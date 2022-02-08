package com.willka.soft.dao;

import com.willka.soft.bean.TransportChargeBean;

public interface TransportChargeDAO {

	public int insertTranportCharge(TransportChargeBean bean)throws Exception;
	
	public int updateTranportCharge(TransportChargeBean bean)throws Exception;
	
	public int cancelTransportCharge(int id,int invoice_id)throws Exception;
	
	public int getInvoiceId(int plant_id,int start_year,int end_year)throws Exception;
}
