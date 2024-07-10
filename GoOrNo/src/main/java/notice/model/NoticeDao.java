package notice.model;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import utility.Paging;

@Component
public class NoticeDao {
	
	@Autowired
	SqlSessionTemplate sst;
	
	private String namespace = "notice";
	
	public int getTotalCount(Map<String, String> map) {
		int cnt = -1;
		cnt = sst.selectOne(namespace+".getTotalCount",map);
		return cnt;
	}

	public List<NoticeBean> getNoticeList(Map<String, String> map, Paging pageInfo) {
		List<NoticeBean> nlists = new ArrayList<NoticeBean>();
		RowBounds rowbounds = new RowBounds(pageInfo.getOffset(), pageInfo.getLimit());
		nlists = sst.selectList(namespace+".getNoticeList", map, rowbounds);
		return nlists;
	}

	public int insertNotice(NoticeBean notice) {
		int cnt = -1;
		cnt = sst.insert(namespace+".insertNotice", notice);
		return cnt;
	}

	public NoticeBean getNoticeByNo(int notice_no) {
		NoticeBean bb = null;
		bb = sst.selectOne(namespace+".getNoticeByNo",notice_no);
		return bb;
	}
	
	public void updateReadcount(int notice_no) {
		sst.update(namespace+".updateReadcount",notice_no);
	}

	public int updateNotice(NoticeBean notice) {
		int cnt = sst.update(namespace+".updateNotice", notice);
		return cnt;
	}

	public int deleteNotice(int notice_no) {
		System.out.println("¿©±â : "+notice_no);
		int cnt = sst.delete(namespace+".deleteNotice",notice_no);
		return cnt;
	}

}
