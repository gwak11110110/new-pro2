package com.himedia.shopping.Controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.himedia.shopping.DAO.MallDAO;
import com.himedia.shopping.DAO.noticeDAO;
import com.himedia.shopping.DAO.paymentsDAO;
import com.himedia.shopping.DTO.PersonDTO;
import com.himedia.shopping.DTO.ProductDTO;
import com.himedia.shopping.DTO.SignupDTO;
import com.himedia.shopping.DTO.addProductDTO;
import com.himedia.shopping.DTO.cartDTO;
import com.himedia.shopping.DTO.noticeDTO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


@Controller
public class MallController {
	
	
	@Autowired
	private MallDAO mdao;
	
	@Autowired
	private noticeDAO ndao;
	
	@Autowired
	private paymentsDAO pdao;
	
	@GetMapping("/") 
	public String home() {
		return "home";
	}
	@GetMapping("/home")
	public String doHome() {
		return "home";
	}
	
	@GetMapping("/login")
	public String showlogin() {
	    return "login";
	}
	
	@GetMapping("/ex")
	public String doEx() {
		return "ex";
	}
	
	@GetMapping("/addProduct")
	public String doAddProduct() {
		return "addProduct";
	}
	
	@GetMapping("/cart")
	public String doCart() {
		return "cart";
	}
	@GetMapping("/n_write")
    public String n_write() {
       return "n_write";
    }
	
	
    @GetMapping("/dologin")
    @ResponseBody
    public String doLogin(HttpServletRequest req, Model model) {
       String userid = req.getParameter("userid");
       String passwd = req.getParameter("passwd");
       int n =0;
       if(userid==null||userid.equals("")) {
          n = 0;
       }else {
          n=mdao.adLogin(userid,passwd);
          HttpSession sess = req.getSession();
          sess.setAttribute("userid", userid);
          if(n==0) {
             n=mdao.doLogin(userid,passwd);
             return ""+n;
          }
          sess.setAttribute("admin", userid);
          model.addAttribute("admin",userid); 
          return "2";
       }
       return "0";
    }
	   //로그아웃
       @GetMapping("/dologout")
       @ResponseBody
       public String dologout(HttpServletRequest req) {
          HttpSession sess=req.getSession();
          sess.invalidate();
          return "1";
       }
       
       // 회원가입
       @GetMapping("/Signup")
       public String Signup() {
          return "Signup";
       }

       @PostMapping("/dosignup")
       public String doSignup(HttpServletRequest req, Model model) {
          String userid = req.getParameter("userid");
          String passwd = req.getParameter("passwd");
          String passwordcheck = req.getParameter("passwordcheck");
          String name = req.getParameter("name");
          String birth = req.getParameter("birth");
          String email = req.getParameter("email");
          String phone = req.getParameter("phone");
          if (userid.equals("") || userid == null) {
             return "redirect:/Signup";
          }

           int n;
           // 사용자 ID는 한 번만 확인하면 됨
           if (mdao.useridExists(userid)) {
               n = mdao.modify1(userid, passwd, passwordcheck, name, birth, email, phone);
              if (n > 0) {
                  return "redirect:/";
              } else {
                  return "redirect:/Signup";
              }
           } else {
               n = mdao.save(userid, passwd, passwordcheck, name, birth, email, phone);
              if (n > 0) {
                  return "redirect:/signupsuccess";
              } else {
                  return "redirect:/Signup";
              }
           }

           
       }
       
       @GetMapping("/signupsuccess")
       public String signupsuccess() {
          
          return "signupsuccess";
       }

       @GetMapping("/s_update")
       public String s_update(HttpServletRequest req, Model model) {
          String userid = req.getParameter("userid");
          SignupDTO sdto = mdao.s_view(userid);
          model.addAttribute("signup", sdto);
          return "s_update";
       }
       @GetMapping("/s_delete")
       public String s_delete(HttpServletRequest req) {
          String userid = req.getParameter("userid");
          int n = mdao.s_delete(userid);
          System.out.println("affacted row="+n);
          HttpSession sess=req.getSession();
          sess.invalidate();
          return "redirect:/";   
       }

