package bookmark.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import bookmark.model.BookmarkBean;
import bookmark.model.BookmarkDao;
import users.model.UsersBean;

@Controller
public class BookmarkSearchController {
	private final String command = "search.bookmark";
	private final String gotoPage = "trafficSearch";
	
	@Autowired
	BookmarkDao bookmarkDao;
	
	@RequestMapping(command)
	public String doAction(Model model,
													HttpSession session,
													@RequestParam(value = "lat", required = false) String lat, 
													@RequestParam(value = "lot", required = false) String lot, 
													@RequestParam(value = "place", required = false) String place) {
		 
		UsersBean users = (UsersBean)session.getAttribute("loginInfo"); 
		 
			if(users != null) { // 로그인된 상태일 때만 bookmark 가져오기
				 int user_no = users.getUser_no();
				
				List<BookmarkBean> bookmarkLists = bookmarkDao.getSearchBookmark(user_no); 
				
				for (BookmarkBean bookmark : bookmarkLists) {
		            if (bookmark.getType().equals("house")) {
		                model.addAttribute("house", bookmark.getB_addr());
		            } else if (bookmark.getType().equals("company")) {
		                model.addAttribute("company", bookmark.getB_addr());
		            } else if (bookmark.getType().equals("star")) {
		                model.addAttribute("star", bookmark.getB_addr());
		            }
		        }
			}
		
		return gotoPage;
	}
}