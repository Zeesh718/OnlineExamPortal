package com.exam.service;

import java.util.List;

import com.exam.entity.User;

public interface UserService {
	
	// Return value: naya generate hua Student ID (registration email me bhejne ke liye)
	public String register(User user);
	// loginId ya to Student ID ho sakta hai ya email (admin ke paas studentId nahi hota)
	public User login(String loginId, String password);
	
	public List<User> getAllStudents();
	
	public void changeStatus(Integer userId, boolean Status);
	public void deleteStudent(Integer userId);
	
	public User findByEmail(String email);
	
	public void updateUser(User user);

	// Forgot Password flow
	public String generateAndSendOtp(String email);
	public boolean verifyOtp(String email, String otp);
	public void resetPassword(String email, String newPassword);
}
