@extends('layouts.layout')
<style>
    /* Fix the carousel size */
    #carouselExampleIndicators {
        max-width: 100%;
        border-radius: 20px;
        /* Add rounded corners */
        width: 100%;
        /* Set your desired width */
        height: 10rem;
        /* Set your desired height */
        margin: auto;
        /* Center the carousel */
        overflow: hidden;
        /* Prevent image overflow */
        box-shadow: 5px 5px 15px rgba(0, 0, 0, 0.2);
        /* Add soft shadow */
    }

    .carousel-inner {
        width: 100%;
        height: 100%;
    }

    .carousel-item {
        width: 10%;
        height: 100%;
    }

    .carousel-item img {
        width: 100%;
        height: 100%;
        object-fit: cover;
        border-radius: 20px;
        /* Ensure the image covers the box */
    }

    /* Custom styling for arrows */
    .carousel-control-prev-icon,
    .carousel-control-next-icon {
        filter: invert(100%);
        /* Makes arrows white */
    }

    .carousel-control-prev,
    .carousel-control-next {
        opacity: 1 !important;
        /* Ensure arrows are fully visible */
    }

    .tag-header {
        font-size: 1.5rem;       
        color: rgb(25, 85, 138);
        text-transform: uppercase;
        letter-spacing: 0.5px;
        margin-top: 5;
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
</style>

@section('content')
<!-- เปลี่ยน container เป็น container-fluid เพื่อให้เต็มความกว้างของหน้าจอ -->
<div class="container-fluid">
    <!-- Highlights banner -->
    <div class="d-sm-flex justify-content-center mt-5">
        <div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="carousel">
           hhhhhhhhhhhhhhh
        </div>
    </div>
</div>

<!-- Tag list -->
<div class="container">
  <div class="flex-wrap" style="display: flex; align-items: center; gap: 8px; margin-top: 45px;">
    <h5 class="tag-header">ALL TAG :</h5>
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

<!-- Card Section -->
<div class="container-card">
    <div class="card" data-tag="ml">
        <div class="card_header">
            <img src="img/Banner1.png" alt="card_image" class="card_image">
        </div>
        <div class="card_body">
            <span class="tag-item">Machine Learning</span>
            <h4>ML Algorithms Explained</h4>
            <p>Understanding machine learning basics.</p>
        </div>
    </div>

    <div class="card" data-tag="technology">
        <div class="card_header">
            <img src="img/Banner1.png" alt="card_image" class="card_image">
        </div>
        <div class="card_body">
            <span class="tag-item">Technology</span>
            <h4>What's new in 2022 Tech</h4>
            <p>Lorem ipsum dolor sit consectetur adipisicing elit.</p>
        </div>
    </div>

    <div class="card" data-tag="programming">
        <div class="card_header">
            <img src="img/Banner1.png" alt="card_image" class="card_image">
        </div>
        <div class="card_body">
            <span class="tag-item">Programming</span>
            <h4>Learn JavaScript in 2022</h4>
            <p>Sequi perferendis molestiae non nemo doloribus.</p>
        </div>
    </div>

    <div class="card" data-tag="webdev">
        <div class="card_header">
            <img src="img/Banner1.png" alt="card_image" class="card_image">
        </div>
        <div class="card_body">
            <span class="tag-item">Web Development</span>
            <h4>Modern Web Trends</h4>
            <p>Doloremque, nihil! At ea atque quidem!</p>
        </div>
    </div>

    <div class="card" data-tag="design">
        <div class="card_header">
            <img src="img/Banner1.png" alt="card_image" class="card_image">
        </div>
        <div class="card_body">
            <span class="tag-item">Design</span>
            <h4>UI/UX Best Practices</h4>
            <p>Learn how to improve your designs today.</p>
        </div>
    </div>

    <div class="card" data-tag="ai">
        <div class="card_header">
            <img src="img/Banner1.png" alt="card_image" class="card_image">
        </div>
        <div class="card_body">
            <span class="tag-item">AI</span>
            <h4>Artificial Intelligence Today</h4>
            <p>Explore the latest advancements in AI.</p>
        </div>
    </div>

    <div class="card" data-tag="ml">
        <div class="card_header">
            <img src="img/Banner1.png" alt="card_image" class="card_image">
        </div>
        <div class="card_body">
            <span class="tag-item">Machine Learning</span>
            <h4>ML Algorithms Explained</h4>
            <p>Understanding machine learning basics.</p>
        </div>
    </div>

    <div class="card" data-tag="ml">
        <div class="card_header">
            <img src="img/Banner1.png" alt="card_image" class="card_image">
        </div>
        <div class="card_body">
            <span class="tag-item">Machine Learning</span>
            <h4>ML Algorithms Explained</h4>
            <p>Understanding machine learning basics.</p>
        </div>
    </div>

    <div class="card" data-tag="programming">
        <div class="card_header">
            <img src="img/Banner1.png" alt="card_image" class="card_image">
        </div>
        <div class="card_body">
            <span class="tag-item">Programming</span>
            <h4>Learn JavaScript in 2022</h4>
            <p>Sequi perferendis molestiae non nemo doloribus.</p>
        </div>
    </div>
</div>

<!-- Link Page -->
<div class="container">
    <ul>
        @foreach ($highlights as $highlight)
            <li>
                <a href="{{ route('allhighlights.show', $highlight->id) }}">{{ $highlight->title }}</a>
            </li>
        @endforeach
    </ul>
</div>

<script>
    // เลือกทุก Tag-item
    const tags = document.querySelectorAll('.Tag-item');

    tags.forEach(tag => {
        tag.addEventListener('click', function(event) {
            event.preventDefault(); // ป้องกันลิงก์ไม่ให้รีเฟรชหน้า

            // Toggle คลาส 'active' เมื่อคลิก
            this.classList.toggle('active');
        });
    });
</script>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        const tags = document.querySelectorAll('.tag-item');
        const cards = document.querySelectorAll('.card');

        tags.forEach(tag => {
            tag.addEventListener('click', function(event) {
                event.preventDefault();

                // ลบคลาส active จากทุก tag
                tags.forEach(t => t.classList.remove('active'));
                // เพิ่ม active ใน tag ที่คลิก
                this.classList.add('active');

                const selectedTag = this.getAttribute('data-tag');

                // แสดง/ซ่อน cards ตาม tag ที่เลือก
                cards.forEach(card => {
                    const cardTag = card.getAttribute('data-tag');
                    if (selectedTag === 'all' || cardTag === selectedTag) {
                        card.style.display = 'flex'; // แสดง card
                    } else {
                        card.style.display = 'none'; // ซ่อน card
                    }
                });
            });
        });
    });
</script>

@endsection
