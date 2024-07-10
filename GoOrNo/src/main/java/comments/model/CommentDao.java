package comments.model;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class CommentDao {
	
	@Autowired
	SqlSessionTemplate sst;
	private String namespace = "comment";
	
	public int writeComment(CommentBean comment) {
		int cnt = -1;
		cnt = sst.insert(namespace+".writeComment", comment);
		return cnt;
	}

	public List<CommentBean> getAllComment(int board_no) {
		List<CommentBean> commentLists = new ArrayList<CommentBean>();
		commentLists = sst.selectList(namespace+".getAllComment", board_no);
		return commentLists;
	}

	public int deleteComment(int comment_no) {
		int cnt = -1;
		cnt = sst.insert(namespace+".deleteComment", comment_no);
		return cnt;
	}

}
