package com.willka.soft.test.bean;

public class InventoryStockBean {

	private int stock_id;
	private int inv_item_id;
	private int plant_id;
	private double stock_quantity;
	
	
	public int getStock_id() {
		return stock_id;
	}
	public void setStock_id(int stock_id) {
		this.stock_id = stock_id;
	}
	public int getInv_item_id() {
		return inv_item_id;
	}
	public void setInv_item_id(int inv_item_id) {
		this.inv_item_id = inv_item_id;
	}
	public int getPlant_id() {
		return plant_id;
	}
	public void setPlant_id(int plant_id) {
		this.plant_id = plant_id;
	}
	public double getStock_quantity() {
		return stock_quantity;
	}
	public void setStock_quantity(double stock_quantity) {
		this.stock_quantity = stock_quantity;
	}
	@Override
	public String toString() {
		return "InventoryStockBean [stock_id=" + stock_id + ", inv_item_id=" + inv_item_id + ", plant_id=" + plant_id
				+ ", stock_quantity=" + stock_quantity + "]";
	}
}
