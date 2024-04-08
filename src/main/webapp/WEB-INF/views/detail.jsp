<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>상세페이지</title>
<link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Nanum+Pen+Script&display=swap" rel="stylesheet">
<link rel="stylesheet" href="/css/detail.css">
</head>
<body style="overflow-y: scroll; ">
   <div class="container">
      <a href="/home" class="btn41-43 btn-42">홈으로</a>
      <form method="post" action="/detailadd" id="detailform" enctype="multipart/form-data">
         <div>
            <input type="hidden" name="userid" value="userid">
            <input type="hidden" name="amount" id="hiddenAmount">
            <input type="hidden" name="image_path" id="hiddenImagePath">
            <input type="hidden" name="p_name" id="hiddenP_name">
            <input type="hidden" name="p_price" id="hiddenP_price">
            <input type="hidden" name="product_inventory" id="hiddenProduct_inventory">
          
         </div>
         <input type="text" id="productid" name="productid" value="${detailProduct.productid}" style="display: none;">
         <div class="details-container">
            <img src="image/${detailProduct.image_path}" alt="이미지1" id="productImage" style="max-width: 40%; margin-right: auto; border: 1px solid; border-radius: 5px;">
            <div class="text-details">
               <h3>${detailProduct.p_name}</h3>
               <p class="product-price"><span>${detailProduct.p_price}원</span></p>
               <br>
               <div style="font-size: 12px;">
                  <p><strong style="color: gray">배송비 &nbsp;</strong> 모든 상품 배송비 무료</p>
                  <p><strong style="color: gray">배송비예정일 &nbsp;</strong> 1~2일 이내</p>
                  <p><strong style="color: gray">반품/교환 &nbsp;</strong> 수령 후 반품/교환 불가능</p>
               </div>
               <label class="numcnt">수량</label><br>
               <input type=number name=numcnt id = numcnt value="1" min="1"max="5" style="width: 50%; "placeholder="1"/>
               <div class="buttons-container">
                  <a href="#" id="cartbtn" style="55%;"  class="btn41-43 btn-42">장바구니</a>
               </div>
            </div>
         </div>
         <hr>
         <div id="button_link">
          <a href="#" id="p_detail" >상세페이지</a>
          <a href="#" id="p_review">리뷰</a>
          <c:if test="${sessionScope.userid != null}">
          <a href="#" id="p_rwrite">리뷰작성</a>
          </c:if>
      </div>
         <hr>
         <div class="image-gallery">
            <div>
               <p class="font-styleP" style="text-align: center;">${detailProduct.description}</p>
               <p class="font-styleP" style="text-align: center;"> <${detailProduct.description1}></p>
               <img src="image/${detailProduct.image_path2}" alt="이미지2">
               <p class="font-styleP" style="text-align: center;"> <${detailProduct.description2}></p>
               <img src="image/${detailProduct.image_path3}" alt="이미지3"><br>
               <img src="image/${detailProduct.image_path4}" alt="이미지4">
               <img src="image/${detailProduct.image_path5}" alt="이미지5">
            </div>
         </div>
       <div class="review-gallery" style="display: none;">
             <div id="reviewList"></div>   
      </div>
        <div class="r_write-gallery">
             <h2>리뷰를 작성해 주세요~</h2>

             <div>
                 <input type="hidden" id="r_id" name="r_id" value="${review.r_id}" readonly>
                 <div class="underline"></div>
             </div>
            <div>
                 <input type="hidden" id="p_id" name="p_id"  readonly>
                 <div class="underline"></div>
             </div>
             <div>
              <div>하트를 선택해주세요</div>
              <div>
              <input type="hidden" id="r_star" name="r_star" value="${review.r_star}" />
                  <span  class="star" data-value="1">♥</span>
                  <span  class="star" data-value="2">♥</span>
                  <span  class="star" data-value="3">♥</span>
                  <span  class="star" data-value="4">♥</span>
                  <span  class="star" data-value="5">♥</span>
              </div>
             </div>
       
             <div>
                 <input type="text" id="r_title" name="r_title" required />
                 <label for="r_title" style="font-size: 15px">제목</label>
                 <div class="underline"></div>
             </div>
             <div>
                 <textarea id="r_cont" name="r_cont" required></textarea>
                 <label for="r_cont" style="font-size: 15px">내용</label>
                 <div class="underline"></div>
             </div>
             <div>
                 <input type="file" id="r_image" name='file' />
                 <div class="select_img"><img src="" /></div>
             </div>
             <div>
                 <input type="text" id="r_writer" name="r_writer" value="${sessionScope.userid}" readonly />
                 <label for="r_writer" style="font-size: 15px">작성자</label>
                 <div class="underline"></div>
  
             </div>
             <div>
                 <button id="submitReview">리뷰등록하기</button>
             </div>
             </div>
      </form>
      
      <div class="box-area">
         <p>© 개똥이네</p>
         <p>여러분의 만족을 위해 항상 노력하는 ○○○쇼핑몰입니다.</p>
         <p>문의사항이 있으시면 언제든지 연락주세요.</p>
         <p>010-0000-1111</p>
      </div>
