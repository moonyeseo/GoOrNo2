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

			if (ub == null) { //���� ȸ���϶�.
				out.println("<script>");
				out.println("alert('�������� �ʴ� ���̵� �Դϴ�.');");
				out.println("</script>");
				out.flush();
				return new ModelAndView(getPage);

			} else {
				if (ub.getPw().equals(users.getPw())) {

					session.setAttribute("loginInfo", ub);
					session.setAttribute("id", ub.getId());

					if (ub.getId().equals("admin")) { //������ �α��� �Ҷ�.
						out.println("<script>");
						out.println("alert('�������������� �̵��մϴ�.');");
						out.println("</script>");
						out.flush();
						return new ModelAndView(goPage2);

					} else { // �α��� ����
						return new ModelAndView(goPage1);
					}

				} else { //��й�ȣ�� Ʋ���� ��
					out.println("<script>");
					out.println("alert('��й�ȣ�� �ٽ� �Է����ּ���.');");
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