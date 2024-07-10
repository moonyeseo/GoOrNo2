package board.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import board.model.BoardBean;
import board.model.BoardDao;
import users.model.UsersBean;

@Controller
public class BoardUpdateController {
	private final String command = "update.board";
	private final String getPage = "boardUpdateForm";
	private final String gotoPage = "redirect:/detail.board";

	@Autowired
	BoardDao boardDao;

	@RequestMapping(value = command, method = RequestMethod.GET)
	public String updateForm(Model model, HttpSession session, 
			@RequestParam(value = "board_no", required = true) int board_no,
			@RequestParam(value = "pageNumber", required = false) String pageNumber,
			@RequestParam(value = "whatColumn", required = false) String whatColumn,
			@RequestParam(value = "keyword", required = false) String keyword) {
		UsersBean mb = (UsersBean) session.getAttribute("loginInfo");
		if (mb == null) { // 로그인x
			model.addAttribute("keyword", keyword);
			model.addAttribute("pageNumber", pageNumber);
			model.addAttribute("whatColumn", whatColumn);

			String destination = "redirect:/update.board?board_no=" + board_no + "&pageNumber=" + pageNumber + "&whatColumn="
					+ whatColumn + "&keyword=" + keyword;
			session.setAttribute("destination", destination);
			return "redirect:/login.users";
		}
		BoardBean bb = boardDao.getBoardByNo(board_no);
		
		//DB에서는 줄바꿈이 <br>로 저장되어 있는게 폼에 그대로 출력되지 않게 다시 변경
		String contents = bb.getContent().replace("<br>","\r\n");
		bb.setContent(contents);
		
		model.addAttribute("board", bb);
		return getPage;
	}

	@RequestMapping(value = command, method = RequestMethod.POST)
	public String update(
			Model model,
			@ModelAttribute("board") @Valid BoardBean board,
			BindingResult result,
			@RequestParam(value = "pageNumber", required = false) String pageNumber,
			@RequestParam(value = "whatColumn", required = false) String whatColumn,
			@RequestParam(value = "keyword", required = false) String keyword
			) throws IOException {
		
		if (result.hasErrors()) {
			model.addAttribute("keyword", keyword);
			model.addAttribute("pageNumber", pageNumber);
			model.addAttribute("whatColumn", whatColumn);
			model.addAttribute("board", board);
			return getPage;
		}
		
		//줄바꿈 포함해서 DB에 저장되게 설정
		String contents = board.getContent().replace("\r\n", "<br>");
		board.setContent(contents);
		
		//제목, 내용만 수정
		int cnt = boardDao.updateBoard(board);
		System.out.println("수정 성공 갯수 : " + cnt);
		return gotoPage+"?board_no="+board.getBoard_no()+"&pageNumber="+pageNumber+"&keyword="+keyword+"&whatColumn="+whatColumn;
	}

}
