package com.exam.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.exam.entity.Result;
import com.exam.entity.User;
import com.exam.service.ResultService;
import com.exam.service.StudentAnswerService;
import com.exam.utility.PageResult;
import com.exam.utility.PageUtil;
import com.exam.utility.ResultPdfGenerator;

@Controller
@RequestMapping("/student")
public class ResultController {
	
	@Autowired
	ResultService resultService; 
	@Autowired
	StudentAnswerService studentAnswerService;
	
	@GetMapping("/myResults")
	public String myResults(@RequestParam(defaultValue = "1") int page, HttpSession session,Model model) {
		
		User user=(User) session.getAttribute("loggedInUser");

		List<Result> allResults = resultService.findResultsByUserId(user.getUserId());
		PageResult<Result> pageResult = PageUtil.paginate(allResults, page, 5);
		
		model.addAttribute("myResultList", pageResult.getContent());
		model.addAttribute("pageResult", pageResult);
		
		return "student/myResults";
	}

	@GetMapping("/viewResult/{resultId}")
	public String viewResult(@PathVariable Integer resultId, HttpSession session, Model model) {

		User loggedInUser = (User) session.getAttribute("loggedInUser");
		Result result = resultService.findById(resultId);

		// security check: sirf apna hi result dekh sake, kisi aur ka nahi
		if (result == null || loggedInUser == null
				|| !result.getUser().getUserId().equals(loggedInUser.getUserId())) {
			return "redirect:/student/myResults";
		}

		model.addAttribute("exam", result.getExam());
		model.addAttribute("correct", result.getCorrect());
		model.addAttribute("wrong", result.getWrong());
		model.addAttribute("unattempted", result.getUnattemted());
		model.addAttribute("marks", result.getObtainedMarks());
		model.addAttribute("resultId", result.getResutId());
		model.addAttribute("studentAnswers", studentAnswerService.findByResultId(resultId));

		return "student/result";
	}

	@GetMapping("/downloadResultPdf/{resultId}")
	public void downloadResultPdf(@PathVariable Integer resultId, HttpSession session, HttpServletResponse response)
			throws IOException {

		User loggedInUser = (User) session.getAttribute("loggedInUser");
		Result result = resultService.findById(resultId);

		// security check: sirf apna hi result download kar sake, kisi aur ka nahi
		if (result == null || loggedInUser == null
				|| !result.getUser().getUserId().equals(loggedInUser.getUserId())) {
			response.sendError(HttpServletResponse.SC_FORBIDDEN, "You cannot access this result.");
			return;
		}

		response.setContentType("application/pdf");
		response.setHeader("Content-Disposition",
				"attachment; filename=Result_" + result.getExam().getExamName().replaceAll("\\s+", "_") + "_" + resultId + ".pdf");

		try {
			ResultPdfGenerator.generate(result, response.getOutputStream());
		} catch (Exception e) {
			e.printStackTrace();
			response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Could not generate PDF.");
		}
	}
	
}
