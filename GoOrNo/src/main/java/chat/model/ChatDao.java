package chat.model;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.stereotype.Component;

import utility.Paging;

@Component
public class ChatDao {
	@Autowired
	SqlSessionTemplate sst;
	
	private String namespace = "chat";
	
	public int getTotalCount(Map<String, String> map) {
		int cnt = -1;
		cnt = sst.selectOne(namespace+".getTotalCount", map);
		return cnt;
	}

	public List<ChatBean> getChatList(Map<String, String> map, Paging pageInfo) {
		List<ChatBean> clists = new ArrayList<ChatBean>();
		RowBounds rowbounds = new RowBounds(pageInfo.getOffset(), pageInfo.getLimit());
		clists = sst.selectList(namespace+".getChatList", map, rowbounds);
		return clists;
	}
	
	public int insertChat(ChatBean chat) {
		System.out.println(chat.getAlias()+"/"+chat.getMaxcount());
		int cnt = -1;
		cnt = sst.insert(namespace + ".insertChat", chat);
		return cnt;
	}

	public int getChatByMaxNo() {
		int chat_no = sst.selectOne(namespace+".getChatByMaxNo");
		return chat_no;
	}

	public ChatBean getChatByNo(int chat_no) {
		ChatBean chatInfo = sst.selectOne(namespace+".getChatByNo", chat_no);
		return chatInfo;
	}

	public void updateHeadcount(int chat_no) {
		sst.update(namespace+".updateHeadcount", chat_no);
	}

	public int deleteChat(int chat_no) {
		int cnt = -1;
		cnt = sst.delete(namespace+".deleteChat", chat_no);
		return cnt;
	}

	public int deleteChatMember(ChatBean chatInfo) {
		System.out.println("deleteChatMember() : "+chatInfo.getChat_no()+chatInfo.getUser_id());
		int cnt = -1;
		cnt = sst.delete(namespace+".deleteChatMember", chatInfo);
		
		//update headcount -1
		if(cnt > 0){
			sst.update(namespace+".downHeadcount", chatInfo);
		}
		return cnt;
	}
	
	/* woo 추가 */
	public List<ChatBean> getChatByUser_no(int user_no){
		return sst.selectList(namespace + ".getChatByUser_no", user_no);
	}
	
	public int getChatCountByUser_no(int user_no) {
		return sst.selectOne(namespace + ".getChatCountByUser_no", user_no);
	}
}