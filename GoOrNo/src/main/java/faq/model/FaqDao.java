package faq.model;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import utility.Paging;

@Component
public class FaqDao {
	
	@Autowired
	SqlSessionTemplate sst;
	
	private String namespace = "faq";
	
	public int getTotalCount(Map<String, String> map) {
		int cnt = -1;
		cnt = sst.selectOne(namespace+".getTotalCount",map);
		return cnt;
	}

	public List<FaqBean> getFaqList(Map<String, String> map, Paging pageInfo) {
		List<FaqBean> nlists = new ArrayList<FaqBean>();
		RowBounds rowbounds = new RowBounds(pageInfo.getOffset(), pageInfo.getLimit());
		nlists = sst.selectList(namespace+".getFaqList", map, rowbounds);
		return nlists;
	}

	public int insertFaq(FaqBean faq) {
		int cnt = -1;
		cnt = sst.insert(namespace+".insertFaq", faq);
		return cnt;
	}

	public FaqBean getFaqByNo(int faq_no) {
		FaqBean bb = null;
		bb = sst.selectOne(namespace+".getFaqByNo",faq_no);
		return bb;
	}
	
	public void updateReadcount(int faq_no) {
		sst.update(namespace+".updateReadcount",faq_no);
	}

	public int updateFaq(FaqBean faq) {
		int cnt = sst.update(namespace+".updateFaq", faq);
		return cnt;
	}

	public int deleteFaq(int faq_no) {
		System.out.println("¿©±â : "+faq_no);
		int cnt = sst.delete(namespace+".deleteFaq",faq_no);
		return cnt;
	}

}
