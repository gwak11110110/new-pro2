<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지글작성</title>
<link rel="stylesheet" href="/css/n_write.css">
</head>
<body>
   <div class="container">
        <form method="post" action="/donotice" enctype="multipart/form-data">
            <h2>공지사항 등록</h2>
            <div class="input-wrapper">
                <input type="hidden" id="id" name="id" value="${notice.id}"readonly>
                <div class="underline"></div>
            </div>
            <div class="input-wrapper">
                <input type="text" id="n_title" name="n_title" required />
                <label for="n_title" style="font-size: 15px">제목</label>
                <div class="underline"></div>
            </div>
            <div class="input-wrapper">
    			<textarea id="n_cont" name="n_cont" required></textarea>
    			<label for="n_cont" style="font-size: 15px">내용</label>
   				<div class="underline"></div>
			</div>
            <div class="input-wrapper">
            	<input type="file" id="n_image" name='file'/>
            	<div class="select_img"><img src=""/></div>
            </div>
            <div class="input-wrapper">
                <input type="text" id="n_writer" name="n_writer" required />
                <label for="n_writer" style="font-size: 15px">작성자</label>
                <div class="underline"></div>
            </div>
            <div>
                <input type="submit" id="notice" value="공지등록">
            </div>
        </form>
        <a href="/notice">공지사항리스트</a>
    </div>
</body>
<script src='https://code.jquery.com/jquery-latest.js'></script>
<script>
.select_img {margin:20px 0;}
</script>

</html>