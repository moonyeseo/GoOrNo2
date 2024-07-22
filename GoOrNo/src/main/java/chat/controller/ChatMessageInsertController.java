package chat.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import chat.model.ChatMessageBean;
import chat.model.ChatMessageDao;
import users.model.UsersBean;
import users.model.UsersDao;

@Controller
@ComponentScan(basePackages = {"chat","users"})
public class ChatMessageInsertController {
	private final String command = "save.chat";
	@Autowired
	ChatMessageDao chatMessageDao;
	@Autowired
	UsersDao memberDao;
	
	@RequestMapping(command)
	public @ResponseBody String saveChatMessage(
			HttpSession session,
			@RequestParam("content") String content,
			@RequestParam("chat_no") int chat_no
			){
		String cnt = "-1";
		
		System.out.println("content : " + content);
		System.out.println("chat_no : " + chat_no);
		
		UsersBean user = (UsersBean)session.getAttribute("loginInfo");
		String user_id = user.getId();
		int user_no = user.getUser_no();
		System.out.println("user info : "+user_no+"/"+user_id);
		
		ChatMessageBean chatMessage = new ChatMessageBean(0, chat_no, user_no, user_id, content, "");
		
		chatMessageDao.writeMessage(chatMessage);
		
		return cnt;
	}
}
