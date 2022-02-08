package com.willka.soft.bean;

public class SupplierPurchaseOrderItemBean {

	private int spoi_id;
	private String product_number;
	private String description1;
	private double quantity;
	private double unit_price;
	private int supplier_purchase_order_id;
	private String unit;
	
	
	public int getSpoi_id() {
		return spoi_id;
	}
	public void setSpoi_id(int spoi_id) {
		this.spoi_id = spoi_id;
	}
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
	public int getSupplier_purchase_order_id() {
		return supplier_purchase_order_id;
	}
	public void setSupplier_purchase_order_id(int supplier_purchase_order_id) {
		this.supplier_purchase_order_id = supplier_purchase_order_id;
	}
	public String getUnit() {
		return unit;
	}
	public void setUnit(String unit) {
		this.unit = unit;
	}
	@Override
	public String toString() {
		return "SupplierPurchaseOrderItemBean [spoi_id=" + spoi_id + ", product_number=" + product_number
				+ ", description1=" + description1 + ", quantity=" + quantity + ", unit_price=" + unit_price
				+ ", supplier_purchase_order_id=" + supplier_purchase_order_id + "]";
	}
	
	
	
		
	
}
