package com.exam.daoimpl;

import org.springframework.transaction.annotation.Transactional;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.exam.dao.RoleDao;
import com.exam.entity.Role;


@Repository
@Transactional
public class RoleDaoImpl implements RoleDao {

	
	@Autowired
	private SessionFactory sessionFactory;
	@Override
	public void save(Role role) {
		
		Session session= sessionFactory.getCurrentSession();
		session.save(role);
	}
	@Override
	public Role findByID(Integer roleId) {
		Session session = sessionFactory.getCurrentSession();
		
		return session.get(Role.class, roleId); //session.get() sirf Primary Key (ID) se record la sakta hai.
	}


}
