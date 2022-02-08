package com.willka.soft.bean;

import java.io.Serializable;

public class MakePaymentBean implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1535L;
	
	private int payment_id;
	private double payment_amount;
	private String payment_date;
	private String payment_time;
	private String payment_mode;
	private String check_dd_no;
	private String check_dd_validity;
	private String payment_timestamp;
	private double new_modified_amount;
	private String comment;
	private String modification_user;
	private String modification_timestamp;
	private String modification_type;
	private String payment_details;
	private int supplier_id;
	private String remark;
	private int bank_detail_id;
	
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	public int getPayment_id() {
		return payment_id;
	}
	public double getPayment_amount() {
		return payment_amount;
	}
	public String getPayment_date() {
		return payment_date;
	}
	public String getPayment_time() {
		return payment_time;
	}
	public String getPayment_mode() {
		return payment_mode;
	}
	public String getCheck_dd_no() {
		return check_dd_no;
	}
	public String getCheck_dd_validity() {
		return check_dd_validity;
	}
	public String getPayment_timestamp() {
		return payment_timestamp;
	}
	public double getNew_modified_amount() {
		return new_modified_amount;
	}
	public String getComment() {
		return comment;
	}
	public String getModification_user() {
		return modification_user;
	}
	public String getModification_timestamp() {
		return modification_timestamp;
	}
	public String getModification_type() {
		return modification_type;
	}
	public String getPayment_details() {
		return payment_details;
	}
	public int getSupplier_id() {
		return supplier_id;
	}
	public String getRemark() {
		return remark;
	}
	public int getBank_detail_id() {
		return bank_detail_id;
	}
	public void setPayment_id(int payment_id) {
		this.payment_id = payment_id;
	}
	public void setPayment_amount(double payment_amount) {
		this.payment_amount = payment_amount;
	}
	public void setPayment_date(String payment_date) {
		this.payment_date = payment_date;
	}
	public void setPayment_time(String payment_time) {
		this.payment_time = payment_time;
	}
	public void setPayment_mode(String payment_mode) {
		this.payment_mode = payment_mode;
	}
	public void setCheck_dd_no(String check_dd_no) {
		this.check_dd_no = check_dd_no;
	}
	public void setCheck_dd_validity(String check_dd_validity) {
		this.check_dd_validity = check_dd_validity;
	}
	public void setPayment_timestamp(String payment_timestamp) {
		this.payment_timestamp = payment_timestamp;
	}
	public void setNew_modified_amount(double new_modified_amount) {
		this.new_modified_amount = new_modified_amount;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	public void setModification_user(String modification_user) {
		this.modification_user = modification_user;
	}
	public void setModification_timestamp(String modification_timestamp) {
		this.modification_timestamp = modification_timestamp;
	}
	public void setModification_type(String modification_type) {
		this.modification_type = modification_type;
	}
	public void setPayment_details(String payment_details) {
		this.payment_details = payment_details;
	}
	public void setSupplier_id(int supplier_id) {
		this.supplier_id = supplier_id;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public void setBank_detail_id(int bank_detail_id) {
		this.bank_detail_id = bank_detail_id;
	}
	
	@Override
	public String toString() {
		return "MakePaymentBean [payment_id=" + payment_id + ", payment_amount=" + payment_amount + ", payment_date="
				+ payment_date + ", payment_time=" + payment_time + ", payment_mode=" + payment_mode + ", check_dd_no="
				+ check_dd_no + ", check_dd_validity=" + check_dd_validity + ", payment_timestamp=" + payment_timestamp
				+ ", new_modified_amount=" + new_modified_amount + ", comment=" + comment + ", modification_user="
				+ modification_user + ", modification_timestamp=" + modification_timestamp + ", modification_type="
				+ modification_type + ", payment_details=" + payment_details + ", supplier_id=" + supplier_id
				+ ", remark=" + remark + ", bank_detail_id=" + bank_detail_id + "]";
	}
	
	
}
