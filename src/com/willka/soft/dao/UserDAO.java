package com.willka.soft.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.willka.soft.bean.UserBean;
import com.willka.soft.bean.UserDetailBean;

public interface UserDAO {

	public int insertUserDetails(UserBean bean)throws Exception;
	
	public int updateUserDetails(UserBean bean)throws Exception;
	
	public int changeUserStatus(int user_id,String user_status)throws Exception;
	
	public UserBean getSingleUserDetails(int user_id)throws Exception;
	
	public UserDetailBean loginAsUser(String user_name,String password)throws Exception;
	
	public int changePasword(int user_id,String old_password,String new_password)throws Exception;
	
	public UserDetailBean getEmployeeLogin(String employee_id,String password)throws Exception;
	
	public UserDetailBean getMarketingLogin(String user_name, String password) throws Exception;

	public int changeMpPassword(int user_id,String user_name, String old_password, String new_password) throws Exception;

	public UserBean getSingleUserByUserID(int user_id)throws Exception;
	
	public int insertRoles(int user_id,int role_id)throws Exception;
	
	public boolean checkRoleExistance(int user_id,int role_id)throws Exception;
	
	public int deleteRoles(int user_id,String roles)throws Exception;
	
	public HashMap<String, Object> getSingleUserRoles(int user_id)throws Exception;
	
	public ArrayList<Integer> getAllRoles(int user_id)throws Exception;
	
	public int updateRoleDetails(int user_id,String roles)throws Exception;
	
	public List<Map<String,Object>> getAllUserList(String search,int business_id,
								String type,int start,int length)throws Exception;
	
	public int countAllUserList(String search,int business_id,String type)throws Exception;
	
	
	
}
