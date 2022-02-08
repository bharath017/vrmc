package com.willka.soft.bean;

import java.io.Serializable;

public class TransportChargeBean implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 43431L;
	
	private int id;
	private int invoice_id;
	private String vehicle_no;
	private double opening_km;
	private double closing_km;
	private double price;
	private int start_year;
	private int end_year;
	private String invoice_date;
	private String invoice_time;
	private String invoice_status;
	private String timestamp;
	private int plant_id;
	private String tax_type;
	private double tax_percent;
	private double gross_amount;
	private double tax_amount;
	private double net_amount;
	private double start_time;
	private double end_time;
	private String price_cat;
	private double diesel_quantity;
	private double diesel_price;
	
	
	
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
	public String getVehicle_no() {
		return vehicle_no;
	}
	public void setVehicle_no(String vehicle_no) {
		this.vehicle_no = vehicle_no;
	}
	public double getOpening_km() {
		return opening_km;
	}
	public void setOpening_km(double opening_km) {
		this.opening_km = opening_km;
	}
	public double getClosing_km() {
		return closing_km;
	}
	public void setClosing_km(double closing_km) {
		this.closing_km = closing_km;
	}
	public double getPrice() {
		return price;
	}
	public void setPrice(double price) {
		this.price = price;
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
	public int getPlant_id() {
		return plant_id;
	}
	public void setPlant_id(int plant_id) {
		this.plant_id = plant_id;
	}
	public String getTax_type() {
		return tax_type;
	}
	public void setTax_type(String tax_type) {
		this.tax_type = tax_type;
	}
	public double getTax_percent() {
		return tax_percent;
	}
	public void setTax_percent(double tax_percent) {
		this.tax_percent = tax_percent;
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
	public double getStart_time() {
		return start_time;
	}
	public void setStart_time(double start_time) {
		this.start_time = start_time;
	}
	public double getEnd_time() {
		return end_time;
	}
	public void setEnd_time(double end_time) {
		this.end_time = end_time;
	}
	public String getPrice_cat() {
		return price_cat;
	}
	public void setPrice_cat(String price_cat) {
		this.price_cat = price_cat;
	}
	public double getDiesel_quantity() {
		return diesel_quantity;
	}
	public void setDiesel_quantity(double diesel_quantity) {
		this.diesel_quantity = diesel_quantity;
	}
	public double getDiesel_price() {
		return diesel_price;
	}
	public void setDiesel_price(double diesel_price) {
		this.diesel_price = diesel_price;
	}
	
	
	@Override
	public String toString() {
		return "TransportChargeBean [id=" + id + ", invoice_id=" + invoice_id + ", vehicle_no=" + vehicle_no
				+ ", opening_km=" + opening_km + ", closing_km=" + closing_km + ", price=" + price + ", start_year="
				+ start_year + ", end_year=" + end_year + ", invoice_date=" + invoice_date + ", invoice_time="
				+ invoice_time + ", invoice_status=" + invoice_status + ", timestamp=" + timestamp + ", plant_id="
				+ plant_id + ", tax_type=" + tax_type + ", tax_percent=" + tax_percent + "]";
	}
	
}
