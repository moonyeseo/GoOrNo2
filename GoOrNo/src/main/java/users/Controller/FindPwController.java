package users.Controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import org.springframework.web.servlet.ModelAndView;

import users.model.UsersBean;
import users.model.UsersDao;

@Controller
public class FindPwController {

	private final String command = "FindPw.users";
	private final String getPage = "FindPw";
	private final String gotoPage = "login.users";

	@Autowired
	UsersDao usersDao;

	@RequestMapping(value = command, method = RequestMethod.GET)
	public String form() {
        System.out.println("findPw.GET");
		return getPage;

	}

	@RequestMapping(value = command, method = RequestMethod.POST)
	public ModelAndView findPw(
			@ModelAttribute("users") @Valid UsersBean users, BindingResult result,
			HttpServletResponse response) {

		ModelAndView mav = new ModelAndView();
		UsersBean ub = usersDao.getById(users.getId());

		try {
			
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();

			if (ub != null) {
				
				out.println("<script>");
				out.println("alert('비밀번호는" + ub.getPw() + "입니다.')");
				out.println("location.href='" + command + "';");
				out.println("</script>");
				out.flush();

			} else {
				out.println("<script>");
				out.println("alert('없는 회원 입니다.');");
				out.println("location.href='" + command + "';");
				out.println("</script>");
				out.flush();

			}

		} catch (IOException e) {
			e.printStackTrace();
		}

		return mav;
	}
}