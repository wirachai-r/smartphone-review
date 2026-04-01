<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\User;
use Illuminate\Support\Facades\Storage;

class UserController extends Controller
{
    // ดึงข้อมูลผู้ใช้ทั้งหมด
    public function index()
    {
        return response()->json(User::all());
    }

    // ดึงข้อมูลผู้ใช้ตาม ID
    public function show($id)
    {
        return response()->json(User::findOrFail($id));
    }

    // สำหรับ admin อัปเดตเฉพาะ role และ status
    public function updateRoleStatus(Request $request, $id)
    {
        $user = User::findOrFail($id);

        // ตรวจสอบ input
        $request->validate([
            'role' => 'sometimes|in:user,admin',
            'status' => 'sometimes|in:active,inactive,banned', // ปรับตามค่าที่ต้องการ
        ]);

        if ($request->has('role')) {
            $user->role = $request->role;
        }

        if ($request->has('status')) {
            $user->status = $request->status;
        }

        $user->save();

        return response()->json([
            'message' => 'User role/status updated successfully',
            'user' => $user
        ]);
    }

    // ลบผู้ใช้
    public function destroy($id)
    {
        $user = User::findOrFail($id);

        // ลบ avatar ถ้ามี
        if ($user->avatar_url) {
            $oldPath = str_replace('/storage/', '', $user->avatar_url);
            if (Storage::disk('public')->exists($oldPath)) {
                Storage::disk('public')->delete($oldPath);
            }
        }

        $user->delete();

        return response()->json(['message' => 'User deleted']);
    }
}
