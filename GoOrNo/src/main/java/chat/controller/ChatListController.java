package chat.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import chat.model.ChatBean;
import chat.model.ChatDao;
import chat.model.ChatMessageBean;
import chat.model.ChatMessageDao;
import users.model.UsersBean;
import utility.Paging;

@Controller
public class ChatListController {
	
	private final String command = "/list.chat";
	private String getPage = "chatList";
	
	@Autowired
	ChatDao chatDao;
	
	@Autowired
	ChatMessageDao chatMessageDao;
	
	@RequestMapping(command)
	private String main(
			Model model,
			HttpServletRequest request,
			@RequestParam(value="isAdmin", required = false) String isAdmin,
			@RequestParam(value="isFull", required = false) String isFull,
			@RequestParam(value="pageNumber", required = false) String pageNumber,
			@RequestParam(value="whatColumn", required = false) String whatColumn,
			@RequestParam(value="keyword", required = false) String keyword
			) {
		
		Map<String,String> map = new HashMap<String,String>();
		map.put("keyword", "%"+keyword+"%");
		map.put("whatColumn", whatColumn);
		
		System.out.println(whatColumn+"/"+keyword);
		
		int totalCount = chatDao.getTotalCount(map);
		String url = request.getContextPath()+this.command;
		Paging pageInfo = new Paging(pageNumber,"12",totalCount,url,null,keyword);
		
		List<ChatBean> clists = chatDao.getChatList(map, pageInfo);
		
		
		//마지막 채팅 메세지 추가
		for(int i = 0 ; i < clists.size() ; i++) {
			List<ChatMessageBean> mlists = chatMessageDao.getAllMessage(clists.get(i).getChat_no()); //chat_no로 메세지 리스트 가져오기
			if(mlists.size() > 0) {
				String lastChat = mlists.get(mlists.size()-1).getContent();
				clists.get(i).setLastChat(lastChat); //마지막 채팅 가져와서 clists에 삽입
			}else {
				clists.get(i).setLastChat("메세지가 존재하지 않습니다.");
			}
		}
		
		model.addAttribute("clists", clists);
		
		//관리자 요청시 관리자 페이지로 이동
		if( isAdmin != null ) {
			String html = pageInfo.getPagingHtml();
			html = html.replaceAll("\\?", "\\?isAdmin=yes&");
			pageInfo.setPagingHtml(html);
			model.addAttribute("pageInfo",pageInfo);
			return "chatAdmin";	
		}
		
		model.addAttribute("pageInfo",pageInfo);
		
        return getPage;
    }
	
	/* woo 추가 */
	//로그인한 유저가 참여 중인 채팅방 개수 추가
	@RequestMapping(value = "/chat/getChatCount", method = RequestMethod.POST)
    @ResponseBody
    public int getChatCount(HttpSession session) {
		System.out.println("--getChatCount--");
		
        UsersBean loginInfo = (UsersBean) session.getAttribute("loginInfo");
        
        if (loginInfo != null) {
        	System.out.println("user_no : " + loginInfo.getUser_no());
        	
            return chatDao.getChatCountByUser_no(loginInfo.getUser_no());
        }
        return 0;
    }

}