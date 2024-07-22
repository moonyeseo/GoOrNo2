package notice.controller;

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

import notice.model.NoticeBean;
import notice.model.NoticeDao;

@Controller
public class NoticeInsertController {
	private final String command = "insert.notice";
	private final String getPage = "noticeWriteForm";
	
	@Autowired
	NoticeDao noticeDao;
	
	@RequestMapping(value=command, method = RequestMethod.GET)
	public String insertForm() {
		return getPage;
	}
	
	@RequestMapping(value=command, method = RequestMethod.POST)
	public String insert(
				Model model,
				HttpServletRequest request,
				HttpServletResponse response,
				@ModelAttribute("notice") @Valid NoticeBean notice,
				BindingResult result
			) throws IOException{
		response.setContentType("text/html; charset=UTF-8");
		
		if(result.hasErrors()) {
			return getPage;
		}
		
		//�ٹٲ� �����ؼ� DB�� ����ǰ� ����
		String contents = notice.getContent().replace("\r\n", "<br>");
		notice.setContent(contents);
			
		//�۵��
		int cnt = noticeDao.insertNotice(notice);
		System.out.println("insertNotice cnt : "+cnt);
		
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
