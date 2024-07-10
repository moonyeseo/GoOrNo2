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
import users.model.UsersBean;

@Controller
public class QnaInsertController {
	private final String command = "insert.qna";
	private final String getPage = "qnaWriteForm";
	private final String gotoPage = "redirect:/list.qna";
	
	@Autowired
	QnaDao QnaDao;
	
	@RequestMapping(value=command, method = RequestMethod.GET)
	public String insertForm(
			Model model,
			HttpSession session,
			@RequestParam(value="pageNumber", required = false) String pageNumber,
			@RequestParam(value="whatColumn", required = false) String whatColumn,
			@RequestParam(value="keyword", required = false) String keyword
			) {
		UsersBean mb = (UsersBean)session.getAttribute("loginInfo");
		if(mb == null) { //�α���x
			model.addAttribute("keyword",keyword);
			model.addAttribute("pageNumber",pageNumber);
			model.addAttribute("whatColumn",whatColumn);

			String destination = "redirect:/insert.qna?pageNumber="+pageNumber+"&whatColumn="+whatColumn+"&keyword="+keyword;
			session.setAttribute("destination", destination);
			return "redirect:/login.users";
		}
		return getPage;
	}
	
	@RequestMapping(value=command, method = RequestMethod.POST)
	public String insert(
				HttpServletRequest request,
				@ModelAttribute("qna") @Valid QnaBean qna,
				BindingResult result
			){
		
		if(result.hasErrors()) {
			return getPage;
		}
		
		//�ٹٲ� �����ؼ� DB�� ����ǰ� ����
		String contents = qna.getContent().replace("\r\n", "<br>");
		qna.setContent(contents);
		
		//�۵��
		int cnt = QnaDao.insertQna(qna);
		System.out.println("���� ���� ���� : "+cnt);
		return gotoPage;
	}
	
	
}
