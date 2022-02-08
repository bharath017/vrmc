package com.willka.soft.bean;

import java.io.Serializable;

public class FleetItemBean implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 3531L;
	
	private int fleet_item_id;
	private String item_name;
	private double item_cost;
	private double item_stock_quantity;
	private int plant_id;
	private String item_status;
	
	
	public int getFleet_item_id() {
		return fleet_item_id;
	}
	public void setFleet_item_id(int fleet_item_id) {
		this.fleet_item_id = fleet_item_id;
	}
	public String getItem_name() {
		return item_name;
	}
	public void setItem_name(String item_name) {
		this.item_name = item_name;
	}
	public double getItem_cost() {
		return item_cost;
	}
	public void setItem_cost(double item_cost) {
		this.item_cost = item_cost;
	}
	public double getItem_stock_quantity() {
		return item_stock_quantity;
	}
	public void setItem_stock_quantity(double item_stock_quantity) {
		this.item_stock_quantity = item_stock_quantity;
	}
	public int getPlant_id() {
		return plant_id;
	}
	public void setPlant_id(int plant_id) {
		this.plant_id = plant_id;
	}
	public String getItem_status() {
		return item_status;
	}
	public void setItem_status(String item_status) {
		this.item_status = item_status;
	}
	@Override
	public String toString() {
		return "FleetItemBean [fleet_item_id=" + fleet_item_id + ", item_name=" + item_name + ", item_cost=" + item_cost
				+ ", item_stock_quantity=" + item_stock_quantity + ", plant_id=" + plant_id + ", item_status="
				+ item_status + "]";
	}	

}
