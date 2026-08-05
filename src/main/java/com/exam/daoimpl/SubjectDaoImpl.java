package com.exam.daoimpl;

import java.util.List;

import javax.transaction.Transactional;


import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.exam.dao.SubjectDao;
import com.exam.entity.Subject;

@Repository
@Transactional
public class SubjectDaoImpl implements SubjectDao {

	@Autowired
	SessionFactory sessionFactory;
	@Override
	public void saveSubject(Subject subject) {
	     sessionFactory.getCurrentSession().save(subject);
		
	}

	@Override
	public List<Subject> getAllSubjects() {
		 
		return sessionFactory.getCurrentSession().createQuery("from Subject",Subject.class).list();
	}

	@Override
	public Subject getSubjectById(Integer subjectId) {
		
		return sessionFactory.getCurrentSession().get(Subject.class,subjectId);
		
	}

	@Override
	public void updateStatus(Integer subjectId, boolean status) {
		Subject subject=getSubjectById(subjectId);
		subject.setStatus(status);
		
	}

	@Override
	public void deleteSubject(Integer subjectId) {
		Subject subject=getSubjectById(subjectId);
		if(subject!=null) {  
			sessionFactory.getCurrentSession().delete(subject);
		
		}
		
	}

	@Override
	public void updateSubject(Subject subject) {
		
		
			sessionFactory.getCurrentSession().update(subject);
		
		
	}

	@Override
	public Subject getSubjectByName(String subjectName) {
		
		return sessionFactory.getCurrentSession().createQuery("from Subject where subjectName=:subjectName",Subject.class).setParameter("subjectName", subjectName).uniqueResult();
	}

}
