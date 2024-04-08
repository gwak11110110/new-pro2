package com.himedia.shopping.DAO;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import com.himedia.shopping.DTO.PersonDTO;
import com.himedia.shopping.DTO.ProductDTO;
import com.himedia.shopping.DTO.SignupDTO;
import com.himedia.shopping.DTO.addProductDTO;
import com.himedia.shopping.DTO.cartDTO;
import com.himedia.shopping.DTO.noticeDTO;

@Mapper
public interface MallDAO {
	//로그인
	int doLogin(String userid, String passwd);
	int adLogin(String userid ,String passwd);
	
	//회원가입
	int save(String p1, String p2, String p3, 
	       String p4, String p5, String p6,String p7); 
	   
	SignupDTO s_view(String userid);
	
	//회원삭제    
	int s_delete(String userid);
	   
	int modify1(String passwd, String passwordcheck, String name, String birth, String email,
	         String phone, String phone2);

	      
	// 아이디 중복 확인(회원가입 ) 
	boolean useridExists(String userid);
	   
	// 이메일 중복 확인(회원가입 ) 
	boolean emailExists(String email);
	    
	
	//Q&A
    ArrayList<PersonDTO> list(); //게시판 목록
    int G_insert(String title,String content,String writer); //추가
    int G_modi(int id,String title,String content,String writer); //수정하기
    int G_remove(int id); //삭제
    PersonDTO G_view(int id); //수정하러 이동
    ArrayList<PersonDTO> G_QnA_AnswerView(int id); //답변들 보기
    int G_QnA_AnswerInsert(int id,String content,String author); //답변 추가
    int G_QnA_Answerdel(int id); // 답변 삭제
	
	// 제품등록
	ArrayList<addProductDTO> addPro();
		
	//제품리스트
	ArrayList<ProductDTO> prolist();
	ProductDTO listal(int p);
	
	// 화면 이미지
	ArrayList<addProductDTO> view();
	
	//상품 검색
	ArrayList<addProductDTO> find(String find);
	
	//제품등록
	int addPro(String p_name, int p_price,
            String description, String image_path, String image_path2,
            String image_path3, String image_path4, String image_path5,
            int product_inventory, String description1, String description2);
	//제품수정
	int modify(int productid, String p_name, int p_price,
				String description, String image_path, String image_path2,
				String image_path3, String image_path4, String image_path5,
				int product_inventory, String description1, String description2);
	//제품삭제
	int remove(int productid);
	
	//공지사항
	ArrayList<noticeDTO> notice();
	   noticeDTO n_view(int id);
	   int insert2(String n_title, String n_cont, String n_image, String n_writer);
	
	//상세페이지
	ArrayList<ProductDTO> dlist();
	
	//장바구니 리스트
	ArrayList<cartDTO> cartList();
	
	//장바구니 추가
	int cartadd(String userid, String p_name, int p_price,
				int amount, int numcnt, String image_path);
	ArrayList<cartDTO> userCartList(String userid);

	//장바구니 삭제
	int cartRemove(int orderid);
	
	int orderDelete(int orderid);
}