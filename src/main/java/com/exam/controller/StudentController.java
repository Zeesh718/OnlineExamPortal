package com.exam.controller;

import java.io.File;
import java.io.IOException;
import java.time.LocalDate;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.exam.dto.ProfileDTO;
import com.exam.entity.ExamQuestion;
import com.exam.entity.Exams;
import com.exam.entity.Result;
import com.exam.entity.StudentAnswer;
import com.exam.entity.User;
import com.exam.entity.UserProfile;
import com.exam.service.ExamQuestionService;
import com.exam.service.ExamService;
import com.exam.service.ResultService;
import com.exam.service.StudentAnswerService;
import com.exam.service.UserProfileService;
import com.exam.service.UserService;

@Controller
@RequestMapping("/student")
public class StudentController {

	@Autowired
	ExamService examService;
	@Autowired
	ExamQuestionService examQuestionService;
	@Autowired
	ResultService resultService; 
	@Autowired
	StudentAnswerService studentAnswerService;
	@Autowired
	UserProfileService userProfileService;
	@Autowired
	UserService userService; 

	    // application.properties me jo:
	    // profile.upload.path=D:/OnlineExamPortalUploads/profileImages/
	    // likha hai, uski VALUE Spring is variable me daal dega.
	    @Value("${profile.upload.path}")
	    private String uploadPath;
	
	
	
	
	
	
	@GetMapping("/dashboard")
	public String dshboard(HttpSession session ,Model model) {
		
		User user=(User)session.getAttribute("loggedInUser");
		if(user==null) {
			return "redirect:/auth/login";
		}
		
		model.addAttribute("user", user);

		List<Result> myResults = resultService.findResultsByUserId(user.getUserId());
		int attempted = myResults.size();
		model.addAttribute("completedExamsCount", attempted);

		double avgScore = 0, highScore = 0, lowScore = 0;
		if (attempted > 0) {
			double sum = 0;
			highScore = Double.MIN_VALUE;
			lowScore = Double.MAX_VALUE;
			for (Result r : myResults) {
				int total = (r.getExam() != null && r.getExam().getTotalMarks() != null
						&& r.getExam().getTotalMarks() > 0) ? r.getExam().getTotalMarks() : 1;
				double pct = (r.getObtainedMarks() * 100.0) / total;
				sum += pct;
				if (pct > highScore) highScore = pct;
				if (pct < lowScore) lowScore = pct;
			}
			avgScore = sum / attempted;
		}
		model.addAttribute("avgScore", Math.round(avgScore * 10.0) / 10.0);
		model.addAttribute("highScore", Math.round(highScore * 10.0) / 10.0);
		model.addAttribute("lowScore", Math.round(lowScore * 10.0) / 10.0);

		List<Exams> availableExams = examService.getAvailableExams();
		model.addAttribute("upcomingExamsCount", availableExams.size());
		model.addAttribute("recentExams",
				availableExams.size() > 3 ? availableExams.subList(0, 3) : availableExams);

		List<Result> recentResultsList = myResults.size() > 4 ? myResults.subList(0, 4) : myResults;
		model.addAttribute("recentResults", recentResultsList);

		// Profile completion %
		UserProfile profile = userProfileService.profileFindByUserId(user.getUserId());
		int filled = 0;
		int totalFields = 6;
		if (profile != null) {
			if (profile.getDateOfBirth() != null) filled++;
			if (profile.getGender() != null && !profile.getGender().isBlank()) filled++;
			if (profile.getAddress() != null && !profile.getAddress().isBlank()) filled++;
			if (profile.getCity() != null && !profile.getCity().isBlank()) filled++;
			if (profile.getQualification() != null && !profile.getQualification().isBlank()) filled++;
			if (profile.getProfileImage() != null && !profile.getProfileImage().isBlank()) filled++;
		}
		int profileCompletion = (filled * 100) / totalFields;
		model.addAttribute("profileCompletion", profileCompletion);

		return "student/studentDashboard";
	}
	
	
	@GetMapping("/availableExams")
	public String available(@RequestParam(defaultValue = "1") int page, HttpSession session,Model model) {
		
		
		List<Exams>	availableExams=examService.getAvailableExams();
		
		
		if(availableExams!=null) {
				for(Exams exam : availableExams) 
				{
					User user=(User)session.getAttribute("loggedInUser");
					
					Result result =resultService.getResultByUserAndExam(user.getUserId(),exam.getExamId());
				
						if(result!=null) {
							
								exam.setAttemted(true);
						}
						else {
							exam.setAttemted(false);
						}
			    }
		com.exam.utility.PageResult<Exams> pageResult = com.exam.utility.PageUtil.paginate(availableExams, page, 6);
		model.addAttribute("availableExamsList", pageResult.getContent());
		model.addAttribute("pageResult", pageResult);
		}
		else {
			model.addAttribute("msg","No Exam Available");
		}
		
		
		
		return "student/availableExams";
	}
	
	
	
