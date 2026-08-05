package com.exam.dto;

import java.time.LocalDate;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

public class ProfileDTO {

    // User entity se
    private String name;
    private String mobile;
    private String email;
    
    public String getEmail() {
		return email;
	}


	public void setEmail(String email) {
		this.email = email;
	}

	// UserProfile entity se
	
	@DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDate dateOfBirth;
    private String gender;
    private String address;
    private String city;
    private String qualification;
    private String bio;

    // Upload hone wali file
    private MultipartFile profileImage;

 // DB me pehle se saved image ka filename rakhne ke liye
    private String existingProfileImage;

    public String getExistingProfileImage() {
        return existingProfileImage;
    }

    public void setExistingProfileImage(String existingProfileImage) {
        this.existingProfileImage = existingProfileImage;
    }

    public ProfileDTO() {
    }


    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public LocalDate getDateOfBirth() {
        return dateOfBirth;
    }

    public void setDateOfBirth(LocalDate dateOfBirth) {
        this.dateOfBirth = dateOfBirth;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getQualification() {
        return qualification;
    }

    public void setQualification(String qualification) {
        this.qualification = qualification;
    }

    public String getBio() {
        return bio;
    }

    public void setBio(String bio) {
        this.bio = bio;
    }

    public MultipartFile getProfileImage() {
        return profileImage;
    }

    public void setProfileImage(MultipartFile profileImage) {
        this.profileImage = profileImage;
    }
}