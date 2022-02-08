package com.willka.soft.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.willka.soft.bean.SchedulingBean;
import com.willka.soft.bean.SchedulingItemBean;

public interface SchedulingDAO {
	
	public int insertScheduling(SchedulingBean bean)throws Exception;
	
	public int updateScheduling(SchedulingBean bean)throws Exception;
	
	public int insertSchedulingItem(SchedulingItemBean bean)throws Exception;
	
	public int updateSchedulingItem(SchedulingItemBean bean)throws Exception;
	
	public int getMaxSchedulingId()throws Exception;
	
	public ArrayList<SchedulingItemBean> getProductDetailsUsingSiteDate(int site_id,String date,int plant_id)throws Exception;
	
	public SchedulingBean getSchedulingDetails(int site_id,String date,int plant_id)throws Exception;
	
	public ArrayList<SchedulingItemBean> getSchedulingItems(int scheduling_id)throws Exception;
	
	public int deleteScheduling(int scheduling_id)throws Exception;
	
	public List<Map<String,Object>> getSchedulingList(String from_date, String to_date, int customer_id, int site_id, int start, int length)throws Exception;
	
	public int countSchedulingList(String from_date, String to_date, int customer_id,int site_id)throws Exception;
	
	public int changeSchedulingStatus(int scheduling_id, String schStatus)throws Exception;
}
