package com.exam.serviceimpl;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.exam.dao.SubjectDao;
import com.exam.entity.Subject;
import com.exam.service.SubjectService;

@Service
@Transactional
public class SubjectServiceImpl implements SubjectService{
	
	@Autowired
	SubjectDao subjectDao;
	@Override
	public void saveSubject(Subject subject) {
		subject.setStatus(true);
		subjectDao.saveSubject(subject);
	}

	@Override
	public List<Subject> getAllSubjects() {
		return subjectDao.getAllSubjects();
	}

	@Override
	public Subject getSubjectById(Integer subjectId) {
		return subjectDao.getSubjectById(subjectId);
	}

	@Override
	public void updateStatus(Integer subjectId, boolean status) {
        subjectDao.updateStatus(subjectId, status);		
	}

	@Override
	public void deleteSubject(Integer subjectId) {
		subjectDao.deleteSubject(subjectId);
	}
	@Override
	public void updateSubject(Subject subject) {
        subjectDao.updateSubject(subject);		
	}

	@Override
	public Subject getSubjectByName(String subjectName) {
		return subjectDao.getSubjectByName(subjectName);
	}              

}
