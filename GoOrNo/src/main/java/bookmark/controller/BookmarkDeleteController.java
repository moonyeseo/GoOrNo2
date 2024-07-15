package bookmark.controller;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import bookmark.model.BookmarkDao;
import users.model.UsersBean;

@Controller
public class BookmarkDeleteController {
	
	@Autowired
	private BookmarkDao bookmarkDao;
	
	@Autowired
	ServletContext servletContext;
	
	private final String command = "/bookmarkDelete.bookmark";
	private final String gotoPage = "/myPage.users";
	
	@RequestMapping(command)
	public ModelAndView bookmarkDelete(HttpSession session, 
										@RequestParam("book_no") int book_no, @RequestParam("type") String type) {
		
		System.out.println("-----BookmarkDeleteController()-----");
		
		UsersBean loginInfo = (UsersBean) session.getAttribute("loginInfo");
		int user_no = loginInfo.getUser_no();
		
		System.out.println("Delete book_no : " + book_no);
		System.out.println("Delete user_no : " + user_no);
		System.out.println("Delete type : " + type);
		
		ModelAndView mav = new ModelAndView();
		
		int cnt = -1;
		cnt = bookmarkDao.deleteBookmark(book_no, user_no, type);
		
		mav.setViewName("redirect:" + gotoPage + "?user_no=" + user_no);
		
		return mav;
	}
}