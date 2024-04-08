<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <title>��ǰ ����Ʈ</title>
    <link rel="stylesheet" type="text/css" href="css/shopping.css">
    <link rel="stylesheet" href="/css/productList.css">
</head>
<body>
<div id="wrap" align="center">
    <h1>��ǰ ����Ʈ - ������ ������</h1>
    <form method="get" action="/productList">
    <table class="list">
        <tr>
            <td colspan="5" style="border: white;">
                <a href="/addProduct" >��ǰ���</a> 	||
                <a href="/home">home</a>
            </td>
        </tr>
        <tr>
            <th>��ȣ</th>
            <th>�̸�</th>
            <th>����</th>
            <th>��� ��</th>
            <th>����</th>
            <th>����</th>
        </tr>
        <c:forEach var="product" items="${alProduct}">
            <tr class="record">
                <td>${product.productid}</td>
                <td>${product.p_name}</td>
                <td>${product.p_price}</td>
                <td >${product.product_inventory}</td>
                <td><a href="/productUpdate?productid=${product.productid}">����</a></td>
                <td><a href="#" class="Del" data-productid="${product.productid}">����</a></td>  
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
        
        if(confirm('������ �����ϰڽ��ϱ�?')){
            let productid = $(this).data('productid');
            $.ajax({
                type: 'post',
                url: '/delete',
                data: { productid: productid },
                dataType: 'text',
                success: function(data){
                    if(data === '1') {
                        alert("���� ����");
                    } else {
                        alert("���� ����");
                    }
                }
            })
        }
    })
  
</script>
</html>