	@GetMapping("/viewAvailableExamDetails/{examId}")
	public String viewExamDetails(@PathVariable Integer examId,Model model,HttpSession session) {
		
		Exams exam =examService.getExamById(examId);
		
		User user=(User)session.getAttribute("loggedInUser");
		Result result =resultService.getResultByUserAndExam(user.getUserId(),examId);
		
		if(result!=null) {
			
				exam.setAttemted(true);
		}
		else {
			exam.setAttemted(false);
			
		}
		
		model.addAttribute("exam", exam);
		
		return "student/viewAvailableExamDetail";
		
	}
	@GetMapping("/startExam/{examId}")
	public String startExam(@PathVariable Integer examId,Model model, HttpSession session,RedirectAttributes ra) {
		
		Exams exam =examService.getExamById(examId);
		List<ExamQuestion> examQuestionList=examQuestionService.getQuestionsByExamId(examId);
		
		model.addAttribute("exam", exam);
		model.addAttribute("examQuestionList", examQuestionList);
		
		
		// ye itta code sirf url se koi nahi chala jaye examdene uske liye kiya hai 
		User user = (User) session.getAttribute("loggedInUser");

		Result result = resultService.getResultByUserAndExam(
		        user.getUserId(),
		        examId);

		if(result != null) {
		    // Already Attempted so 
			ra.addFlashAttribute("msg","*cheating Karta Hai sale..!"
					+ " Batau Teko Abhi 👊🏻👊🏻");
			return "redirect:/student/availableExams";
		}
		////////////////////////////////////////////////////////////////////////////
		return "student/takeExam";
		
	}
	
