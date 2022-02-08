package com.willka.soft.bean;

public class VehiclesBean {
	
	private String vehicle_no;
	private String vehicle_name;
	private int plant_id;
	private String location;
	private String driver_name;
	private String insurance_valid_till;
	private String insurance_no;
	private String vehicle_type;
	private String licence_valid_till ;
	private String  licence_no ;
	private double meter_reading;
	private String from_date;
	private String to_date;
	private String amount;
	private String fc_date;
	private String tax_date;
	private double vehicle_weight;
	private String vehicle_cat;
	
	
	public String getFc_date() {
		return fc_date;
	}
	public void setFc_date(String fc_date) {
		this.fc_date = fc_date;
	}
	public String getTax_date() {
		return tax_date;
	}
	public void setTax_date(String tax_date) {
		this.tax_date = tax_date;
	}
	public double getMeter_reading() {
		return meter_reading;
	}
	public void setMeter_reading(double meter_reading) {
		this.meter_reading = meter_reading;
	}
	public String getFrom_date() {
		return from_date;
	}
	public void setFrom_date(String from_date) {
		this.from_date = from_date;
	}
	public String getTo_date() {
		return to_date;
	}
	public void setTo_date(String to_date) {
		this.to_date = to_date;
	}
	public String getAmount() {
		return amount;
	}
	public void setAmount(String amount) {
		this.amount = amount;
	}
	public String getVehicle_no() {
		return vehicle_no;
	}
	public void setVehicle_no(String vehicle_no) {
		this.vehicle_no = vehicle_no;
	}
	public String getVehicle_name() {
		return vehicle_name;
	}
	public void setVehicle_name(String vehicle_name) {
		this.vehicle_name = vehicle_name;
	}
	public int getPlant_id() {
		return plant_id;
	}
	public void setPlant_id(int plant_id) {
		this.plant_id = plant_id;
	}
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	
	public String getInsurance_valid_till() {
		return insurance_valid_till;
	}
	public void setInsurance_valid_till(String insurance_valid_till) {
		this.insurance_valid_till = insurance_valid_till;
	}
	public String getInsurance_no() {
		return insurance_no;
	}
	
	public void setInsurance_no(String insurance_no) {
		this.insurance_no = insurance_no;
	}
	
	public String getDriver_name() {
		return driver_name;
	}
	public void setDriver_name(String driver_name) {
		this.driver_name = driver_name;
	}
	
	public String getVehicle_type() {
		return vehicle_type;
	}
	public void setVehicle_type(String vehicle_type) {
		this.vehicle_type = vehicle_type;
	}

	public String getLicence_valid_till() {
		return licence_valid_till;
	}
	public void setLicence_valid_till(String licence_valid_till) {
		this.licence_valid_till = licence_valid_till;
	}
	public String getLicence_no() {
		return licence_no;
	}
	public void setLicence_no(String licence_no) {
		this.licence_no = licence_no;
	}
	public double getVehicle_weight() {
		return vehicle_weight;
	}
	public void setVehicle_weight(double vehicle_weight) {
		this.vehicle_weight = vehicle_weight;
	}
	public String getVehicle_cat() {
		return vehicle_cat;
	}
	public void setVehicle_cat(String vehicle_cat) {
		this.vehicle_cat = vehicle_cat;
	}
	@Override
	public String toString() {
		return "VehiclesBean [vehicle_no=" + vehicle_no + ", vehicle_name=" + vehicle_name + ", plant_id=" + plant_id
				+ ", location=" + location + ", driver_name=" + driver_name + ", insurance_valid_till="
				+ insurance_valid_till + ", insurance_no=" + insurance_no + ", vehicle_type=" + vehicle_type
				+ ", licence_valid_till=" + licence_valid_till + ", licence_no=" + licence_no + ", meter_reading="
				+ meter_reading + ", from_date=" + from_date + ", to_date=" + to_date + ", amount=" + amount + "]";
	}
	
	
	
		
	
		
	

}
