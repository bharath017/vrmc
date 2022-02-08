package com.willka.soft.bean;

import java.io.Serializable;

public class GradeComposition implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 15354L;
	private int comp_id;
	private int product_id;
	private String product_name;
	private double comp_weight;
	private int sp_id;
	private String sp_name;
	public int getComp_id() {
		return comp_id;
	}
	public void setComp_id(int comp_id) {
		this.comp_id = comp_id;
	}
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
	public double getComp_weight() {
		return comp_weight;
	}
	public void setComp_weight(double comp_weight) {
		this.comp_weight = comp_weight;
	}
	public int getSp_id() {
		return sp_id;
	}
	public void setSp_id(int sp_id) {
		this.sp_id = sp_id;
	}
	public String getSp_name() {
		return sp_name;
	}
	public void setSp_name(String sp_name) {
		this.sp_name = sp_name;
	}
	
	
	@Override
	public String toString() {
		return "GradeComposition [comp_id=" + comp_id + ", product_id=" + product_id + ", product_name=" + product_name
				+ ", comp_weight=" + comp_weight + ", sp_id=" + sp_id + ", sp_name=" + sp_name + "]";
	}
	
	
	
	
}
