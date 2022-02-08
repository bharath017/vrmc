package com.willka.soft.test.dao;

import java.util.List; 
import java.util.Map;

import com.willka.soft.test.bean.Inventory;
import com.willka.soft.test.bean.InventoryItemBean;
import com.willka.soft.test.bean.InventoryItemModification;
import com.willka.soft.test.bean.InventoryModificationBean;
import com.willka.soft.test.bean.InventoryStockBean;



public interface InventoryDAO {
	
	
	public int insertInventoryItem(String inventory_name,String stock_unit)throws Exception;
	
	public int updateInventoryItem(String inventory_name,int inv_item_id,String stock_unit)throws Exception;
	
	public int deleteInventoryItem(int inv_item_id) throws Exception;
	
	public int insertInventoryStock(InventoryStockBean bean)throws Exception;
	
	public InventoryStockBean getStockDetails(int inv_item_id,int plant_id)throws Exception;
	
	public int updateInventoryStock(InventoryStockBean bean)throws Exception;
	
	public String getItemUnitName(int inv_item_id)throws Exception;
	
	public Inventory getSingleInventoryDetails(int inventory_id)throws Exception;
	
	public int changeStockQuantity(int stock_id,double stock_quantity)throws Exception;
	
	public Map<Integer,String> getInventoryItemList()throws Exception;
	
	
	public int changeInventoryItemQuantity(int inv_item_id,double item_quantity)throws Exception;
	
	public InventoryItemBean getSingleInventoryItemDetails(int inv_item_id)throws Exception;
	
	public int insertInventoryItemModification(InventoryItemModification bean)throws Exception;
	
	public int changeInventoryItemStatus(int inv_item_id,String status)throws Exception;
	
	public int insertInventory(Inventory bean)throws Exception;
	
	public int updateInventory(Inventory bean)throws Exception;
	
	public int cancelInventory(int inventory_id)throws Exception;
	
	public int deleteInventory(int inventory_id)throws Exception;
	
	
	
	public int CancelInventoryItem(int inv_item_id) throws Exception ;
	
	public int CancelInventory(int inventory_id, String status) throws Exception ;
	
	
	public int insertInventoryModification(InventoryModificationBean bean)throws Exception;
	
	public int changeInventoryQuantity(int inventory_id, double empty_quantity,double loaded_quantity,double net_weight) throws Exception;
	
	public int insertInventoryVehicle(String  vehicle_no)throws Exception;
	
	public int updateLoadedWeight(String vehicle_no,double loaded_weight)throws Exception;
	
	public double getLoadedWeight(String vehicle_no)throws Exception;
	
	//REPORT PART
	
	public List<Map<String,Object>> getDatewiseReport(String from_date,String to_date,
			int supplier_id,int inventory_id,int plant_id, int business_id)throws Exception;
	
	public List<Map<String,Object>> supplierwithDatewiseReport(String from_date,String to_date,
			int supplier_id,int item_id,int plant_id,int business_id)throws Exception;
	
	public List<Map<String,Object>> getStockReport(String from_date, String to_date,
			int inv_item_id, int plant_id)throws Exception;

	public List<Map<String,Object>> getDateWithItemGroupWiseReport(String from_date,
			String to_date, int inv_item_id, int plant_id)throws Exception;
	
	public List<Map<String,Object>> getSupplierWithItemWiseReport(int inv_item_id, int supplier_id, int plant_id)throws Exception;
	
	public List<Map<String,Object>> getSupplierWithDateWiseItemReport(String from_date,
			String to_date, int inv_item_id, int supplier_id, int plant_id)throws Exception;
	
	
	
	
}
