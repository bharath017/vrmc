package com.willka.soft.bean;

import java.io.Serializable;

public class InventoryOutgoingBean implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1242L;
	
	private int invout_id;
	private int product_id;
	private String date;
	private String comment;
	private String added_by;
	private String timestamp;
	private double quantity;
	private int plant_id;
	private double production_cost;
	private String type;
	
	public int getInvout_id() {
		return invout_id;
	}
	public void setInvout_id(int invout_id) {
		this.invout_id = invout_id;
	}
	public int getProduct_id() {
		return product_id;
	}
	public void setProduct_id(int product_id) {
		this.product_id = product_id;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	public String getAdded_by() {
		return added_by;
	}
	public void setAdded_by(String added_by) {
		this.added_by = added_by;
	}
	public String getTimestamp() {
		return timestamp;
	}
	public void setTimestamp(String timestamp) {
		this.timestamp = timestamp;
	}
	public int getPlant_id() {
		return plant_id;
	}
	public void setPlant_id(int plant_id) {
		this.plant_id = plant_id;
	}
	public double getQuantity() {
		return quantity;
	}
	public void setQuantity(double quantity) {
		this.quantity = quantity;
	}
	public double getProduction_cost() {
		return production_cost;
	}
	public void setProduction_cost(double production_cost) {
		this.production_cost = production_cost;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	@Override
	public String toString() {
		return "InventoryOutgoingBean [invout_id=" + invout_id + ", product_id=" + product_id + ", date=" + date
				+ ", comment=" + comment + ", added_by=" + added_by + ", timestamp=" + timestamp + ", quantity="
				+ quantity + ", plant_id=" + plant_id + ", production_cost=" + production_cost + ", type=" + type + "]";
	}
}
