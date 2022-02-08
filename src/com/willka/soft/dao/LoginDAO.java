package com.willka.soft.dao;

import java.util.List;

import com.willka.soft.bean.UserDetailBean;


public interface LoginDAO {
	
	public UserDetailBean loginAsSuperAdmin(String username,String password)throws Exception;
	
	public UserDetailBean loginAsUser(String username,String password)throws Exception;
	
	public List<Integer> getAccessAuthority(int user_id)throws Exception;
	
	public int changeSuperAdminPassword(String newPassword,String oldPassword)throws Exception;
	
	public int changeUserPassword(String newPassword, 
										String oldPassword , int user_id)throws Exception;
	
	
}
