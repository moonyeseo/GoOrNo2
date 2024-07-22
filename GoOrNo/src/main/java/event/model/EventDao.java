package event.model;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import utility.Paging;


@Component("MyEventDao")
public class EventDao {
	@Autowired
    SqlSessionTemplate sqlSessionTemplate;
    private final String namespace = "event.model.Event";
    
    public EventDao() {
        System.out.println("EventDao 생성자"); 
    }
    
    // 행사 테이블 비우기
    public int truncateEvent() {
    	int cnt = sqlSessionTemplate.delete(namespace + ".truncateEvent");
    	System.out.println("truncate = " + cnt);
    	return cnt;
    }
    
    // 행사 등록
    public int insertEvent(EventBean event) {
    	System.out.println("test1");
    	int cnt = -1;
        
    	System.out.println("insertEvent()=======================");
        System.out.println("img : " + event.getImg());
        System.out.println("위도 : " + event.getLot());
        System.out.println("경도 : " + event.getLat());
        
    	cnt = sqlSessionTemplate.insert(namespace + ".insertEvent", event);
    	System.out.println("test2");
    	return cnt;
    	
    }

    // 목록
    public List<EventBean> getAllEvents(Map<String, String> map, Paging pageInfo) {
    	RowBounds rowBounds = new RowBounds(pageInfo.getOffset(), pageInfo.getLimit());
        List<EventBean> lists = sqlSessionTemplate.selectList(namespace + ".getAllEvents", map, rowBounds);
        
        System.out.println("lists.size() : " + lists.size());
        return lists;
    }
    
    // 카테고리
    public List<String> getPerformanceType() {
		List<String> lists = sqlSessionTemplate.selectList(namespace + ".getPerformanceType");
        System.out.println("lists.size() : " + lists.size());
        return lists;
    }
    
    // 번호로 조회
    public EventBean getEventByEventNo(int eventNo) {
    	EventBean event = null;
    	event = sqlSessionTemplate.selectOne(namespace + ".getEventByEventNo", eventNo);
    	return event;
    }
    
    // 전체 글
    public int getTotalCount(Map<String, String> map) {
    	int cnt = -1;
    	cnt = sqlSessionTemplate.selectOne(namespace + ".getTotalCount", map);
    	return cnt;
    }
    
    // 행사 수정
    public int updateEvent(EventBean event) {
    	int cnt = -1;
    	cnt = sqlSessionTemplate.update(namespace + ".updateEvent", event);
    	return cnt;
    }
    
    // 행사 삭제
    public int deleteEvent(int eventNo) {
    	int cnt = -1;
    	cnt = sqlSessionTemplate.delete(namespace + ".deleteEvent", eventNo);
    	return cnt;
    }
    
    // 업로드 파일
	public int insertFimg(EventBean event) {
		int cnt = -1;
    	cnt = sqlSessionTemplate.insert(namespace + ".insertFimg", event);
    	System.out.println("test2");
    	return cnt;
	}
	
	
	
}