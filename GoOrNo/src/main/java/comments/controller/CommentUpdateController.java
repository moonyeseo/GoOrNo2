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
public class CommentUpdateController {
	private final String command = "update.comments";
	@Autowired
	CommentDao commentDao;
	@Autowired
	UsersDao memberDao;
	
	@RequestMapping(command)
	public @ResponseBody List<CommentBean> commentUpdate(
			HttpSession session,
			HttpServletResponse response,
			@ModelAttribute("comment") CommentBean comment
			) throws IOException{
		
		//board/detailView.jsp���� ��� ���� Ŭ�� => ajax���� 3���� ���� ������ ��û
		System.out.println("�Ѿ�� ��۹�ȣ/���ۼ���/�񳻿� : "+comment.getComment_no()+"/"+comment.getId()+"/"+comment.getContent());
		
		//���� �α����� ���� ������ user_no, user_id �����ͼ� ��� ������ set
		UsersBean mb = (UsersBean)session.getAttribute("loginInfo");
		comment.setUser_no(mb.getUser_no());
		comment.setUser_id(mb.getId());
		System.out.println("user_id : "+comment.getUser_id());
		
		//��� ���� �޼��� ȣ��
		int cnt = commentDao.updateComment(comment);
		System.out.println("��� ���� ���� ���� : "+cnt);
		
		//��� ������ ����
		if(cnt > 0) {
			List<CommentBean> commentLists = commentDao.getAllComment(comment.getBoard_no());
			System.out.println("commentLists.get(0).getContent() : "+commentLists.get(0).getContent());
			return commentLists;
		}else {
			return null;
		}
	}
}
