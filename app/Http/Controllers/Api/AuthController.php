<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\User;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\ValidationException;
use Illuminate\Support\Facades\Storage;

class AuthController extends Controller
{
    public function register(Request $request)
    {
        try {
            $validated = $request->validate([
                'name' => 'required|string|max:100',
                'email' => 'required|email|unique:users',
                'password' => 'required|min:8|confirmed',
            ], [
                'name.required' => 'กรุณากรอกชื่อ-นามสกุล',
                'email.required' => 'กรุณากรอกอีเมล',
                'email.email' => 'รูปแบบอีเมลไม่ถูกต้อง',
                'email.unique' => 'อีเมลนี้ถูกใช้งานแล้ว',
                'password.required' => 'กรุณากรอกรหัสผ่าน',
                'password.min' => 'รหัสผ่านต้องมีอย่างน้อย 8 ตัวอักษร',
                'password.confirmed' => 'รหัสผ่านยืนยันไม่ตรงกัน',
            ]);
        } catch (\Illuminate\Validation\ValidationException $e) {
            return response()->json([
                'errors' => $e->errors()
            ], 422);
        }

        $user = User::create([
            'name' => $validated['name'],
            'email' => $validated['email'],
            'password' => Hash::make($validated['password']),
        ]);

        $token = $user->createToken('auth_token')->plainTextToken;
        return response()->json(['user' => $user, 'token' => $token]);
    }

    public function login(Request $request)
    {
        $user = User::where('email', $request->email)->first();

        if (!$user || !Hash::check($request->password, $user->password)) {
            throw ValidationException::withMessages(['email' => 'อีเมลหรือรหัสผ่านไม่ถูกต้อง']);
        }

        // ตรวจสอบสถานะผู้ใช้
        if ($user->status !== 'active') {
            if ($user->status === 'inactive') {
                throw ValidationException::withMessages(['email' => 'บัญชีของคุณยังไม่ถูกเปิดใช้งาน']);
            }
            if ($user->status === 'banned') {
                throw ValidationException::withMessages(['email' => 'บัญชีของคุณถูกระงับ']);
            }
        }

        $token = $user->createToken('auth_token')->plainTextToken;
        return response()->json(['user' => $user, 'token' => $token]);
    }

    public function logout(Request $request)
    {
        $request->user()->tokens()->delete();
        return response()->json(['message' => 'Logged out']);
    }

    public function updateAvatar(Request $request)
    {
        $user = $request->user();

        $request->validate([
            'avatar' => 'required|image|mimes:jpg,jpeg,png,gif|max:5120', // max 5MB
        ]);

        if ($request->hasFile('avatar')) {
            // ลบไฟล์เก่า
            if ($user->avatar_url) {
                $oldPath = str_replace('/storage/', '', parse_url($user->avatar_url, PHP_URL_PATH));
                if (Storage::disk('public')->exists($oldPath)) {
                    Storage::disk('public')->delete($oldPath);
                }
            }

            // อัปโหลดไฟล์ใหม่
            $file = $request->file('avatar');
            $filename = time() . '_' . $file->getClientOriginalName();
            $path = $file->storeAs('avatars', $filename, 'public');

            $user->avatar_url = asset('storage/' . $path);
            $user->save();
        }

        return response()->json($user);
    }

    public function profile(Request $request)
    {
        return response()->json($request->user());
    }

    public function updateProfile(Request $request)
    {
        $user = $request->user();

        $validated = $request->validate([
            'name' => 'sometimes|string|max:100',
            'email' => 'sometimes|email|unique:users,email,' . $user->id,
            'password' => 'sometimes|min:6',
        ]);

        if (isset($validated['name'])) $user->name = $validated['name'];
        if (isset($validated['email'])) $user->email = $validated['email'];
        if (isset($validated['password'])) $user->password = Hash::make($validated['password']);

        $user->save();

        return response()->json($user);
    }
}
