@extends('layouts.layout')

@section('content')
<div class="head-img">
    @if($highlights->isNotEmpty())
    @foreach($highlights as $highlight)
    <img src="{{ asset('storage/' . $highlight->image) }}" sizes="(max-width: 640px) 100vw, (max-width: 768px) 100vw, 100vw" srcset="" style="width: 100%; height: 100%;">
</div>

<div class="container">
    <div class="row">
        <div class="py-3 px-0 d-flex align-items-center col-sm-12 col-lg-10">
            <div class="row mx-0 w-100">
                <div class="px-0 py-2 d-flex justify-content-center align-content-center align-items-center col-sm-12 col-lg-4">
                    <span>เผยแพร่&nbsp;{{ $highlight->created_at->format('d/m/Y H:i') }}&nbsp;</span>
                </div>
                <div class="px-2 d-flex col-sm-12 col-lg-8">
                    <div class="d-flex px-1 align-items-center" style="width: 150px;">
                        <span> หมวดหมู่ : </span>
                        <a href="/content/news/category/{{ $highlight->category->name }}" class="">
                            <span>&nbsp;{{ $highlight->category->name }}</span>
                        </a>
                    </div>
                </div>
            </div>
        </div>
        <div class="p-0 d-flex justify-content-center align-items-center col-sm-12 col-lg-2">
            แชร์ &nbsp;
            <a href="javascript:void(0)" class="share-network-facebook"><button type="button" class="btn btn-outline-primary btn-sm">
                    <i class="fab fa-facebook" aria-hidden="true"></i></button></a>
        </div>
        <div class="text-center py-5 col-12">
            <h2>{{ $highlight->title }}</h2>
        </div>
        <div class="py-2 col-12">
            <span style="font-size:12pt"><span style="font-family:Aptos,sans-serif">
                    {{ $highlight->description }}
                </span>
            </span>
        </div>

        <div class="py-2 col-12"><span class="text-muted">
                อัลบั้ม รูปภาพ
            </span>
            <div class="px-2 container-fluid">
                <div class="row">
                    @foreach($highlight->images as $image)
                    <div class="my-2 col-sm-12 col-md-6 col-lg-2">
                        <img src="{{ asset('storage/' . $image->image) }}" class="img-thumbnail w-100" 
                        style="height: 150px; object-fit: cover; border-radius: 8px;"   class="img-thumbnail" role="button" tabindex="0">
                    </div>
                    @endforeach
                </div>
            </div>

            <div class="d-flex justify-content-end col-12">
                <h6><i class="fas fa-user" aria-hidden="true"></i>
                    {{ $highlight->user->fname_th }} {{ $highlight->user->lname_th }}
                </h6>
            </div>
            <div class="d-flex justify-content-end col-12">
                <h6>
                    อัปเดตล่าสุด
                    <span>
                        {{ $highlight->updated_at->format('d/m/Y H:i') }}
                    </span>
                </h6>
            </div>
        </div>
    </div>
</div>
@endforeach
@else
<p>ไม่มีข้อมูล</p>
@endif

<!-- Related News Section -->
<div class="container">
    <div class="row mx-0 mb-4">
        <div class="d-flex col-12">
            ข่าวที่เกี่ยวข้อง &nbsp;
            <a href="/content/news/category/{{ $highlight->category->name }}" class="">
                {{ $highlight->category->name }}
            </a>
        </div>
        @if($news->isNotEmpty())
        <div class="container news">
            <div class="card-wrapper">
                <ul class="card-list">
                    @foreach($news as $new)
                    <li class="card-item">
                        <a href="{{ route('highlight.show', $new->id) }}" class="card-link">
                            <img src="{{ asset('storage/' . $new->image) }}" class="d-block w-100"
                                style="height: 200px; object-fit: cover;" alt="Card Image" class="card-image">
                            <p class="tag">{{ $new->category->name }}</p>
                            <h6 class="card-title">{{ $new->title }}</h6>
                            <p class="card-description">{{ Str::limit($new->description, 100) }}</p>
                        </a>
                    </li>
                    @endforeach
                </ul>
                <div class="arrow-container">
                    <button class="arrow left">&#10094</button>
                    <button class="arrow right">&#10095</button>
                </div>
            </div>
        </div>


        @else
        <p>ไม่มีข่าวที่เกี่ยวข้อง</p>
        @endif
    </div>
</div>

<script>
    const cardList = document.querySelector('.card-list');
    const leftArrow = document.querySelector('.arrow.left');
    const rightArrow = document.querySelector('.arrow.right');

    const cardWidth = document.querySelector('.card-item').offsetWidth + 24;
    const visibleCards = 3;
    const totalCards = document.querySelectorAll('.card-item').length;
    let position = 0;

    function moveSlider(direction) {
        const maxScroll = cardWidth * (totalCards - visibleCards);

        if (direction === 'right') {
            position -= cardWidth;
            if (Math.abs(position) > maxScroll) {
                position = 0;
            }
        } else {
            position += cardWidth;
            if (position > 0) {
                position = -maxScroll;
            }
        }

        cardList.style.transform = `translateX(${position}px)`;
    }
    window.addEventListener('resize', () => {
        position = 0;
        cardList.style.transform = `translateX(${position}px)`;
    });

    rightArrow.addEventListener('click', () => moveSlider('right'));
    leftArrow.addEventListener('click', () => moveSlider('left'));
</script>

@endsection