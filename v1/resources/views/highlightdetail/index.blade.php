@extends('layouts.layout')

<style>

    /* Related News Section */
.related-container {
    position: relative;
    max-width: 100%;
    padding: 20px 0;
}

.related-wrapper {
    display: flex;
    gap: 15px;
    overflow-x: auto;
    scroll-behavior: smooth;
    padding-bottom: 10px;
}

/* Hide Scrollbar */
.related-wrapper::-webkit-scrollbar {
    display: none;
}

.related-card {
    flex: 0 0 18rem;
    min-width: 18rem;
    border-radius: 10px;
    overflow: hidden;
    box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
    transition: transform 0.3s ease-in-out;
}

.related-card:hover {
    transform: translateY(-5px);
}

.related-card img {
    height: 200px;
    object-fit: cover;
}

</style>
@section('content')
@if($highlights->isNotEmpty())
@foreach($highlights as $highlight)
<div class="head-img">
    <img src="{{ asset('storage/' . $highlight->image) }}" class="w-100" style="height: 600px; object-fit: cover;">
</div>

<div class="container">
    <div class="row">
        <div class="py-3 px-0 d-flex align-items-center col-lg-10">
            <div class="row mx-0 w-100">
                <div class="px-0 py-2 d-flex justify-content-center align-items-center col-lg-4">
                    <span>เผยแพร่&nbsp;{{ $highlight->created_at->format('d/m/Y H:i') }}&nbsp;</span>
                </div>
                <div class="px-2 d-flex col-lg-8">
                    <div class="d-flex px-1 align-items-center" style="width: fit-content;">
                        <span>หมวดหมู่:</span>
                        <!-- <a href="/content/news/tag/{{ $highlight->tag->name }}"> -->
                            <span>&nbsp;{{ $highlight->tag->name }}</span>
                        <!-- </a> -->
                    </div>
                </div>
            </div>
        </div>
        <div class="p-0 d-flex justify-content-center align-items-center col-lg-2">
            แชร์ &nbsp;
            <a href="javascript:void(0)" class="share-network-facebook">
                <button type="button" class="btn btn-outline-primary btn-sm">
                    <i class="fab fa-facebook" aria-hidden="true"></i>
                </button>
            </a>
        </div>
        <div class="text-center py-5 col-12">
            <h2>{{ $highlight->title }}</h2>
        </div>
        <div class="py-2 col-12">
            <span style="font-size:12pt; font-family:Aptos,sans-serif;">
                {{ $highlight->description }}
            </span>
        </div>

        @if($highlight->images->isNotEmpty())
        <div class="py-2 col-12">
            <span class="text-muted">อัลบั้ม รูปภาพ</span>
            <div class="container-fluid px-2">
                <div class="row">
                    @foreach($highlight->images as $image)
                    <div class="my-2 col-md-6 col-lg-2">
                        <img src="{{ asset('storage/' . $image->image) }}" 
                            class="img-thumbnail w-100" 
                            style="height: 150px; object-fit: cover; border-radius: 8px;" 
                            role="button" tabindex="0">
                    </div>
                    @endforeach
                </div>
            </div>
        </div>
        @endif

        <div class="d-flex justify-content-end col-12">
            <h6><i class="fas fa-user" aria-hidden="true"></i>
                {{ $highlight->user->fname_th }} {{ $highlight->user->lname_th }}
            </h6>
        </div>
        <div class="d-flex justify-content-end col-12">
            <h6>
                อัปเดตล่าสุด:
                <span>{{ $highlight->updated_at->format('d/m/Y H:i') }}</span>
            </h6>
        </div>
    </div>
</div>
@endforeach
@else
<p>ไม่มีข้อมูล</p>
@endif

<!-- Related News Section -->
<div class="container rlNews mt-5">
    <h3 class="mb-4">ข่าวที่เกี่ยวข้อง</h3>

    <div class="related-container">
        @if($news->isNotEmpty())
        <div class="related-wrapper" id="relatedNews">
            @foreach($news as $new)
            <div class="related-card">
                <a href="{{ route('highlight.show', $new->id) }}">
                    <img src="{{ asset('storage/' . $new->image) }}" class="card-img-top" alt="Related News Image">
                </a>
                <div class="card-body">
                    <span class="badge bg-primary">{{ $new->tag->name }}</span>
                    <h6 class="card-title mt-2">{{ $new->title }}</h6>
                    <p class="card-text">{{ Str::limit($new->description, 100) }}</p>
                </div>
            </div>
            @endforeach
        </div>

        <!-- Navigation Arrows -->
        <div class="d-flex justify-content-end mt-3">
            <button class="btn btn-outline-primary me-2" id="scrollLeftRelated"><i class="fas fa-chevron-left"></i></button>
            <button class="btn btn-outline-primary" id="scrollRightRelated"><i class="fas fa-chevron-right"></i></button>
        </div>

        @else
        <p class="text-muted">ไม่มีข่าวที่เกี่ยวข้อง</p>
        @endif
    </div>
</div>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        const container = document.getElementById("relatedNews");
        if (!container) return;

        const btnLeft = document.getElementById("scrollLeftRelated");
        const btnRight = document.getElementById("scrollRightRelated");

        btnLeft.addEventListener("click", function () {
            container.scrollBy({ left: -250, behavior: "smooth" });
        });

        btnRight.addEventListener("click", function () {
            container.scrollBy({ left: 250, behavior: "smooth" });
        });
    });
</script>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        const cardList = document.querySelector('.card-list');
        if (!cardList) return;

        const leftArrow = document.querySelector('.arrow.left');
        const rightArrow = document.querySelector('.arrow.right');
        const cardItems = document.querySelectorAll('.card-item');

        if (cardItems.length === 0) return;

        const cardWidth = cardItems[0].offsetWidth + 24;
        const visibleCards = 3;
        const totalCards = cardItems.length;
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
    });
</script>

@endsection
