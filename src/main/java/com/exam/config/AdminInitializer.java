package com.exam.config;

import javax.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Component;

import com.exam.dao.RoleDao;
import com.exam.dao.UserDao;
import com.exam.entity.Role;
import com.exam.entity.User;

@Component
public class AdminInitializer {

    @Autowired
    private UserDao userDao;

    @Autowired
    private RoleDao roleDao;

    @Autowired
    private BCryptPasswordEncoder passwordEncoder;

    @PostConstruct
    public void createAdmin() {

        // Pehle check karo admin already exist karta hai ya nahi
        User existingAdmin = userDao.findByEmail("sayyedjishan187@gmail.com");

        if (existingAdmin != null) {
            System.out.println("Admin already exists.");
            return;
        }

        // ADMIN role DB se nikalo
        Role adminRole = roleDao.findByID(1); // apne actual ADMIN roleId ke hisab se

        User admin = new User();

        admin.setName("Admin");
        admin.setEmail("sayyedjishan187@gmail.com");
        admin.setMobile("9999999999");

        // IMPORTANT: BCrypt encoded password
        admin.setPassword(passwordEncoder.encode("Zeesh@718"));

        admin.setRole(adminRole);
        admin.setStatus(true);

        userDao.save(admin);

        System.out.println("Default admin created successfully.");
    }
}