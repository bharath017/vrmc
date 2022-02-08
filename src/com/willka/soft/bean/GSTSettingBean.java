package com.willka.soft.bean;

import java.io.Serializable;

public class GSTSettingBean implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 981L;
	private float cgst;
	private float sgst;
	private float igst;
	
	public float getCgst() {
		return cgst;
	}
	public void setCgst(float cgst) {
		this.cgst = cgst;
	}
	public float getSgst() {
		return sgst;
	}
	public void setSgst(float sgst) {
		this.sgst = sgst;
	}
	public float getIgst() {
		return igst;
	}
	public void setIgst(float igst) {
		this.igst = igst;
	}
	
	
	@Override
	public String toString() {
		return "GSTSettingBean [cgst=" + cgst + ", sgst=" + sgst + ", igst=" + igst + "]";
	}
	

}
