package event.model;

import org.hibernate.validator.constraints.NotBlank;
import org.hibernate.validator.constraints.NotEmpty;
import org.springframework.web.multipart.MultipartFile;

public class EventBean {
    private int event_no;
    
    @NotBlank(message="������ �����ϼ���.")
    private String performance_type;
    
    @NotEmpty(message="������ �Է��ϼ���.")
    private String title;
    
    @NotEmpty(message="��Ҹ� �Է��ϼ���.")
    private String place;
    
    @NotEmpty(message="��¥�� �����ϼ���.")
    private String event_period;
    
    private String img; // Api �̹���
    
    @NotEmpty(message = "���� ���� ����")
    private String fimg; // ���ε� ���� �̹���
    
    public String getFimg() {
		return fimg;
	}

	public void setFimg(String fimag) {
		this.fimg = fimag;
	}

	@NotEmpty(message="������ �Է��ϼ���.")
    private String lot;
    
    @NotEmpty(message="�浵�� �Է��ϼ���.")
    private String lat;
    
    // moonyeseo �߰�
    @NotEmpty(message="�ּҸ� �Է��ϼ���.")
    private String fullAddr;
    
    public String getFullAddr() {
		return fullAddr;
	}

	public void setFullAddr(String fullAddr) {
		this.fullAddr = fullAddr;
	}

	// �߰�
 	private MultipartFile upload;
 	private String upload2; // �����Ҷ� �����Ϸ��� ���ϸ�
    
	public EventBean() {
        System.out.println("EventBean ������");
    }
    
    public MultipartFile getUpload() {
		return upload;
	}

    public void setUpload(MultipartFile upload) {
		System.out.println("setUpload()");
		System.out.println("upload:" + upload); // org.springframework.web.multipart.commons.CommonsMultipartFile@51eb1299

		this.upload = upload;
		if(this.upload != null) {
			System.out.println(upload.getName()); // upload
			System.out.println(upload.getOriginalFilename()); 
			fimg = upload.getOriginalFilename(); 
		}
	}

	public String getUpload2() {
		return upload2;
	}

	public void setUpload2(String upload2) {
		this.upload2 = upload2;
	}

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