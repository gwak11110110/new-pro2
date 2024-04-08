<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charSet="utf-8"/>
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>���� ����</title>
  <script src="https://js.tosspayments.com/v1/payment-widget"></script>
  <style>
    #payment-button{ width:100%; padding:15px; background-color:#3065AC; color:white; border-radius:3px; font-size:16px; border:none; margin-top:10px}
	.title {margin: 0 0 4px; font-size: 24px; font-weight: 600;color: #4e5968;}
  </style>
</head>
<body>
  <!-- ��ǰ ���� ����-->
  <div class="title">��ǰ ����</div>
  <p>�佺 Ƽ����</p>
  <p>���� �ݾ�: 15,000��</p>
  <form id="discount-coupon">
    <input type="checkbox" id="coupon"/>5,000�� ���ιޱ� 
  </form>
  <hr>	

  <!-- ���� ��� ����-->
  <div class="title">���� ���</div>
  <div id="payment-method"></div>
  <div id="agreement"></div> 
  <button id="payment-button">�����ϱ�</button>
</body>

<script>
  const clientKey = 'test_ck_D5GePWvyJnrK0W0k6q8gLzN97Eoq' // ������ Ư���ϴ� Ű
  const customerKey = 'YbX2HuSlsC9uVJW6NMRMj' // ���� ���� Ư���ϴ� Ű
  const amount = 15_000 // ���� �ݾ�
  const couponAmount = 5_000 // ���� ���� �ݾ�

  /*�������� ���� ������*/
  const paymentWidget = PaymentWidget(clientKey, customerKey) // ȸ�� ����
  // const paymentWidget = PaymentWidget(clientKey, PaymentWidget.ANONYMOUS) // ��ȸ�� ����
  paymentMethods = paymentWidget.renderPaymentMethods('#payment-method', amount)
  
  /*��� ���� ������*/
  const paymentAgreement = paymentWidget.renderAgreement('#agreement')
  
  /*����â ����*/
  document.querySelector("#payment-button").addEventListener("click",()=>{
    paymentWidget.requestPayment({
      orderId: 'AD8aZDpbzXs4EQa-UkIX6',
      orderName: '�佺 Ƽ����',
      successUrl: 'http://localhost:8080/success',
      failUrl: 'http://localhost:8080/fail',
      customerEmail: 'customer123@gmail.com', 
      customerName: '���佺'
      }).catch(function (error) {
          if (error.code === 'USER_CANCEL') {
          // ���� ���� ����â�� �ݾ��� �� ���� ó��
          } if (error.code === 'INVALID_CARD_COMPANY') {
            // ��ȿ���� ���� ī�� �ڵ忡 ���� ���� ó��
          }
      })  
  })

  /*���� ���� ����*/
  document.querySelector("#coupon").addEventListener("click", applyDiscount)
	
  function applyDiscount(e) {
    if (e.target.checked) {
      paymentMethods.updateAmount(amount - couponAmount, "����")
    } else {
      paymentMethods.updateAmount(amount)
    }
  }
</script>
</html>