<!DOCTYPE html>

<html>

<head>

    <script src="http://code.jquery.com/jquery-1.10.2.js"></script>

        <script>

        $(document).ready(function (event){

        $(window).scroll(function(){

        

        var scrollHeight = $(window).scrollTop() + $(window).height();

        var documentHeight = $(document).height();

        

        //스크롤이 맨아래로 갔는지 아닌지 확인하는 if문

        if(scrollHeight == documentHeight){

        for(var i = 0; i < 10; i++){

        $('<h1>Infinity Scroll11</h1>').appendTo('body');

        }      

        }

        

        });

        });

        

        //테스트를 위해 내부에 공간을 채워서 스크롤을 임의로 만듬

        $(document).ready(function(){

        for(var i = 0; i < 20; i++){

        $('<h1>infinity scroll</h1>').appendTo('body');

        }      

        });

        

    </script>

</head>

<body>

        <div>

        <p>지금 내 생각을</p>

        <h1>150</h1>

        <textarea cols="70" rows="5"></textarea>

        </div>

</body>

</html>