package com.exam.serviceimpl;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.exam.dao.ExamQuestionDao;
import com.exam.entity.ExamQuestion;
import com.exam.service.ExamQuestionService;

@Service
@Transactional
public class ExamQuestionServiceImpl implements ExamQuestionService {
	
	@Autowired
	ExamQuestionDao examQuestionDao;
	
	public void saveExamQuestion(Integer examId, List<Integer> questionIds) {
		
		examQuestionDao.saveExamQuestion(examId, questionIds);
		
	}

	@Override
	public List<ExamQuestion> getQuestionsByExamId(Integer examId) {
		
		return examQuestionDao.getQuestionsByExamId(examId);
	}
	
	@Override
	public void removeQuestion(Integer examQuestionId) {
	    examQuestionDao.removeQuestion(examQuestionId);
	}
}
