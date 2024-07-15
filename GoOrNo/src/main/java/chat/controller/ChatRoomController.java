package chat.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
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
		//채팅방 메시지 리스트
		List<ChatMessageBean> mlists = chatMessageDao.getAllMessage(chat_no);
		
		//채팅방 정보
		ChatBean chatInfo = chatDao.getChatByNo(chat_no);
		
		int headcount = chatInfo.getHeadcount(); //현재 인원수
		int max = chatInfo.getMaxcount(); //채팅방 정원
		
		//채팅방 멤버 목록에 신규 유저 추가
		boolean isMember = false;
		
		if(isAdmin == null) {
			List<ChatMemberBean> memberList = chatMemberDao.getMemberList(chat_no);
			UsersBean users = (UsersBean)session.getAttribute("loginInfo");
			if(memberList.size() > 0) {
				for(ChatMemberBean member : memberList) {
					//로그인한 유저가 채팅방 멤버인 경우
					if(users.getId().equals(member.getUser_id())) {
						isMember = true;
						break;
					}
				}
			}
			
			if(isMember == false) { //채팅방 멤버 아님
				if(headcount == max) { //정원이 다 찬 경우
					model.addAttribute("isFull", "yes");
					return getPage;
				}else { //정원이 남은 경우
					System.out.println(chat_no+"/"+users.getUser_no()+"/"+users.getId());
					ChatMemberBean member = new ChatMemberBean(0, chat_no, users.getUser_no(), users.getId(), 0);
					int cnt =  chatMemberDao.insertMember(member);
					if(cnt > 0) { 
						//채팅방 입장하면 메세지 띄우기
						String content = users.getId()+"님이 입장했습니다.";
						ChatMessageBean message = new ChatMessageBean(0, chat_no, 1, "info", content, ""); //user_no는 1로, user_id는 'info'로 설정
						chatMessageDao.writeMessage(message);
						
						//jsp 새로 입장한다고 알림
						model.addAttribute("isNew", "new");
						
						//채팅방 headcount +1 하기
						chatDao.updateHeadcount(chat_no);
						chatInfo.setHeadcount(headcount+1);
					}
				}
			}
		}//관리자 아님
		
		model.addAttribute("mlists", mlists);
		session.setAttribute("chatInfo", chatInfo);
		
		return getPage;
	}
}
