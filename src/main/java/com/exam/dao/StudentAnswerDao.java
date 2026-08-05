package com.exam.dao;

import java.util.List;

import com.exam.entity.StudentAnswer;

public interface StudentAnswerDao {

	public void save(StudentAnswer studentAnswer);

	public List<StudentAnswer> findByResultId(Integer resultId);
}
