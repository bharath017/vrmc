package com.willka.soft.bean;

import java.io.Serializable;

public class FleetItemModificationBean implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 18777L;
	
	private int fleet_item_modification_id;
	private int fleet_item_id;
	private double old_stock_quantity;
	private double new_stock_quantity;
	private String modification_timestamp;
	private String modified_user;
	private String modification_comment;
	
	
	public int getFleet_item_modification_id() {
		return fleet_item_modification_id;
	}
	public void setFleet_item_modification_id(int fleet_item_modification_id) {
		this.fleet_item_modification_id = fleet_item_modification_id;
	}
	public int getFleet_item_id() {
		return fleet_item_id;
	}
	public void setFleet_item_id(int fleet_item_id) {
		this.fleet_item_id = fleet_item_id;
	}
	public double getOld_stock_quantity() {
		return old_stock_quantity;
	}
	public void setOld_stock_quantity(double old_stock_quantity) {
		this.old_stock_quantity = old_stock_quantity;
	}
	public double getNew_stock_quantity() {
		return new_stock_quantity;
	}
	public void setNew_stock_quantity(double new_stock_quantity) {
		this.new_stock_quantity = new_stock_quantity;
	}
	public String getModification_timestamp() {
		return modification_timestamp;
	}
	public void setModification_timestamp(String modification_timestamp) {
		this.modification_timestamp = modification_timestamp;
	}
	public String getModified_user() {
		return modified_user;
	}
	public void setModified_user(String modified_user) {
		this.modified_user = modified_user;
	}
	public String getModification_comment() {
		return modification_comment;
	}
	public void setModification_comment(String modification_comment) {
		this.modification_comment = modification_comment;
	}
	
	@Override
	public String toString() {
		return "FleetItemModificationBean [fleet_item_modification_id=" + fleet_item_modification_id
				+ ", fleet_item_id=" + fleet_item_id + ", old_stock_quantity=" + old_stock_quantity
				+ ", new_stock_quantity=" + new_stock_quantity + ", modification_timestamp=" + modification_timestamp
				+ ", modified_user=" + modified_user + ", modification_comment=" + modification_comment + "]";
	}
	
	
}
