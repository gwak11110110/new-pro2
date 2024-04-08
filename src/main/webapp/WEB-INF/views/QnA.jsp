<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta charset="UTF-8">
<title>QnA</title>
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Single+Day&display=swap&subset=korean&noto.script=Kore">
<link rel="stylesheet" href="/css/QnA.css">
<head>
</head>
<body>
<nav>
  <ul>
    <li>Q n A</li>
  </ul>
</nav>

<div class="post-form">
  <table id="tblge" class="tbl">
    <tr>
      <th><div class="post">제목</div></th>
      <th><div class="post">작성자</div></th>
      <th><div class="post">자세히 보기</div></th>
    </tr>
    <c:forEach var="board" items="${alBoard}">
      <tr>
        <td style="display:none"><input type="text" value="${board.id}"></td>
        <td><p>${board.title}</p></td>
        <td>${board.writer}</td>
      <td><button id=view value="${board.id}" class="button">내용보기</button></td>
      </tr>
    </c:forEach>
  </table>

  <br>

  <c:if test="${sessionScope.userid != null}">
    <button id="write" class="post-form button">새 글 작성</button>
  </c:if>

  <button id="backhome" class="post-form button">홈으로</button>
</div>

</body>
<script src='https://code.jquery.com/jquery-latest.js'></script>
<script>
$(document)


//홈으로
.on('click','#backhome',function(){
   location.href='/'
})

//게시판 보기
.on('click','#view',function(){
	location.href='/nWrite?id='+$(this).val()
})


//게시판 보기2
.on('click','#write',function(){
   location.href='/nWrite'
})


</script>
</html>