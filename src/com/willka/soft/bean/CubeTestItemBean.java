package com.willka.soft.bean;

public class CubeTestItemBean {

	private int tst_item_id;
	private int tst_id;
	private double mass1;
	private double mass2;
	private double mass3;
	private double maxld1;
	private double maxld2;
	private double maxld3;
	private String cube_id;
	public int getTst_item_id() {
		return tst_item_id;
	}
	public void setTst_item_id(int tst_item_id) {
		this.tst_item_id = tst_item_id;
	}
	public int getTst_id() {
		return tst_id;
	}
	public void setTst_id(int tst_id) {
		this.tst_id = tst_id;
	}
	public double getMass1() {
		return mass1;
	}
	public void setMass1(double mass1) {
		this.mass1 = mass1;
	}
	public double getMass2() {
		return mass2;
	}
	public void setMass2(double mass2) {
		this.mass2 = mass2;
	}
	public double getMass3() {
		return mass3;
	}
	public void setMass3(double mass3) {
		this.mass3 = mass3;
	}
	public double getMaxld1() {
		return maxld1;
	}
	public void setMaxld1(double maxld1) {
		this.maxld1 = maxld1;
	}
	public double getMaxld2() {
		return maxld2;
	}
	public void setMaxld2(double maxld2) {
		this.maxld2 = maxld2;
	}
	public double getMaxld3() {
		return maxld3;
	}
	public void setMaxld3(double maxld3) {
		this.maxld3 = maxld3;
	}
	public String getCube_id() {
		return cube_id;
	}
	public void setCube_id(String cube_id) {
		this.cube_id = cube_id;
	}
	@Override
	public String toString() {
		return "CubeTestItemBean [tst_item_id=" + tst_item_id + ", tst_id=" + tst_id + ", mass1=" + mass1 + ", mass2="
				+ mass2 + ", mass3=" + mass3 + ", maxld1=" + maxld1 + ", maxld2=" + maxld2 + ", maxld3=" + maxld3 + "]";
	}
}
