package event.controller;

import java.io.PrintWriter;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import event.model.EventDao;

@Controller
public class EventDeleteController {
	private final String command = "delete.event";
	private final String gotoPage = "redirect:/AdminList.event";
	
	@Autowired
	private EventDao edao;
	
	@RequestMapping(command)
	public String delete(@RequestParam("eventNo") int eventNo) {
		
		
		
		
		int cnt = -1;
		cnt = edao.deleteEvent(eventNo);
		return gotoPage;
	}
}
