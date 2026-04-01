<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Phone extends Model
{
    use HasFactory;

    protected $fillable = [
        'model',
        'summary',
        'release_date',
        'price',
        'main_image_url',
        'specs',
        'views',
        'category_id',
        'colors', // เพิ่มตรงนี้
    ];

    protected $casts = [
        'release_date' => 'date',
        'colors' => 'array', // Laravel จะ decode/encode JSON อัตโนมัติ
    ];

    public function category()
    {
        return $this->belongsTo(Category::class);
    }

    public function images()
    {
        return $this->hasMany(Image::class)->orderBy('order');
    }

    public function reviews()
    {
        return $this->hasMany(Review::class);
    }

    public function mainImage()
    {
        return $this->hasOne(Image::class)->where('order', 1);
    }
}
