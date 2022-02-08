package com.willka.soft.bean;

import java.io.Serializable;

public class FleetIncomingEditBean implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 43431L;
	
	private int fin_edit_id;
	private double old_amount;
	private double new_amount;
	private String edited_user;
	private String edited_comment;
	private String edited_timestamp;
	
	
	public int getFin_edit_id() {
		return fin_edit_id;
	}
	public void setFin_edit_id(int fin_edit_id) {
		this.fin_edit_id = fin_edit_id;
	}
	public double getOld_amount() {
		return old_amount;
	}
	public void setOld_amount(double old_amount) {
		this.old_amount = old_amount;
	}
	public double getNew_amount() {
		return new_amount;
	}
	public void setNew_amount(double new_amount) {
		this.new_amount = new_amount;
	}
	public String getEdited_user() {
		return edited_user;
	}
	public void setEdited_user(String edited_user) {
		this.edited_user = edited_user;
	}
	public String getEdited_comment() {
		return edited_comment;
	}
	public void setEdited_comment(String edited_comment) {
		this.edited_comment = edited_comment;
	}
	public String getEdited_timestamp() {
		return edited_timestamp;
	}
	public void setEdited_timestamp(String edited_timestamp) {
		this.edited_timestamp = edited_timestamp;
	}
	
	
	@Override
	public String toString() {
		return "FleetIncomingEditBean [fin_edit_id=" + fin_edit_id + ", old_amount=" + old_amount + ", new_amount="
				+ new_amount + ", edited_user=" + edited_user + ", edited_comment=" + edited_comment
				+ ", edited_timestamp=" + edited_timestamp + "]";
	}
	
	
	

}
