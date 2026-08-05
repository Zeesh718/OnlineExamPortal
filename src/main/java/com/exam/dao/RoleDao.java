package com.exam.dao;

import org.springframework.stereotype.Repository;

import com.exam.entity.Role;


public interface RoleDao {
	public void save(Role role);
    public Role findByID(Integer roleId);
}
