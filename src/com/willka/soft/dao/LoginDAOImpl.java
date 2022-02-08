package com.willka.soft.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.willka.soft.bean.UserDetailBean;
import com.willka.soft.util.DBUtil;



public class LoginDAOImpl implements LoginDAO {
	private Connection con=null;
	private PreparedStatement ps=null;
	private ResultSet rs=null;
	
	private static final String LOGIN_AS_SUPERADMIN="select company_name,company_mail,"
			+ "	company_username,company_password"
			+ "	from company_detail where company_username=? and company_password like ?";
	
	private static final String LOGIN_AS_USER="select * from user where user_login_id=? and user_password like ? and user_status='active'";
	
	private static final String GET_AUTHORITY_LIST="select role_id from user_role where user_id=?";
	
	private static final String CHANGE_SUPER_ADMIN_PASSWORD="update company_detail set company_password=? where company_password like ?";
	
	private static  final String CHANGE_USER_PASSWORD="update user set user_password=? where user_id=? and user_password like ?";
	
	
	
	 public LoginDAOImpl() {
		 con=DBUtil.getConnection();
	 }
	 
	
	@Override
	public UserDetailBean loginAsSuperAdmin(String username, String password) throws Exception {
		ps=con.prepareStatement(LOGIN_AS_SUPERADMIN);
		ps.setString(1, username);
		ps.setString(2, password);
		rs=ps.executeQuery();
		if(rs.next()) {
			UserDetailBean bean=new UserDetailBean();
			bean.setUsers_name(rs.getString("company_username"));
			bean.setUsername(rs.getString("company_name"));
			bean.setUser_email(rs.getString("company_mail"));
			bean.setRoles(new Integer[] {0});
			bean.setUsertype("superadmin");
			bean.setUser_id(0);
			bean.setPlant_id(0);
			bean.setBusiness_id(0);
			return bean;
		}
		return null;
	}


	@Override
	public UserDetailBean loginAsUser(String username, String password) throws Exception {
		ps=con.prepareStatement(LOGIN_AS_USER);
		ps.setString(1, username);
		ps.setString(2, password);
		rs=ps.executeQuery();
		if(rs.next()) {
			UserDetailBean bean=new UserDetailBean();
			bean.setUsername(rs.getString("user_name"));
			bean.setUsers_name(rs.getString("user_login_id"));
			bean.setUser_email(rs.getString("user_email"));
			int user_id=rs.getInt("user_id");
			bean.setUsertype(rs.getString("user_type"));
			bean.setLogo(rs.getString("user_photo"));
			bean.setUser_id(user_id);
			bean.setPlant_id(rs.getInt("plant_id"));
			bean.setBusiness_id(rs.getInt("business_id"));
			return bean;
		}
		return null;
	}
	



	@Override
	public List<Integer> getAccessAuthority(int user_id) throws Exception {
		ps=con.prepareStatement(GET_AUTHORITY_LIST);
		ps.setInt(1, user_id);
		rs=ps.executeQuery();
		List<Integer> list=new ArrayList<Integer>();
		while(rs.next()) {
			list.add(rs.getInt("role_id"));
		}
		return list;
	}
	
	



	@Override
	public int changeSuperAdminPassword(String newPassword, String oldPassword) throws Exception {
		ps=con.prepareStatement(CHANGE_SUPER_ADMIN_PASSWORD);
		ps.setString(1, newPassword);
		ps.setString(2, oldPassword);
		int count=ps.executeUpdate();
		return count;
	}


	@Override
	public int changeUserPassword(String newPassword, 
			String oldPassword, int user_id) throws Exception {
		ps=con.prepareStatement(CHANGE_USER_PASSWORD);
		ps.setString(1, newPassword);
		ps.setInt(2, user_id);
		ps.setString(3, oldPassword);
		int count=ps.executeUpdate();
		return count;
	}
	
	
}
