package com.exam.dao;

import com.exam.entity.UserProfile;

public interface UserProfileDao {
	
	public UserProfile profileFindByUserId(Integer userId);
	
	


	public void saveUserProfile(UserProfile userProfile);



	public void updateUserProfile(UserProfile userProfile);



	//public void updateUserProfile(UserProfile userProfile);

}
