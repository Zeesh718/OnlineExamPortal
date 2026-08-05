package com.exam.dao;

import java.util.List;

import com.exam.entity.Questions;
import com.exam.entity.Subject;

public interface QuestionDao {
	
	public void saveQuestion(Questions questions);
	public List<Questions> getAllQuestions();
	public Questions getQuestionById(Integer questionId);
	public void updateStatus(Integer questionId,boolean status);
	public void deleteQuestion(Integer questionId);
	public void updateQuestion(Questions question);
	public List<Questions> getAllQuestionsBySubjectId(Integer subjectId);

}
