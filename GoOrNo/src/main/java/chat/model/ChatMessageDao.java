package chat.model;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.stereotype.Component;

@Component
public class ChatMessageDao {
	@Autowired
	SqlSessionTemplate sst;

	HttpSession session;
	
	private String namespace = "chat";
	
	public int writeMessage(ChatMessageBean chatMessage) {
		int cnt = -1;
		cnt = sst.insert(namespace+".writeMessage", chatMessage);
		return cnt;
	}

	public List<ChatMessageBean> getAllMessage(int chat_no) {
		System.out.println("chat_no : "+chat_no);
		List<ChatMessageBean> mlists = new ArrayList<ChatMessageBean>();
		mlists = sst.selectList(namespace+".getAllMessage", chat_no);
		return mlists;
	}
}