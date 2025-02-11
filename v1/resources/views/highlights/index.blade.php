@extends('dashboards.users.layouts.user-dash-layout')

@section('content')
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<div class="container">
    <!-- แสดงข้อความแจ้งเตือน -->
    @if ($message = Session::get('success'))
    <div class="alert alert-success">{{ $message }}</div>
    @endif
    @if ($message = Session::get('error'))
    <div class="alert alert-danger">{{ $message }}</div>
    @endif

    <!-- ซ่อนค่า Count ของ Highlights -->
    <input type="hidden" id="highlight-count" value="{{ $highlights->where('status', 1)->count() }}">

    <!-- ✅ ตาราง Highlights (ข้างบน) -->
    <h2>Highlights</h2>
    <table id="highlight-table" class="table table-striped">

        <thead>
            <tr>
                <th>ID</th>
                <th>Image</th>
                <th>Title</th>
                <th>Category</th>
                <th>Date Time</th>
                <th>Created By</th>
                <th>Actions</th>
                <th>Remove Highlight</th>
            </tr>
        </thead>
        <tbody>
            @foreach ($highlights as $highlight)
            <tr id="highlight-row-{{ $highlight->id }}">
                <td>{{ $highlight->id }}</td>
                <td>
                    @if($highlight->image)
                    <img src="{{ asset('storage/' . $highlight->image) }}" width="120">
                    @else
                    No Image
                    @endif
                </td>
                <td>{{ $highlight->title }}</td>
                <td>{{ $highlight->category->name ?? 'No Category' }}</td>
                <td>{{ $highlight->created_at->format('d/m/Y h:i:s A') }}</td>
                <td>
                    {{ optional($highlight->user)->fname_th ?? 'Unknown' }} {{ optional($highlight->user)->lname_th ?? '' }}
                </td>
                <td>
                    <!-- ปุ่ม Edit -->
                    <a href="{{ route('highlights.edit', $highlight->id) }}" class="btn btn-outline-primary">
                        <i class="fas fa-edit"></i>
                    </a>

                    <!-- ปุ่ม Delete -->
                    <button type="button" class="btn btn-danger btn-delete" data-id="{{ $highlight->id }}">
                        <i class="fas fa-trash-alt"></i>
                    </button>
                </td>

                <td>
                    <!-- ปุ่ม Remove from Highlight -->
                    <button type="button" class="btn btn-warning btn-remove" data-id="{{ $highlight->id }}">REMOVE</button>
                </td>
            </tr>
            @endforeach
        </tbody>
    </table>

    <!-- ✅ ตาราง News (ข้างล่าง) -->
    <h2>News</h2>
    <a href="{{ route('highlights.create') }}" class="btn btn-primary mb-3">+ Create</a>
    <table id="news-table" class="table table-striped">

        <thead>
            <tr>
                <th>ID</th>
                <th>Image</th>
                <th>Title</th>
                <th>Category</th>
                <th>Date Time</th>
                <th>Created By</th>
                <th>Actions</th>
                <th>Add to Highlight</th>
            </tr>
        </thead>
        <tbody>
            @foreach ($news as $highlight)
            <tr id="news-row-{{ $highlight->id }}">
                <td>{{ $highlight->id }}</td>
                <td>
                    @if($highlight->image)
                    <img src="{{ asset('storage/' . $highlight->image) }}" width="120">
                    @else
                    No Image
                    @endif
                </td>
                <td>{{ $highlight->title }}</td>
                <td>{{ $highlight->category->name ?? 'No Category' }}</td>
                <td>{{ $highlight->created_at->format('d/m/Y h:i:s A') }}</td>
                <td>
                    {{ optional($highlight->user)->fname_th ?? 'Unknown' }} {{ optional($highlight->user)->lname_th ?? '' }}
                </td>
                <td>
                    <a href="{{ route('highlights.edit', $highlight->id) }}" class="btn btn-outline-primary">
                        <i class="fas fa-edit"></i>
                    </a>

                    <!-- ปุ่ม Delete -->
                    <button type="button" class="btn btn-danger btn-delete" data-id="{{ $highlight->id }}">
                        <i class="fas fa-trash-alt"></i>
                    </button>
                </td>

                <td>
                    <!-- ปุ่ม Add to Highlight -->
                    <button type="button" class="btn btn-success btn-add" data-id="{{ $highlight->id }}">ADD</button>
                </td>
            </tr>
            @endforeach
        </tbody>
    </table>
</div>

