package com.willka.soft.dao;

import java.util.List;
import java.util.Map;

import com.willka.soft.bean.InventoryOutgoingBean;
import com.willka.soft.bean.InventoryOutgoingItem;
import com.willka.soft.bean.StockBean;

public interface StockDAO {

	public int insertStockDAO(StockBean bean)throws Exception;
	
	public int updateStockDAO(StockBean bean)throws Exception;
	
	public int deleteClosingStock(int stock_id)throws Exception;
	
	public List<Map<String,Object>> getCurrentStock()throws Exception;
	
	public StockBean getSingleOpeningStock(int stock_id)throws Exception;
	
	public List<Map<String,Object>> getAllStockItemList()throws Exception;
	
	
	public int addInventoryOutgoing(InventoryOutgoingBean bean)throws Exception;
	
	public int updateInventoryOutgoing(InventoryOutgoingBean bean)throws Exception;
	
	public int addInventoryOutgoingForOnlyConsumption(InventoryOutgoingBean bean)throws Exception;
	
	public int getLastAddedOutgoinId()throws Exception;
	
	public int[] addInventoryOutgoingItem(List<InventoryOutgoingItem> list,
				int invout_id)throws Exception;
	
	public int[] updateInventoryOutogingItem(List<InventoryOutgoingItem> list)throws Exception;
	
	public List<Map<String,Object>> getGradeCompositionDetails(int product_id)throws Exception;
	
	public List<Map<String,Object>> getProductionList(int product_id,
				String from_date,String to_date,int plant_id,int start,int length)throws Exception;
	
	public int countProductionList(int product_id,String from_date, String to_date, int plant_id)throws Exception;
	
	public int deleteProductionDetails(int invout_id)throws Exception;
	
	public List<Map<String,Object>> getInventoryOutgoingList(String from_date,String to_date,
			int inv_item_id,int plant_id, int start,int length)throws Exception;
	
	public int countInventoryOutgoingList(String from_date, String to_date,int inv_item_id,int plant_id)throws Exception;
	
	public Map<String,Object> getConversionValueDetails(int product_id)throws Exception;
	
	//report part
	
	public List<Map<String,Object>> getDateWiseReportOfProductionReport(String from_date, String to_date, int product_id, int plant_id)throws Exception;
	
	public List<Map<String,Object>> getStockReport(String from_date, String to_date, int product_id, int plant_id)throws Exception;
	
	
	
}
