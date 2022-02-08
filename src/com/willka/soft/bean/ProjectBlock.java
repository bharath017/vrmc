package com.willka.soft.bean;

public class ProjectBlock {

	private int block_id;
	private String block_name;
	private int site_id;
	
	
	public int getBlock_id() {
		return block_id;
	}
	public void setBlock_id(int block_id) {
		this.block_id = block_id;
	}
	public String getBlock_name() {
		return block_name;
	}
	public void setBlock_name(String block_name) {
		this.block_name = block_name;
	}
	public int getSite_id() {
		return site_id;
	}
	public void setSite_id(int site_id) {
		this.site_id = site_id;
	}
	@Override
	public String toString() {
		return "ProjectBlock [block_id=" + block_id + ", block_name=" + block_name + ", site_id=" + site_id + "]";
	}
}
