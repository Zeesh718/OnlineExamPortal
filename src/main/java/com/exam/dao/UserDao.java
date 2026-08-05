package com.exam.dao;

import java.util.List;

import org.hibernate.query.Query;

import com.exam.entity.User;
import com.exam.entity.UserProfile;

public interface UserDao  {
  
	public void save(User user);
	
	public User findByEmail(String email);
	
	public User findByStudentId(String studentId);
	
	public List<User> getAllStudents();
	
	public void changeStatus(Integer userId, boolean status);
	
	public void deleteStudent(Integer userId);

	public void updateUser(User user);
	
	
}
