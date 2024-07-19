package alarm.model;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;

@Repository
public class AlarmDao {

	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	private String namespace = "alarm.model.Alarm";
	
	public AlarmDao() {
		System.out.println("-----AlarmDao()-----");
	}
	
	public List<AlarmBean> getAlarmByUser_no(int user_no){
		System.out.println("-----AlarmDao _getAlarmByUser_no()-----");
		
		List<AlarmBean> alarmList = new ArrayList<AlarmBean>();
		alarmList = sqlSessionTemplate.selectList(namespace + ".getAlarmByUser_no", user_no);
		
		System.out.println("alarmList: " + alarmList);
		
		return alarmList;
	}
	
	
	//insertAlarm
	public int insertAlarm(AlarmBean alarmBean) {
		System.out.println("-----AlarmDao _insertAlarm()-----");
		
		int cnt = -1;
		cnt = sqlSessionTemplate.insert(namespace + ".insertAlarm", alarmBean);
		
		return cnt;
	}
	
	//checkRead _읽음 여부 업데이트
	public int checkRead(int alarm_no) {
		System.out.println("-----AlarmDao _checkRead()-----");
		
		int cnt = -1;
		cnt = sqlSessionTemplate.update(namespace + ".checkRead", alarm_no);
		
		return cnt;
	}
	
	//deleteAlarm _알림 삭제
	public int deleteAlarm(int alarm_no) {
        System.out.println("-----AlarmDao _deleteAlarm()-----");
        
        int cnt = -1;
        cnt = sqlSessionTemplate.delete(namespace + ".deleteAlarm", alarm_no);
        
        return cnt;
    }
}