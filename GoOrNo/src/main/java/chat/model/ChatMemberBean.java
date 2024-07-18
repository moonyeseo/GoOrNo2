package chat.model;

public class ChatMemberBean {
	private int member_no;
	private int chat_no;
	private int user_no;
	private String user_id;
	private int owner;
	
	public ChatMemberBean() {};
	public ChatMemberBean(int member_no, int chat_no, int user_no, String user_id, int owner) {
		super();
		this.member_no = member_no;
		this.chat_no = chat_no;
		this.user_no = user_no;
		this.user_id = user_id;
		this.owner = owner;
	}
	public int getMember_no() {
		return member_no;
	}
	public void setMember_no(int member_no) {
		this.member_no = member_no;
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
	public int getOwner() {
		return owner;
	}
	public void setOwner(int owner) {
		this.owner = owner;
	}
}
