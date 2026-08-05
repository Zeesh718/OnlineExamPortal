package com.exam.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.exam.entity.Exams;
import com.exam.entity.Result;
import com.exam.entity.User;
import com.exam.service.ExamService;
import com.exam.service.QuestionService;
import com.exam.service.ResultService;
import com.exam.service.SubjectService;
import com.exam.service.UserService;
import com.exam.utility.PageResult;
import com.exam.utility.PageUtil;


@Controller
@RequestMapping("/admin")
public class AdminController {

	
	@Autowired
	private UserService userService;
	@Autowired
	private SubjectService subjectService;
	@Autowired
	private ExamService examService;
	@Autowired
	private QuestionService questionService;
	@Autowired
	private ResultService resultService;
	
	
	@GetMapping("/dashboard")
	public String adminLogin(HttpSession session, Model model) {
		
	    User user=(User)session.getAttribute("loggedInUser");
		if(user==null) {
			return "redirect:/login";
		
		}

		List<User> allStudents = userService.getAllStudents();
		long activeStudents = allStudents.stream().filter(User::getStatus).count();

		List<Exams> allExams = examService.getAllExams();
		java.time.LocalDate today = java.time.LocalDate.now();
		long todaysExams = allExams.stream()
				.filter(e -> e.getExamDate() != null && e.getExamDate().isEqual(today)).count();

		List<Result> allResults = resultService.getAllResults();
		int totalResults = allResults.size();

		double avgPercentage = 0;
		long passCount = 0;
		if (totalResults > 0) {
			double sumPercentage = 0;
			for (Result r : allResults) {
				int total = (r.getExam() != null && r.getExam().getTotalMarks() != null
						&& r.getExam().getTotalMarks() > 0) ? r.getExam().getTotalMarks() : 1;
				double pct = (r.getObtainedMarks() * 100.0) / total;
				sumPercentage += pct;
				if (pct >= 40) passCount++;
			}
			avgPercentage = sumPercentage / totalResults;
		}
		double passPercentage = totalResults > 0 ? (passCount * 100.0) / totalResults : 0;
		double failPercentage = totalResults > 0 ? 100 - passPercentage : 0;

		model.addAttribute("totalStudents", allStudents.size());
		model.addAttribute("activeStudents", activeStudents);
		model.addAttribute("totalSubjects", subjectService.getAllSubjects().size());
		model.addAttribute("totalExams", allExams.size());
		model.addAttribute("todaysExams", todaysExams);
		model.addAttribute("totalQuestions", questionService.getAllQuestions().size());
		model.addAttribute("completedExams", totalResults);
		model.addAttribute("avgPercentage", Math.round(avgPercentage * 10.0) / 10.0);
		model.addAttribute("passPercentage", Math.round(passPercentage * 10.0) / 10.0);
		model.addAttribute("failPercentage", Math.round(failPercentage * 10.0) / 10.0);

		java.util.List<Result> recentResults = allResults.size() > 6 ? allResults.subList(0, 6) : allResults;
		model.addAttribute("recentResults", recentResults);

		java.util.List<User> recentStudents = new java.util.ArrayList<>(allStudents);
		java.util.Collections.reverse(recentStudents);
		model.addAttribute("recentStudents",
				recentStudents.size() > 6 ? recentStudents.subList(0, 6) : recentStudents);

		return "admin/adminDashboard";
		
	}
	
	
	
	
	
	@GetMapping("/manageStudents")
	 public String manageStudents(@RequestParam(defaultValue = "1") int page, Model model) {

		List<User> studentList=userService.getAllStudents();

		PageResult<User> pageResult = PageUtil.paginate(studentList, page, 6);

	    model.addAttribute("studentList", pageResult.getContent());
	    model.addAttribute("pageResult", pageResult);
		return "admin/manageStudents";
	}
	
	@GetMapping("/changeStatus")
		public String changeStatus(Integer userId, boolean status) // agar udhar jsp se / karke bhejta to yaha path verible me le leta but waha me ?userid=student.userId&status=student.stauts karke bheja hai isliye yaha direct kar liya or agar veriable name different hote waha or yaha ke to @RequestParam lagana padhta 
	    {
		    userService.changeStatus(userId, status);
			// BUG FIX: pehle yaha sirf "redirect:/manageStudents" tha, jo class-level
			// "/admin" prefix ko ignore karta hai kyunki redirect: absolute path leta hai.
			// Isi wajah se "No mapping found" console me aata tha (action ho jaata tha,
			// bas redirect galat jagah jaata tha).
			return "redirect:/admin/manageStudents";
		}
	@GetMapping("/deleteStudent/{userId}")
	public String deleteStudent(@PathVariable Integer userId)  
	{
		userService.deleteStudent(userId);
		return "redirect:/admin/manageStudents";
	}

	// ===================== AJAX (JSON) versions — inhe manageStudents.jsp use karta hai =====================

//	@PostMapping("/api/changeStatus")
//	@ResponseBody
//	public Map<String, Object> changeStatusAjax(@RequestParam Integer userId, @RequestParam boolean status) {
//		Map<String, Object> response = new HashMap<>();
//		try {
//			userService.changeStatus(userId, status);
//			response.put("success", true);
//		} catch (Exception e) {
//			response.put("success", false);
//			response.put("message", e.getMessage());
//		}
//		return response;
//	}
//
//	@PostMapping("/api/deleteStudent")
//	@ResponseBody
//	public Map<String, Object> deleteStudentAjax(@RequestParam Integer userId) {
//		Map<String, Object> response = new HashMap<>();
//		try {
//			userService.deleteStudent(userId);
//			response.put("success", true);
//		} catch (Exception e) {
//			response.put("success", false);
//			response.put("message", e.getMessage());
//		}
//		return response;
//	}

	
	
	
	
	
	
//	@GetMapping("/manageExams")
//	public String manageExams() {
//		return "admin/manageExams";
//	}
//	@GetMapping("/manageQuestions")
//	public String manageQuestions() {
//		return "admin/manageQuestions";
//	}
	
}
