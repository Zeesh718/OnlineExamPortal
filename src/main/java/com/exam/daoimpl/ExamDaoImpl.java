package com.exam.daoimpl;

import java.time.LocalDate;
import java.util.Date;
import java.util.List;

import javax.transaction.Transactional;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.exam.dao.ExamDao;
import com.exam.entity.Exams;

@Repository
@Transactional
public class ExamDaoImpl implements ExamDao{
	@Autowired
	SessionFactory sessionFactory;
	@Override
	public void saveExam(Exams exam) {
	     sessionFactory.getCurrentSession().save(exam);
		
	}

	@Override
	public List<Exams> getAllExams() {
		 
		return sessionFactory.getCurrentSession().createQuery("from Exams",Exams.class).list();
	}

	@Override
	public Exams getExamById(Integer examId) {
		
		return sessionFactory.getCurrentSession().get(Exams.class,examId);
		
	}

	@Override
	public void updateStatus(Integer examId, boolean status) {
		Exams exam=getExamById(examId);
		exam.setStatus(status);
		
	}

	@Override
	public void deleteExam(Integer examId) {
		Exams exam=getExamById(examId);
		if(exam!=null) {  
			sessionFactory.getCurrentSession().delete(exam);
		
		}
		sessionFactory.getCurrentSession().flush(); // ye flush ki wajah se wo persictance wali eroor aa rahi thi isliye ek exception or add ki agar ye nahi likhte o wo fir khud ho jata or agar ye likha tha or usdar percistance wali nahi lagate to wo main exception me aata 
	}

	@Override
	public void updateExam(Exams exam) {
		
		
			sessionFactory.getCurrentSession().update(exam);
		
		
	}
	
	@Override
	public List<Exams> getAvailableExams() {
		LocalDate currentDate=LocalDate.now();
		return sessionFactory.getCurrentSession().createQuery("from Exams where status=true and examDate>=:currentDate",Exams.class).setParameter("currentDate",currentDate).list();
	}

	@Override
	public List<Exams> getAllActiveExams() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Exams> getExamBySubject(Integer subjectId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Exams findByExamNameAndSubjectAndExamDate(String examName, Integer subjectId, LocalDate examDate) {
		
		return sessionFactory.getCurrentSession().createQuery("from Exams where lower(trim(examName))=:examName and subject.subjectId=:subjectId and examDate=:examDate",Exams.class).setParameter("examName",examName.trim().toLowerCase()).setParameter("subjectId",subjectId).setParameter("examDate",examDate).uniqueResult();
		}

	



}
