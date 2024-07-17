package chat.controller;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import chat.model.ChatBean;
import chat.model.ChatDao;
import chat.model.ChatMemberBean;
import chat.model.ChatMemberDao;
import users.model.UsersBean;
import users.model.UsersDao;

@Controller
@ComponentScan(basePackages = {"chat","users"})
public class ChatInsertController {
	private final String command = "/insert.chat";
	private String getPage = "chatInsertForm";
	private String gotoPage = "redirect:/room.chat";
	
	@Autowired
	ChatDao chatDao;
	
	@Autowired
	ChatMemberDao chatMemberDao;
	
	@Autowired
	UsersDao usersDao;
	
	@RequestMapping(value = command, method = RequestMethod.GET)
	private String insertForm() {
		return getPage;
	}

	@RequestMapping(value = command, method = RequestMethod.POST)
	private String insert(
			Model model,
			@ModelAttribute("chat") @Valid ChatBean chat,
			@RequestParam("user_id") String user_id
			) {
		System.out.println(chat.getAlias() + " / " + chat.getMaxcount() + "/" + user_id);
		
		//채팅방 생성
		int cnt = chatDao.insertChat(chat);
		
		if(cnt > 0) {
			System.out.println("채팅방 생성됨");
			//생성된 채팅방 번호 가져오기
			int chat_no = chatDao.getChatByMaxNo();
			
			//채팅방 생성한 유저 정보 가져오기
			UsersBean ub = usersDao.getById(user_id);
			
			//채팅방 멤버 목록에 유저 추가
			System.out.println(chat_no+"/"+ub.getUser_no()+"/"+user_id);
			ChatMemberBean member = new ChatMemberBean(0, chat_no, ub.getUser_no(), user_id, 1);
			int cnt2 =  chatMemberDao.insertMember(member);
			
			if(cnt2 > 0) {
				System.out.println("방장 설정 완료");
				model.addAttribute("chat_no", chat_no);
				return gotoPage;
			}else {
				System.out.println("채팅방 멤버 삽입 실패");
			}
		}
		
		return getPage;
	}
	
}
