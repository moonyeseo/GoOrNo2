package users.Controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import chat.model.ChatBean;
import chat.model.ChatDao;
import comments.model.CommentBean;
import comments.model.CommentDao;
import favorite.model.FavoriteBean;
import favorite.model.FavoriteDao;
import qna.model.QnaBean;
import qna.model.QnaDao;
import review.model.ReviewDao;
import users.model.UsersBean;
import users.model.UsersDao;

@Controller
@ComponentScan(basePackages = {"board", "users","comments", "bookmark", "favorite", "qna", "chat", "review"})
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
	
	@Autowired
	private ChatDao chatDao;
	
	@Autowired
	private ReviewDao reviewDao;
	
	private final String command = "/myPage.users";
	private final String getPage = "myPage";
	
	@RequestMapping(command)

	public String mypage(
						@RequestParam("user_no") int user_no,
						Model model, HttpSession session, HttpServletRequest request) {
		
		System.out.println("-----mypageController()-----");
		System.out.println("user_no: " + user_no);

		
		if(session.getAttribute("loginInfo") == null) { //�α��� �� ���� ��
			
			session.setAttribute("destination", "redirect:/myPage.users?user_no=" + user_no);
			
			return "redirect:/loginForm.users";
			
		} else { //�α��� ���� ��
			
			//ȸ�� ���� ��������
			UsersBean usersBean = usersDao.getByUserId(user_no);
			model.addAttribute("usersBean", usersBean);
			
			
			//bookmark ��������
            List<BookmarkBean> bookmarkList = bookmarkDao.getSearchBookmark(user_no);
            Map<String, BookmarkBean> bookmarkMap = new HashMap<>();
            for (BookmarkBean bookmark : bookmarkList) {
                bookmarkMap.put(bookmark.getType(), bookmark);
            }
            model.addAttribute("bookmarkList", bookmarkMap);
			
            
            //favoirte ��������
            List<FavoriteBean> favoriteList = favoriteDao.getFavoriteByUser_no(user_no);
            Map<Integer, Double> avgRatingMap = new HashMap<>();
            for (FavoriteBean favorite : favoriteList) {
            	double avgRating = reviewDao.getAverageRating(favorite.getEvent_no());
            	avgRatingMap.put(favorite.getEvent_no(), avgRating);
            }
            model.addAttribute("favoriteList", favoriteList);
            model.addAttribute("avgRatingMap", avgRatingMap);
            
            
			//���� qna ��������
			List<QnaBean> myQnaList = qnaDao.getQnaByUser_no(user_no);
			model.addAttribute("myQnaList", myQnaList);
			
			
			//���� �ۼ��� �� ��������
            List<BoardBean> myBoardList = boardDao.getBoardByUser_no(user_no);
            model.addAttribute("myBoardList", myBoardList);
			
            
            //���� �ۼ��� ��� ��������
            List<CommentBean> myCommentList = commentDao.getCommentsByUser_no(user_no);
            model.addAttribute("myCommentList", myCommentList);
            
            
            //��ä�� ��������
            List<ChatBean> myChatList = chatDao.getChatByUser_no(user_no);
            model.addAttribute("myChatList", myChatList);
            
            
			return getPage;
		}
	}
}