</div>
</body>

<script src='https://code.jquery.com/jquery-latest.js'></script>
<script>
$(document).ready(function() {
    let image_path = $("#productImage").attr("src");
    let p_name = $(".text-details h3").text();
    let p_price = $(".product-price span").text().replace(/[^0-9]/g, '');
    let numcnt = $("#numcnt").val();
    let amount = p_price * numcnt;

    console.log("image_path:", image_path);
    console.log("p_name:", p_name);
    console.log("p_price:", p_price);
    console.log("numcnt:", numcnt);
    console.log("amount:", amount);
   
   
    
    // 장바구니 버튼 클릭 이벤트 처리
    $('#cartbtn').on('click', function() {
        let image_path = $("#productImage").attr("src");
        let p_name = $(".text-details h3").text();
        let p_price = $(".product-price span").text().replace(/[^0-9]/g, '');
        let numcnt = $("#numcnt").val();
        let amount = p_price * numcnt;

        $('#hiddenAmount').val(amount);
        $('#hiddenImagePath').val(image_path);
        $('#hiddenP_name').val(p_name);
        $('#hiddenP_price').val(p_price);

        $('#detailform').submit();

        console.log("image_path:", image_path);
        console.log("p_name:", p_name);
        console.log("p_price:", p_price);
        console.log("numcnt:", numcnt);
        console.log("amount:", amount);  
    });

    // 상세 페이지 링크와 리뷰 링크 클릭 이벤트 처리
    $('#p_detail').on('click', function(event) { 
        event.preventDefault();
        $('.image-gallery').show();
        $('.review-gallery').hide();
        $('.r_write-gallery').hide();
    });
    
    //상품리뷰보기
    $('#p_review').on('click', function(event) { 
        event.preventDefault();

        $('.review-gallery').show();
        $('.image-gallery').hide();
        $('.r_write-gallery').hide();
        
        //윈도우에서 url에 있는 id 가져오기 
        const urlParams = new URLSearchParams(window.location.search);
        const productid = urlParams.get('productid');
      
        $.ajax({
            url: '/review', // 쇼핑몰 리뷰를 가져올 URL
            type: 'GET',
            dataType: 'json', // 응답 데이터 타입은 JSON
            data: { p_id:$('#productid').val() }, // p_id 전달
            success: function(response) {
                // 가져온 JSON 데이터를 처리하여 리뷰 목록을 생성
                
                 // 이전에 추가된 리뷰 목록을 비움
                $('#reviewList').empty();
                let rList= '';  
                
                $.each(response, function(index, review) {
                    if (review.p_id == productid) {
                    rList += '<div class="review-item">';
                    rList += '<div>작성자: ' + review.r_writer + '</div>';
                    rList += '<div>하트뿅뿅: ';
                    for (let i = 0; i < review.r_star; i++) {
                         rList += '<span style="color:pink ;font-size: 30px">♥</span>';
                    }
                    rList += '</div>';
            
                    rList += '<div>제목: ' + review.r_title + '</div>';
                    rList += '<div>내용: ' + review.r_cont + '</div>';
                    
                    rList += '<div><img src="' + review.r_image + '" class="review-image"></div>';
                    rList += '<div>작성일자: ' + review.created + '</div>';
                    // 리뷰 삭제 버튼 추가
                    if (review.r_writer === '<%= session.getAttribute("userid") %>' || '<%= session.getAttribute("userid") %>' === 'admin') {
                        rList += '<button class="delete-review" data-review-id="' + review.r_id + '">리뷰 삭제</button>';
                    }
   
                    rList += '</div>';
                }
            });
                
            // 생성된 리뷰 목록을 표시할 요소에 추가
            $('#reviewList').append(rList);
            
            $('.delete-review').on('click', function() {
                var reviewId = $(this).data('review-id');
                let pdiv=$(this).parent();
                //if (confirm("정말로 지우시겠습니까?")) {
                    $.ajax({
                        type: 'get',
                        url: '/r_delete',
                        data: {r_id : reviewId},
                        dataType: 'text',
                        success: function(data) {    
                            if (data = '1') {
                               alert('리뷰를 삭제완료했습니다');   
                               pdiv.remove();
                            } else { 
                                alert('삭제 실패');   
                            }
                        }
                    });
                //}
            });
            
            
            },
            error: function(xhr, status, error) {
                  console.error(error);
           }
       });
   });
    
    
    //상품리뷰작성
    $('#p_rwrite').on('click', function(event) { 
        
        event.preventDefault(); // 링크의 기본 동작을 중지
        $('.review-gallery').hide();
        $('.image-gallery').hide();
        $('.r_write-gallery').show();
        
        
    });
    
    // 별점을 선택할 때 이벤트 리스너 추가
    
    $('.star').click(function() {
          $('.star').html('♡'); // 선택한 요소 안의 내용을 가져오거나, 다른 내용으로 바꿈
        $(this).html('♥').prevAll().html('♥'); // 클릭한 별을 채우고 그 앞의 별들도 채움

        //$('.star').removeClass('selected'); // 모든 별에서 선택 표시 제거
        $(this).addClass('selected'); // 클릭한 별에 선택 표시 추가
        $('#r_star').val($(this).data('value')); // 선택한 별표의 값을 hidden input에 저장
    });

    
    //리뷰등록하기
    
    $('#submitReview').click(function (e) {
        e.preventDefault(); //이벤트의 기본 동작을 중지하는 JavaScript 메서드
 
        var formData = new FormData();
        formData.append('r_id', $('#r_id').val());
        formData.append('p_id', $('#productid').val()); 
        formData.append('r_title', $('#r_title').val());
        formData.append('r_cont', $('#r_cont').val());
        formData.append('file', $('#r_image')[0].files[0]);
        formData.append('r_writer', $('#r_writer').val());
        // 별점 값 가져오기
        r_star = $('.star.selected').data('value');

        formData.append('r_star', r_star);
        console.log("r_star:",r_star);
        $.ajax({
            url: '/doreview',
            type: 'POST',
            data: formData,
            processData: false,
            contentType: false,
            success: function (response) {
                alert('리뷰가 성공적으로 등록되었습니다.');
                // 리뷰를 성공적으로 등록한 후 원하는 동작을 수행할 수 있습니다.
                // 예를 들어, 리뷰 목록을 새로 고침하는 등의 동작을 수행할 수 있습니다.
                location.reload(); // 페이지 새로 고침
            },
            error: function (xhr, status, error) {
                alert('리뷰 등록에 실패했습니다.');
                console.error(error);
            }
        });
    });
    

    
    
    
});




</script>

</html> 