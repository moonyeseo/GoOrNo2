package users.Controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import chat.model.ChatBean;
import chat.model.ChatDao;
import users.model.UsersDao;

@Controller
@ComponentScan(basePackages = {"chat","users"})
public class UserDeleteController {
	
	@Autowired
	private UsersDao usersDao;
	
	@Autowired
	private ChatDao chatDao;
	
	private final String command = "/delete.users";
	
	@RequestMapping(command)
	public String delete(@RequestParam("user_no") int user_no, HttpServletRequest request) {
		
		List<ChatBean> chatList = chatDao.getChatByUser_no(user_no);
		System.out.println("chatList.size() : "+chatList.size());
		
		int cnt = usersDao.deleteUsers(user_no);
		
		//yoon
		System.out.println("************************UserDeleteController : "+user_no);
		
		if(cnt > 0) {
			if(chatList.size() > 0 ) {
				for(ChatBean chat : chatList) {
					System.out.println(chat.getAlias());
					chatDao.downHeadcount(chat);
				}
			}
		}
		
		HttpSession session = request.getSession(false);
		if (session != null) {
			session.invalidate();
		}
		
		return "redirect:/main.jsp";
	}
}