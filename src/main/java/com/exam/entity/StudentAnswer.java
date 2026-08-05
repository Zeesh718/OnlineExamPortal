package com.exam.entity;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

// Har exam-submission ke har question ke liye ek row - question-wise result analysis
// aur PDF report ke liye zaroori hai. Purani Result table (aggregate counts) untouched hai.
@Entity
@Table(name = "student_answer")
public class StudentAnswer {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer studentAnswerId;

	@ManyToOne
	@JoinColumn(name = "resultId")
	private Result result;

	@ManyToOne
	@JoinColumn(name = "questionId")
	private Questions question;

	// null matlab student ne attempt hi nahi kiya
	private String selectedOption;

	private boolean correct;

	public StudentAnswer() {
		super();
	}

	public StudentAnswer(Result result, Questions question, String selectedOption, boolean correct) {
		super();
		this.result = result;
		this.question = question;
		this.selectedOption = selectedOption;
		this.correct = correct;
	}

	public Integer getStudentAnswerId() {
		return studentAnswerId;
	}
	public void setStudentAnswerId(Integer studentAnswerId) {
		this.studentAnswerId = studentAnswerId;
	}
	public Result getResult() {
		return result;
	}
	public void setResult(Result result) {
		this.result = result;
	}
	public Questions getQuestion() {
		return question;
	}
	public void setQuestion(Questions question) {
		this.question = question;
	}
	public String getSelectedOption() {
		return selectedOption;
	}
	public void setSelectedOption(String selectedOption) {
		this.selectedOption = selectedOption;
	}
	public boolean isCorrect() {
		return correct;
	}
	public void setCorrect(boolean correct) {
		this.correct = correct;
	}
}
