<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>�α���</title>
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
        <label for="userid" style="font-size: 15px">���̵�</label>
        <div class="underline"></div>
      </div>
    </td>
  </tr>
  <tr>
    <td>
      <div class="input-wrapper">
        <input type="password" id="passwd" name="passwd" required />
        <label for="passwd" style="font-size: 15px">��й�ȣ</label>
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
        <button id="Login">�α���</button>
      </div>
      <div style="text-align: center;">
        <a href="/Signup" style="margin-bottom: 10px;">ȸ������ </a>
        <a href="/home">Ȩ����</a>  
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
            alert("ȸ�� �α��� ����")
            location.href="/"
               $('#userid,#passwd').val('');
         }else if(data=='2'){
            alert("������ �α��� ����")
            location.href="/"
               $('#userid,#passwd').val('');
         }else{
            alert("ȸ���� �ƴմϴ�. ȸ������ ���ּ���")
            $('#userid,#passwd').val('');
         }   
      }
   })
})
</script>
</html>