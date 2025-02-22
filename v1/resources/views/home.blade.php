@extends('layouts.layout')
<style>
    .count {
        background-color: #f5f5f5;
        padding: 20px 0;
        border-radius: 5px;


    }

    .count-title {
        font-size: 40px;
        font-weight: normal;
        margin-top: 10px;
        margin-bottom: 0;
        text-align: center;
    }

    .count-text {
        font-size: 15px;
        font-weight: normal;
        margin-top: 10px;
        margin-bottom: 0;
        text-align: center;

    }

    .fa-2x {
        margin: 0 auto;
        float: none;
        display: table;
        color: #4ad1e5;
    }

    #highlightNews {
        overflow-x: auto;
        scroll-behavior: smooth;
        display: flex;
        white-space: nowrap;
        padding-bottom: 10px;
    }

    /* ซ่อน scrollbar ในเบราว์เซอร์ */
    #highlightNews::-webkit-scrollbar {
        display: none;
    }

    /* ปรับสไตล์ของแถบไฮไลท์ */
    .highlight-container {
        position: relative;
        max-width: 100%;
        padding: 20px 0;
    }

    .highlight-wrapper {
        display: flex;
        gap: 15px;
        overflow-x: auto;
        scroll-behavior: smooth;
        padding-bottom: 10px;
    }

    /* ซ่อน Scrollbar */
    .highlight-wrapper::-webkit-scrollbar {
        display: none;
    }

    .highlight-card {
        flex: 0 0 18rem;
        /* ขนาดของการ์ด */
        min-width: 18rem;
        border-radius: 10px;
        overflow: hidden;
        box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
        transition: transform 0.3s ease-in-out;
    }

    .highlight-card:hover {
        transform: translateY(-5px);
    }

    .highlight-card img {
        height: 200px;
        object-fit: cover;
    }

    /* ปุ่มเลื่อน */
    .highlight-nav {
        position: absolute;
        top: 50%;
        transform: translateY(-50%);
        background: rgba(0, 0, 0, 0.5);
        color: white;
        border: none;
        padding: 15px 20px;
        cursor: pointer;
        border-radius: 50%;
        transition: background 0.3s;
        z-index: 10;
        /* ทำให้ปุ่มอยู่หน้าสุด */
    }

    .highlight-nav:hover {
        background: rgba(0, 0, 0, 0.8);
    }

    /* ป้องกันการโดนกดบัง */
    .highlight-nav i {
        pointer-events: none;
        /* ป้องกันการบังการกด */
    }

    .highlight-prev {
        left: 5px;
    }

    .highlight-next {
        right: 5px;
    }


    /* Fix the carousel size */
    #carouselExampleIndicators {
        max-width: 100%;
        border-radius: 20px;
        /* Add rounded corners */

        width: 100%;
        /* Set your desired width */
        height: 600px;
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
</style>
@section('content')
<div class="container home">
    <div class="container d-sm-flex justify-content-center mt-5">

        <div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="carousel">
            <!-- Carousel Indicators -->
            <ol class="carousel-indicators">
                @foreach($heads as $index => $head)
                <li data-bs-target="#carouselExampleIndicators" data-bs-slide-to="{{ $index }}" class="{{ $loop->first ? 'active' : '' }}"></li>
                @endforeach
            </ol>

            <!-- Carousel Items -->
            <div class="carousel-inner">
                @foreach($heads as $index => $head)
                <div class="carousel-item {{ $loop->first ? 'active' : '' }}">
                    <a href="{{ route('highlight.show', $head->id) }}">
                        <img src="{{ asset('storage/' . $head->image) }}" class="d-block w-100" alt="...">
                    </a>
                </div>
                @endforeach
            </div>

            <!-- Navigation Buttons -->
            <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-bs-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Previous</span>
            </a>
            <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-bs-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Next</span>
            </a>
        </div>

    </div>


    <!-- News -->
