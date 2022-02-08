package com.willka.soft.bean;

import java.io.Serializable;
import java.util.Arrays;

public class UserDetailBean implements Serializable {

	private static final long serialVersionUID = 9791L;
	
	private int user_id;
	private String usertype;
	private String users_name;
	private String username;
	private String user_email;
	private String logo;
	private int plant_id;
	private Integer[] roles;
	private int business_id;
	
	public String getUser_email() {
		return user_email;
	}
	public void setUser_email(String user_email) {
		this.user_email = user_email;
	}
	public String getUsertype() {
		return usertype;
	}
	public void setUsertype(String usertype) {
		this.usertype = usertype;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getLogo() {
		return logo;
	}
	public void setLogo(String logo) {
		this.logo = logo;
	}
	public int getPlant_id() {
		return plant_id;
	}
	public void setPlant_id(int plant_id) {
		this.plant_id = plant_id;
	}
	public String getUsers_name() {
		return users_name;
	}
	public void setUsers_name(String users_name) {
		this.users_name = users_name;
	}
	public int getUser_id() {
		return user_id;
	}
	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}
	public Integer[] getRoles() {
		return roles;
	}
	public void setRoles(Integer[] roles) {
		this.roles = roles;
	}
	public int getBusiness_id() {
		return business_id;
	}
	public void setBusiness_id(int business_id) {
		this.business_id = business_id;
	}
	@Override
	public String toString() {
		return "UserDetailBean [user_id=" + user_id + ", usertype=" + usertype + ", users_name=" + users_name
				+ ", username=" + username + ", user_email=" + user_email + ", logo=" + logo + ", plant_id=" + plant_id
				+ ", roles=" + Arrays.toString(roles) + ", business_id=" + business_id + "]";
	}
	

}
