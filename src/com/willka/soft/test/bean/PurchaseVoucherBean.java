package com.willka.soft.test.bean;

import java.io.Serializable;

public class PurchaseVoucherBean implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private int purchase_voucher_id;
	private String bill_no;
	private String purhcase_date;
	private double discount_amount;
	private String voucher_status;
	private String timestamp;
	private String rate_include_tax;
	private int supplier_id;
	private double round_off;
	private String gst_type;
	private int plant_id;
	
	public int getPlant_id() {
		return plant_id;
	}
	public void setPlant_id(int plant_id) {
		this.plant_id = plant_id;
	}
	public int getPurchase_voucher_id() {
		return purchase_voucher_id;
	}
	public void setPurchase_voucher_id(int purchase_voucher_id) {
		this.purchase_voucher_id = purchase_voucher_id;
	}
	public String getBill_no() {
		return bill_no;
	}
	public void setBill_no(String bill_no) {
		this.bill_no = bill_no;
	}
	public String getPurhcase_date() {
		return purhcase_date;
	}
	public void setPurhcase_date(String purhcase_date) {
		this.purhcase_date = purhcase_date;
	}
	public double getDiscount_amount() {
		return discount_amount;
	}
	public void setDiscount_amount(double discount_amount) {
		this.discount_amount = discount_amount;
	}
	public String getVoucher_status() {
		return voucher_status;
	}
	public void setVoucher_status(String voucher_status) {
		this.voucher_status = voucher_status;
	}
	public String getTimestamp() {
		return timestamp;
	}
	public void setTimestamp(String timestamp) {
		this.timestamp = timestamp;
	}
	public int getSupplier_id() {
		return supplier_id;
	}
	public void setSupplier_id(int supplier_id) {
		this.supplier_id = supplier_id;
	}
	public String getRate_include_tax() {
		return rate_include_tax;
	}
	public void setRate_include_tax(String rate_include_tax) {
		this.rate_include_tax = rate_include_tax;
	}
	public double getRound_off() {
		return round_off;
	}
	public void setRound_off(double round_off) {
		this.round_off = round_off;
	}
	@Override
	public String toString() {
		return "PurchaseVoucherBean [purchase_voucher_id=" + purchase_voucher_id + ", bill_no=" + bill_no
				+ ", purhcase_date=" + purhcase_date + ", discount_amount=" + discount_amount + ", voucher_status="
				+ voucher_status + ", timestamp=" + timestamp + ", rate_include_tax=" + rate_include_tax
				+ ", supplier_id=" + supplier_id + ", round_off=" + round_off + ", gst_type=" + gst_type + ", plant_id="
				+ plant_id + "]";
	}
	public String getGst_type() {
		return gst_type;
	}
	public void setGst_type(String gst_type) {
		this.gst_type = gst_type;
	}
}