<script>
    $(document).ready(function() {
        function updateHighlightCount() {
            let count = $("#highlight-table tbody tr").length;
            $("#highlight-count").val(count);

            // ปิดปุ่ม ADD ถ้าครบ 5 ไฮไลท์
            if (count >= 5) {
                $(".btn-add").prop("disabled", true);
            } else {
                $(".btn-add").prop("disabled", false);
            }
        }

        // ✅ ฟังก์ชันกดปุ่ม ADD → ย้ายไปตาราง Highlights
        $(document).on("click", ".btn-add", function() {
            let row = $(this).closest("tr");
            let highlightId = $(this).attr("data-id");

            let highlightCount = $("#highlight-table tbody tr").length;
            if (highlightCount >= 5) {
                Swal.fire({
                    icon: "warning",
                    title: "เพิ่มไม่ได้!",
                    text: "คุณมี 5 รายการใน Highlights แล้ว กรุณาลบรายการเก่าก่อนเพิ่มใหม่",
                    confirmButtonText: "ตกลง",
                    confirmButtonColor: "#3085d6",
                });
                return;
            }

            $.ajax({
                url: "/highlights/" + highlightId + "/add",
                type: "POST",
                data: { _token: "{{ csrf_token() }}", _method: "PUT" },
                success: function(response) {
                    Swal.fire({
                        position: "center",
                        icon: "success",
                        title: "เพิ่มลงใน Highlights แล้ว!",
                        showConfirmButton: false,
                        timer: 1500
                    });

                    $("#highlight-table tbody").append(row);

                    row.find(".btn-add")
                        .removeClass("btn-success btn-add")
                        .addClass("btn-warning btn-remove")
                        .text("REMOVE");

                    updateHighlightCount();
                },
                error: function(xhr) {
                    Swal.fire("ผิดพลาด!", "เกิดข้อผิดพลาดบางอย่าง!", "error");
                }
            });
        });

        // ✅ ฟังก์ชันกดปุ่ม REMOVE → ย้ายไปตาราง News (ไม่ได้ลบ)
        $(document).on("click", ".btn-remove", function() {
            let row = $(this).closest("tr");
            let highlightId = $(this).attr("data-id");

            $.ajax({
                url: "/highlights/" + highlightId + "/remove",
                type: "POST",
                data: { _token: "{{ csrf_token() }}", _method: "PUT" },
                success: function(response) {
                    Swal.fire({
                        position: "center",
                        icon: "success",
                        title: "นำออกจาก Highlights แล้ว!",
                        showConfirmButton: false,
                        timer: 1500
                    });

                    $("#news-table tbody").append(row);

                    row.find(".btn-remove")
                        .removeClass("btn-warning btn-remove")
                        .addClass("btn-success btn-add")
                        .text("ADD");

                    updateHighlightCount();
                },
                error: function(xhr) {
                    Swal.fire("ผิดพลาด!", "เกิดข้อผิดพลาดบางอย่าง!", "error");
                }
            });
        });

        // ✅ ฟังก์ชันกดปุ่ม DELETE → ลบจาก Database
        $(document).on("click", ".btn-delete", function() {
            let row = $(this).closest("tr");
            let highlightId = $(this).attr("data-id");

            Swal.fire({
                title: "คุณแน่ใจหรือไม่?",
                text: "หากลบแล้วจะไม่สามารถกู้คืนได้!",
                icon: "warning",
                padding: "1.25rem",
                showCancelButton: true,
                confirmButtonColor: "#d33",
                cancelButtonColor: "#3085d6",
                confirmButtonText: "ใช่, ลบเลย!",
                cancelButtonText: "ยกเลิก"
            }).then((result) => {
                if (result.isConfirmed) {
                    $.ajax({
                        url: "/highlights/" + highlightId,
                        type: "POST",
                        data: { _token: "{{ csrf_token() }}", _method: "DELETE" },
                        success: function(response) {
                            Swal.fire({
                                icon: "success",
                                title: "ลบสำเร็จ!",
                                padding: "1.25rem",
                                text: "รายการนี้ถูกลบออกจากระบบแล้ว",
                                showConfirmButton: false,
                                timer: 1500
                            });

                            row.remove();
                            updateHighlightCount();
                        },
                        error: function(xhr) {
                            Swal.fire("ผิดพลาด!", "เกิดข้อผิดพลาดบางอย่าง!", "error");
                        }
                    });
                }
            });
        });

        updateHighlightCount();
    });
</script>









@endsection