package faq.model;

import org.hibernate.validator.constraints.NotBlank;

public class FaqBean {
	private int faq_no;
	@NotBlank(message = "질문 내용을 입력하세요.")
	private String question;
	@NotBlank(message = "답변 내용을 입력하세요.")
	private String answer;
	private int readcount;
	private String regdate;
	public int getFaq_no() {
		return faq_no;
	}
	public void setFaq_no(int faq_no) {
		this.faq_no = faq_no;
	}
	public String getQuestion() {
		return question;
	}
	public void setQuestion(String question) {
		this.question = question;
	}
	public String getAnswer() {
		return answer;
	}
	public void setAnswer(String answer) {
		this.answer = answer;
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
