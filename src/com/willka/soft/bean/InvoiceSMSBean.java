package com.willka.soft.bean;

public class InvoiceSMSBean {

	private String customer_name;
	private String customer_phone;
	private String site_address;
	private String grade;
	private double amount;
	private double quantity;
	private String date;
	private String vehicle_no;
	private String driver_name;
	
	public String getCustomer_name() {
		return customer_name;
	}
	public void setCustomer_name(String customer_name) {
		this.customer_name = customer_name;
	}
	public String getCustomer_phone() {
		return customer_phone;
	}
	public void setCustomer_phone(String customer_phone) {
		this.customer_phone = customer_phone;
	}
	public String getSite_address() {
		return site_address;
	}
	public void setSite_address(String site_address) {
		this.site_address = site_address;
	}
	public String getGrade() {
		return grade;
	}
	public void setGrade(String grade) {
		this.grade = grade;
	}
	public double getAmount() {
		return amount;
	}
	public void setAmount(double amount) {
		this.amount = amount;
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
	public String getVehicle_no() {
		return vehicle_no;
	}
	public void setVehicle_no(String vehicle_no) {
		this.vehicle_no = vehicle_no;
	}
	public String getDriver_name() {
		return driver_name;
	}
	public void setDriver_name(String driver_name) {
		this.driver_name = driver_name;
	}
	@Override
	public String toString() {
		return "InvoiceSMSBean [customer_name=" + customer_name + ", customer_phone=" + customer_phone
				+ ", site_address=" + site_address + ", grade=" + grade + ", amount=" + amount + ", quantity="
				+ quantity + ", date=" + date + ", vehicle_no=" + vehicle_no + ", driver_name=" + driver_name + "]";
	}
}
