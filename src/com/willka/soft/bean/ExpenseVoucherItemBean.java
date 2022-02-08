package com.willka.soft.bean;

import java.io.Serializable;

public class ExpenseVoucherItemBean implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 14343L;
	private int evi_id;
	private int expense_voucher_id;
	private String item_name;
	private double item_quantity;
	private double item_price;
	private float gst_percent;
	private double gross_amount;
	private int category_id;
	private double tax_amount;
	private double net_amount;
	
	public int getEvi_id() {
		return evi_id;
	}
	public void setEvi_id(int evi_id) {
		this.evi_id = evi_id;
	}
	public int getExpense_voucher_id() {
		return expense_voucher_id;
	}
	public void setExpense_voucher_id(int expense_voucher_id) {
		this.expense_voucher_id = expense_voucher_id;
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
	public int getCategory_id() {
		return category_id;
	}
	public void setCategory_id(int category_id) {
		this.category_id = category_id;
	}
	
	@Override
	public String toString() {
		return "ExpenseVoucherItemBean [evi_id=" + evi_id + ", expense_voucher_id=" + expense_voucher_id
				+ ", item_name=" + item_name + ", item_quantity=" + item_quantity + ", item_price=" + item_price
				+ ", gst_percent=" + gst_percent + ", gross_amount=" + gross_amount + ", category_id=" + category_id
				+ ", tax_amount=" + tax_amount + ", net_amount=" + net_amount + "]";
	}
}