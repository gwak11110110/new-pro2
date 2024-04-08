<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Notice</title>
    <link rel="stylesheet" href="/css/n_view.css">
</head>
<body>
    <div id="tblnotice">
        <table>
            <tr>
                <td><h4><a href="#">번호: ${notice.id}</a></h4></td>
            </tr>
            <tr>
                <td><h4><a href="#">제목: ${notice.n_title}</a></h4></td>
            </tr>
            <tr>
                <td><p class="underline">공지사항:</p>
                 <p>${notice.n_cont.replaceAll("\\n", "<br>")}</p></td>
            </tr>
            <tr>
                <td><img src="image/${notice.n_image}"></td>
            </tr>
            <tr>
                <td><p>작성자: ${notice.n_writer}</p></td>
            </tr>
        </table>
    </div>
</body>
</html>
<h4><a href="/notice">목록으로</a>&nbsp;&nbsp;
 <c:if test="${sessionScope.admin != null}">
 <a href="/n_update?id=${notice.id}">수정</a>&nbsp;&nbsp;
<a href="/n_delete?id=${notice.id}">삭제</a>&nbsp;&nbsp;</h4>
 </c:if>
</body>
</html>