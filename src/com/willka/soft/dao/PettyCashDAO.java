package com.willka.soft.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.willka.soft.bean.PettyCashBean;
import com.willka.soft.bean.PettyCashModificationBean;
import com.willka.soft.bean.PettyCashTransactionBean;

public interface PettyCashDAO {

	public int insertPettyCash(PettyCashBean bean)throws Exception;
	
	public int updatePettyCash(PettyCashBean bean)throws Exception;
	
	public int deletePettyCash(long cash_id)throws Exception;
	
	public int insertPettyCashModification(PettyCashModificationBean bean)throws Exception;
	
	public PettyCashBean getSinglePettyCashDetails(long cash_id)throws Exception;
	
	public ArrayList<HashMap<String, Object>> getPettyCashList(String from_date,String to_date,
			String cash_id,int plant_id,int start,int length)throws Exception;
	
	public int countPettyCashList(String from_date,String to_date,
			String cash_id,int plant_id)throws Exception;
	
	public ArrayList<HashMap<String, Object>> getPettyCashModificationList(String cash_id,int start,int length)throws Exception;
	
	public int countPettyCashModificationList(String cash_id)throws Exception;
	
	public int insertPettyCashTransaction(PettyCashTransactionBean bean)throws Exception;
	
	public int updatePettyCashTransaction(PettyCashTransactionBean bean)throws Exception;
	
	public int deletePettyCashTransaction(long transaction_id)throws Exception;
	
	public ArrayList<HashMap<String, Object>> getPettyCashTransactionList(String from_date,String to_date,int plant_id,boolean checked,int start,int length)throws Exception;
	
	public int countPettyCashTransactionList(String from_date,String to_date,int plant_id,boolean checked)throws Exception;
	
	public PettyCashTransactionBean getSinglePettyCashTransaction(long transaction_id)throws Exception;
	
	public int approvePettyCash(long cash_id,String received_by)throws Exception;
	
	public HashMap<String, Object> getDetailsSumOfPettyCash(int plant_id)throws Exception;
	
	public int changePettyCashTransactionBillStatus(long transaction_id,boolean status)throws Exception;
	
	
	
	
	
	
}
