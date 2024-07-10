package qna.model;

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
public class QnaDao {
	
	@Autowired
	SqlSessionTemplate sst;
	
	private String namespace = "qna";
	
	public int getTotalCount(Map<String, String> map) {
		int cnt = -1;
		cnt = sst.selectOne(namespace+".getTotalCount",map);
		return cnt;
	}
	
	public int getOrgTotalCount(Map<String, String> map) {
		int cnt = -1;
		cnt = sst.selectOne(namespace+".getOrgTotalCount",map);
		System.out.println("getOrgTotalCount : "+cnt);
		return cnt;
	}

	public List<QnaBean> getQnaList(Map<String, String> map, Paging pageInfo) {
		List<QnaBean> qlists = new ArrayList<QnaBean>();
		RowBounds rowbounds = new RowBounds(pageInfo.getOffset(), pageInfo.getLimit());
		qlists = sst.selectList(namespace+".getQnaList", map, rowbounds);
		return qlists;
	}

	public List<QnaBean> getOrgQnaList(Map<String, String> map, Paging pageInfo) {
		List<QnaBean> qlists = new ArrayList<QnaBean>();
		RowBounds rowbounds = new RowBounds(pageInfo.getOffset(), pageInfo.getLimit());
		qlists = sst.selectList(namespace+".getOrgQnaList", map, rowbounds);
		return qlists;
	}

	public int insertQna(QnaBean qna) {
		int cnt = -1;
		cnt = sst.insert(namespace+".insertQna", qna);
		return cnt;
	}

	public QnaBean getQnaByNo(int qna_no) {
		QnaBean bb = null;
		bb = sst.selectOne(namespace+".getQnaByNo", qna_no);
		return bb;
	}
	
	public void updateReadcount(int qna_no) {
		sst.update(namespace+".updateReadcount",qna_no);
	}

	public int insertReply(QnaBean qna, int orgNo) {
		//��� �߰� ���� ref
		QnaBean bb = getQnaByNo(orgNo); //�������� ��ȣ�� ������ ���� ��������
		int ref = bb.getRef(); //�������� ref ������
		qna.setRef(ref); //�������� ref�� ����
		
		//�����ڸ� ��� �ۼ� ����
		qna.setUser_id("admin");
		qna.setUser_no(1);
		
		//��� ����
		int cnt = sst.insert(namespace+".insertReply", qna);
		
		//��� �ۼ��� �亯 ������ state = 1�� ����
		if(cnt > 0) {
			Map<String,Integer> map = new HashMap<String,Integer>();
			map.put("state", 1);
			map.put("no", orgNo);
			
			int cnt2 = sst.update(namespace+".updateState", map);
			System.out.println("state 1�� ������ ���� : "+cnt2);
		}
		return cnt;
	}

	public int updateQna(QnaBean qna) {
		int cnt = sst.update(namespace+".updateQna", qna);
		return cnt;
	}

	public int deleteQna(int qna_no) {
		//�� ���� ������
		QnaBean qb = getQnaByNo(qna_no);
		
		int cnt = sst.delete(namespace+".deleteQna",qna_no);

		if(cnt > 0) {// ���� ����
			//��� ������ ������ state = 0���� ����
			if(qb.getQna_no() != qb.getRef()) {
				Map<String,Integer> map = new HashMap<String,Integer>();
				map.put("state", 0);
				map.put("no", qb.getRef());
				
				int cnt2 = sst.update(namespace+".updateState", map);
				System.out.println("state 0�� ������ ���� : "+cnt2);
			}else { //������ ������ �亯�� ���� ����
				int ref = qna_no;
				sst.delete(namespace+".deleteReply",ref);
			}
		}
		return cnt;
	}

	public QnaBean getReplyByOrgNo(int qna_no) {
		QnaBean qb = null;
		qb = sst.selectOne(namespace+".getReplyByOrgNo", qna_no);
		return qb;
	}

}
