package com.willka.soft.dao;

import com.willka.soft.bean.ConsolidateInvoiceBean;
import com.willka.soft.bean.ConsolidateInvoiceItemBean;
import com.willka.soft.bean.InvoiceBean;
import com.willka.soft.bean.InvoiceModificationBean;

public interface InvoiceDAO {

	public int insertInvoice(InvoiceBean bean)throws Exception;
	
	public int insertInvoiceModification(InvoiceModificationBean bean)throws Exception;
	
	public int updateVehiclePumpDetails(int id,String vehicle_no,String driver_name,String pump)throws Exception;
	
	public int updateInvoiceDateTime(int id,String invoice_date,String invoice_time)throws Exception;
	
	public int updateFullInvoice(InvoiceBean bean)throws Exception;
	
	public int generateConsolidateInvoice(ConsolidateInvoiceBean bean)throws Exception;
	
	public int addConsolidateInvoiceItem(ConsolidateInvoiceItemBean bean)throws Exception;

	public int getMaxConsolidateInvoiceId()throws Exception;
	
	public int maxConsId(int start_year,int end_year)throws Exception;
	
	public int cancelConsolidateInvoice(int consolidate_invoice_id)throws Exception;
	
	public int refreshInvoice(int id)throws Exception;
	
	public int cancelInvoice(int id)throws Exception;
	
	public int changeDocketNo(int id,String docket_no)throws Exception;
	
	public int getInvoiceNo(int plant_id,int start_year,int end_year)throws Exception;
	
	public int deleteInvoice(int id,int invoice_id)throws Exception;
	
	public int getMaxOfId()throws Exception;
	
	public double getTotalNetAmount(int customer_id,int start_year,int end_year)throws Exception;
	
	
}
