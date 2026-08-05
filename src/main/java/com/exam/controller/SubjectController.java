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

import com.exam.entity.Subject;
import com.exam.service.SubjectService;
import com.exam.utility.PageResult;
import com.exam.utility.PageUtil;

@Controller
@RequestMapping("/admin")
public class SubjectController {

	@Autowired
	private SubjectService subjectService;
	
	@GetMapping("/addSubject")
	public String addSubject(Model model) {
		model.addAttribute("subject", new Subject());
		return "admin/addSubject";
	}
	
	@PostMapping("/saveSubject")
	public String saveSubject(@Valid @ModelAttribute Subject subject,
            BindingResult bindingResult, Model model) {
		
		if(bindingResult.hasErrors()) {
	        return "admin/addSubject";
	    }
	   // String sbName=	subject.getSubjectName().trim().replaceAll("\\s+"," ");
		Subject dbSubject=subjectService.getSubjectByName(subject.getSubjectName().trim().replaceAll("\\s+"," "));
		if(dbSubject!=null) {
			  model.addAttribute("subjectError",
			            "Subject already exists.");

			    return "admin/addSubject";
			
		}
		subjectService.saveSubject(subject);
		return "redirect:/admin/manageSubjects";
		
	}
	@GetMapping("/manageSubjects")
	public String manageSubjects(@RequestParam(defaultValue = "1") int page, Model model) {

		List<Subject> subjectList=subjectService.getAllSubjects();

		PageResult<Subject> pageResult = PageUtil.paginate(subjectList, page, 6);

		model.addAttribute("subjectList", pageResult.getContent());
		model.addAttribute("pageResult", pageResult);
		return "admin/manageSubjects" ;
	}
	@GetMapping("/changeSubjectStatus/{subjectId}/{status}")
	public String changeSubjectStatus(@PathVariable Integer subjectId,@PathVariable boolean status) {
		subjectService.updateStatus(subjectId, status);
		return "redirect:/admin/manageSubjects" ;
	}
	@GetMapping("/deleteSubject/{subjectId}")
	public String deleteSubject(@PathVariable Integer subjectId) {
			subjectService.deleteSubject(subjectId);
		return "redirect:/admin/manageSubjects" ;
	}
	@GetMapping("/updateSubject/{subjectId}")
	public String updateSubject(@PathVariable Integer subjectId, Model model) {
		Subject subject=subjectService.getSubjectById(subjectId);
		model.addAttribute("subject", subject);
		return "admin/updateSubject";
	}
	@PostMapping("/updateSubject")
	public String updateSubject(@Valid @ModelAttribute Subject subject, BindingResult bindingResult,Model model) {
		
		
		if(bindingResult.hasErrors()){
		    return "admin/updateSubject";
		}
		Subject dbSubject=subjectService.getSubjectByName(subject.getSubjectName().trim().replaceAll("\\s+"," "));
		if(dbSubject!=null && !dbSubject.getSubjectId().equals(subject.getSubjectId())) {
			  model.addAttribute("subjectExistError",
			            "Subject already exists.");

			    return "admin/updateSubject";
			
		}
		
		subjectService.updateSubject(subject);
		return "redirect:/admin/manageSubjects";
		
	}

	// ===================== AJAX (JSON) versions =====================

//	@PostMapping("/api/changeSubjectStatus")
//	@ResponseBody
//	public Map<String, Object> changeSubjectStatusAjax(@RequestParam Integer subjectId, @RequestParam boolean status) {
//		Map<String, Object> response = new HashMap<>();
//		try {
//			subjectService.updateStatus(subjectId, status);
//			response.put("success", true);
//		} catch (Exception e) {
//			response.put("success", false);
//			response.put("message", e.getMessage());
//		}
//		return response;
//	}
//
//	@PostMapping("/api/deleteSubject")
//	@ResponseBody
//	public Map<String, Object> deleteSubjectAjax(@RequestParam Integer subjectId) {
//		Map<String, Object> response = new HashMap<>();
//		try {
//			subjectService.deleteSubject(subjectId);
//			response.put("success", true);
//		} catch (Exception e) {
//			response.put("success", false);
//			response.put("message", e.getMessage());
//		}
//		return response;
//	}
	
}
