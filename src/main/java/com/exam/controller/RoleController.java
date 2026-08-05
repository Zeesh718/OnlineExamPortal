package com.exam.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import com.exam.entity.Role;
import com.exam.service.RoleService;

@Controller
public class RoleController {

    @Autowired
    private RoleService roleService;

    @GetMapping("/addRole")
    public String addRole() {

        Role role = new Role();
        role.setRoleName("ADMIN");

        roleService.save(role);

        return "home";
    }

}