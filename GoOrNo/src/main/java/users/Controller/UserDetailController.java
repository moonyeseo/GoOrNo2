package users.Controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import users.model.UsersBean;
import users.model.UsersDao;

@Controller
public class UserDetailController {
	private final String command = "detailUsers.users";
	private final String getPage = "detailUsersAdmin";
	
	@Autowired
	UsersDao usersDao;
	
	@RequestMapping(value = command)
	public String detail(@RequestParam("user_no") int user_no,
            @RequestParam("pageNumber") int pageNumber,
            @RequestParam("whatColumn") String whatColumn,
            @RequestParam("keyword") String keyword,
            Model model) {
		
		UsersBean users = usersDao.getByUserId(user_no);
		model.addAttribute("users",users);
		model.addAttribute("pageNumber",pageNumber);
		
		return getPage;
	}
	

}
