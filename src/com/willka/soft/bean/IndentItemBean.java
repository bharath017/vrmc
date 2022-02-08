package com.willka.soft.bean;

public class IndentItemBean {

	private int indent_item_id;
	private String product_number;
	private String description1;
	private double quantity;
	private double unit_price;
	private int indent_id;
	private String unit;

	
	public String getProduct_number() {
		return product_number;
	}
	public void setProduct_number(String product_number) {
		this.product_number = product_number;
	}
	public String getDescription1() {
		return description1;
	}
	public void setDescription1(String description1) {
		this.description1 = description1;
	}
	public double getQuantity() {
		return quantity;
	}
	public void setQuantity(double quantity) {
		this.quantity = quantity;
	}
	public double getUnit_price() {
		return unit_price;
	}
	public void setUnit_price(double unit_price) {
		this.unit_price = unit_price;
	}
	public int getIndent_id() {
		return indent_id;
	}
	public void setIndent_id(int indent_id) {
		this.indent_id = indent_id;
	}
	public String getUnit() {
		return unit;
	}
	public void setUnit(String unit) {
		this.unit = unit;
	}
	public int getIndent_item_id() {
		return indent_item_id;
	}
	public void setIndent_item_id(int indent_item_id) {
		this.indent_item_id = indent_item_id;
	}
	@Override
	public String toString() {
		return "IndentItemBean [indent_item_id=" + indent_item_id + ", product_number=" + product_number
				+ ", description1=" + description1 + ", quantity=" + quantity + ", unit_price=" + unit_price
				+ ", indent_id=" + indent_id + ", unit=" + unit + "]";
	}

	
	
	

	
	
	
		
	
}
