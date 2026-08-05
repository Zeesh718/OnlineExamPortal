package com.exam.serviceimpl;

import java.util.List;

import org.springframework.transaction.annotation.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.exam.dao.QuestionDao;
import com.exam.entity.Questions;
import com.exam.service.QuestionService;

@Service
@Transactional
public class QuestionServiceImpl implements QuestionService {

	@Autowired
	QuestionDao questionDao;
	@Override
	public void saveQuestion(Questions question) {
		question.setStatus(true);
		questionDao.saveQuestion(question);
	}

	@Override
	public List<Questions> getAllQuestions() {
		return questionDao.getAllQuestions();
	}

	@Override
	public Questions getQuestionById(Integer questionId) {
		return questionDao.getQuestionById(questionId);
	}

	@Override
	public void updateStatus(Integer questionId, boolean status) {
        questionDao.updateStatus(questionId, status);		
	}

	@Override
	public void deleteQuestion(Integer questionId) {
		questionDao.deleteQuestion(questionId);
	}
	@Override
	public void updateQuestion(Questions question) {
        questionDao.updateQuestion(question);		
	}

	@Override
	public List<Questions> getAllQuestionsBySubjectId(Integer subjectId) {
		return questionDao.getAllQuestionsBySubjectId(subjectId);
		
		 
	}

	
}
