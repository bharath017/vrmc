package com.willka.soft.bean;

public class MoistureCorrectionBean {

	private float aggr1_moi;
	private float aggr2_moi;
	private float aggr3_moi;
	private float aggr4_moi;
	private float aggr1_abs;
	private float aggr2_abs;
	private float aggr3_abs;
	private float aggr4_abs;
	private int plant_id;
	
	
	public float getAggr1_moi() {
		return aggr1_moi;
	}
	public void setAggr1_moi(float aggr1_moi) {
		this.aggr1_moi = aggr1_moi;
	}
	public float getAggr2_moi() {
		return aggr2_moi;
	}
	public void setAggr2_moi(float aggr2_moi) {
		this.aggr2_moi = aggr2_moi;
	}
	public float getAggr3_moi() {
		return aggr3_moi;
	}
	public void setAggr3_moi(float aggr3_moi) {
		this.aggr3_moi = aggr3_moi;
	}
	public float getAggr4_moi() {
		return aggr4_moi;
	}
	public void setAggr4_moi(float aggr4_moi) {
		this.aggr4_moi = aggr4_moi;
	}
	public float getAggr1_abs() {
		return aggr1_abs;
	}
	public void setAggr1_abs(float aggr1_abs) {
		this.aggr1_abs = aggr1_abs;
	}
	public float getAggr2_abs() {
		return aggr2_abs;
	}
	public void setAggr2_abs(float aggr2_abs) {
		this.aggr2_abs = aggr2_abs;
	}
	public float getAggr3_abs() {
		return aggr3_abs;
	}
	public void setAggr3_abs(float aggr3_abs) {
		this.aggr3_abs = aggr3_abs;
	}
	public float getAggr4_abs() {
		return aggr4_abs;
	}
	public void setAggr4_abs(float aggr4_abs) {
		this.aggr4_abs = aggr4_abs;
	}
	public int getPlant_id() {
		return plant_id;
	}
	public void setPlant_id(int plant_id) {
		this.plant_id = plant_id;
	}
	@Override
	public String toString() {
		return "MoistureCorrectionBean [aggr1_moi=" + aggr1_moi + ", aggr2_moi=" + aggr2_moi + ", aggr3_moi="
				+ aggr3_moi + ", aggr4_moi=" + aggr4_moi + ", aggr1_abs=" + aggr1_abs + ", aggr2_abs=" + aggr2_abs
				+ ", aggr3_abs=" + aggr3_abs + ", aggr4_abs=" + aggr4_abs + ", plant_id=" + plant_id + "]";
	}
	
}
