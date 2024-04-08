<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="EUC-KR"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="EUC-KR">
<title>회원가입</title>
<link rel="stylesheet" href="/css/Signup.css">

</head>
<body>
    <div class="container">
        <form method="post" action="/dosignup">
            <h2>Signup</h2>
 
            <div class="input-wrapper">
                  <input type="text" id="userid" name="userid" required />
                <label for="userid" style="font-size: 15px;">로그인 아이디</label>
                <div class="underline"></div>
         	</div>
         	<div class="message-container">
                <div id="errorMessage" style="color: red;"></div>
                <div id="success" style="color: green; "></div>
            </div>
         	
            <div class="input-wrapper">
                <input type="password" id="passwd" name="passwd" required />
                <label for="passwd" style="font-size: 15px">비밀번호</label>
                <div class="underline"></div>
            </div>
            <div class="input-wrapper">
                <input type="password" id="passwordcheck" name="passwordcheck" required />
                <label for="passwordcheck" style="font-size: 15px">비밀번호 확인</label>
                <div class="underline"></div>
            </div>
            <div class="message-container">
             <div id="password-error" style="color: red;"></div><br>
             </div>
            <div class="input-wrapper">
                <input type="text" id="name" name="name" required />
                <label for="name" style="font-size: 15px">실명</label>
                <div class="underline"></div>
            </div>
            <div class="input-wrapper">
                <input type="date" id="birth" name="birth" required style="text-align: center;"/>
                <label for="birth" style="font-size: 15px">생년월일</label>
                <div class="underline"></div>
            </div>
            <div class="input-wrapper">
                <input type="email" id="email" name="email" required />
                <label for="email" style="font-size: 15px">이메일</label>
                <div class="underline"></div>
            </div>
            <div class="message-container">
            	<div id="errorMessage1" style="color: red;"></div>
            	<div id="success1" style="color: green;"></div>
            </div>
            <div class="input-wrapper">
                <input type="tel" id="phone" name="phone" required />
                <label for="phone" style="font-size: 15px">모바일번호</label>
                <div class="underline"></div>
            </div>
            <div>
                <input type="submit" id="sign" value="회원가입" disabled>
            </div>
        </form>
        <a href="/home">홈으로</a>
    </div>
</body>
<script src='http://code.jquery.com/jquery-latest.js'></script>
<script>
document.getElementById('passwordcheck').addEventListener('input', function() {
    password = document.getElementById('passwd').value;
    passwordcheck = document.getElementById('passwordcheck').value;
    errorDiv = document.getElementById('password-error');

    if (password !== passwordcheck) {
        errorDiv.textContent = '비밀번호가 일치하지 않습니다.';
        document.getElementById('sign').disabled = true;
    } else {
        errorDiv.textContent = '';
        document.getElementById('sign').disabled = false;
    }
});

$(document)
   .ready(function(){
         
   $('#userid').blur(function() {
      $.ajax({
          type: 'POST',
          url: '/checkUserid',
          data: {userid: $('#userid').val()},
          success: function(response) {
              if (response=='1') {
                 $('#success').text('');
                  $('#errorMessage').text("아이디가 이미 사용 중입니다.");
                  $('#sign').prop('disabled', true); // 회원가입 버튼 비활성화      
              } else {
                 $('#errorMessage').text("");
                  $('#success').text('사용 가능한 아이디 입니다');
                  $('#sign').prop('disabled', false); // 회원가입 버튼 활성화
              }
          }

         })
     });
   
   $('#email').blur(function() {
         $.ajax({
             type: 'POST',
             url: '/checkEmail',
             data: {email: $('#email').val()},
             success: function(email1) {
                 if (email1=='1') {
                    $('#success1').text('');
                     $('#errorMessage1').text("이미 사용중인 이메일 입니다.");
                     $('#sign').prop('disabled', true); // 회원가입 버튼 비활성화

                 } else {
                    $('#errorMessage1').text("");
                     $('#success1').text('사용 가능한 이메일 입니다');
                     $('#sign').prop('disabled', false); // 회원가입 버튼 활성화

                 }
             }

         })
     });
   
   

});



</script>
</html>