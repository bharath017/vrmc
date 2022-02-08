package com.willka.soft.bean;

import java.io.Serializable;

public class FleetOutgoingEditBean implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 14343L;
	
	private int fo_edit_id;
	private String edited_user;
	private String edited_comment;
	private String edited_timestamp;
	
	
	public int getFo_edit_id() {
		return fo_edit_id;
	}
	public void setFo_edit_id(int fo_edit_id) {
		this.fo_edit_id = fo_edit_id;
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
		return "FleetOutgoingEditBean [fo_edit_id=" + fo_edit_id + ", edited_user=" + edited_user + ", edited_comment="
				+ edited_comment + ", edited_timestamp=" + edited_timestamp + "]";
	}
	

}
