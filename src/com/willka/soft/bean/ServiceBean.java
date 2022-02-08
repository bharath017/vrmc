package com.willka.soft.bean;

import java.io.Serializable;

public class ServiceBean implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private long vs_id;
	private long vt_id;	
	private String vehicle_no;
	private String date;
	private String time;
	private String vehicle;
	private double service_cost;
	private double last_skm;
	private double present_skm;
	private  int plant_id;
	public long getVs_id() {
		return vs_id;
	}
	public void setVs_id(long vs_id) {
		this.vs_id = vs_id;
	}
	public long getVt_id() {
		return vt_id;
	}
	public void setVt_id(long vt_id) {
		this.vt_id = vt_id;
	}
	public String getVehicle_no() {
		return vehicle_no;
	}
	public void setVehicle_no(String vehicle_no) {
		this.vehicle_no = vehicle_no;
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
	public String getVehicle() {
		return vehicle;
	}
	public void setVehicle(String vehicle) {
		this.vehicle = vehicle;
	}
	
	public double getService_cost() {
		return service_cost;
	}
	public void setService_cost(double service_cost) {
		this.service_cost = service_cost;
	}
	public double getLast_skm() {
		return last_skm;
	}
	public void setLast_skm(double last_skm) {
		this.last_skm = last_skm;
	}
	public double getPresent_skm() {
		return present_skm;
	}
	public void setPresent_skm(double present_skm) {
		this.present_skm = present_skm;
	}
	public int getPlant_id() {
		return plant_id;
	}
	public void setPlant_id(int plant_id) {
		this.plant_id = plant_id;
	}
	@Override
	public String toString() {
		return "ServiceBean [vs_id=" + vs_id + ", vt_id=" + vt_id + ", vehicle_no=" + vehicle_no + ", date=" + date
				+ ", time=" + time + ", vehicle=" + vehicle + ", service_cost=" + service_cost + ", last_skm="
				+ last_skm + ", present_skm=" + present_skm + ", plant_id=" + plant_id + "]";
	}
}
