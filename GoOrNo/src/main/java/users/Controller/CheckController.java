package users.Controller;

import java.io.PrintWriter;

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

	private final String command = "/id_check_proc.users";

	@RequestMapping(value = command)
	@ResponseBody
	public String check(@RequestParam(value = "inputid", required = true) String inputid) {

		System.out.println("controller inputid: " + inputid);

		int count = usersDao.searchId(inputid);
		System.out.println("controller: " + count);

		PrintWriter out = null;

		if (count == 0) {
			return "YES";
		} else {
			return "NO";
		}
	}

}