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
		//ä�ù� �޽��� ����Ʈ
		List<ChatMessageBean> mlists = chatMessageDao.getAllMessage(chat_no);
		
		//ä�ù� ����
		ChatBean chatInfo = chatDao.getChatByNo(chat_no);
		
		int headcount = chatInfo.getHeadcount(); //���� �ο���
		int max = chatInfo.getMaxcount(); //ä�ù� ����
		
		//ä�ù� ��� ��Ͽ� �ű� ���� �߰�
		boolean isMember = false;
		
		if(isAdmin == null) {
			List<ChatMemberBean> memberList = chatMemberDao.getMemberList(chat_no);
			UsersBean users = (UsersBean)session.getAttribute("loginInfo");
			if(memberList.size() > 0) {
				for(ChatMemberBean member : memberList) {
					//�α����� ������ ä�ù� ����� ���
					if(users.getId().equals(member.getUser_id())) {
						isMember = true;
						break;
					}
				}
			}
			
			if(isMember == false) { //ä�ù� ��� �ƴ�
				if(headcount == max) { //������ �� �� ���
					model.addAttribute("isFull", "yes");
					return getPage;
				}else { //������ ���� ���
					System.out.println(chat_no+"/"+users.getUser_no()+"/"+users.getId());
					ChatMemberBean member = new ChatMemberBean(0, chat_no, users.getUser_no(), users.getId(), 0);
					int cnt =  chatMemberDao.insertMember(member);
					if(cnt > 0) { 
						//ä�ù� �����ϸ� �޼��� ����
						String content = users.getId()+"���� �����߽��ϴ�.";
						ChatMessageBean message = new ChatMessageBean(0, chat_no, 1, "info", content, ""); //user_no�� 1��, user_id�� 'info'�� ����
						chatMessageDao.writeMessage(message);
						
						//jsp ���� �����Ѵٰ� �˸�
						model.addAttribute("isNew", "new");
						
						//ä�ù� headcount +1 �ϱ�
						chatDao.updateHeadcount(chat_no);
						chatInfo.setHeadcount(headcount+1);
					}
				}
			}
		}//������ �ƴ�
		
		model.addAttribute("mlists", mlists);
		session.setAttribute("chatInfo", chatInfo);
		
		return getPage;
	}
}
