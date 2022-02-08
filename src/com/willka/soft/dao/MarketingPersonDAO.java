package com.willka.soft.dao;

import com.willka.soft.bean.MarketingPersonBean;

public interface MarketingPersonDAO {

	public int insertMarketingPerson(MarketingPersonBean bean)throws Exception;
	
	public int updateMarketingPerson(MarketingPersonBean bean)throws Exception;
	
	public int changeMarketingStatus(int mp_id,String mp_status)throws Exception;
	
}
