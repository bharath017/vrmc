package com.willka.soft.dao;

import java.util.ArrayList;

import com.willka.soft.bean.DriverBean;

public interface DriverDAO {

	
	public int insertDriverDetail(DriverBean bean)throws Exception;
	
	public int updateDriverDetail(DriverBean bean)throws Exception;
	
	public int deleteDriverDetail(int driver_id)throws Exception;
	
	public DriverBean getSingleDriverDetail(int driver_id)throws Exception;
	
	public ArrayList<DriverBean> getAllDriverList()throws Exception;
	
	public int insertAddPumpDG(String type,String pump_name)throws Exception;
	
	public int updateAddPumpDG(int pump_id,String type,String pump_name)throws Exception;
	
	public int deletePumpDG(int pump_id)throws Exception;
	
}
