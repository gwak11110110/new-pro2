<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>제품 수정</title>
<link rel="stylesheet" href="/css/productUpdate.css">
</head>
<body>
<div>
    <h1>상품 수정 - 관리자 페이지</h1>
    <form method="post" action="/upload" enctype="multipart/form-data">
        <input type="hidden" name="productid" value="${allist.productid}">
        <div>
            <label for="p_name">상품명</label>
            <input type="text" name="p_name" id="p_name" value="${allist.p_name}">
        </div>
        <div>
            <label for="p_price">가격</label>
            <input type="text" name="p_price" id="p_price" value="${allist.p_price}"> 원
        </div>
        <div>
        	<label for="description1">색상</label>
        	<input type="text" name="description1" id="description1" value="${allist.description1}">
            <input type="text" name="description2" id="description2" value="${allist.description2}">
        </div>
        <div>
            <label for="file">사진(이미지를 다시 넣어주세요)</label>
            <input type="file" name="file">
            <input type="file" name="file2">
            <input type="file" name="file3">
            <input type="file" name="file4">
            <input type="file" name="file5">
        </div>
        <div>
            <label for="description">설명</label>
            <textarea name="description" id="description">${allist.description}</textarea>
            
        </div>
        <div>
            <label for="product_inventory">재고 수</label>
            <input type="text" name="product_inventory" id="product_inventory" value="${allist.product_inventory}">
        </div>
        <div>
            <input type="submit" value="수정">
            <input type="reset" value="다시작성">
            <a href='/productList'>목록</a>
        </div>
    </form>
</div>
</body>
</html>
