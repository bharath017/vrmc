package com.willka.soft.dao;

import com.willka.soft.bean.CustomerQuotationBean; 
import com.willka.soft.bean.CustomerQuotationItemBean;


public interface CustomerQuotationDAO {
	
	public int insertCustomerQuotation(CustomerQuotationBean bean) throws Exception;
	
	public int updateCustomerQuotation(CustomerQuotationBean bean) throws Exception;
	
	public int insertCustomerQuotationItem(CustomerQuotationItemBean bean) throws Exception;
	
	public int updateCustomerQuotationItem(CustomerQuotationItemBean bean) throws Exception;
	
	public int deleteCustomerQuotation(int quotation_id) throws Exception;
	
	public CustomerQuotationBean getSingleCustomerQuotaionDetails(int quotation_id) throws Exception;
	
	public int getHighestQuotationId() throws Exception;
	
	public int statusCustomerQuotation(int quotation_id,String status) throws Exception;

}
