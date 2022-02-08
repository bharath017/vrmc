package com.willka.soft.bean;

import java.io.Serializable;

public class CustomerQuotationItemBean implements Serializable{

	private static final long serialVersionUID = 154L;
	
	private int grade_id;
	private String grade_name;
	private double grade_price;
	private double ggbs_price;
	private int quotation_id;
	private double quantity;
	
	
	public double getQuantity() {
		return quantity;
	}
	public void setQuantity(double quantity) {
		this.quantity = quantity;
	}
	public int getGrade_id() {
		return grade_id;
	}
	public void setGrade_id(int grade_id) {
		this.grade_id = grade_id;
	}
	public String getGrade_name() {
		return grade_name;
	}
	public void setGrade_name(String grade_name) {
		this.grade_name = grade_name;
	}
	public double getGrade_price() {
		return grade_price;
	}
	public void setGrade_price(double grade_price) {
		this.grade_price = grade_price;
	}
	public double getGgbs_price() {
		return ggbs_price;
	}
	public void setGgbs_price(double ggbs_price) {
		this.ggbs_price = ggbs_price;
	}
	public int getQuotation_id() {
		return quotation_id;
	}
	public void setQuotation_id(int quotation_id) {
		this.quotation_id = quotation_id;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	@Override
	public String toString() {
		return "CustomerQuotationItemBean [grade_id=" + grade_id + ", grade_name=" + grade_name + ", grade_price="
				+ grade_price + ", ggbs_price=" + ggbs_price + ", quotation_id=" + quotation_id + ", quantity="
				+ quantity + "]";
	}
	
	
}
