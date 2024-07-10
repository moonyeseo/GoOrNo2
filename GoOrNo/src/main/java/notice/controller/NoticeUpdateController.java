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
		
		//DB에서는 줄바꿈이 <br>로 저장되어 있는게 폼에 그대로 출력되지 않게 다시 변경
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
		
		//줄바꿈 포함해서 DB에 저장되게 설정
		String contents = notice.getContent().replace("\r\n", "<br>");
		notice.setContent(contents);
		
		//제목, 내용만 수정
		int cnt = noticeDao.updateNotice(notice);
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
		contents = notice.getContent().replace("<br>","\r\n");
		notice.setContent(contents);
		
		out.flush();
		
		return getPage;
	}

}
