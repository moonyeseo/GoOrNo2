package favorite.controller;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import favorite.model.FavoriteDao;
import users.model.UsersBean;

@Controller
public class favoriteDeleteController {
	
	@Autowired
	private FavoriteDao favoriteDao;
	
	@Autowired
	ServletContext servletContext;
	
	private final String command = "/favoriteDelete.favorite";
	private final String gotoPage = "/myPage.users";
	
	@RequestMapping(command)
	public ModelAndView deleteFavorite(HttpSession session,
										@RequestParam("favorite_no") int favorite_no,
										@RequestParam("event_no") int event_no) {
		
		System.out.println("-----favoriteDeleteController()-----");
		
		UsersBean loginInfo = (UsersBean) session.getAttribute("loginInfo");
		int user_no = loginInfo.getUser_no();
		
		System.out.println("favorite_no: " + favorite_no);
		System.out.println("event_no: " + event_no);
		System.out.println("user_no: " + user_no);
		
		ModelAndView mav = new ModelAndView();
		
		int cnt = -1;
		cnt = favoriteDao.deleteFavorite(favorite_no, event_no, user_no);
		
		mav.setViewName("redirect:" + gotoPage + "?user_no=" + user_no);
		
		return mav;
	}
}