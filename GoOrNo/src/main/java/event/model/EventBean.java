package event.model;

import org.hibernate.validator.constraints.NotBlank;
import org.hibernate.validator.constraints.NotEmpty;

public class EventBean {
    private int event_no;
    
    @NotBlank(message="유형을 선택하세요.")
    private String performance_type;
    
    @NotEmpty(message="제목을 입력하세요.")
    private String title;
    
    @NotEmpty(message="장소를 입력하세요.")
    private String place;
    
    @NotEmpty(message="기간을 입력하세요.")
    private String event_period;
    
    private String img;
    
    @NotEmpty(message="위도를 입력하세요.")
    private String lot;
    
    @NotEmpty(message="경도를 입력하세요.")
    private String lat;
    
	public EventBean() {
        System.out.println("EventBean 생성자");
    }
    
    //�׽�Ʈ

//    public EventBean(int event_no, String performance_type, String title, String place, String event_period, String img, String lot, String lat) {
//        this.event_no = event_no;
//        this.performance_type = performance_type;
//        this.title = title;
//        this.place = place;
//        this.event_period = event_period;
//        this.img = img;
//        this.lot = lot;
//        this.lat = lat;
//    }

    public int getEvent_no() {
        return event_no;
    }

    public void setEvent_no(int event_no) {
        this.event_no = event_no;
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

    public String getLot() {
        return lot;
    }

    public void setLot(String lot) {
        this.lot = lot;
    }

    public String getLat() {
        return lat;
    }

    public void setLat(String lat) {
        this.lat = lat;
    }
}
