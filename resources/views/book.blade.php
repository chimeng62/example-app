<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <ol>
        <!-- Step 3: loop through arr sent from index method in BookController -->

        @foreach ($books as $book)
            <li>{{$book->title}}</li>  
        @endforeach
    </ol>
</body>
</html>