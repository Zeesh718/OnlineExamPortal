package com.exam.entity;


import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="roles")
public class Role {
	
	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer roleId;
	
	private String roleName;
	
	  public Role() {
	    }

	   

	    public Role(Integer roleId, String roleName) {
			super();
			this.roleId = roleId;
			this.roleName = roleName;
		}
	    
	    
	    public Integer getRoleId() {
	        return roleId;
	    }

		public void setRoleId(Integer roleId) {
	        this.roleId = roleId;
	    }

	    public String getRoleName() {
	        return roleName;
	    }

	    public void setRoleName(String roleName) {
	        this.roleName = roleName;
	    }

}
