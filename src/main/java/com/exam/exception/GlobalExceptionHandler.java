package com.exam.exception;

import javax.persistence.Persistence;

import javax.persistence.PersistenceException;

import org.hibernate.exception.ConstraintViolationException;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

@ControllerAdvice
public class GlobalExceptionHandler {
	
	
	
	
	@ExceptionHandler(DataIntegrityViolationException.class)
	public String handleException(DataIntegrityViolationException ex, Model model) {
		
		
		String msg = ex.getMostSpecificCause().getMessage();

		System.out.println(msg);
		
		
		model.addAttribute("errorList","Delete Failed");
		model.addAttribute("errorMessage", "This record is already being used in another module. Please remove its dependencies first.");
		
		return "common/error";
	}
	
	@ExceptionHandler(ConstraintViolationException.class)
	public String handleConstraint(ConstraintViolationException ex, Model model) {
		
		 model.addAttribute("errorTitle",
		            "Database Constraint");

		    model.addAttribute("errorMessage",
		            "Operation cannot be completed because related records exist.");

		    return "common/error";
		}
	
	@ExceptionHandler(PersistenceException.class) // ye wala wo flush kekaran add kiya bass 
	public String handlePersistenceException(PersistenceException ex, Model model) {

	    model.addAttribute("errorTitle", "Delete Failed");

	    model.addAttribute(
	        "errorMessage",
	        "This record is already being used. Please remove its dependencies first."
	    );

	    return "common/error";
	}
	
	@ExceptionHandler(Exception.class)
	public String handleException(Exception ex, Model model) {
		
		//ex.printStackTrace();

	   // System.out.println("Class = " + ex.getClass().getName());

	    model.addAttribute("errorTitle", "Unexpected Error");
	    model.addAttribute("errorMessage", ex.getMessage());
	    
	    
	    
		return "common/error";
	}

}
