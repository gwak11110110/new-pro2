<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="EUC-KR"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="EUC-KR">
<title>ȸ������</title>
<link rel="stylesheet" href="/css/Signup.css">

</head>
<body>
    <div class="container">
        <form method="post" action="/dosignup">
            <h2>Signup</h2>
 
            <div class="input-wrapper">
                  <input type="text" id="userid" name="userid" required />
                <label for="userid" style="font-size: 15px;">�α��� ���̵�</label>
                <div class="underline"></div>
         	</div>
         	<div class="message-container">
                <div id="errorMessage" style="color: red;"></div>
                <div id="success" style="color: green; "></div>
            </div>
         	
            <div class="input-wrapper">
                <input type="password" id="passwd" name="passwd" required />
                <label for="passwd" style="font-size: 15px">��й�ȣ</label>
                <div class="underline"></div>
            </div>
            <div class="input-wrapper">
                <input type="password" id="passwordcheck" name="passwordcheck" required />
                <label for="passwordcheck" style="font-size: 15px">��й�ȣ Ȯ��</label>
                <div class="underline"></div>
            </div>
            <div class="message-container">
             <div id="password-error" style="color: red;"></div><br>
             </div>
            <div class="input-wrapper">
                <input type="text" id="name" name="name" required />
                <label for="name" style="font-size: 15px">�Ǹ�</label>
                <div class="underline"></div>
            </div>
            <div class="input-wrapper">
                <input type="date" id="birth" name="birth" required style="text-align: center;"/>
                <label for="birth" style="font-size: 15px">�������</label>
                <div class="underline"></div>
            </div>
            <div class="input-wrapper">
                <input type="email" id="email" name="email" required />
                <label for="email" style="font-size: 15px">�̸���</label>
                <div class="underline"></div>
            </div>
            <div class="message-container">
            	<div id="errorMessage1" style="color: red;"></div>
            	<div id="success1" style="color: green;"></div>
            </div>
            <div class="input-wrapper">
                <input type="tel" id="phone" name="phone" required />
                <label for="phone" style="font-size: 15px">����Ϲ�ȣ</label>
                <div class="underline"></div>
            </div>
            <div>
                <input type="submit" id="sign" value="ȸ������" disabled>
            </div>
        </form>
        <a href="/home">Ȩ����</a>
    </div>
</body>
<script src='http://code.jquery.com/jquery-latest.js'></script>
<script>
document.getElementById('passwordcheck').addEventListener('input', function() {
    password = document.getElementById('passwd').value;
    passwordcheck = document.getElementById('passwordcheck').value;
    errorDiv = document.getElementById('password-error');

    if (password !== passwordcheck) {
        errorDiv.textContent = '��й�ȣ�� ��ġ���� �ʽ��ϴ�.';
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
                  $('#errorMessage').text("���̵� �̹� ��� ���Դϴ�.");
                  $('#sign').prop('disabled', true); // ȸ������ ��ư ��Ȱ��ȭ      
              } else {
                 $('#errorMessage').text("");
                  $('#success').text('��� ������ ���̵� �Դϴ�');
                  $('#sign').prop('disabled', false); // ȸ������ ��ư Ȱ��ȭ
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
                     $('#errorMessage1').text("�̹� ������� �̸��� �Դϴ�.");
                     $('#sign').prop('disabled', true); // ȸ������ ��ư ��Ȱ��ȭ

                 } else {
                    $('#errorMessage1').text("");
                     $('#success1').text('��� ������ �̸��� �Դϴ�');
                     $('#sign').prop('disabled', false); // ȸ������ ��ư Ȱ��ȭ

                 }
             }

         })
     });
   
   

});



</script>
</html>