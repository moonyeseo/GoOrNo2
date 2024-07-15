package users.Controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import users.model.UsersBean;
import users.model.UsersDao;

@Controller
public class mypageUpdateController {

	@Autowired
	private UsersDao usersDao;
	
	@Autowired
	ServletContext servletContext;
	
	private final String command = "/updateMyPage.users";
	private final String commandPw = "/updatePw.users";
	private final String getPage = "myPage";
	private final String gotoPage = "redirect:/myPage.users";
	
	
	@RequestMapping(value = command, method = RequestMethod.POST)
	public ModelAndView updateMyPage(@ModelAttribute("usersBean") @Valid UsersBean usersBean, BindingResult result) {
		
		System.out.println("-----mypageUpdateController_updateMyPage-----");
		
		System.out.println("user_no: " + usersBean.getUser_no());
        System.out.println("id: " + usersBean.getId());
        System.out.println("pw: " + usersBean.getPw());
        System.out.println("gender: " + usersBean.getGender());
        System.out.println("email: " + usersBean.getEmail());
        System.out.println("name: " + usersBean.getName());
        System.out.println("profile: " + usersBean.getProfile());
        System.out.println("phoneNum: " + usersBean.getPhoneNum());
        System.out.println("postcode: " + usersBean.getPostcode());
        System.out.println("address: " + usersBean.getAddress());
		
		ModelAndView mav = new ModelAndView();
		
		if (result.hasErrors()) {
            mav.setViewName(getPage);
            
            if(usersBean.getProfile().equals("")) {
            	usersBean.setProfile(usersBean.getUpload2());
            }
            
            return mav;
        }
		
		// 비밀번호가 비어 있으면 기존 비밀번호 유지
	    if (usersBean.getPw() == null || usersBean.getPw().isEmpty()) {
	        UsersBean users = usersDao.getByUserId(usersBean.getUser_no());
	        usersBean.setPw(users.getPw());
	    }
		
		MultipartFile multi = usersBean.getUpload();
		String uploadPath = servletContext.getRealPath("/resources/uploadImage/");
		System.out.println("Upload path: " + uploadPath);
		
		if (!multi.isEmpty()) {
			usersBean.setProfile(multi.getOriginalFilename());
		} else {
			usersBean.setProfile(usersBean.getUpload2());
		}
		
		System.out.println("Updating user with profile: " + usersBean.getProfile());
		int cnt = -1;
		cnt = usersDao.updateUsers(usersBean);
		System.out.println("Update result: " + cnt);
		
		if(cnt != -1) {
			if (!multi.isEmpty()) {
				String deletePath = servletContext.getRealPath("/resources/uploadImage/");
				File file = new File(deletePath + File.separator + usersBean.getUpload2());
				
				if(file.exists()) {
					file.delete();
				}
				
				File destination = new File(uploadPath + File.separator + multi.getOriginalFilename());
				System.out.println("Destination path: " + destination.getAbsolutePath());
				
				try {
					multi.transferTo(destination);
				} catch (IllegalStateException e) {
					e.printStackTrace();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
			
			mav.setViewName(gotoPage + "?user_no=" + usersBean.getUser_no());
		} else {
			mav.setViewName(getPage);
		}
		
		System.out.println("Update cnt : " + cnt);
		
		return mav;
	}//updateMyPage
	
	
	@RequestMapping(value = commandPw, method = RequestMethod.POST)
	public void updatePw(
						@RequestParam("user_no") int user_no,
						@RequestParam("currentPw") String currentPw,
						@RequestParam("newPw") String newPw,
						@RequestParam("reNewPw") String reNewPw,
						HttpSession session, HttpServletResponse response) {
		
		System.out.println("-----mypageUpdateController_updatePw-----");
		
		System.out.println("user_no: " + user_no);
        System.out.println("currentPw: " + currentPw);
        System.out.println("newPw: " + newPw);
        System.out.println("reNewPw: " + reNewPw);
        
        UsersBean usersBean = usersDao.getByUserId(user_no);
        
        try {
        	response.setContentType("text/html; charset=UTF-8");
        	PrintWriter out = response.getWriter();
        	
        	if(!usersBean.getPw().equals(currentPw)) {
        		out.println("<script>alert('현재 비밀번호가 일치하지 않습니다.'); history.go(-1);</script>");
        		out.flush();
        		return;
        	}
        	
        	if (newPw == null || newPw.isEmpty() || reNewPw == null || reNewPw.isEmpty()) {
                out.println("<script>alert('변경할 비밀번호를 입력해 주세요.'); history.go(-1);</script>");
                out.flush();
                return;
            }
        	
        	if(!newPw.equals(reNewPw)) {
        		out.println("<script>alert('새로운 비밀번호가 일치하지 않습니다.'); history.go(-1);</script>");
        		out.flush();
        		return;
        	}
        	
        	usersBean.setPw(newPw);
        	int cnt = usersDao.updatePw(usersBean);
        	
        	if(cnt != -1) {
        		out.println("<script>alert('비밀번호가 변경되었습니다.'); location.href='myPage.users?user_no=" + user_no + "';</script>");
        	} else {
        		out.println("<script>alert('비밀번호 변경에 실패했습니다.'); history.go(-1);</script>");
        	}
        	out.flush();
        	
        	
        } catch (IOException e) {
        	e.printStackTrace();
        }
	}//updatePw
}