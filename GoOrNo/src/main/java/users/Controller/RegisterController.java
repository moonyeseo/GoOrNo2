package users.Controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import users.model.UsersBean;
import users.model.UsersDao;

@Controller
public class RegisterController {

	private final String command = "join.users";
	private final String getPage = "register";
	private final String gotoPage = "redirect:/login.users";

	@Autowired
	UsersDao usersDao;

	@Autowired
	ServletContext servletContext;

	@RequestMapping(value = command, method = RequestMethod.GET)
	public String form() {
		return getPage;

	}

	@RequestMapping(value = command, method = RequestMethod.POST)
	public ModelAndView register(@ModelAttribute("users") @Valid UsersBean users, BindingResult result,
			HttpServletResponse response) {

//		System.out.println("PIC post");
//		System.out.println("usersid:" + users.getId());
//		System.out.println("getGender:" + users.getGender());
//		System.out.println("getPhoneNum:" + users.getPhoneNum());
//		System.out.println("getAddress:" + users.getAddress());
//		System.out.println("getPostcode:" + users.getPostcode());
//		System.out.println("getUpload:" + users.getUpload());

		MultipartFile multi = users.getUpload();

		String uploadPath = servletContext.getRealPath("/resources/uploadImage/");
		System.out.println("uploadPath:" + uploadPath);

		ModelAndView mav = new ModelAndView();

		int cnt = -1;
		cnt = usersDao.insertUsers(users);

		try {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			
			if (cnt != -1) {//회원가입 성공
				mav.setViewName(gotoPage);
				
				File destination = new File(uploadPath + File.separator + multi.getOriginalFilename());

				try {
					multi.transferTo(destination);
				} catch (IllegalStateException e) {
					e.printStackTrace();
				} catch (IOException e) {
					e.printStackTrace();
				}
				
			} else {//회원가입 실패
				out.println("<script>");
				out.println("alert('회원가입 실패.');");
				out.println("</script>");
				out.flush();
				mav.setViewName(getPage);
			}

		} catch (IOException e) {
			e.printStackTrace();
		}

		return mav;
	}
}