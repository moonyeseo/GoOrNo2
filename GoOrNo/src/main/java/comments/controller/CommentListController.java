package comments.controller;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import comments.model.CommentBean;
import comments.model.CommentDao;

@Controller
@ComponentScan(basePackages = {"comments","board"})
public class CommentListController {
	private final String command = "list.comments";
	@Autowired
	CommentDao commentDao;
	
	@RequestMapping(command)
	public @ResponseBody List<CommentBean> commentList(
			@RequestParam int board_no
			) throws IOException{
		
		//board/boardAdmin.jsp에서 게시글 제목 클릭 => ajax에서 board_no 가지고 요청
		System.out.println("넘어온 게시글번호 : "+board_no);
		
		//댓글 가져오기 메서드 호출
		List<CommentBean> commentLists = commentDao.getAllComment(board_no);
		
		return commentLists;
	}
}
