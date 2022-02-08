package com.willka.soft.bean;

public class PipelineBean {
	
	private int pipe_id;
	private String unit;
	private String bdm;
	private String customer_id;
	private int total_volume;
	private int period_month;
	private int vol_month;
	private String target_date;
	private String remark_as;
	private String status;
	public int getPipe_id() {
		return pipe_id;
	}
	public void setPipe_id(int pipe_id) {
		this.pipe_id = pipe_id;
	}
	public String getUnit() {
		return unit;
	}
	public void setUnit(String unit) {
		this.unit = unit;
	}
	public String getBdm() {
		return bdm;
	}
	public void setBdm(String bdm) {
		this.bdm = bdm;
	}
	public String getCustomer_id() {
		return customer_id;
	}
	public void setCustomer_id(String customer_id) {
		this.customer_id = customer_id;
	}
	public int getTotal_volume() {
		return total_volume;
	}
	public void setTotal_volume(int total_volume) {
		this.total_volume = total_volume;
	}
	public int getPeriod_month() {
		return period_month;
	}
	public void setPeriod_month(int period_month) {
		this.period_month = period_month;
	}
	public int getVol_month() {
		return vol_month;
	}
	public void setVol_month(int vol_month) {
		this.vol_month = vol_month;
	}
	public String getTarget_date() {
		return target_date;
	}
	public void setTarget_date(String target_date) {
		this.target_date = target_date;
	}
	public String getRemark_as() {
		return remark_as;
	}
	public void setRemark_as(String remark_as) {
		this.remark_as = remark_as;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	@Override
	public String toString() {
		return "PipelineBean [pipe_id=" + pipe_id + ", unit=" + unit + ", bdm=" + bdm + ", customer_id=" + customer_id
				+ ", total_volume=" + total_volume + ", period_month=" + period_month + ", vol_month=" + vol_month
				+ ", target_date=" + target_date + ", remark_as=" + remark_as + ", status=" + status + "]";
	}
	
	
	
	
	
	

}
