package com.willka.soft.bean;

import java.io.Serializable;

public class SchedulingItemBean  implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 15353L;
	private int scheduling_item_id;
	private int product_id;
	private double production_quantity;
	private int scheduling_id;
	private String product_name;
	private double tquantity;
	private double po_quantity;
	
	public int getScheduling_item_id() {
		return scheduling_item_id;
	}
	public void setScheduling_item_id(int scheduling_item_id) {
		this.scheduling_item_id = scheduling_item_id;
	}
	public int getProduct_id() {
		return product_id;
	}
	public void setProduct_id(int product_id) {
		this.product_id = product_id;
	}
	public double getProduction_quantity() {
		return production_quantity;
	}
	public void setProduction_quantity(double production_quantity) {
		this.production_quantity = production_quantity;
	}
	public int getScheduling_id() {
		return scheduling_id;
	}
	public void setScheduling_id(int scheduling_id) {
		this.scheduling_id = scheduling_id;
	}
	public String getProduct_name() {
		return product_name;
	}
	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}
	public double getTquantity() {
		return tquantity;
	}
	public void setTquantity(double tquantity) {
		this.tquantity = tquantity;
	}
	public double getPo_quantity() {
		return po_quantity;
	}
	public void setPo_quantity(double po_quantity) {
		this.po_quantity = po_quantity;
	}
	
	
	@Override
	public String toString() {
		return "Scheduling_item [scheduling_item_id=" + scheduling_item_id + ", product_id=" + product_id
				+ ", production_quantity=" + production_quantity + "]";
	}

}
