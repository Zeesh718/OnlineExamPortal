package com.exam.daoimpl;

import java.util.List;

import org.hibernate.query.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import com.exam.dao.UserDao;
import com.exam.entity.User;
import com.exam.entity.UserProfile;


@Repository
@Transactional
public class UserDaoImpl implements UserDao{

	@Autowired
	private SessionFactory sessionFactory;
	@Override
	public void save(User user) {
		
		Session session= sessionFactory.getCurrentSession();
		session.save(user);
		
	}
	@Override
	public User findByEmail(String email) {
		Session session= sessionFactory.getCurrentSession();
		
		//return session.get(User.class, email); // session.get() sirf Primary Key (ID) se record la sakta hai.
		//Isliye ham yenabi kar sakte hai,  HQL ki zarurat padti hai.
		
		String hql= "from User where email= :email";// select taab lagega jab hame specific coloumn ka data chahiye hota hai like sirf nam ya email ya dono etc  ex= select e.name ,e.email fromEmployeee where e.dept='IT';
		// String hql= "from User Where email='"+email+"'"; esa isliye nahi kar sakte kyukiSQL 1) Injection ka risk. 2)Performance kharab 3)Professional code nahi.
		Query<User> query= session.createQuery(hql,User.class);
		
		query.setParameter("email",email);
		
		return query.uniqueResult();		
	
	}
	@Override
	public User findByStudentId(String studentId) {
		Session session = sessionFactory.getCurrentSession();
		String hql = "from User where studentId= :studentId";
		Query<User> query = session.createQuery(hql, User.class);
		query.setParameter("studentId", studentId);
		return query.uniqueResult();
	}
	@Override
	public List<User> getAllStudents() {
//		Session session = sessionFactory.getCurrentSession();
//		Query<User> query =session.createQuery("from User where role.roleName='STUDENT'",User.class);
//		
//		List<User> studentList=query.list();
		return sessionFactory
			  .getCurrentSession()
			  .createQuery("from User where role.roleName='STUDENT'",User.class)
			  .list();
		
	}
	@Override
	public void changeStatus(Integer userId, boolean status) {
		User user=sessionFactory.getCurrentSession().get(User.class, userId);
		
		user.setStatus(status);
		
	}
	@Override
	public void deleteStudent(Integer userId) {
		User user=sessionFactory.getCurrentSession().get(User.class, userId);
		if(user!=null) {
		sessionFactory.getCurrentSession().delete(user);
		
		}
	}
	@Override
	public void updateUser(User user) {
		
		sessionFactory.getCurrentSession().update(user);
		
	}
	
}
