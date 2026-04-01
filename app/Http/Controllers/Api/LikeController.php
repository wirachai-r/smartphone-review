<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Like;

class LikeController extends Controller
{
    // toggle like / unlike
    public function store(Request $request, $phoneId)
    {
        $data = [
            'user_id' => $request->user()->id, // <-- ใช้ $request->user()
            'phone_id' => $phoneId,
        ];

        $like = Like::where($data)->first();

        if ($like) {
            $like->delete();
            return response()->json(['liked' => false]);
        } else {
            Like::create($data);
            return response()->json(['liked' => true]);
        }
    }

    // count likes
    public function count(Request $request, $phoneId)
    {
        $count = Like::where('phone_id', $phoneId)->count();
        return response()->json(['likes' => $count]);
    }

    // check if current user liked
    public function check(Request $request, $phoneId)
    {
        $user = $request->user(); // <-- ใช้ $request->user()
        $liked = Like::where('user_id', $user->id)
                     ->where('phone_id', $phoneId)
                     ->exists();

        return response()->json(['liked' => $liked]);
    }
}
