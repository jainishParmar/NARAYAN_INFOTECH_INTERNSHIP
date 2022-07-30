<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor" crossorigin="anonymous">

</head>



<body>
    <div class="container">
        <form action="{{url('/') }}/up" method="POST" enctype="multipart/form-data">
            @csrf  
            <div class="mb-3">
              <label for="exampleInputEmail1" class="form-label">item _name</label>
              <input type="text" class="form-control" name="item_name" id="exampleInputEmail1" aria-describedby="emailHelp">
        </div> 
            <div class="mb-3">
              <label for="exampleInputPassword1" class="form-label">price</label>
              <input type="text" class="form-control" name="price" id="exampleInputPassword1">
            </div>
            <div class="mb-3">
                <label for="exampleFormControlTextarea1" class="form-label">Example textarea</label>
                <textarea class="form-control" name="desc" id="exampleFormControlTextarea1" rows="3"></textarea>
              </div>
              <div class="mb-3">
                <label for="exampleInputPassword1" class="form-label">type_id</label>
                <input type="number" class="form-control" name="tid" id="exampleInputPassword1">
              </div>
              <div class="mb-3">
                <label for="exampleInputPassword1" class="form-label">Password</label>
                <input type="file"   class="form-control" name="img1" id="exampleInputPassword1">
              </div>
              <div class="mb-3">
                <label for="exampleInputPassword1" class="form-label">Password</label>
                <input type="file" class="form-control" name="img2" id="exampleInputPassword1">
              </div>
              <div class="mb-3">
                <label for="exampleInputPassword1" class="form-label">Password</label>
                <input type="file" class="form-control"name="img3" id="exampleInputPassword1">
              </div>
              <div class="mb-3">
                <label for="ex ampleInputPassword1" class="form-label">Password</label>
                <input type="file" class="form-control" name="img4" id="exampleInputPassword1">
              </div>
              <div class="mb-3">
                <label for="exampleInputPassword1" class="form-label">Password</label>
                <input type="file" class="form-control" name="img5" id="exampleInputPassword1">
              </div>
            
            <button type="submit" class="btn btn-primary">Submit</button>
          </form>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-pprn3073KE6tl6bjs2QrFaJGz5/SUsLqktiwsUTF55Jfv3qYSDhgCecCxMW52nD2" crossorigin="anonymous"></script>

</body>
</html>