       @PostMapping("/checkUserid")
       @ResponseBody
       public String checkUserid(HttpServletRequest req, Model model) {
          String userid = req.getParameter("userid");
          boolean exists = mdao.useridExists(userid);
          // 응답 데이터 생성
          String response;
          if (exists) {
             // 아이디가 이미 존재하는 경우
             response = "1";
          } else {
             // 아이디가 존재하지 않는 경우
             response = "0";
          }
          System.out.println(response);
          return response;

       }

       @PostMapping("/checkEmail")
       @ResponseBody
       public String checkEmail(HttpServletRequest req, Model model) {
          String email = req.getParameter("email");
          boolean exists = mdao.emailExists(email);
          // 응답 데이터 생성
          String email1;
          if (exists) {
             // 이미 존재하는 경우
             email1 = "1";
          } else {
             // 존재하지 않는 경우
             email1 = "0";
          }
          System.out.println(email1);
          return email1;

       }
	   
	   //Q&A
	   @GetMapping("/doList")
	   @ResponseBody
	   public String doList(){
	      ArrayList<PersonDTO> aList = mdao.list();
	      JSONArray ja = new JSONArray();
	      for(int i=0;i<aList.size();i++) {
	         JSONObject jo= new JSONObject();
	         jo.put("title",aList.get(i).getTitle());
	         jo.put("con",aList.get(i).getCont());
	         jo.put("writer",aList.get(i).getWriter());
	         jo.put("created",aList.get(i).getCreated());
	         ja.add(jo);
	      }
	      return ja.toJSONString();
	   }
	   
	   
	   @GetMapping("/doWR")
	   public String doWR() {
	      return "doWR";
	   }
	   //QnA답변보기
       @GetMapping("/G_QnA_Answer")
       @ResponseBody
       public String G_QnA_Answer(HttpServletRequest req) {
          String id = req.getParameter("id");
           ArrayList<PersonDTO> alanswer  = mdao.G_QnA_AnswerView(Integer.parseInt(id));
           JSONArray ja = new JSONArray();
           for(int i=0;i<alanswer.size();i++) {
              JSONObject jo= new JSONObject();
              jo.put("id",alanswer.get(i).getId());
              jo.put("author",alanswer.get(i).getAuthor());
              jo.put("content",alanswer.get(i).getContent());
              ja.add(jo);
           }
           return ja.toJSONString();
       }
       
       //QnA 답변 추가
       @GetMapping("/G_QnA_AnswerInsert")
       @ResponseBody
       public String G_QnA_AnswerInsert(HttpServletRequest req) {
         String post_id = req.getParameter("post_id");
          String content=req.getParameter("content");
          String author=req.getParameter("author");
          int n=0;
          if(content.equals("") || content==null) {
             n=0;
             }else {
             n= mdao.G_QnA_AnswerInsert(Integer.parseInt(post_id),author,content);
             }
             return ""+n;
       }
       
       //QnA 답변 삭제
       @GetMapping("/G_QnA_Answerdel")
       @ResponseBody
       public String G_QnA_Answerdel(HttpServletRequest req) {
          String id = req.getParameter("id");
          int n=mdao.G_QnA_Answerdel(Integer.parseInt(id));
          return ""+n;
       }
	   
	   // 제품등록
	   @GetMapping("/Product")
	   @ResponseBody
	   public String Product() {
	      ArrayList<addProductDTO> alProduct = mdao.addPro();
	         JSONArray ja = new JSONArray();
	         for(int i=0;i<alProduct.size();i++) {
	            JSONObject jo= new JSONObject();
	            jo.put("productid",alProduct.get(i).getProductid());
	            jo.put("p_name",alProduct.get(i).getP_name());
	            jo.put("p_price",alProduct.get(i).getP_price());
	            jo.put("description",alProduct.get(i).getDescription());
	            jo.put("product_inventory",alProduct.get(i).getProduct_inventory());
	            jo.put("description1",alProduct.get(i).getDescription1());
	            jo.put("description2",alProduct.get(i).getDescription2());
	            ja.add(jo);
	         }
	         return ja.toJSONString();
	      }
	   
