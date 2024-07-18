package bookmark.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class BookmarkDao {
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	private String namespace = "bookmark.model.Bookmark";
	
	// select by user_no
	public List<BookmarkBean> getSearchBookmark(int users_no){
		List<BookmarkBean> bookmarkLists = sqlSessionTemplate.selectList(namespace + ".getSearchBookmark", users_no);
				
		return bookmarkLists;
	}
	
	/*	woo 추가 */
	//insertBookmark
	public int insertBookmark(BookmarkBean bookmarkBean) {
		
//		System.out.println("-----BookmarkDao _insertBookmark()-----");
//		System.out.println("Insert book_no: " + bookmarkBean.getUser_no());
//		System.out.println("Delete user_no: " + bookmarkBean.getUser_no());
//		System.out.println("Delete type: " + bookmarkBean.getType());
//		System.out.println("Delete b_addr: " + bookmarkBean.getB_addr());
//		System.out.println("Delete b_post: " + bookmarkBean.getB_post());
		
		int cnt = -1;
		cnt = sqlSessionTemplate.insert(namespace + ".insertBookmark", bookmarkBean);
		
		return cnt;
	}
	
	//getBookmarkByUserNoAndType
	public BookmarkBean getBookmarkByUserNoAndType(int user_no, String type) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("user_no", user_no);
		map.put("type", type);
		
		BookmarkBean bookmarkBean = sqlSessionTemplate.selectOne(namespace+".getBookmarkByUserNoAndType", map);
		
		return bookmarkBean;
	}
	
	//updateBookmark
	public int updateBookmark(BookmarkBean bookmarkBean) {
		
//		System.out.println("-----BookmarkDao _updateBookmark()-----");
//		System.out.println("Update book_no: " + bookmarkBean.getBook_no());
//		System.out.println("Update user_no: " + bookmarkBean.getUser_no());
//		System.out.println("Update type: " + bookmarkBean.getType());
//		System.out.println("Update b_addr: " + bookmarkBean.getB_addr());
//		System.out.println("Update b_post: " + bookmarkBean.getB_post());
		
		int cnt = -1;
		cnt = sqlSessionTemplate.update(namespace + ".updateBookmark", bookmarkBean);
		
//		System.out.println("update cnt : " + cnt);
		
		return cnt;
	}
	
	//deleteBookmark
	public int deleteBookmark(int book_no, int user_no, String type) {
		
//		System.out.println("-----BookmarkDao _deleteBookmark()-----");
//		System.out.println("Delete book_no: " + book_no);
//		System.out.println("Delete user_no: " + user_no);
//		System.out.println("Delete type: " + type);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("book_no", book_no);
		map.put("user_no", user_no);
		map.put("type", type);

		
		int cnt = -1;
		cnt = sqlSessionTemplate.delete(namespace + ".deleteBookmark", map);
		
//		System.out.println("delete cnt : " + cnt);
		
		return cnt;
	}
}