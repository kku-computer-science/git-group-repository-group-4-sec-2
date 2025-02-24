@extends('layouts.layout')
<style>
    /* Fix the carousel size */
    /* #carouselExampleIndicators {
        max-width: 100%;
        border-radius: 10px;
        width: 100%;
        height: 15rem;
        margin: auto;
        overflow: hidden;
        border: 1px solid #ccc;
        display: flex;
        justify-content: center;
        align-items: center;
    } */
    #carouselExampleIndicators {
        max-width: 100%;
        border-radius: 10px;
        width: 100%;
        height: 15rem;
        margin: auto;
        overflow: hidden;
        border: 1px solid #ccc;
        display: flex;
        justify-content: center;
        align-items: center;
        background: url('{{ asset("img/ba_banner_highlights.jpg") }}') no-repeat center center;
        background-size: cover;
    }


    #carouselExampleIndicators h1 {
        font-size: 2rem;
        /* background-color: #000000; */
        background-color: rgba(0, 0, 0, 0.5);
        color: #FFFFFF;
        text-align: center;
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
        text-decoration: none;
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
        text-decoration: none;
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
        text-decoration: none;
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
        color: black;
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
        height: 15rem;
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

    /* เพิ่มมา */
    .tag-container {
        display: flex;
        flex-wrap: nowrap;
        overflow: hidden;
        gap: 1px;
    }

    .tag-list-wrapper {
        position: relative;
        overflow: hidden;
        width: 100%;
        margin: 0;
    }

    .tag-list {
        display: flex;
        flex-wrap: nowrap;
        /* แสดง tag ในแถวเดียว */
        gap: 10px;
        overflow-x: auto;
        scroll-behavior: smooth;
        margin-top: 2rem;
        /* padding: 10px 10px; */
        /* มี padding เพื่อเว้นระยะจากปุ่ม */
    }

    /* ซ่อน scrollbar ในเบราว์เซอร์ที่รองรับ */
    .tag-list::-webkit-scrollbar {
        display: none;
    }

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
        white-space: nowrap;
        /* ป้องกันไม่ให้ข้อความ wrap เป็นหลายบรรทัด */
    }

    .scroll-btn {
        position: absolute;
        /* top: 50%; */
        /* transform: translateY(-50%); */
        background: rgba(0, 0, 0, 0.5);
        border-radius: 100%;
        width: 2.5rem;
        border: none;
        color: white;
        padding: 8px;
        cursor: pointer;
        z-index: 10;
    }

    #scrollRightTag {
        margin-left: 6.25rem;
        background-color: rgb(62, 162, 233);
    }

    #scrollLeftTag {
        margin-left: 3.5rem;
        background-color: rgb(62, 162, 233);
    }

    #scrollRightTag:hover {
        background-color: rgb(34, 121, 184);
    }

    #scrollLeftTag:hover {
        background-color: rgb(34, 121, 184);
    }

    .btn-group-tag {
        display: flex;
        align-items: center;
        gap: 10px;
        margin-top: 2rem;
    }
</style>

@section('content')
<!-- Highlights banner -->
<div class="container">
    <div class="container d-sm-flex justify-content-center mt-5">
        <div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="carousel">
            <h1>HIGHLIGHTS</h1>
        </div>
    </div>
</div>

<!-- Dynamic Tag list -->
<!-- <div class="container">
    <div class="flex-wrap" style="display: flex; align-items: center; gap: 8px; margin-top: 45px;">
        <h5 class="tag-header ml-2">TAG :</h5>
        <div class="tag-list">
            <a href="#" class="tag-item tag-all active" data-tag="all">All</a>
            @foreach ($tags as $tag)
                <a href="#" class="tag-item" data-tag="{{ strtolower(trim($tag->name)) }}">{{ $tag->name }}</a>
            @endforeach
        </div>
    </div>
</div> -->
<!-- Dynamic Tag list -->
<div class="container">
    <div>
        <div class="container">
            <div class="btn-group-tag">
                <h4>Tag : </h4>
                <button id="scrollLeftTag" class="scroll-btn">&lt;</button>
                <button id="scrollRightTag" class="scroll-btn">&gt;</button>
            </div>
            <div class="tag-list-wrapper">
                <div class="tag-list">
                    <a href="#" class="tag-item tag-all active" data-tag="all">All</a>
                    @foreach ($tags as $tag)
                    <a href="#" class="tag-item" data-tag="{{ strtolower(trim($tag->name)) }}">{{ $tag->name }}</a>
                    @endforeach
                </div>
            </div>
        </div>
    </div>
</div>



<!-- Dynamic Item Highlights -->
<!-- <div class="container-card">
    @foreach ($highlights as $highlight)
    <div class="card" data-tag="{{ $highlight->tags->isNotEmpty() ? $highlight->tags->pluck('name')->map(function($name) { return strtolower(trim($name)); })->implode('|') : '' }}">
        <div class="card_header">
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
</div> -->
<!-- Dynamic Item Highlights -->
<div class="container-card">
    @foreach ($highlights as $highlight)
    <a href="{{ route('highlight.show', $highlight->id) }}" class="card" data-tag="{{ $highlight->tags->isNotEmpty() ? $highlight->tags->pluck('name')->map(function($name) { return strtolower(trim($name)); })->implode('|') : '' }}">
        <div class="card_header">
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
    </a>
    @endforeach
</div>



<script>
    document.addEventListener('DOMContentLoaded', function() {
        const tagItems = document.querySelectorAll('.tag-list > a.tag-item');
        const cards = document.querySelectorAll('.container-card .card');
        ////
        const tagList = document.querySelector('.tag-list');
        const btnLeft = document.getElementById('scrollLeftTag');
        const btnRight = document.getElementById('scrollRightTag');

        btnLeft.addEventListener('click', function() {
            tagList.scrollBy({
                left: -150,
                behavior: 'smooth'
            });
        });

        btnRight.addEventListener('click', function() {
            tagList.scrollBy({
                left: 150,
                behavior: 'smooth'
            });
        });
        ////
        tagItems.forEach(tagItem => {
            tagItem.addEventListener('click', function(event) {
                event.preventDefault();
                // ลบคลาส active จาก tag list ทั้งหมด
                tagItems.forEach(t => t.classList.remove('active'));
                // เพิ่ม active ให้กับ tag ที่ถูกคลิก
                this.classList.add('active');

                const selectedTag = this.getAttribute('data-tag'); // ค่าเป็น lowercase
                cards.forEach(card => {
                    const tagAttr = card.getAttribute('data-tag') || '';
                    // แยกเป็น array ด้วยตัวคั่น '|' และ trim ค่าแต่ละตัว
                    const cardTags = tagAttr.split('|').map(t => t.trim()).filter(t => t !== '');

                    if (selectedTag === 'all' || cardTags.includes(selectedTag)) {
                        card.style.display = 'flex';
                    } else {
                        card.style.display = 'none';
                    }
                });
            });
        });
    });
</script>



@endsection