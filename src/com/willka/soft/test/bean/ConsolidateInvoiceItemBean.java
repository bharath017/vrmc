package com.willka.soft.test.bean;

public class ConsolidateInvoiceItemBean {

	private int c_id;
	private int consolidate_invoice_id;
	private int id;
	
	public int getC_id() {
		return c_id;
	}
	public void setC_id(int c_id) {
		this.c_id = c_id;
	}
	public int getConsolidate_invoice_id() {
		return consolidate_invoice_id;
	}
	public void setConsolidate_invoice_id(int consolidate_invoice_id) {
		this.consolidate_invoice_id = consolidate_invoice_id;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	
	
	@Override
	public String toString() {
		return "ConsolidateInvoiceItemBean [c_id=" + c_id + ", consolidate_invoice_id=" + consolidate_invoice_id
				+ ", id=" + id + "]";
	}
	
	
	
}
