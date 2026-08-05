package com.exam.dao;

import java.util.List;

import com.exam.entity.Subject;

public interface SubjectDao {
	
	public void saveSubject(Subject subject);
	public List<Subject> getAllSubjects();
	public Subject getSubjectById(Integer subjectId);
	public void updateStatus(Integer subjectId,boolean status);
	public void deleteSubject(Integer subjectId);
	public void updateSubject(Subject subject);
	
	Subject getSubjectByName(String subjectName);

}
