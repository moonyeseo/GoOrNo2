package chat.model;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.stereotype.Component;

@Component
public class ChatMemberDao {
	@Autowired
	SqlSessionTemplate sst;
	
	private String namespace = "chat";

	public int insertMember(ChatMemberBean member) {
		int cnt = -1;
		cnt = sst.insert(namespace+".insertMember", member);
		return cnt;
	}

	public List<ChatMemberBean> getMemberList(int chat_no) {
		List<ChatMemberBean> memberLists = new ArrayList<ChatMemberBean>();
		memberLists = sst.selectList(namespace+".getMemberList", chat_no);
		return memberLists;
	}
}