package alarm.model;

public class AlarmBean {
	private int alarm_no;
	private int user_no; //원글 작성자(로그인한 유저)
	private String user_id; //댓글or답글 단 유저의 id
	private String message;
	private String alarm_type;
	private int type_id;
	private int read;
	
	public int getAlarm_no() {
		return alarm_no;
	}
	public void setAlarm_no(int alarm_no) {
		this.alarm_no = alarm_no;
	}
	public int getUser_no() {
		return user_no;
	}
	public void setUser_no(int user_no) {
		this.user_no = user_no;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public String getAlarm_type() {
		return alarm_type;
	}
	public void setAlarm_type(String alarm_type) {
		this.alarm_type = alarm_type;
	}
	public int getType_id() {
		return type_id;
	}
	public void setType_id(int type_id) {
		this.type_id = type_id;
	}
	public int getRead() {
		return read;
	}
	public void setRead(int read) {
		this.read = read;
	}
}