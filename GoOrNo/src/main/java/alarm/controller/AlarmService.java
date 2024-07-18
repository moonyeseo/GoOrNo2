package alarm.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import alarm.model.AlarmBean;
import alarm.model.AlarmDao;

@Service
public class AlarmService {
	
	@Autowired
    private AlarmDao alarmDao;

    public List<AlarmBean> getUnreadAlarms(int user_no) {
    	List<AlarmBean> alarms = alarmDao.getAlarmByUser_no(user_no);
        
    	System.out.println("getUnreadAlarms: " + alarms);
        
    	return alarms;
    }

    public void checkRead(int alarm_no) {
        alarmDao.checkRead(alarm_no);
        alarmDao.deleteAlarm(alarm_no);
    }
}