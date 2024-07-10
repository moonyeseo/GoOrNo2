package notice.model;

import org.hibernate.validator.constraints.NotBlank;

public class NoticeBean {
	private int notice_no;
	@NotBlank(message = "제목이 누락되었습니다.")
	private String subject;
	@NotBlank(message = "내용이 누락되었습니다.")
	private String content;
	private int readcount;
	private String regdate;
	public int getNotice_no() {
		return notice_no;
	}
	public void setNotice_no(int notice_no) {
		this.notice_no = notice_no;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getReadcount() {
		return readcount;
	}
	public void setReadcount(int readcount) {
		this.readcount = readcount;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	
}
