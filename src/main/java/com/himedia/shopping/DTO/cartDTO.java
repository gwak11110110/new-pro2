package com.himedia.shopping.DTO;

import lombok.Data;

@Data
public class cartDTO {
	int orderid;
	String userid;
	String p_name;
	String p_price;
	int amount;
	int numcnt;
	String image_path;
}
