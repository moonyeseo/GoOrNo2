package bookmark.model;

public class BookmarkBean {
	private int book_no;
	private int user_no;
	private String type;
	private String b_addr;
	private String b_post;
	
	public int getBook_no() {
		return book_no;
	}
	public void setBook_no(int book_no) {
		this.book_no = book_no;
	}
	public int getUser_no() {
		return user_no;
	}
	public void setUser_no(int user_no) {
		this.user_no = user_no;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getB_addr() {
		return b_addr;
	}
	public void setB_addr(String b_addr) {
		this.b_addr = b_addr;
	}
	public String getB_post() {
		return b_post;
	}
	public void setB_post(String b_post) {
		this.b_post = b_post;
	}
}