	   	//제품 리스트 관리자 페이지
	    @GetMapping("/productList")
	    public String showProductList(Model model) {
	        ArrayList<ProductDTO> alProduct = mdao.prolist();
	        model.addAttribute("alProduct", alProduct);
	        return "productList";
	    }
		
		 //제품 수정
		 @GetMapping("/productUpdate") 
		 public String doProductUpdate(@RequestParam("productid") int productid, Model model) {
			 ProductDTO allist = mdao.listal(productid);
			model.addAttribute("allist",allist); 
		 return "productUpdate"; 
		 }
         
	     @GetMapping("/detail")
	       public String detail(@RequestParam(value="productid", required=false) String productid,
	                            HttpServletRequest req, HttpServletResponse res, Model model) {
	           ArrayList<ProductDTO> dProduct = mdao.dlist();
	           ProductDTO selectedProduct = null;
	           for (ProductDTO product : dProduct) {
	               if (Integer.toString(product.getProductid()).equals(productid)) {
	                   selectedProduct = product;
	                   break;
	               }
	           }
	           if (selectedProduct != null) {
	               model.addAttribute("detailProduct", selectedProduct);
	           }
	           
	           return "detail";
	     }
	     @PostMapping("/detailadd")
	     public String doCartadd(HttpServletRequest req) {
	    	 HttpSession session = req.getSession(false);
	    	 String userid = (session != null) ? (String) session.getAttribute("userid") : null;

	    	 if (userid == null || userid.equals("")) {
	    	     return "redirect:/login";
	    	 }
	    	 
	    	 String p_name = req.getParameter("p_name");
	    	 String p_price = req.getParameter("p_price");
	    	 String numcnt = req.getParameter("numcnt");
	    	 String amount = req.getParameter("amount");
	    	 String image_path = req.getParameter("image_path");

	    	 ArrayList<cartDTO> alcart = mdao.cartList();
	    	 System.out.println("userid:"+userid);
	    	 System.out.println("p_name:"+p_name);
	    	 System.out.println("p_price:"+p_price);
	    	 System.out.println("numcnt:"+numcnt);
	    	 System.out.println("amount:"+amount);
	    	 System.out.println("image_path:"+image_path);
	    	 int n = mdao.cartadd(userid, p_name, Integer.parseInt(p_price),
	    			 		Integer.parseInt(amount), Integer.parseInt(numcnt),image_path);
	    	 
	         return "redirect:/cart";
	     }
	     
	     //장바구니
	     @PostMapping("/cartrev")
	     @ResponseBody
	     public String doCartrev(HttpServletRequest req) {
	    	 HttpSession session = req.getSession();
	    	 String userid = (String) session.getAttribute("userid");
	    	 ArrayList<cartDTO> alcart = mdao.userCartList(userid);
	    	 JSONArray ja = new JSONArray();
	    	 for (int i = 0; i < alcart.size(); i++) {
	    	     JSONObject jo = new JSONObject();
	    	     jo.put("orderid", alcart.get(i).getOrderid());
	    	     jo.put("userid", alcart.get(i).getUserid());
	    	     jo.put("p_name", alcart.get(i).getP_name());
	    	     jo.put("p_price", alcart.get(i).getP_price());
	    	     jo.put("numcnt", alcart.get(i).getNumcnt());
	    	     jo.put("amount", alcart.get(i).getAmount());
	    	     jo.put("image_path", alcart.get(i).getImage_path());
	    	     ja.add(jo);
	    	 }
	    	 System.out.println(ja);
	    	 return ja.toJSONString();
	     }
	     
