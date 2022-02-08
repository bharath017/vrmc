package com.willka.soft.test.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.willka.soft.test.bean.PurchaseVoucherBean;
import com.willka.soft.test.bean.PurchaseVoucherItemBean;


public interface PurchaseVoucherDAO {

	public int insertPurchaseVoucher(PurchaseVoucherBean bean)throws Exception;
	
	public int updatePurchaseVoucher(PurchaseVoucherBean bean)throws Exception;
	
	public int changePurchaseVoucherStatus(int purchase_voucher_id,String voucher_status)throws Exception;
	
	public int insertPurchaseVoucherItem(PurchaseVoucherItemBean bean)throws Exception;
	
	public int updatePurchaseVoucherItem(PurchaseVoucherItemBean bean)throws Exception;
	
	public int deletePurchaseVoucherItem(int pvi_id)throws Exception;
	
	public int getMaxPurchaseVoucherId()throws Exception;
	
	public ArrayList<HashMap<String, Object>> getPurchaseVoucherList(String bill_no,String from_date,
			String to_date,int supplier_id,int business_id,
							int start,int length)throws Exception;

	public int countPurchaseVoucherList(String bill_no,String from_date,String to_date,
							int supplier_id,int business_id)throws Exception;

	public int DeletePurchaseVoucher(int purchase_voucher_id) throws Exception;

	public int activatePurchaseVoucherStatus(int purchase_voucher_id, String string) throws Exception;
}
