package event.controller;

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

import event.model.EventBean;
import event.model.EventDao;
import users.model.UsersBean;

@Controller
public class EventInsertController {
	private final String command = "insert.event";
	private final String getPage = "eventInsert";
	private final String gotoPage = "redirect:/list.event";
	
	@Autowired
	EventDao edao;
	// �̿ϼ�.
	// ������ �߰� Ŭ��
	@RequestMapping(value=command, method = RequestMethod.GET)
	public String insertForm(@RequestParam(value="whatColumn", required = false) String whatColumn,
			@RequestParam(value="keyword", required = false) String keyword,
			@RequestParam(value="pageNumber", required = false) String pageNumber,
			HttpSession session, Model model
			) {
		UsersBean mb = (UsersBean)session.getAttribute("loginInfo");
		
		// �α��� x
		if(mb == null) { 
			model.addAttribute("keyword",keyword);
			model.addAttribute("pageNumber",pageNumber);
			model.addAttribute("whatColumn",whatColumn);

			String destination = "redirect:/insert.event?pageNumber="+pageNumber+"&whatColumn="+whatColumn+"&keyword="+keyword;
			session.setAttribute("destination", destination);
			return "redirect:/login.users";
		}
		return getPage;
	}
	
	@RequestMapping(value=command, method = RequestMethod.POST)
	public String insert(
			@ModelAttribute("event") @Valid EventBean event,
			BindingResult result) {
		
		
		return gotoPage;
	}
}
