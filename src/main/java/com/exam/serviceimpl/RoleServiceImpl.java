package com.exam.serviceimpl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.exam.dao.RoleDao;
import com.exam.entity.Role;
import com.exam.service.RoleService;

import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class RoleServiceImpl implements RoleService {
    
	
	
	@Autowired
	private RoleDao roleDao;
	@Override
	public void save(Role role) {
		
		roleDao.save(role);
	}

}
