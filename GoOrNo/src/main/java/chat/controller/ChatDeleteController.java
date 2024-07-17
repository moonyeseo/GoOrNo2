package chat.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import chat.model.ChatBean;
import chat.model.ChatDao;
import chat.model.ChatMemberDao;
import chat.model.ChatMessageBean;
import chat.model.ChatMessageDao;
import users.model.UsersBean;
import users.model.UsersDao;

@Controller
//ComponentScan(basePackages = {"chat","users"})
public class ChatDeleteController {
	private final String command = "/delete.chat";
	private String getPage = "chatRoom";
	private String gotoPage = "redirect:/list.chat";
	
	@Autowired
	ChatDao chatDao;
	
	@Autowired
	ChatMemberDao chatMemberDao;

	@Autowired
	ChatMessageDao chatMessageDao;
	
	@Autowired
	UsersDao usersDao;
	

	@RequestMapping(value = command)
	private String insert(
			HttpSession session,
			Model model,
			@RequestParam(value="isAdmin", required = false) String isAdmin,
			@RequestParam("chat_no") int chat_no
			) {
		System.out.println("==============================");
		System.out.println("여기 chat_no : "+chat_no);
		
		//admin delete chat
		if(isAdmin != null) {
			chatDao.deleteChat(chat_no);
			model.addAttribute("isAdmin", isAdmin);
			return gotoPage;
		}
		
		//is id == owner?
		ChatBean chatInfo = chatDao.getChatByNo(chat_no);
		
		String owner = chatInfo.getUser_id();
		UsersBean loginInfo = (UsersBean)session.getAttribute("loginInfo");
		String id = loginInfo.getId();
		System.out.println("owner/id : "+owner+"/"+id);
		
		//delete chat
		if(owner.equals(id)) {
			int cnt = chatDao.deleteChat(chat_no);
			System.out.println("cnt : "+cnt);
		}else {
			//delete chatMember
			System.out.println("delete chatMember");
			chatInfo.setUser_id(id);
			int cnt2 = chatDao.deleteChatMember(chatInfo);
			System.out.println("cnt2 : "+cnt2);
			
			if(cnt2 > 0) {
				//save exit message in DB
				String content = id+" is exit.";
				ChatMessageBean message = new ChatMessageBean(0, chat_no, 1, "info", content, ""); //user_no, user_id, 'info'
				chatMessageDao.writeMessage(message);
			}
		}
		
		model.addAttribute("isExit", "yes");
		return getPage;
	}
	
}

