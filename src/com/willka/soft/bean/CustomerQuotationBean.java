package com.willka.soft.bean;

import java.io.Serializable;

public class CustomerQuotationBean implements Serializable{

	private static final long serialVersionUID = 15456L;
	private int quotation_id;
	private String customer_name;
	private String quotation_date;
	private double pump_charge;
	private double pump_quantity;
	private String site_address;
	private String customer_phone;
	private String comment;
	private int mp_id;
	private String customer_email;
	private String host;
	private String status;
	private String customer_gstin;
	
	
	public int getQuotation_id() {
		return quotation_id;
	}
	public void setQuotation_id(int quotation_id) {
		this.quotation_id = quotation_id;
	}
	public String getCustomer_name() {
		return customer_name;
	}
	public void setCustomer_name(String customer_name) {
		this.customer_name = customer_name;
	}
	public String getQuotation_date() {
		return quotation_date;
	}
	public void setQuotation_date(String quotation_date) {
		this.quotation_date = quotation_date;
	}
	public double getPump_charge() {
		return pump_charge;
	}
	public void setPump_charge(double pump_charge) {
		this.pump_charge = pump_charge;
	}
	public double getPump_quantity() {
		return pump_quantity;
	}
	public void setPump_quantity(double pump_quantity) {
		this.pump_quantity = pump_quantity;
	}
	public String getSite_address() {
		return site_address;
	}
	public void setSite_address(String site_address) {
		this.site_address = site_address;
	}
	public String getCustomer_phone() {
		return customer_phone;
	}
	public void setCustomer_phone(String customer_phone) {
		this.customer_phone = customer_phone;
	}
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	public int getMp_id() {
		return mp_id;
	}
	public void setMp_id(int mp_id) {
		this.mp_id = mp_id;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	public String getCustomer_email() {
		return customer_email;
	}
	public void setCustomer_email(String customer_email) {
		this.customer_email = customer_email;
	}
	public String getHost() {
		return host;
	}
	public void setHost(String host) {
		this.host = host;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getCustomer_gstin() {
		return customer_gstin;
	}
	public void setCustomer_gstin(String customer_gstin) {
		this.customer_gstin = customer_gstin;
	}
	@Override
	public String toString() {
		return "CustomerQuotationBean [quotation_id=" + quotation_id + ", customer_name=" + customer_name
				+ ", quotation_date=" + quotation_date + ", pump_charge=" + pump_charge + ", pump_quantity="
				+ pump_quantity + ", site_address=" + site_address + ", customer_phone=" + customer_phone + ", comment="
				+ comment + ", mp_id=" + mp_id + ", customer_email=" + customer_email + ", host=" + host + ", status="
				+ status + "]";
	}
	
}
