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
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.himedia.shopping.DAO.reviewDAO;
import com.himedia.shopping.DTO.reviewDTO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class reviewController {
   @Autowired
   private reviewDAO rdao;
   
   
   //제품리뷰
    @GetMapping("/review")
    @ResponseBody public String review(HttpServletRequest req) {
    ArrayList<reviewDTO> review = rdao.review(); 
    JSONArray ja = new JSONArray();
    String img = "/image/"; 
       for(int i = 0; i < review.size(); i++) { 
          JSONObject jo = new JSONObject();
          jo.put("r_id", review.get(i).getR_id());  
          jo.put("p_id", review.get(i).getP_id());
          jo.put("r_title", review.get(i).getR_title());
          jo.put("r_cont", review.get(i).getR_cont());
          jo.put("r_star", review.get(i).getR_star());
          jo.put("r_writer", review.get(i).getR_writer());
          jo.put("r_image",img+ review.get(i).getR_image());
          jo.put("created", review.get(i).getCreated()); // 필요한 경우 다른 필드 추가
          ja.add(jo); 
       } 
       System.out.println(ja);
       return ja.toJSONString(); 
    }
  
       
     
     @PostMapping("/doreview")
     public String doreview(@RequestParam ("r_id") String r_id,
           @RequestParam ("p_id") String p_id,
               @RequestParam ("r_title") String r_title,
               @RequestParam ("r_cont") String r_cont,
               @RequestParam("file") MultipartFile file,
               @RequestParam("r_writer") String r_writer,    
               @RequestParam("r_star") int r_star,
               HttpServletRequest req,HttpServletResponse res) throws IOException{
        
              //String r_writer = (String) req.getSession().getAttribute("userid");
               // 현재 시간 생성
               LocalDateTime currentTime = LocalDateTime.now();

               // 현재 시간을 원하는 형식으로 변환하여 문자열로 사용
               DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
               String created = currentTime.format(formatter);
            
            
               System.out.println("r_title" +r_title);
               
               System.out.println("r_cont" +r_cont);

              
               System.out.println("r_writer" +r_writer);
               System.out.println("created" +created); 
                  req.setCharacterEncoding("UTF-8");
                  res.setContentType("text/html; charset=UTF-8");
                  
                  String savePath = "C:\\Users\\1234\\git\\new-pro\\src\\main\\resources\\static\\image";
                  String uploadFolderPath = Paths.get(savePath).toString();
                  System.out.println("uploadFolderPath:" + uploadFolderPath);

                  
                  // 원본 파일 이름 가져오기
                  //String originalFileName = file.getOriginalFilename();
                  String r_image = file.getOriginalFilename();
                  // 덮어쓰기를 방지하기 위해 고유 파일 이름 생성
                  String ori_file_name = System.currentTimeMillis() + "_" + r_image;
                  
                  // 서버에 파일 저장
                  String filePath = Paths.get(uploadFolderPath, ori_file_name).toString();
                 // String filePath = Paths.get(uploadFolderPath,n_image).toString();
                  System.out.println("Uploaded File Path: " + filePath);
//                  String filePath = uploadFolderPath + File.separator + ori_file_name;
                  file.transferTo(new File(filePath));
                  
                  // 추가 로직:
                  System.out.println("Uploaded File Name: " + r_image);
              
                  int n;
                  if (r_id == null || r_id.equals ("")) {         
                      n = rdao.insert(Integer.parseInt(p_id),r_title, r_cont,ori_file_name,r_star,r_writer, created);
                  } else {
                      n = rdao.modify(Integer.parseInt(r_id),Integer.parseInt(p_id),r_title, r_cont, ori_file_name,r_star, r_writer, created);
                  }
                  return "redirect:/review";
               }
     
     
     @GetMapping("/r_write")
      public String r_write() {
         return "r_write";
      }
     @GetMapping("/r_delete")
     public String doDelete(@RequestParam("r_id") String r_id) {
         int n = rdao.remove(Integer.parseInt(r_id));
         System.out.println("affected row=" + n);
         return "redirect:/";
     }
     
     
}