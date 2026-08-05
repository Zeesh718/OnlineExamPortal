package com.exam.controller;

import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.exam.entity.User;
import com.exam.entity.UserProfile;
import com.exam.service.MailService;
import com.exam.service.UserProfileService;
import com.exam.service.UserService;
import com.exam.utility.RegisterGroup;

@Controller
public class AuthController {
	
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private UserProfileService userProfileService;

	@Autowired
	private MailService mailService;
	
	
	@PostMapping("/register")
	public String register(@Validated(RegisterGroup.class) @ModelAttribute User user, BindingResult bindingResult,RedirectAttributes ra, Model model) throws UnsupportedEncodingException {
		
		/**@ModelAttribute object banata nahi hai. Wo kya karta hai?
		Request
		   ↓
		Spring
		   ↓
		new User()
		   ↓
		setName(...)
		setEmail(...)
		setPassword(...)
		   ↓
		Ready User Object

		Yani Spring internally setters call karta hai.

		Isliye:

		Default Constructor hona chahiye. ✅
		Getters/Setters hone chahiye. ✅

		Ye dono na ho to @ModelAttribute properly kaam nahi karega.   
		
		"User entity me jitni validation annotations lagi hain (@NotBlank, @Email, @Size), sabko check karo."
		Agar @Valid hi nahi likhoge...
		😄 To annotation lagane ka koi fayda hi nahi.
		
		# BindingResult bindingResult

		Ye ek report card hai. Validation hone ke baad Spring isme likh deta hai.
		Example :- User ne submit kiya.
		
		Name = "", Email = abc, Password = 12
		Validation hui.
		
		BindingResult ke andar aa gaya.
		
		Name Error
		Email Error
		Password Error
		
		**/
		
		if (bindingResult.hasErrors()) {
			return "auth/register";
		}
		User dbUser=userService.findByEmail(user.getEmail());
		if(dbUser!=null) {
			 model.addAttribute("emailError",
			            "Email already registered.");

			    return "auth/register";
		}
		String generatedStudentId = userService.register(user);

		// Registration ke baad welcome mail (async transaction se bahar, DB save fail hone se independent)
		mailService.sendWelcomeMail(user.getEmail(), user.getName(), generatedStudentId);

		ra.addFlashAttribute("registerMsg",
				"*Successfully Registered. Your Student ID is " + generatedStudentId
				+ " — use it to login. It has also been emailed to you.");
		ra.addFlashAttribute("generatedStudentId", generatedStudentId);
		
		return "redirect:/login";
	}
	
	@PostMapping("/login")
	public String login(
			@RequestParam("loginId") String loginId,
			@RequestParam("password") String password,
            HttpSession session,
            Model model) {
		
	   User dbUser= userService.login(loginId, password);
	   if(dbUser==null) 
	   {
		   model.addAttribute("inValidMsg","*Invalid Student ID/Email or Password");
		   return "auth/login";
	   }
	   
	   if(!dbUser.getStatus()){

		    model.addAttribute("inActiveMsg",
		            "Account is inactive");

		    return "auth/login";
		}
	  
	   // image kari header ke liye session me
	   session.setAttribute("loggedInUser", dbUser);
	   UserProfile profile =
		        userProfileService.profileFindByUserId(dbUser.getUserId());

		if(profile != null) {
		    session.setAttribute(
		        "loggedInUserProfileImage",
		        profile.getProfileImage()
		    );
		}
	   
		
		
		
	   if(dbUser.getRole().getRoleName().equals("ADMIN"))
	   {
		   return "redirect:/admin/dashboard";
	   }
	   
	  
	   else { // abhi elseme dala in future multiple role hue to multiple if else lagenge
		return "redirect:/student/dashboard";
	   }  
	}
	
	@GetMapping("/logout")
	public String logout(HttpSession session, RedirectAttributes ra) {
		session.invalidate();
		ra.addFlashAttribute("logOutMsg","*Successfully Logout");
		return "redirect:/login";
		
		
	}

