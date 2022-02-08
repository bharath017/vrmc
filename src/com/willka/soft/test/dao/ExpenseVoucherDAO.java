package com.willka.soft.test.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.willka.soft.test.bean.ExpenseVoucherBean;
import com.willka.soft.test.bean.ExpenseVoucherItemBean;


public interface ExpenseVoucherDAO {
	
	public int insertExpenseCategory(String category_name,String category_type,
					String category_description)throws Exception;
	
	public  int updateExpenseCategory(int category_id,String category_name,
					String category_type,String category_description)throws Exception;
	
	public int deleteExpenseCategory(int category_id)throws Exception;
	
	public List<Map<String,Object>> getExpenseCategoryList(String search,
							int start, int length)throws Exception;
	
	public Map<String,Object> getSingleCategory(int category_id)throws Exception;
	
	public List<Map<String,Object>> getCategoryListById(String category_type)throws Exception;
	
	
	public int countExpenseCategoryList(String search)throws Exception;

	public int insertExpenseVoucher(ExpenseVoucherBean bean)throws Exception;
	
	public int insertExpenseVoucherItem(ExpenseVoucherItemBean bean)throws Exception;
	
	public int updateExpenseVoucher(ExpenseVoucherBean bean)throws Exception;
	
	public int cancelExpenseVoucher(int expense_voucher_id)throws Exception;
	
	public int getMaxExpenseVoucher()throws Exception;
	
	public int updateExpenseVoucherItem(ExpenseVoucherItemBean bean)throws Exception;
	
	public int deleteExpenseVoucherItm(int evi_id)throws Exception;
	
	public int deleteExpenseVoucher(int expense_voucher_id)throws Exception;
	
	public ArrayList<HashMap<String, Object>> getExpenseVoucherList(String bill_no,String from_date,
			String to_date,int supplier_id,int business_id,
							int start,int length)throws Exception;

	public int countExpenseVoucherList(String bill_no,String from_date,String to_date,
							int supplier_id,int business_id)throws Exception;
	
	public Map<String,Object> getExpenseVoucherDashboard()throws Exception;
	
	public List<String> getExpenseCategoryType()throws Exception;
	
}
