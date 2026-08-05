package com.exam.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.exam.entity.Questions;
import com.exam.entity.Subject;
import com.exam.service.QuestionService;
import com.exam.service.SubjectService;
import com.exam.utility.PageResult;
import com.exam.utility.PageUtil;

@Controller
@RequestMapping("/admin")
public class QuestionController {
	
	
    @Autowired
    private SubjectService subjectService;
	@Autowired
	private QuestionService questionService;
	
	@GetMapping("/addQuestion")
	public String addQuestion(Model model) {
		List<Subject> subjectList=subjectService.getAllSubjects();
		model.addAttribute("subjectList", subjectList);
		model.addAttribute("question",new Questions());
		
		return "admin/addQuestion";
	}
	
	@PostMapping("/saveQuestion")
	public String saveQuestion(@Valid @ModelAttribute("question") Questions question,
	                           BindingResult bindingResult,
	                           Model model) {

	    if (question.getSubject() == null ||
	        question.getSubject().getSubjectId() == null) {

	        bindingResult.rejectValue(
	                "subject.subjectId",
	                "subject.required",
	                "Please select a subject");
	    }

	    if (bindingResult.hasErrors()) {

	        model.addAttribute("subjectList",
	                subjectService.getAllSubjects());

	        return "admin/addQuestion";
	    }
	    

	    questionService.saveQuestion(question);

	    return "redirect:/admin/manageQuestions";
	}
	@GetMapping("/manageQuestions")
	public String manageQuestions(@RequestParam(defaultValue = "1") int page, Model model) {

		List<Questions> questionList=questionService.getAllQuestions();

		PageResult<Questions> pageResult = PageUtil.paginate(questionList, page, 6);

		model.addAttribute("questionList", pageResult.getContent());
		model.addAttribute("pageResult", pageResult);
		return "admin/manageQuestions" ;
	}
	@GetMapping("/changeQuestionStatus/{questionId}/{status}")
	public String changeQuestionStatus(@PathVariable Integer questionId,@PathVariable boolean status) {
		questionService.updateStatus(questionId, status);
		return "redirect:/admin/manageQuestions" ;
	}
	@GetMapping("/deleteQuestion/{questionId}")
	public String deleteQuestion(@PathVariable Integer questionId) {
			questionService.deleteQuestion(questionId);
		return "redirect:/admin/manageQuestions" ;
	}
	@GetMapping("/updateQuestion/{questionId}")
	public String updatequestion(@PathVariable Integer questionId, Model model) {
		
		Questions question=questionService.getQuestionById(questionId);
		model.addAttribute("question", question);
		
		List<Subject> subjectList = subjectService.getAllSubjects();
		model.addAttribute("subjectList", subjectList);
		
		return "admin/updateQuestion";
	}
	@PostMapping("/updateQuestion")
	public String updateqQuestion(@Valid @ModelAttribute("question") Questions question, BindingResult bindingResult, Model model)
	{
		
		if(question.getSubject()==null || question.getSubject().getSubjectId()==null) {
			bindingResult.rejectValue("subject.subjectId",
					                   "subject.required",
					                   "*Plese Select A Subject");
		}
		if(bindingResult.hasErrors()) {
			List<Subject> subjectList = subjectService.getAllSubjects();
			model.addAttribute("subjectList", subjectList);
			return "admin/updateQuestion";
		}
		
		questionService.updateQuestion(question);
		return "redirect:/admin/manageQuestions";
		
	}

	// ===================== AJAX (JSON) versions =====================

//	@PostMapping("/api/changeQuestionStatus")
//	@ResponseBody
//	public Map<String, Object> changeQuestionStatusAjax(@RequestParam Integer questionId, @RequestParam boolean status) {
//		Map<String, Object> response = new HashMap<>();
//		try {
//			questionService.updateStatus(questionId, status);
//			response.put("success", true);
//		} catch (Exception e) {
//			response.put("success", false);
//			response.put("message", e.getMessage());
//		}
//		return response;
//	}
//
//	@PostMapping("/api/deleteQuestion")
//	@ResponseBody
//	public Map<String, Object> deleteQuestionAjax(@RequestParam Integer questionId) {
//		Map<String, Object> response = new HashMap<>();
//		try {
//			questionService.deleteQuestion(questionId);
//			response.put("success", true);
//		} catch (Exception e) {
//			response.put("success", false);
//			response.put("message", e.getMessage());
//		}
//		return response;
//	}

}
