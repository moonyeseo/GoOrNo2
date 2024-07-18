package users.model;

import org.hibernate.validator.constraints.Email;
import org.hibernate.validator.constraints.NotBlank;
import org.hibernate.validator.constraints.NotEmpty;
import org.springframework.web.multipart.MultipartFile;

public class UsersBean {
	private int user_no;
	private String id;
	private String pw;
	private String gender;
	private String email;
	private String name;
	private String profile;
	private String phoneNum;
	private String postcode;
	private String address;

	private MultipartFile upload;
	private String upload2;

	public UsersBean() {

	}

	public MultipartFile getUpload() {
		return upload;
	}

	public void setUpload(MultipartFile upload) {
		System.out.println("setUpload()");
		System.out.println("upload:" + upload);

		this.upload = upload;
		if (this.upload != null) {
			System.out.println(upload.getName());
			System.out.println(upload.getOriginalFilename());
			profile = upload.getOriginalFilename();
		}

	}
	
	public String getUpload2() {
		return upload2;
	}

	public void setUpload2(String upload2) {
		this.upload2 = upload2;
	}

	public int getUser_no() {
		return user_no;
	}

	public void setUser_no(int user_no) {
		this.user_no = user_no;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPw() {
		return pw;
	}

	public void setPw(String pw) {
		this.pw = pw;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getProfile() {
		return profile;
	}

	public void setProfile(String profile) {
		this.profile = profile;
	}

	public String getPhoneNum() {
		return phoneNum;
	}

	public void setPhoneNum(String phoneNum) {
		this.phoneNum = phoneNum;
	}

	public String getPostcode() {
		return postcode;
	}

	public void setPostcode(String postcode) {
		this.postcode = postcode;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public UsersBean(int user_no, String id, String pw, String gender, String email, String profile, String phoneNum,
			String postcode, String address) {
		super();
		this.user_no = user_no;
		this.id = id;
		this.pw = pw;
		this.gender = gender;
		this.email = email;
		this.profile = profile;
		this.phoneNum = phoneNum;
		this.postcode = postcode;
		this.address = address;

	}
}

