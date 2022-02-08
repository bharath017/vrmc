package com.willka.soft.dao;

import java.util.List;
import java.util.Map;

public interface SmsSenderDAO {
	
	public int changeSmsSetting(int sms,String sms_time)throws Exception;

	public String getWithBillDetails()throws Exception;
	
	public String getWithoutBillDetails()throws Exception;
	
	public int insertPhone(String phone)throws Exception;
	
	public int deletePhone(int id)throws Exception;
	
	
}
