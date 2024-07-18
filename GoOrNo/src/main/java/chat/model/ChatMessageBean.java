package chat.model;

public class ChatMessageBean {
	private int message_no;
	private int chat_no;
	private int user_no;
	private String user_id;
	private String content;
	private String sendTime;
	
	public ChatMessageBean() {};
	public ChatMessageBean(int message_no, int chat_no, int user_no, String user_id, String content, String sendTime) {
		super();
		this.message_no = message_no;
		this.chat_no = chat_no;
		this.user_no = user_no;
		this.user_id = user_id;
		this.content = content;
		this.sendTime = sendTime;
	}
	public int getMessage_no() {
		return message_no;
	}
	public void setMessage_no(int message_no) {
		this.message_no = message_no;
	}
	public int getChat_no() {
		return chat_no;
	}
	public void setChat_no(int chat_no) {
		this.chat_no = chat_no;
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
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getSendTime() {
		return sendTime;
	}
	public void setSendTime(String sendTime) {
		this.sendTime = sendTime;
	}
}