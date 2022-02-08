package com.willka.soft.bean;

import java.io.Serializable;

public class CompanySalaryStructureBean implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 14565L;
	private int cmp_id;
	private double cmp_basic;
	private double cmp_hra;
	private double cmp_ta;
	private double cmp_pf;
	private double cmp_mr;
	private double cmp_esic;
	private double cmp_pt;
	private double cmp_da;
	
	
	public int getCmp_id() {
		return cmp_id;
	}
	public void setCmp_id(int cmp_id) {
		this.cmp_id = cmp_id;
	}
	public double getCmp_basic() {
		return cmp_basic;
	}
	public void setCmp_basic(double cmp_basic) {
		this.cmp_basic = cmp_basic;
	}
	public double getCmp_hra() {
		return cmp_hra;
	}
	public void setCmp_hra(double cmp_hra) {
		this.cmp_hra = cmp_hra;
	}
	public double getCmp_ta() {
		return cmp_ta;
	}
	public void setCmp_ta(double cmp_ta) {
		this.cmp_ta = cmp_ta;
	}
	public double getCmp_pf() {
		return cmp_pf;
	}
	public void setCmp_pf(double cmp_pf) {
		this.cmp_pf = cmp_pf;
	}
	public double getCmp_mr() {
		return cmp_mr;
	}
	public void setCmp_mr(double cmp_mr) {
		this.cmp_mr = cmp_mr;
	}
	public double getCmp_esic() {
		return cmp_esic;
	}
	public void setCmp_esic(double cmp_esic) {
		this.cmp_esic = cmp_esic;
	}
	public double getCmp_pt() {
		return cmp_pt;
	}
	public void setCmp_pt(double cmp_pt) {
		this.cmp_pt = cmp_pt;
	}
	public double getCmp_da() {
		return cmp_da;
	}
	public void setCmp_da(double cmp_da) {
		this.cmp_da = cmp_da;
	}
	@Override
	public String toString() {
		return "CompanySalaryStructureBean [cmp_id=" + cmp_id + ", cmp_basic=" + cmp_basic + ", cmp_hra=" + cmp_hra
				+ ", cmp_ta=" + cmp_ta + ", cmp_pf=" + cmp_pf + ", cmp_mr=" + cmp_mr + ", cmp_esic=" + cmp_esic
				+ ", cmp_pt=" + cmp_pt + ", cmp_da=" + cmp_da + "]";
	}
	
	
	
	
}
