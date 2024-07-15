package favorite.model;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import utility.Paging;


@Component
public class FavoriteDao {
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	private String namespace = "favorite.model.Favorite";
	
	//getFavoriteByUser_no
	public List<FavoriteBean> getFavoriteByUser_no(int user_no){
		
		List<FavoriteBean> favoriteList = new ArrayList<FavoriteBean>();
		favoriteList = sqlSessionTemplate.selectList(namespace + ".getFavoriteByUser_no", user_no);
		
		return favoriteList;
	}
	
	//insertFavorite
	public int insertFavorite(FavoriteBean favoriteBean) {
		
		System.out.println("-----FavoriteDao _insertFavorite()-----");
		System.out.println("Insert favorite_no : " + favoriteBean.getFavorite_no());
		System.out.println("Insert event_no : " + favoriteBean.getEvent_no());
		System.out.println("Insert user_no : " + favoriteBean.getUser_no());
		
		int cnt = -1;
		cnt = sqlSessionTemplate.insert(namespace + ".insertFavorite", favoriteBean);
		
		return cnt;
	}
	
	//deleteFavorite
	public int deleteFavorite(int favorite_no, int event_no, int user_no) {
		
		System.out.println("-----FavoriteDao _deleteFavorite()-----");
		System.out.println("Delete favorite_no: " + favorite_no);
		System.out.println("Delete event_no: " + event_no);
		System.out.println("Delete user_no: " + user_no);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("favorite_no", favorite_no);
		map.put("event_no", event_no);
		map.put("user_no", user_no);
		
		int cnt = -1;
		cnt = sqlSessionTemplate.delete(namespace + ".deleteFavorite", map);
		
		System.out.println("delete cnt : " + cnt);
		
		return cnt;
	}
}