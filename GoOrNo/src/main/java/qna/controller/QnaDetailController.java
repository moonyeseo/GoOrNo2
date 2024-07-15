package qna.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import qna.model.QnaBean;
import qna.model.QnaDao;

@Controller
public class QnaDetailController {
	private final String command = "detail.qna";
	private final String getPage = "qnaDetailView";
	
	@Autowired
	QnaDao qnaDao;
	
	@RequestMapping(value=command)
	public String detail(
			Model model,
			HttpSession session,
			@RequestParam(value="qna_no", required = true) int qna_no,
			@RequestParam(value="isAdmin", required = false) String isAdmin,
			@RequestParam(value="pageNumber", required = false) String pageNumber,
			@RequestParam(value="whatColumn", required = false) String whatColumn,
			@RequestParam(value="keyword", required = false) String keyword
			) {
		
		System.out.println("여기 QnaDetailController");
		
		if(isAdmin == null) { //����� ��û
			qnaDao.updateReadcount(qna_no);
			QnaBean qna = qnaDao.getQnaByNo(qna_no);
			model.addAttribute("qna", qna);
			return getPage;
		}else { //������ ��û
			QnaBean qna = qnaDao.getReplyByOrgNo(qna_no);
			model.addAttribute("qna", qna);
			return "qnaAdminDetailView";
		}
	}
	
}
