package com.willka.soft.test.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.willka.soft.test.bean.SchedulingBean;
import com.willka.soft.test.bean.SchedulingItemBean;

public interface SchedulingDAO {
	
	public int insertScheduling(SchedulingBean bean)throws Exception;
	
	public int updateScheduling(SchedulingBean bean)throws Exception;
	
	public int insertSchedulingItem(SchedulingItemBean bean)throws Exception;
	
	public int updateSchedulingItem(SchedulingItemBean bean)throws Exception;
	
	//new code goes here
	
	ArrayList<HashMap<String, Object>> getGradeForSchedule(int site_id,int plant_id)throws Exception;
	
	public int  checkIfSchedulingIsExist(int site_id,
			int plant_id,String scheduling_date)throws Exception;
	
	public ArrayList<HashMap<String, Object>> getAllExistScheduleGrade(int scheduling_id)throws Exception;
	
	public int getMaxOfSchedulingId()throws Exception;
	
	public int deleteSchedulingItemDetails(int product_id,int scheduling_id)throws Exception;
	
	public ArrayList<HashMap<String, Object>> getAllSchedulingList(String scheduling_date,
			int customer_id,int site_id,int start,int length)throws Exception;
	
	public int countAllSchedulingList(String scheduling_date,int customer_id,int site_id)throws Exception;
	
	public ArrayList<HashMap<String, Object>> getScheduledInvoiceDetails(int scheduling_id)throws Exception;
	
	public int deleteSchedulingDetails(int scheduling_id)throws Exception;
	
	public HashMap<String, Object> getScheduleDashBoard()throws Exception;
	
	public double getScheduledQuantityOfPerticularProductId(int poi_id)throws Exception;
	
	
	
	
	
}
