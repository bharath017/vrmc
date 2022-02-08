package com.willka.soft.bean;

import java.io.Serializable;

public class InvoiceBean implements Serializable {

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
	private double km_reading;
	private String project_block;
	private double tcs_price;
	private double empty_weight;
	private double loaded_weight;
	private double net_weight;
	private int ticket_id;
	
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
	public double getKm_reading() {
		return km_reading;
	}
	public void setKm_reading(double km_reading) {
		this.km_reading = km_reading;
	}
	public String getProject_block() {
		return project_block;
	}
	public void setProject_block(String project_block) {
		this.project_block = project_block;
	}
	public double getTcs_price() {
		return tcs_price;
	}
	public void setTcs_price(double tcs_price) {
		this.tcs_price = tcs_price;
	}
	public double getEmpty_weight() {
		return empty_weight;
	}
	public void setEmpty_weight(double empty_weight) {
		this.empty_weight = empty_weight;
	}
	public double getLoaded_weight() {
		return loaded_weight;
	}
	public void setLoaded_weight(double loaded_weight) {
		this.loaded_weight = loaded_weight;
	}
	public double getNet_weight() {
		return net_weight;
	}
	public void setNet_weight(double net_weight) {
		this.net_weight = net_weight;
	}
	public int getTicket_id() {
		return ticket_id;
	}
	public void setTicket_id(int ticket_id) {
		this.ticket_id = ticket_id;
	}
	@Override
	public String toString() {
		return "InvoiceBean [id=" + id + ", plant_id=" + plant_id + ", invoice_id=" + invoice_id + ", customer_id="
				+ customer_id + ", site_id=" + site_id + ", poi_id=" + poi_id + ", invoice_date=" + invoice_date
				+ ", invoice_time=" + invoice_time + ", quantity=" + quantity + ", rate=" + rate + ", gross_amount="
				+ gross_amount + ", tax_amount=" + tax_amount + ", net_amount=" + net_amount + ", vehicle_no="
				+ vehicle_no + ", pump=" + pump + ", driver_name=" + driver_name + ", start_year=" + start_year
				+ ", end_year=" + end_year + ", invoice_status=" + invoice_status + ", timestamp=" + timestamp
				+ ", km_reading=" + km_reading + ", project_block=" + project_block + ", tcs_price=" + tcs_price
				+ ", empty_weight=" + empty_weight + ", loaded_weight=" + loaded_weight + ", net_weight=" + net_weight
				+ ", ticket_id=" + ticket_id + "]";
	}
	
	
}
