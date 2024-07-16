package review.model;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import users.model.UsersBean;
import utility.Paging;

@Service("myReviewDao")
public class ReviewDao {

	private String namespace = "review.model.Review";

	@Autowired
	SqlSessionTemplate sqlSessionTemplate;

	public ReviewDao() {
		System.out.println("reviewDao 생성자");
	}

	public int insertReview(ReviewBean review) {
		int cnt = -1;
		cnt = sqlSessionTemplate.insert(namespace + ".insertReview", review);
		return cnt;
	}

	public List<ReviewBean> getAllReview(int event_no) {
		List<ReviewBean> reviewLists = new ArrayList<ReviewBean>();
		reviewLists = sqlSessionTemplate.selectList(namespace + ".getAllReview", event_no);
		return reviewLists;
	}

	public double getAverageRating(int event_no) {
		Double avgRating = sqlSessionTemplate.selectOne(namespace + ".getAverageRating", event_no);
		return (avgRating == null) ? 0.0 : avgRating;
	}

	public int deleteReview(int review_no) {
		int cnt = -1;
		cnt = sqlSessionTemplate.delete(namespace + ".deleteReview", review_no);
		return cnt;
	}

	public int getTotalCount(Map<String, String> map) {
		int count = -1;
		count = sqlSessionTemplate.selectOne(namespace + ".getTotalCount", map);
		return count;
	}

	public List<ReviewBean> getReviewList(Map<String, String> map, Paging pageInfo) {
		List<ReviewBean> lists = new ArrayList<ReviewBean>();
		RowBounds rowBounds = new RowBounds(pageInfo.getOffset(), pageInfo.getLimit());
		lists = sqlSessionTemplate.selectList(namespace + ".getReviewList", map, rowBounds);

		return lists;
	}

}
