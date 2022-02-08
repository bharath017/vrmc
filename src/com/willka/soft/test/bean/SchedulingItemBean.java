package com.willka.soft.test.bean;

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
	
	@Override
	public String toString() {
		return "Scheduling_item [scheduling_item_id=" + scheduling_item_id + ", product_id=" + product_id
				+ ", production_quantity=" + production_quantity + "]";
	}

}
