package review.model;

public class ReviewBean {
	private int review_no;
	private int event_no;
	private int user_no;
	private String user_id;
	private String comments;
	private int rating;
	private String id;

	public ReviewBean() {

	}

	public int getReview_no() {
		return review_no;
	}

	public void setReview_no(int review_no) {
		this.review_no = review_no;
	}

	public int getEvent_no() {
		return event_no;
	}

	public void setEvent_no(int event_no) {
		this.event_no = event_no;
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

	public String getComments() {
		return comments;
	}

	public void setComments(String comments) {
		this.comments = comments;
	}

	public int getRating() {
		return rating;
	}

	public void setRating(int rating) {
		this.rating = rating;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public ReviewBean(int review_no, int event_no, int user_no, String user_id, String comments, int rating,
			String id) {
		super();
		this.review_no = review_no;
		this.event_no = event_no;
		this.user_no = user_no;
		this.user_id = user_id;
		this.comments = comments;
		this.rating = rating;
		this.id = id;
	}

}
