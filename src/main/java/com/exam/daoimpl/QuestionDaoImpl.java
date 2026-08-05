package com.exam.daoimpl;

import java.util.List;

import org.springframework.transaction.annotation.Transactional;

import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.exam.dao.QuestionDao;
import com.exam.entity.Questions;



@Repository
@Transactional
public class QuestionDaoImpl implements QuestionDao{
	@Autowired
	SessionFactory sessionFactory;
	@Override
	public void saveQuestion(Questions question) {
	     sessionFactory.getCurrentSession().save(question);
		
	}

	@Override
	public List<Questions> getAllQuestions() {
		 
		return sessionFactory.getCurrentSession().createQuery("from Questions",Questions.class).list();
	}

	@Override
	public Questions getQuestionById(Integer questionId) {
		
		return sessionFactory.getCurrentSession().get(Questions.class,questionId);
		
	}

	@Override
	public void updateStatus(Integer questionId, boolean status) {
		Questions question=getQuestionById(questionId);
		question.setStatus(status);
		
	}

	@Override
	public void deleteQuestion(Integer questionId) {
		Questions question=getQuestionById(questionId);
		if(question!=null) {  
			sessionFactory.getCurrentSession().delete(question);
		
		}
		
	}

	@Override
	public void updateQuestion(Questions question) {
		
		
			sessionFactory.getCurrentSession().update(question);
		
		
	}

	@Override
	public List<Questions> getAllQuestionsBySubjectId(Integer subjectId) {

	   Query<Questions> query =sessionFactory.getCurrentSession().createQuery("from Questions where subject.subjectId=:subjectId",Questions.class);
	   query.setParameter("subjectId", subjectId);

		return query.list();
	}


}
