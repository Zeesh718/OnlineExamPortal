package com.exam.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.MappedSuperclass;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import com.exam.utility.RegisterGroup;


@Entity
@Table(name="users")
public class User {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer userId;
	// Sirf STUDENT role ke liye auto-generate hota hai (format: STD<year><5-digit seq>).
	// Admin ke liye ye null rehta hai, admin email se hi login karta hai.
	@Column(unique = true)
	private String studentId;
	@NotBlank(message = "Name is requred")
	@Size(min=3,max=30, message="Name must be between 3 and 30 characters")
	private String name;
	@NotBlank(message = "Email is required")
	@Column(unique=true)
	@Email(message = "Enter a valid email")
	private String email;
	@NotBlank(message = "Password is required", groups = RegisterGroup.class)
	@Size(min = 6, max = 20, message = "Password must be between 6 and 20 characters", groups = RegisterGroup.class)
	private String password;
	@NotBlank(message = "Mobile number is required", groups = RegisterGroup.class)
	@Pattern(regexp = "^[0-9]{10}$", message = "Mobile number must be 10 digits", groups = RegisterGroup.class)
	private String mobile;
	private boolean status;
	@ManyToOne  // manay user have one role isliye 
	@JoinColumn(name="role_id")
	private Role role;
	
	@OneToOne(mappedBy = "user")
	private UserProfile userProfile;  

	// Forgot Password OTP ke liye - reset flow ke dauran hi use hote hain
	private String resetOtp;
	private Long otpExpiryTime; // epoch millis, jab tak OTP valid rahega

	public User() {
		super();
	}
	public User(Integer userId, String name, String email, String password, String mobile, boolean status, Role role) {
		super();
		this.userId = userId;
		this.name = name;
		this.email = email;
		this.password = password;
		this.mobile = mobile;
		this.status = status;
		this.role = role;
	}
	public Integer getUserId() {
		return userId;
	}
	public void setUserId(Integer userId) {
		this.userId = userId;
	}
	public String getStudentId() {
		return studentId;
	}
	public void setStudentId(String studentId) {
		this.studentId = studentId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public boolean getStatus() {
		return status;
	}
	public void setStatus(boolean b) {
		this.status = b;
	}
	public Role getRole() {
		return role;
	}
	public void setRole(Role role) {
		this.role = role;
	}
	public String getResetOtp() {
		return resetOtp;
	}
	public void setResetOtp(String resetOtp) {
		this.resetOtp = resetOtp;
	}
	public Long getOtpExpiryTime() {
		return otpExpiryTime;
	}
	public void setOtpExpiryTime(Long otpExpiryTime) {
		this.otpExpiryTime = otpExpiryTime;
	}
}
