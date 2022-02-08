package com.willka.soft.bean;

public class DriverBean {

	private int driver_id;
	private String driver_name;
	private String driver_phone;
	private String driver_address;
	private String licence_no;
	private String licence_valid_till;
	private int plant_id;
	
	
	
	public int getPlant_id() {
		return plant_id;
	}
	public void setPlant_id(int plant_id) {
		this.plant_id = plant_id;
	}
	public int getDriver_id() {
		return driver_id;
	}
	public void setDriver_id(int driver_id) {
		this.driver_id = driver_id;
	}
	public String getDriver_name() {
		return driver_name;
	}
	public void setDriver_name(String driver_name) {
		this.driver_name = driver_name;
	}
	public String getDriver_phone() {
		return driver_phone;
	}
	public void setDriver_phone(String driver_phone) {
		this.driver_phone = driver_phone;
	}
	public String getDriver_address() {
		return driver_address;
	}
	public void setDriver_address(String driver_address) {
		this.driver_address = driver_address;
	}
	public String getLicence_no() {
		return licence_no;
	}
	public void setLicence_no(String licence_no) {
		this.licence_no = licence_no;
	}
	public String getLicence_valid_till() {
		return licence_valid_till;
	}
	public void setLicence_valid_till(String licence_valid_till) {
		this.licence_valid_till = licence_valid_till;
	}
	
	
	@Override
	public String toString() {
		return "DriverBean [driver_id=" + driver_id + ", driver_name=" + driver_name + ", driver_phone=" + driver_phone
				+ ", driver_address=" + driver_address + ", licence_no=" + licence_no + ", licence_valid_till="
				+ licence_valid_till + ", plant_id=" + plant_id + "]";
	}
	
	
	
	
}
