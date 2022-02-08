package com.willka.soft.test.bean;

import java.io.Serializable;

public class InventoryModificationBean implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 24241L;
	
	private int inv_mod_id;
	private int inventory_id;
	private double old_net_weight;
	private double new_net_weight;
	private double old_supplier_weight;
	private double new_supplier_weight;
	private String modification_user;
	private String modification_comment;
	private String modification_timestamp;
	private double net_weight;
	
	public int getInv_mod_id() {
		return inv_mod_id;
	}
	public void setInv_mod_id(int inv_mod_id) {
		this.inv_mod_id = inv_mod_id;
	}
	public int getInventory_id() {
		return inventory_id;
	}
	public void setInventory_id(int inventory_id) {
		this.inventory_id = inventory_id;
	}
	public double getOld_net_weight() {
		return old_net_weight;
	}
	public void setOld_net_weight(double old_net_weight) {
		this.old_net_weight = old_net_weight;
	}
	public double getNew_net_weight() {
		return new_net_weight;
	}
	public void setNew_net_weight(double new_net_weight) {
		this.new_net_weight = new_net_weight;
	}
	public double getOld_supplier_weight() {
		return old_supplier_weight;
	}
	public void setOld_supplier_weight(double old_supplier_weight) {
		this.old_supplier_weight = old_supplier_weight;
	}
	public double getNew_supplier_weight() {
		return new_supplier_weight;
	}
	public void setNew_supplier_weight(double new_supplier_weight) {
		this.new_supplier_weight = new_supplier_weight;
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
	public double getNet_weight() {
		return net_weight;
	}
	public void setNet_weight(double net_weight) {
		this.net_weight = net_weight;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	@Override
	public String toString() {
		return "InventoryModificationBean [inv_mod_id=" + inv_mod_id + ", inventory_id=" + inventory_id
				+ ", old_net_weight=" + old_net_weight + ", new_net_weight=" + new_net_weight + ", old_supplier_weight="
				+ old_supplier_weight + ", new_supplier_weight=" + new_supplier_weight + ", modification_user="
				+ modification_user + ", modification_comment=" + modification_comment + ", modification_timestamp="
				+ modification_timestamp + ", net_weight=" + net_weight + "]";
	}
}
