@extends('dashboards.users.layouts.user-dash-layout')

@section('content')
<div class="container">
    @if ($message = Session::get('success'))
    <div class="alert alert-success">{{ $message }}</div>
    @endif
<<<<<<< HEAD
    <div class="card" style="padding: 16px;">
        <div class="card-body">
            <h4 class="card-title">Manage Highlights</h4>
            <a href="{{ route('highlights.create') }}" class="btn btn-primary btn-menu btn-icon-text btn-sm mb-3">
                <i class="mdi mdi-plus btn-icon-prepend"></i> ADD
            </a>
            <!-- <div class="table-responsive"> -->
            <table id="example1" class="table table-striped">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Image</th>
                        <th>Title</th>
                        <th>Category</th>
                        <th>Date Time</th>
                        <th>Create By</th>
                        <th>Action</th>
                        <th>Remove Form Highlights</th>
                    </tr>
                </thead>

                <tbody>

                </tbody>

            </table>
            <table id="example2" class="table table-striped">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Image</th>
                        <th>Title</th>
                        <th>Category</th>
                        <th>Date Time</th>
                        <th>Create By</th>
                        <th>Action</th>
                        <th>Add to Highlights</th>
                    </tr>
                </thead>

                <tbody>

                </tbody>

            </table>
            <!-- </div> -->
        </div>
    </div>

=======
>>>>>>> main

    <!-- ตาราง Highlights -->
    <h2>Highlights</h2>
    <table id="example1" class="table table-striped">
        <thead>
            <tr>
                <th>ID</th>
                <th>Image</th>
                <th>Title</th>
                <th>Category</th>
                <th>Date Time</th>
                <th>Created By</th>
                <th>Action</th>
                <th>Remove from Highlight</th>
            </tr>
        </thead>
        <tbody>
            @foreach ($highlights as $highlight)
            <tr>
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
                    {{ optional($highlight->user)->fname_th ?? 'Unknown' }}
                    {{ optional($highlight->user)->lname_th ?? '' }}
                </td>
                <td>
                    <a href="{{ route('highlights.edit', $highlight->id) }}" class="btn btn-outline-primary">
                        <i class="fas fa-edit"></i>
                    </a>
                </td>
                <td>
                    <form action="{{ route('highlights.remove', $highlight->id) }}" method="POST">
                        @csrf @method('PUT')
                        <button type="submit" class="btn btn-danger">REMOVE</button>
                    </form>
                </td>
            </tr>
            @endforeach
        </tbody>
    </table>

    <!-- ตาราง News -->
    <h2>News</h2>
    <a href="{{ route('highlights.create') }}" class="btn btn-primary mb-3">+ Create</a>
    <table id="example2" class="table table-striped">
        <thead>
            <tr>
                <th>ID</th>
                <th>Image</th>
                <th>Title</th>
                <th>Category</th>
                <th>Date Time</th>
                <th>Created By</th>
                <th>Action</th>
                <th>Add to Highlight</th>
            </tr>
        </thead>
        <tbody>
            @foreach ($news as $highlight)
            <tr>
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
                    {{ optional($highlight->user)->fname_th ?? 'Unknown' }}
                    {{ optional($highlight->user)->lname_th ?? '' }}
                </td>
                <td>
                    <a href="{{ route('highlights.edit', $highlight->id) }}" class="btn btn-outline-primary">
                        <i class="fas fa-edit"></i>
                    </a>
                </td>
                <td>
                    <form action="{{ route('highlights.add', $highlight->id) }}" method="POST">
                        @csrf @method('PUT')
                        <button type="submit" class="btn btn-success">ADD</button>
                    </form>
                </td>
            </tr>
            @endforeach
        </tbody>
    </table>
</div>
<<<<<<< HEAD
<script src="https://code.jquery.com/jquery-3.3.1.js"></script>
<script src="http://cdn.datatables.net/1.10.18/js/jquery.dataTables.min.js" defer></script>
<script src="https://cdn.datatables.net/1.12.0/js/dataTables.bootstrap4.min.js" defer></script>
<script src="https://cdn.datatables.net/fixedheader/3.2.3/js/dataTables.fixedHeader.min.js" defer></script>
<script>
=======
>>>>>>> main

<script src="https://code.jquery.com/jquery-3.3.1.js"></script>
<script src="http://cdn.datatables.net/1.10.18/js/jquery.dataTables.min.js" defer></script>
<script src="https://cdn.datatables.net/1.12.0/js/dataTables.bootstrap4.min.js" defer></script>
<script>
    $(document).ready(function() {
        $('#example1').DataTable();
        $('#example2').DataTable();
    });
</script>
@endsection