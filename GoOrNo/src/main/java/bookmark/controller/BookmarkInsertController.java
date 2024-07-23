package bookmark.controller;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import bookmark.model.BookmarkBean;
import bookmark.model.BookmarkDao;
import users.model.UsersBean;

@Controller
public class BookmarkInsertController {
	
	@Autowired
	private BookmarkDao bookmarkDao;
	
	@Autowired
	ServletContext servletContext;
	
	private final String command = "/bookmarkInsert.bookmark";
	private final String gotoPage = "/myPage.users";
	
	@RequestMapping(value = command, method = RequestMethod.POST)
	public ModelAndView bookmarkInsert(@ModelAttribute("bookmarkBean") @Valid BookmarkBean bookmarkBean,
										HttpSession session) {
		
		System.out.println("-----BookmarkInsertController()-----");
		System.out.println("Received bookmarkBean: " + bookmarkBean);
		
		UsersBean loginInfo = (UsersBean) session.getAttribute("loginInfo");
		bookmarkBean.setUser_no(loginInfo.getUser_no());
		
		System.out.println("Updated bookmarkBean with book_no: " + bookmarkBean.getBook_no());
		System.out.println("Updated bookmarkBean with user_no: " + bookmarkBean.getUser_no());
		System.out.println("Updated bookmarkBean with type: " + bookmarkBean.getType());
		System.out.println("Updated bookmarkBean with b_addr: " + bookmarkBean.getB_addr());
		System.out.println("Updated bookmarkBean with b_post: " + bookmarkBean.getB_post());
		
		ModelAndView mav = new ModelAndView();
		
		//기존 북마크 있는지 확인
		BookmarkBean existBookmark = bookmarkDao.getBookmarkByUserNoAndType(bookmarkBean.getUser_no(), bookmarkBean.getType());
		
		//있으면 삭제
		if(existBookmark != null) {
			bookmarkDao.deleteBookmark(existBookmark.getBook_no() , bookmarkBean.getUser_no(), bookmarkBean.getType());
		}
		
		int cnt = -1;
		cnt = bookmarkDao.insertBookmark(bookmarkBean);
		
		System.out.println("insert cnt : " + cnt);
		
		String contextPath = servletContext.getContextPath();
		RedirectView redirectView = new RedirectView(contextPath + gotoPage + "?user_no=" + bookmarkBean.getUser_no());
		redirectView.setExposeModelAttributes(false);
		mav.setView(redirectView);
		
		return mav;
	}
}