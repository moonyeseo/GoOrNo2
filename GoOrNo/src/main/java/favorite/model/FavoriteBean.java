package favorite.model;

public class FavoriteBean {
	private int favorite_no;
	private int event_no;
	private int user_no;
	private String performance_type;
	private String title;
	private String place;
	private String event_period;
	private String img;
	private int rating;
	
	public int getFavorite_no() {
		return favorite_no;
	}
	public void setFavorite_no(int favorite_no) {
		this.favorite_no = favorite_no;
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
	public String getPerformance_type() {
		return performance_type;
	}
	public void setPerformance_type(String performance_type) {
		this.performance_type = performance_type;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getPlace() {
		return place;
	}
	public void setPlace(String place) {
		this.place = place;
	}
	public String getEvent_period() {
		return event_period;
	}
	public void setEvent_period(String event_period) {
		this.event_period = event_period;
	}
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}
	public int getRating() {
		return rating;
	}
	public void setRating(int rating) {
		this.rating = rating;
	}
}