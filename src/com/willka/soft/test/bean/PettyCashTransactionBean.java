package com.willka.soft.test.bean;

import java.io.Serializable;

public class PettyCashTransactionBean implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 64541L;
	private long transaction_id;
	private double amount;
	private String date;
	private String description;
	private int plant_id;
	private String purpose;
	
	
	public long getTransaction_id() {
		return transaction_id;
	}
	public void setTransaction_id(long transaction_id) {
		this.transaction_id = transaction_id;
	}
	public double getAmount() {
		return amount;
	}
	public void setAmount(double amount) {
		this.amount = amount;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public int getPlant_id() {
		return plant_id;
	}
	public void setPlant_id(int plant_id) {
		this.plant_id = plant_id;
	}
	public String getPurpose() {
		return purpose;
	}
	public void setPurpose(String purpose) {
		this.purpose = purpose;
	}
	@Override
	public String toString() {
		return "PettyCashTransactionBean [transaction_id=" + transaction_id + ", amount=" + amount + ", date=" + date
				+ ", description=" + description + ", plant_id=" + plant_id + ", purpose=" + purpose + "]";
	}
}
