package com.willka.soft.service;

import java.sql.SQLIntegrityConstraintViolationException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import com.google.gson.Gson;
import com.willka.soft.bean.InventoryOutgoingBean;
import com.willka.soft.bean.InventoryOutgoingItem;
import com.willka.soft.bean.StockBean;
import com.willka.soft.dao.StockDAOImpl;
import com.willka.soft.util.IndianDateFormater;

public class StockService {
	
	private StockDAOImpl dao=null;
	public StockService() {
		dao=new StockDAOImpl();
	}

	public boolean addStockService(StockBean bean) throws Exception{
		int count=0;
			count=dao.insertStockDAO(bean);
		return (count>0)?true:false;
	}
	
	
	public boolean updateclosingStock(StockBean bean)throws Exception {
		return (dao.updateStockDAO(bean)>0)?true:false;
	}
	
	public boolean deleteClosingStock(int stock_id)throws Exception {
		return (dao.deleteClosingStock(stock_id)>0)?true:false;
	}
	
	
	public List<Map<String,Object>> getGradeCompositionList(int product_id)
				throws Exception{
		return dao.getGradeCompositionDetails(product_id);
	}
	
	
	public boolean addProductionStock(InventoryOutgoingBean bean,List<InventoryOutgoingItem> list)throws Exception {
		bean.setDate(IndianDateFormater.
				converToIndianFormat(bean.getDate()));
		int count=0;
		if(bean.getType()==null || bean.getType().trim().equals(""))
			count=dao.addInventoryOutgoing(bean);
		else
			count=dao.addInventoryOutgoingForOnlyConsumption(bean);
		
		if(count>0) {
			int invout_id=dao.getLastAddedOutgoinId();
			int data[]=dao.addInventoryOutgoingItem(list, invout_id);
			if(data.length>0)
				return true;
			else
				return false;
		}
		return false;
	}
	
	
	public boolean updateProductionStock(InventoryOutgoingBean bean)throws Exception {
		bean.setDate(IndianDateFormater.
				converToIndianFormat(bean.getDate()));
		int count=0;
			count=dao.updateInventoryOutgoing(bean);
		return (count>0)?true:false;
	}
	
	
	public boolean updateInventoryOutgoingItem(List<InventoryOutgoingItem> list,int invout_id)throws Exception {
		List<InventoryOutgoingItem> updateItems=new ArrayList<InventoryOutgoingItem>();
		List<InventoryOutgoingItem> insertItems=new ArrayList<>();
		Iterator<InventoryOutgoingItem> iterator=list.iterator();
		while(iterator.hasNext()) {
			InventoryOutgoingItem item=iterator.next();
			if(item.getInvout_item_id()==0) {
				insertItems.add(item);
			}else {
				updateItems.add(item);
			}
		}
		
		int updateCount[]=dao.updateInventoryOutogingItem(updateItems);
		int insertCount[]=dao.addInventoryOutgoingItem(insertItems, invout_id);
		return ((updateCount.length+insertCount.length)>0)?true:false;
	}
	
	public Map<String,Object> getProductionList(int product_id,String from_date,
						String to_date,int plant_id,int start, int length, int draw)throws Exception{
		from_date=IndianDateFormater.converToIndianFormat(from_date);
		from_date=(from_date==null)?"":from_date;
		to_date=IndianDateFormater.converToIndianFormat(to_date);
		to_date=(to_date==null)?"":to_date;
		Map<String,Object> data=new HashMap<>();
		data.put("data",dao.getProductionList(product_id, from_date,
					to_date,plant_id, start, length));
		data.put("draw", draw);
		int recordCount=dao.countProductionList(product_id,
				from_date, to_date,plant_id);
		data.put("recordsTotal", recordCount);
		data.put("recordsFiltered", recordCount);
		return data;
	}
	
	public boolean deleteProductionDetails(int invout_id)throws Exception{
		return (dao.deleteProductionDetails(invout_id))>0?true:false;
	}
	
	
	public List<Map<String,Object>> getDateWiseReportList(String from_date, String to_date, int product_id,int plant_id)throws Exception {
		return dao.getDateWiseReportOfProductionReport(from_date, to_date, product_id, plant_id);
	}
	
	
	public List<Map<String,Object>> getStockReport(String from_date, String to_date, int product_id, int plant_id)throws Exception {
		return dao.getStockReport(from_date, to_date, product_id, plant_id);
	}
	
	
	public List<Map<String,Object>> getStockList()throws Exception {
		return dao.getAllStockItemList();
	}
	
	public StockBean getSingleStockDataForUpdate(int stock_id)throws Exception {
		return dao.getSingleOpeningStock(stock_id);
	}
	
	
	public Map<String,Object> getInventoryOutgoingList(int inv_item_id,String from_date,
			String to_date,int plant_id,int start, int length, int draw)throws Exception{
		from_date=IndianDateFormater.converToIndianFormat(from_date);
		from_date=(from_date==null)?"":from_date;
		to_date=IndianDateFormater.converToIndianFormat(to_date);
		to_date=(to_date==null)?"":to_date;
		Map<String,Object> data=new HashMap<>();
		data.put("data",dao.getInventoryOutgoingList(from_date,
				to_date, inv_item_id, plant_id, start, length));
		data.put("draw", draw);
		int recordCount=dao.countInventoryOutgoingList(from_date, to_date, inv_item_id, plant_id);
		data.put("recordsTotal", recordCount);
		data.put("recordsFiltered", recordCount);
		return data;
	}
	
	
	public Map<String,Object> getConversionDetails(int product_id)throws Exception {
		return dao.getConversionValueDetails(product_id);
	}
	
	
}

