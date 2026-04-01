<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Category;
use Illuminate\Support\Facades\Storage;

class CategoryController extends Controller
{
    public function index()
    {
        return response()->json(
            Category::orderBy('name', 'asc')->get()
        );
    }

    public function store(Request $request)
    {
        $data = $request->validate([
            'name' => 'required|string',
            'brand_image' => 'nullable|image|max:2048',
        ]);

        // Upload image to public disk
        if ($request->hasFile('brand_image')) {
            $path = $request->file('brand_image')->store('categories', 'public');
            $data['brand_image_url'] = '/storage/' . $path; // ใช้ path สำหรับ public
        }

        $category = Category::create($data);
        return response()->json($category);
    }

    public function show($id)
    {
        return response()->json(Category::findOrFail($id));
    }

    public function update(Request $request, $id)
    {
        $category = Category::findOrFail($id);

        $data = $request->validate([
            'name' => 'required|string',
            'brand_image' => 'nullable|image|max:2048',
        ]);

        // ถ้ามีไฟล์ใหม่ให้ลบไฟล์เก่าแล้วอัปโหลดใหม่
        if ($request->hasFile('brand_image')) {
            if ($category->brand_image_url) {
                $oldPath = str_replace('/storage/', '', $category->brand_image_url);
                Storage::disk('public')->delete($oldPath);
            }
            $path = $request->file('brand_image')->store('categories', 'public');
            $data['brand_image_url'] = '/storage/' . $path;
        }

        $category->update($data);
        return response()->json($category);
    }

    public function destroy($id)
    {
        $category = Category::findOrFail($id);

        // ตรวจสอบว่ามีโทรศัพท์อยู่ในหมวดนี้หรือไม่
        if ($category->phones()->count() > 0) {
            return response()->json([
                'message' => 'ไม่สามารถลบแบรนด์นี้ได้ เพราะมีโทรศัพท์อยู่แบรนด์นี้'
            ], 400);
        }

        // ลบไฟล์รูปเก่า ถ้ามี
        if ($category->brand_image_url) {
            $oldPath = str_replace('/storage/', '', $category->brand_image_url);
            if (Storage::disk('public')->exists($oldPath)) {
                Storage::disk('public')->delete($oldPath);
            }
        }

        $category->delete();

        return response()->json(['message' => 'Category deleted']);
    }
}
