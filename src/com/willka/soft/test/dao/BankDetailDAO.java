// 
// Decompiled by Procyon v0.5.36
// 

package com.willka.soft.test.dao;

import java.util.List;
import java.util.Map;

import com.willka.soft.bean.BankDetailBean;
import com.willka.soft.bean.BankTransactionBean;

public interface BankDetailDAO
{
   public int updateBankDetails(final BankDetailBean p0) throws Exception;
   
   public List<Map<String,Object>> getBankTransactionList(String from_date, String to_date, int business_id,
		   			int bank_id, int start, int length)throws Exception;
   
   public int countBankTransactionList(String from_date, 
		   	String to_date, int bank_id,int business_id)throws Exception;
   
   public List<Map<String,Object>> getBankListByPaymentType(String group_name,int business_id)throws Exception;
   
   public int insertFileUploadData(int id,String type,String file_name)throws Exception;
   
   public List<Map<String,Object>> getDocumentList(int id,String type)throws Exception;
   
   public int deleteDocumentFileName(int id)throws Exception;
   
}
