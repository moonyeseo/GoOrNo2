package notice.controller;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import notice.model.NoticeDao;

@Controller
public class NoticeDeleteController {
	private final String command = "delete.notice";
	private final String gotoPage = "redirect:/list.notice";

	@Autowired
	NoticeDao noticeDao;

	@RequestMapping(value = command)
	public String delete(
			Model model,
			@RequestParam(value = "notice_no", required = true) int notice_no,
			@RequestParam(value="isAdmin", required = false) String isAdmin,
			@RequestParam(value = "pageNumber", required = false) String pageNumber,
			@RequestParam(value = "whatColumn", required = false) String whatColumn,
			@RequestParam(value = "keyword", required = false) String keyword
			) throws IOException {
		
		model.addAttribute("keyword", keyword);
		model.addAttribute("pageNumber", pageNumber);
		model.addAttribute("whatColumn", whatColumn);
		
		int cnt = noticeDao.deleteNotice(notice_no);
		System.out.println("삭제 갯수 : " + cnt);
		
		//관리자 요청시 관리자 페이지로 이동
		if( isAdmin != null ) {
			model.addAttribute("isAdmin","yes");
		}

		return gotoPage;
	}

}
