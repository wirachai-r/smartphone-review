<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Category extends Model
{
    use HasFactory;

    protected $fillable = ['name', 'brand_image_url'];

    public function phones()
    {
        return $this->hasMany(Phone::class);
    }
}
