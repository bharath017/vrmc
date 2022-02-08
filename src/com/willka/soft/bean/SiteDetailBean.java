package com.willka.soft.bean;

public class SiteDetailBean {

	private int  site_id;
	private String site_name;
	private String site_address;
	private String tally_ladger;
	private int customer_id;
	
	
	public int getSite_id() {
		return site_id;
	}
	public void setSite_id(int site_id) {
		this.site_id = site_id;
	}
	public String getSite_name() {
		return site_name;
	}
	public void setSite_name(String site_name) {
		this.site_name = site_name;
	}
	public String getSite_address() {
		return site_address;
	}
	public void setSite_address(String site_address) {
		this.site_address = site_address;
	}
	public String getTally_ladger() {
		return tally_ladger;
	}
	public void setTally_ladger(String tally_ladger) {
		this.tally_ladger = tally_ladger;
	}
	public int getCustomer_id() {
		return customer_id;
	}
	public void setCustomer_id(int customer_id) {
		this.customer_id = customer_id;
	}
	
	
	@Override
	public String toString() {
		return "SiteDetailBean [site_id=" + site_id + ", site_name=" + site_name + ", site_address=" + site_address
				+ ", tally_ladger=" + tally_ladger + "]";
	}
	
	
}
