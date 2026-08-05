package com.exam.service;

import java.util.List;

import com.exam.entity.ExamQuestion;

public interface ExamQuestionService  {

	public void saveExamQuestion(Integer examId, List<Integer> questionIds);
	public List<ExamQuestion> getQuestionsByExamId(Integer examId);

	public void removeQuestion(Integer examQuestionId);

}
