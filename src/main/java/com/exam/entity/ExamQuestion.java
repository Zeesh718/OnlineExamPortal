package com.exam.entity;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name="examquestion")
public class ExamQuestion {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer examQuestionId;

	@ManyToOne
	@JoinColumn(name="examId")
	private Exams exam;

	@ManyToOne
	@JoinColumn(name="questionId")
	private Questions question;

	public ExamQuestion() {
		super();
	}
	public ExamQuestion(Integer examQuestionId, Exams exam, Questions question) {
		super();
		this.examQuestionId = examQuestionId;
		this.exam = exam;
		this.question = question;
	}
	public Integer getExamQuestionId() {
		return examQuestionId;
	}
	public void setExamQuestionId(Integer examQuestionId) {
		this.examQuestionId = examQuestionId;
	}
	public Exams getExam() {
		return exam;
	}
	public void setExam(Exams exam) {
		this.exam = exam;
	}
	public Questions getQuestion() {
		return question;
	}
	public void setQuestion(Questions question) {
		this.question = question;
	}

	
	
}