<!-- 
    <div class="container news mt-5">
        <h3 class="mb-4">HIGHLIGHT NEWS</h3>

        <div class="highlight-container">

            <div class="highlight-wrapper" id="highlightNews">
                @foreach($highlights as $highlight)
                <div class="highlight-card">
                    <a href="{{ route('highlight.show', $highlight->id) }}">
                        <img src="{{ asset('storage/' . $highlight->image) }}" class="card-img-top" alt="Highlight Image">
                    </a>
                    <div class="card-body">
                        <span class="badge bg-primary">{{ $highlight->tags->pluck('name')->implode(', ') ?? 'No Tag' }}</span>
                        <h6 class="card-title mt-2">{{ $highlight->title }}</h6>
                        <p class="card-text">{{ Str::limit($highlight->description, 100) }}</p>
                    </div>
                </div>
                @endforeach
            </div>

            <div class="d-flex justify-content-end mt-3">
                <button class="btn btn-outline-primary me-2" id="scrollLeft"><i class="fas fa-chevron-left"></i></button>
                <button class="btn btn-outline-primary" id="scrollRight"><i class="fas fa-chevron-right"></i></button>
            </div>
        </div>
    </div> -->

    <!-- Modal -->

    <div class="container card-cart d-sm-flex justify-content-center mt-5">
        <div class="col-md-8">
            <div class="card">
                <div class="card-body">
                    <div class="chart" style="height: 350px;">
                        <canvas id="barChart1"></canvas>
                    </div>
                </div>
            </div>
        </div>

    </div>
    <br>

    <div class="container mt-3">

        <div class="row text-center">
            <div class="col">
                <div class="count" id='all'>

                </div>
            </div>
            <div class="col">
                <div class="count" id='scopus'>

                </div>
            </div>
            <div class="col">
                <div class="count" id='wos'>

                </div>
            </div>
            <div class="col">
                <div class="count" id='tci'>

                </div>
            </div>
        </div>
    </div>

    <div class="modal" id="myModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Reference (APA)</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body" id="name">
                    <!-- <p>Modal body text goes here.</p> -->
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <!-- <button type="button" class="btn btn-primary">Save changes</button> -->
                </div>
            </div>
        </div>
    </div>


    <div class="container mixpaper pb-10 mt-3">
        <h3>{{ trans('message.publications') }}</h3>
        @foreach($papers as $n => $pe)
        <div class="accordion" id="accordionExample">
            <div class="accordion-item">
                <h2 class="accordion-header" id="headingOne">
                    <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapse{{$n}}" aria-expanded="true" aria-controls="collapseOne">
                        @if (!$loop->last)
                        {{$n}}
                        @else
                        Before {{$n}}
                        @endif

                    </button>
                </h2>
                <div id="collapse{{$n}}" class="accordion-collapse collapse" aria-labelledby="headingOne" data-bs-parent="#accordionExample">
                    <div class="accordion-body">
                        @foreach($pe as $n => $p)
                        <div class="row mt-2 mb-3 border-bottom">
                            <div id="number" class="col-sm-1">
                                <h6>[{{$n+1}}]</h6>
                            </div>
                            <div id="paper2" class="col-sm-11">
                                <p class="hidden">
                                    <b>{{$p['paper_name']}}</b> (
                                    <link>{{$p['author']}}</link>), {{$p['paper_sourcetitle']}}, {{$p['paper_volume']}},
                                    {{$p['paper_yearpub']}}.
                                    <a href="{{$p['paper_url']}} " target="_blank">[url]</a> <a href="https://doi.org/{{$p['paper_doi']}}" target="_blank">[doi]</a>
                                    <!-- <a href="{{ route('bibtex',['id'=>$p['id']])}}">
                                        [อ้างอิง]
                                    </a> -->
                                    <button style="padding: 0;" class="btn btn-link open_modal" value="{{$p['id']}}">[อ้างอิง]</button>
                                </p>
                            </div>
                        </div>
                        @endforeach
                    </div>
                </div>

            </div>

        </div>
        @endforeach
    </div>

