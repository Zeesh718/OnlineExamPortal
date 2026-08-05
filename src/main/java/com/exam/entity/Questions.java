package com.exam.entity;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;


@Entity
public class Questions {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer questionId;
	@NotBlank(message="Question is required")
	private String questionText;
	@NotBlank(message="Option A is required")
	private String optionA;
	@NotBlank(message="Option B is required")
	private String optionB;
	@NotBlank(message="Option C is required")
	private String optionC;
	@NotBlank(message="Option D is required")
	private String optionD;
	@NotBlank(message="Correct Answer is required")
	private String correctAnswer;
	@NotNull(message="Marks are required")
	@Min(value=1, message="Marks must be greater than 0")
	private Integer marks;
	private boolean status;
	
	@NotNull(message="Please select a subject")
	@ManyToOne
	@JoinColumn(name="subjectId")
	private Subject subject;

	
	public Questions() {
		super();
	}
	public Questions(Integer questionId, String questionText, String optionA, String optionB, String optionC,
			String optionD, String correctAnswer, Integer marks, boolean status, Subject subject) {
		super();
		this.questionId = questionId;
		this.questionText = questionText;
		this.optionA = optionA;
		this.optionB = optionB;
		this.optionC = optionC;
		this.optionD = optionD;
		this.correctAnswer = correctAnswer;
		this.marks = marks;
		this.status = status;
		this.subject = subject;
	}

	public Integer getQuestionId() {
		return questionId;
	}

	public void setQuestionId(Integer questionId) {
		this.questionId = questionId;
	}

	public String getQuestionText() {
		return questionText;
	}

	public void setQuestionText(String questionText) {
		this.questionText = questionText;
	}

	public String getOptionA() {
		return optionA;
	}

	public void setOptionA(String optionA) {
		this.optionA = optionA;
	}

	public String getOptionB() {
		return optionB;
	}

	public void setOptionB(String optionB) {
		this.optionB = optionB;
	}

	public String getOptionC() {
		return optionC;
	}

	public void setOptionC(String optionC) {
		this.optionC = optionC;
	}

	public String getOptionD() {
		return optionD;
	}

	public void setOptionD(String optionD) {
		this.optionD = optionD;
	}

	public String getCorrectAnswer() {
		return correctAnswer;
	}

	public void setCorrectAnswer(String correctAnswer) {
		this.correctAnswer = correctAnswer;
	}

	public Integer getMarks() {
		return marks;
	}

	public void setMarks(Integer marks) {
		this.marks = marks;
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

	
}
