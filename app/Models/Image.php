<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Image extends Model
{
    use HasFactory;

    protected $fillable = ['phone_id', 'url', 'order'];

    public function phone()
    {
        return $this->belongsTo(Phone::class);
    }
}
