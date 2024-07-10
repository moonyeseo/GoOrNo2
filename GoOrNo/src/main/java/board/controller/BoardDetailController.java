package board.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import board.model.BoardBean;
import board.model.BoardDao;
import comments.model.CommentBean;
import comments.model.CommentDao;
import users.model.UsersDao;

@Controller
@ComponentScan(basePackages = {"board","users","comments"})
public class BoardDetailController {
	private final String command = "detail.board";
	private final String getPage = "boardDetailView";
	
	@Autowired
	BoardDao boardDao;
	@Autowired
	CommentDao commentDao;
	@Autowired
	UsersDao usersDao;
	
	@RequestMapping(value=command)
	public String detail(
			Model model,
			HttpSession session,
			@RequestParam(value="board_no", required = true) int board_no,
			@RequestParam(value="pageNumber", required = false) String pageNumber,
			@RequestParam(value="whatColumn", required = false) String whatColumn,
			@RequestParam(value="keyword", required = false) String keyword
			) {
		boardDao.updateReadcount(board_no);
		BoardBean bb = boardDao.getBoardByNo(board_no);
		model.addAttribute("board", bb);
		
		//댓글 목록 불러오기
		List<CommentBean> commentLists = commentDao.getAllComment(board_no); //게시판 번호로 댓글 목록 가져옴
		
		model.addAttribute("commentLists", commentLists);
		
		return getPage;
	}
	
}
