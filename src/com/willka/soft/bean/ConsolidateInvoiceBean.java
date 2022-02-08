package com.willka.soft.bean;

import java.io.Serializable;

public class ConsolidateInvoiceBean implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1242L;
	private int consolidate_invoice_id;
	private int customer_id;
	private double pump_charge;
	private double advance_amount;
	private int plant_id;
	private String generate_date;
	private int cons_id;
	private int start_year;
	private int end_year;
	private String type;
	
	
	public int getConsolidate_invoice_id() {
		return consolidate_invoice_id;
	}
	public void setConsolidate_invoice_id(int consolidate_invoice_id) {
		this.consolidate_invoice_id = consolidate_invoice_id;
	}
	public int getCustomer_id() {
		return customer_id;
	}
	public void setCustomer_id(int customer_id) {
		this.customer_id = customer_id;
	}
	public double getPump_charge() {
		return pump_charge;
	}
	public void setPump_charge(double pump_charge) {
		this.pump_charge = pump_charge;
	}
	public double getAdvance_amount() {
		return advance_amount;
	}
	public void setAdvance_amount(double advance_amount) {
		this.advance_amount = advance_amount;
	}
	public int getPlant_id() {
		return plant_id;
	}
	public void setPlant_id(int plant_id) {
		this.plant_id = plant_id;
	}
	public String getGenerate_date() {
		return generate_date;
	}
	public void setGenerate_date(String generate_date) {
		this.generate_date = generate_date;
	}
	public int getCons_id() {
		return cons_id;
	}
	public void setCons_id(int cons_id) {
		this.cons_id = cons_id;
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
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	
	@Override
	public String toString() {
		return "ConsolidateInvoiceBean [consolidate_invoice_id=" + consolidate_invoice_id + ", customer_id="
				+ customer_id + ", pump_charge=" + pump_charge + ", advance_amount=" + advance_amount + ", plant_id="
				+ plant_id + ", generate_date=" + generate_date + ", cons_id=" + cons_id + ", start_year=" + start_year
				+ ", end_year=" + end_year + ", type=" + type + "]";
	}
}
