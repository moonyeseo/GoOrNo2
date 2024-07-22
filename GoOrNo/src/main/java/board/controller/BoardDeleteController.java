package board.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import board.model.BoardBean;
import board.model.BoardDao;
import users.model.UsersBean;

@Controller
public class BoardDeleteController {
	private final String command = "delete.board";
	private final String gotoPage = "redirect:/list.board";

	@Autowired
	BoardDao boardDao;

	@RequestMapping(value = command)
	public String delete(
			Model model,
			@RequestParam(value = "board_no", required = true) int board_no,
			@RequestParam(value="isAdmin", required = false) String isAdmin,
			@RequestParam(value = "pageNumber", required = false) String pageNumber,
			@RequestParam(value = "whatColumn", required = false) String whatColumn,
			@RequestParam(value = "keyword", required = false) String keyword
			) throws IOException {
		
		model.addAttribute("keyword", keyword);
		model.addAttribute("pageNumber", pageNumber);
		model.addAttribute("whatColumn", whatColumn);
		
		int cnt = boardDao.deleteBoard(board_no);
		System.out.println("deleteBoard cnt : " + cnt);
		
		//goto admin page
		if( isAdmin != null ) {
			model.addAttribute("isAdmin","yes");
		}
		
		return gotoPage;
	}

}
