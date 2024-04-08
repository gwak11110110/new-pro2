package com.himedia.shopping.DAO;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import com.himedia.shopping.DTO.reviewDTO;

@Mapper
public interface reviewDAO {

   ArrayList<reviewDTO> review();

   int insert( int p_id,String r_title, String r_cont, String ori_file_name, int r_star, String r_writer, String created);

   int modify(int parseInt, int p_id, String r_title, String r_cont, String ori_file_name,int r_star, String r_writer, String created);

int remove(int parseInt);

}