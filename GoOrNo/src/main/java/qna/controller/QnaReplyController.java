package qna.controller;

import javax.servlet.http.HttpServletRequest;
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

import qna.model.QnaBean;
import qna.model.QnaDao;

@Controller
public class QnaReplyController {
	private final String command = "reply.qna";
	private final String getPage = "qnaAdminReplyForm";
	
	@Autowired
	QnaDao qnaDao;
	
	@RequestMapping(value=command, method = RequestMethod.GET)
	public String replyForm(
			Model model,
			HttpSession session,
			@RequestParam(value="orgNo", required = true) int orgNo
			) {
		QnaBean qna = qnaDao.getQnaByNo(orgNo);
		model.addAttribute("org", qna);
		return getPage;
	}
	
	@RequestMapping(value=command, method = RequestMethod.POST)
	public String reply(
				Model model,
				HttpServletRequest request,
				@RequestParam(value="orgNo", required = true) int orgNo,
				@ModelAttribute("qna") @Valid QnaBean qna,
				BindingResult result
			){
		
		if(result.hasErrors()) {
			return getPage;
		}
		
		//줄바꿈 포함해서 DB에 저장되게 설정
		String contents = qna.getContent().replace("\r\n", "<br>");
		qna.setContent(contents);
				
		
		int cnt = qnaDao.insertReply(qna,orgNo);
		System.out.println("답글 삽입 성공 갯수 : "+cnt);
		
		model.addAttribute("isSuccess", "yes");
		return getPage;
	}
	
	
}
