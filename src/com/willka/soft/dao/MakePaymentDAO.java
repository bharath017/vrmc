package com.willka.soft.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.willka.soft.bean.MakePaymentBean;

public interface MakePaymentDAO {

	public HashMap<String, Double> getCreditBalance(int supplier_id)throws Exception;
	
	public int insertMakePayment(MakePaymentBean bean)throws Exception;
	
	public int updateMakePayment(MakePaymentBean bean)throws Exception;
	
	public int deleteMakePayment(int payment_id)throws Exception;
	
	public MakePaymentBean getSingleMakePayment(int payment_id)throws Exception;
	
	public int insertMakePaymentModification(MakePaymentBean bean)throws Exception;
	
	
	public ArrayList<HashMap<String, Object>> getAllMakePaymentList(String from_date,String to_date,String payment_id
			,int supplier_id,int business_id,int start,int length)throws Exception;
	
	public int countAllMakePaymentList(String from_date,String to_date,String payment_id
			,int supplier_id, int business_id)throws Exception;
	
	//report part
	
	public List<Map<String,Object>> getDateWiseReport(String from_date, String to_date, int business_id)throws Exception;
	
	public List<Map<String,Object>> getSupplierWiseReport(int supplier_id, int business_id)throws Exception;
	
	public List<Map<String,Object>> getSupplierWithDateWise(int supplier_id,String from_date, String to_date, int business_id)throws Exception;
	
	public List<Map<String,Object>> getBankWithDateWise(int bank_detail_id, String from_date, String to_date, int business_id)throws Exception;
	
	public List<Map<String,Object>> getPurchaseTransactionReport(String from_date, String to_date, int business_id)throws Exception;
	
	
	
	
	
	
}
