package com.willka.soft.bean;

public class PlantDeliveryAddressBean {

	private  int pl_delivery_address_id;
	private int plant_id;
	private String delivery_address;
	private String status;
	
	
	public int getPl_delivery_address_id() {
		return pl_delivery_address_id;
	}
	public void setPl_delivery_address_id(int pl_delivery_address_id) {
		this.pl_delivery_address_id = pl_delivery_address_id;
	}
	public int getPlant_id() {
		return plant_id;
	}
	public void setPlant_id(int plant_id) {
		this.plant_id = plant_id;
	}
	public String getDelivery_address() {
		return delivery_address;
	}
	public void setDelivery_address(String delivery_address) {
		this.delivery_address = delivery_address;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	
	
	@Override
	public String toString() {
		return "PlantDeliveryAddressBean [pl_delivery_address_id=" + pl_delivery_address_id + ", plant_id=" + plant_id
				+ ", delivery_address=" + delivery_address + ", status=" + status + "]";
	}
	
}
