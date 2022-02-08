package com.willka.soft.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

import com.willka.soft.bean.MarketingPersonBean;
import com.willka.soft.util.DBUtil;

public class MarketingPersonDAOImpl implements MarketingPersonDAO{
	
	private Connection con=null;
	private PreparedStatement ps=null;
	
	private static final String INSERT_MARKETING_PERSON="insert into marketing_person(mp_name,mp_phone,mp_address,mp_email,mp_type,plant_id,mp_head,mp_login_id,mp_password) values(?,?,?,?,?,?,?,?,?)";
	
	private static final String UPDATE_MARKETING_PERSON="update marketing_person set mp_name=?,mp_phone=?,mp_address=?,mp_email=?,mp_type=?,plant_id=?,mp_head=?,mp_login_id=?,mp_password=? where mp_id=?";
	
	private static final String CHANGE_MARKETING_STATUS="update marketing_person set mp_status=? where mp_id=?";
	
	
	
	public MarketingPersonDAOImpl() {
		con=DBUtil.getConnection();
	}
	
	@Override
	public int insertMarketingPerson(MarketingPersonBean bean) throws Exception {
		ps=con.prepareStatement(INSERT_MARKETING_PERSON);
		ps.setString(1, bean.getMp_name());
		ps.setString(2, bean.getMp_phone());
		ps.setString(3, bean.getMp_address());
		ps.setString(4, bean.getMp_email());
		ps.setString(5, bean.getMp_type());
		ps.setInt(6, bean.getPlant_id());
		System.out.println(bean.getMp_head());
		ps.setInt(7, bean.getMp_head());
		ps.setString(8, bean.getMp_login_id());
		ps.setString(9, bean.getMp_password());
		int count=ps.executeUpdate();
		return count;
	}

	@Override
	public int updateMarketingPerson(MarketingPersonBean bean) throws Exception {
		ps=con.prepareStatement(UPDATE_MARKETING_PERSON);
		ps.setString(1, bean.getMp_name());
		ps.setString(2, bean.getMp_phone());
		ps.setString(3, bean.getMp_address());
		ps.setString(4, bean.getMp_email());
		ps.setString(5, bean.getMp_type());
		ps.setInt(6, bean.getPlant_id());
		ps.setInt(7, bean.getMp_head());
		ps.setString(8, bean.getMp_login_id());
		ps.setString(9, bean.getMp_password());
		ps.setInt(10, bean.getMp_id());
		int count=ps.executeUpdate();
		return count;
	}

	@Override
	public int changeMarketingStatus(int mp_id, String mp_status) throws Exception {
		ps=con.prepareStatement(CHANGE_MARKETING_STATUS);
		ps.setString(1,mp_status);
		ps.setInt(2, mp_id);
		int count=ps.executeUpdate();
		return count;
	}

}
