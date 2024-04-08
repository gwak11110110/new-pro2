<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>애견용품 판매 쇼핑몰</title>
<link href="https://fonts.googleapis.com/css2?family=Nanum+Pen+Script&display=swap" rel="stylesheet">
<link rel="stylesheet" href="/css/home.css">
</head>
<body>
<nav>
    <ul>
        <li><a href="/notice" class="link">공지사항</a></li>
        <li><strike><a href="#" class="link">신상품</a></strike></li>
        <li><strike><a href="#" class="link">베스트</a></strike></li>
        <li><strike><a href="#" class="link">세일</a></strike></li>
        <li><strike><a href="#" class="link">이벤트</a></strike></li>
    </ul>
</nav>
<div class="logo-container">
		<img alt="logo" src="/image/강아지 logo.png" style="width: 19%; ">
	    <h1>SpringBoot를 활요한 애완동물 쇼핑몰 프로젝트</h1>
	</div>
<nav>
    <div class="login-button-container">
    <c:if test="${sessionScope.admin == null and sessionScope.userid == null}">
        <a href="/" class="inline-flex rounded-md shadow-sm bg-purple-700">
        <a href="#" id="login">
  			<button class="bn54" >
				<span  class="bn54span">로그인</span>
			</button>
		</a>	
        
    </c:if>
    </div>
    <c:if test="${sessionScope.admin != null or sessionScope.userid != null}">
    <div style="font-size: 24px; font-weight: bold; color: #1e1025;">
      <br>  <%=session.getAttribute("userid")%>님 반갑습니다!!<br><br><br>
        <input type="hidden" id="name" value="<%= session.getAttribute("userid") %>">
        </div>
        <button id="logout" class="link">로그아웃</button>
    </c:if>
    <c:if test="${sessionScope.admin == null and sessionScope.userid != null }">
        <button id="changemy" class="link">내 정보 수정</button>
        <button id="cart" class="link">장바구니</button>
    </c:if>
    <c:if test="${sessionScope.admin != null}">
        <button id="plus" class="link">제품 수정 및 등록</button>
    </c:if>
</nav>
<table class="table2">
    <tr>
        <th class="th"><b>애견 용품 추천 상품</b></th>
    </tr>
    <tr>
        <td>
            <div class="divm">
                <div class="div1">
                    상품 검색: 
                    <input type="text" id="serch" placeholder="상품명을 입력하세요">
                    <a href="#" id="serchm" class="btn41-43 btn-42">검색</a>
                    
                </div>
            </div>
            <table class="table3">
                <tr>
                    <td class="link">인기순위</td>
                    <td class="link">판매순위</td>
                    <td class="link">리뷰 많은 순위</td>
                    <td class="link">별점순위</td>
                </tr>
            </table>
            <table id="view" class="table1">
            </table>
        </td>
    </tr>
    <tr>
        <td>
            <div class="div2">
                <a href="/notice" class="link">공지사항</a>
            </div>
        </td>
    </tr>
    <tr>
        <td>
            <div class="div3">
                이벤트 소식
            </div>
        </td>
    </tr>
</table>
</body>
<script src='https://code.jquery.com/jquery-latest.js'></script>
<script>
$(document)

// 시작
.ready(function(){
 view();

})


// 상품등록
.on('click','#plus', function(){
    location.href='/productList'
})

// 상세 페이지 이동
.on('click', '.b', function() {
    let productid = $(this).attr('id');
    location.href = '/detail?productid=' + productid;
})


// 로그인
.on('click','#login', function(){
    location.href='/login'
})


//상품 찾기 엔터키 활성화
.on('keypress','#serch',function(e,u){
   if(e.keyCode == 13) {$('#serchm').trigger('click')}
})

// 상품 찾기
.on('click','#serchm',function(){
   $.ajax({
      type:'get',
      url:'/doserch',
      data:{str:$('#serch').val()},
      dataType:'json',
      beforeSend:function(){
          if($('#serch').val()==""){
             return false;   
          }
       },
      success:function(data){
         $('#view').empty();
            let i=0;
            let j=5;
            let k=0;
            for(i=0;i<data.length;i++){
               let str='<tr>'
               for(k; k<j;k++){
                  if(k==data.length){
                     break;
                  }
                   let bo=data[k];
                   str +='<td><table><tr><td calss="td1" class="b" id='+bo['productid']+'><img src="'+bo['image']+'" style="max-width: 100px; max-height: 100px;"></td></tr><tr><td>'+bo['name']+'</td></tr><tr><td>'+bo['price']+'</td></tr></table></td>'
               }
              str+='</tr>';
               j=j+5;
               $('#view').append(str);
            }
      }
   }) 
})


// 로그아웃
.on('click','#logout', function(){
   $.ajax({
        type:'get',
        url:'/dologout',
        data:{},
        dataType:'text',
        success:function(data){
           if(data=='1'){
              alert("로그아웃 성공")
              location.href='/'
              }
           }
        })
})
//정보수정
.on('click','#changemy',function(){
      $.ajax({
           type:'get',
           url:'/s_update',
           data:{userid:$('#name').val()},
           dataType:'text',
           success:function(data){
              let userid =$('#name').val()
              location.href='/s_update?userid='+userid
                 }
           })
})

//장바구니
.on('click', '#cart', function(){
    let userid = $('#name').val();
    if (userid) {
        location.href = '/cart';
    }
})


// 최초 모든 상품 조회
function view(){
      $.ajax({
         type:'get',
         url:'/doView',
         data:{},
         dataType:'json',
         success:function(data){
            console.log(data)
            $('#view').empty();
            let i=0;
            let j=5;
            let k=0;
            for(i=0;i<data.length;i++){
               let str='<tr>'
               for(k; k<j;k++){
                  if(k==data.length){
                     break;
                  }
                  let bo=data[k];
                  str +='<td><table><tr><td class="b" id='+bo['productid']+'><img src="'+bo['image']+'" style="width: 30%;"></td></tr><tr><td>'+bo['name']+'</td></tr><tr><td>'+bo['price']+'</td></tr></table></td>'
               }
              str+='</tr>';
               j=j+5;
             
               $('#view').append(str);
            }
         }
      })
   }   
</script>
</html>