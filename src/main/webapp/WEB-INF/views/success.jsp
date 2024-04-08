<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>결제 결과</title>
<link rel="stylesheet" href="/css/success.css">
</head>
<body>
<input type=hidden id=orderid value="<%=session.getAttribute("session")%>">
<div class="container">
    <c:if test="${isSuccess == true}">
        <h1 class="success">결제 성공</h1>
          <a href="/home">메인으로</a>
        <div class="info">
            <p>주문 상품 : <span id=orderName value="${orderName}">${orderName}</span></p>
            <p>주문 금액 : <span id=amount value="${amount}">${amount}</span></p>
            <p>주문자 : <span id=userid value="${userid}">${userid}</span></p>
            <p>결제 방식 : <span id=method  value="${method}">${method}</span></p>
            <c:if test="${method == '카드'}">
                <p>cardNumber : <span>${cardNumber}</span></p>
            </c:if>
            <c:if test="${method == '가상계좌'}">
                <p>accountNumber : <span>${accountNumber}</span></p>
            </c:if>
            <c:if test="${method == '계좌이체'}">
                <p>bank : <span>${bank}</span></p>
            </c:if>
            <c:if test="${method == '휴대폰'}">
                <p>customerMobilePhone : <span>${customerMobilePhone}</span></p>
            </c:if>
        </div>
    </c:if>
    <c:if test="${isSuccess != true}">
        <h1 class="error">결제 실패</h1>
        <div class="info">
            <p>에러메시지 : <span>${message}</span></p>
            <p>에러코드 : <span>${code}</span></p>
        </div>
    </c:if>
</div>
</body>

<script src='https://code.jquery.com/jquery-latest.js'></script>
<script>

$(document)
.ready(function(){
   orderDelete();
})



//결제 성공시 db추가
function order(){
    $.ajax({
       type:'get',
       url:'/alorder',
       data:{orderName:$('#orderName').text(),amount:$('#amount').text(),userid:$('#userid').text(),method:$('#method').text()},
       dataType:'text',
       success:function(data){
         if (data=='1'){
            alert("주문완료")
         }else{
            alert("주문실패")
         }
       }
    })
 }
 
function orderDelete(){
    $.ajax({
       type:'get',
       url:'/orderDelete',
       data:{orderid:$('#orderid').val()},
       dataType:'text',
       success:function(data){
         if (data=='1'){
            console.log(data)
         }
       }
    })
 }
 
</script>
</html>


