package event.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import event.model.EventBean;
import event.model.EventDao;
import utility.Paging;

@Controller
public class EventRandomController {
	private final String command = "/random.event";
	private final String gotoPage = "../../main";

	@Autowired
	private EventDao eventDao;

	@RequestMapping(command)
//@ResponseBody
	public String doAction(HttpServletRequest request) {

		Map<String, String> map = new HashMap<String, String>();
		
		// 랜덤으로 행사 아무거나 하나 가져오기
		int totalCount = eventDao.getTotalCount(map);

		int random = (int)(Math.random() * totalCount) + 1;

		System.out.println( totalCount + " /  " + random);

		EventBean event = eventDao.getEventByEventNo(random);

		request.setAttribute("event", event);
		request.setAttribute("calendarFlag", true);

		return gotoPage;
	}							
}
