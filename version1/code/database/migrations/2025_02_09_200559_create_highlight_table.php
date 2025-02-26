<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up()
    {
        Schema::create('highlight', function (Blueprint $table) {
            $table->id();
            $table->string('image', 45)->nullable();
            $table->string('title', 45)->nullable();
            $table->string('description', 45)->nullable();
            $table->tinyInteger('status')->nullable();
            $table->unsignedBigInteger('category_id');

            $table->unique('id');
            $table->foreign('category_id')->references('id')->on('category')->onDelete('cascade');
            $table->timestamps();
        });
    }

    public function down()
    {
        Schema::dropIfExists('highlight');
    }
};
