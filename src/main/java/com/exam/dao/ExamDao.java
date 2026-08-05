package com.exam.dao;

import java.time.LocalDate;
import java.util.List;

import com.exam.entity.Exams;

public interface ExamDao {

	public void saveExam(Exams exams);
	public List<Exams> getAllExams();
	public Exams getExamById(Integer examId);
	public void updateStatus(Integer examId,boolean status);
	public void deleteExam(Integer examId);
	public void updateExam(Exams exam);
	public List<Exams> getAvailableExams();
	
	
	List<Exams> getAllActiveExams();
	List<Exams> getExamBySubject(Integer subjectId);
	public Exams findByExamNameAndSubjectAndExamDate(String examName, Integer subjectId, LocalDate examDate);
	
	
}
