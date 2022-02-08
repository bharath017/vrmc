package com.willka.soft.bean;

import java.io.Serializable;

public class FleetIncomingBean implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int fleet_id;
	private String bill_no;
	private String incoming_date;
	private String incoming_time;
	private String purchaser_name;
	private String fleet_type;
	private String fleet_supplier;
	private double total_gross_amount;
	private double total_net_amount;
	private double total_tax_amount;
	private String added_timestamp;
	private int plant_id;
	
	public int getFleet_id() {
		return fleet_id;
	}
	public void setFleet_id(int fleet_id) {
		this.fleet_id = fleet_id;
	}
	public String getBill_no() {
		return bill_no;
	}
	public void setBill_no(String bill_no) {
		this.bill_no = bill_no;
	}
	public String getIncoming_date() {
		return incoming_date;
	}
	public void setIncoming_date(String incoming_date) {
		this.incoming_date = incoming_date;
	}
	public String getIncoming_time() {
		return incoming_time;
	}
	public void setIncoming_time(String incoming_time) {
		this.incoming_time = incoming_time;
	}
	public String getPurchaser_name() {
		return purchaser_name;
	}
	public void setPurchaser_name(String purchaser_name) {
		this.purchaser_name = purchaser_name;
	}
	public String getFleet_type() {
		return fleet_type;
	}
	public void setFleet_type(String fleet_type) {
		this.fleet_type = fleet_type;
	}
	public String getFleet_supplier() {
		return fleet_supplier;
	}
	public void setFleet_supplier(String fleet_supplier) {
		this.fleet_supplier = fleet_supplier;
	}
	public String getAdded_timestamp() {
		return added_timestamp;
	}
	public void setAdded_timestamp(String added_timestamp) {
		this.added_timestamp = added_timestamp;
	}
	public double getTotal_gross_amount() {
		return total_gross_amount;
	}
	public void setTotal_gross_amount(double total_gross_amount) {
		this.total_gross_amount = total_gross_amount;
	}
	public double getTotal_net_amount() {
		return total_net_amount;
	}
	public void setTotal_net_amount(double total_net_amount) {
		this.total_net_amount = total_net_amount;
	}
	public double getTotal_tax_amount() {
		return total_tax_amount;
	}
	public void setTotal_tax_amount(double total_tax_amount) {
		this.total_tax_amount = total_tax_amount;
	}
	public int getPlant_id() {
		return plant_id;
	}
	public void setPlant_id(int plant_id) {
		this.plant_id = plant_id;
	}
	
	
	@Override
	public String toString() {
		return "FleetIncomingBean [fleet_id=" + fleet_id + ", bill_no=" + bill_no + ", incoming_date=" + incoming_date
				+ ", incoming_time=" + incoming_time + ", purchaser_name=" + purchaser_name + ", fleet_type="
				+ fleet_type + ", fleet_supplier=" + fleet_supplier + ", added_timestamp=" + added_timestamp + "]";
	}
	
	
	

}
