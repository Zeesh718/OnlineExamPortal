package com.exam.serviceimpl;

import java.time.LocalDate;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.exam.dao.ExamDao;
import com.exam.entity.Exams;
import com.exam.service.ExamService;


@Service
@Transactional
public class ExamServiceImpl implements ExamService {
	@Autowired
	ExamDao examDao;
	@Override
	public void saveExam(Exams exam) {
		exam.setStatus(true);
		examDao.saveExam(exam);
	}

	@Override
	public List<Exams> getAllExams() {
		return examDao.getAllExams();
	}

	@Override
	public Exams getExamById(Integer examId) {
		return examDao.getExamById(examId);
	}

	@Override
	public void updateStatus(Integer examId, boolean status) {
        examDao.updateStatus(examId, status);		
	}

	@Override
	public void deleteExam(Integer examId) {
		examDao.deleteExam(examId);
	}
	@Override
	public void updateExam(Exams exam) {
        examDao.updateExam(exam);		
	}

	@Override
	public List<Exams> getAvailableExams() {
		
		return examDao.getAvailableExams();
	}

	@Override
	public Exams findByExamNameAndSubjectAndExamDate(String examName, Integer subjectId, LocalDate examDate) {
		
		return examDao.findByExamNameAndSubjectAndExamDate(examName, subjectId,examDate);
	}  

}
