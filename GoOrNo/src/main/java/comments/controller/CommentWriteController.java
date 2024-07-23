package comments.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import comments.model.CommentBean;
import comments.model.CommentDao;
import users.model.UsersBean;
import users.model.UsersDao;

@Controller
@ComponentScan(basePackages = {"comments","board","users"})
public class CommentWriteController {
	private final String command = "write.comments";
	@Autowired
	CommentDao commentDao;
	@Autowired
	UsersDao memberDao;
	
	@RequestMapping(command)
	public @ResponseBody List<CommentBean> commentWrite(
			HttpSession session,
			HttpServletResponse response,
			@ModelAttribute("comment") CommentBean comment
			) throws IOException{
		
		//board/detailView.jsp에서 댓글 작성 클릭 => ajax에서 3가지 정보 가지고 요청/*id는 가져올 필요 없음
		System.out.println("넘어온 게시글번호/댓작성자/댓내용 : "+comment.getBoard_no()+"/"+comment.getId()+"/"+comment.getContent());
		
		//현재 로그인한 유저 정보로 user_no, user_id 가져와서 댓글 정보에 set
		UsersBean mb = (UsersBean)session.getAttribute("loginInfo");
		comment.setUser_no(mb.getUser_no());
		comment.setUser_id(mb.getId());
		System.out.println("user_id : "+comment.getUser_id());
		
		//댓글 삽입 메서드 호출
		int cnt = commentDao.writeComment(comment);
		System.out.println("댓글 삽입 성공 갯수 : "+cnt);
		
		//댓글 삽입에 성공
		if(cnt > 0) {
			List<CommentBean> commentLists = commentDao.getAllComment(comment.getBoard_no());
			System.out.println("commentLists.get(0).getContent() : "+commentLists.get(0).getContent());
			return commentLists;
		}else {
			return null;
		}
	}
}
