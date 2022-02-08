package com.willka.soft.bean;

import java.io.Serializable;

public class CompanyDetailsBean implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 112321L;
	private int company_id;
	private String company_name;
	private String company_phone;
	private String company_head_office;
	private String company_mail;
	private String company_director;
	private String company_logo;
	private String pan_number;
	private String gstin_number;
	private String registration_no;
	private String established_year;
	private String company_username;
	private String company_password;
	private String user_type;
	private String plant_access;
	
	public int getCompany_id() {
		return company_id;
	}
	public void setCompany_id(int company_id) {
		this.company_id = company_id;
	}
	public String getCompany_name() {
		return company_name;
	}
	public void setCompany_name(String company_name) {
		this.company_name = company_name;
	}
	public String getCompany_phone() {
		return company_phone;
	}
	public void setCompany_phone(String company_phone) {
		this.company_phone = company_phone;
	}
	public String getCompany_head_office() {
		return company_head_office;
	}
	public void setCompany_head_office(String company_head_office) {
		this.company_head_office = company_head_office;
	}
	public String getCompany_mail() {
		return company_mail;
	}
	public void setCompany_mail(String company_mail) {
		this.company_mail = company_mail;
	}
	public String getCompany_director() {
		return company_director;
	}
	public void setCompany_director(String company_director) {
		this.company_director = company_director;
	}
	public String getCompany_logo() {
		return company_logo;
	}
	public void setCompany_logo(String company_logo) {
		this.company_logo = company_logo;
	}
	public String getPan_number() {
		return pan_number;
	}
	public void setPan_number(String pan_number) {
		this.pan_number = pan_number;
	}
	public String getGstin_number() {
		return gstin_number;
	}
	public void setGstin_number(String gstin_number) {
		this.gstin_number = gstin_number;
	}
	public String getRegistration_no() {
		return registration_no;
	}
	public void setRegistration_no(String registration_no) {
		this.registration_no = registration_no;
	}
	public String getEstablished_year() {
		return established_year;
	}
	public void setEstablished_year(String established_year) {
		this.established_year = established_year;
	}
	public String getCompany_username() {
		return company_username;
	}
	public void setCompany_username(String company_username) {
		this.company_username = company_username;
	}
	public String getCompany_password() {
		return company_password;
	}
	public void setCompany_password(String company_password) {
		this.company_password = company_password;
	}
	public String getUser_type() {
		return user_type;
	}
	public void setUser_type(String user_type) {
		this.user_type = user_type;
	}
	public String getPlant_access() {
		return plant_access;
	}
	public void setPlant_access(String plant_access) {
		this.plant_access = plant_access;
	}

	@Override
	public String toString() {
		return "CompanyDetailsBean [company_id=" + company_id + ", company_name=" + company_name + ", company_phone="
				+ company_phone + ", company_head_office=" + company_head_office + ", company_mail=" + company_mail
				+ ", company_director=" + company_director + ", company_logo=" + company_logo + ", pan_number="
				+ pan_number + ", gstin_number=" + gstin_number + ", registration_no=" + registration_no
				+ ", established_year=" + established_year + ", company_username=" + company_username
				+ ", company_password=" + company_password + "]";
	}
	
	
	
}
