package com.exam.daoimpl;

import java.util.List;

import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.exam.dao.StudentAnswerDao;
import com.exam.entity.StudentAnswer;

@Repository
@Transactional
public class StudentAnswerDaoImpl implements StudentAnswerDao {

	@Autowired
	private SessionFactory sessionFactory;

	@Override
	public void save(StudentAnswer studentAnswer) {
		sessionFactory.getCurrentSession().save(studentAnswer);
	}

	@Override
	public List<StudentAnswer> findByResultId(Integer resultId) {
		Query<StudentAnswer> query = sessionFactory.getCurrentSession()
				.createQuery("from StudentAnswer where result.resultId=:resultId", StudentAnswer.class);
		query.setParameter("resultId", resultId);
		return query.list();
	}
}
