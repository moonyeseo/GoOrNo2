package users.Controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import users.model.UsersBean;
import users.model.UsersDao;

@Controller
public class LoginController {

	private final String command = "login.users";
	private final String getPage = "loginForm";
	private final String goPage1 = "../../main";
	private final String goPage2 = "../../mainAdmin";

	@Autowired
	UsersDao UserDao;

	@RequestMapping(value = command, method = RequestMethod.GET)
	public String form() {
		System.out.println(this.getClass() + "GET");
		return getPage;
	}

	@RequestMapping(value = command, method = RequestMethod.POST)
	public ModelAndView Login(UsersBean users, HttpSession session, HttpServletResponse response, Model model) {

		ModelAndView mav = new ModelAndView();

		UsersBean ub = UserDao.getById(users.getId());
		System.out.println("ub:" + ub);

		try {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();

			if (ub == null) { // 없는 아이디 일 경우.
				out.println("<script>");
				out.println("alert('존재하지 않는 아이디 입니다.');");
				out.println("</script>");
				out.flush();
				return new ModelAndView(getPage);

			} else {
				if (ub.getPw().equals(users.getPw())) {

					session.setAttribute("loginInfo", ub);
					//yoon 추가
					session.setAttribute("id", ub.getId());

					if (ub.getId().equals("admin")) { //  관리자 로그인을 할 경우.
						out.println("<script>");
						out.println("alert('관리자페이지로 이동합니다.');");
						out.println("</script>");
						out.flush();
						return new ModelAndView(goPage2);

					} else { // 관리자가 아닌 일반 로그인인 경우.
//						out.println("<script>");
//						out.println("alert('반갑습니다! " + ub.getName() + "님')");
//						out.println("</script>");
//						out.flush();
						return new ModelAndView(goPage1);
					}

				} else { // 회원은 있지만, 비밀번호가 틀렸을 경우.
					out.println("<script>");
					out.println("alert('비밀번호를 다시 입력해주세요.');");
					out.println("</script>");
					out.flush();
					return new ModelAndView(getPage);
				}
			}

		} catch (IOException e) {
			e.printStackTrace();
		}

		return mav;
	}
}
