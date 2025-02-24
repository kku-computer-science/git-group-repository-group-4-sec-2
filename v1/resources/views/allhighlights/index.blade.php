@extends('layouts.layout')
<style>
    /* Fix the carousel size */
    #carouselExampleIndicators {
        max-width: 100%;
        border-radius: 10px;
        /* Add rounded corners */
        width: 100%;
        /* Set your desired width */
        height: 15rem;
        /* Set your desired height */
        margin: auto;
        /* Center the carousel */
        overflow: hidden;
        border: 1px solid #ccc;
        display: flex;
        justify-content: center;
        align-items: center;
    }

    #carouselExampleIndicators h1 {
        font-size: 2rem;
        color: #000;
        text-align: center;
        background-color: #000;
        opacity: 0.75;
        color: white;
        width: 100%;
        padding: 1.5rem 0;
    }

    .tag-header {
        font-size: 1.5rem;
        color: rgb(25, 85, 138);
        text-transform: uppercase;
        letter-spacing: 0.5px;
        margin-top: 5px;
    }

    /* Tag List */
    .tag-list {
        display: flex;
        flex-wrap: wrap;
        gap: 10px;
        align-items: center;
    }

    /* Tag Items */
    .tag-item {
        font-size: 1rem;
        font-weight: 500;
        color: rgb(62, 162, 233);
        padding: 5px 10px;
        border-radius: 8px;
        text-transform: uppercase;
        transition: background-color 0.3s ease, color 0.3s ease;
        text-decoration: none;
        border: 2px solid rgb(76, 169, 235);
    }

    /* เมื่อ hover */
    .tag-item:hover {
        background-color: rgb(76, 169, 235);
        color: rgb(255, 255, 255);
        text-decoration: none;
    }

    /* เมื่อคลิกแล้วเลือก (Active) */
    .tag-item.active {
        background-color: rgb(76, 169, 235);
        color: rgb(255, 255, 255);
    }

    /* Container สำหรับ Card */
    .container-card {
        display: flex;
        flex-wrap: wrap;
        justify-content: center;
        align-items: center;
        gap: 2rem;
        max-width: 1375px;
        margin: auto;
        padding: 2rem;
        min-height: 2rem;
    }

    /* Card แต่ละใบ */
    .card {
        display: flex;
        flex-direction: column;
        width: calc(33.33% - 2rem);
        overflow: hidden;
        box-shadow: 0 0.1rem 1rem rgba(0, 0, 0, 0.1);
        border-radius: 16px;
        background: #ECE9E6;
        transition: transform 0.3s ease;
    }

    /* Tag เฉพาะใน Card ที่กรอบล้อมรอบตัวอักษร */
    .card .tag-item {
        font-size: 0.75rem;
        color: rgb(255, 255, 255);
        background-color: rgb(76, 169, 235);
        width: fit-content;
        padding: 3px 6px;
        border-radius: 8px;
    }

    /* Hover Effect */
    .card:hover {
        transform: translateY(-5px);
    }

    /* ภาพใน Card */
    img {
        max-width: 100%;
        display: block;
        object-fit: cover;
    }

    /* ส่วนเนื้อหาใน Card */
    .card_body {
        padding: 1rem;
        display: flex;
        flex-direction: column;
        gap: 0.5rem;
    }

    /* หัวข้อใน Card */
    .card_body h4 {
        font-size: 1.5rem;
        text-transform: capitalize;
        margin: 0;
    }

    .card_image {
        width: 100%;
        height: 100%;
    }

    /* กำหนดความสูงของ card header ให้เท่ากับ static example */
    .card_header {
        height: 15rem; /* กำหนดความสูงที่ต้องการ */
        overflow: hidden;
    }

    /* Tablet (2 ใบต่อแถว) */
    @media (max-width: 900px) {
        .card {
            width: calc(50% - 2rem);
        }
    }

    /* Mobile (1 ใบต่อแถว) */
    @media (max-width: 600px) {
        .card {
            width: 100%;
        }
    }

    .tag-container {
        display: flex;
        flex-wrap: wrap;
        gap: 5px;
    }
</style>

@section('content')
<!-- Highlights banner -->
<div class="container">
    <div class="container d-sm-flex justify-content-center mt-5">
        <div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="carousel">
            <!-- ใส่เนื้อหา carousel ตามต้องการ -->
        </div>
    </div>
</div>

<!-- Tag list -->
<div class="container">
    <div class="flex-wrap" style="display: flex; align-items: center; gap: 8px; margin-top: 45px;">
        <h5 class="tag-header ml-2">TAG :</h5>
        <div class="tag-list">
            <a href="#" class="tag-item tag-all active" data-tag="all">All</a>
            <a href="#" class="tag-item" data-tag="technology">Technology</a>
            <a href="#" class="tag-item" data-tag="programming">Programming</a>
            <a href="#" class="tag-item" data-tag="webdev">Web Development</a>
            <a href="#" class="tag-item" data-tag="design">Design</a>
            <a href="#" class="tag-item" data-tag="ai">AI</a>
            <a href="#" class="tag-item" data-tag="ml">Machine Learning</a>
        </div>
    </div>
</div>

<!-- Card Section (Static Example) -->
<div class="container-card">
    <div class="card" data-tag="ml">
        <div class="card_header">
            <img src="" alt="card_image" class="card_image">
        </div>
        <div class="card_body">
            <span class="tag-item">Machine Learning</span>
            <h4>ML Algorithms Explained</h4>
            <p>Understanding machine learning basics.</p>
        </div>
    </div>

    <div class="card" data-tag="technology">
        <div class="card_header">
            <img src="" alt="card_image" class="card_image">
        </div>
        <div class="card_body">
            <span class="tag-item">Technology</span>
            <h4>What's new in 2022 Tech</h4>
            <p>Lorem ipsum dolor sit consectetur adipisicing elit.</p>
        </div>
    </div>

    <div class="card" data-tag="ai">
        <div class="card_header">
            <img src="" alt="card_image" class="card_image">
        </div>
        <div class="card_body">
            <span class="tag-item">AI</span>
            <h4>What's new in 2022 Tech</h4>
            <p>Lorem ipsum dolor sit consectetur adipisicing elit.</p>
        </div>
    </div>
</div>

<!-- Dynamic Item Highlights -->
<div class="container-card">
    @foreach ($highlights as $highlight)
    <div class="card" data-tag="{{ $highlight->tags->isNotEmpty() ? $highlight->tags->pluck('name')->map(function($name) { return Str::slug($name); })->implode(' ') : '' }}">
        <div class="card_header">
            <!-- ดึงภาพจากฐานข้อมูล -->
            <img src="{{ asset('storage/' . $highlight->image) }}" alt="{{ $highlight->title }}" class="card_image">
        </div>
        <div class="card_body">
            @if($highlight->tags->isNotEmpty())
            <div class="tag-container">
                @foreach ($highlight->tags as $tag)
                <span class="tag-item">{{ $tag->name }}</span>
                @endforeach
            </div>
            @endif
            <h4>{{ $highlight->title }}</h4>
            <p>{{ Str::limit($highlight->description, 100) }}</p>
        </div>
    </div>
    @endforeach
</div>
@endsection
