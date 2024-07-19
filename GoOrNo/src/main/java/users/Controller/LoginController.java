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

			if (ub == null) { // �뾾�뒗 �븘�씠�뵒 �씪 寃쎌슦.
				out.println("<script>");
				out.println("alert('議댁옱�븯吏� �븡�뒗 �븘�씠�뵒 �엯�땲�떎.');");
				out.println("</script>");
				out.flush();
				return new ModelAndView(getPage);

			} else {
				if (ub.getPw().equals(users.getPw())) {

					session.setAttribute("loginInfo", ub);
					session.setAttribute("id", ub.getId());

					if (ub.getId().equals("admin")) { //  愿�由ъ옄 濡쒓렇�씤�쓣 �븷 寃쎌슦.
						out.println("<script>");
						out.println("alert('愿�由ъ옄�럹�씠吏�濡� �씠�룞�빀�땲�떎.');");
						out.println("</script>");
						out.flush();
						return new ModelAndView(goPage2);

					} else { // 愿�由ъ옄媛� �븘�땶 �씪諛� 濡쒓렇�씤�씤 寃쎌슦.
//						out.println("<script>");
//						out.println("alert('諛섍컩�뒿�땲�떎! " + ub.getName() + "�떂')");
//						out.println("</script>");
//						out.flush();
						return new ModelAndView(goPage1);
					}

				} else { // �쉶�썝�� �엳吏�留�, 鍮꾨�踰덊샇媛� ���졇�쓣 寃쎌슦.
					out.println("<script>");
					out.println("alert('鍮꾨�踰덊샇瑜� �떎�떆 �엯�젰�빐二쇱꽭�슂.');");
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
