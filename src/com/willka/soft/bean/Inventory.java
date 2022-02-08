package com.willka.soft.bean;

import java.io.Serializable;

public class Inventory implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 14242L;
	
	private int inventory_id;
	private int inv_item_id;
	private String date;
	private String time;
	private double empty_weight;
	private double loaded_weight;
	private double net_weight;
	private double supplier_weight;
	private String bill_no;
	private int plant_id;
	private int supplier_id;
	private float moisture_percent;
	private Double after_weight;
	private String inventory_status;
	private String timestamp;
	private String vehicle_no;
	private String gatepass_no;
	private String royalty_no;
	private String unit;
	private int pl_delivery_address_id;
	
	
	public String getRoyalty_no() {
		return royalty_no;
	}
	public void setRoyalty_no(String royalty_no) {
		this.royalty_no = royalty_no;
	}
	public float getMoisture_percent() {
		return moisture_percent;
	}
	public void setMoisture_percent(float moisture_percent) {
		this.moisture_percent = moisture_percent;
	}
	public Double getAfter_weight() {
		return after_weight;
	}
	public void setAfter_weight(Double after_weight) {
		this.after_weight = after_weight;
	}
	public int getInventory_id() {
		return inventory_id;
	}
	public void setInventory_id(int inventory_id) {
		this.inventory_id = inventory_id;
	}
	public int getInv_item_id() {
		return inv_item_id;
	}
	public void setInv_item_id(int inv_item_id) {
		this.inv_item_id = inv_item_id;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
	public double getEmpty_weight() {
		return empty_weight;
	}
	public void setEmpty_weight(double empty_weight) {
		this.empty_weight = empty_weight;
	}
	public double getLoaded_weight() {
		return loaded_weight;
	}
	public void setLoaded_weight(double loaded_weight) {
		this.loaded_weight = loaded_weight;
	}
	public double getNet_weight() {
		return net_weight;
	}
	public void setNet_weight(double net_weight) {
		this.net_weight = net_weight;
	}
	public double getSupplier_weight() {
		return supplier_weight;
	}
	public void setSupplier_weight(double supplier_weight) {
		this.supplier_weight = supplier_weight;
	}
	public String getBill_no() {
		return bill_no;
	}
	public void setBill_no(String bill_no) {
		this.bill_no = bill_no;
	}
	public int getPlant_id() {
		return plant_id;
	}
	public void setPlant_id(int plant_id) {
		this.plant_id = plant_id;
	}
	public int getSupplier_id() {
		return supplier_id;
	}
	public void setSupplier_id(int supplier_id) {
		this.supplier_id = supplier_id;
	}
	public String getInventory_status() {
		return inventory_status;
	}
	public void setInventory_status(String inventory_status) {
		this.inventory_status = inventory_status;
	}
	public String getTimestamp() {
		return timestamp;
	}
	public void setTimestamp(String timestamp) {
		this.timestamp = timestamp;
	}
	public String getVehicle_no() {
		return vehicle_no;
	}
	public void setVehicle_no(String vehicle_no) {
		this.vehicle_no = vehicle_no;
	}
	public String getGatepass_no() {
		return gatepass_no;
	}
	public void setGatepass_no(String gatepass_no) {
		this.gatepass_no = gatepass_no;
	}
	public String getUnit() {
		return unit;
	}
	public void setUnit(String unit) {
		this.unit = unit;
	}
	public int getPl_delivery_address_id() {
		return pl_delivery_address_id;
	}
	public void setPl_delivery_address_id(int pl_delivery_address_id) {
		this.pl_delivery_address_id = pl_delivery_address_id;
	}
	
	@Override
	public String toString() {
		return "Inventory [inventory_id=" + inventory_id + ", inv_item_id=" + inv_item_id + ", date=" + date + ", time="
				+ time + ", empty_weight=" + empty_weight + ", loaded_weight=" + loaded_weight + ", net_weight="
				+ net_weight + ", supplier_weight=" + supplier_weight + ", bill_no=" + bill_no + ", plant_id="
				+ plant_id + ", supplier_id=" + supplier_id + ", moisture_percent=" + moisture_percent
				+ ", after_weight=" + after_weight + ", inventory_status=" + inventory_status + ", timestamp="
				+ timestamp + ", vehicle_no=" + vehicle_no + ", gatepass_no=" + gatepass_no + ", royalty_no="
				+ royalty_no + ", unit=" + unit + ", pl_delivery_address_id=" + pl_delivery_address_id + "]";
	}
}
