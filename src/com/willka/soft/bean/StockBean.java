package com.willka.soft.bean;

import java.io.Serializable;

public class StockBean  implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 13943L;
	private int stock_id;
	private double quantity;
	private String date;
	private int inv_item_id;
	private int plant_id;
	
	
	public int getStock_id() {
		return stock_id;
	}
	public void setStock_id(int stock_id) {
		this.stock_id = stock_id;
	}
	public double getQuantity() {
		return quantity;
	}
	public void setQuantity(double quantity) {
		this.quantity = quantity;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
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
	@Override
	public String toString() {
		return "StockBean [stock_id=" + stock_id + ", quantity=" + quantity + ", date=" + date + ", inv_item_id="
				+ inv_item_id + ", plant_id=" + plant_id + "]";
	}
}
