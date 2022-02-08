package com.willka.soft.bean;

import java.io.Serializable;

public class MarketingPersonBean implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1454L;
	
	private int mp_id;
	private String mp_name;
	private String mp_phone;
	private String mp_address;
	private String mp_email;
	private String mp_type;
	private int mp_head;
	private int plant_id;
	private String mp_acno;
	private String mp_ifsc;
	private String mp_accholder;
	private String mp_status;
	private String mp_login_id;
	private String mp_password;
	
	
	public String getMp_login_id() {
		return mp_login_id;
	}
	public void setMp_login_id(String mp_login_id) {
		this.mp_login_id = mp_login_id;
	}
	public int getMp_id() {
		return mp_id;
	}
	public void setMp_id(int mp_id) {
		this.mp_id = mp_id;
	}
	public String getMp_name() {
		return mp_name;
	}
	public void setMp_name(String mp_name) {
		this.mp_name = mp_name;
	}
	public String getMp_phone() {
		return mp_phone;
	}
	public void setMp_phone(String mp_phone) {
		this.mp_phone = mp_phone;
	}
	public String getMp_address() {
		return mp_address;
	}
	public void setMp_address(String mp_address) {
		this.mp_address = mp_address;
	}
	public String getMp_email() {
		return mp_email;
	}
	public void setMp_email(String mp_email) {
		this.mp_email = mp_email;
	}

	public String getMp_type() {
		return mp_type;
	}
	public void setMp_type(String mp_type) {
		this.mp_type = mp_type;
	}
	public int getMp_head() {
		return mp_head;
	}
	public void setMp_head(int mp_head) {
		this.mp_head = mp_head;
	}
	public int getPlant_id() {
		return plant_id;
	}
	public void setPlant_id(int plant_id) {
		this.plant_id = plant_id;
	}
	public String getMp_acno() {
		return mp_acno;
	}
	public void setMp_acno(String mp_acno) {
		this.mp_acno = mp_acno;
	}
	public String getMp_ifsc() {
		return mp_ifsc;
	}
	public void setMp_ifsc(String mp_ifsc) {
		this.mp_ifsc = mp_ifsc;
	}
	public String getMp_accholder() {
		return mp_accholder;
	}
	public void setMp_accholder(String mp_accholder) {
		this.mp_accholder = mp_accholder;
	}
	public String getMp_status() {
		return mp_status;
	}
	public void setMp_status(String mp_status) {
		this.mp_status = mp_status;
	}
	public String getMp_password() {
		return mp_password;
	}
	public void setMp_password(String mp_password) {
		this.mp_password = mp_password;
	}
	
	@Override
	public String toString() {
		return "MarketingPersonBean [mp_id=" + mp_id + ", mp_name=" + mp_name + ", mp_phone=" + mp_phone
				+ ", mp_address=" + mp_address + ", mp_email=" + mp_email + ", mp_type=" + mp_type + ", mp_head="
				+ mp_head + ", plant_id=" + plant_id + ", mp_acno=" + mp_acno + ", mp_ifsc=" + mp_ifsc
				+ ", mp_accholder=" + mp_accholder + ", mp_status=" + mp_status + ", mp_login_id=" + mp_login_id
				+ ", mp_password=" + mp_password + "]";
	}
	
	
	

}
