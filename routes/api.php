<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\Api\UserController;
use App\Http\Controllers\Api\PhoneController;
use App\Http\Controllers\Api\ReviewController;
use App\Http\Controllers\Api\CommentController;
use App\Http\Controllers\Api\CategoryController;
use App\Http\Controllers\Api\LikeController;
use App\Http\Controllers\Api\ImageController;
use App\Http\Middleware\AdminMiddleware;

// ------------------ ผู้ใช้ทั่วไป ------------------
Route::get('/phones', [PhoneController::class, 'index']); // มือถือทั้งหมด
Route::get('/phones/{id}', [PhoneController::class, 'show']); // รายละเอียดมือถือ
Route::get('/categories', [CategoryController::class, 'index']); // หมวดหมู่ (เปิดให้ทุกคนเห็น)
Route::get('/phones/{phone_id}/reviews', [ReviewController::class, 'showPhoneReviews']);
Route::get('/reviews/{review_id}/comments', [CommentController::class, 'showReviewComments']);
Route::patch('/phones/{id}/views', [PhoneController::class, 'incrementViews']);
Route::get('/phones/{phoneId}/likes', [LikeController::class, 'count']);

// ------------------ Auth ------------------
Route::post('/register', [AuthController::class, 'register']);
Route::post('/login', [AuthController::class, 'login']);

// ------------------ ต้องล็อกอิน ------------------
Route::middleware('auth:sanctum')->group(function () {
    Route::prefix('profile')->group(function () {
        Route::get('/', [AuthController::class, 'profile']);
        Route::put('/', [AuthController::class, 'updateProfile']);
        Route::post('/avatar', [AuthController::class, 'updateAvatar']);
    });

    Route::post('/logout', [AuthController::class, 'logout']);

    // Reviews
    Route::post('/phones/{phoneId}/reviews', [ReviewController::class, 'store']);
    Route::put('/reviews/{id}', [ReviewController::class, 'update']);
    Route::delete('/reviews/{id}', [ReviewController::class, 'destroy']);
    Route::get('/reviews/hasReviewed', [ReviewController::class, 'hasReviewed']);
    Route::get('/users/{userId}/reviews', [ReviewController::class, 'showUserReviews']);

    // Comments
    Route::post('/reviews/{reviewId}/comments', [CommentController::class, 'storeForReview']);
    Route::put('/comments/{id}', [CommentController::class, 'update']);
    Route::delete('/comments/{id}', [CommentController::class, 'destroy']);

    // Like/Unlike
    Route::post('/phones/{phoneId}/like', [LikeController::class, 'store']);
    Route::get('/phones/{phoneId}/like', [LikeController::class, 'check']);
});

// ------------------ แอดมิน ------------------
Route::middleware(['auth:sanctum', AdminMiddleware::class])->prefix('admin')->group(function () {
    Route::apiResource('phones', PhoneController::class)->except(['index', 'show']);
    Route::apiResource('categories', CategoryController::class);
    Route::apiResource('users', UserController::class);
    Route::post('/images/upload', [ImageController::class, 'upload']);
    Route::delete('/images/{id}', [ImageController::class, 'destroy']);
    Route::put('users/{id}/role-status', [UserController::class, 'updateRoleStatus']);
    Route::patch('reviews/{id}/status', [ReviewController::class, 'updateStatus']);
    Route::get('/reviews', [ReviewController::class, 'index']); // ดึงรีวิวทั้งหมด
});
