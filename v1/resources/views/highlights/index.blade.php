@extends('dashboards.users.layouts.user-dash-layout')

@section('content')
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

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

    <!-- ✅ ตาราง Show  Highlights (ข้างบน) -->
    <h2>Show Highlights</h2>
    <table id="highlight-table" class="table table-striped">
        <thead>
            <tr>
                <th>Priority</th>
                <th>ID</th>
                <th>Image</th>
                <th>Title</th>
                <th>Tags</th>
                <th>Date Time</th>
                <th>Created By</th>
                <th>Actions</th>
                <th>Remove Highlight</th>
            </tr>
        </thead>
        <tbody>
            @foreach ($highlights as $highlight)
            <tr id="highlight-row-{{ $highlight->id }}" data-id="{{ $highlight->id }}" data-priority="{{ $highlight->priority }}">
                <td class="priority-controls">
                    <button class="btn btn-sm btn-light move-up" data-id="{{ $highlight->id }}">⬆️</button>
                    <button class="btn btn-sm btn-light move-down" data-id="{{ $highlight->id }}">⬇️</button>
                </td>
                <td>{{ $highlight->id }}</td>
                <td>
                    @if($highlight->image)
                    <img src="{{ asset('storage/' . $highlight->image) }}" width="120">
                    @else
                    No Image
                    @endif
                </td>
                <td>{{ $highlight->title }}</td>
                <td>{{ $highlight->tags->pluck('name')->implode(', ') ?? 'No Tag' }}</td>
                <td>{{ $highlight->created_at->format('d/m/Y h:i:s A') }}</td>
                <td>{{ optional($highlight->user)->fname_th ?? 'Unknown' }} {{ optional($highlight->user)->lname_th ?? '' }}</td>
                <td>
                    <a href="{{ route('highlights.edit', $highlight->id) }}" class="btn btn-outline-primary"><i class="fas fa-edit"></i></a>
                    <button type="button" class="btn btn-danger btn-delete" data-id="{{ $highlight->id }}"><i class="fas fa-trash-alt"></i></button>
                </td>
                <td>
                    <button type="button" class="btn btn-warning btn-remove" data-id="{{ $highlight->id }}">REMOVE</button>
                </td>
            </tr>
            @endforeach
        </tbody>
    </table>

    <h2>Highlights</h2>
    <a href="{{ route('highlights.create') }}" class="btn btn-primary mb-3">+ Create</a>
    <button type="button" class="btn btn-danger" id="deleteTagBtn">
        ลบ Tag
    </button>
    <table id="news-table" class="table table-striped">

        <thead>
            <tr>
                <th>ID</th>
                <th>Image</th>
                <th>Title</th>
                <th>Tags</th>
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
                    <img src="{{ asset('storage/' . $highlight->image) }}">
                    @else
                    No Image
                    @endif
                </td>
                <td>{{ $highlight->title }}</td>
                <td>{{ $highlight->tags->pluck('name')->implode(', ') ?? 'No Tag' }}</td>
                <td>{{ $highlight->created_at->format('d/m/Y h:i:s A') }}</td>
                <td>
                    {{ optional($highlight->user)->fname_th ?? 'Unknown' }} {{ optional($highlight->user)->lname_th ?? '' }}
                </td>
                <td>
                    <a href="{{ route('highlights.edit', $highlight->id) }}" class="btn btn-outline-primary">
                        <i class="fas fa-edit"></i>
                    </a>

                    <button type="button" class="btn btn-danger btn-delete" data-id="{{ $highlight->id }}">
                        <i class="fas fa-trash-alt"></i>
                    </button>
                </td>

                <td>
                    <button type="button" class="btn btn-success btn-add" data-id="{{ $highlight->id }}">ADD</button>
                </td>
            </tr>
            @endforeach
        </tbody>
    </table>
</div>

<!-- Modal แสดงรายการ Tag -->
<div id="deleteTagModal" class="modal fade" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">เลือกลบ Tag</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <table class="table table-bordered">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>ชื่อ Tag</th>
                            <th>ลบ</th>
                        </tr>
                    </thead>
                    <tbody>
                        @foreach ($tags as $index => $tag)
                        <tr>
                            <td>{{ $index + 1 }}</td>
                            <td>{{ $tag->name }}</td>
                            <td>
                                <button class="btn btn-danger delete-tag-btn" data-id="{{ $tag->id }}">ลบ</button>
                            </td>
                        </tr>
                        @endforeach
                    </tbody>
                </table>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">ปิด</button>
            </div>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.3.1.js"></script>
