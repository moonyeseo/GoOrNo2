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
		
		//DB������ �ٹٲ��� <br>�� ����Ǿ� �ִ°� ���� �״�� ��µ��� �ʰ� �ٽ� ����
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
		
		//�ٹٲ� �����ؼ� DB�� ����ǰ� ����
		String answer = faq.getAnswer().replace("\r\n", "<br>");
		faq.setAnswer(answer);
		
		//����, �亯�� ����
		int cnt = faqDao.updateFaq(faq);
		System.out.println("���� ���� ���� : " + cnt);
		
		//�ƿ� ��ü ����
		PrintWriter out = response.getWriter();
		
		if(cnt > 0) {
			out.append("<script>alert('�����Ǿ����ϴ�.')</script>");
			//�����Ǹ� �θ�â ���ΰ�ħ�ǵ��� ���� ����
			model.addAttribute("isUpdate", "yes");
		}else {
			out.append("<script>alert('������ �����Ͽ����ϴ�.')</script>");
		}
		
		//DB������ �ٹٲ��� <br>�� ����Ǿ� �ִ°� ���� �״�� ��µ��� �ʰ� �ٽ� ����
		answer = faq.getAnswer().replace("<br>","\r\n");
		faq.setAnswer(answer);
		
		out.flush();
		
		return getPage;
	}

}
