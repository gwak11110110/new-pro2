package com.himedia.shopping.DAO;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import com.himedia.shopping.DTO.noticeDTO;

@Mapper
public interface noticeDAO {
   //공지사항
   ArrayList<noticeDTO> notice();
   noticeDTO n_view(int id);

   int remove(int parseInt);


   int insert2(String n_title, String n_cont, String ori_file_name, String n_writer, String created);
   int modify(Integer id, String n_title, String n_cont, String ori_file_name, String n_writer, String created);
}