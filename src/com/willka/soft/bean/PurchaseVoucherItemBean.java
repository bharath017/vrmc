package com.willka.soft.bean;

import java.io.Serializable;

public class PurchaseVoucherItemBean implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1343L;
	
	private int pvi_id;
	private int purchase_voucher_id;
	private String item_name;
	private double item_quantity;
	private double item_price;
	private float gst_percent;
	private double tax_amount;
	private double net_amount;
	private double gross_amount;
	
	
	private String timestamp;
	
	
	public int getPvi_id() {
		return pvi_id;
	}
	public void setPvi_id(int pvi_id) {
		this.pvi_id = pvi_id;
	}
	public int getPurchase_voucher_id() {
		return purchase_voucher_id;
	}
	public void setPurchase_voucher_id(int purchase_voucher_id) {
		this.purchase_voucher_id = purchase_voucher_id;
	}
	public String getItem_name() {
		return item_name;
	}
	public void setItem_name(String item_name) {
		this.item_name = item_name;
	}
	public double getItem_quantity() {
		return item_quantity;
	}
	public void setItem_quantity(double item_quantity) {
		this.item_quantity = item_quantity;
	}
	public double getItem_price() {
		return item_price;
	}
	public void setItem_price(double item_price) {
		this.item_price = item_price;
	}
	public float getGst_percent() {
		return gst_percent;
	}
	public void setGst_percent(float gst_percent) {
		this.gst_percent = gst_percent;
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
	public double getGross_amount() {
		return gross_amount;
	}
	public void setGross_amount(double gross_amount) {
		this.gross_amount = gross_amount;
	}
	public String getTimestamp() {
		return timestamp;
	}
	public void setTimestamp(String timestamp) {
		this.timestamp = timestamp;
	}
	
	
	@Override
	public String toString() {
		return "PurchaseVoucherItemBean [pvi_id=" + pvi_id + ", purchase_voucher_id=" + purchase_voucher_id
				+ ", item_name=" + item_name + ", item_quantity=" + item_quantity + ", item_price=" + item_price
				+ ", timestamp=" + timestamp + "]";
	}
	
	

}
