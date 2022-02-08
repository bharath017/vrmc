package com.willka.soft.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.willka.soft.bean.CompanyDetailsBean;
import com.willka.soft.bean.UserDetailBean;
import com.willka.soft.util.DBUtil;

public class CompanyDAOImpl implements CompanyDAO {
	
	//declare database variable
	private Connection con=null;
	private PreparedStatement ps=null;
	private ResultSet rs=null;
	
	
	private static final String UPDATE_QUERY="update company_detail set company_name=?, company_phone=?, company_head_office=?, company_mail=?, compnay_director=?, company_logo=?, pan_number=?, gstin_number=?, registration_no=?, established_year=?, company_username=?, company_password=? where company_id=?";
	
	private static final String GET_DETAILS="select * from company_detail where company_username=? and company_password=?";
	
	private static final String CHANGE_PASSWORD="update company_detail set company_password=? where company_username=? and company_password=?";
	
	public CompanyDAOImpl() {
		con=DBUtil.getConnection();
	}
	
	@Override
	public int updateCompanyDetails(CompanyDetailsBean bean) throws Exception {
		ps=con.prepareStatement(UPDATE_QUERY);
		ps.setString(1, bean.getCompany_name());
		ps.setString(2, bean.getCompany_phone());
		ps.setString(3, bean.getCompany_head_office());
		ps.setString(4, bean.getCompany_mail());
		ps.setString(5, bean.getCompany_director());
		ps.setString(6, bean.getCompany_logo());
		ps.setString(7, bean.getCompany_password());
		return 0;
	}

	@Override
	public UserDetailBean loginAsUser(String username, String password) throws Exception {
		ps=con.prepareStatement(GET_DETAILS);
		ps.setString(1, username);
		ps.setString(2, password);
		rs=ps.executeQuery();
		if(rs.next()){
			UserDetailBean bean=new UserDetailBean();
			bean.setUsername(rs.getString("company_username"));
			bean.setUser_email(rs.getString("company_mail"));
			bean.setUsers_name(rs.getString("company_name"));
			bean.setPlant_id(rs.getInt("plant_access"));
			bean.setUsertype(rs.getString("user_type"));
			return bean;
		}
		else
			return null;
	}

	@Override
	public int changePassword(String login_id, String old_password, String new_password) throws Exception {
		ps=con.prepareStatement(CHANGE_PASSWORD);
		ps.setString(1, new_password);
		ps.setString(2, login_id);
		ps.setString(3,old_password);
		int count=ps.executeUpdate();
		return count;
	}

	
}
