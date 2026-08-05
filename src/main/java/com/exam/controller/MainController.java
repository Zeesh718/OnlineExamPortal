package com.exam.controller;



import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.exam.entity.User;


@Controller
public class MainController {
	
	

	@GetMapping("/")
	public String home() {
		return "common/home";
	}
	
	@GetMapping("/about")
	public String about() {
		return "common/about";
	}
	
	@GetMapping("/login")
	public String login(Model model) {
		 model.addAttribute("user",new User());
		return "auth/login";
	}

	@GetMapping("/register")
	public String register(Model model) {
		model.addAttribute("user", new User());  // yaha se jsp me ek obj bheja jo ki wo waha ka data pura User Entity me bind ho jaye or hamre validations kam ar jaye 
		return "auth/register";
	}

}
