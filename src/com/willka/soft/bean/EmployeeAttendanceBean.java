package com.willka.soft.bean;

public class EmployeeAttendanceBean {

	private int attendance_id;
	private int e_id;
	private String attendance_date;
	private String start_time;
	private String end_time;
	private String status;
	private String timestamp;
	private int user_id;
	private String description;
	
	public int getAttendance_id() {
		return attendance_id;
	}
	public void setAttendance_id(int attendance_id) {
		this.attendance_id = attendance_id;
	}
	public int getE_id() {
		return e_id;
	}
	public void setE_id(int e_id) {
		this.e_id = e_id;
	}
	public String getAttendance_date() {
		return attendance_date;
	}
	public void setAttendance_date(String attendance_date) {
		this.attendance_date = attendance_date;
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
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getTimestamp() {
		return timestamp;
	}
	public void setTimestamp(String timestamp) {
		this.timestamp = timestamp;
	}
	public int getUser_id() {
		return user_id;
	}
	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	@Override
	public String toString() {
		return "EmployeeAttendanceBean [attendance_id=" + attendance_id + ", e_id=" + e_id + ", attendance_date="
				+ attendance_date + ", start_time=" + start_time + ", end_time=" + end_time + ", status=" + status
				+ ", timestamp=" + timestamp + ", user_id=" + user_id + ", description=" + description + "]";
	}
	
}
