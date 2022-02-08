package com.willka.soft.bean;

import java.io.Serializable;

public class InventoryItemBean implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 16464L;
	private int inv_item_id;
	private String inventory_name;
	private String item_unit;
	private double item_quantity;
	private String item_status;
	
	
	public int getInv_item_id() {
		return inv_item_id;
	}
	public void setInv_item_id(int inv_item_id) {
		this.inv_item_id = inv_item_id;
	}
	public String getInventory_name() {
		return inventory_name;
	}
	public void setInventory_name(String inventory_name) {
		this.inventory_name = inventory_name;
	}
	public String getItem_unit() {
		return item_unit;
	}
	public void setItem_unit(String item_unit) {
		this.item_unit = item_unit;
	}
	public double getItem_quantity() {
		return item_quantity;
	}
	public void setItem_quantity(double item_quantity) {
		this.item_quantity = item_quantity;
	}
	public String getItem_status() {
		return item_status;
	}
	public void setItem_status(String item_status) {
		this.item_status = item_status;
	}
	
	
	@Override
	public String toString() {
		return "InventoryItemBean [inv_item_id=" + inv_item_id + ", inventory_name=" + inventory_name + ", item_unit="
				+ item_unit + ", item_quantity=" + item_quantity + ", item_status=" + item_status + "]";
	}
	
}
