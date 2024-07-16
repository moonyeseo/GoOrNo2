package alarm.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import alarm.model.AlarmBean;
import chat.model.ChatDao;
import users.model.UsersBean;


@Controller
public class AlarmController {

	@Autowired
    private AlarmService alarmService;
	
	@Autowired
    private ChatDao chatDao;
	
	@GetMapping("/alarms/unread")
    @ResponseBody
    public List<AlarmBean> getUnreadAlarms(HttpSession session) {
        UsersBean loginInfo = (UsersBean) session.getAttribute("loginInfo");
        if (loginInfo != null) {
        	List<AlarmBean> alarms = alarmService.getUnreadAlarms(loginInfo.getUser_no());
            
        	System.out.println("getUnreadAlarms controller: " + alarms);
            
        	return alarms;
        }
        return new ArrayList<>();
    }
	
	@PostMapping("/alarms/read")
    @ResponseBody
    public String checkRead(@RequestParam int alarm_no) {
        alarmService.checkRead(alarm_no);
        return "success";
    }
	
	@PostMapping("/notifications/chatCount")
    @ResponseBody
    public int getChatCount(HttpSession session) {
        UsersBean loginInfo = (UsersBean) session.getAttribute("loginInfo");
        if (loginInfo != null) {
            return chatDao.getChatCountByUser_no(loginInfo.getUser_no());
        }
        return 0;
    }
}