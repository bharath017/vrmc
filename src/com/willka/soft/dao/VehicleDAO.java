package com.willka.soft.dao;

import java.util.ArrayList;
import java.util.List;

import com.willka.soft.bean.VehiclesBean;

public interface VehicleDAO {

	public int insertVehicleDetail(VehiclesBean bean)throws Exception;
	
	public int updateVehicleDetail(VehiclesBean bean)throws Exception;
	
	public int deleteVehicleSingleVehicle(String vehicle_no)throws Exception;
	
	public List<String> getAllVehicleForOption()throws Exception;
	
	public ArrayList<VehiclesBean>  getAllVehicle()throws Exception;
	
	public ArrayList<VehiclesBean>  getOwnVehicle()throws Exception;
	
	public ArrayList<VehiclesBean>  getRentalVehicle()throws Exception;
	
	public VehiclesBean getVehicleDetailUsingVehicleNo(String vehicle_number)throws Exception;
	
	public int updateVehicleMeterReading(String vehicle_no,double meter_reading)throws Exception;
	
	public int updateEmptyWeight(String vehicle_no,double empty_weight)throws Exception;
	
	public int updateLoadedWeight(String vehicle_no,double loaded_weight)throws Exception;
	
	public double getEmptyWeight(String vehicle_no)throws Exception;
	
	public double getLoadedWeight(String vehicle_no)throws Exception;
	
	public int getLastTicketRised(String vehicle_no)throws Exception;
}
