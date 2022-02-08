package com.willka.soft.bean;

import java.io.Serializable;

public class TicketBean implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 19873L;
	
	private int t_id;
	private int ticket_id;
	private int plant_id;
	private String vehicle_no;
	private int product_id;
	private double empty_weight;
	private double loaded_weight;
	private double ticket_status;
	private String timestamp;
	private String ticket_type;
	private String user_name;
	
	
	public String getTicket_type() {
		return ticket_type;
	}
	public void setTicket_type(String ticket_type) {
		this.ticket_type = ticket_type;
	}
	public int getT_id() {
		return t_id;
	}
	public void setT_id(int t_id) {
		this.t_id = t_id;
	}
	public int getTicket_id() {
		return ticket_id;
	}
	public void setTicket_id(int ticket_id) {
		this.ticket_id = ticket_id;
	}
	public int getPlant_id() {
		return plant_id;
	}
	public void setPlant_id(int plant_id) {
		this.plant_id = plant_id;
	}
	public String getVehicle_no() {
		return vehicle_no;
	}
	public void setVehicle_no(String vehicle_no) {
		this.vehicle_no = vehicle_no;
	}
	public int getProduct_id() {
		return product_id;
	}
	public void setProduct_id(int product_id) {
		this.product_id = product_id;
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
	public double getTicket_status() {
		return ticket_status;
	}
	public void setTicket_status(double ticket_status) {
		this.ticket_status = ticket_status;
	}
	public String getTimestamp() {
		return timestamp;
	}
	public void setTimestamp(String timestamp) {
		this.timestamp = timestamp;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	
	@Override
	public String toString() {
		return "TicketBean [t_id=" + t_id + ", ticket_id=" + ticket_id + ", plant_id=" + plant_id + ", vehicle_no="
				+ vehicle_no + ", product_id=" + product_id + ", empty_weight=" + empty_weight + ", loaded_weight="
				+ loaded_weight + ", ticket_status=" + ticket_status + ", timestamp=" + timestamp + "]";
	}
	
	

}
