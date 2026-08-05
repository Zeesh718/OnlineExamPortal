package com.exam.controller;

import java.time.LocalDate;
import java.util.List;

import javax.validation.Valid;

import org.hibernate.SessionFactory;
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

import com.exam.entity.ExamQuestion;
import com.exam.entity.Exams;
import com.exam.entity.Questions;
import com.exam.entity.Subject;
import com.exam.service.ExamQuestionService;
import com.exam.service.ExamService;
import com.exam.service.QuestionService;
import com.exam.service.SubjectService;

@Controller
@RequestMapping("/admin")
public class ExamController {
    @Autowired
    private SubjectService subjectService;
	@Autowired
	private ExamService examService;
	@Autowired
	SessionFactory sessionFactory;
	@Autowired
	private QuestionService questionService;
	@Autowired
	private ExamQuestionService examQuestionService;
	
	@GetMapping("/addExam")
	public String addExam(Model model) {
		 model.addAttribute("exam", new Exams()); 
		List<Subject> subjectList=subjectService.getAllSubjects();
		model.addAttribute("subjectList", subjectList);
		return "admin/addExam";
	}
	
	@PostMapping("/saveExam")
	public String saveexam(@Valid @ModelAttribute("exam") Exams exam,
			BindingResult bindingResult,Model model) {
		
		if(exam.getSubject()==null ||
				   exam.getSubject().getSubjectId()==null){

				    bindingResult.rejectValue(
				        "subject.subjectId",
				        "subject.required",
				        "Please select a subject");
				}
		//Ek extra  validation 
		//Ki Exam Date past me nahi honi chahiye.
		if(exam.getExamDate() != null && exam.getExamDate().isBefore(LocalDate.now())){

		    bindingResult.rejectValue(
		        "examDate",
		        "date.invalid",
		        "Exam date cannot be in the past");
		}
		
		if(bindingResult.hasErrors()){

		    model.addAttribute("subjectList",subjectService.getAllSubjects());

		    return "admin/addExam";
		}
		
		// duplicate exam to add nahi ho rahi hai wo dekhne ke liye 
		
		Exams dbExam=examService.findByExamNameAndSubjectAndExamDate(exam.getExamName(),exam.getSubject().getSubjectId(),exam.getExamDate());
		if(dbExam!=null) {
			   model.addAttribute("examExistError",
			            "Exam already exists.");
			    model.addAttribute("subjectList",subjectService.getAllSubjects());

			   return "admin/addExam";
		}
		examService.saveExam(exam);
		return "redirect:/admin/manageExams";
		
	}
	@GetMapping("/manageExams")
	public String manageExams(@RequestParam(defaultValue = "1") int page, Model model) {
		List<Exams> examList=examService.getAllExams();
		com.exam.utility.PageResult<Exams> pageResult = com.exam.utility.PageUtil.paginate(examList, page, 6);
		model.addAttribute("examList", pageResult.getContent());
		model.addAttribute("pageResult", pageResult);
		return "admin/manageExams" ;
	}
	@GetMapping("/changeExamStatus/{examId}/{status}")
	public String changeExamStatus(@PathVariable Integer examId,@PathVariable boolean status) {
		examService.updateStatus(examId, status);
		return "redirect:/admin/manageExams" ;
	}
	@GetMapping("/deleteExam/{examId}")
	public String deleteExam(@PathVariable Integer examId) {
			examService.deleteExam(examId);
		return "redirect:/admin/manageExams" ;
	}

