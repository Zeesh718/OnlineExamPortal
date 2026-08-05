package com.exam.service;

import java.util.List;

import com.exam.entity.Questions;

public interface QuestionService {
	public void saveQuestion(Questions question);
	public List<Questions> getAllQuestions();
	public Questions getQuestionById(Integer questionId);
	public void updateStatus(Integer questionId,boolean status);
	public void deleteQuestion(Integer questionId);
	public void updateQuestion(Questions question);

	List<Questions> getAllQuestionsBySubjectId(Integer subjectId);


}
