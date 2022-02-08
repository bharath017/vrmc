package com.willka.soft.bean;

import java.io.Serializable;

public class FleetIncomingItemBean implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1434L;
	
	private int fi_item_id;
	private int fleet_id;
	private int fleet_item_id;
	private double quantity;
	private double rate;
	private double gst_percent;
	private double gross_amount;
	private double net_amount;
	private double tax_amount;
	
	
	public int getFi_item_id() {
		return fi_item_id;
	}
	public void setFi_item_id(int fi_item_id) {
		this.fi_item_id = fi_item_id;
	}
	public int getFleet_id() {
		return fleet_id;
	}
	public void setFleet_id(int fleet_id) {
		this.fleet_id = fleet_id;
	}
	public int getFleet_item_id() {
		return fleet_item_id;
	}
	public void setFleet_item_id(int fleet_item_id) {
		this.fleet_item_id = fleet_item_id;
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
	public double getGst_percent() {
		return gst_percent;
	}
	public void setGst_percent(double gst_percent) {
		this.gst_percent = gst_percent;
	}
	public double getGross_amount() {
		return gross_amount;
	}
	public void setGross_amount(double gross_amount) {
		this.gross_amount = gross_amount;
	}
	public double getNet_amount() {
		return net_amount;
	}
	public void setNet_amount(double net_amount) {
		this.net_amount = net_amount;
	}
	public double getTax_amount() {
		return tax_amount;
	}
	public void setTax_amount(double tax_amount) {
		this.tax_amount = tax_amount;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
	@Override
	public String toString() {
		return "FleetIncomingItemBean [fi_item_id=" + fi_item_id + ", fleet_id=" + fleet_id + ", fleet_item_id="
				+ fleet_item_id + ", quantity=" + quantity + ", rate=" + rate + ", gst_percent=" + gst_percent
				+ ", gross_amount=" + gross_amount + ", net_amount=" + net_amount + ", tax_amount=" + tax_amount + "]";
	}
	

}
