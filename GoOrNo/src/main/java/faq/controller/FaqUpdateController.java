package faq.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import faq.model.FaqBean;
import faq.model.FaqDao;

@Controller
public class FaqUpdateController {
	private final String command = "update.faq";
	private final String getPage = "faqUpdateForm";

	@Autowired
	FaqDao faqDao;

	@RequestMapping(value = command, method = RequestMethod.GET)
	public String updateForm(
			Model model, 
			@RequestParam(value = "faq_no", required = true) int faq_no
			) {
		
		FaqBean faq = faqDao.getFaqByNo(faq_no);
		
		//DB에서는 줄바꿈이 <br>로 저장되어 있는게 폼에 그대로 출력되지 않게 다시 변경
		String answer = faq.getAnswer().replace("<br>","\r\n");
		faq.setAnswer(answer);
		
		model.addAttribute("faq", faq);
		return getPage;
	}

	@RequestMapping(value = command, method = RequestMethod.POST)
	public String update(
			Model model,
			HttpServletResponse response,
			@ModelAttribute("faq") @Valid FaqBean faq,
			BindingResult result
			) throws IOException {
		response.setContentType("text/html; charset=UTF-8");
		
		if (result.hasErrors()) {
			model.addAttribute("faq", faq);
			return getPage;
		}
		
		//줄바꿈 포함해서 DB에 저장되게 설정
		String answer = faq.getAnswer().replace("\r\n", "<br>");
		faq.setAnswer(answer);
		
		//질문, 답변만 수정
		int cnt = faqDao.updateFaq(faq);
		System.out.println("수정 성공 갯수 : " + cnt);
		
		//아웃 객체 생성
		PrintWriter out = response.getWriter();
		
		if(cnt > 0) {
			out.append("<script>alert('수정되었습니다.')</script>");
			//수정되면 부모창 새로고침되도록 변수 설정
			model.addAttribute("isUpdate", "yes");
		}else {
			out.append("<script>alert('수정에 실패하였습니다.')</script>");
		}
		
		//DB에서는 줄바꿈이 <br>로 저장되어 있는게 폼에 그대로 출력되지 않게 다시 변경
		answer = faq.getAnswer().replace("<br>","\r\n");
		faq.setAnswer(answer);
		
		out.flush();
		
		return getPage;
	}

}
