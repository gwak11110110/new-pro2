<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>공지사항</title>
<link rel="stylesheet" href="/css/notice.css">
</head>
<body>

<nav>
   <ul>
       <li><a href="/notice" class="link">notice</a></li>
       <li><a href="/QnA" class="link">QnA</a></li>
       <li><a href="/" class="link">자주묻는 질문</a></li>
       <li><a href="/" class="link">홈으로</a></li>
    </ul>
</nav>

<table id="tblnotice">
  <thead>
    <tr>
      <th>게시물</th>
      <th>내용</th>
      <th>작성자</th>
      <th>등록시간</th>
      <th> <c:if test="${sessionScope.admin != userid}">
      수정 및 삭제
      </c:if></th>
    </tr>
  </thead>
  <tbody>
    <c:forEach var="notice" items="${alnotice}">
      <tr>
        <td><a href="/n_view?id=${notice.id}">no:${notice.id}</a></td>
        <td><a href="/n_view?id=${notice.id}" target="_blank">${notice.n_title}</a></td>
        <td><a href="/n_view?id=${notice.id}">${notice.n_writer}</a></td>
        <td>${notice.created}</td>
        <td class="actions">
          <c:if test="${sessionScope.admin != null}">
            <a href="/n_update?id=${notice.id}">수정</a>
            <a href="/n_delete?id=${notice.id}">삭제</a>
          </c:if>
        </td>
      </tr>
    </c:forEach>
  </tbody>
</table>

<h4>
   <c:if test="${sessionScope.admin != null}">
       <a href="/n_write">공지사항 등록</a>
     </c:if>
    <a href="/">홈으로</a>
</h4>

</body>
</html>