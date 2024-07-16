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
		//梨꾪똿諛� 硫붿떆吏� 由ъ뒪�듃
		List<ChatMessageBean> mlists = chatMessageDao.getAllMessage(chat_no);
		
		//梨꾪똿諛� �젙蹂�
		ChatBean chatInfo = chatDao.getChatByNo(chat_no);
		
		int headcount = chatInfo.getHeadcount(); //�쁽�옱 �씤�썝�닔
		int max = chatInfo.getMaxcount(); //梨꾪똿諛� �젙�썝
		
		//梨꾪똿諛� 硫ㅻ쾭 紐⑸줉�뿉 �떊洹� �쑀�� 異붽�
		boolean isMember = false;
		
		if(isAdmin == null) {
			List<ChatMemberBean> memberList = chatMemberDao.getMemberList(chat_no);
			UsersBean users = (UsersBean)session.getAttribute("loginInfo");
			if(memberList.size() > 0) {
				for(ChatMemberBean member : memberList) {
					//濡쒓렇�씤�븳 �쑀��媛� 梨꾪똿諛� 硫ㅻ쾭�씤 寃쎌슦
					if(users.getId().equals(member.getUser_id())) {
						isMember = true;
						break;
					}
				}
			}
			
			if(isMember == false) { //梨꾪똿諛� 硫ㅻ쾭 �븘�떂
				if(headcount == max) { //�젙�썝�씠 �떎 李� 寃쎌슦
					model.addAttribute("isFull", "yes");
					return getPage;
				}else { //�젙�썝�씠 �궓�� 寃쎌슦
					System.out.println(chat_no+"/"+users.getUser_no()+"/"+users.getId());
					ChatMemberBean member = new ChatMemberBean(0, chat_no, users.getUser_no(), users.getId(), 0);
					int cnt =  chatMemberDao.insertMember(member);
					if(cnt > 0) { 
						//梨꾪똿諛� �엯�옣�븯硫� 硫붿꽭吏� �쓣�슦湲�
						String content = users.getId()+"님이 입장하셨습니다.";
						ChatMessageBean message = new ChatMessageBean(0, chat_no, 1, "info", content, ""); //user_no�뒗 1濡�, user_id�뒗 'info'濡� �꽕�젙
						chatMessageDao.writeMessage(message);
						
						//jsp �깉濡� �엯�옣�븳�떎怨� �븣由�
						model.addAttribute("isNew", "new");
						
						//梨꾪똿諛� headcount +1 �븯湲�
						chatDao.updateHeadcount(chat_no);
						chatInfo.setHeadcount(headcount+1);
					}
				}
			}
		}//愿�由ъ옄 �븘�떂
		
		model.addAttribute("mlists", mlists);
		session.setAttribute("chatInfo", chatInfo);
		
		return getPage;
	}
}