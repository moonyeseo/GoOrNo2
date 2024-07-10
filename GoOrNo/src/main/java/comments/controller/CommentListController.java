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
		
		//board/boardAdmin.jsp���� �Խñ� ���� Ŭ�� => ajax���� board_no ������ ��û
		System.out.println("�Ѿ�� �Խñ۹�ȣ : "+board_no);
		
		//��� �������� �޼��� ȣ��
		List<CommentBean> commentLists = commentDao.getAllComment(board_no);
		
		return commentLists;
	}
}
