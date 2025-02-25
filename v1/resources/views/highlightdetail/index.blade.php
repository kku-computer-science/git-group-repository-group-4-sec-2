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
@if(isset($highlight))
<div class="head-img">
    @if($highlights->isNotEmpty())
    @foreach($highlights as $highlight)
    <img src="{{ asset('storage/' . $highlight->image) }}" class="w-100" style="height: 600px; object-fit: cover;">
</div>

<div class="container">
    <div class="row">
        <div class="py-3 px-0 d-flex align-items-center col-lg-10">
            <div class="row mx-0 w-100">
                <div class="px-0 py-2 d-flex justify-content-center align-items-center col-lg-4">
                    <span><b>เผยแพร่:</b>&nbsp;{{ $highlight->created_at->format('d/m/Y H:i') }}&nbsp;</span>
                </div>
                <div class="px-2 d-flex col-lg-8">
                    <div class="d-flex px-1 align-items-center" style="width: fit-content;">
                        <span><b>แท็ก:</b></span>
                        @if($highlight->tags->isNotEmpty())
                        @foreach($highlight->tags as $tag)
                        <span>&nbsp;{{ $tag->name }}</span>
                        @endforeach
                        @else
                        <span class="text-muted">แท็ก: -</span>
                        @endif
                    </div>
                </div> -->

                <div class="d-flex justify-content-start align-items-start col-lg-7">
                    <span class="px-1"><b>แท็ก:&nbsp;</b></span>
                    <div class="d-flex flex-wrap">
                        @if($highlight->tags->isNotEmpty())
                        @foreach($highlight->tags as $tag)
                        <span>
                            <a href="{{ route('allhighlights.index', ['tag' => strtolower(trim($tag->name))]) }}"
                                class="text-decoration-none">{{ $tag->name }}</a>&nbsp;
                        </span>
                        @endforeach
                        @else
                        <span class="text-muted">แท็ก: -</span>
                        @endif
                    </div>
                </div>

                <div class="d-flex justify-content-end align-items-start col-lg-2">
                    <b>แชร์:</b>&nbsp;
                    <a href="javascript:void(0)" class="share-network-facebook">
                        <button type="button" class="btn btn-outline-secondary btn-sm copy-url-btn" title="คัดลอกลิงก์">
                            <i class="fas fa-copy" aria-hidden="true"></i>
                        </button>
                    </a>
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
            <!-- <pre style="font-size:12pt; font-family:Aptos,sans-serif; white-space: normal; overflow-wrap: break-word; word-wrap: break-word;">
            {{ $highlight->description }}
            </pre> -->
            <pre style="font-size: 12pt; font-family: Aptos, sans-serif; white-space: pre-wrap; word-wrap: break-word; overflow-wrap: break-word;">
            {{ $highlight->description }}
            </pre>

        </div>
        <!-- <div class="my-4 d-flex align-items-center col-lg-12">
            <b style="max-width: 30%" ;>แหล่งข้อมูลเพิ่มเติม:</b>&nbsp;
            <a href="{{ $highlight->link }}" target="_blank"
                class="text-decoration-none text-truncate d-inline-block"
                style="max-width: 70%; overflow: hidden; white-space: nowrap; text-overflow: ellipsis;">
                {{ $highlight->link }}
            </a>
        </div> -->
        @if($highlight->link)
        <div class="my-4 d-flex align-items-center col-lg-12">
            <b style="max-width: 30%" ;>แหล่งข้อมูลเพิ่มเติม:</b>&nbsp;
            <a href="{{ $highlight->link }}" target="_blank"
                class="text-decoration-none text-truncate d-inline-block"
                style="max-width: 70%; overflow: hidden; white-space: nowrap; text-overflow: ellipsis;">
                {{ $highlight->link }}
            </a>
        </div>
        @endif

        @if($highlight->images->isNotEmpty())
        <div class="py-2 col-12">
            <span class="text-muted">
                อัลบั้ม รูปภาพ
            </span>

            <div class="px-2 container-fluid">
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
            <span><b>อัปเดตล่าสุด: </b></span>
            <span>&nbsp;{{ $highlight->updated_at->format('d/m/Y H:i') }}</span>
        </div>
    </div>
</div>
@else
<p>ไม่มีข้อมูล</p>
@endif


<script>
    document.addEventListener("DOMContentLoaded", function() {
        const container = document.getElementById("relatedNews");
        if (!container) return;

        const btnLeft = document.getElementById("scrollLeftRelated");
        const btnRight = document.getElementById("scrollRightRelated");

        btnLeft.addEventListener("click", function() {
            container.scrollBy({
                left: -250,
                behavior: "smooth"
            });
        });

        btnRight.addEventListener("click", function() {
            container.scrollBy({
                left: 250,
                behavior: "smooth"
            });
        });
    });
</script>

<script>
    document.addEventListener("DOMContentLoaded", function() {
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


<script>
    document.addEventListener("DOMContentLoaded", function() {
        const copyButton = document.querySelector(".copy-url-btn");

        if (copyButton) {
            copyButton.addEventListener("click", function() {
                const currentURL = window.location.href;

                navigator.clipboard.writeText(currentURL)
                    .then(() => {
                        copyButton.innerHTML = '<i class="fas fa-check" aria-hidden="true"></i>';
                        copyButton.classList.add("btn-success");
                        setTimeout(() => {
                            copyButton.innerHTML = '<i class="fas fa-copy" aria-hidden="true"></i>';
                            copyButton.classList.remove("btn-success");
                        }, 2000);
                    })
                    .catch(err => {
                        console.error("ไม่สามารถคัดลอก URL ได้: ", err);
                    });
            });
        }
    });
</script>
@endsection