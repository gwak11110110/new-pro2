package com.himedia.shopping.DTO;

import lombok.Data;

@Data
public class SignupDTO {
   String userid;
   String passwd;
    String passwordcheck;
    String name;
    String birth;
    String email;
    String phone;
}