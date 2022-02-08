package com.willka.soft.dao;

import com.willka.soft.bean.CompanyDetailsBean;
import com.willka.soft.bean.UserDetailBean;

public interface CompanyDAO {
	
	public int updateCompanyDetails(CompanyDetailsBean bean)throws Exception;
	
	public UserDetailBean loginAsUser(String username,String password)throws Exception;
	
	public int changePassword(String login_id,String old_password,String new_password)throws Exception;
	
}
