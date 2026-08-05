package com.exam.serviceimpl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.exam.dao.UserProfileDao;
import com.exam.entity.UserProfile;
import com.exam.service.UserProfileService;

@Service
@Transactional
public class UserProfileServiceImpl implements UserProfileService {

    @Autowired
    private UserProfileDao userProfileDao;

    @Override
    public UserProfile profileFindByUserId(Integer userId) {
        return userProfileDao.profileFindByUserId(userId);
    }

    @Override
    public void saveUserProfile(UserProfile userProfile) {
        userProfileDao.saveUserProfile(userProfile);
    }

    @Override
    public void updateUserProfile(UserProfile userProfile) {
        userProfileDao.updateUserProfile(userProfile);
    }

	
}