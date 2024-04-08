package com.himedia.shopping.DAO;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface paymentsDAO {
	int addpayments(String userid,String orderName, int amount, String paymentMethod);
	
	
}