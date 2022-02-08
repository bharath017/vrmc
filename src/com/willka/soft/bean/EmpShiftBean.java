package com.willka.soft.bean;

public class EmpShiftBean {
	
	private int shift_id;
	private String shift_name;
	private String start_time;
	private String end_time;
	public int getShift_id() {
		return shift_id;
	}
	public void setShift_id(int shift_id) {
		this.shift_id = shift_id;
	}
	public String getShift_name() {
		return shift_name;
	}
	public void setShift_name(String shift_name) {
		this.shift_name = shift_name;
	}
	public String getStart_time() {
		return start_time;
	}
	public void setStart_time(String start_time) {
		this.start_time = start_time;
	}
	public String getEnd_time() {
		return end_time;
	}
	public void setEnd_time(String end_time) {
		this.end_time = end_time;
	}
	@Override
	public String toString() {
		return "EmpShiftBean [shift_id=" + shift_id + ", shift_name=" + shift_name + ", start_time=" + start_time
				+ ", end_time=" + end_time + "]";
	}

}
