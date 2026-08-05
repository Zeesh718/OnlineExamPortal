package com.exam.daoimpl;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.exam.dao.UserProfileDao;
import com.exam.entity.UserProfile;

@Repository
@Transactional
public class UserProfileDaoImpl implements UserProfileDao {

	@Autowired
	private SessionFactory sessionFactory;
	
	
	@Override
	public UserProfile profileFindByUserId(Integer userId) {
		
		return  sessionFactory.getCurrentSession().createQuery("from UserProfile where user.userId=:userId",UserProfile.class).setParameter("userId", userId).uniqueResult();
	}


	


	@Override
	public void saveUserProfile(UserProfile userProfile) {
		 sessionFactory.getCurrentSession().save(userProfile);
		
	}


	@Override
	public void updateUserProfile(UserProfile userProfile) {
		 sessionFactory.getCurrentSession().update(userProfile);
		
	}





	
}
