package com.willka.soft.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.willka.soft.bean.ContactPerson;
import com.willka.soft.bean.CustomerBean;
import com.willka.soft.bean.ProjectBlock;
import com.willka.soft.bean.SiteDetailBean;

public interface CustomerDAO {

	public int addCustomerDetails(CustomerBean bean)throws Exception;
	
	public int updateCustomerDetails(CustomerBean bean)throws Exception;
	
	public int changeCustomerStatus(int customer_id,String customer_status)throws Exception;
	
	public int insertSiteDetails(SiteDetailBean bean)throws Exception;
	
	public int updateSiteDetails(SiteDetailBean bean)throws Exception;
	
	public int changeSiteStatus(int site_id,String site_status)throws Exception;
	
	public int getMaxCustomerId()throws Exception;
	
	public ArrayList<SiteDetailBean> getAllSiteAddress(int customer_id)throws Exception;
	
	public SiteDetailBean getSiteDetailsUsingId(int site_id)throws Exception;
	
	public CustomerBean getSingleCustomerDetails(int customer_id)throws Exception;
	
	public int updateTallyLedger(int site_id,String tally_ledger)throws Exception;
	
	public int insertCotactPerson(ContactPerson bean)throws Exception;
	
	public int updateContactPerson(ContactPerson bean)throws Exception;
	
	public int deleteContactPerson(int contact_id)throws Exception;
	
	public int insertProjectBlock(ProjectBlock bean)throws Exception;
	
	public int deleteProjectBlock(int block_id)throws Exception;
	
	ArrayList<ProjectBlock> getAllProjectBlock(int site_id)throws Exception;
	
	public int updateCreditLimit(int customer_id, double credit_limit) throws Exception;
	
	ArrayList<HashMap<String, Object>> getAllCustomerList(String name,
			String phone,String status,String alp,int business_id,int plant_id,
			int start,int length)throws Exception;

	int countAllCustomerList(String name,String phone,
			String status,String alp,int business_id,int plant_id)throws Exception;
	
	public Map<String,Object> getMarketingPersonDetails(int customer_id)throws Exception;
	
	public Map<String,Object> getDashboardDetails()throws Exception;	
	
	public List<Map<String,Object>> getCustomerListByBusinessGroup(int business_id)throws Exception;
	
	
}
