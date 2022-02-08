package com.willka.soft.bean;

import java.io.Serializable;

public class FleetOutgoingBean implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1232L;
	
	private int fleet_outgoing_id;
	private String issued_date;
	private String issued_time;
	private String received_person;
	private String returnable;
	private String return_status;
	private String outgoing_comment;
	private String added_timestamp;
	private int plant_id;
	
	
	
	public int getFleet_outgoing_id() {
		return fleet_outgoing_id;
	}
	public void setFleet_outgoing_id(int fleet_outgoing_id) {
		this.fleet_outgoing_id = fleet_outgoing_id;
	}
	public String getIssued_date() {
		return issued_date;
	}
	public void setIssued_date(String issued_date) {
		this.issued_date = issued_date;
	}
	public String getIssued_time() {
		return issued_time;
	}
	public void setIssued_time(String issued_time) {
		this.issued_time = issued_time;
	}
	public String getReceived_person() {
		return received_person;
	}
	public void setReceived_person(String received_person) {
		this.received_person = received_person;
	}
	public String getReturnable() {
		return returnable;
	}
	public void setReturnable(String returnable) {
		this.returnable = returnable;
	}
	public String getReturn_status() {
		return return_status;
	}
	public void setReturn_status(String return_status) {
		this.return_status = return_status;
	}
	public String getOutgoing_comment() {
		return outgoing_comment;
	}
	public void setOutgoing_comment(String outgoing_comment) {
		this.outgoing_comment = outgoing_comment;
	}
	public String getAdded_timestamp() {
		return added_timestamp;
	}
	public void setAdded_timestamp(String added_timestamp) {
		this.added_timestamp = added_timestamp;
	}
	public int getPlant_id() {
		return plant_id;
	}
	public void setPlant_id(int plant_id) {
		this.plant_id = plant_id;
	}
	
	@Override
	public String toString() {
		return "FleetOutgoingBean [fleet_outgoing_id=" + fleet_outgoing_id + ", issued_date=" + issued_date
				+ ", issued_time=" + issued_time + ", received_person=" + received_person + ", returnable=" + returnable
				+ ", return_status=" + return_status + ", outgoing_comment=" + outgoing_comment + ", added_timestamp="
				+ added_timestamp + "]";
	}
	
	
	

}
