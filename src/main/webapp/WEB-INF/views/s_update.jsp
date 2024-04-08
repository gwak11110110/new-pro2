<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보업데이트</title>
<link rel="stylesheet" href="/css/s_update.css">

</head>
<body>
    <div class="container">
        <form method="post" action="/dosignup" enctype="multipart/form-data">
            <h2>회원정보업데이트</h2>
 
            <div class="input-wrapper">
                  <input type="text" id="userid" name="userid" value="${signup.userid}" readonly />
         </div>
            <div class="input-wrapper">
                <input type="text" id="passwd" name="passwd" value="${signup.passwd}" required />
                <div class="underline"></div>
            </div>
            <div class="input-wrapper">
                <input type="text" id="passwordcheck" name="passwordcheck" value="${signup.passwordcheck}" required />
                <div class="underline"></div>
            </div>
             <div id="password-error" style="color: red;"></div><br>
            <div class="input-wrapper">
                <input type="text" id="name" name="name" value="${signup.name}" required />
                <div class="underline"></div>
            </div>
            <div class="input-wrapper">
                <input type="date" id="birth" name="birth" value="${signup.birth}" required style="text-align: center;" />
                <div class="underline"></div>
            </div>
            <div class="input-wrapper">
                <input type="email" id="email" name="email" value="${signup.email}" readonly />
                <div class="underline"></div>
            </div>
            <div class="input-wrapper">
                <input type="tel" id="phone" name="phone" value="${signup.phone}" required />
                <div class="underline"></div>
            </div>
            <div>
                <input type="submit" id="sign" value="회원정보수정">
                <input type="submit" id="lnkdelete" value="회원정보삭제">
            </div>
        </form>
        <a href="/s_update?userid=${signup.userid}">회원정보 확인</a>
         <a href="/">메인페이지로 이동</a>
    </div>
</body>
<script src='http://code.jquery.com/jquery-latest.js'></script>
<script>
document.getElementById('passwordcheck').addEventListener('input', function() { //이벤트를 등록하는 방식 addEventListener
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

document.getElementById('lnkdelete').addEventListener('click', function(event) {
   event.preventDefault(); // 기본 동작 방지
    confirmation = confirm('정말로 회원을 탈퇴하시겠습니까?');
    if (confirmation) {
          userId = document.getElementById('userid').value;
        fetch('/s_delete?userid=' + userId, {
            method: 'GET'
        })
          .then(response => {
       if (response.ok) {
           // 응답이 성공적으로 도착했을 때 처리할 코드
            console.log('회원 탈퇴가 완료되었습니다.');
           alert('회원 탈퇴가 완료되었습니다.');
           location.href = '/'; // 페이지 이동
       } else {
           // 응답이 실패했을 때 처리할 코드
           alert('회원 탈퇴에 실패하였습니다.');
       }
   })
    }else {
        // 회원 탈퇴를 취소한 경우 아무것도 하지 않음
        console.log('회원 탈퇴가 취소되었습니다.');
        alert('회원 탈퇴가 취소되었습니다.');
    }
});




</script>
</html>