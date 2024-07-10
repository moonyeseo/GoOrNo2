package notice.controller;

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

import notice.model.NoticeBean;
import notice.model.NoticeDao;

@Controller
public class NoticeUpdateController {
	private final String command = "update.notice";
	private final String getPage = "noticeUpdateForm";

	@Autowired
	NoticeDao noticeDao;

	@RequestMapping(value = command, method = RequestMethod.GET)
	public String updateForm(Model model, HttpSession session, 
			@RequestParam(value = "notice_no", required = true) int notice_no
			) {
		
		NoticeBean notice = noticeDao.getNoticeByNo(notice_no);
		
		//DB������ �ٹٲ��� <br>�� ����Ǿ� �ִ°� ���� �״�� ��µ��� �ʰ� �ٽ� ����
		String contents = notice.getContent().replace("<br>","\r\n");
		notice.setContent(contents);
		
		model.addAttribute("notice", notice);
		return getPage;
	}

	@RequestMapping(value = command, method = RequestMethod.POST)
	public String update(
			Model model,
			HttpServletResponse response,
			@ModelAttribute("notice") @Valid NoticeBean notice,
			BindingResult result
			) throws IOException {
		response.setContentType("text/html; charset=UTF-8");
		
		if (result.hasErrors()) {
			model.addAttribute("notice", notice);
			return getPage;
		}
		
		//�ٹٲ� �����ؼ� DB�� ����ǰ� ����
		String contents = notice.getContent().replace("\r\n", "<br>");
		notice.setContent(contents);
		
		//����, ���븸 ����
		int cnt = noticeDao.updateNotice(notice);
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
		contents = notice.getContent().replace("<br>","\r\n");
		notice.setContent(contents);
		
		out.flush();
		
		return getPage;
	}

}
