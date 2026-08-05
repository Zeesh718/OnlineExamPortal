package com.exam.service;

import java.util.List;

import com.exam.entity.StudentAnswer;

public interface StudentAnswerService {

	public void save(StudentAnswer studentAnswer);

	public List<StudentAnswer> findByResultId(Integer resultId);
}
