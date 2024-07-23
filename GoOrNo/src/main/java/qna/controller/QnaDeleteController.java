package qna.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
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

import qna.model.QnaBean;
import qna.model.QnaDao;
import users.model.UsersBean;

@Controller
public class QnaDeleteController {
	private final String command = "delete.qna";
	private final String gotoPage = "redirect:/list.qna";

	@Autowired
	QnaDao QnaDao;

	@RequestMapping(value = command)
	public String delete(
			Model model,
			HttpServletResponse response,
			@RequestParam(value = "qna_no", required = true) int qna_no,
			@RequestParam(value="isAdmin", required = false) String isAdmin,
			@RequestParam(value="isList", required = false) String isList,
			@RequestParam(value = "pageNumber", required = false) String pageNumber,
			@RequestParam(value = "whatColumn", required = false) String whatColumn,
			@RequestParam(value = "keyword", required = false) String keyword
			) throws IOException {

		model.addAttribute("keyword", keyword);
		model.addAttribute("pageNumber", pageNumber);
		model.addAttribute("whatColumn", whatColumn);
		
		int cnt = QnaDao.deleteQna(qna_no);
		System.out.println("삭제 개수: " + cnt);
		
		if(isAdmin == null) {
			return gotoPage;
		}else {
			model.addAttribute("isAdmin", "yes");
			model.addAttribute("isSuccess", "yes");
			if(isList == null) {
				return "qnaAdminDetailView";
			}else {
				return gotoPage;
			}
		}
	}

}
