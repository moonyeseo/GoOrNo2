package users.Controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import board.model.BoardBean;
import board.model.BoardDao;
import bookmark.model.BookmarkBean;
import bookmark.model.BookmarkDao;
import comments.model.CommentBean;
import comments.model.CommentDao;
import favorite.model.FavoriteBean;
import favorite.model.FavoriteDao;
import qna.model.QnaBean;
import qna.model.QnaDao;
import users.model.UsersBean;
import users.model.UsersDao;
import utility.Paging;

@Controller
@ComponentScan(basePackages = {"board","users","comments", "bookmark", "favorite", "qna"})
public class mypageController {

	@Autowired
	private UsersDao usersDao;
	
	@Autowired
    private BookmarkDao bookmarkDao;
	
	@Autowired
	private FavoriteDao favoriteDao;
	
	@Autowired
	private BoardDao boardDao;
	
	@Autowired
	private CommentDao commentDao;
	
	@Autowired
	private QnaDao qnaDao;
	
	private final String command = "/myPage.users";
	private final String getPage = "myPage";
	
	@RequestMapping(command)

	public String mypage(
						@RequestParam("user_no") int user_no,
						Model model, HttpSession session, HttpServletRequest request) {
		
		System.out.println("-----mypageController()-----");
		System.out.println("user_no: " + user_no);

		
		if(session.getAttribute("loginInfo") == null) { //로그인 안 했을 때
			
			session.setAttribute("destination", "redirect:/myPage.users?user_no=" + user_no);
			
			return "redirect:/loginForm.users";
			
		} else { //로그인 했을 때
			
			//회원 정보 가져오기
			UsersBean usersBean = usersDao.getByUserId(user_no);
			model.addAttribute("usersBean", usersBean);
			
			//bookmark 가져오기
			List<BookmarkBean> bookmarkList = bookmarkDao.getSearchBookmark(user_no);
            model.addAttribute("bookmarkList", bookmarkList);
			
            
            //favoirte 가져오기
            List<FavoriteBean> favoriteList = favoriteDao.getFavoriteByUser_no(user_no);
            model.addAttribute("favoriteList", favoriteList);
            
            
			//나의 qna 가져오기
			List<QnaBean> myQnaList = qnaDao.getQnaByUser_no(user_no);
			model.addAttribute("myQnaList", myQnaList);
			
			
			//내가 작성한 글 가져오기
            List<BoardBean> myBoardList = boardDao.getBoardByUser_no(user_no);
            model.addAttribute("myBoardList", myBoardList);
			
            //내가 작성한 댓글 가져오기
            List<CommentBean> myCommentList = commentDao.getCommentsByUser_no(user_no);
            model.addAttribute("myCommentList", myCommentList);
            
			return getPage;
		}
	}
}