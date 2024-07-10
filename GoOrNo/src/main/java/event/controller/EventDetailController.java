package event.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import event.model.EventBean;
import event.model.EventDao;
import users.model.UsersBean;

@Controller
public class EventDetailController {
	// �󼼺���
	private final String command = "detail.event"; 
	private final String getPage = "eventDetail";
	
	@Autowired
	private EventDao edao;
	
	@RequestMapping(command)
	public String detail(
			@RequestParam("eventNo") int eventNo,
			@RequestParam(value="pageNumber", required = false) String pageNumber,
			@RequestParam(value="whatColumn", required = false) String whatColumn,
			@RequestParam(value="keyword", required = false) String keyword,
			HttpSession session, Model model) {
		
			EventBean event = edao.getEventByEventNo(eventNo);
			model.addAttribute("event", event);
			return getPage;
	}
}