	// ===================== FORGOT PASSWORD FLOW (Email OTP based) =====================

	@GetMapping("/forgotPassword")
	public String forgotPasswordPage() {
		return "auth/forgotPassword";
	}

	/*@PostMapping("/forgotPassword")
	public String forgotPasswordSubmit(@RequestParam String email, Model model, RedirectAttributes ra) throws UnsupportedEncodingException {

		User user = userService.findByEmail(email);
		if (user == null) {
			model.addAttribute("emailNotFoundMsg", "No account found with this email.");
			return "auth/forgotPassword";
		}

		String otp = userService.generateAndSendOtp(email);
		
		System.out.println(otp);
		mailService.sendOtpMail(email, user.getName(), otp);
		
		System.out.println("dfghjkljhgfdxcvbjkiuytfgvhjfgvjuytfgvhjf");
		ra.addFlashAttribute("otpSentMsg", "An OTP has been sent to your email.");
		ra.addAttribute("email", email);
		return "redirect:/verifyOtp";
	}*/
	@PostMapping("/forgotPassword")
	public String forgotPasswordSubmit(
	        @RequestParam String email,
	        Model model,
	        RedirectAttributes ra)
	        throws UnsupportedEncodingException {

	    System.out.println("1. FORGOT PASSWORD REQUEST = " + email);

	    User user = userService.findByEmail(email);

	    if (user == null) {
	        System.out.println("2. USER NOT FOUND");

	        model.addAttribute(
	            "emailNotFoundMsg",
	            "No account found with this email."
	        );

	        return "auth/forgotPassword";
	    }

	    System.out.println("2. USER FOUND = " + user.getEmail());

	    String otp = userService.generateAndSendOtp(email);

	    System.out.println("3. GENERATED OTP = [" + otp + "]");

	    // TEMPORARILY COMMENT THIS FOR DUMMY EMAILS
	    // mailService.sendOtpMail(email, user.getName(), otp);

	    System.out.println("4. OTP PROCESS COMPLETE");

	    ra.addFlashAttribute(
	        "otpSentMsg",
	        "OTP generated successfully."
	    );

	    ra.addAttribute("email", email);

	    return "redirect:/verifyOtp";
	}

	@GetMapping("/verifyOtp")
	public String verifyOtpPage(@RequestParam String email, Model model) {
		model.addAttribute("email", email);
		return "auth/verifyOtp";
	}

	@PostMapping("/verifyOtp")
	public String verifyOtpSubmit(@RequestParam String email, @RequestParam String otp, Model model, RedirectAttributes ra) {

		boolean valid = userService.verifyOtp(email, otp);
		if (!valid) {
			model.addAttribute("otpErrorMsg", "Invalid or expired OTP. Please try again.");
			model.addAttribute("email", email);
			return "auth/verifyOtp";
		}

		ra.addAttribute("email", email);
		return "redirect:/resetPassword";
	}

	@GetMapping("/resetPassword")
	public String resetPasswordPage(@RequestParam String email, Model model) {
		model.addAttribute("email", email);
		return "auth/resetPassword";
	}

	@PostMapping("/resetPassword")
	public String resetPasswordSubmit(@RequestParam String email, @RequestParam String password,
			@RequestParam String confirmPassword, Model model, RedirectAttributes ra) {

		if (password == null || password.length() < 6) {
			model.addAttribute("resetErrorMsg", "Password must be at least 6 characters.");
			model.addAttribute("email", email);
			return "auth/resetPassword";
		}

		if (!password.equals(confirmPassword)) {
			model.addAttribute("resetErrorMsg", "Passwords do not match.");
			model.addAttribute("email", email);
			return "auth/resetPassword";
		}

		userService.resetPassword(email, password);
		ra.addFlashAttribute("registerMsg", "*Password reset successful. Please login with your new password.");
		return "redirect:/login";
	}

}