</div>
<script>
    document.addEventListener("DOMContentLoaded", function() {
        const highlightNews = document.getElementById("highlightNews");
        const scrollLeft = document.getElementById("scrollLeft");
        const scrollRight = document.getElementById("scrollRight");

        // คำนวณความกว้างของการ์ด + ระยะห่าง
        const cardWidth = document.querySelector(".highlight-card").offsetWidth + 15;

        // เลื่อนไปทางซ้าย
        scrollLeft.addEventListener("click", function() {
            highlightNews.scrollBy({
                left: -cardWidth,
                behavior: "smooth"
            });
        });

        // เลื่อนไปทางขวา
        scrollRight.addEventListener("click", function() {
            highlightNews.scrollBy({
                left: cardWidth,
                behavior: "smooth"
            });
        });
    });
</script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.min.js"></script>

<script>
    $(document).ready(function() {
        $(".moreBox").slice(0, 1).show();
        if ($(".blogBox:hidden").length != 0) {
            $("#loadMore").show();
        }
        $("#loadMore").on('click', function(e) {
            e.preventDefault();
            $(".moreBox:hidden").slice(0, 1).slideDown();
            if ($(".moreBox:hidden").length == 0) {
                $("#loadMore").fadeOut('slow');
            }
        });
    });
</script>

<script>
    var year = <?php echo $year; ?>;
    var paper_tci = <?php echo $paper_tci; ?>;
    var paper_scopus = <?php echo $paper_scopus; ?>;
    var paper_wos = <?php echo $paper_wos; ?>;
    var areaChartData = {

        labels: year,

        datasets: [{
                label: 'SCOPUS',
                backgroundColor: '#3994D6',
                borderColor: 'rgba(210, 214, 222, 1)',
                pointRadius: false,
                pointColor: '#3994D6',
                pointStrokeColor: '#c1c7d1',
                pointHighlightFill: '#fff',
                pointHighlightStroke: '#3994D6',
                data: paper_scopus
            },
            {
                label: 'TCI',
                backgroundColor: '#83E4B5',
                borderColor: 'rgba(255, 255, 255, 0.5)',
                pointRadius: false,
                pointColor: '#83E4B5',
                pointStrokeColor: '#3b8bba',
                pointHighlightFill: '#fff',
                pointHighlightStroke: '#83E4B5',
                data: paper_tci
            },
            {
                label: 'WOS',
                backgroundColor: '#FCC29A',
                borderColor: 'rgba(0, 0, 255, 1)',
                pointRadius: false,
                pointColor: '#FCC29A',
                pointStrokeColor: '#c1c7d1',
                pointHighlightFill: '#fff',
                pointHighlightStroke: '#FCC29A',
                data: paper_wos
            },
        ]
    }



    //-------------
    //- BAR CHART -
    //-------------
    var barChartCanvas = $('#barChart1').get(0).getContext('2d')
    var barChartData = $.extend(true, {}, areaChartData)
    var temp0 = areaChartData.datasets[0]
    var temp1 = areaChartData.datasets[1]
    barChartData.datasets[0] = temp1
    barChartData.datasets[1] = temp0

    var barChartOptions = {
        responsive: true,
        maintainAspectRatio: false,
        datasetFill: false,
        scales: {
            yAxes: [{
                formatter: function() {
                    return Math.abs(this.value);
                },
                scaleLabel: {
                    display: true,
                    labelString: 'Number',

                },
                ticks: {
                    reverse: false,
                    stepSize: 10
                },
            }],
            xAxes: [{
                scaleLabel: {
                    display: true,
                    labelString: 'Year'
                }
            }]
        },

        title: {
            display: true,
            text: 'Report the total number of articles ( 5 years : cumulative)',
            fontSize: 20
        }


    }

    new Chart(barChartCanvas, {
        type: 'bar',
        data: barChartData,
        options: barChartOptions
    })
