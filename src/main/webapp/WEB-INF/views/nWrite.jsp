<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Q&A</title>
<link rel="stylesheet" href="/css/nWrite.css">
</head>
<body>
<nav>
  <ul>
    <li>무엇이든 물어보살</li>
  </ul>
</nav>

<input type=hidden id=admin value="${sessionScope.admin}">
<% if(session.getAttribute("userid") == null) {%>
<!-- 비회원 보기만 -->
  <div class="post-form">
    <table class="tbl">
      <tr>
        <td style="display:none">
          <input type="text" id="id" value="${board.id}" readonly>
        </td>
      </tr>
      <tr>
        <td>제목: </td>
        <td><input type="text" id="title" value="${board.title}" readonly></td>
      </tr>
      <tr>
        <td>내용: </td>
        <td><textarea rows="10" cols="30" id="cont" readonly>${board.cont}</textarea></td>
      </tr>
      <tr>
        <td>작성자: </td>
        <td><input type="text" id="writer"  value="${board.writer}" readonly></td>
      </tr>
      <tr>
        <td><button id="back" class="button">목록으로</button></td>
      </tr>
    </table>
    <table id=tblanswer1 class="tbl2">
    </table>
  </div>

<%}else{%>
  
    <c:if test="${board.id !=null}">
    <div class="post-form">
    <table class="tbl">
      <tr>
        <td style="display:none">
          <input type="text" id="id" value="${board.id}" >
        </td>
      </tr>
      <c:if test="${sessionScope.userid != board.writer}">
      <tr>
        <td>제목: </td>
        <td><input type="text" value="${board.title}" readonly ></td>
         </tr>
         <tr>
        <td>내용: </td>
        <td><textarea rows="10" cols="30" readonly >${board.cont}</textarea></td>
      </tr>
      </c:if>
      <c:if test="${sessionScope.userid == board.writer}">
      <tr>
        <td>제목: </td>
        <td><input type="text" id="title" value="${board.title}" ></td>
        </tr>
        <tr>
        <td>내용: </td>
        <td><textarea rows="10" cols="30" id="cont" >${board.cont}</textarea></td>
      </tr>
     </c:if>
     <tr>
        <td>작성자: </td>
         <td><input type="text" id="writer"  value="${board.writer}" readonly></td>
      </tr>
      <tr>
        <td><button id="back" class="button">목록으로</button></td>
        <c:if test="${sessionScope.userid == board.writer}">
      <td>
        <button id="end" class="button">수정하기</button>
        <button id="del" class="button">삭제</button>
        </td>
        </c:if>
      </tr>
    </table>
     <table id=tblanswer2 class="tbl2">
    </table>
  </div>
 </c:if>
  
  
  <c:if test="${board.id == null}">
    <div class="post-form">
    <table class="tbl">
      <tr>
        <td style="display:none">
          <input type="text" id="id" value="${board.id}" >
        </td>
      </tr>
      <tr>
        <td>제목: </td>
        <td><input type="text" id="title" value="${board.title}" ></td>
      </tr>
      <tr>
        <td>내용: </td>
        <td><textarea rows="10" cols="30" id="cont"  >${board.cont}</textarea></td>
      </tr>
      <tr>
        <td>작성자: </td>
        <td><input type="text" id="writer"  value="<%=session.getAttribute("userid")%>" readonly ></td>
      </tr>

      <tr>
      <td><button id="end" class="button">추가</button></td>
        <td><button id="back" class="button">목록으로</button></td>
      </tr>

    </table >
     <table id=tblanswer3 class="tbl2">
    </table>
  </div>
  </c:if>
<%}%>
   <c:if test="${sessionScope.admin != null}">
   <button id="answer" class="button">답변 하기</button>
   <input type=text id="answer1" style=display:none;>
   <button id="answerend" style=display:none; class="button">답변 저장</button>
   </c:if>
</body>
<script src='https://code.jquery.com/jquery-latest.js'></script>
<script>

$(document)

.ready(function(){
	answer()
})

//게시글 수정
.on('click','#end',function(){
   $.ajax({
      type:'get',
      url:'/add',
      data:{id:$('#id').val(),title:$('#title').val(),cont:$('#cont').val(),writer:$('#writer').val()},
      dataType:'text',
      success:function(data){
            if(data=='1'){
               alert("작성 및 수정 완료")
               $('#title,#cont,#writer').val('')
               location.href='/QnA'
            }else{
               alert("작성 및 수정 실패")
            }
         }
   })
})

//게시판 글 삭제
.on('click','#del',function(){
   $.ajax({
      type:'get',
      url:'/G_remove',
      data:{id:$('#id').val()},
      dataType:'text',
      success:function(data){
            if(data=='1'){
               alert("삭제 완료")
               $('#title,#cont,#writer,#id').val('')
               location.href='/QnA'
            }else{
               alert("작성 및 수정 실패")
            }
         }
   })
})

//관리자 전용 답변하기클릭
.on('click','#answer',function(){
   $('#answer').hide()
   $('#answer1').show()
   $('#answerend').show()
})



//Q&A 내용칸 작성후  엔터키 활성화
.on('keypress','#cont',function(e,u){
   if(e.keyCode == 13) {$('#end').trigger('click')}
})



//관리자 전용 답변완료하기
.on('click','#answerend',function(){
	$.ajax({ 
		type:'get',
		url:'/G_QnA_AnswerInsert',
		data:{post_id:$('#id').val(),author:$('#admin').val(),content:$('#answer1').val()},
		dataType:'text',
		success:function(data){
			if(data=='1'){
				alert("답변 등록 완료")
				answer()
				$('#answer').show()
				$('#answer1').val('')
 				$('#answer1').hide()
 				$('#answerend').hide()
				}else{
				 alert("답변 등록 실패")
				}
			}
		
 	})
 
})
 
 //답변 작성 후 엔터 활성화
.on('keypress','#answer1',function(e,u){
   if(e.keyCode == 13) {$('#answerend').trigger('click')}
})
 
 
 //QnA이동
.on('click','#back',function(){
   location.href='/QnA'
})


//QnA 답변 삭제
.on('click','#Ans_del',function(){
	$.ajax({
		type:'get',
		url:'/G_QnA_Answerdel',
		data:{id:$(this).parent().parent().find('td:eq(0)').find('#answer_id').val()},
		dataType:'text',
		success:function(data){
			if(data=='1'){
				alert("삭제완료")
				answer()
				$('#answer1').val('')
				return false
			}			
			alert("삭제실패")
		}
	})
})


function answer(){
	$.ajax({ 
		type:'get',
		url:'/G_QnA_Answer',
		data:{id:$('#id').val()},
		dataType:'json',
		success:function(data){
			$('#tblanswer1,#tblanswer2,#tblanswer3').empty()
			for (let i=0;i<data.length;i++){
				let ob = data[i]
				let str='<tr><td><input type=hidden id=answer_id value='+ob['id']+'>'+ob['author']+'</td><td>'+ob['content']+'<c:if test="${sessionScope.admin != null}">'
				+'<button id=Ans_del class="button1">답글 삭제</button></c:if></td></tr>'
				$('#tblanswer1,#tblanswer2,#tblanswer3').append(str)
          }
       }
    })
 }
</script>
</html>