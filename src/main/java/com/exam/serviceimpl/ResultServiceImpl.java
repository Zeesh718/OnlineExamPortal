package com.exam.serviceimpl;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.exam.dao.ResultDao;
import com.exam.entity.Result;
import com.exam.service.ResultService;

@Service
@Transactional
public class ResultServiceImpl implements ResultService{

	@Autowired
	ResultDao resultDao;
	@Override
	public void saveResult(Result result) {
		resultDao.saveResult(result);
		
	}

	@Override
	public Result getResultByUserAndExam(Integer userId, Integer examId) {
		
		return resultDao.getResultByUserAndExam(userId, examId);
	}

	@Override
	public List<Result> findResultsByUserId(Integer userId) {
		
		return resultDao.findResultsByUserId(userId);
	}

	@Override
	public Result findById(Integer resultId) {
		return resultDao.findById(resultId);
	}

	@Override
	public List<Result> getAllResults() {
		return resultDao.getAllResults();
	}

}
