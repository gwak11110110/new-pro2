<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <title>제품 리스트</title>
    <link rel="stylesheet" type="text/css" href="css/shopping.css">
    <link rel="stylesheet" href="/css/productList.css">
</head>
<body>
<div id="wrap" align="center">
    <h1>상품 리스트 - 관리자 페이지</h1>
    <form method="get" action="/productList">
    <table class="list">
        <tr>
            <td colspan="5" style="border: white;">
                <a href="/addProduct" >상품등록</a> 	||
                <a href="/home">home</a>
            </td>
        </tr>
        <tr>
            <th>번호</th>
            <th>이름</th>
            <th>가격</th>
            <th>재고 수</th>
            <th>수정</th>
            <th>삭제</th>
        </tr>
        <c:forEach var="product" items="${alProduct}">
            <tr class="record">
                <td>${product.productid}</td>
                <td>${product.p_name}</td>
                <td>${product.p_price}</td>
                <td >${product.product_inventory}</td>
                <td><a href="/productUpdate?productid=${product.productid}">수정</a></td>
                <td><a href="#" class="Del" data-productid="${product.productid}">삭제</a></td>  
            </tr>
        </c:forEach>
    </table>
    </form>
</div>
</body>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script>
$(document).ready(function(){
    
})
$('.Del').click(function(){
        
        if(confirm('정말로 삭제하겠습니까?')){
            let productid = $(this).data('productid');
            $.ajax({
                type: 'post',
                url: '/delete',
                data: { productid: productid },
                dataType: 'text',
                success: function(data){
                    if(data === '1') {
                        alert("삭제 성공");
                    } else {
                        alert("삭제 실패");
                    }
                }
            })
        }
    })
  
</script>
</html>
