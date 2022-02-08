package com.willka.soft.dao;

import java.util.List;
import java.util.Map;

import com.willka.soft.bean.TicketBean;

public interface TicketDAO {
	public int insertTicketDetails(TicketBean bean)throws Exception;
	
	public int updateTicketDetails(TicketBean bean)throws Exception;
	
	public int getMaxTicketAccordingPlant(int plant_id,String ticket_type)throws Exception;
	
	public int cancelTicketDetails(int t_id)throws Exception;
	
	
	public List<Map<String,Object>> getTicketList(String search,int plant_id,int business_id,int start,int length)throws Exception;
	
	public int countTicketList(String search, int plant_id, int business_id)throws Exception;
	
}

