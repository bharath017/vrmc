package com.willka.soft.dao;

import java.util.List;
import java.util.Map;

import com.willka.soft.bean.SalesDocumentBean;
import com.willka.soft.bean.SalesDocumentItemBean;

public interface SalesDocumentDAO {

	public int insertSalesDocument(SalesDocumentBean bean)throws Exception;
	
	public int updateSalesDocument(SalesDocumentBean bean)throws Exception;
	
	public int insertSalesDocumentItem(SalesDocumentItemBean bean)throws Exception;
	
	public int updateSalesDocumentItem(SalesDocumentItemBean bean)throws Exception;
	
	public int cancelSalesDocument(int id)throws Exception;
	
	public int getMaxId()throws Exception;
	
	public int getLastInvoiceNo(int business_id,int start_year,int end_year, int plant_id)throws Exception;
	
	public List<Map<String,Object>> getSalesDocumentList(int customer_id,int site_id,
						String from_date, String to_date, String invoice_id,int plant_id, int business_id, int start, int length)throws Exception;
	
	public int countSalesDocumentList(int customer_id,int site_id,
						String from_date, String to_date, String invoice_id,int plant_id, int business_id)throws Exception;
	
	
	public List<Map<String,Object>> getSalesConsolidateInvoiceList(String cons_id,int customer_id,
			String form_date, String to_date,int business_id, int plant_id, int start, int length)throws Exception;
	
	public int countSalesConsolidateInvoice(String cons_id,int customer_id,String from_date, String to_date
			,int plant_id, int business_id)throws Exception;
	
	public int getBusinessIdByPlantId(int plant_id)throws Exception;
	
	public double getTotalNetAmount(int customer_id, int start_year,int end_year)throws Exception;
	
	public int[] updateInvoiceNoInDC(String[] dc_nos, int id) throws Exception;

	
	
	
	
}
