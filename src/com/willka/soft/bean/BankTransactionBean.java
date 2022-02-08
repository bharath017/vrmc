package com.willka.soft.bean;

import java.io.Serializable;

public class BankTransactionBean implements Serializable
{

	private int transaction_id;
	private double transaction_amount;
	private String transaction_date;
	private String transaction_time;
	private String transaction_type;
	private int added_by;
	private String timestamp;
	private String remarks;
	private int bank_id;
	private int  business_id;
	private String receiver;
	
	
	
	public int getTransaction_id() {
		return transaction_id;
	}
	public double getTransaction_amount() {
		return transaction_amount;
	}
	public String getTransaction_date() {
		return transaction_date;
	}
	public String getTransaction_time() {
		return transaction_time;
	}
	public String getTransaction_type() {
		return transaction_type;
	}
	public int getAdded_by() {
		return added_by;
	}
	public String getTimestamp() {
		return timestamp;
	}
	public String getRemarks() {
		return remarks;
	}
	public void setTransaction_id(int transaction_id) {
		this.transaction_id = transaction_id;
	}
	public void setTransaction_amount(double transaction_amount) {
		this.transaction_amount = transaction_amount;
	}
	public void setTransaction_date(String transaction_date) {
		this.transaction_date = transaction_date;
	}
	public void setTransaction_time(String transaction_time) {
		this.transaction_time = transaction_time;
	}
	public void setTransaction_type(String transaction_type) {
		this.transaction_type = transaction_type;
	}
	public void setAdded_by(int added_by) {
		this.added_by = added_by;
	}
	public void setTimestamp(String timestamp) {
		this.timestamp = timestamp;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	public int getBank_id() {
		return bank_id;
	}
	public void setBank_id(int bank_id) {
		this.bank_id = bank_id;
	}
	public String getReceiver() {
		return receiver;
	}
	public void setReceiver(String receiver) {
		this.receiver = receiver;
	}
	public int getBusiness_id() {
		return business_id;
	}
	public void setBusiness_id(int business_id) {
		this.business_id = business_id;
	}
	@Override
	public String toString() {
		return "BankTransactionBean [transaction_id=" + transaction_id + ", transaction_amount=" + transaction_amount
				+ ", transaction_date=" + transaction_date + ", transaction_time=" + transaction_time
				+ ", transaction_type=" + transaction_type + ", added_by=" + added_by + ", timestamp=" + timestamp
				+ ", remarks=" + remarks + ", bank_id=" + bank_id + ", business_id=" + business_id + ", receiver="
				+ receiver + "]";
	}
}
