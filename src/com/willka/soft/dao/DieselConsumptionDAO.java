package com.willka.soft.dao;

import com.willka.soft.bean.DieselConsumptionBean;
import com.willka.soft.bean.DieselModificationBean;

public interface DieselConsumptionDAO {
	
	public int insertDieselConsumption(DieselConsumptionBean bean)throws Exception;
	
	public DieselConsumptionBean getLastConsumptionDetailsByVehicle(String vehicle_no)throws Exception;
	
	public int insertdieselModificationDetails(DieselModificationBean bean)throws Exception;
	
	public DieselConsumptionBean getSingleDeiselDetailsByDieselId(int diesel_id)throws Exception;
	
	public int updateDieselConsumption(DieselConsumptionBean bean)throws Exception;
	
	public int deleteDieselConsumption(int diesel_id)throws Exception;
	
	
	
	
}
