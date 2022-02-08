package com.willka.soft.bean;

import java.io.Serializable;

public class InventoryItemModification implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 13535L;
	
	private int invitem_mod_id;
	private int inv_item_id;
	private double old_quantity;
	private double new_quantity;
	private String modification_user;
	private String modification_comment;
	private String modification_timestamp;
	
	
	public int getInvitem_mod_id() {
		return invitem_mod_id;
	}
	public void setInvitem_mod_id(int invitem_mod_id) {
		this.invitem_mod_id = invitem_mod_id;
	}
	public int getInv_item_id() {
		return inv_item_id;
	}
	public void setInv_item_id(int inv_item_id) {
		this.inv_item_id = inv_item_id;
	}
	public double getOld_quantity() {
		return old_quantity;
	}
	public void setOld_quantity(double old_quantity) {
		this.old_quantity = old_quantity;
	}
	public double getNew_quantity() {
		return new_quantity;
	}
	public void setNew_quantity(double new_quantity) {
		this.new_quantity = new_quantity;
	}
	public String getModification_user() {
		return modification_user;
	}
	public void setModification_user(String modification_user) {
		this.modification_user = modification_user;
	}
	public String getModification_comment() {
		return modification_comment;
	}
	public void setModification_comment(String modification_comment) {
		this.modification_comment = modification_comment;
	}
	public String getModification_timestamp() {
		return modification_timestamp;
	}
	public void setModification_timestamp(String modification_timestamp) {
		this.modification_timestamp = modification_timestamp;
	}
	
	
	@Override
	public String toString() {
		return "InventoryItemModification [invitem_mod_id=" + invitem_mod_id + ", inv_item_id=" + inv_item_id
				+ ", old_quantity=" + old_quantity + ", new_quantity=" + new_quantity + ", modification_user="
				+ modification_user + ", modification_comment=" + modification_comment + ", modification_timestamp="
				+ modification_timestamp + "]";
	}
	
	
}
