package com.willka.soft.bean;

import java.io.Serializable;

public class DCBean implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1424L;
	
	private int id;
	private int plant_id;
	private int invoice_id;
	private int customer_id;
	private int site_id;
	private int poi_id;
	private String invoice_date;
	private String invoice_time;
	private double quantity;
	private double rate;
	private double gross_amount;
	private double tax_amount;
	private double net_amount;
	private String vehicle_no;
	private String pump;
	private String driver_name;
	private int start_year;
	private int end_year;
	private String invoice_status;
	private String timestamp;
	private String km_reading;
	private String project_block;
	private double loaded_quantity;
	private int loaded_product_id;
	private String km_reading2;
	
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getPlant_id() {
		return plant_id;
	}
	public void setPlant_id(int plant_id) {
		this.plant_id = plant_id;
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
	public int getPoi_id() {
		return poi_id;
	}
	public void setPoi_id(int poi_id) {
		this.poi_id = poi_id;
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
	public double getQuantity() {
		return quantity;
	}
	public void setQuantity(double quantity) {
		this.quantity = quantity;
	}
	public double getRate() {
		return rate;
	}
	public void setRate(double rate) {
		this.rate = rate;
	}
	public double getGross_amount() {
		return gross_amount;
	}
	public void setGross_amount(double gross_amount) {
		this.gross_amount = gross_amount;
	}
	public double getTax_amount() {
		return tax_amount;
	}
	public void setTax_amount(double tax_amount) {
		this.tax_amount = tax_amount;
	}
	public double getNet_amount() {
		return net_amount;
	}
	public void setNet_amount(double net_amount) {
		this.net_amount = net_amount;
	}
	public String getVehicle_no() {
		return vehicle_no;
	}
	public void setVehicle_no(String vehicle_no) {
		this.vehicle_no = vehicle_no;
	}
	public String getPump() {
		return pump;
	}
	public void setPump(String pump) {
		this.pump = pump;
	}
	public String getDriver_name() {
		return driver_name;
	}
	public void setDriver_name(String driver_name) {
		this.driver_name = driver_name;
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
	public String getKm_reading() {
		return km_reading;
	}
	public void setKm_reading(String km_reading) {
		this.km_reading = km_reading;
	}
	public String getProject_block() {
		return project_block;
	}
	public void setProject_block(String project_block) {
		this.project_block = project_block;
	}
	public double getLoaded_quantity() {
		return loaded_quantity;
	}
	public void setLoaded_quantity(double loaded_quantity) {
		this.loaded_quantity = loaded_quantity;
	}

	
	@Override
	public String toString() {
		return "DCBean [id=" + id + ", plant_id=" + plant_id + ", invoice_id=" + invoice_id + ", customer_id="
				+ customer_id + ", site_id=" + site_id + ", poi_id=" + poi_id + ", invoice_date=" + invoice_date
				+ ", invoice_time=" + invoice_time + ", quantity=" + quantity + ", rate=" + rate + ", gross_amount="
				+ gross_amount + ", tax_amount=" + tax_amount + ", net_amount=" + net_amount + ", vehicle_no="
				+ vehicle_no + ", pump=" + pump + ", driver_name=" + driver_name + ", start_year=" + start_year
				+ ", end_year=" + end_year + ", invoice_status=" + invoice_status + ", timestamp=" + timestamp
				+ ", km_reading=" + km_reading + ", project_block=" + project_block + ", loaded_quantity="
				+ loaded_quantity + ", loaded_product_id=" + loaded_product_id + ", km_reading2=" + km_reading2 + "]";
	}
	public int getLoaded_product_id() {
		return loaded_product_id;
	}
	public void setLoaded_product_id(int loaded_product_id) {
		this.loaded_product_id = loaded_product_id;
	}
	public String getKm_reading2() {
		return km_reading2;
	}
	public void setKm_reading2(String km_reading2) {
		this.km_reading2 = km_reading2;
	}
	
}
