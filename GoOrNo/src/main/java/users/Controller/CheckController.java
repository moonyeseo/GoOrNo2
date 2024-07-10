package users.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import users.model.UsersDao;

@Controller
public class CheckController {
	
	@Autowired
	UsersDao usersDao;
	
	private final String command = "/id_check_proc.user";
	

}
