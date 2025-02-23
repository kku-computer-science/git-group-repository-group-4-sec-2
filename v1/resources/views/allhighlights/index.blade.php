@extends('layouts.layout')

@section('content')
<div class="container">
    <h3>All Highlights</h3>
    <ul>
        @foreach ($highlights as $highlight)
            <li>
                <a href="{{ route('allhighlights.show', $highlight->id) }}">{{ $highlight->title }}</a>
            </li>
        @endforeach
    </ul>
</div>
@endsection
