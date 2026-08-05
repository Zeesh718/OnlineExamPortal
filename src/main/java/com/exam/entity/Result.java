package com.exam.entity;

import java.time.LocalDate;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

@Entity
public class Result {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer resultId;
	private Integer correct;
	private Integer unattemted;
	private Integer wrong;
	private Integer obtainedMarks;
	private LocalDate submittedDate;
	
	@ManyToOne
	@JoinColumn(name="userId")
	private User user;
	
	@ManyToOne
	@JoinColumn(name="examId")
	private Exams exam;
	
	
	
	
	
	public Result() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	

	public Result(Integer resutId, Integer correct, Integer unattemted, Integer wrong, Integer obtainedMarks,
			LocalDate submittedDate, User user, Exams exam) {
		super();
		this.resultId = resutId;
		this.correct = correct;
		this.unattemted = unattemted;
		this.wrong = wrong;
		this.obtainedMarks = obtainedMarks;
		this.submittedDate = submittedDate;
		this.user = user;
		this.exam = exam;
	}



	public Integer getResutId() {
		return resultId;
	}

	public void setResutId(Integer resutId) {
		this.resultId = resutId;
	}

	public Integer getCorrect() {
		return correct;
	}

	public void setCorrect(Integer correct) {
		this.correct = correct;
	}

	public Integer getUnattemted() {
		return unattemted;
	}

	public void setUnattemted(Integer unattemted) {
		this.unattemted = unattemted;
	}

	public Integer getWrong() {
		return wrong;
	}

	public void setWrong(Integer wrong) {
		this.wrong = wrong;
	}

	public Integer getObtainedMarks() {
		return obtainedMarks;
	}

	public void setObtainedMarks(Integer obtainedMarks) {
		this.obtainedMarks = obtainedMarks;
	}

	public LocalDate getSubmittedDate() {
		return submittedDate;
	}

	public void setSubmittedDate(LocalDate submittedDate) {
		this.submittedDate = submittedDate;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Exams getExam() {
		return exam;
	}

	public void setExam(Exams exam) {
		this.exam = exam;
	}

	
	

	
}
