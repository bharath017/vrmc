package com.willka.soft.dao;

import com.willka.soft.bean.InvoiceBean;
import com.willka.soft.bean.InvoiceSMSBean;

public interface SMSDAO {

	public boolean sendSMSForEveryInvoice(InvoiceSMSBean bean)throws Exception;
	
	public InvoiceSMSBean getSingleInvoiceDetails(int id)throws Exception;
	
}
