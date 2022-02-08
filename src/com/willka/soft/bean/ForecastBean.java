package com.willka.soft.bean;

import java.io.Serializable;

public class ForecastBean implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 15353L;
	
	private int forecast_id;
	private int plant_id;
	private int customer_id;
	private int site_id;
	private int mp_id;
	private Double project_quantity;
	private String date;
	private Double forecast_quantity;
	private Double week1_forecast;
	private Double week2_forecast;
	private Double week3_forecast;
	private Double week4_forecast;
	
	
	
	public int getMp_id() {
		return mp_id;
	}
	public void setMp_id(int mp_id) {
		this.mp_id = mp_id;
	}
	public Double getProject_quantity() {
		return project_quantity;
	}
	public void setProject_quantity(Double project_quantity) {
		this.project_quantity = project_quantity;
	}
	public int getForecast_id() {
		return forecast_id;
	}
	public void setForecast_id(int forecast_id) {
		this.forecast_id = forecast_id;
	}
	public int getPlant_id() {
		return plant_id;
	}
	public void setPlant_id(int plant_id) {
		this.plant_id = plant_id;
	}
	public int getCustomer_id() {
		return customer_id;
	}
	public void setCustomer_id(int customer_id) {
		this.customer_id = customer_id;
	}
	public int getSite_id() {
		return site_id;
	}
	public void setSite_id(int site_id) {
		this.site_id = site_id;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public Double getForecast_quantity() {
		return forecast_quantity;
	}
	public void setForecast_quantity(Double forecast_quantity) {
		this.forecast_quantity = forecast_quantity;
	}
	public Double getWeek1_forecast() {
		return week1_forecast;
	}
	public void setWeek1_forecast(Double week1_forecast) {
		this.week1_forecast = week1_forecast;
	}
	public Double getWeek2_forecast() {
		return week2_forecast;
	}
	public void setWeek2_forecast(Double week2_forecast) {
		this.week2_forecast = week2_forecast;
	}
	public Double getWeek3_forecast() {
		return week3_forecast;
	}
	public void setWeek3_forecast(Double week3_forecast) {
		this.week3_forecast = week3_forecast;
	}
	public Double getWeek4_forecast() {
		return week4_forecast;
	}
	public void setWeek4_forecast(Double week4_forecast) {
		this.week4_forecast = week4_forecast;
	}
	@Override
	public String toString() {
		return "ForecastBean [forecast_id=" + forecast_id + ", plant_id=" + plant_id + ", customer_id=" + customer_id
				+ ", site_id=" + site_id + ", mp_id=" + mp_id + ", project_quantity=" + project_quantity + ", date="
				+ date + ", forecast_quantity=" + forecast_quantity + ", week1_forecast=" + week1_forecast
				+ ", week2_forecast=" + week2_forecast + ", week3_forecast=" + week3_forecast + ", week4_forecast="
				+ week4_forecast + "]";
	}
	
	
	

}
