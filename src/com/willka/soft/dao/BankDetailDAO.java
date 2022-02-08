// 
// Decompiled by Procyon v0.5.36
// 

package com.willka.soft.dao;

import java.util.List;
import java.util.Map;

import com.willka.soft.bean.BankDetailBean;
import com.willka.soft.bean.BankTransactionBean;

public interface BankDetailDAO
{
   public int insertBankDetails(final BankDetailBean p0) throws Exception;
    
   public int updateBankDetails(final BankDetailBean p0) throws Exception;
    
   public int deleteBankDetails(final int p0) throws Exception;
    
   public int insertTransactionDetail(final BankTransactionBean p0) throws Exception;
    
   public int updateTransactionDetail(final BankTransactionBean p0) throws Exception;
    
   public int deleteTransactionDetail(final int p0) throws Exception;
    
   public int cancelTransactionDetail(final int p0) throws Exception;
   
   public List<Map<String,Object>> getBankTransactionList(String from_date, String to_date, int business_id,
		   			int bank_id, int start, int length)throws Exception;
   
   public int countBankTransactionList(String from_date, 
		   	String to_date, int bank_id,int business_id)throws Exception;
   
   public List<Map<String,Object>> getBankListByPaymentType(String group_name,int business_id)throws Exception;
   
   public List<Map<String,Object>> getBanksByBusinessGroup(int business_id)throws Exception;
   
   
   //report part goes here
   
   public List<Map<String,Object>> getOpeningBalanceList(String from_date, int bank_detail_id,int business_id)throws Exception;
   
   public List<Map<String,Object>> getTransactionReport(String from_date, String to_date, int bank_detail_id,int business_id)throws Exception;
   
   public double getOldBankBalance(int bank_detail_id)throws Exception;
   
   public Map<String,Object> processTransactionReport(String from_date, String to_date, int bank_detail_id,int business_id)throws Exception;
   
    
}
