package com.exam.entity;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;

@Entity
public class Subject {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer subjectId;
	@NotBlank(message="Subject name is required")
	@Size(min=2,max=30,message="Subject name must be between 2 and 30 characters")
	@Column(unique=true)
	private String  subjectName;
	private boolean status;
	
	@OneToMany (mappedBy = "subject")                      //@JoinColumn owner side par lagta hai. (Jis table me foreign key banegi.)                             
	private List<Exams> exams;                            //mappedBy optional hai. Sirf tab lagta hai jab tum relation ko dusri side se bhi access karna chahte ho.
	
	
	@OneToMany(mappedBy="subject")
	private List<Questions> questions ;
	
	public Subject() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Subject(Integer subjectId, String subjectName, boolean status) {
		super();
		this.subjectId = subjectId;
		this.subjectName = subjectName;
		this.status = status;
	}
	public Integer getSubjectId() {
		return subjectId;
	}
	public void setSubjectId(Integer subjectId) {
		this.subjectId = subjectId;
	}
	public String getSubjectName() {
		return subjectName;
	}
	public void setSubjectName(String subjectName) {
		this.subjectName = subjectName;
	}
	public boolean isStatus() {
		return status;
	}
	public void setStatus(boolean status) {
		this.status = status;
	}
	

}
