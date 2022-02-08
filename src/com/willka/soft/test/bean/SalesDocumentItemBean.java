package com.willka.soft.test.bean;

import java.io.Serializable;

public class SalesDocumentItemBean implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 19879L;
	
	private int id;
	private int poi_id;
	private double item_quantity;
	private double item_price;
	private double gross_price;
	private double net_price;
	private double tax_price;
	private int sditem_id;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getPoi_id() {
		return poi_id;
	}
	public void setPoi_id(int poi_id) {
		this.poi_id = poi_id;
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
	public double getGross_price() {
		return gross_price;
	}
	public void setGross_price(double gross_price) {
		this.gross_price = gross_price;
	}
	public double getNet_price() {
		return net_price;
	}
	public void setNet_price(double net_price) {
		this.net_price = net_price;
	}
	public double getTax_price() {
		return tax_price;
	}
	public void setTax_price(double tax_price) {
		this.tax_price = tax_price;
	}
	public int getSditem_id() {
		return sditem_id;
	}
	public void setSditem_id(int sditem_id) {
		this.sditem_id = sditem_id;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	@Override
	public String toString() {
		return "SalesDocumentItemBean [id=" + id + ", poi_id=" + poi_id + ", item_quantity=" + item_quantity
				+ ", item_price=" + item_price + ", gross_price=" + gross_price + ", net_price=" + net_price
				+ ", tax_price=" + tax_price + ", sditem_id=" + sditem_id + "]";
	}

}
