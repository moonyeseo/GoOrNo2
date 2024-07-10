package faq.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import faq.model.FaqBean;
import faq.model.FaqDao;

@Controller
public class FaqInsertController {
	private final String command = "insert.faq";
	private final String getPage = "faqWriteForm";
	
	@Autowired
	FaqDao faqDao;
	
	@RequestMapping(value=command, method = RequestMethod.GET)
	public String insertForm() {
		return getPage;
	}
	
	@RequestMapping(value=command, method = RequestMethod.POST)
	public String insert(
				Model model,
				HttpServletRequest request,
				HttpServletResponse response,
				@ModelAttribute("faq") @Valid FaqBean faq,
				BindingResult result
			) throws IOException{
		response.setContentType("text/html; charset=UTF-8");
		
		if(result.hasErrors()) {
			return getPage;
		}
		
		//줄바꿈 포함해서 DB에 저장되게 설정
		String contents = faq.getAnswer().replace("\r\n", "<br>");
		faq.setAnswer(contents);
			
		//글 등록
		int cnt = faqDao.insertFaq(faq);
		System.out.println("삽입 성공 갯수 : "+cnt);
		
		//아웃 객체 생성
		PrintWriter out = response.getWriter();
		
		if(cnt > 0) {
			out.append("<script>alert('등록되었습니다.')</script>");
			//수정되면 부모창 새로고침되도록 변수 설정

			model.addAttribute("isSuccess", "yes");
		}else {
			out.append("<script>alert('등록에 실패하였습니다.')</script>");
		}
		
		return getPage;
	}
	
	
}
