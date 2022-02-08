package com.willka.soft.bean;

import java.io.Serializable;

public class UserBean implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private int user_id;
	private String user_name;
	private String user_email;
	private String user_phone;
	private String user_password;
	private int plant_id;
	private String user_type;
	private String user_status;
	private String user_photo;
	private String user_address;
	private String user_login_id;
	private int business_id;
	private String user_plant_name;
	
	
	public int getUser_id() {
		return user_id;
	}
	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public String getUser_email() {
		return user_email;
	}
	public void setUser_email(String user_email) {
		this.user_email = user_email;
	}
	public String getUser_phone() {
		return user_phone;
	}
	public void setUser_phone(String user_phone) {
		this.user_phone = user_phone;
	}
	public String getUser_password() {
		return user_password;
	}
	public void setUser_password(String user_password) {
		this.user_password = user_password;
	}
	public int getPlant_id() {
		return plant_id;
	}
	public void setPlant_id(int plant_id) {
		this.plant_id = plant_id;
	}
	public String getUser_type() {
		return user_type;
	}
	public void setUser_type(String user_type) {
		this.user_type = user_type;
	}
	public String getUser_status() {
		return user_status;
	}
	public void setUser_status(String user_status) {
		this.user_status = user_status;
	}
	public String getUser_photo() {
		return user_photo;
	}
	public void setUser_photo(String user_photo) {
		this.user_photo = user_photo;
	}
	public String getUser_address() {
		return user_address;
	}
	public void setUser_address(String user_address) {
		this.user_address = user_address;
	}
	public String getUser_login_id() {
		return user_login_id;
	}
	public void setUser_login_id(String user_login_id) {
		this.user_login_id = user_login_id;
	}
	public int getBusiness_id() {
		return business_id;
	}
	public void setBusiness_id(int business_id) {
		this.business_id = business_id;
	}
	public String getUser_plant_name() {
		return user_plant_name;
	}
	public void setUser_plant_name(String user_plant_name) {
		this.user_plant_name = user_plant_name;
	}
	@Override
	public String toString() {
		return "UserBean [user_id=" + user_id + ", user_name=" + user_name + ", user_email=" + user_email
				+ ", user_phone=" + user_phone + ", user_password=" + user_password + ", plant_id=" + plant_id
				+ ", user_type=" + user_type + ", user_status=" + user_status + ", user_photo=" + user_photo
				+ ", user_address=" + user_address + ", user_login_id=" + user_login_id + ", business_id=" + business_id
				+ ", user_plant_name=" + user_plant_name + "]";
	}
}
