package com.willka.soft.bean;

import java.io.Serializable;

public class ForecastItemBean implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 15353L;
	
	private int forecast_id;
	private int forecast_item_id;
	private String forecast_date;
	private Double forecast_quantity;
	private String type;
	private Double average_c1;
	
	public int getForecast_id() {
		return forecast_id;
	}
	public void setForecast_id(int forecast_id) {
		this.forecast_id = forecast_id;
	}
	public int getForecast_item_id() {
		return forecast_item_id;
	}
	public void setForecast_item_id(int forecast_item_id) {
		this.forecast_item_id = forecast_item_id;
	}
	public String getForecast_date() {
		return forecast_date;
	}
	public void setForecast_date(String forecast_date) {
		this.forecast_date = forecast_date;
	}
	public Double getForecast_quantity() {
		return forecast_quantity;
	}
	public void setForecast_quantity(Double forecast_quantity) {
		this.forecast_quantity = forecast_quantity;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	
	
	
	public Double getAverage_c1() {
		return average_c1;
	}
	public void setAverage_c1(Double average_c1) {
		this.average_c1 = average_c1;
	}
	@Override
	public String toString() {
		return "ForecastItemBean [forecast_id=" + forecast_id + ", forecast_item_id=" + forecast_item_id
				+ ", forecast_date=" + forecast_date + ", forecast_quantity=" + forecast_quantity + ", type=" + type
				+ ", average_c1=" + average_c1 + "]";
	}
	

	
	
	

}
