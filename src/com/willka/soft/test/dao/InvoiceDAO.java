package com.willka.soft.test.dao;

import com.willka.soft.bean.ConsolidateInvoiceItemBean;
import com.willka.soft.test.bean.ConsolidateInvoiceBean;
import com.willka.soft.test.bean.InvoiceBean;
import com.willka.soft.test.bean.InvoiceModificationBean;

public interface InvoiceDAO {

	public int insertInvoice(InvoiceBean bean)throws Exception;
	
	public int insertInvoiceModification(InvoiceModificationBean bean)throws Exception;
	
	public int updateVehiclePumpDetails(int id,String vehicle_no,String driver_name,String pump)throws Exception;
	
	public int updateInvoiceDateTime(int id,String invoice_date,String invoice_time)throws Exception;
	
	public int updateFullInvoice(InvoiceBean bean)throws Exception;
	
	public int generateConsolidateInvoice(ConsolidateInvoiceBean bean)throws Exception;
	
	public int addConsolidateInvoiceItem(ConsolidateInvoiceItemBean bean)throws Exception;

	public int getMaxConsolidateInvoiceId()throws Exception;
	
	public int cancelConsolidateInvoice(int consolidate_invoice_id)throws Exception;
	
	public int refreshInvoice(int id)throws Exception;
	
	public int cancelInvoice(int id)throws Exception;
	
	public int changeDocketNo(int id,String docket_no)throws Exception;
	
	public boolean checkExistanceOfInvoice(int plant_id,int invoice_id,int start_year,int end_year)throws Exception;
	
	public int changeInvoiceState(String state)throws Exception;
	
	public int deleteInvoice(int id,int invoice_id)throws Exception;
	
	
	
	
	
	
}
