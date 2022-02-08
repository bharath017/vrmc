package com.willka.soft.bean;

public class PettyCashModificationBean {

	private long id;
	private long cash_id;
	private String date;
	private double amount;
	private double new_amount;
	private String modified_by;
	private String modification_timestamp;
	private int received_by;
	private int plant_id;
	private String modification_type;
	
	
	
	
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public long getCash_id() {
		return cash_id;
	}
	public void setCash_id(long cash_id) {
		this.cash_id = cash_id;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public double getAmount() {
		return amount;
	}
	public void setAmount(double amount) {
		this.amount = amount;
	}
	public double getNew_amount() {
		return new_amount;
	}
	public void setNew_amount(double new_amount) {
		this.new_amount = new_amount;
	}
	public String getModified_by() {
		return modified_by;
	}
	public void setModified_by(String modified_by) {
		this.modified_by = modified_by;
	}
	public String getModification_timestamp() {
		return modification_timestamp;
	}
	public void setModification_timestamp(String modification_timestamp) {
		this.modification_timestamp = modification_timestamp;
	}
	public int getReceived_by() {
		return received_by;
	}
	public void setReceived_by(int received_by) {
		this.received_by = received_by;
	}
	public int getPlant_id() {
		return plant_id;
	}
	public void setPlant_id(int plant_id) {
		this.plant_id = plant_id;
	}
	public String getModification_type() {
		return modification_type;
	}
	public void setModification_type(String modification_type) {
		this.modification_type = modification_type;
	}
	@Override
	public String toString() {
		return "PettyCashModificationBean [id=" + id + ", cash_id=" + cash_id + ", date=" + date + ", amount=" + amount
				+ ", new_amount=" + new_amount + ", modified_by=" + modified_by + ", modification_timestamp="
				+ modification_timestamp + ", received_by=" + received_by + ", plant_id=" + plant_id
				+ ", modification_type=" + modification_type + "]";
	}
	
	
	
	
	
}
