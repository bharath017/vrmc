package com.willka.soft.dao;

import java.util.ArrayList;
import java.util.HashMap;

public interface BatchingDAO {
	
	public ArrayList<String> getAllCustomerList()throws Exception;
	
	public int countTotalBatchingCount(String from_date,
			String to_date,String customer_name)throws Exception;
	
	public ArrayList<HashMap<String, Object>> getBatchingList(String from_date,
			String to_date,String customer_name,int start,int length)throws Exception;
	
	public HashMap<String, Object> getTotalQuantityOfStockToday()throws Exception;
	
	public HashMap<String, Object> getSingleTripDetails(int BatchID)throws Exception;
	
	public ArrayList<HashMap<String, Object>> getSingleBatchListDetails(int BatchID)throws Exception;
	
	
	
	

}