	     //장바구니삭제
	     @PostMapping("/CartRemove")
	     @ResponseBody
	     public String doCartRemove(HttpServletRequest req) {
	    	 String orderid = req.getParameter("orderid");
	    	 System.out.println("orderid:" + orderid);
	    	 int n = mdao.cartRemove(Integer.parseInt(orderid));
	    	 return ""+n;
	     }
			
	     //주문 성공시 서버내 오더테이블 삭제
	     @GetMapping("/orderDelete")
	     @ResponseBody
	     public String orderDelete(HttpServletRequest req){ 
	    	 String orderids = req.getParameter("orderid"); 
	    	 String[] orderid = null;
	    	 int n=0;
			 orderid = orderids.split(",");
			 for (int i = 0; i < orderid.length; i++) {
				 n=mdao.orderDelete(Integer.parseInt(orderid[i])); 
			 }
			 return ""+n;
	     }
			 
			 
	     //장바구니 아이디 세션등록
         @PostMapping("/doSession")
         @ResponseBody
         public String doSession(HttpServletRequest req,Model model) {
             // 단일 문자열로 받기
             String sessions1 = req.getParameter("session");
             String[] sessions = null;
             if(sessions1 != null && !sessions1.equals("")) {
                 sessions = sessions1.split(",");
                 String str="";       
                 for (int i = 0; i < sessions.length; i++) {
                    if (i==sessions.length-1) {
                       str+=sessions[i];
                       break;
                    }
                    str+=sessions[i]+",";
                 }
                     HttpSession sess = req.getSession();
                    sess.setAttribute("session",str); 
             }
             return "1";
         }

			 

//	   //장바구니 아이디 세션등록
//	   @PostMapping("/doSession")
//	   @ResponseBody
//	   public String doSession(HttpServletRequest req) {
//	       // 단일 문자열로 받기
//	       String sessions = req.getParameter("session");
//	       if(sessions != null && !sessions.equals("")) {
//	           HttpSession sess = req.getSession();
//	           sess.setAttribute("session", sessions);
//	       } 
//	        System.out.println(sessions);
//	        return "1";
//	   }
//	        
//	      
//	   //주문 성공시 서버내 오더테이블 삭제 
//	   @GetMapping("/orderDelete")
//	   @ResponseBody 
//	   public String orderDelete(HttpServletRequest req){ 
//		   String orderid = req.getParameter("orderid"); 
//		   String[] orderidArray = orderid.split(","); 
//		   int n = 0; 
//		   for(int i = 0; i < orderidArray.length; i++){
//			   n = mdao.orderDelete(Integer.parseInt(orderidArray[i])); 
//		   }
//		   return "" + n;
//	   }
	          

		 //제품삭제
		 @PostMapping("/delete")
		 public String doRemove(HttpServletRequest req) {
				String productid = req.getParameter("productid");
				System.out.println("productid=" + productid);
				int n = mdao.remove(Integer.parseInt(productid));
				return "" + n;
		}
	   
	     //시작 페이지&이미지
         @GetMapping("/doView")
         @ResponseBody
         public String doView(){
            ArrayList<addProductDTO> aList = mdao.view();
            JSONArray ja = new JSONArray();
            String k="/image/" ;
            for(int i=0;i<aList.size();i++) {
               JSONObject jo= new JSONObject();
               jo.put("productid",aList.get(i).getProductid());
               jo.put("image",k+aList.get(i).getImage_path());
               jo.put("image2",k+aList.get(i).getImage_path2());
               jo.put("image3",k+aList.get(i).getImage_path3());
               jo.put("image4",k+aList.get(i).getImage_path4());
               jo.put("image5",k+aList.get(i).getImage_path5());
               jo.put("name",aList.get(i).getP_name());
               jo.put("price",aList.get(i).getP_price());
               jo.put("category",aList.get(i).getCategory_id());
               ja.add(jo);
            }
            
            return ja.toJSONString();
         }
         
