package com.willka.soft.bean;

import java.io.Serializable;

public class CubeTestBean implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private int tst_id;
	private int customer_id;
	private int site_id;
	private String product_name;
	private String supply_date;
	private int testing_days;
	private int dimension;
	private int plant_id;
	private int test_id;
	
	public int getTst_id() {
		return tst_id;
	}
	public void setTst_id(int tst_id) {
		this.tst_id = tst_id;
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
	public String getProduct_name() {
		return product_name;
	}
	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}
	public String getSupply_date() {
		return supply_date;
	}
	public void setSupply_date(String supply_date) {
		this.supply_date = supply_date;
	}
	public int getTesting_days() {
		return testing_days;
	}
	public void setTesting_days(int testing_days) {
		this.testing_days = testing_days;
	}
	public int getDimension() {
		return dimension;
	}
	public void setDimension(int dimension) {
		this.dimension = dimension;
	}
	public int getPlant_id() {
		return plant_id;
	}
	public void setPlant_id(int plant_id) {
		this.plant_id = plant_id;
	}
	public int getTest_id() {
		return test_id;
	}
	public void setTest_id(int test_id) {
		this.test_id = test_id;
	}
	@Override
	public String toString() {
		return "CubeTestBean [tst_id=" + tst_id + ", customer_id=" + customer_id + ", site_id=" + site_id
				+ ", product_name=" + product_name + ", supply_date=" + supply_date + ", testing_days=" + testing_days
				+ ", dimension=" + dimension + ", plant_id=" + plant_id + ", test_id=" + test_id + "]";
	}
}
