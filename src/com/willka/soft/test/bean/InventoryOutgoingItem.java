package com.willka.soft.test.bean;

import java.io.Serializable;

public class InventoryOutgoingItem implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1398473L;
	
	private int invout_item_id;
	private int inv_item_id;
	private double quantity;
	private int invout_id;
	
	public int getInvout_item_id() {
		return invout_item_id;
	}
	public void setInvout_item_id(int invout_item_id) {
		this.invout_item_id = invout_item_id;
	}
	public int getInv_item_id() {
		return inv_item_id;
	}
	public void setInv_item_id(int inv_item_id) {
		this.inv_item_id = inv_item_id;
	}
	public double getQuantity() {
		return quantity;
	}
	public void setQuantity(double quantity) {
		this.quantity = quantity;
	}
	public int getInvout_id() {
		return invout_id;
	}
	public void setInvout_id(int invout_id) {
		this.invout_id = invout_id;
	}
	
	@Override
	public String toString() {
		return "InventoryOutgoingItem [invout_item_id=" + invout_item_id + ", inv_item_id=" + inv_item_id
				+ ", quantity=" + quantity + ", invout_id=" + invout_id + "]";
	}
}
