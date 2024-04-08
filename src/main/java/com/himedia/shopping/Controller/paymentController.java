package com.himedia.shopping.Controller;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import jakarta.servlet.http.HttpServletRequest;

import com.himedia.shopping.DAO.paymentsDAO;

@RestController
public class paymentController {

    @Autowired
    private paymentsDAO pdao;

    //주문 성공시 서버내 테이블에 저장
    @GetMapping("/alorder")
    @ResponseBody
    public String alOrder(HttpServletRequest req){
       String orderName = req.getParameter("orderName");
       String amount = req.getParameter("amount");
       String userid = req.getParameter("userid");
       String method = req.getParameter("method");
       int n = pdao.addpayments(userid, orderName,Integer.parseInt(amount), method);
       
       return ""+n;
       
    }
}
