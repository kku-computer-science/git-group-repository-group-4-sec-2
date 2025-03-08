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
                <!-- <th>ID</th> -->
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
            @foreach ($highlights->sortBy('priority') as $highlight)
            <tr id="highlight-row-{{ $highlight->id }}" data-id="{{ $highlight->id }}" data-priority="{{ $highlight->priority }}">
                <td class="priority-controls">
                    <div class="btn-group-vertical">
                        <button class="btn btn-sm btn-light move-up" data-id="{{ $highlight->id }}"><i class="fas fa-arrow-circle-up"></i></button>
                        <button class="btn btn-sm btn-light move-down" data-id="{{ $highlight->id }}"><i class="fas fa-arrow-circle-down"></i></button>
                    </div>
                </td>
                <!-- <td>{{ $highlight->id }}</td> -->
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
                    <a href="{{ route('highlight.show', $highlight->id) }}" class="btn btn-outline-primary"><i class="fas fa-eye"></i></a>
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
    <!-- <button type="button" class="btn btn-danger mb-3" id="deleteTagBtn">
        ลบ Tag
    </button> -->
    <table id="news-table" class="table table-striped">

        <thead>
            <tr>
                <!-- <th>ID</th> -->
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
                <!-- <td>{{ $highlight->id }}</td> -->
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
                    <a href="{{ route('highlight.show', $highlight->id) }}" class="btn btn-outline-primary"><i class="fas fa-eye"></i></a>
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
    <h2>Tags</h2>
    <a href="#" class="btn btn-primary mb-3" data-bs-toggle="modal" data-bs-target="#createTagModal">+ Create</a>
    <table id="tag-table" class="table table-striped">
        <thead>
            <tr>
                <th>Id</th>
                <th>Tag Name</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            @foreach($tags as $tag)
            <tr id="tag-row-{{ $tag->id }}" data-id="{{ $tag->id }}">
                <td>{{ $tag->id }}</td>
                <td>{{ $tag->name }}</td>
                <td>
                    <button type="button" class="btn btn-outline-primary btn-edit"
                        data-id="{{ $tag->id }}"
                        data-name="{{ $tag->name }}">
                        <i class="fas fa-edit"></i>
                    </button>

                    <button type="button" class="btn btn-danger btn-delete delete-tag-btn" data-id="{{ $tag->id }}"><i class="fas fa-trash-alt"></i></button>
                </td>
            </tr>
            @endforeach
        </tbody>
    </table>
</div>

<!-- Popup สำหรับสร้าง Tag -->
<div class="modal fade" id="createTagModal" tabindex="-1" aria-labelledby="createTagModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <form id="createTagForm">
                <div class="modal-header">
                    <h5 class="modal-title" id="createTagModalLabel">Create Tag</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="mb-3">
                        <label for="tagName" class="form-label">Tag Name</label>
                        <input type="text" class="form-control" id="tagName" name="name" required>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-primary">Save</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Popup สำหรับแก้ไข Tag -->

