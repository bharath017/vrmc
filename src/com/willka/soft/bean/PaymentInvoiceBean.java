package com.willka.soft.bean;

import java.io.Serializable;

public class PaymentInvoiceBean implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int id;
	private int invoice_id;
	private int payment_id;
	private Double amount;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getInvoice_id() {
		return invoice_id;
	}
	public void setInvoice_id(int invoice_id) {
		this.invoice_id = invoice_id;
	}
	public int getPayment_id() {
		return payment_id;
	}
	public void setPayment_id(int payment_id) {
		this.payment_id = payment_id;
	}
	public Double getAmount() {
		return amount;
	}
	public void setAmount(Double amount) {
		this.amount = amount;
	}
	@Override
	public String toString() {
		return "PaymentInvoiceBean [id=" + id + ", invoice_id=" + invoice_id + ", payment_id=" + payment_id
				+ ", amount=" + amount + "]";
	}
	
	
	

}