	@PostMapping("/submitExam")
	public String submitExam(@RequestParam Map<String,String> answers,Model model, HttpSession session)
	{
		Integer examId=Integer.parseInt(answers.get("examId"));
		Exams exam =examService.getExamById(examId);
		List<ExamQuestion> examQuestionList=examQuestionService
				.getQuestionsByExamId(examId);
		answers.remove("examId");
		int correct=0;
		int marks=0;
		int wrong=0;
		int unattempted=0;
		// Har question ka student ka jawab yaad rakhte hain - result save hone ke baad
		// StudentAnswer rows ke roop me persist karenge (question-wise analysis ke liye).
		java.util.List<StudentAnswer> pendingAnswers = new java.util.ArrayList<>();
		for(ExamQuestion examQuestion:examQuestionList) {
			String selected = answers.get(examQuestion.getQuestion().getQuestionId().toString());
			boolean isCorrect = false;
			if(selected!=null) {
				
					if(examQuestion.getQuestion().getCorrectAnswer()
					.equals(selected))
					{
						
						correct++;
						marks+=examQuestion.getQuestion().getMarks();
						isCorrect = true;
						
					}
					else {
						wrong++;
					}
			}	
			else {
				unattempted++;
			}
			StudentAnswer sa = new StudentAnswer();
			sa.setQuestion(examQuestion.getQuestion());
			sa.setSelectedOption(selected);
			sa.setCorrect(isCorrect);
			pendingAnswers.add(sa);
			
		}
		model.addAttribute("correct", correct);
		model.addAttribute("marks", marks);
		model.addAttribute("wrong", wrong);
		model.addAttribute("unattempted", unattempted);
		model.addAttribute("exam", exam);
		
		Result result=new Result();
		
		result.setCorrect(correct);
		result.setObtainedMarks(marks);
		result.setWrong(wrong);
		result.setUnattemted(unattempted);
		result.setExam(exam);
		result.setSubmittedDate(LocalDate.now());
		//System.out.print((User)(session.getAttribute("loggedInUser")));
		result.setUser((User)(session.getAttribute("loggedInUser")));
													
		resultService.saveResult(result);

		for (StudentAnswer sa : pendingAnswers) {
			sa.setResult(result);
			studentAnswerService.save(sa);
		}

		model.addAttribute("resultId", result.getResutId());
		model.addAttribute("studentAnswers", pendingAnswers);
		
		return "student/result";
	}
	
	
	
	
	
	
	
	
	@GetMapping("/editProfile")
	public String editProfile(HttpSession session, Model model) {
		
		User loggedInUser= (User) session.getAttribute("loggedInUser");
		
		User user= userService.findByEmail(loggedInUser.getEmail());
		
		UserProfile userProfile= userProfileService.profileFindByUserId(user.getUserId());		
		
	    ProfileDTO profileDTO= new ProfileDTO();
	   
	    profileDTO.setName(user.getName());
		profileDTO.setEmail(user.getEmail());
		profileDTO.setMobile(user.getMobile());
		
		  if(userProfile != null) {

			  profileDTO.setDateOfBirth(userProfile.getDateOfBirth());
			  profileDTO.setGender(userProfile.getGender());
			  profileDTO.setAddress(userProfile.getAddress());
			  profileDTO.setCity(userProfile.getCity());
			  profileDTO.setQualification(userProfile.getQualification());
			  profileDTO.setBio(userProfile.getBio());
			  
			  profileDTO.setExistingProfileImage(userProfile.getProfileImage());
			  
			  model.addAttribute("profileCompleted", true);
		    }

		  else {
		  
			model.addAttribute("profileCompleted", false); // button ke naam ke liye hai wo complete ya fir edit esa
			
		  }
			   
			
		model.addAttribute("profileDTO", profileDTO);
		
		return "student/editProfile";
	}
	
