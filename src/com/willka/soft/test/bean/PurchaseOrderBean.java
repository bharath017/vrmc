package com.willka.soft.test.bean;

import java.io.Serializable;

public class PurchaseOrderBean implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 14343L;
	private int order_id;
	private String po_date;
	private String po_valid_till;
	private String tax_group;
	private String rate_include_tax;
	private int product_id;
	private int customer_id;
	private String credit_date;
	private String po_number;
	private int marketing_person_id;
	private int plant_id;
	private int address_id;
	private float gst_percent;
	private String order_type;
	private String bill_photo;
	private int credit_days;
	private double credit_limit;
	private int gst_id;
	
	
	
	
	
	public String getPo_number() {
		return po_number;
	}
	public void setPo_number(String po_number) {
		this.po_number = po_number;
	}
	public int getAddress_id() {
		return address_id;
	}
	public void setAddress_id(int address_id) {
		this.address_id = address_id;
	}
	public int getOrder_id() {
		return order_id;
	}
	public void setOrder_id(int order_id) {
		this.order_id = order_id;
	}
	public String getPo_date() {
		return po_date;
	}
	public void setPo_date(String po_date) {
		this.po_date = po_date;
	}
	public String getPo_valid_till() {
		return po_valid_till;
	}
	public void setPo_valid_till(String po_valid_till) {
		this.po_valid_till = po_valid_till;
	}
	public String getTax_group() {
		return tax_group;
	}
	public void setTax_group(String tax_group) {
		this.tax_group = tax_group;
	}
	public String getRate_include_tax() {
		return rate_include_tax;
	}
	public void setRate_include_tax(String rate_include_tax) {
		this.rate_include_tax = rate_include_tax;
	}
	public int getProduct_id() {
		return product_id;
	}
	public void setProduct_id(int product_id) {
		this.product_id = product_id;
	}
	public int getCustomer_id() {
		return customer_id;
	}
	public void setCustomer_id(int customer_id) {
		this.customer_id = customer_id;
	}
	public String getCredit_date() {
		return credit_date;
	}
	public void setCredit_date(String credit_date) {
		this.credit_date = credit_date;
	}
	
	public int getMarketing_person_id() {
		return marketing_person_id;
	}
	public void setMarketing_person_id(int marketing_person_id) {
		this.marketing_person_id = marketing_person_id;
	}
	public int getPlant_id() {
		return plant_id;
	}
	public void setPlant_id(int plant_id) {
		this.plant_id = plant_id;
	}
	public float getGst_percent() {
		return gst_percent;
	}
	public void setGst_percent(float gst_percent) {
		this.gst_percent = gst_percent;
	}
	public String getOrder_type() {
		return order_type;
	}
	public void setOrder_type(String order_type) {
		this.order_type = order_type;
	}
	public String getBill_photo() {
		return bill_photo;
	}
	public void setBill_photo(String bill_photo) {
		this.bill_photo = bill_photo;
	}
	public int getCredit_days() {
		return credit_days;
	}
	public void setCredit_days(int credit_days) {
		this.credit_days = credit_days;
	}
	public double getCredit_limit() {
		return credit_limit;
	}
	public void setCredit_limit(double credit_limit) {
		this.credit_limit = credit_limit;
	}
	public int getGst_id() {
		return gst_id;
	}
	public void setGst_id(int gst_id) {
		this.gst_id = gst_id;
	}
	@Override
	public String toString() {
		return "PurchaseOrderBean [order_id=" + order_id + ", po_date=" + po_date + ", po_valid_till=" + po_valid_till
				+ ", tax_group=" + tax_group + ", rate_include_tax=" + rate_include_tax + ", product_id=" + product_id
				+ ", customer_id=" + customer_id + ", credit_date=" + credit_date + ", po_number=" + po_number
				+ ", marketing_person_id=" + marketing_person_id + ", plant_id=" + plant_id + ", address_id="
				+ address_id + ", gst_percent=" + gst_percent + ", order_type=" + order_type + ", bill_photo="
				+ bill_photo + ", credit_days=" + credit_days + ", credit_limit=" + credit_limit + ", gst_id=" + gst_id
				+ "]";
	}
	
	
}
