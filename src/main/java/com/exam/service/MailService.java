package com.exam.service;

import java.io.UnsupportedEncodingException;

public interface MailService {

	public void sendWelcomeMail(String toEmail, String name, String studentId) throws UnsupportedEncodingException;

	public void sendOtpMail(String toEmail, String name, String otp) throws UnsupportedEncodingException;

}
