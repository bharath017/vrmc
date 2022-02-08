package com.willka.soft.bean;

import java.io.Serializable;

public class PurchaseOrderItemBean implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private int poi_id;
	private int product_id;
	private double quantity;
	private double rate;
	private int order_id;
	
	public int getPoi_id() {
		return poi_id;
	}
	public void setPoi_id(int poi_id) {
		this.poi_id = poi_id;
	}
	public int getProduct_id() {
		return product_id;
	}
	public void setProduct_id(int product_id) {
		this.product_id = product_id;
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
	public int getOrder_id() {
		return order_id;
	}
	public void setOrder_id(int order_id) {
		this.order_id = order_id;
	}
	
	@Override
	public String toString() {
		return "PurchaseOrderItemBean [poi_id=" + poi_id + ", product_id=" + product_id + ", quantity=" + quantity
				+ ", rate=" + rate + ", order_id=" + order_id + "]";
	}
}
