package com.exam.interceptor;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;

public class LoginInterceptor implements HandlerInterceptor {
	
	@Override
	public boolean preHandle( HttpServletRequest request , HttpServletResponse response, Object handler)throws Exception
	{
		
		HttpSession session=request.getSession(false); //Agar existing session hai to do, lekin session nahi hai to naya session mat banao.
		
		if(session == null || session.getAttribute("loggedInUser")==null) {
			
			response.sendRedirect(request.getContextPath()+"/login"); //To final URL: /OnlineExamPortal/login
			return false;
		}
		
		
		
		return true;
		
	}
		
	

}
