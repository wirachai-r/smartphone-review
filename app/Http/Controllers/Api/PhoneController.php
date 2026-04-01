<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Phone;
use App\Models\Image;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;

class PhoneController extends Controller
{
    public function index()
    {
        $phones = Phone::with([
            'category',
            'images',
            'reviews' => function ($query) {
                $query->where('status', 'approved'); // เฉพาะรีวิวที่ status = approved
            }
        ])
            ->select(
                'phones.*',
                DB::raw('(SELECT COUNT(*) FROM likes WHERE likes.phone_id = phones.id) as likes'),
                DB::raw('(SELECT IFNULL(AVG(rating),0) FROM reviews WHERE reviews.phone_id = phones.id AND status = "approved") as average_rating')
            )
            ->orderByDesc('created_at')
            ->get();

        return response()->json($phones);
    }

    public function store(Request $request)
    {
        $data = $request->validate([
            'model' => 'required|string|max:150',
            'summary' => 'nullable|string',
            'release_date' => 'nullable|date',
            'price' => 'nullable|integer',
            'main_image_url' => 'nullable|string',
            'category_id' => 'nullable|exists:categories,id',
            'specs' => 'nullable|string',
            'colors' => 'nullable|array',
            'colors.*.name' => 'required_with:colors|string|max:50',
            'colors.*.hex' => 'required_with:colors|string|size:7',
            'images' => 'nullable|array',
            'images.*.url' => 'required|string',
        ]);

        DB::transaction(function () use ($data, &$phone) {
            $images = $data['images'] ?? [];
            unset($data['images']);

            $phone = Phone::create($data);

            // บันทึกรูปภาพ
            foreach ($images as $index => $img) {
                $phone->images()->create([
                    'url' => $img['url'],
                    'order' => $index,
                ]);
            }

            // รูปหลัก
            if (!empty($images)) {
                $phone->update(['main_image_url' => $images[0]['url']]);
            }
        });

        return response()->json($phone->load('images'), 201);
    }

    public function show($id)
    {
        $phone = Phone::with('category', 'images')->findOrFail($id);
        return response()->json($phone);
    }

    public function update(Request $request, $id)
    {
        $phone = Phone::findOrFail($id);

        $data = $request->validate([
            'model' => 'sometimes|required|string|max:150',
            'summary' => 'nullable|string',
            'release_date' => 'nullable|date',
            'price' => 'nullable|integer',
            'main_image_url' => 'nullable|string',
            'category_id' => 'nullable|exists:categories,id',
            'specs' => 'nullable|string',
            'colors' => 'nullable|array',
            'colors.*.name' => 'required_with:colors|string|max:50',
            'colors.*.hex' => 'required_with:colors|string|size:7',
            'images' => 'nullable|array',
            'images.*.url' => 'required|string',
        ]);

        DB::transaction(function () use ($data, $phone) {
            $images = $data['images'] ?? [];
            unset($data['images']);

            $phone->update($data);

            // ลบรูปเก่าที่ไม่ได้อยู่ใน array ใหม่
            $newUrls = collect($images)->pluck('url')->toArray();
            $phone->images()->whereNotIn('url', $newUrls)->each(function ($img) {
                $filePath = str_replace('/storage/', '', $img->url);
                if (Storage::disk('public')->exists($filePath)) {
                    Storage::disk('public')->delete($filePath);
                }
                $img->delete();
            });

            // เพิ่ม/อัปเดตรูปใหม่
            foreach ($images as $index => $img) {
                $existing = $phone->images()->where('url', $img['url'])->first();
                if ($existing) {
                    $existing->update(['order' => $index]);
                } else {
                    $phone->images()->create([
                        'url' => $img['url'],
                        'order' => $index,
                    ]);
                }
            }

            // อัปเดตรูปหลัก
            $phone->update(['main_image_url' => $images[0]['url'] ?? null]);
        });

        return response()->json($phone->load('images'));
    }

    public function destroy($id)
    {
        $phone = Phone::findOrFail($id);

        // ลบรูปทั้งหมดจาก storage
        $phone->images->each(function ($img) {
            $filePath = str_replace('/storage/', '', $img->url);
            if (Storage::disk('public')->exists($filePath)) {
                Storage::disk('public')->delete($filePath);
            }
            $img->delete();
        });

        $phone->delete();

        return response()->json(['message' => 'Phone deleted successfully']);
    }

    // เพิ่มยอดเข้าชมโดยไม่กระทบฟิลด์อื่น
    public function incrementViews($id)
    {
        $phone = Phone::with('category', 'images')->findOrFail($id);
        $phone->increment('views'); // เพิ่ม 1
        return response()->json($phone);
    }
}
