<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Review;

class ReviewController extends Controller
{

    public function index()
    {
        $reviews = Review::with('user', 'phone')
            ->orderByDesc('created_at')
            ->get();

        return response()->json($reviews);
    }

    public function showPhoneReviews($phone_id)
    {
        $reviews = Review::with('user')
            ->where('phone_id', $phone_id)
            ->where('status', 'approved') // เพิ่มตรงนี้
            ->get();

        return response()->json($reviews);
    }

    public function store(Request $request, $phoneId)
    {
        $data = $request->validate([
            'rating' => 'required|integer|between:1,5',
            'body' => 'required|string',
        ]);

        $data['user_id'] = $request->user()->id;
        $data['phone_id'] = $phoneId;
        $data['status'] = 'pending'; // เพิ่มตรงนี้

        $review = Review::create($data);
        return response()->json($review);
    }

    public function update(Request $request, $id)
    {
        $review = Review::findOrFail($id);

        $validated = $request->validate([
            'rating' => 'sometimes|integer|between:1,5',
            'title' => 'sometimes|string',
            'body' => 'sometimes|string',
            'status' => 'sometimes|in:pending,approved,rejected', // เพิ่มตรงนี้
        ]);

        $review->update($validated);
        return response()->json($review);
    }

    public function destroy($id)
    {
        Review::destroy($id);
        return response()->json(['message' => 'Review deleted']);
    }

    public function hasReviewed(Request $request)
    {
        $user = $request->user();
        $phoneId = $request->query('phoneId');

        if (!$user) {
            return response()->json(['reviewed' => false]);
        }

        $reviewed = Review::where('phone_id', $phoneId)
            ->where('user_id', $user->id)
            ->exists();

        return response()->json(['reviewed' => $reviewed]);
    }

    public function showUserReviews($userId)
    {
        // ดึงรีวิวพร้อมข้อมูลโทรศัพท์และผู้ใช้
        $reviews = Review::with('phone', 'user')
            ->where('user_id', $userId)
            ->orderBy('created_at', 'desc')
            ->get();

        return response()->json($reviews);
    }

    public function updateStatus(Request $request, $id)
    {
        $review = Review::findOrFail($id);

        $validated = $request->validate([
            'status' => 'required|in:pending,approved,rejected',
        ]);

        $review->status = $validated['status'];
        $review->save();

        return response()->json($review);
    }
}
