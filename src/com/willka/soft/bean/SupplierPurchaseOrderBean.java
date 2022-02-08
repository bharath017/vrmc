package com.willka.soft.bean;

public class SupplierPurchaseOrderBean {

	private int supplier_purchase_order_id;
	private String purchase_order_date;
	private String required_date;
	private String payment_term;
	private String description;
	private int supplier_id;
	private String gst_type;
	private float gst_percentage;
	private String order_validity;
	private String receiver_name;
	private String receiver_phone;
	private String receiver_email;
	private String quotation_no;
	private double discount;
	private String discount_type;
	private double pf_percent;
	private int plant_id;
	private String terms;
	private int order_no;
	private int start_year;
	private int end_year;
	private int pl_delivery_address_id;
	
	
	
	public int getSupplier_purchase_order_id() {
		return supplier_purchase_order_id;
	}
	public void setSupplier_purchase_order_id(int supplier_purchase_order_id) {
		this.supplier_purchase_order_id = supplier_purchase_order_id;
	}
	public String getPurchase_order_date() {
		return purchase_order_date;
	}
	public void setPurchase_order_date(String purchase_order_date) {
		this.purchase_order_date = purchase_order_date;
	}
	public String getRequired_date() {
		return required_date;
	}
	public void setRequired_date(String required_date) {
		this.required_date = required_date;
	}
	public String getPayment_term() {
		return payment_term;
	}
	public void setPayment_term(String payment_term) {
		this.payment_term = payment_term;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public int getSupplier_id() {
		return supplier_id;
	}
	public void setSupplier_id(int supplier_id) {
		this.supplier_id = supplier_id;
	}
	public String getGst_type() {
		return gst_type;
	}
	public void setGst_type(String gst_type) {
		this.gst_type = gst_type;
	}
	public float getGst_percentage() {
		return gst_percentage;
	}
	public void setGst_percentage(float gst_percentage) {
		this.gst_percentage = gst_percentage;
	}
	public String getOrder_validity() {
		return order_validity;
	}
	public void setOrder_validity(String order_validity) {
		this.order_validity = order_validity;
	}
	public String getReceiver_name() {
		return receiver_name;
	}
	public void setReceiver_name(String receiver_name) {
		this.receiver_name = receiver_name;
	}
	public String getReceiver_phone() {
		return receiver_phone;
	}
	public void setReceiver_phone(String receiver_phone) {
		this.receiver_phone = receiver_phone;
	}
	public String getReceiver_email() {
		return receiver_email;
	}
	public void setReceiver_email(String receiver_email) {
		this.receiver_email = receiver_email;
	}
	public String getQuotation_no() {
		return quotation_no;
	}
	public void setQuotation_no(String quotation_no) {
		this.quotation_no = quotation_no;
	}
	public double getDiscount() {
		return discount;
	}
	public void setDiscount(double discount) {
		this.discount = discount;
	}
	public String getDiscount_type() {
		return discount_type;
	}
	public void setDiscount_type(String discount_type) {
		this.discount_type = discount_type;
	}
	public double getPf_percent() {
		return pf_percent;
	}
	public void setPf_percent(double pf_percent) {
		this.pf_percent = pf_percent;
	}
	public String getTerms() {
		return terms;
	}
	public void setTerms(String terms) {
		this.terms = terms;
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
	public int getPl_delivery_address_id() {
		return pl_delivery_address_id;
	}
	public void setPl_delivery_address_id(int pl_delivery_address_id) {
		this.pl_delivery_address_id = pl_delivery_address_id;
	}
	
	@Override
	public String toString() {
		return "SupplierPurchaseOrderBean [supplier_purchase_order_id=" + supplier_purchase_order_id
				+ ", purchase_order_date=" + purchase_order_date + ", required_date=" + required_date
				+ ", payment_term=" + payment_term + ", description=" + description + ", supplier_id=" + supplier_id
				+ ", gst_type=" + gst_type + ", gst_percentage=" + gst_percentage + ", order_validity=" + order_validity
				+ ", receiver_name=" + receiver_name + ", receiver_phone=" + receiver_phone + ", receiver_email="
				+ receiver_email + ", quotation_no=" + quotation_no + ", discount=" + discount + ", discount_type="
				+ discount_type + ", pf_percent=" + pf_percent + ", plant_id=" + plant_id + ", terms=" + terms + "]";
	}
	
	
	
	
	
}
