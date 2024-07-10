package notice.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import notice.model.NoticeBean;
import comments.model.CommentBean;
import comments.model.CommentDao;
import notice.model.NoticeDao;
import users.model.UsersDao;

@Controller
@ComponentScan(basePackages = {"notice","users","comments"})
public class NoticeDetailController {
	private final String command = "detail.notice";
	private final String getPage = "noticeDetailView";
	
	@Autowired
	NoticeDao noticeDao;
	@Autowired
	CommentDao commentDao;
	@Autowired
	UsersDao usersDao;
	
	@RequestMapping(value=command)
	public String detail(
			Model model,
			HttpSession session,
			@RequestParam(value="notice_no", required = true) int notice_no,
			@RequestParam(value="pageNumber", required = false) String pageNumber,
			@RequestParam(value="whatColumn", required = false) String whatColumn,
			@RequestParam(value="keyword", required = false) String keyword
			) {
		noticeDao.updateReadcount(notice_no);
		NoticeBean nb = noticeDao.getNoticeByNo(notice_no);
		model.addAttribute("notice", nb);
		
		return getPage;
	}
	
}
