package com.exam.serviceimpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.exam.dao.StudentAnswerDao;
import com.exam.entity.StudentAnswer;
import com.exam.service.StudentAnswerService;

@Service
@Transactional
public class StudentAnswerServiceImpl implements StudentAnswerService {

	@Autowired
	private StudentAnswerDao studentAnswerDao;

	@Override
	public void save(StudentAnswer studentAnswer) {
		studentAnswerDao.save(studentAnswer);
	}

	@Override
	public List<StudentAnswer> findByResultId(Integer resultId) {
		return studentAnswerDao.findByResultId(resultId);
	}
}
