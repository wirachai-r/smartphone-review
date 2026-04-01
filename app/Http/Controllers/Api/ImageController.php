<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Image;
use App\Models\Phone;
use Illuminate\Support\Facades\Storage;

class ImageController extends Controller
{
    // อัปโหลดไฟล์ → คืน url ให้ frontend
    public function upload(Request $request)
    {
        $request->validate([
            'image' => 'required|image|max:10240',
        ]);

        // เก็บไฟล์ใน disk 'public' (storage/app/public/Phones)
        $path = $request->file('image')->store('Phones', 'public');

        // URL ให้ frontend เข้าถึงผ่าน public/storage/...
        $url = '/storage/' . $path;

        return response()->json(['url' => $url]);
    }

    // ลบรูป
    public function destroy($id)
    {
        $image = Image::findOrFail($id);
        $phone = $image->phone;

        if ($image->url) {
            $filePath = str_replace('/storage/', '', $image->url);
            if (Storage::disk('public')->exists($filePath)) {
                Storage::disk('public')->delete($filePath);
            }
        }

        $image->delete();

        // อัปเดต main_image_url ถ้าจำเป็น
        if ($phone) {
            if ($phone->main_image_url === $image->url) {
                $newMain = $phone->images()->orderBy('order')->first();
                $phone->update(['main_image_url' => $newMain?->url]);
            }
        }

        return response()->json(['message' => 'Image deleted']);
    }
}
