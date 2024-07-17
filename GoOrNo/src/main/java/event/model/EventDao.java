package event.model;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import utility.Paging;


@Component("MyEventDao") // �� Ŭ������ Spring�� ������Ʈ�� �νĵǵ��� ��
public class EventDao {
	// Ŀ�� �׽�Ʈ
	@Autowired // ������ ������ ���� SqlSessionTemplate ��ü�� �ڵ����� ����
    SqlSessionTemplate sqlSessionTemplate;
    private final String namespace = "event.model.Event"; // MyBatis ���� ���ӽ����̽� ����
    
    public EventDao() {
        System.out.println("EventDao ������"); // ������: ��ü ���� �� �޽��� ���
    }
    
    // ��� ���̺� ����
    public int truncateEvent() {
    	int cnt = sqlSessionTemplate.delete(namespace + ".truncateEvent");
    	System.out.println("truncate = " + cnt);
    	return cnt;
    }
    
    // �̺�Ʈ �߰�
    public int insertEvent(EventBean event) {
    	System.out.println("test1");
    	int cnt = -1;
        
    	System.out.println("insertEvent()=======================");
        System.out.println("img : " + event.getImg());
        System.out.println("���� : " + event.getLot());
        System.out.println("�浵 : " + event.getLat());
        
    	cnt = sqlSessionTemplate.insert(namespace + ".insertEvent", event);
    	System.out.println("test2");
    	return cnt;
    	
    }

    // �̺�Ʈ ��ȸ
    public List<EventBean> getAllEvents(Map<String, String> map, Paging pageInfo) {
    	RowBounds rowBounds = new RowBounds(pageInfo.getOffset(), pageInfo.getLimit());
        List<EventBean> lists = sqlSessionTemplate.selectList(namespace + ".getAllEvents", map, rowBounds);
        
        System.out.println("lists.size() : " + lists.size());
        return lists;
    }
    
    // �̺�Ʈ �� ���� ��ȸ
    public List<String> getPerformanceType() {
		List<String> lists = sqlSessionTemplate.selectList(namespace + ".getPerformanceType");
        System.out.println("lists.size() : " + lists.size());
        return lists;
    }
    
    // �̺�Ʈ �� ��ȸ
    public EventBean getEventByEventNo(int eventNo) {
    	EventBean event = null;
    	event = sqlSessionTemplate.selectOne(namespace + ".getEventByEventNo", eventNo);
    	return event;
    }
    
    // �� �̺�Ʈ �� ��ȸ
    public int getTotalCount(Map<String, String> map) {
    	int cnt = -1;
    	cnt = sqlSessionTemplate.selectOne(namespace + ".getTotalCount", map);
    	return cnt;
    }
    
    // �̺�Ʈ ����
    public int updateEvent(EventBean event) {
    	int cnt = -1;
    	cnt = sqlSessionTemplate.update(namespace + ".updateEvent", event);
    	return cnt;
    }
    
    // �ش� ��ȣ ����
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