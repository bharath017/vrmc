package com.willka.soft.bean;

import java.io.Serializable;

public class EmployeeSalaryStructureBean implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1758L;
	
	private int e_id;
	private int emp_salary_id;
	private String employee_id;
	private String employee_name;
	private double employee_basic;
	private double employee_hra;
	private double employee_ta;
	private double employee_pf;
	private double employee_mr;
	private double employee_esic;
	private double employee_pt;
	private double employee_da;
	private String employee_month;
	
	private double advance_salary;
	private double total_earnings;
	private double total_deducations;
	public int getE_id() {
		return e_id;
	}
	public void setE_id(int e_id) {
		this.e_id = e_id;
	}
	public int getEmp_salary_id() {
		return emp_salary_id;
	}
	public void setEmp_salary_id(int emp_salary_id) {
		this.emp_salary_id = emp_salary_id;
	}
	public String getEmployee_id() {
		return employee_id;
	}
	public void setEmployee_id(String employee_id) {
		this.employee_id = employee_id;
	}
	public String getEmployee_name() {
		return employee_name;
	}
	public void setEmployee_name(String employee_name) {
		this.employee_name = employee_name;
	}
	public double getEmployee_basic() {
		return employee_basic;
	}
	public void setEmployee_basic(double employee_basic) {
		this.employee_basic = employee_basic;
	}
	public double getEmployee_hra() {
		return employee_hra;
	}
	public void setEmployee_hra(double employee_hra) {
		this.employee_hra = employee_hra;
	}
	public double getEmployee_ta() {
		return employee_ta;
	}
	public void setEmployee_ta(double employee_ta) {
		this.employee_ta = employee_ta;
	}
	public double getEmployee_pf() {
		return employee_pf;
	}
	public void setEmployee_pf(double employee_pf) {
		this.employee_pf = employee_pf;
	}
	public double getEmployee_mr() {
		return employee_mr;
	}
	public void setEmployee_mr(double employee_mr) {
		this.employee_mr = employee_mr;
	}
	public double getEmployee_esic() {
		return employee_esic;
	}
	public void setEmployee_esic(double employee_esic) {
		this.employee_esic = employee_esic;
	}
	public double getEmployee_pt() {
		return employee_pt;
	}
	public void setEmployee_pt(double employee_pt) {
		this.employee_pt = employee_pt;
	}
	public double getEmployee_da() {
		return employee_da;
	}
	public void setEmployee_da(double employee_da) {
		this.employee_da = employee_da;
	}
	public String getEmployee_month() {
		return employee_month;
	}
	public void setEmployee_month(String employee_month) {
		this.employee_month = employee_month;
	}
	public double getAdvance_salary() {
		return advance_salary;
	}
	public void setAdvance_salary(double advance_salary) {
		this.advance_salary = advance_salary;
	}
	public double getTotal_earnings() {
		return total_earnings;
	}
	public void setTotal_earnings(double total_earnings) {
		this.total_earnings = total_earnings;
	}
	public double getTotal_deducations() {
		return total_deducations;
	}
	public void setTotal_deducations(double total_deducations) {
		this.total_deducations = total_deducations;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	@Override
	public String toString() {
		return "EmployeeSalaryStructureBean [e_id=" + e_id + ", emp_salary_id=" + emp_salary_id + ", employee_id="
				+ employee_id + ", employee_name=" + employee_name + ", employee_basic=" + employee_basic
				+ ", employee_hra=" + employee_hra + ", employee_ta=" + employee_ta + ", employee_pf=" + employee_pf
				+ ", employee_mr=" + employee_mr + ", employee_esic=" + employee_esic + ", employee_pt=" + employee_pt
				+ ", employee_da=" + employee_da + ", employee_month=" + employee_month + ", advance_salary="
				+ advance_salary + ", total_earnings=" + total_earnings + ", total_deducations=" + total_deducations
				+ "]";
	}
	
	
	
	
	
	

}
