package com.himedia.shopping.DTO;

import lombok.Data;

@Data
public class reviewDTO {
   int r_id;
   int p_id;
    String r_title;
    String r_cont;
    String r_writer;
    String created;
    String r_image;
    String r_star;

}