package qna.controller;

import java.io.IOException;

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
import users.model.UsersBean;

@Controller
public class QnaUpdateController {
	private final String command = "update.qna";
	private final String getPage = "qnaUpdateForm";
	private final String gotoPage = "redirect:/detail.qna";

	@Autowired
	QnaDao QnaDao;

	@RequestMapping(value = command, method = RequestMethod.GET)
	public String updateForm(Model model, HttpSession session, 
			@RequestParam(value = "qna_no", required = true) int qna_no,
			@RequestParam(value="isAdmin", required = false) String isAdmin,
			@RequestParam(value = "pageNumber", required = false) String pageNumber,
			@RequestParam(value = "whatColumn", required = false) String whatColumn,
			@RequestParam(value = "keyword", required = false) String keyword) {
		if(isAdmin == null) {
			UsersBean mb = (UsersBean) session.getAttribute("loginInfo");
			if (mb == null) { // 로그인x
				model.addAttribute("keyword", keyword);
				model.addAttribute("pageNumber", pageNumber);
				model.addAttribute("whatColumn", whatColumn);
				
				String destination = "redirect:/update.qna?qna_no=" + qna_no + "&pageNumber=" + pageNumber + "&whatColumn="
						+ whatColumn + "&keyword=" + keyword;
				session.setAttribute("destination", destination);
				return "redirect:/login.mb";
			}
		}
		QnaBean qna = QnaDao.getQnaByNo(qna_no);
		
		//DB에서는 줄바꿈이 <br>로 저장되어 있는게 폼에 그대로 출력되지 않게 다시 변경
		String contents = qna.getContent().replace("<br>","\r\n");
		qna.setContent(contents);
				
		model.addAttribute("qna", qna);
		
		if(isAdmin == null) {
			return getPage;
		}else {
			return "qnaAdminUpdateForm";
		}
	}

	@RequestMapping(value = command, method = RequestMethod.POST)
	public String update(
			@ModelAttribute("qna") @Valid QnaBean qna,
			BindingResult result,
			Model model,
			@RequestParam(value="isAdmin", required = false) String isAdmin,
			@RequestParam(value = "pageNumber", required = false) String pageNumber,
			@RequestParam(value = "whatColumn", required = false) String whatColumn,
			@RequestParam(value = "keyword", required = false) String keyword
			) throws IOException {
		if (result.hasErrors()) {
			return getPage;
		}
		
		//줄바꿈 포함해서 DB에 저장되게 설정
		String contents = qna.getContent().replace("\r\n", "<br>");
		qna.setContent(contents);
				
		int cnt = QnaDao.updateQna(qna);
		System.out.println("수정 성공 갯수 : " + cnt);
		
		if(isAdmin == null) {
			return gotoPage+"?qna_no="+qna.getQna_no()+"&pageNumber="+pageNumber+"&keyword="+keyword+"&whatColumn="+whatColumn;
		}else {
			model.addAttribute("isSuccess", "yes");
			return "qnaAdminUpdateForm";
		}
	}

}