<script src="http://cdn.datatables.net/1.10.18/js/jquery.dataTables.min.js" defer></script>
<script src="https://cdn.datatables.net/1.12.0/js/dataTables.bootstrap4.min.js" defer></script>
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
                data: {
                    _token: "{{ csrf_token() }}",
                    _method: "PUT"
                },
                success: function(response) {
                    Swal.fire({
                        position: "center",
                        icon: "success",
                        title: "เพิ่มลงใน Highlights แล้ว!",
                        showConfirmButton: false,
                        timer: 1500
                    });

                    // ✅ เพิ่มปุ่ม Move Up / Move Down ก่อนนำไปใส่ใน Highlight Table
                    let priorityControls = `
                <td class="priority-controls">
                    <button class="btn btn-sm btn-light move-up" data-id="${highlightId}">⬆️</button>
                    <button class="btn btn-sm btn-light move-down" data-id="${highlightId}">⬇️</button>
                </td>
            `;

                    row.prepend(priorityControls); // เพิ่มปุ่มก่อนนำเข้า Highlight Table

                    // ✅ ย้ายแถวไปยัง Highlight Table
                    $("#highlight-table tbody").append(row);

                    // ✅ เปลี่ยนปุ่มจาก ADD -> REMOVE
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
                data: {
                    _token: "{{ csrf_token() }}",
                    _method: "PUT"
                },
                success: function(response) {
                    Swal.fire({
                        position: "center",
                        icon: "success",
                        title: "นำออกจาก Highlights แล้ว!",
                        showConfirmButton: false,
                        timer: 1500
                    });

                    // ✅ ลบปุ่ม Move Up / Move Down ก่อนย้ายไปตาราง News
                    row.find(".priority-controls").remove();

                    // ✅ ย้ายไปตาราง News และไปอยู่ด้านล่างสุด
                    $("#news-table tbody").append(row);

                    // ✅ เปลี่ยนปุ่มจาก REMOVE -> ADD
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
                        data: {
                            _token: "{{ csrf_token() }}",
                            _method: "DELETE"
                        },
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
                            Swal.fire({
                                icon: "error",
                                title: "เกิดข้อผิดพลาด!",
                                padding: "1.25rem",
                                text: "ไม่สามารถลบรายการนี้ได้",
                                confirmButtonText: "ตกลง",
                                confirmButtonColor: "#3085d6"
                            });
                        }
                    });
                }
            });
        });

        updateHighlightCount();
    });

    $(document).ready(function() {
        // Initialize DataTables for both tables
        $('#highlight-table').DataTable();
        $('#news-table').DataTable();


        setTimeout(function() {
            $(".alert-success").fadeOut("slow");
        }, 2000);
        setTimeout(function() {
            $(".alert-danger").fadeOut("slow");
        }, 2000);
    });

    $(document).ready(function() {
        // ซ่อนข้อความที่ยาวเกิน 25 ตัวอักษรในคอลัมน์ Title
        $('#highlight-table tbody tr').each(function() {
            var titleCell = $(this).find('td:nth-child(3)'); // คอลัมน์ Title
            var titleText = titleCell.text().trim();

            if (titleText.length > 25) {
                var shortenedTitle = titleText.substring(0, 25) + '...'; // ย่อข้อความและเพิ่ม ...
                titleCell.text(shortenedTitle); // อัพเดตข้อความที่แสดงในตาราง
            }
        });

        $('#news-table tbody tr').each(function() {
            var titleCell = $(this).find('td:nth-child(3)'); // คอลัมน์ Title
            var titleText = titleCell.text().trim();

            if (titleText.length > 25) {
                var shortenedTitle = titleText.substring(0, 25) + '...'; // ย่อข้อความและเพิ่ม ...
                titleCell.text(shortenedTitle);
            }
        });
    });

    $(document).ready(function() {
        // เปิด Modal
        $("#deleteTagBtn").click(function() {
            $("#deleteTagModal").modal("show");
        });

        // ฟังก์ชันลบ Tag
        $(document).on("click", ".delete-tag-btn", function() {
            let tagId = $(this).data("id");

            Swal.fire({
                title: "คุณแน่ใจหรือไม่?",
                text: "Tag นี้จะถูกลบและไม่สามารถกู้คืนได้!",
                icon: "warning",
                showCancelButton: true,
                confirmButtonColor: "#d33",
                cancelButtonColor: "#3085d6",
                confirmButtonText: "ใช่, ลบเลย!",
                cancelButtonText: "ยกเลิก"
            }).then((result) => {
                if (result.isConfirmed) {
                    $.ajax({
                        url: `/tags/${tagId}`,
                        type: "DELETE",
                        data: {
                            _token: "{{ csrf_token() }}"
                        },
                        success: function(response) {
                            if (response.success) {
                                Swal.fire("ลบสำเร็จ!", "Tag ถูกลบเรียบร้อย", "success").then(() => {
                                    location.reload(); // รีโหลดหน้าเพื่ออัปเดตรายการ
                                });
                            } else {
                                Swal.fire("ไม่สามารถลบได้!", response.message, "warning");
                            }
                        },
                        error: function(xhr) {
                            if (xhr.status === 400) {
                                Swal.fire("ไม่สามารถลบได้!", "Tag นี้ถูกใช้งานอยู่ ไม่สามารถลบได้", "warning");
                            } else {
                                Swal.fire("Error", "เกิดข้อผิดพลาด ไม่สามารถลบ Tag ได้", "error");
                            }
                        }
                    });
                }
            });
        });
    });

    // console.log("🔍 Ordered IDs ส่งไปที่ API:", orderedIds);
    $(document).on("click", ".move-up, .move-down", function() {
        let row = $(this).closest("tr");
        let moveUp = $(this).hasClass("move-up");
        let siblingRow = moveUp ? row.prev() : row.next();

        if (siblingRow.length === 0) return; // ถ้าไม่มีแถวข้างบนหรือข้างล่าง ให้หยุดทำงาน

        // ✅ สลับตำแหน่งแถว
        moveUp ? siblingRow.before(row) : siblingRow.after(row);

        // ✅ ดึงค่า ID ของลำดับใหม่จากทุกแถวในตาราง
        let orderedIds = $("#highlight-table tbody tr").map(function() {
            return $(this).data("id");
        }).get();

        console.log("🔍 Ordered IDs ที่ส่งไป API:", orderedIds); // Debug ตรวจสอบค่า

        // ✅ เรียก API อัปเดต Priority
        $.ajax({
            url: "/highlights/reorder",
            type: "POST",
            data: {
                _token: "{{ csrf_token() }}", // Laravel CSRF Token
                orderedIds: orderedIds // ส่งค่าที่ถูกต้องไปยัง Server
            },
            success: function(response) {
                Swal.fire({
                    position: "center",
                    icon: "success",
                    title: "ลำดับ Priority ถูกอัปเดตแล้ว!",
                    showConfirmButton: false,
                    timer: 1500
                });
            },
            error: function(xhr) {
                console.error("❌ Error Response:", xhr); // Debug ค่าที่ error
                Swal.fire("ผิดพลาด!", "ไม่สามารถอัปเดตลำดับ Priority ได้!", "error");
            }
        });
    });
</script>

<style>
    .priority-handle {
        cursor: grab;
        color: #007bff;
        font-weight: bold;
    }

    .sortable-placeholder {
        background-color: #f8d7da;
        height: 50px;
        border: 2px dashed #dc3545;
    }

    #highlight-table tbody tr {
        transition: all 0.2s ease-in-out;
    }

    #highlight-table tbody tr:hover {
        background-color: #f1f1f1;
    }

    .table {
        table-layout: fixed;
        width: 100%;
    }

    .table th,
    .table td {
        word-wrap: break-word;
        white-space: normal;
        max-width: 200px;
    }

    .container {
        overflow-x: auto;
    }

    .action-buttons {
        display: flex;
        gap: 10px;
        justify-content: center;
    }

    .action-buttons .btn {
        display: flex;
        align-items: center;
        justify-content: center;
        padding: 5px 10px;
        font-size: 14px;
    }


    th:nth-child(7),
    td:nth-child(7) {
        width: 300px;
    }

    td img {
        border-radius: 0 !important;
        width: 100px !important;
        height: auto !important;
        object-fit: cover;
    }
</style>

@endsection