<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>로그인</title>
<link rel="stylesheet" href="/css/login.css">
</head>
</head>
<body> 
  
<table>

  <tr>
    <td colspan="2"><h2>Login</h2></td>
  </tr>
  <tr>
    <td>      
      <div class="input-wrapper">
        <input type="text" id="userid" name="userid" required />
        <label for="userid" style="font-size: 15px">아이디</label>
        <div class="underline"></div>
      </div>
    </td>
  </tr>
  <tr>
    <td>
      <div class="input-wrapper">
        <input type="password" id="passwd" name="passwd" required />
        <label for="passwd" style="font-size: 15px">비밀번호</label>
        <div class="underline"></div>
      </div>
    </td>
  </tr>
  <tr>
    <td>
    </td>
  </tr>
  <tr>
    <td>
      <div class="button-container">
        <button id="Login">로그인</button>
      </div>
      <div style="text-align: center;">
        <a href="/Signup" style="margin-bottom: 10px;">회원가입 </a>
        <a href="/home">홈으로</a>  
      </div>      
      	
    </td>
  </tr>
</table>

</body>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script>
$(document)
.on('click','#signup',function(){
   location.href='/Signup'
})

.on('keypress','#passwd',function(e,u){
   if(e.keyCode == 13) {$('#Login').trigger('click')}
})


.on('click','#Login',function(){
   $.ajax({
      type:'get',
      url:'/dologin',
      data:{userid:$('#userid').val(),passwd:$('#passwd').val()},
      dataType:'text',
      success:function(data){
         if(data=='1'){
            alert("회원 로그인 성공")
            location.href="/"
               $('#userid,#passwd').val('');
         }else if(data=='2'){
            alert("관리자 로그인 성공")
            location.href="/"
               $('#userid,#passwd').val('');
         }else{
            alert("회원이 아닙니다. 회원가입 해주세요")
            $('#userid,#passwd').val('');
         }   
      }
   })
})
</script>
</html>