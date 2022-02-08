package com.willka.soft.test.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.willka.soft.test.bean.CustomerPaymentBean;


public interface PaymentDAO {
	
	public int insertPayment(CustomerPaymentBean bean)throws Exception;
	
	public int updatePayment(CustomerPaymentBean bean)throws Exception;
	
	public double getCreditAmmount(int customer_id)throws Exception;
	
	public CustomerPaymentBean getSinglePaymentDetails(int payment_id)throws Exception;
	
	public int insertModificationDetails(CustomerPaymentBean bean)throws Exception;
	
	public int deletePaymentDetails(int payment_id)throws Exception;
	
	public ArrayList<HashMap<String, Object>> getPaymentList(String from_date,String to_date,
			String payment_id,int customer_id,int business_id, int start,int length)throws Exception;
	public int countPaymentList(String from_date,String to_date,
			String payment_id,int customer_id, int business_id)throws Exception;
	
	
	
	
}

