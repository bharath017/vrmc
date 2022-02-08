package com.willka.soft.test.bean;

import java.io.Serializable;

public class SchedulingBean implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 15353L;
	
	private int scheduling_id;
	private int plant_id;
	private int customer_id;
	private int site_id;
	private String scheduling_date;
	private String start_time;
	private String end_time;
	private String pump1;
	private String pump2;
	private int user_id;
	
	
	public int getScheduling_id() {
		return scheduling_id;
	}
	public void setScheduling_id(int scheduling_id) {
		this.scheduling_id = scheduling_id;
	}
	public int getPlant_id() {
		return plant_id;
	}
	public void setPlant_id(int plant_id) {
		this.plant_id = plant_id;
	}
	public int getCustomer_id() {
		return customer_id;
	}
	public void setCustomer_id(int customer_id) {
		this.customer_id = customer_id;
	}
	public int getSite_id() {
		return site_id;
	}
	public void setSite_id(int site_id) {
		this.site_id = site_id;
	}
	public String getScheduling_date() {
		return scheduling_date;
	}
	public void setScheduling_date(String scheduling_date) {
		this.scheduling_date = scheduling_date;
	}
	public String getStart_time() {
		return start_time;
	}
	public void setStart_time(String start_time) {
		this.start_time = start_time;
	}
	public String getEnd_time() {
		return end_time;
	}
	public void setEnd_time(String end_time) {
		this.end_time = end_time;
	}
	public String getPump1() {
		return pump1;
	}
	public void setPump1(String pump1) {
		this.pump1 = pump1;
	}
	public String getPump2() {
		return pump2;
	}
	public void setPump2(String pump2) {
		this.pump2 = pump2;
	}
	public int getUser_id() {
		return user_id;
	}
	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	@Override
	public String toString() {
		return "SchedulingBean [scheduling_id=" + scheduling_id + ", customer_id=" + customer_id + ", site_id="
				+ site_id + ", scheduling_date=" + scheduling_date + ", start_time=" + start_time + ", end_time="
				+ end_time + ", pump1=" + pump1 + ", pump2=" + pump2 + "]";
	}
	

}
