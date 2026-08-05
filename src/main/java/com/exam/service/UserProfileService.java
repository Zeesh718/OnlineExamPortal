package com.exam.service;

import com.exam.entity.UserProfile;

public interface UserProfileService {

    UserProfile profileFindByUserId(Integer userId);

    void saveUserProfile(UserProfile userProfile);

    

	

	void updateUserProfile(UserProfile userProfile);
}