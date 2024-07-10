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
		
		//�ٹٲ� �����ؼ� DB�� ����ǰ� ����
		String contents = faq.getAnswer().replace("\r\n", "<br>");
		faq.setAnswer(contents);
			
		//�� ���
		int cnt = faqDao.insertFaq(faq);
		System.out.println("���� ���� ���� : "+cnt);
		
		//�ƿ� ��ü ����
		PrintWriter out = response.getWriter();
		
		if(cnt > 0) {
			out.append("<script>alert('��ϵǾ����ϴ�.')</script>");
			//�����Ǹ� �θ�â ���ΰ�ħ�ǵ��� ���� ����

			model.addAttribute("isSuccess", "yes");
		}else {
			out.append("<script>alert('��Ͽ� �����Ͽ����ϴ�.')</script>");
		}
		
		return getPage;
	}
	
	
}
