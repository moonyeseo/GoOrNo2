package users.Controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import users.model.UsersDao;

@Controller
public class UserDeleteController {
	
	@Autowired
	private UsersDao usersDao;
	
	private final String command = "/delete.users";
	
	@RequestMapping(command)
	public String delete(@RequestParam("user_no") int user_no, HttpServletRequest request) {
		
		usersDao.deleteUsers(user_no);
		
		HttpSession session = request.getSession(false);
		if (session != null) {
			session.invalidate();
		}
		
		return "redirect:/main.jsp";
	}
}