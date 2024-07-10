package report.model;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Component;

import utility.Paging;

@Component
public class ReportDao {
	@Autowired
	  SqlSessionTemplate sqlSessionTemplate;
	
	private String namespace = "report.model.Report";
	
// insert
	public int insertReport(ReportBean report) {
		int cnt = -1;
		
		try {
			cnt = sqlSessionTemplate.insert(namespace + ".insertReport", report);
			
		}catch(DataAccessException e) {
			System.out.println(e.getMessage());
		}
		
		return cnt;
	}
	
// select
	public List<ReportBean> getAllReport(Map<String, String> map, Paging pageInfo){
		RowBounds rowBounds = new RowBounds(pageInfo.getOffset(), pageInfo.getLimit());
		
		List<ReportBean> reportLists = sqlSessionTemplate.selectList(namespace + ".getAllReport", map, rowBounds);
		
		return reportLists;
	}
	
// select by no
	public ReportBean getReport(ReportBean rb) {
		ReportBean report = sqlSessionTemplate.selectOne(namespace + ".getReport", rb);
		
		System.out.println(report.getSubject());
		System.out.println(report.getBoard_no());
		System.out.println(report.getUser_no());
		
		return report;
	}
	
// update
	public void updateCheck(int re_no) {
		sqlSessionTemplate.update(namespace + ".updateCheck", re_no);
	}
	
// delete
	public void deleteReport(int re_no) {
		sqlSessionTemplate.delete(namespace + ".deleteReport", re_no);
	}
	
// select total count
	public int getTotalCount(Map<String, String> map) {
		int cnt = sqlSessionTemplate.selectOne(namespace + ".getTotalCount", map);
		
		return cnt;
	}
}
