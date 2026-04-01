<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Review extends Model
{
    use HasFactory;

    protected $fillable = ['user_id', 'phone_id', 'rating', 'title', 'body', 'status'];

    public function user()
    {
        return $this->belongsTo(User::class);
    }

    public function phone()
    {
        return $this->belongsTo(Phone::class);
    }

    public function comments()
    {
        return $this->hasMany(Comment::class);
    }

    public function likes()
    {
        return $this->hasMany(Like::class);
    }
}
