package com.exam.service;

import java.util.List;

import com.exam.entity.Result;

public interface ResultService {
	
	public void saveResult(Result result);
	public Result getResultByUserAndExam(Integer userId, Integer examId);
	public List<Result> findResultsByUserId(Integer userId);
	public Result findById(Integer resultId);
	public List<Result> getAllResults();

}
