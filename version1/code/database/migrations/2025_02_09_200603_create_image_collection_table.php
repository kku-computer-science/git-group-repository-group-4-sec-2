<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up()
    {
        Schema::create('image_collection', function (Blueprint $table) {
            $table->id();
            $table->string('image', 45)->nullable();
            $table->unsignedBigInteger('highlight_id');

            $table->unique('id');
            $table->foreign('highlight_id')->references('id')->on('highlight')->onDelete('cascade');
            $table->timestamps();
        });
    }

    public function down()
    {
        Schema::dropIfExists('image_collection');
    }
};
