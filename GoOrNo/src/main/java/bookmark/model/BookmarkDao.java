package bookmark.model;

import java.util.List;

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
}