	@PostMapping("/editProfile")
	public String saveEditProfile(@ModelAttribute("profileDTO") ProfileDTO profileDTO , HttpSession session, Model model, RedirectAttributes ra) throws IllegalStateException, IOException {
		
		
//		System.out.println("===== POST EDIT PROFILE CHALA =====");
//	    System.out.println("Name = " + profileDTO.getName());
//	    System.out.println("Mobile = " + profileDTO.getMobile());
//	    System.out.println("DOB = " + profileDTO.getDateOfBirth());
//	    System.out.println("Gender = " + profileDTO.getGender());
//	    System.out.println("Address = " + profileDTO.getAddress());
//	    System.out.println("City = " + profileDTO.getCity());
//	    System.out.println("Qualification = " + profileDTO.getQualification());
//	    System.out.println("Bio = " + profileDTO.getBio());
//	    
	    
		User loggedInUser= (User) session.getAttribute("loggedInUser");
		
		User user= userService.findByEmail(loggedInUser.getEmail());
		
		
	   // ProfileDTO profileDTO= new ProfileDTO();
	   
	    user.setName(profileDTO.getName());
	    //user.setEmail(profileDTO.getEmail());
	    user.setMobile(profileDTO.getMobile());
	    userService.updateUser(user);
	    
	    
	    
	    UserProfile userProfile= userProfileService.profileFindByUserId(user.getUserId());		
		
		
		  if(userProfile != null) { 
			  
			  userProfile.setUser(user);

			  userProfile.setDateOfBirth(profileDTO.getDateOfBirth());
			  userProfile.setGender(profileDTO.getGender());
			  userProfile.setAddress(profileDTO.getAddress());
			  userProfile.setCity(profileDTO.getCity());
			  userProfile.setQualification(profileDTO.getQualification());
			  userProfile.setBio(profileDTO.getBio());
			  
			  // image ka kaam 
			  
			  MultipartFile image = profileDTO.getProfileImage();
			  if (image != null && !image.isEmpty()) {
			  String originalName= image.getOriginalFilename();
			  
			  String fileName= System.currentTimeMillis()+"_"+originalName;
			  
			  //String  uploadPath = session.getServletContext().getRealPath("/images/profileImage/");
			 
			  File folder = new File(uploadPath); // new File(uploadPath) folder banati nahi hai. Ye bas Java ka File object banati hai jo us path ko represent karta hai. File folder = new File(uploadPath);
			  									//Matlab Java se keh rahe ho: "folder naam ka object is location ko represent karega."
			  		     						//Actual folder ye line banati hai: folder.mkdirs();
			  
			  if(!folder.exists()) {
				  folder.mkdirs();
			  }
			  File destination= new File(folder,fileName);
			  
			  image.transferTo(destination);
//			  System.out.println("UPLOAD PATH = " + uploadPath);
//			  System.out.println("FILE NAME = " + fileName);
//			  System.out.println("DESTINATION = " + destination.getAbsolutePath());
			  
			  userProfile.setProfileImage(fileName);
			 // System.out.println("Image saved ");
			  
			// Header ko turant new image mile
			  session.setAttribute("loggedInUserProfileImage", fileName);
			  
			  }
			  userProfileService.updateUserProfile(userProfile);
		    }
		  
		  
		  if(userProfile == null) {
			  UserProfile userProfileNew = new UserProfile();
			  
			  
			   userProfileNew.setUser(user);
			 
			  userProfileNew.setDateOfBirth(profileDTO.getDateOfBirth());
			  userProfileNew.setGender(profileDTO.getGender());
			  userProfileNew.setAddress(profileDTO.getAddress());
			  userProfileNew.setCity(profileDTO.getCity());
			  userProfileNew.setQualification(profileDTO.getQualification());
			  userProfileNew.setBio(profileDTO.getBio());
			  
			  
			  
                  // image ka kaam 
			  
			  MultipartFile image = profileDTO.getProfileImage();
			  if (image != null && !image.isEmpty()) {
			  String originalName= image.getOriginalFilename();
			  
			  String fileName= System.currentTimeMillis()+"_"+originalName;
			  
			  //String  uploadPath = session.getServletContext().getRealPath("/images/profileImage/");
			 
			  File folder = new File(uploadPath); // new File(uploadPath) folder banati nahi hai. Ye bas Java ka File object banati hai jo us path ko represent karta hai. File folder = new File(uploadPath);
			  									//Matlab Java se keh rahe ho: "folder naam ka object is location ko represent karega."
			  		     						//Actual folder ye line banati hai: folder.mkdirs();
			  
			  if(!folder.exists()) {
				  folder.mkdirs();
			  }
			  File destination= new File(folder,fileName);
			  
			  image.transferTo(destination);
	  
//			  System.out.println("UPLOAD PATH = " + uploadPath);
//			  System.out.println("FILE NAME = " + fileName);
//			  System.out.println("DESTINATION = " + destination.getAbsolutePath());
			  
			  
			  
			  
			  userProfileNew.setProfileImage(fileName);
//			  System.out.println("Image saved ");
			  
			// Header ko turant new image mile
			  session.setAttribute("loggedInUserProfileImage", fileName);
			  }
			  userProfileService.saveUserProfile(userProfileNew);

		  }

		  
			
		model.addAttribute("profileDTO", profileDTO);
		ra.addFlashAttribute( "profileMsg","Profile updated successfully");
		return "redirect:/student/editProfile";
	}
	
}
