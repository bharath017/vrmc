package com.willka.soft.test.bean;

import java.io.Serializable;

public class CustomerPaymentBean implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1345L;
	
	private int payment_id;
	private int customer_id;
	private double payment_amount;
	private String payment_category;
	private String check_dd_number;
	private String check_dd_validity;
	private String neft_no;
	private String payment_date;
	private String payment_time;
	private String timestamp;
	private int mp_id;
	private int site_id;
	private String user_name;
	private String bill_photo;
	private int bank_detail_id;
	private int category_id;
	
	
	//modification details
	private int payment_mod_id;
	private double modification_payment_amount;
	private String modification_type;
	private String comment;
	private String modification_timestamp;
	private String modification_user;
	
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	public int getPayment_id() {
		return payment_id;
	}
	public int getCustomer_id() {
		return customer_id;
	}
	public double getPayment_amount() {
		return payment_amount;
	}
	public String getPayment_category() {
		return payment_category;
	}
	public String getCheck_dd_number() {
		return check_dd_number;
	}
	public String getCheck_dd_validity() {
		return check_dd_validity;
	}
	public String getNeft_no() {
		return neft_no;
	}
	public String getPayment_date() {
		return payment_date;
	}
	public String getPayment_time() {
		return payment_time;
	}
	public String getTimestamp() {
		return timestamp;
	}
	public int getMp_id() {
		return mp_id;
	}
	public int getSite_id() {
		return site_id;
	}
	public String getUser_name() {
		return user_name;
	}
	public String getBill_photo() {
		return bill_photo;
	}
	public int getBank_detail_id() {
		return bank_detail_id;
	}
	public int getPayment_mod_id() {
		return payment_mod_id;
	}
	public double getModification_payment_amount() {
		return modification_payment_amount;
	}
	public String getModification_type() {
		return modification_type;
	}
	public String getComment() {
		return comment;
	}
	public String getModification_timestamp() {
		return modification_timestamp;
	}
	public String getModification_user() {
		return modification_user;
	}
	public void setPayment_id(int payment_id) {
		this.payment_id = payment_id;
	}
	public void setCustomer_id(int customer_id) {
		this.customer_id = customer_id;
	}
	public void setPayment_amount(double payment_amount) {
		this.payment_amount = payment_amount;
	}
	public void setPayment_category(String payment_category) {
		this.payment_category = payment_category;
	}
	public void setCheck_dd_number(String check_dd_number) {
		this.check_dd_number = check_dd_number;
	}
	public void setCheck_dd_validity(String check_dd_validity) {
		this.check_dd_validity = check_dd_validity;
	}
	public void setNeft_no(String neft_no) {
		this.neft_no = neft_no;
	}
	public void setPayment_date(String payment_date) {
		this.payment_date = payment_date;
	}
	public void setPayment_time(String payment_time) {
		this.payment_time = payment_time;
	}
	public void setTimestamp(String timestamp) {
		this.timestamp = timestamp;
	}
	public void setMp_id(int mp_id) {
		this.mp_id = mp_id;
	}
	public void setSite_id(int site_id) {
		this.site_id = site_id;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public void setBill_photo(String bill_photo) {
		this.bill_photo = bill_photo;
	}
	public void setBank_detail_id(int bank_detail_id) {
		this.bank_detail_id = bank_detail_id;
	}
	public void setPayment_mod_id(int payment_mod_id) {
		this.payment_mod_id = payment_mod_id;
	}
	public void setModification_payment_amount(double modification_payment_amount) {
		this.modification_payment_amount = modification_payment_amount;
	}
	public void setModification_type(String modification_type) {
		this.modification_type = modification_type;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	public void setModification_timestamp(String modification_timestamp) {
		this.modification_timestamp = modification_timestamp;
	}
	public void setModification_user(String modification_user) {
		this.modification_user = modification_user;
	}
	public int getCategory_id() {
		return category_id;
	}
	public void setCategory_id(int category_id) {
		this.category_id = category_id;
	}
	@Override
	public String toString() {
		return "CustomerPaymentBean [payment_id=" + payment_id + ", customer_id=" + customer_id + ", payment_amount="
				+ payment_amount + ", payment_category=" + payment_category + ", check_dd_number=" + check_dd_number
				+ ", check_dd_validity=" + check_dd_validity + ", neft_no=" + neft_no + ", payment_date=" + payment_date
				+ ", payment_time=" + payment_time + ", timestamp=" + timestamp + ", mp_id=" + mp_id + ", site_id="
				+ site_id + ", user_name=" + user_name + ", bill_photo=" + bill_photo + ", bank_detail_id="
				+ bank_detail_id + ", category_id=" + category_id + ", payment_mod_id=" + payment_mod_id
				+ ", modification_payment_amount=" + modification_payment_amount + ", modification_type="
				+ modification_type + ", comment=" + comment + ", modification_timestamp=" + modification_timestamp
				+ ", modification_user=" + modification_user + "]";
	}
	
}
