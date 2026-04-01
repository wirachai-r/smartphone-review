<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Comment;

class CommentController extends Controller
{
    public function showReviewComments($review_id)
    {
        return response()->json(Comment::with('user')->where('review_id', $review_id)->get());
    }

    public function storeForReview(Request $request, $reviewId)
    {
        $data = $request->validate([
            'body' => 'required|string',
        ]);

        $data['review_id'] = $reviewId;
        $data['user_id'] = $request->user()->id;

        $comment = Comment::create($data);
        return response()->json($comment, 201);
    }

    public function update(Request $request, $id)
    {
        $comment = Comment::findOrFail($id);
        $comment->update($request->only('body'));
        return response()->json($comment);
    }

    public function destroy($id)
    {
        Comment::destroy($id);
        return response()->json(['message' => 'Comment deleted']);
    }
}