<div class="modal fade" id="editTagModal" tabindex="-1" aria-labelledby="editTagModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <form id="editTagForm">
                <div class="modal-header">
                    <h5 class="modal-title" id="editTagModalLabel">Edit Tag</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <input type="hidden" id="editTagId" name="id">
                    <div class="mb-3">
                        <label for="editTagName" class="form-label">Tag Name</label>
                        <input type="text" class="form-control" id="editTagName" name="name" required>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-primary">Update</button>
                </div>
            </form>
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

            // Disable ADD buttons if 5 highlights already exist
            if (count >= 5) {
                $(".btn-add").prop("disabled", true);
            } else {
                $(".btn-add").prop("disabled", false);
            }
        }

        // ADD button functionality - move row to Highlights table
        $(document).on("click", ".btn-add", function() {
            let row = $(this).closest("tr");
            let highlightId = $(this).attr("data-id");
            let originalRowId = row.attr("id");

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
                    _token: $('meta[name="csrf-token"]').attr('content') || "{{ csrf_token() }}",
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

                    let newRowHtml = `
                    <tr id="highlight-row-${highlightId}" data-id="${highlightId}" data-priority="${response.priority || 0}">
                        <td class="priority-controls">
                            <div class="btn-group-vertical">
                                <button class="btn btn-sm btn-light move-up" data-id="${highlightId}"><i class="fas fa-arrow-circle-up"></i></button>
                                <button class="btn btn-sm btn-light move-down" data-id="${highlightId}"><i class="fas fa-arrow-circle-down"></i></button>
                            </div>
                        </td>
                        <td>${row.find('td:nth-child(1)').html()}</td>
                        <td>${row.find('td:nth-child(2)').html()}</td>
                        <td>${row.find('td:nth-child(3)').html()}</td>
                        <td>${row.find('td:nth-child(4)').html()}</td>
                        <td>${row.find('td:nth-child(5)').html()}</td>
                        <td>${row.find('td:nth-child(6)').html()}</td>
                        <td>
                            <button type="button" class="btn btn-warning btn-remove" data-id="${highlightId}">REMOVE</button>
                        </td>
                    </tr>`;

                    // ✅ เพิ่มแถวใหม่ไปตารางบน
                    $("#highlight-table tbody").append(newRowHtml);

                    // ✅ ลบแถวออกจากตารางล่างให้ถูกต้อง
                    row.remove();

                    // ✅ อัปเดตจำนวน highlight
                    updateHighlightCount();

                    // ✅ อัปเดต priority
                    updatePriorityOrder();
                },
                error: function(xhr) {
                    console.error("Error response:", xhr);
                    Swal.fire("ผิดพลาด!", "เกิดข้อผิดพลาดบางอย่าง!", "error");
                }
            });
        });

        // REMOVE button functionality - ลบฟังก์ชันซ้ำและรวมเป็นฟังก์ชันเดียว
        $(document).on("click", ".btn-remove", function() {
            let row = $(this).closest("tr");
            let highlightId = $(this).attr("data-id");

            $.ajax({
                url: "/highlights/" + highlightId + "/remove",
                type: "POST",
                data: {
                    _token: $('meta[name="csrf-token"]').attr('content') || "{{ csrf_token() }}",
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

                    // ✅ คัดลอกข้อมูลทุกช่องจากแถวที่ถูก Remove
                    let newNewsRow = `
            <tr id="news-row-${highlightId}">
                <td>${row.find('td:nth-child(2)').html()}</td>  <!-- Image -->
                <td>${row.find('td:nth-child(3)').html()}</td>  <!-- Title -->
                <td>${row.find('td:nth-child(4)').html()}</td>  <!-- Tags -->
                <td>${row.find('td:nth-child(5)').html()}</td>  <!-- Date Time -->
                <td>${row.find('td:nth-child(6)').html()}</td>  <!-- Created By -->
                <td>${row.find('td:nth-child(7)').html()}</td>  <!-- Actions (รวมปุ่ม View, Edit, Delete) -->
                <td>
                    <button type="button" class="btn btn-success btn-add" data-id="${highlightId}">ADD</button>
                </td>
            </tr>`;

                    // ✅ เพิ่มแถวกลับไปที่ตาราง Highlights (ด้านล่าง)
                    $("#news-table tbody").append(newNewsRow);

                    // ✅ ลบแถวออกจากตาราง Show Highlights (ด้านบน)
                    row.remove();

                    // ✅ อัปเดตจำนวน highlight
                    updateHighlightCount();
                },
                error: function(xhr) {
                    console.error("Error response:", xhr);
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
        // Helper function to update priority order after any changes
        function updatePriorityOrder() {
            console.log("-----------2");
            let orderedIds = $("#highlight-table tbody tr").map(function() {
                return $(this).data("id");
            }).get();

            console.log("🔍 ส่งค่าไป API:", orderedIds);

            if (orderedIds.length > 0) {
                console.log("🔍 Updating priority order with IDs:", orderedIds);
                console.log("-----------3");
                $.ajax({
                    url: "/highlights/reorder",
                    type: "POST",
                    data: {
                        _token: $('meta[name="csrf-token"]').attr('content') || "{{ csrf_token() }}",
                        orderedIds: orderedIds
                    },
                    success: function(response) {
                        console.log("Priority order updated successfully");
                    },
                    error: function(xhr) {
                        console.error("❌ Error updating priority order:", xhr);
                    }
                });
            }
        }

        // Move up/down button functionality
        $(document).on("click", ".move-up, .move-down", function() {
            console.log("-----------1");

            let row = $(this).closest("tr");
            let moveUp = $(this).hasClass("move-up");
            let siblingRow = moveUp ? row.prev() : row.next();

            if (siblingRow.length === 0) return; // No row above/below

            // Swap row positions
            moveUp ? siblingRow.before(row) : siblingRow.after(row);

            // Update priority order
            updatePriorityOrder();
        });

        // Initialize
        updateHighlightCount();



        // Initialize DataTables
        $('#highlight-table').DataTable();
        $('#news-table').DataTable();
        $('#tag-table').DataTable();

        // Auto-fade alerts
        setTimeout(function() {
            $(".alert-success").fadeOut("slow");
        }, 2000);
        setTimeout(function() {
            $(".alert-danger").fadeOut("slow");
        }, 2000);

        // Shorten long titles
        $('.table tbody tr').each(function() {
            var titleCell = $(this).find('td:nth-child(3)'); // Title column
            var titleText = titleCell.text().trim();

            if (titleText.length > 100) {
                var shortenedTitle = titleText.substring(0, 100) + '...';
                titleCell.text(shortenedTitle);
            }
        });



        // delete teg
        $(document).ready(function() {
            $(document).on("click", ".delete-tag-btn", function() {
                let tagId = $(this).data("id");

                Swal.fire({
                    title: "คุณแน่ใจหรือไม่?",
                    text: "Tag นี้จะถูกลบและไม่สามารถกู้คืนได้!",
                    icon: "warning",
                    showCancelButton: true,
                    confirmButtonColor: "#d33",
                    padding: "1.25rem",
                    cancelButtonColor: "#3085d6",
                    confirmButtonText: "ใช่, ลบเลย!",
                    cancelButtonText: "ยกเลิก"
                }).then((result) => {
                    if (result.isConfirmed) {
                        $.ajax({
                            url: '/tags/' + tagId,
                            type: 'DELETE',
                            data: {
                                _token: "{{ csrf_token() }}"
                            },
                            success: function(response) {
                                if (response.success) {
                                    Swal.fire({
                                        title: "ลบสำเร็จ!",
                                        text: "Tag ถูกลบเรียบร้อย",
                                        icon: "success",
                                        showConfirmButton: false,
                                        timer: 1500,
                                        padding: '1.25rem'
                                    }).then(() => {
                                        location.reload();
                                    });
                                } else {
                                    Swal.fire({
                                        title: "ไม่สามารถลบได้!",
                                        text: response.message,
                                        icon: "warning",
                                        showConfirmButton: false,
                                        timer: 1500,
                                        padding: '1.25rem'
                                    });
                                }

                            },
                            error: function(xhr) {
                                if (xhr.status === 400) {
                                    Swal.fire({
                                        title: "ไม่สามารถลบได้!",
                                        text: "Tag นี้ถูกใช้งานอยู่ ไม่สามารถลบได้",
                                        icon: "warning",
                                        showConfirmButton: false,
                                        timer: 1500,
                                        padding: '1.25rem'
                                    });
                                } else {
                                    Swal.fire({
                                        title: "Error!",
                                        text: "เกิดข้อผิดพลาด ไม่สามารถลบ Tag ได้",
                                        icon: "error",
                                        showConfirmButton: false,
                                        timer: 1500,
                                        padding: '1.25rem'
                                    });
                                }
                            }
                        });
                    }
                });
            });
        });


        // สร้าง Tag ใหม่
        $('#createTagForm').on('submit', function(e) {
            e.preventDefault();
            var tagName = $('#tagName').val();

            $.ajax({
                type: 'POST',
                url: '{{ route("tags.store") }}',
                data: {
                    name: tagName,
                    _token: '{{ csrf_token() }}'
                },
                success: function(response) {
                    if (response.success) {
                        Swal.fire({
                            icon: 'success',
                            title: 'สร้าง Tag สำเร็จ!',
                            text: 'Tag ใหม่ถูกสร้างเรียบร้อยแล้ว',
                            showConfirmButton: false,
                            timer: 1500
                        }).then(function() {
                            location.reload();
                        });
                    } else {

                        Swal.fire({
                            icon: 'error',
                            title: 'ไม่สามารถสร้าง Tag ได้',
                            text: response.message || 'เกิดข้อผิดพลาดในการสร้าง Tag',
                            showConfirmButton: false,
                            timer: 1500
                        });
                    }
                },
                error: function(xhr, status, error) {

                    Swal.fire({
                        icon: 'error',
                        title: 'เกิดข้อผิดพลาด',
                        text: error || 'เกิดข้อผิดพลาดในการสร้าง Tag',
                        showConfirmButton: false,
                        timer: 1500
                    });
                }
            });
        });


        //เปิด Popup แก้ไข Tag
        $(document).on('click', '.btn-edit', function() {
            var tagId = $(this).data('id');
            var tagName = $(this).data('name');

            $('#editTagId').val(tagId);
            $('#editTagName').val(tagName);

            $('#editTagModal').modal('show');
        });

        // บันทึกการแก้ไข Tag
        $('#editTagForm').on('submit', function(e) {
            e.preventDefault();
            var tagId = $('#editTagId').val();
            var tagName = $('#editTagName').val();

            $.ajax({
                type: 'PUT',
                url: '/tags/' + tagId,
                data: {
                    name: tagName,
                    _token: '{{ csrf_token() }}'
                },
                success: function(response) {
                    if (response.success) {
                        Swal.fire({
                            icon: 'success',
                            title: 'แก้ไข Tag สำเร็จ!',
                            text: 'Tag ถูกแก้ไขเรียบร้อยแล้ว',
                            showConfirmButton: false,
                            timer: 1500
                        }).then(function() {
                            location.reload(); // โหลดหน้าใหม่เมื่อแก้ไขสำเร็จ
                        });
                    } else {
                        Swal.fire({
                            icon: 'error',
                            title: 'ไม่สามารถแก้ไข Tag ได้',
                            text: response.message,
                            showConfirmButton: false,
                            timer: 1500
                        });
                    }
                },
                error: function() {
                    Swal.fire({
                        icon: 'error',
                        title: 'เกิดข้อผิดพลาด',
                        text: 'เกิดข้อผิดพลาดในการแก้ไข Tag',
                    });
                }
            });
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
    #highlight-table td:nth-child(7) {
    white-space: nowrap;
    width: 300px;
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
        margin: 1.25rem;
        padding: 5px 10px;
        font-size: 14px;
    }

    td img {
        border-radius: 0 !important;
        width: 100px !important;
        height: auto !important;
        object-fit: cover;
    }

    #news-table .btn {
        display: inline-block;
        margin-right: 5px;
    }

    #news-table td:nth-child(6) {
        white-space: nowrap;
        width: 300px;
    }

    #highlight-table .btn,
    #news-table .btn {
        padding: 5px 10px;
        font-size: 16px;
        justify-items: center;
    }

    .priority-controls {
        width: 50px;
    }

    .btn-group-vertical {
        display: flex;
        flex-direction: column;
        align-items: center;
        gap: 3px;
    }

    .btn-group-vertical .btn {
        width: 36px;
        height: 36px;
        padding: 6px;
        margin: 0;
    }
    
</style>

@endsection