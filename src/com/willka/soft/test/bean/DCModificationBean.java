package com.willka.soft.test.bean;

import java.io.Serializable;

public class DCModificationBean implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 431L;
	
	private int invoice_modification_id;
	private int invoice_id;
	private String modification_type;
	private String comment;
	private String modification_user;
	private String modification_timestamp;
	
	
	public int getInvoice_modification_id() {
		return invoice_modification_id;
	}
	public void setInvoice_modification_id(int invoice_modification_id) {
		this.invoice_modification_id = invoice_modification_id;
	}
	public int getInvoice_id() {
		return invoice_id;
	}
	public void setInvoice_id(int invoice_id) {
		this.invoice_id = invoice_id;
	}
	public String getModification_type() {
		return modification_type;
	}
	public void setModification_type(String modification_type) {
		this.modification_type = modification_type;
	}
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	public String getModification_user() {
		return modification_user;
	}
	public void setModification_user(String modification_user) {
		this.modification_user = modification_user;
	}
	public String getModification_timestamp() {
		return modification_timestamp;
	}
	public void setModification_timestamp(String modification_timestamp) {
		this.modification_timestamp = modification_timestamp;
	}
	
	@Override
	public String toString() {
		return "InvoiceModificationBean [invoice_modification_id=" + invoice_modification_id + ", invoice_id="
				+ invoice_id + ", modification_type=" + modification_type + ", comment=" + comment
				+ ", modification_user=" + modification_user + ", modification_timestamp=" + modification_timestamp
				+ "]";
	}
	

}
