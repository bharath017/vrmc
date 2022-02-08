package com.willka.soft.bean;

import java.io.Serializable;

public class ProductBean implements Serializable {
	

	/**
	 * 
	 */
	private static final long serialVersionUID = 17343L;
	private int product_id;
	private String product_name;
	private String product_detail;
	private String unit_of_measurement;
	private String cem_type;
	private double cem_quantity;
	private String max_aggregate;
	private double max_wc;
	private int business_id;
	private String hsn_code;
	private boolean isConversionRequired;
	private double conversion_value;
	
	
	
	public int getProduct_id() {
		return product_id;
	}
	public void setProduct_id(int product_id) {
		this.product_id = product_id;
	}
	public String getProduct_name() {
		return product_name;
	}
	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}
	public String getProduct_detail() {
		return product_detail;
	}
	public void setProduct_detail(String product_detail) {
		this.product_detail = product_detail;
	}
	public String getUnit_of_measurement() {
		return unit_of_measurement;
	}
	public void setUnit_of_measurement(String unit_of_measurement) {
		this.unit_of_measurement = unit_of_measurement;
	}
	public String getCem_type() {
		return cem_type;
	}
	public void setCem_type(String cem_type) {
		this.cem_type = cem_type;
	}
	public double getCem_quantity() {
		return cem_quantity;
	}
	public void setCem_quantity(double cem_quantity) {
		this.cem_quantity = cem_quantity;
	}
	public String getMax_aggregate() {
		return max_aggregate;
	}
	public void setMax_aggregate(String max_aggregate) {
		this.max_aggregate = max_aggregate;
	}
	public double getMax_wc() {
		return max_wc;
	}
	public void setMax_wc(double max_wc) {
		this.max_wc = max_wc;
	}
	public int getBusiness_id() {
		return business_id;
	}
	public void setBusiness_id(int business_id) {
		this.business_id = business_id;
	}
	public String getHsn_code() {
		return hsn_code;
	}
	public void setHsn_code(String hsn_code) {
		this.hsn_code = hsn_code;
	}
	public boolean isConversionRequired() {
		return isConversionRequired;
	}
	public void setConversionRequired(boolean isConversionRequired) {
		this.isConversionRequired = isConversionRequired;
	}
	public double getConversion_value() {
		return conversion_value;
	}
	public void setConversion_value(double conversion_value) {
		this.conversion_value = conversion_value;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	@Override
	public String toString() {
		return "ProductBean [product_id=" + product_id + ", product_name=" + product_name + ", product_detail="
				+ product_detail + ", unit_of_measurement=" + unit_of_measurement + ", cem_type=" + cem_type
				+ ", cem_quantity=" + cem_quantity + ", max_aggregate=" + max_aggregate + ", max_wc=" + max_wc
				+ ", business_id=" + business_id + "]";
	}

	
	

}
