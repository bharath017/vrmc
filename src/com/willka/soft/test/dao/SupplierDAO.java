package com.willka.soft.test.dao;

import java.util.List;
import java.util.Map;

import com.willka.soft.test.bean.SupplierBean;


public interface SupplierDAO {

	public int insertSupplier(SupplierBean bean)throws Exception;
	
	public int updateSupplier(SupplierBean bean)throws Exception;
	
	public int changeSupplierStatus(int supplier_id,String supplier_status)throws Exception;

	public int UpdateTallyLedger(int supplier_id, String tally_ledger) throws Exception;
	
	public List<Map<String,Object>> getSupplierList(String search,int business_id,int start,int length)throws Exception;
	
	public int countSupplierList(String search,int business_id)throws Exception;
	
	public SupplierBean getSingleSupplierDetails(int supplier_id)throws Exception;
	
	public List<Map<String,Object>> getSupplierListByBusinessGroup(int business_id)throws Exception;
	
	
	
}
