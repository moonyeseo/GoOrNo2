package comments.controller;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import comments.model.CommentDao;

@Controller
public class CommentsDeleteController {
	private final String command = "delete.comments";
	private final String gotoPage = "redirect:/detail.board";

	@Autowired
	CommentDao commentDao;

	@RequestMapping(value = command)
	public String delete(
			Model model,
			@RequestParam(value = "board_no", required = true) int board_no,
			@RequestParam(value = "comment_no", required = true) int comment_no,
			@RequestParam(value = "pageNumber", required = false) String pageNumber,
			@RequestParam(value = "whatColumn", required = false) String whatColumn,
			@RequestParam(value = "keyword", required = false) String keyword
			) throws IOException {
		
		model.addAttribute("keyword", keyword);
		model.addAttribute("pageNumber", pageNumber);
		model.addAttribute("whatColumn", whatColumn);
		model.addAttribute("board_no", board_no);
		
		int cnt = commentDao.deleteComment(comment_no);
		System.out.println("´ñ±Û »èÁ¦ °¹¼ö : " + cnt);
		return gotoPage;
	}

}
