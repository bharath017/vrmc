package com.willka.soft.bean;

import java.io.Serializable;

public class BankDetailBean implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 981L;
	private String bank_name;
	private String account_no;
	private String ifsc_code;
	private String branch_name;
	private double amount;
	private int bank_detail_id;
	private int business_id;
	private String group;
	
	
	public String getBank_name() {
		return bank_name;
	}
	public void setBank_name(String bank_name) {
		this.bank_name = bank_name;
	}
	public String getAccount_no() {
		return account_no;
	}
	public void setAccount_no(String account_no) {
		this.account_no = account_no;
	}
	public String getIfsc_code() {
		return ifsc_code;
	}
	public void setIfsc_code(String ifsc_code) {
		this.ifsc_code = ifsc_code;
	}
	public String getBranch_name() {
		return branch_name;
	}
	public void setBranch_name(String branch_name) {
		this.branch_name = branch_name;
	}
	public double getAmount() {
		return amount;
	}
	public void setAmount(double amount) {
		this.amount = amount;
	}
	public int getBank_detail_id() {
		return bank_detail_id;
	}
	public void setBank_detail_id(int bank_detail_id) {
		this.bank_detail_id = bank_detail_id;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	public int getBusiness_id() {
		return business_id;
	}
	public void setBusiness_id(int business_id) {
		this.business_id = business_id;
	}
	public String getGroup() {
		return group;
	}
	public void setGroup(String group) {
		this.group = group;
	}
	@Override
	public String toString() {
		return "BankDetailBean [bank_name=" + bank_name + ", account_no=" + account_no + ", ifsc_code=" + ifsc_code
				+ ", branch_name=" + branch_name + ", amount=" + amount + ", bank_detail_id=" + bank_detail_id
				+ ", business_id=" + business_id + ", group=" + group + "]";
	}
}
