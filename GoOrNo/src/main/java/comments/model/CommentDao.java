package comments.model;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.stereotype.Component;

import alarm.model.AlarmBean;
import alarm.model.AlarmDao;
import board.model.BoardBean;
import board.model.BoardDao;

@Component
@ComponentScan(basePackages = {"alarm"})
public class CommentDao {
	
	@Autowired
	SqlSessionTemplate sst;
	
	@Autowired
    AlarmDao alarmDao;
	
	@Autowired
    BoardDao boardDao;
	
	private String namespace = "comment";
	
	public int writeComment(CommentBean comment) {
		int cnt = -1;
		cnt = sst.insert(namespace+".writeComment", comment);
		
		// 알림 생성
		if (cnt > 0) {
            BoardBean board = boardDao.getBoardByNo(comment.getBoard_no());
            
            if (board != null && board.getUser_no() != comment.getUser_no()) {
                AlarmBean alarm = new AlarmBean();
                alarm.setUser_no(board.getUser_no());
                alarm.setUser_id(comment.getUser_id());
                alarm.setMessage("'" + board.getSubject() + "' 에 댓글을 달았습니다.");
                alarm.setAlarm_type("board");
                alarm.setType_id(comment.getBoard_no());
                alarm.setRead(0);
                alarmDao.insertAlarm(alarm);
                
            }
        }
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
	
	//woo 추가 : user_no에 따른 댓글 list
	public List<CommentBean> getCommentsByUser_no(int user_no){
		List<CommentBean> commentsLists = new ArrayList<CommentBean>();
		commentsLists = sst.selectList(namespace + ".getCommentsByUser_no", user_no);
		
		for (CommentBean comment : commentsLists) {
			System.out.println("Comment ID: " + comment.getComment_no());
			System.out.println("Board Subject: " + comment.getBoard_subject());
		}
		
		
		return commentsLists;
	}//getCommentsByUser_no

}
