package event.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import event.model.EventBean;
import event.model.EventDao;
import review.model.ReviewBean;
import review.model.ReviewDao;
import users.model.UsersBean;
import users.model.UsersDao;

@Controller
@ComponentScan(basePackages = {"review","users"})
public class EventDetailController {
	// 상세보기
	private final String command = "detail.event"; 
	private final String admincmd = "AdminDetail.event"; 
	private final String getPage = "eventDetail";
	private final String adminPage = "eventAdminDetail";
	
	@Autowired
	private EventDao edao;
	
	@Autowired
	ReviewDao reviewDao;
	
	@Autowired
	UsersDao usersDao;
	
	@RequestMapping(command)
	public String detail(
			@RequestParam("eventNo") int eventNo,
			@RequestParam(value="pageNumber", required = false) String pageNumber,
			@RequestParam(value="whatColumn", required = false) String whatColumn,
			@RequestParam(value="keyword", required = false) String keyword,
			HttpSession session, Model model) {
		
			EventBean event = edao.getEventByEventNo(eventNo);
			model.addAttribute("event", event);
			model.addAttribute("eventNo", eventNo);
			model.addAttribute("keyword", keyword);
			model.addAttribute("whatColumn", whatColumn);
			model.addAttribute("pageNumber", pageNumber);
			
			/* review 추가 */			
			List<ReviewBean> reviewLists = reviewDao.getAllReview(eventNo);
            double averageRating = reviewDao.getAverageRating(eventNo);
           
            model.addAttribute("averageRating", averageRating);
            model.addAttribute("reviewLists", reviewLists);
            
			return getPage;
	}
	
	// 관리자
	@RequestMapping(admincmd)
	public String Admindetail(
			@RequestParam("eventNo") int eventNo,
			@RequestParam(value="pageNumber", required = false) String pageNumber,
			@RequestParam(value="whatColumn", required = false) String whatColumn,
			@RequestParam(value="keyword", required = false) String keyword,
			HttpSession session, Model model) {
		
			EventBean event = edao.getEventByEventNo(eventNo);
			model.addAttribute("event", event);
			model.addAttribute("eventNo", eventNo);
			model.addAttribute("keyword", keyword);
			model.addAttribute("whatColumn", whatColumn);
			model.addAttribute("pageNumber", pageNumber);
			return adminPage;
	}
	
	
}
