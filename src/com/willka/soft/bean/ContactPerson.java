package com.willka.soft.bean;

public class ContactPerson {

	private int contact_id;
	private String contact_name;
	private String phone;
	private String email;
	private int customer_id;
	
	public int getContact_id() {
		return contact_id;
	}
	public void setContact_id(int contact_id) {
		this.contact_id = contact_id;
	}
	public String getContact_name() {
		return contact_name;
	}
	public void setContact_name(String contact_name) {
		this.contact_name = contact_name;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public int getCustomer_id() {
		return customer_id;
	}
	public void setCustomer_id(int customer_id) {
		this.customer_id = customer_id;
	}
	
	@Override
	public String toString() {
		return "ContactPerson [contact_id=" + contact_id + ", contact_name=" + contact_name + ", phone=" + phone
				+ ", email=" + email + ", customer_id=" + customer_id + "]";
	}
	
	
	
}
