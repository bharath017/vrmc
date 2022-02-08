package com.willka.soft.bean;

public class IndentBean {

	private int indent_id;
	private String indent_date;
	private String required_date;
	private String indentor;
	private String designation;
	private String type;
	private int supplier_id;
	private int plant_id;
	private int order_no;
	private int start_year;
	private int end_year;
	private String budget_head;
	private String approved_by;
	private String checked_by;
	private String justification;
	
	
	public String getJustification() {
		return justification;
	}
	public void setJustification(String justification) {
		this.justification = justification;
	}
	public int getIndent_id() {
		return indent_id;
	}
	public void setIndent_id(int indent_id) {
		this.indent_id = indent_id;
	}
	public String getIndent_date() {
		return indent_date;
	}
	public void setIndent_date(String indent_date) {
		this.indent_date = indent_date;
	}
	public String getRequired_date() {
		return required_date;
	}
	public void setRequired_date(String required_date) {
		this.required_date = required_date;
	}
	public String getIndentor() {
		return indentor;
	}
	public void setIndentor(String indentor) {
		this.indentor = indentor;
	}
	public String getDesignation() {
		return designation;
	}
	public void setDesignation(String designation) {
		this.designation = designation;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public int getSupplier_id() {
		return supplier_id;
	}
	public void setSupplier_id(int supplier_id) {
		this.supplier_id = supplier_id;
	}
	public int getPlant_id() {
		return plant_id;
	}
	public void setPlant_id(int plant_id) {
		this.plant_id = plant_id;
	}
	public int getOrder_no() {
		return order_no;
	}
	public void setOrder_no(int order_no) {
		this.order_no = order_no;
	}
	public int getStart_year() {
		return start_year;
	}
	public void setStart_year(int start_year) {
		this.start_year = start_year;
	}
	public int getEnd_year() {
		return end_year;
	}
	public void setEnd_year(int end_year) {
		this.end_year = end_year;
	}
	public String getBudget_head() {
		return budget_head;
	}
	public void setBudget_head(String budget_head) {
		this.budget_head = budget_head;
	}
	public String getApproved_by() {
		return approved_by;
	}
	public void setApproved_by(String approved_by) {
		this.approved_by = approved_by;
	}
	public String getChecked_by() {
		return checked_by;
	}
	public void setChecked_by(String checked_by) {
		this.checked_by = checked_by;
	}
	@Override
	public String toString() {
		return "IndentBean [indent_id=" + indent_id + ", indent_date=" + indent_date + ", required_date="
				+ required_date + ", indentor=" + indentor + ", designation=" + designation + ", type=" + type
				+ ", supplier_id=" + supplier_id + ", plant_id=" + plant_id + ", order_no=" + order_no + ", start_year="
				+ start_year + ", end_year=" + end_year + ", budget_head=" + budget_head + ", approved_by="
				+ approved_by + ", checked_by=" + checked_by + ", justification=" + justification + "]";
	}
	
	
	
}
