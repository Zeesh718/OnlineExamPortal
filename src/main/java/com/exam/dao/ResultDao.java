package com.exam.dao;

import java.util.List;

import com.exam.entity.Result;

public interface ResultDao {
	
	
	public void saveResult(Result result);
	public Result getResultByUserAndExam(Integer UserId,Integer examId);
	public List<Result> findResultsByUserId(Integer userId);
	public Result findById(Integer resultId);
	public List<Result> getAllResults();

}
