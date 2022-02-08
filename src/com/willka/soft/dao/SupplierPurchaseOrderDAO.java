package com.willka.soft.dao;

import java.util.ArrayList;

import com.willka.soft.bean.SupplierPurchaseOrderBean;
import com.willka.soft.bean.SupplierPurchaseOrderItemBean;



public interface SupplierPurchaseOrderDAO {
	
public int insertSupplierPurchaseOrder(SupplierPurchaseOrderBean bean)throws Exception;
	
	public int updateSupplierPurchaseOrder(SupplierPurchaseOrderBean bean)throws Exception;
	
	public int deleteSupplierPurchaseOrder(int supplier_purchase_order_id)throws Exception;
	
	public int insertSupplierPurchaseOrderItem(SupplierPurchaseOrderItemBean bean)throws Exception;
	
	public int updateSupplierPurchaseOrderItem(SupplierPurchaseOrderItemBean bean)throws Exception;
	
	public int deleteSupplierPurchaseOrderItem(int spoi_id)throws Exception;
	
	public SupplierPurchaseOrderBean getSingleSupplierPurchaseOrder(int supplier_purchase_order_id)throws Exception;
	
	public SupplierPurchaseOrderItemBean getSingleSupplierPurchaseOrderItem(int spoi_id)throws Exception;
	
	public int getMaxSupplierPurchaseOrderId()throws Exception;
	
	public int getMaxOrderNo(int plant_id,int start_year,int end_year)throws Exception;
	
	public ArrayList<SupplierPurchaseOrderItemBean> getAllSupplierPurchaseOrderItem(int supplier_purchase_order_id)throws Exception;

	int approveSupplierPurchaseOrder(int supplier_purchase_order_id) throws Exception;


}
