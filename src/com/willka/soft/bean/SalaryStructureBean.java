package com.willka.soft.bean;

public class SalaryStructureBean {

	private int e_id;
	private double basic_pay;
	private double hra;
	private double da;
	private double other;
	private double pf;
	private double esic;
	private double prof_tax;
	private double tds;
	
	public int getE_id() {
		return e_id;
	}
	public void setE_id(int e_id) {
		this.e_id = e_id;
	}
	public double getBasic_pay() {
		return basic_pay;
	}
	public void setBasic_pay(double basic_pay) {
		this.basic_pay = basic_pay;
	}
	public double getHra() {
		return hra;
	}
	public void setHra(double hra) {
		this.hra = hra;
	}
	public double getDa() {
		return da;
	}
	public void setDa(double da) {
		this.da = da;
	}
	public double getOther() {
		return other;
	}
	public void setOther(double other) {
		this.other = other;
	}
	public double getPf() {
		return pf;
	}
	public void setPf(double pf) {
		this.pf = pf;
	}
	public double getEsic() {
		return esic;
	}
	public void setEsic(double esic) {
		this.esic = esic;
	}
	public double getProf_tax() {
		return prof_tax;
	}
	public void setProf_tax(double prof_tax) {
		this.prof_tax = prof_tax;
	}
	public double getTds() {
		return tds;
	}
	public void setTds(double tds) {
		this.tds = tds;
	}
	@Override
	public String toString() {
		return "SalaryStructureBean [e_id=" + e_id + ", basic_pay=" + basic_pay + ", hra=" + hra + ", da=" + da
				+ ", other=" + other + ", pf=" + pf + ", esic=" + esic + ", prof_tax=" + prof_tax + ", tds=" + tds
				+ "]";
	}
}
