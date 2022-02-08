package com.willka.soft.bean;

import java.io.Serializable;

public class VehicleRepairBean implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	private int gp_no;
	private String vehicle_no;
	private String repair_date;
	private String repair_time;
	private double repair_cost;
	private String  description;
	private String remarks;
	private String vendor;
	private String place;
	private String received_person;
	private  int plant_id;
	public int getGp_no() {
		return gp_no;
	}
	public void setGp_no(int gp_no) {
		this.gp_no = gp_no;
	}
	public String getVehicle_no() {
		return vehicle_no;
	}
	public void setVehicle_no(String vehicle_no) {
		this.vehicle_no = vehicle_no;
	}
	public String getRepair_date() {
		return repair_date;
	}
	public void setRepair_date(String repair_date) {
		this.repair_date = repair_date;
	}
	public String getRepair_time() {
		return repair_time;
	}
	public void setRepair_time(String repair_time) {
		this.repair_time = repair_time;
	}
	public double getRepair_cost() {
		return repair_cost;
	}
	public void setRepair_cost(double repair_cost) {
		this.repair_cost = repair_cost;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	public String getVendor() {
		return vendor;
	}
	public void setVendor(String vendor) {
		this.vendor = vendor;
	}
	public String getPlace() {
		return place;
	}
	public void setPlace(String place) {
		this.place = place;
	}
	public String getReceived_person() {
		return received_person;
	}
	public void setReceived_person(String received_person) {
		this.received_person = received_person;
	}
	public int getPlant_id() {
		return plant_id;
	}
	public void setPlant_id(int plant_id) {
		this.plant_id = plant_id;
	}
	@Override
	public String toString() {
		return "VehicleRepairBean [gp_no=" + gp_no + ", vehicle_no=" + vehicle_no + ", repair_date=" + repair_date
				+ ", repair_time=" + repair_time + ", repair_cost=" + repair_cost + ", description=" + description
				+ ", remarks=" + remarks + ", vendor=" + vendor + ", place=" + place + ", received_person="
				+ received_person + ", plant_id=" + plant_id + "]";
	}
	
	
	
}
