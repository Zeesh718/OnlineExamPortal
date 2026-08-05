package com.exam.service;

import java.time.LocalDate;
import java.util.List;

import com.exam.entity.Exams;

public interface ExamService {
	public void saveExam(Exams exam);
	public List<Exams> getAllExams();
	public Exams getExamById(Integer examId);
	public void updateStatus(Integer examId,boolean status);
	public void deleteExam(Integer examId);
	public void updateExam(Exams exam);
	public List<Exams> getAvailableExams();
	public Exams findByExamNameAndSubjectAndExamDate(String examName, Integer subjectId, LocalDate examDate); 

}
