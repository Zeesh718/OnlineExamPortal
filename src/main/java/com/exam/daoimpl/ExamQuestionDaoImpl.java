package com.exam.daoimpl;

import java.util.List;

import javax.transaction.Transactional;

import org.hibernate.query.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.exam.dao.ExamQuestionDao;
import com.exam.entity.ExamQuestion;
import com.exam.entity.Exams;
import com.exam.entity.Questions;
import com.exam.service.ExamService;

@Repository
@Transactional
public class ExamQuestionDaoImpl implements ExamQuestionDao{

	@Autowired
	SessionFactory sessionFactory;
	@Autowired
	ExamService examService;
	
	@Override
	public void saveExamQuestion(Integer examId,List<Integer> questionIds) {
		Session session =sessionFactory.getCurrentSession();
		
		ExamQuestion eq;
		
		Exams exam=examService.getExamById(examId);
		
		for(int i=0;i<questionIds.size();i++) {
			 
			Questions question= session.get(Questions.class,questionIds.get(i));
			eq=new ExamQuestion();
			eq.setExam(exam);
			eq.setQuestion(question);
		    session.save(eq);
		}
	}

	@Override
	public List<ExamQuestion> getQuestionsByExamId(Integer examId) {
		Session session= sessionFactory.getCurrentSession();
		//session.createQuery("from ExamQuestio where question.questionId=:questionId",ExamQuestion.class);
		Query<ExamQuestion> query=session.createQuery("from ExamQuestion where exam.examId=:examId",ExamQuestion.class);
		query.setParameter("examId",examId);
		return query.list();
	}
	
	@Override
	public void removeQuestion(Integer examQuestionId) {

	    ExamQuestion examQuestion =
	            sessionFactory.getCurrentSession()
	                          .get(ExamQuestion.class, examQuestionId);

	    if (examQuestion != null) {
	        sessionFactory.getCurrentSession().delete(examQuestion);
	    }
	}

}
