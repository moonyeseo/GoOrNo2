package comments.controller;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import comments.model.CommentBean;
import comments.model.CommentDao;

@Controller
public class CommentsDeleteController {
	private final String command = "delete.comments";
	private final String gotoPage = "redirect:/detail.board";

	@Autowired
	CommentDao commentDao;

	@RequestMapping(value = command)
	public @ResponseBody List<CommentBean> delete(
			Model model,
			@RequestParam(value = "board_no", required = true) int board_no,
			@RequestParam(value = "comment_no", required = true) int comment_no
			) throws IOException {
		
		model.addAttribute("board_no", board_no);
		
		int cnt = commentDao.deleteComment(comment_no);
		System.out.println("´ñ±Û »èÁ¦ °¹¼ö : " + cnt);
		
		//´ñ±Û »èÁ¦ ¼º°ø
		if(cnt > 0) {
			List<CommentBean> commentLists = commentDao.getAllComment(board_no);
			System.out.println("commentLists.get(0).getContent() : "+commentLists.get(0).getContent());
			return commentLists;
		}else {
			return null;
		}
	}

}
