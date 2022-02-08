package com.willka.soft.bean;

public class ClintBean {
	
	private int clint_id;
	private String clint_name;
	private String clint_phone;
	private String customer_address;
	private String contractor_name;
	private String contractor_phone;
	private String architech_name;
	private String architech_phone;
	private String consultent_name;
	private String consultent_phone;
	private String pmc_name;
	private String pmc_phone;
	private double project_quantity;
	private String  monthly_requirnment;
	private String currnet_supplier;
	private String stage;
	public int getClint_id() {
		return clint_id;
	}
	public void setClint_id(int clint_id) {
		this.clint_id = clint_id;
	}
	public String getClint_name() {
		return clint_name;
	}
	public void setClint_name(String clint_name) {
		this.clint_name = clint_name;
	}
	public String getClint_phone() {
		return clint_phone;
	}
	public void setClint_phone(String clint_phone) {
		this.clint_phone = clint_phone;
	}
	public String getCustomer_address() {
		return customer_address;
	}
	public void setCustomer_address(String customer_address) {
		this.customer_address = customer_address;
	}
	public String getContractor_name() {
		return contractor_name;
	}
	public void setContractor_name(String contractor_name) {
		this.contractor_name = contractor_name;
	}
	public String getContractor_phone() {
		return contractor_phone;
	}
	public void setContractor_phone(String contractor_phone) {
		this.contractor_phone = contractor_phone;
	}
	public String getArchitech_name() {
		return architech_name;
	}
	public void setArchitech_name(String architech_name) {
		this.architech_name = architech_name;
	}
	public String getArchitech_phone() {
		return architech_phone;
	}
	public void setArchitech_phone(String architech_phone) {
		this.architech_phone = architech_phone;
	}
	public String getConsultent_name() {
		return consultent_name;
	}
	public void setConsultent_name(String consultent_name) {
		this.consultent_name = consultent_name;
	}
	public String getConsultent_phone() {
		return consultent_phone;
	}
	public void setConsultent_phone(String consultent_phone) {
		this.consultent_phone = consultent_phone;
	}
	public String getPmc_name() {
		return pmc_name;
	}
	public void setPmc_name(String pmc_name) {
		this.pmc_name = pmc_name;
	}
	public String getPmc_phone() {
		return pmc_phone;
	}
	public void setPmc_phone(String pmc_phone) {
		this.pmc_phone = pmc_phone;
	}
	public double getProject_quantity() {
		return project_quantity;
	}
	public void setProject_quantity(double project_quantity) {
		this.project_quantity = project_quantity;
	}
	public String getMonthly_requirnment() {
		return monthly_requirnment;
	}
	public void setMonthly_requirnment(String monthly_requirnment) {
		this.monthly_requirnment = monthly_requirnment;
	}
	public String getCurrnet_supplier() {
		return currnet_supplier;
	}
	public void setCurrnet_supplier(String currnet_supplier) {
		this.currnet_supplier = currnet_supplier;
	}
	public String getStage() {
		return stage;
	}
	public void setStage(String stage) {
		this.stage = stage;
	}
	@Override
	public String toString() {
		return "ClintBean [clint_id=" + clint_id + ", clint_name=" + clint_name + ", clint_phone=" + clint_phone
				+ ", customer_address=" + customer_address + ", contractor_name=" + contractor_name
				+ ", contractor_phone=" + contractor_phone + ", architech_name=" + architech_name + ", architech_phone="
				+ architech_phone + ", consultent_name=" + consultent_name + ", consultent_phone=" + consultent_phone
				+ ", pmc_name=" + pmc_name + ", pmc_phone=" + pmc_phone + ", project_quantity=" + project_quantity
				+ ", monthly_requirnment=" + monthly_requirnment + ", currnet_supplier=" + currnet_supplier + ", stage="
				+ stage + "]";
	}
	
	
	

}
