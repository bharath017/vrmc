package com.willka.soft.bean;

public class PlantBean {

private int plant_id;
private String plant_name;
private String plant_address;
private String plant_manager;
private String plant_phones;
private String plant_email;
private String plant_domain;
private String plant_gstin;
private String plant_cst;
private String plant_panno;
private String plant_transport;
private String plant_regno;
private String billing_address;
private int business_id;



public String getPlant_regno() {
	return plant_regno;
}
public void setPlant_regno(String plant_regno) {
	this.plant_regno = plant_regno;
}
public int getPlant_id() {
	return plant_id;
}
public void setPlant_id(int plant_id) {
	this.plant_id = plant_id;
}
public String getPlant_name() {
	return plant_name;
}
public void setPlant_name(String plant_name) {
	this.plant_name = plant_name;
}
public String getPlant_address() {
	return plant_address;
}
public void setPlant_address(String plant_address) {
	this.plant_address = plant_address;
}
public String getPlant_email() {
	return plant_email;
}
public void setPlant_email(String plant_email) {
	this.plant_email = plant_email;
}
public String getPlant_domain() {
	return plant_domain;
}
public void setPlant_domain(String plant_domain) {
	this.plant_domain = plant_domain;
}
public String getPlant_gstin() {
	return plant_gstin;
}
public void setPlant_gstin(String plant_gstin) {
	this.plant_gstin = plant_gstin;
}
public String getPlant_cst() {
	return plant_cst;
}
public void setPlant_cst(String plant_cst) {
	this.plant_cst = plant_cst;
}
public String getPlant_panno() {
	return plant_panno;
}
public void setPlant_panno(String plant_panno) {
	this.plant_panno = plant_panno;
}
public String getPlant_transport() {
	return plant_transport;
}
public void setPlant_transport(String plant_transport) {
	this.plant_transport = plant_transport;
}
public String getPlant_manager() {
	return plant_manager;
}
public void setPlant_manager(String plant_manager) {
	this.plant_manager = plant_manager;
}
public String getPlant_phones() {
	return plant_phones;
}
public void setPlant_phones(String plant_phones) {
	this.plant_phones = plant_phones;
}
public String getBilling_address() {
	return billing_address;
}
public void setBilling_address(String billing_address) {
	this.billing_address = billing_address;
}
public int getBusiness_id() {
	return business_id;
}
public void setBusiness_id(int business_id) {
	this.business_id = business_id;
}
@Override
public String toString() {
	return "PlantBean [plant_id=" + plant_id + ", plant_name=" + plant_name + ", plant_address=" + plant_address
			+ ", plant_manager=" + plant_manager + ", plant_phones=" + plant_phones + ", plant_email=" + plant_email
			+ ", plant_domain=" + plant_domain + ", plant_gstin=" + plant_gstin + ", plant_cst=" + plant_cst
			+ ", plant_panno=" + plant_panno + ", plant_transport=" + plant_transport + ", plant_regno=" + plant_regno
			+ ", billing_address=" + billing_address + ", business_id=" + business_id + "]";
}
}
