package com.exam.serviceimpl;

import java.io.UnsupportedEncodingException;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import com.exam.service.MailService;

@Service
public class MailServiceImpl implements MailService {

	@Autowired
	private JavaMailSender mailSender;

	@Value("${mail.username}")
	private String fromEmail;

	@Override
	public void sendWelcomeMail(String toEmail, String name, String studentId) throws UnsupportedEncodingException {
		try {
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper helper = new MimeMessageHelper(message, true);

			helper.setTo(toEmail);
			helper.setFrom(fromEmail, "Online Exam Portal");
			helper.setSubject("Welcome to Online Exam Portal — Your Student ID: " + studentId);

			String html = "<div style='font-family:Arial,sans-serif;max-width:520px;margin:auto;"
					+ "border:1px solid #e5e7eb;border-radius:10px;overflow:hidden'>"
					+ "<div style='background:#4361ee;padding:22px;text-align:center;color:white;'>"
					+ "<h2 style='margin:0;'>Online Exam Portal</h2></div>"
					+ "<div style='padding:25px;color:#333;'>"
					+ "<h3>Welcome, " + name + "!</h3>"
					+ "<p>Your account has been created successfully. You can now log in and start attempting exams.</p>"
					+ "<table style='width:100%;border-collapse:collapse;margin:18px 0;'>"
					+ "<tr><td style='padding:8px;font-weight:bold;background:#f4f6fb;'>Student ID (Login)</td>"
					+ "<td style='padding:8px;font-weight:bold;color:#4361ee;font-size:16px;'>" + studentId + "</td></tr>"
					+ "<tr><td style='padding:8px;font-weight:bold;background:#f4f6fb;'>Registered Email</td>"
					+ "<td style='padding:8px;'>" + toEmail + "</td></tr></table>"
					+ "<p>Login using your <b>Student ID</b> above and the password you created during registration.</p>"
					+ "<p style='color:#888;font-size:13px;'>For your security we never send your password by email. "
					+ "If you forget it, use the \"Forgot Password\" option on the login page.</p>"
					+ "<p style='margin-top:20px;'>Good luck with your exams!</p></div>"
					+ "<div style='background:#f4f6fb;text-align:center;padding:12px;font-size:12px;color:#888;'>"
					+ "&copy; 2026 Online Exam Portal</div></div>";

			helper.setText(html, true);
			mailSender.send(message);

		} catch (MessagingException e) {
			// Mail fail hone se poori registration process fail nahi honi chahiye
			e.printStackTrace();
		}
	}

	@Override
	public void sendOtpMail(String toEmail, String name, String otp) throws UnsupportedEncodingException {
		try {
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper helper = new MimeMessageHelper(message, true);

			helper.setTo(toEmail);
			helper.setFrom(fromEmail, "Online Exam Portal");
			helper.setSubject("Your Password Reset OTP");

			String html = "<div style='font-family:Arial,sans-serif;max-width:520px;margin:auto;"
					+ "border:1px solid #e5e7eb;border-radius:10px;overflow:hidden'>"
					+ "<div style='background:#4361ee;padding:22px;text-align:center;color:white;'>"
					+ "<h2 style='margin:0;'>Online Exam Portal</h2></div>"
					+ "<div style='padding:25px;color:#333;text-align:center;'>"
					+ "<h3>Hi " + name + ",</h3>"
					+ "<p>Use the OTP below to reset your password. It is valid for 10 minutes.</p>"
					+ "<div style='font-size:32px;font-weight:bold;letter-spacing:8px;background:#f4f6fb;"
					+ "padding:15px;border-radius:8px;margin:20px 0;'>" + otp + "</div>"
					+ "<p style='color:#888;font-size:13px;'>If you did not request this, you can safely ignore this email.</p>"
					+ "</div></div>";

			helper.setText(html, true);
			mailSender.send(message);

		} catch (MessagingException e) {
			e.printStackTrace();
		}
	}
}
