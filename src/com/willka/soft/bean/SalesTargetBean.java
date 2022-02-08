package com.willka.soft.bean;

import java.io.Serializable;

public class SalesTargetBean implements Serializable {

	
private static final long serialVersionUID = 15353L;
	
	private int target_id;
	private int mp_id;
	private String date;
	private Double Quantity;
	public int getTarget_id() {
		return target_id;
	}
	public void setTarget_id(int target_id) {
		this.target_id = target_id;
	}
	public int getMp_id() {
		return mp_id;
	}
	public void setMp_id(int mp_id) {
		this.mp_id = mp_id;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public Double getQuantity() {
		return Quantity;
	}
	public void setQuantity(Double quantity) {
		Quantity = quantity;
	}
	@Override
	public String toString() {
		return "SalesTargetBean [target_id=" + target_id + ", mp_id=" + mp_id + ", date=" + date + ", Quantity="
				+ Quantity + "]";
	}
	
}