         //상품 찾기
         @GetMapping("/doserch")
         @ResponseBody
         public String doSerch(HttpServletRequest req) {
            String serch=req.getParameter("str");
            String nSerch="%"+(serch)+"%";
            String k="/image/" ;
             ArrayList<addProductDTO> find = mdao.find(nSerch);
             JSONArray ja = new JSONArray();
             for(int i=0;i<find.size();i++) {
                JSONObject jo= new JSONObject();
                jo.put("productid",find.get(i).getProductid());
                jo.put("image",k+find.get(i).getImage_path());
                jo.put("price",find.get(i).getP_price());
                jo.put("name",find.get(i).getP_name());
                ja.add(jo);
             }
             return ja.toJSONString();
         }
         
         
         
	      
	      //제품 이미지 등록
	      @PostMapping("/upload")
	      public String doUpload(@RequestParam(value="productid", required=false) String productid,
	    		  				 @RequestParam("p_name") String p_name,
	                             @RequestParam("p_price") String p_price,
	                             @RequestParam("description") String description,
	                             @RequestParam("file") MultipartFile file,
	                             @RequestParam("file2") MultipartFile file2,
	                             @RequestParam("file3") MultipartFile file3,
	                             @RequestParam("file4") MultipartFile file4,
	                             @RequestParam("file5") MultipartFile file5,
	                             @RequestParam("product_inventory") String product_inventory,
	                             @RequestParam("description1") String description1,
	                             @RequestParam("description2") String description2,
	                             HttpServletRequest req, HttpServletResponse res) throws IOException {
	    	  
	    	  if (file == null || file2 == null || file3 == null || file4 == null || file5 == null || p_name == null || p_name.equals("")) {
	    		        return "redirect:/addProduct";
	    	  } else {
		          String[] imagePaths = {file.getOriginalFilename(), file2.getOriginalFilename(), file3.getOriginalFilename(), file4.getOriginalFilename(), file5.getOriginalFilename()};
	
		          req.setCharacterEncoding("UTF-8");
		          res.setContentType("text/html; charset=UTF-8");
	
		          String savePath = "C:\\Users\\1234\\git\\new-pro\\src\\main\\resources\\static\\image";
		          String uploadFolderPath = Paths.get(savePath).toString();
	
		          String[] fileNames = new String[5];
		          MultipartFile[] files = {file, file2, file3, file4, file5};
		          for (int i = 0; i < files.length; i++) {
		              if (!files[i].equals("")) {
		                  String image_path = files[i].getOriginalFilename();
		                  String ori_file_name = System.currentTimeMillis() + "_" + image_path;
		                  String filePath = Paths.get(uploadFolderPath, ori_file_name).toString();
		                  files[i].transferTo(new File(filePath));
		                  fileNames[i] = ori_file_name;
		                  System.out.println("Uploaded File Name " + (i + 1) + ": " + ori_file_name);
		                  System.out.println("Uploaded File Path " + (i + 1) + ": " + filePath);
		              }
		          }
		          int n;
		          if(productid == null||productid.equals("")) {
		        	  n = mdao.addPro(p_name, Integer.parseInt(p_price),
			                  description, fileNames[0], fileNames[1], fileNames[2], fileNames[3], fileNames[4],
			                  Integer.parseInt(product_inventory), description1, description2);  
		          } else {
		        	  n = mdao.modify(Integer.parseInt(productid), p_name, Integer.parseInt(p_price), description, 
		        			  fileNames[0], fileNames[1], fileNames[2], fileNames[3], fileNames[4],
			                  Integer.parseInt(product_inventory), description1, description2);
		          }
		          return "redirect:/productList";
	    	  }
	      }
	      
