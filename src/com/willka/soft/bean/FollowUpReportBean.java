package com.willka.soft.bean;

import java.io.Serializable;

public class FollowUpReportBean implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private double phone;
	private String client;
	private int follow_up_report_id;
	private String date;
	private String time;
	private String description;
	private String comment;
	private String status;
	private Double amount;
	private String type;
	private String follow_up_date;
	
	
	public String getFollow_up_date() {
		return follow_up_date;
	}
	public void setFollow_up_date(String follow_up_date) {
		this.follow_up_date = follow_up_date;
	}
	public Double getAmount() {
		return amount;
	}
	public void setAmount(Double amount) {
		this.amount = amount;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public double getPhone() {
		return phone;
	}
	public void setPhone(double phone) {
		this.phone = phone;
	}
	public String getClient() {
		return client;
	}
	public void setClient(String client) {
		this.client = client;
	}
	public int getFollow_up_report_id() {
		return follow_up_report_id;
	}
	public void setFollow_up_report_id(int follow_up_report_id) {
		this.follow_up_report_id = follow_up_report_id;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	
	@Override
	public String toString() {
		return "FollowUpReportBean [phone=" + phone + ", client=" + client + ", follow_up_report_id="
				+ follow_up_report_id + ", date=" + date + ", time=" + time + ", description=" + description
				+ ", comment=" + comment + ", status=" + status + ", amount=" + amount + ", type=" + type
				+ ", follow_up_date=" + follow_up_date + "]";
	}
	
}
