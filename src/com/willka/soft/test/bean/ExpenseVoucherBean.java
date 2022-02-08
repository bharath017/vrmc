package com.willka.soft.test.bean;

import java.io.Serializable;

public class ExpenseVoucherBean implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 3531L;
	
	private int expense_voucher_id;
	private String bill_no;
	private String bill_date;
	private double tds_amount;
	private int plant_id;
	private String bill_photo;
	private String remark;
	private int supplier_id;
	private String category_type;
	private String gst_category;
	private boolean rate_include_tax;
	
	
	
	public int getExpense_voucher_id() {
		return expense_voucher_id;
	}
	public void setExpense_voucher_id(int expense_voucher_id) {
		this.expense_voucher_id = expense_voucher_id;
	}
	public String getBill_no() {
		return bill_no;
	}
	public void setBill_no(String bill_no) {
		this.bill_no = bill_no;
	}
	public String getBill_date() {
		return bill_date;
	}
	public void setBill_date(String bill_date) {
		this.bill_date = bill_date;
	}
	public double getTds_amount() {
		return tds_amount;
	}
	public void setTds_amount(double tds_amount) {
		this.tds_amount = tds_amount;
	}
	public int getPlant_id() {
		return plant_id;
	}
	public void setPlant_id(int plant_id) {
		this.plant_id = plant_id;
	}
	public String getBill_photo() {
		return bill_photo;
	}
	public void setBill_photo(String bill_photo) {
		this.bill_photo = bill_photo;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public int getSupplier_id() {
		return supplier_id;
	}
	public void setSupplier_id(int supplier_id) {
		this.supplier_id = supplier_id;
	}
	public String getCategory_type() {
		return category_type;
	}
	public void setCategory_type(String category_type) {
		this.category_type = category_type;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	public String getGst_category() {
		return gst_category;
	}
	public void setGst_category(String gst_category) {
		this.gst_category = gst_category;
	}
	public boolean isRate_include_tax() {
		return rate_include_tax;
	}
	public void setRate_include_tax(boolean rate_include_tax) {
		this.rate_include_tax = rate_include_tax;
	}
	@Override
	public String toString() {
		return "ExpenseVoucherBean [expense_voucher_id=" + expense_voucher_id + ", bill_no=" + bill_no + ", bill_date="
				+ bill_date + ", tds_amount=" + tds_amount + ", plant_id=" + plant_id + ", bill_photo=" + bill_photo
				+ ", remark=" + remark + ", supplier_id=" + supplier_id + ", category_type=" + category_type
				+ ", gst_category=" + gst_category + ", rate_include_tax=" + rate_include_tax + "]";
	}
}