</script>
<script>
    var paper_tci = <?php echo $paper_tci_numall; ?>;
    var paper_scopus = <?php echo $paper_scopus_numall; ?>;
    var paper_wos = <?php echo $paper_wos_numall; ?>;
    //console.log(paper_scopus)
    let sumtci = paper_tci;
    let sumsco = paper_scopus;
    let sumwos = paper_wos;
    (function($) {

        let sum = paper_wos + paper_tci + paper_scopus;
        //console.log(sum);
        //$("#scopus").append('data-to="100"');
        document.getElementById("all").innerHTML += `
                <i class="count-icon fa fa-book fa-2x"></i>
                <h2 class="timer count-title count-number" data-to="${sum}" data-speed="1500"></h2>
                <p class="count-text ">SUMMARY</p>`
        document.getElementById("scopus").innerHTML += `
                <i class="count-icon fa fa-book fa-2x"></i>
                <h2 class="timer count-title count-number" data-to="${sumsco}" data-speed="1500"></h2>
                <p class="count-text ">SCOPUS</p>`
        document.getElementById("wos").innerHTML += `
                <i class="count-icon fa fa-book fa-2x"></i>
                <h2 class="timer count-title count-number" data-to="${sumwos}" data-speed="1500"></h2>
                <p class="count-text ">WOS</p>`
        document.getElementById("tci").innerHTML += `
                <i class="count-icon fa fa-book fa-2x"></i>
                <h2 class="timer count-title count-number" data-to="${sumtci}" data-speed="1500"></h2>
                <p class="count-text ">TCI</p>`
        //document.getElementById("scopus").appendChild('data-to="100"');
        $.fn.countTo = function(options) {
            options = options || {};

            return $(this).each(function() {
                // set options for current element
                var settings = $.extend({}, $.fn.countTo.defaults, {
                    from: $(this).data('from'),
                    to: $(this).data('to'),
                    speed: $(this).data('speed'),
                    refreshInterval: $(this).data('refresh-interval'),
                    decimals: $(this).data('decimals')
                }, options);

                // how many times to update the value, and how much to increment the value on each update
                var loops = Math.ceil(settings.speed / settings.refreshInterval),
                    increment = (settings.to - settings.from) / loops;

                // references & variables that will change with each update
                var self = this,
                    $self = $(this),
                    loopCount = 0,
                    value = settings.from,
                    data = $self.data('countTo') || {};

                $self.data('countTo', data);

                // if an existing interval can be found, clear it first
                if (data.interval) {
                    clearInterval(data.interval);
                }
                data.interval = setInterval(updateTimer, settings.refreshInterval);

                // initialize the element with the starting value
                render(value);

                function updateTimer() {
                    value += increment;
                    loopCount++;

                    render(value);

                    if (typeof(settings.onUpdate) == 'function') {
                        settings.onUpdate.call(self, value);
                    }

                    if (loopCount >= loops) {
                        // remove the interval
                        $self.removeData('countTo');
                        clearInterval(data.interval);
                        value = settings.to;

                        if (typeof(settings.onComplete) == 'function') {
                            settings.onComplete.call(self, value);
                        }
                    }
                }

                function render(value) {
                    var formattedValue = settings.formatter.call(self, value, settings);
                    $self.html(formattedValue);
                }
            });
        };

        $.fn.countTo.defaults = {
            from: 0, // the number the element should start at
            to: 0, // the number the element should end at
            speed: 1000, // how long it should take to count between the target numbers
            refreshInterval: 100, // how often the element should be updated
            decimals: 0, // the number of decimal places to show
            formatter: formatter, // handler for formatting the value before rendering
            onUpdate: null, // callback method for every time the element is updated
            onComplete: null // callback method for when the element finishes updating
        };

        function formatter(value, settings) {
            return value.toFixed(settings.decimals);
        }
    }(jQuery));

    jQuery(function($) {
        // custom formatting example
        $('.count-number').data('countToOptions', {
            formatter: function(value, options) {
                return value.toFixed(options.decimals).replace(/\B(?=(?:\d{3})+(?!\d))/g, ',');
            }
        });

        // start all the timers
        $('.timer').each(count);

        function count(options) {
            var $this = $(this);
            options = $.extend({}, options || {}, $this.data('countToOptions') || {});
            $this.countTo(options);
        }
    });
</script>


<script>
    $(document).on('click', '.open_modal', function() {
        //var url = "domain.com/yoururl";
        var tour_id = $(this).val();
        $.get('/bib/' + tour_id, function(data) {
            //success data
            console.log(data);
            $(".bibtex-biblio").remove();
            document.getElementById("name").innerHTML += `${data}`
            // $('#tour_id').val(data.id);
            // $('#name').val(data);
            // $('#details').val(data.details);
            // $('#btn-save').val("update");
            $('#myModal').modal('show');
        })
    });
</script>
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