package com.willka.soft.bean;

import java.io.Serializable;

public class DieselConsumptionBean implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 187L;
	private long consumption_id;
	private String vehicle_no;
	private String issued_date;
	private String issued_time;
	private double issued_quantity;
	private double opning_km;
	private double closing_km;
	private String driver_name;
	private String issued_person;
	private String timestamp;
	private  int plant_id;
	
	
	public long getConsumption_id() {
		return consumption_id;
	}


	public void setConsumption_id(long consumption_id) {
		this.consumption_id = consumption_id;
	}


	public String getVehicle_no() {
		return vehicle_no;
	}


	public void setVehicle_no(String vehicle_no) {
		this.vehicle_no = vehicle_no;
	}


	public String getIssued_date() {
		return issued_date;
	}


	public void setIssued_date(String issued_date) {
		this.issued_date = issued_date;
	}


	public String getIssued_time() {
		return issued_time;
	}


	public void setIssued_time(String issued_time) {
		this.issued_time = issued_time;
	}


	public double getIssued_quantity() {
		return issued_quantity;
	}


	public void setIssued_quantity(double issued_quantity) {
		this.issued_quantity = issued_quantity;
	}


	public double getOpning_km() {
		return opning_km;
	}


	public void setOpning_km(double opning_km) {
		this.opning_km = opning_km;
	}


	public double getClosing_km() {
		return closing_km;
	}


	public void setClosing_km(double closing_km) {
		this.closing_km = closing_km;
	}


	public String getDriver_name() {
		return driver_name;
	}


	public void setDriver_name(String driver_name) {
		this.driver_name = driver_name;
	}


	public String getIssued_person() {
		return issued_person;
	}


	public void setIssued_person(String issued_person) {
		this.issued_person = issued_person;
	}


	public String getTimestamp() {
		return timestamp;
	}


	public void setTimestamp(String timestamp) {
		this.timestamp = timestamp;
	}
	

	public int getPlant_id() {
		return plant_id;
	}


	public void setPlant_id(int plant_id) {
		this.plant_id = plant_id;
	}


	@Override
	public String toString() {
		return "DieselConsumptionBean [consumption_id=" + consumption_id + ", vehicle_no=" + vehicle_no
				+ ", issued_date=" + issued_date + ", issued_time=" + issued_time + ", issued_quantity="
				+ issued_quantity + ", opning_km=" + opning_km + ", closing_km=" + closing_km + ", driver_name="
				+ driver_name + ", issued_person=" + issued_person + ", timestamp=" + timestamp + "]";
	}

		
}
