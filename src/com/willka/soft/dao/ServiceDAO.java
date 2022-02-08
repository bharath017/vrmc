package com.willka.soft.dao;

import com.willka.soft.bean.ServiceBean;

public interface ServiceDAO {
	
	public int insertService(ServiceBean bean)throws Exception;
	
	public ServiceBean getLastServiceDetailsByVehicle(String vehicle_no) throws Exception;
	
	public int updateService(ServiceBean bean)throws Exception;
	
	public int deleteService(int bean)throws Exception;

}
