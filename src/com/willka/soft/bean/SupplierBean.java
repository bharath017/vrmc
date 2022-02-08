package com.willka.soft.bean;

import java.io.Serializable;

public class SupplierBean implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1343L;
	
	private int supplier_id;
	private String supplier_name;
	private String supplier_phone;
	private String supplier_address;
	private String supplier_status;
	private String supplier_gstin;
	private String supplier_panno;
	private String supplier_email;
	private double opening_balance;
	private int business_id;
	private String group_name;
	
	public int getSupplier_id() {
		return supplier_id;
	}
	public void setSupplier_id(int supplier_id) {
		this.supplier_id = supplier_id;
	}
	public String getSupplier_name() {
		return supplier_name;
	}
	public void setSupplier_name(String supplier_name) {
		this.supplier_name = supplier_name;
	}
	public String getSupplier_phone() {
		return supplier_phone;
	}
	public void setSupplier_phone(String supplier_phone) {
		this.supplier_phone = supplier_phone;
	}
	public String getSupplier_address() {
		return supplier_address;
	}
	public void setSupplier_address(String supplier_address) {
		this.supplier_address = supplier_address;
	}
	public String getSupplier_status() {
		return supplier_status;
	}
	public void setSupplier_status(String supplier_status) {
		this.supplier_status = supplier_status;
	}
	public String getSupplier_gstin() {
		return supplier_gstin;
	}
	public void setSupplier_gstin(String supplier_gstin) {
		this.supplier_gstin = supplier_gstin;
	}
	public String getSupplier_panno() {
		return supplier_panno;
	}
	public void setSupplier_panno(String supplier_panno) {
		this.supplier_panno = supplier_panno;
	}
	public double getOpening_balance() {
		return opening_balance;
	}
	public void setOpening_balance(double opening_balance) {
		this.opening_balance = opening_balance;
	}
	public int getBusiness_id() {
		return business_id;
	}
	public void setBusiness_id(int business_id) {
		this.business_id = business_id;
	}
	public String getSupplier_email() {
		return supplier_email;
	}
	public void setSupplier_email(String supplier_email) {
		this.supplier_email = supplier_email;
	}
	public String getGroup_name() {
		return group_name;
	}
	public void setGroup_name(String group_name) {
		this.group_name = group_name;
	}
	@Override
	public String toString() {
		return "SupplierBean [supplier_id=" + supplier_id + ", supplier_name=" + supplier_name + ", supplier_phone="
				+ supplier_phone + ", supplier_address=" + supplier_address + ", supplier_status=" + supplier_status
				+ ", supplier_gstin=" + supplier_gstin + ", supplier_panno=" + supplier_panno + ", supplier_email="
				+ supplier_email + ", opening_balance=" + opening_balance + ", business_id=" + business_id
				+ ", group_name=" + group_name + "]";
	}
}
