package chat.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import chat.model.ChatBean;
import chat.model.ChatDao;
import chat.model.ChatMessageBean;
import chat.model.ChatMessageDao;
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
		
		
		//get last chat
		for(int i = 0 ; i < clists.size() ; i++) {
			List<ChatMessageBean> mlists = chatMessageDao.getAllMessage(clists.get(i).getChat_no()); //get messageList
			if(mlists.size() > 0) {
				String lastChat = mlists.get(mlists.size()-1).getContent();
				clists.get(i).setLastChat(lastChat); //save lastChat
			}else {// no messages
				clists.get(i).setLastChat("no last message.");
			}
		}
		
		model.addAttribute("clists", clists);
		
		//go to admin page
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
}
