package com.exam.serviceimpl;


import org.springframework.transaction.annotation.Transactional;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.exam.dao.RoleDao;
import com.exam.dao.UserDao;
import com.exam.entity.Role;
import com.exam.entity.User;
import com.exam.service.UserService;

@Service
@Transactional
public class UserServiceImpl implements UserService {
	
	@Autowired
	private UserDao userDao;
	@Autowired
	private RoleDao roleDao;
	@Autowired
	private PasswordEncoder passwordEncoder;

	@Override
	public String register(User user) {
		
		user.setStatus(true);
		Role role= roleDao.findByID(2); // Baad me isko improve karenge:
                                         //roleDao.findByName("STUDENT");

		user.setRole(role);
		// Ab password plaintext me save nahi hota, BCrypt se hash hoke jaata hai
		user.setPassword(passwordEncoder.encode(user.getPassword()));

		String studentId = generateStudentId();
		user.setStudentId(studentId);

		userDao.save(user);
		return studentId;
	}

	// STD<year><5-digit-sequence>, jaise STD202600001. Sequence har saal reset hoti hai
	// (existing students me se us saal ke sabse bade sequence number ke aage badhti hai).
	// NOTE: Ye demo/college-project scale ke liye theek hai; high-concurrency production
	// registration ke liye isko DB sequence/unique-constraint-retry se replace karna chahiye.
	private String generateStudentId() {
		int year = java.time.Year.now().getValue();
		String yearPrefix = "STD" + year;
		int maxSeq = 0;
		for (User existing : userDao.getAllStudents()) {
			String sid = existing.getStudentId();
			if (sid != null && sid.startsWith(yearPrefix)) {
				try {
					int seq = Integer.parseInt(sid.substring(yearPrefix.length()));
					if (seq > maxSeq) {
						maxSeq = seq;
					}
				} catch (NumberFormatException ignored) {
					// malformed/legacy value, skip
				}
			}
		}
		return yearPrefix + String.format("%05d", maxSeq + 1);
	}

	

/*	@Override
	public User login(String email, String password) {
		User user=userDao.findByEail(email);
		if(user==null) 
		{
		    return null;
		}
		// Ab plain .equals() nahi, BCrypt matches() se compare hota hai
		if(!passwordEncoder.matches(password, user.getPassword())) 
		{
			return null;	
		}
//		if(!user.getStatus()) 
//		{
//	        return null;
//		}
//		
		
		return user;
	}*/

	@Override
	public String generateAndSendOtp(String email) {
		User user = userDao.findByEmail(email);
		if (user == null) {
			return null;
		}
		String otp = String.valueOf((int) (100000 + Math.random() * 900000)); // 6 digit OTP
		user.setResetOtp(otp);
		user.setOtpExpiryTime(System.currentTimeMillis() + (10 * 60 * 1000)); // 10 minute
		userDao.updateUser(user);
		return otp;
	}
	
	@Override
	public User login(String loginId, String password) {

	    System.out.println("LOGIN ID = [" + loginId + "]");

	    // Pehle Student ID se try karo (students isi se login karte hain),
	    // fallback email se (admin ke paas studentId nahi hota).
	    User user = userDao.findByStudentId(loginId);
	    if (user == null) {
	        user = userDao.findByEmail(loginId);
	    }

	    if (user == null) {
	        System.out.println("❌ USER NOT FOUND");
	        return null;
	    }

	    System.out.println("✅ USER FOUND");
	    System.out.println("DB EMAIL = [" + user.getEmail() + "]");
	    System.out.println("DB PASSWORD = [" + user.getPassword() + "]");
	    System.out.println("ENTERED PASSWORD = [" + password + "]");

	    boolean matched = passwordEncoder.matches(
	            password,
	            user.getPassword()
	    );

	    System.out.println("PASSWORD MATCH = " + matched);

	    if (!matched) {
	        System.out.println("❌ PASSWORD DOES NOT MATCH");
	        return null;
	    }

	    System.out.println("✅ LOGIN SUCCESS");

	    return user;
	}

	@Override
	public boolean verifyOtp(String email, String otp) {
		User user = userDao.findByEmail(email);
		if (user == null || user.getResetOtp() == null || user.getOtpExpiryTime() == null) {
			return false;
		}
		if (!user.getResetOtp().equals(otp)) {
			return false;
		}
		if (System.currentTimeMillis() > user.getOtpExpiryTime()) {
			return false; // OTP expire ho chuka
		}
		return true;
	}

	@Override
	public void resetPassword(String email, String newPassword) {
		User user = userDao.findByEmail(email);
		if (user != null) {
			user.setPassword(passwordEncoder.encode(newPassword));
			user.setResetOtp(null);
			user.setOtpExpiryTime(null);
			userDao.updateUser(user);
		}
	}



	@Override
	public List<User> getAllStudents() {
		
		return userDao.getAllStudents();
	}



	@Override
	public void changeStatus(Integer userId, boolean status) {
		userDao.changeStatus(userId, status);
		
	}



	@Override
	public void deleteStudent(Integer userId) {
		userDao.deleteStudent(userId);
		
	}



	@Override
	public User findByEmail(String email) {
		return userDao.findByEmail(email);
	}



	@Override
	public void updateUser(User user) {
		userDao.updateUser(user);
		
	}



	
	
	
	
}
