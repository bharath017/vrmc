package com.willka.soft.test.dao;

import java.util.HashMap;

import com.willka.soft.test.bean.ConsolidateInvoiceBean;
import com.willka.soft.test.bean.ConsolidateInvoiceItemBean;
import com.willka.soft.test.bean.DCBean;
import com.willka.soft.test.bean.DCModificationBean;  



public interface DCDAO {

	public int insertInvoice(DCBean bean)throws Exception;
	
	public int insertInvoiceModification(DCModificationBean bean)throws Exception;
	
	public int updateVehiclePumpDetails(int id,String vehicle_no,String driver_name,String pump)throws Exception;
	
	public int updateInvoiceDateTime(int id,String invoice_date,String invoice_time)throws Exception;
	
	public int updateFullInvoice(DCBean bean)throws Exception;
	
	public int generateConsolidateInvoice(ConsolidateInvoiceBean bean)throws Exception;
	
	public int addConsolidateInvoiceItem(ConsolidateInvoiceItemBean bean)throws Exception;

	public int getMaxConsolidateInvoiceId()throws Exception;
	
	public int maxConsId(int start_year,int end_year)throws Exception;
	
	public int cancelConsolidateInvoice(int consolidate_invoice_id)throws Exception;
	
	public int refreshDC(int id)throws Exception;
	
	public int cancelInvoice(int id)throws Exception;
	
	public int changeDocketNo(int id,String docket_no)throws Exception;
	
	public int getInvoiceNo(int plant_id,int start_year,int end_year)throws Exception;
	
	public int deleteInvoice(int id,int invoice_id)throws Exception;
	
	public int getMaxOfId()throws Exception;
	
	// DC Report Part
	
	public HashMap<String, Object> getDatewiseReport(String from_date,String to_date,int product_id,int plant_id)throws Exception;
	
	public HashMap<String, Object> getCustomerWiseReport(int customer_id,int site_id,int product_id,int plant_id)throws Exception;
	
	public HashMap<String, Object> getCustomerWithDateWiseReport(String from_date,String to_date,int customer_id,int site_id,int product_id,int plant_id) throws Exception;
	
	public HashMap<String, Object> getVehicleWithDateWiseReport(String from_date,String to_date,String vehicle_no,int product_id,int plant_id) throws Exception;
	
	public HashMap<String, Object> getMarketingPersonWiseReport(String from_date,String to_date,int mp_id,int product_id,int plant_id) throws Exception;
	
	
}
