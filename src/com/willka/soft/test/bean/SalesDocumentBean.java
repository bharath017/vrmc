package com.willka.soft.test.bean;

import java.io.Serializable;

public class SalesDocumentBean implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 45351L;
	
	private int id;
	private int invoice_id;
	private int customer_id;
	private int site_id;
	private String invoice_date;
	private String invoice_time;
	private int plant_id;
	private int start_year;
	private int end_year;
	private String vehicle_no;
	private String driver_name;
	private String invoice_status;
	private String timestamp;
	
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getInvoice_id() {
		return invoice_id;
	}
	public void setInvoice_id(int invoice_id) {
		this.invoice_id = invoice_id;
	}
	public int getCustomer_id() {
		return customer_id;
	}
	public void setCustomer_id(int customer_id) {
		this.customer_id = customer_id;
	}
	public int getSite_id() {
		return site_id;
	}
	public void setSite_id(int site_id) {
		this.site_id = site_id;
	}
	public String getInvoice_date() {
		return invoice_date;
	}
	public void setInvoice_date(String invoice_date) {
		this.invoice_date = invoice_date;
	}
	public String getInvoice_time() {
		return invoice_time;
	}
	public void setInvoice_time(String invoice_time) {
		this.invoice_time = invoice_time;
	}
	public int getPlant_id() {
		return plant_id;
	}
	public void setPlant_id(int plant_id) {
		this.plant_id = plant_id;
	}
	public int getStart_year() {
		return start_year;
	}
	public void setStart_year(int start_year) {
		this.start_year = start_year;
	}
	public int getEnd_year() {
		return end_year;
	}
	public void setEnd_year(int end_year) {
		this.end_year = end_year;
	}
	public String getVehicle_no() {
		return vehicle_no;
	}
	public void setVehicle_no(String vehicle_no) {
		this.vehicle_no = vehicle_no;
	}
	public String getDriver_name() {
		return driver_name;
	}
	public void setDriver_name(String driver_name) {
		this.driver_name = driver_name;
	}
	public String getInvoice_status() {
		return invoice_status;
	}
	public void setInvoice_status(String invoice_status) {
		this.invoice_status = invoice_status;
	}
	public String getTimestamp() {
		return timestamp;
	}
	public void setTimestamp(String timestamp) {
		this.timestamp = timestamp;
	}
	@Override
	public String toString() {
		return "SalesDocumentBean [id=" + id + ", invoice_id=" + invoice_id + ", customer_id=" + customer_id
				+ ", site_id=" + site_id + ", invoice_date=" + invoice_date + ", invoice_time=" + invoice_time
				+ ", plant_id=" + plant_id + ", start_year=" + start_year + ", end_year=" + end_year + ", vehicle_no="
				+ vehicle_no + ", driver_name=" + driver_name + ", invoice_status=" + invoice_status + ", timestamp="
				+ timestamp + "]";
	}

}
