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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import event.model.EventBean;
import event.model.EventDao;
import utility.Paging;

@Controller
public class EventCalendarController {
	private final String command = "/calendar.event";
	private final String gotoPage = "eventCalendar";

	@Autowired
	private EventDao eventDao;
	
	@RequestMapping(value = command, method = RequestMethod.GET)
//@ResponseBody
	public String doAction(@RequestParam("year") int year,
			@RequestParam("month") int month,
			@RequestParam("day") int day,
			HttpServletRequest request) {

		//System.out.println(year + "." + month + "." + day);

		Map<String, String> map = new HashMap<String, String>();
		Paging pageInfo = new Paging(null, "10", 0, null, null, null);

		List<EventBean> lists = eventDao.getAllEvents(map, pageInfo);

		ArrayList<EventBean> eventLists = new ArrayList<EventBean>();

		//System.out.println("lists size : " + lists.size());

		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");

		Date selectDate = null;

		try {
			selectDate = formatter.parse(year + "-" + month + "-" + day);

		} catch (ParseException e1) {
			e1.printStackTrace();
		}

		//System.out.println("selectDate : " + selectDate);

		Date startDate = null;
		Date endDate = null;

		String period = null;
		String [] start_end = null; 

		for(int i = 0; i < lists.size(); i++) {
			period = lists.get(i).getEvent_period();
			start_end = period.split("~");

			try {
				startDate = formatter.parse( start_end[0]);
				endDate = formatter.parse( start_end[1]);

			} catch (ParseException e) {
				e.printStackTrace();
			}

			//			System.out.println(lists.get(i).getTitle());
			//			System.out.println(lists.get(i).getEvent_period());
			//			
			//		 System.out.println("startDate : " + startDate);
			//		 System.out.println("endDate : " + endDate);


			if(selectDate.after(startDate) || selectDate.equals(startDate)) {
				if(selectDate.before(endDate) || selectDate.equals(endDate)) {
					eventLists.add(lists.get(i));
				}
			}
		}

		request.setAttribute("eventLists", eventLists);
		request.setAttribute("calendarFlag", true);

		return gotoPage;
	}							
}
