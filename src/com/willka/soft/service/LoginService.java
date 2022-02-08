package com.willka.soft.service;

import java.util.List;

import com.willka.soft.bean.UserDetailBean;
import com.willka.soft.dao.LoginDAO;
import com.willka.soft.dao.LoginDAOImpl;


public class LoginService {
	
	private LoginDAO dao;
	
	public LoginService() {
		dao=new LoginDAOImpl();
	}
	public UserDetailBean loginAsSuperAdmin(String username,String password)throws  Exception {
		UserDetailBean bean=dao.loginAsSuperAdmin(username, password);
		return bean;
	}
	
	public UserDetailBean loginAsUser(String username,String password)throws Exception{
		UserDetailBean bean=dao.loginAsUser(username, password);
		if(bean!=null) {
			List<Integer> accesslist=dao.getAccessAuthority(bean.getUser_id());
			bean.setRoles(accesslist.toArray(new Integer[] {accesslist.size()}));	
		}
		return bean;
	}
	
	
	public int changeSuperAdminPassword(String oldPassword, String newPassword)throws Exception {
		return dao.changeSuperAdminPassword(newPassword, oldPassword);
	}
	
	public int changeUserPassword(String oldPassword, String newPassword, int user_id)throws Exception {
		return dao.changeUserPassword(newPassword, oldPassword, user_id);
	}
	
	

	
}
