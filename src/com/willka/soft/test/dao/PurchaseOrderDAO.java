package com.willka.soft.test.dao;

import java.util.List;
import java.util.Map;

import com.willka.soft.test.bean.PurchaseOrderBean;
import com.willka.soft.test.bean.PurchaseOrderItemBean;


public interface PurchaseOrderDAO {
	
	public int insertPurchaseOrder(PurchaseOrderBean bean)throws Exception;
	
	public int updatePurchaseOrder(PurchaseOrderBean bean)throws Exception;
	
	public int insertPurchaseOrderItem(PurchaseOrderItemBean bean)throws Exception;
	
	public int updatePurchaseOrderItem(PurchaseOrderItemBean bean)throws Exception;
	
	public int cancelPurchaseOrder(int order_id)throws Exception;
	
	public int activatePurchaseOrder(int order_id) throws Exception;
	
	public int getHighestOrderId()throws Exception;
	
	public int countAllPurchaseOrderList(int customer_id,int site_id,String from_date,
							String to_date,String po_number, int business_id,int plant_id)throws Exception;

	public List<Map<String, Object>> getAllPurchaseOrderList(int customer_id, int site_id, String from_date, String to_date,
			String po_number, int business_id,int plant_id, int start,int length)throws Exception;
	
	public Map<String,Object> getPurchaseOrderDetails(int order_id)throws Exception;
	
	
	
}
