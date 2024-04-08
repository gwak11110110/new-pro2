<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰페이지</title>
<link rel="stylesheet" href="/css/r_write.css">
</head>
<body>
   <div class="container">
        <form method="post" action="/doreview" enctype="multipart/form-data">
            <h2>리뷰등록</h2>
            <div class="input-wrapper">
                <input type="hidden" id="r_id" name="r_id" value="${review.r_id}"readonly>
                <div class="underline"></div>
            </div>
            <div class="input-wrapper">
                <input type="text" id="r_title" name="r_title" required />
                <label for="r_title" style="font-size: 15px">제목</label>
                <div class="underline"></div>
            </div>
            <div class="input-wrapper">
             <textarea id="r_cont" name="r_cont" required></textarea>
             <label for="r_cont" style="font-size: 15px">내용</label>
               <div class="underline"></div>
         </div>
            <div class="input-wrapper">
               <input type="file" id="r_image" name='file'/>
               <div class="select_img"><img src=""/></div>
            </div>
            <div class="input-wrapper">
             
                <input type="text" id="r_writer" name="r_writer" value="${sessionScope.userid}"readonly />
                <label for="r_writer" style="font-size: 15px">작성자</label>
                <div class="underline"></div>
                
            </div>
         
              
            <div>
                <input type="submit" id="review" value="리뷰등록하기">
            </div>
        </form>
        <a href="/">홈</a>
    </div>
</body>
<script src='https://code.jquery.com/jquery-latest.js'></script>
<script>
.select_img {margin:20px 0;}
</script>


</html>