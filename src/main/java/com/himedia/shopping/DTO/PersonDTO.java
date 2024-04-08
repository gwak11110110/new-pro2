package com.himedia.shopping.DTO;

import lombok.Data;

@Data
public class PersonDTO {
   
   //QnA
   int id;
   String title;
   String cont;
   String writer;
   String created;
   //QnA답변
   String content;
   String author;
   int post_id;
}