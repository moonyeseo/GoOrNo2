package report.model;

import org.hibernate.validator.constraints.NotBlank;

public class ReportBean {
	private int re_no;
	private int board_no;
	private int user_no;
	
	@NotBlank(message = "신고 사유를 입력해야 신고가 접수됩니다.")
	private String why;
	
	private String reportdate;
	private String re_check;
	private String subject;
	
	private String id;
	
	private String content;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public void setUser_no(int user_no) {
		this.user_no = user_no;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getRe_check() {
		return re_check;
	}
	public void setRe_check(String re_check) {
		this.re_check = re_check;
	}
	public String getReportdate() {
		return reportdate;
	}
	public void setReportdate(String reportdate) {
		this.reportdate = reportdate;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public int getRe_no() {
		return re_no;
	}
	public void setRe_no(int re_no) {
		this.re_no = re_no;
	}
	public int getBoard_no() {
		return board_no;
	}
	public void setBoard_no(int board_no) {
		this.board_no = board_no;
	}
	public int getUser_no() {
		return user_no;
	}
	public String getWhy() {
		return why;
	}
	public void setWhy(String why) {
		this.why = why;
	}
}