	       //공지사항
          @GetMapping("/notice")
          public String notice(Model model) {
             ArrayList<noticeDTO> alnotice = ndao.notice();
             model.addAttribute("alnotice",alnotice);
             return "notice";   
          }
          @PostMapping("/donotice")
          public String donotice(@RequestParam ("id") String id,
                @RequestParam ("n_title") String n_title,
                @RequestParam ("n_cont") String n_cont,
                @RequestParam("file") MultipartFile file,
                @RequestParam("n_writer") String n_writer,    
                HttpServletRequest req,HttpServletResponse res) throws IOException{
   
              
                // 현재 시간 생성
                LocalDateTime currentTime = LocalDateTime.now();

                // 현재 시간을 원하는 형식으로 변환하여 문자열로 사용
                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
                String created = currentTime.format(formatter);
             
             
                System.out.println("n_title" +n_title);
                
                System.out.println("n_cont" +n_cont);
               
                System.out.println("n_writer" +n_writer);
                System.out.println("created" +created); 
                   req.setCharacterEncoding("UTF-8");
                   res.setContentType("text/html; charset=UTF-8");
                   
                   String savePath = "C:\\Users\\1234\\git\\new-pro\\src\\main\\resources\\static\\image";
                   String uploadFolderPath = Paths.get(savePath).toString();
                   System.out.println("uploadFolderPath:" + uploadFolderPath);

                   
                   // 원본 파일 이름 가져오기
                   String n_image = file.getOriginalFilename();
                   // 덮어쓰기를 방지하기 위해 고유 파일 이름 생성
                   String ori_file_name = System.currentTimeMillis() + "_" + n_image;
                   
                   // 서버에 파일 저장
                   String filePath = Paths.get(uploadFolderPath, ori_file_name).toString();
                   System.out.println("Uploaded File Path: " + filePath);
                   file.transferTo(new File(filePath));
                   
                   // 추가 로직:
                   System.out.println("Uploaded File Name: " + n_image);
               
                   int n;
                   if (id == null || id.equals ("")) {         
                       n = ndao.insert2(n_title, n_cont,ori_file_name, n_writer, created);
                   } else {
                       n = ndao.modify(Integer.parseInt(id),n_title, n_cont, ori_file_name, n_writer, created);
                   }
                   return "redirect:/notice";
                }
          
          
          
 
          
          @GetMapping("/n_view")
          public String n_view(@RequestParam("id")int id,Model model) {
                noticeDTO ndto=ndao.n_view(id);
             model.addAttribute("notice",ndto);
             return "n_view";
          }
         @GetMapping("/n_delete")
         public String doDelete(HttpServletRequest req) {
           String id= req.getParameter("id");
           int n =ndao.remove(Integer.parseInt(id));
           System.out.println("affacted row="+n);
           return "redirect:/notice";   
         }
         @GetMapping("/n_update")
         public String n_update(@RequestParam("id") int id,Model model) {
           noticeDTO ndto=ndao.n_view(id);
           model.addAttribute("notice",ndto);
           return "n_update";
         }
         
        //QNA페이지
        @GetMapping("/QnA")
         public String Qna(HttpServletRequest req,Model model){
              ArrayList<PersonDTO> aList = mdao.list();
              model.addAttribute("alBoard",aList);
            return "QnA";
         }




           //QNA수정시 글보기
           @GetMapping("/nWrite")
           public String nWrite(HttpServletRequest req,Model model){
              String id=req.getParameter("id");
              if(id!=null && !id.equals("")) {
                 PersonDTO mdto = mdao.G_view(Integer.parseInt(id));
                 model.addAttribute("board",mdto);
              }
              return "nWrite";
           }




           //QnA 추가 및 수정
           @GetMapping("/add")
           @ResponseBody
           public String doAdd(HttpServletRequest req) {
              String id = req.getParameter("id");
              String title=req.getParameter("title");
              String cont=req.getParameter("cont");
              String writer=req.getParameter("writer");
              int n=0;
              if(id==null || id.equals("")) {
                 n = mdao.G_insert(title,cont,writer);
              }else {
                 n = mdao.G_modi(Integer.parseInt(id),title,cont,writer);
                 }

              return ""+n;
           }


           //QnA삭제
           @GetMapping("/G_remove")
           @ResponseBody
           public String G_delete(HttpServletRequest req) {
              String id = req.getParameter("id");
              int x = mdao.G_remove(Integer.parseInt(id));
              return ""+x;
           }
           
}
