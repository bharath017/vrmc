package com.willka.soft.bean;

import java.io.Serializable;

public class FleetOutgoingItemBean implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 32321L;
	
	private int fo_item_id;
	private int fleet_outgoing_id;
	private int fleet_item_id;
	private int quantity;
	private String timestamp;
	
	
	public int getFo_item_id() {
		return fo_item_id;
	}
	public void setFo_item_id(int fo_item_id) {
		this.fo_item_id = fo_item_id;
	}
	public int getFleet_outgoing_id() {
		return fleet_outgoing_id;
	}
	public void setFleet_outgoing_id(int fleet_outgoing_id) {
		this.fleet_outgoing_id = fleet_outgoing_id;
	}
	public int getFleet_item_id() {
		return fleet_item_id;
	}
	public void setFleet_item_id(int fleet_item_id) {
		this.fleet_item_id = fleet_item_id;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public String getTimestamp() {
		return timestamp;
	}
	public void setTimestamp(String timestamp) {
		this.timestamp = timestamp;
	}
	
	
	@Override
	public String toString() {
		return "FleetOutgoingItemBean [fo_item_id=" + fo_item_id + ", fleet_outgoing_id=" + fleet_outgoing_id
				+ ", fleet_item_id=" + fleet_item_id + ", quantity=" + quantity + ", timestamp=" + timestamp + "]";
	}
	
	

}
