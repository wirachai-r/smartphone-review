<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('phones', function (Blueprint $table) {
            $table->id();
            $table->string('model', 150);
            $table->text('summary')->nullable();
            $table->date('release_date')->nullable();
            $table->integer('price')->nullable();
            $table->string('main_image_url')->nullable(); // ✅ จะอัปเดตอัตโนมัติจาก images
            $table->longText('specs')->nullable();
            $table->unsignedBigInteger('views')->default(0);
            $table->foreignId('category_id')->nullable()->constrained('categories')->nullOnDelete();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('phones');
    }
};
