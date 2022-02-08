package com.willka.soft.test.bean;

import java.io.Serializable;

public class PettyCashBean implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 123232L;
	private long cash_id;
	private int plant_id;
	private String date;
	private int added_by;
	private int received_by;
	private int approved_by;
	private double amount;
	private String purpose;
	private int bank_id;
	private int category_id;
	private String receiver;
	
	
	public long getCash_id() {
		return cash_id;
	}
	public void setCash_id(long cash_id) {
		this.cash_id = cash_id;
	}
	public int getPlant_id() {
		return plant_id;
	}
	public void setPlant_id(int plant_id) {
		this.plant_id = plant_id;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public int getAdded_by() {
		return added_by;
	}
	public void setAdded_by(int added_by) {
		this.added_by = added_by;
	}
	public int getReceived_by() {
		return received_by;
	}
	public void setReceived_by(int received_by) {
		this.received_by = received_by;
	}
	public int getApproved_by() {
		return approved_by;
	}
	public void setApproved_by(int approved_by) {
		this.approved_by = approved_by;
	}
	public double getAmount() {
		return amount;
	}
	public void setAmount(double amount) {
		this.amount = amount;
	}
	public String getPurpose() {
		return purpose;
	}
	public void setPurpose(String purpose) {
		this.purpose = purpose;
	}
	public int getCategory_id() {
		return category_id;
	}
	public void setCategory_id(int category_id) {
		this.category_id = category_id;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
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
	@Override
	public String toString() {
		return "PettyCashBean [cash_id=" + cash_id + ", plant_id=" + plant_id + ", date=" + date + ", added_by="
				+ added_by + ", received_by=" + received_by + ", approved_by=" + approved_by + ", amount=" + amount
				+ ", purpose=" + purpose + ", bank_id=" + bank_id + ", category_id=" + category_id + ", receiver="
				+ receiver + "]";
	}
}
