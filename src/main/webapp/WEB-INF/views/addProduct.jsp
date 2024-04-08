<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 등록</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<link rel="stylesheet" href="/css/addproduct.css">
</head>
<body>
    <form method="post" action="/upload" enctype="multipart/form-data">
        <h1 style="margin-bottom: 20px">상품 등록 - 관리자 페이지</h1>

        <table class="table">
            <tbody>
                <tr>
                    <td><label>상품명</label></td>
                    <td><input type="text" name="p_name" id="p_name" class="form-control"></td>
                </tr>
                <tr>
                    <td><label>가격</label></td>
                    <td><input type="text" name="p_price" id="p_price" class="form-control"></td>
                </tr>
                <tr>
                    <td><label>상세 정보</label></td>
                    <td><textarea name="description" id="description" cols="100" rows="8" class="form-control"></textarea></td>
                </tr>
                <tr>
                	
                    <td><label>이미지 추가</label></td>
                    <td><p>첫 번째 이미지가 메인 이미지입니다.</p>
                        <input type="file" name='file' class="form-control"/>
                        <p>색상 사진 입력해주세요</p>
                        <input type="text" name="description1" id="description1" class="form-control"/>
                        <input type="file" name='file2' class="form-control"/>
                        <p>색상 사진 입력해주세요</p>
                        <input type="text" name="description2" id="description2" class="form-control"/>
                        <input type="file" name='file3' class="form-control"/>
                        
                        <input type="file" name='file4' class="form-control"/>
                        <input type="file" name='file5' class="form-control"/>
                    </td>
                </tr>
<!--                 <tr>
                    <td><label>카테고리</label></td>
                    <td><input type="text" name="category_id" id="category_id" class="form-control"></td>
                </tr> -->
                <tr>
                    <td><label>재고 수</label></td>
                    <td><input type="text" name="product_inventory" id="product_inventory" class="form-control"></td>
                </tr>
            </tbody>
        </table>
        <div>
            <input type="submit" value="등록">
            
        </div>
    </form>
</body>
</html>
