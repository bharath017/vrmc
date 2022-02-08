package com.willka.soft.test.bean;

import java.io.Serializable;

public class SalesComissionBean implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 5011208971563734082L;
	private int payment_id;
	private int customer_id;
	private double payment_amount;
	private String payment_category;
	private String check_dd_number;
	private String check_dd_validity;
	private String payment_date;
	private String payment_time;
	private int site_id;
	private String paid_to;
	
	private String timestamp;
	
	//modification details
	private int payment_mod_id;
	private double modification_payment_amount;
	private String modification_type;
	private String comment;
	private String modification_timestamp;
	private String modification_user;
	
	
	
	public int getPayment_id() {
		return payment_id;
	}
	public void setPayment_id(int payment_id) {
		this.payment_id = payment_id;
	}
	public int getCustomer_id() {
		return customer_id;
	}
	public void setCustomer_id(int customer_id) {
		this.customer_id = customer_id;
	}
	public double getPayment_amount() {
		return payment_amount;
	}
	public void setPayment_amount(double payment_amount) {
		this.payment_amount = payment_amount;
	}
	public String getPayment_category() {
		return payment_category;
	}
	public void setPayment_category(String payment_category) {
		this.payment_category = payment_category;
	}
	public String getCheck_dd_number() {
		return check_dd_number;
	}
	public void setCheck_dd_number(String check_dd_number) {
		this.check_dd_number = check_dd_number;
	}
	public String getCheck_dd_validity() {
		return check_dd_validity;
	}
	public void setCheck_dd_validity(String check_dd_validity) {
		this.check_dd_validity = check_dd_validity;
	}
	public String getPayment_date() {
		return payment_date;
	}
	public void setPayment_date(String payment_date) {
		this.payment_date = payment_date;
	}
	public String getPayment_time() {
		return payment_time;
	}
	public void setPayment_time(String payment_time) {
		this.payment_time = payment_time;
	}
	public String getTimestamp() {
		return timestamp;
	}
	public void setTimestamp(String timestamp) {
		this.timestamp = timestamp;
	}
	
	
	
	//modification getter and setter method
	
	public int getPayment_mod_id() {
		return payment_mod_id;
	}
	public void setPayment_mod_id(int payment_mod_id) {
		this.payment_mod_id = payment_mod_id;
	}
	public double getModification_payment_amount() {
		return modification_payment_amount;
	}
	public void setModification_payment_amount(double modification_payment_amount) {
		this.modification_payment_amount = modification_payment_amount;
	}
	public String getModification_type() {
		return modification_type;
	}
	public void setModification_type(String modification_type) {
		this.modification_type = modification_type;
	}
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	public String getModification_timestamp() {
		return modification_timestamp;
	}
	public void setModification_timestamp(String modification_timestamp) {
		this.modification_timestamp = modification_timestamp;
	}
	public String getModification_user() {
		return modification_user;
	}
	public void setModification_user(String modification_user) {
		this.modification_user = modification_user;
	}
	
	
	@Override
	public String toString() {
		return "SalesComissionBean [payment_id=" + payment_id + ", customer_id=" + customer_id + ", payment_amount="
				+ payment_amount + ", payment_category=" + payment_category + ", check_dd_number=" + check_dd_number
				+ ", check_dd_validity=" + check_dd_validity + ", payment_date=" + payment_date + ", payment_time="
				+ payment_time + ", site_id=" + site_id + ", paid_to=" + paid_to + ", timestamp=" + timestamp
				+ ", payment_mod_id=" + payment_mod_id + ", modification_payment_amount=" + modification_payment_amount
				+ ", modification_type=" + modification_type + ", comment=" + comment + ", modification_timestamp="
				+ modification_timestamp + ", modification_user=" + modification_user + "]";
	}
	public int getSite_id() {
		return site_id;
	}
	public void setSite_id(int site_id) {
		this.site_id = site_id;
	}
	public String getPaid_to() {
		return paid_to;
	}
	public void setPaid_to(String paid_to) {
		this.paid_to = paid_to;
	}
	
	
	
}
