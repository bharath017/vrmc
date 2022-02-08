package com.willka.soft.bean;

import java.io.Serializable;

public class DieselModificationBean implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1232L;
	private int id;
	private int diesel_id;
	private double old_quantity;
	private double new_quantity;
	private String comment;
	private String modified_by;
	private String modification_type;
	
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getDiesel_id() {
		return diesel_id;
	}
	public void setDiesel_id(int diesel_id) {
		this.diesel_id = diesel_id;
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
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	public String getModified_by() {
		return modified_by;
	}
	public void setModified_by(String modified_by) {
		this.modified_by = modified_by;
	}
	public String getModification_type() {
		return modification_type;
	}
	public void setModification_type(String modification_type) {
		this.modification_type = modification_type;
	}
	
	
	@Override
	public String toString() {
		return "DieselModificationBean [id=" + id + ", diesel_id=" + diesel_id + ", old_quantity=" + old_quantity
				+ ", new_quantity=" + new_quantity + ", comment=" + comment + ", modified_by=" + modified_by
				+ ", modification_type=" + modification_type + "]";
	}

	
}
