package com.willka.soft.dao;

import com.willka.soft.bean.VehicleRepairBean;

public interface RepairDAO {

	
	public int insertRepair(VehicleRepairBean bean)throws Exception;
	
	public int updateRepair(VehicleRepairBean bean)throws Exception;
	
	public int deleteRepair(int bean)throws Exception;
	
}
