package com.exam.entity;

import java.time.LocalDate;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import org.springframework.format.annotation.DateTimeFormat;

@Entity
public class Exams {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer examId;
	@NotBlank(message="Exam name is required")
	@Size(min=3,max=50,message="Exam name must be between 3 and 50 characters")
	private String examName;
	@NotBlank(message="Duration is required")
	@Pattern(regexp="^[0-9]+$", message="Duration must be numeric")
	private String duration;
	@NotBlank(message="Start Time is required")
    private String  startTime;
	@NotNull(message="Total marks are required")
	@Min(value=1,message="Total marks must be greater than 0")
	private Integer totalMarks;

	
	@Transient
	private boolean attemted;
	
	
	@NotNull(message="Exam date is required")
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private LocalDate examDate;

	private boolean status;
	
	@NotNull(message="Please select a subject")
	@ManyToOne
	@JoinColumn(name="subjectId")
	private Subject subject ;

	public Exams() {
		super();
	}
	public Exams(Integer examId, String examName, String duration, String startTime, Integer totalMarks, LocalDate examDate,
			boolean status, Subject subject) {
		super();
		this.examId = examId;
		this.examName = examName;
		this.duration = duration;
		this.startTime = startTime;
		this.totalMarks = totalMarks;
		this.examDate = examDate;
		this.status = status;
		this.subject = subject;
	}

	public Integer getExamId() {
		return examId;
	}

	public void setExamId(Integer examId) {
		this.examId = examId;
	}

	public String getExamName() {
		return examName;
	}

	public void setExamName(String examName) {
		this.examName = examName;
	}

	public String getDuration() {
		return duration;
	}

	public void setDuration(String duration) {
		this.duration = duration;
	}

	public String getStartTime() {
		return startTime;
	}

	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}

	public Integer getTotalMarks() {
		return totalMarks;
	}

	public void setTotalMarks(Integer totalMarks) {
		this.totalMarks = totalMarks;
	}

	public LocalDate getExamDate() {
		return examDate;
	}

	public void setExamDate(LocalDate examDate) {
		this.examDate = examDate;
	}

	public boolean isStatus() {
		return status;
	}

	public void setStatus(boolean status) {
		this.status = status;
	}

	public Subject getSubject() {
		return subject;
	}

	public void setSubject(Subject subject) {
		this.subject = subject;
	}
	public boolean isAttemted() {
		return attemted;
	}
	public void setAttemted(boolean attemted) {
		this.attemted = attemted;
	}

	
	
}
