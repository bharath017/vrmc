package com.willka.soft.bean;

public class CustomerBean {
	
	private int customer_id;
	private String customer_name;
	private String customer_email;
	private String customer_phone;
	private String customer_gstin;
	private String customer_status;
	private String customer_panno;
	private String customer_address;
	private int mp_id;
	private int business_id;
	private double opening_balance;
	private String last_dispatch_date;
	private int plant_id;
	
	public int getCustomer_id() {
		return customer_id;
	}
	public void setCustomer_id(int customer_id) {
		this.customer_id = customer_id;
	}
	public String getCustomer_name() {
		return customer_name;
	}
	public void setCustomer_name(String customer_name) {
		this.customer_name = customer_name;
	}
	public String getCustomer_email() {
		return customer_email;
	}
	public void setCustomer_email(String customer_email) {
		this.customer_email = customer_email;
	}
	public String getCustomer_phone() {
		return customer_phone;
	}
	public void setCustomer_phone(String customer_phone) {
		this.customer_phone = customer_phone;
	}
	public String getCustomer_gstin() {
		return customer_gstin;
	}
	public void setCustomer_gstin(String customer_gstin) {
		this.customer_gstin = customer_gstin;
	}
	public String getCustomer_status() {
		return customer_status;
	}
	public void setCustomer_status(String customer_status) {
		this.customer_status = customer_status;
	}
	public String getCustomer_panno() {
		return customer_panno;
	}
	public void setCustomer_panno(String customer_panno) {
		this.customer_panno = customer_panno;
	}
	public String getCustomer_address() {
		return customer_address;
	}
	public void setCustomer_address(String customer_address) {
		this.customer_address = customer_address;
	}
	public int getMp_id() {
		return mp_id;
	}
	public void setMp_id(int mp_id) {
		this.mp_id = mp_id;
	}
	public int getBusiness_id() {
		return business_id;
	}
	public void setBusiness_id(int business_id) {
		this.business_id = business_id;
	}
	public double getOpening_balance() {
		return opening_balance;
	}
	public void setOpening_balance(double opening_balance) {
		this.opening_balance = opening_balance;
	}
	public String getLast_dispatch_date() {
		return last_dispatch_date;
	}
	public void setLast_dispatch_date(String last_dispatch_date) {
		this.last_dispatch_date = last_dispatch_date;
	}
	public int getPlant_id() {
		return plant_id;
	}
	public void setPlant_id(int plant_id) {
		this.plant_id = plant_id;
	}
	@Override
	public String toString() {
		return "CustomerBean [customer_id=" + customer_id + ", customer_name=" + customer_name + ", customer_email="
				+ customer_email + ", customer_phone=" + customer_phone + ", customer_gstin=" + customer_gstin
				+ ", customer_status=" + customer_status + ", customer_panno=" + customer_panno + ", customer_address="
				+ customer_address + ", mp_id=" + mp_id + ", business_id=" + business_id + ", opening_balance="
				+ opening_balance + ", last_dispatch_date=" + last_dispatch_date + ", plant_id=" + plant_id + "]";
	}
}
