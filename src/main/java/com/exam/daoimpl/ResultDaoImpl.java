package com.exam.daoimpl;

import java.util.List;

import javax.transaction.Transactional;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.exam.dao.ResultDao;
import com.exam.entity.Result;

@Repository
@Transactional
public class ResultDaoImpl implements ResultDao {

	
	@Autowired
	SessionFactory sessionFactory;
	
	@Override
	public void saveResult(Result result) {
		
		sessionFactory.getCurrentSession().save(result);
	}

	@Override
	public Result getResultByUserAndExam(Integer userId, Integer examId) {
		
		return sessionFactory
				.getCurrentSession()
				.createQuery("from Result where userId=:userId and examId=:examId",Result.class)
				.setParameter("userId", userId)
				.setParameter("examId", examId)
				.uniqueResult();
	}

	@Override
	public List<Result> findResultsByUserId(Integer userId) {
		
		return sessionFactory
				.getCurrentSession()
				.createQuery("from Result where userId=:userId order by submittedDate desc",Result.class)
				.setParameter("userId", userId)
				.list();
	}

	@Override
	public Result findById(Integer resultId) {
		return sessionFactory.getCurrentSession().get(Result.class, resultId);
	}

	@Override
	public List<Result> getAllResults() {
		return sessionFactory
				.getCurrentSession()
				.createQuery("from Result order by submittedDate desc", Result.class)
				.list();
	}

}
