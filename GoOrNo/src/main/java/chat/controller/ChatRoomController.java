package chat.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import chat.model.ChatBean;
import chat.model.ChatDao;
import chat.model.ChatMemberBean;
import chat.model.ChatMemberDao;
import chat.model.ChatMessageBean;
import chat.model.ChatMessageDao;
import users.model.UsersBean;
import users.model.UsersDao;

@Controller
@ComponentScan(basePackages = {"chat","users"})
public class ChatRoomController {
	private final String command = "/room.chat";
	private String getPage = "chatRoom";
	
	@Autowired
	ChatDao chatDao;
	
	@Autowired
	ChatMemberDao chatMemberDao;
	
	@Autowired
	ChatMessageDao chatMessageDao;
	
	@Autowired
	UsersDao usersDao;
	
	@RequestMapping(value = command)
	private String room(
			Model model,
			HttpSession session,
			@RequestParam(value="isAdmin", required = false) String isAdmin,
			@RequestParam("chat_no") int chat_no
			) throws IOException {
		//get all message
		List<ChatMessageBean> mlists = chatMessageDao.getAllMessage(chat_no);
		
		//get chatInfo
		ChatBean chatInfo = chatDao.getChatByNo(chat_no);
		
		int headcount = chatInfo.getHeadcount();
		int max = chatInfo.getMaxcount();
		
		//is chatMember?
		boolean isMember = false;
		
		if(isAdmin == null) {
			//get chatMemberList
			List<ChatMemberBean> memberList = chatMemberDao.getMemberList(chat_no);
			UsersBean users = (UsersBean)session.getAttribute("loginInfo");
			
			if(memberList.size() > 0) {
				for(ChatMemberBean member : memberList) {
					//already chatMember
					if(users.getId().equals(member.getUser_id())) {
						isMember = true;
						break;
					}
				}
			}
			
			if(isMember == false) { //not chatMember
				if(headcount == max) { //already full
					model.addAttribute("isFull", "yes");
					return getPage;
				}else { //enter new member
					System.out.println(chat_no+"/"+users.getUser_no()+"/"+users.getId());
					ChatMemberBean member = new ChatMemberBean(0, chat_no, users.getUser_no(), users.getId(), 0);
					int cnt =  chatMemberDao.insertMember(member);
					if(cnt > 0) { 
						//save endtered message in DB
						String content = users.getId()+" is entered.";
						ChatMessageBean message = new ChatMessageBean(0, chat_no, 1, "info", content, ""); //user_no占쎈뮉 1嚥∽옙, user_id占쎈뮉 'info'嚥∽옙 占쎄퐬占쎌젟
						chatMessageDao.writeMessage(message);
						
						//send entered message to WebSoket 
						model.addAttribute("isNew", "new");
						
						//update headcount +1
						chatDao.updateHeadcount(chat_no);
						chatInfo.setHeadcount(headcount+1);
					}
				}
			}
		}//users
		
		model.addAttribute("mlists", mlists);
		session.setAttribute("chatInfo", chatInfo);
		
		return getPage;
	}
}