	// ===================== AJAX (JSON) versions =====================

//	@PostMapping("/api/changeExamStatus")
//	@ResponseBody
//	public java.util.Map<String, Object> changeExamStatusAjax(@RequestParam Integer examId, @RequestParam boolean status) {
//		java.util.Map<String, Object> response = new java.util.HashMap<>();
//		try {
//			examService.updateStatus(examId, status);
//			response.put("success", true);
//		} catch (Exception e) {
//			response.put("success", false);
//			response.put("message", e.getMessage());
//		}
//		return response;
//	}
//
//	@PostMapping("/api/deleteExam")
//	@ResponseBody
//	public java.util.Map<String, Object> deleteExamAjax(@RequestParam Integer examId) {
//		java.util.Map<String, Object> response = new java.util.HashMap<>();
//		try {
//			examService.deleteExam(examId);
//			response.put("success", true);
//		} catch (Exception e) {
//			response.put("success", false);
//			response.put("message", e.getMessage());
//		}
//		return response;
//	}
	@GetMapping("/updateExam/{examId}")
	public String updateExam(@PathVariable Integer examId, Model model) {
		
		Exams exam=examService.getExamById(examId);
		model.addAttribute("exam", exam);
		
		List<Subject> subjectList = subjectService.getAllSubjects();
		model.addAttribute("subjectList", subjectList);
		
		return "admin/updateExam";
	}
	@PostMapping("/updateExam")
	public String updateqExam(@Valid @ModelAttribute("exam") Exams exam, BindingResult bindingResult,Model model) {
		
		
		

		if(exam.getSubject()==null ||
				   exam.getSubject().getSubjectId()==null){

				    bindingResult.rejectValue(
				        "subject.subjectId",
				        "subject.required",
				        "Please select a subject");
				}
		//Ek extra  validation 
		//Ki Exam Date past me nahi honi chahiye.
		if(exam.getExamDate() != null && exam.getExamDate().isBefore(LocalDate.now())){

		    bindingResult.rejectValue(
		        "examDate",
		        "date.invalid",
		        "Exam date cannot be in the past");
		}
		
		if(bindingResult.hasErrors()){

		    model.addAttribute("subjectList",subjectService.getAllSubjects());

		    return "admin/updateExam";
		}
		
		// duplicate exam to add nahi ho rahi hai wo dekhne ke liye 
		
		Exams dbExam=examService.findByExamNameAndSubjectAndExamDate(exam.getExamName(),exam.getSubject().getSubjectId(),exam.getExamDate());
		if(dbExam!=null && !dbExam.getExamId().equals(exam.getExamId())) {
			   model.addAttribute("examExistError",
			            "Exam already exists.");
			    model.addAttribute("subjectList",subjectService.getAllSubjects());

			   return "admin/updateExam";
		}
		
		
		examService.updateExam(exam);
		return "redirect:/admin/manageExams";
		
	}
	
	
	
	@GetMapping("/assignQuestions/{examId}")
	public String saveExamquestion(@PathVariable Integer examId, Model model){
		
		Exams exam =examService.getExamById(examId);
		
		Subject subject=exam.getSubject();	
		
		 Integer subjectId=subject.getSubjectId();
		 List<Questions> subjectQuestionList=questionService.getAllQuestionsBySubjectId(subjectId);
		 model.addAttribute("subjectQuestionList", subjectQuestionList);
		 model.addAttribute("examId",examId);
		 return "admin/addExamQuestions";
		
	}
	
	@PostMapping("/saveExamQuestion")
	public String saveExamQuestion(@RequestParam(required=false) List<Integer> questionIds, @RequestParam Integer examId) {
		 
		   if(questionIds == null || questionIds.isEmpty()) {
		        return "redirect:/admin/assignQuestions/" + examId;  // wapas bhejo
		    }
		examQuestionService.saveExamQuestion(examId, questionIds);
		
		return "redirect:/admin/viewExamDetails/" + examId;
	}
	
	@GetMapping("/viewExamDetails/{examId}")
	public String viewExamDetails(@PathVariable Integer examId,Model model) {
		
		List<ExamQuestion> examQuestionList=examQuestionService.getQuestionsByExamId(examId);
		Exams exam =examService.getExamById(examId);
		model.addAttribute("examQuestionList", examQuestionList);
		model.addAttribute("exam", exam);
		return "admin/viewExamDetails";
		
	}
	
	@GetMapping("/removeQuestion/{examQuestionId}/{examId}")
	public String removeQuestion(@PathVariable Integer examQuestionId,
	                             @PathVariable Integer examId) {

	    examQuestionService.removeQuestion(examQuestionId);

	    return "redirect:/admin/viewExamDetails/" + examId;
	}

}
