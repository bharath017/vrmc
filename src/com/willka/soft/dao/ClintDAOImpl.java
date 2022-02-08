package com.willka.soft.dao;


import java.sql.ResultSet;
import java.sql.Connection;
import java.sql.PreparedStatement;

import com.willka.soft.bean.ClintBean;
import com.willka.soft.util.DBUtil;

public class ClintDAOImpl  implements ClintDAO {
	
	private Connection con=null;
	private PreparedStatement ps=null;
	private ResultSet rs=null;

	private static final String INSERT_CLINT="insert into client(client_name,client_phone,customer_address,contractor_name,contractor_phone,architech_name,architech_phone,consultent_name,consultent_phone,pmc_name,pmc_phone,project_quantity,monthly_requirnment,currnet_supplier,stage)values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
	
	private static final String UPDATE_CLINT="update client set client_name=?, client_phone=?, customer_address=?, contractor_name=?, contractor_phone=?, architech_name=?, architech_phone=?, consultent_name=?, consultent_phone=?, pmc_name=?, pmc_phone=?, project_quantity=?, monthly_requirnment=?, currnet_supplier=?, stage=? where client_id=?";
	
	private static final String DELETE_CLINT="delete from client where client_id=?";
	
	public ClintDAOImpl() {
		con=DBUtil.getConnection();
	}

	@Override
	public int insertClint(ClintBean bean) throws Exception {
	
		ps=con.prepareStatement(INSERT_CLINT);
		ps.setString(1, bean.getClint_name());
		ps.setString(2, bean.getClint_phone());
		ps.setString(3, bean.getCustomer_address());
		ps.setString(4, bean.getContractor_name());
		ps.setString(5, bean.getContractor_phone());		
		ps.setString(6, bean.getArchitech_name());
		ps.setString(7, bean.getArchitech_phone());
		ps.setString(8,bean.getConsultent_name());
		ps.setString(9, bean.getConsultent_phone());
		ps.setString(10, bean.getPmc_name());
		ps.setString(11, bean.getPmc_phone());
		ps.setDouble(12, bean.getProject_quantity());
		ps.setString(13, bean.getMonthly_requirnment());
		ps.setString(14, bean.getCurrnet_supplier());
		ps.setString(15, bean.getStage());
		int count=ps.executeUpdate();
		return count;

	}

	@Override
	public int updateClint(ClintBean bean) throws Exception {
		ps=con.prepareStatement(UPDATE_CLINT);
		ps.setString(1, bean.getClint_name());
		ps.setString(2, bean.getClint_phone());
		ps.setString(3, bean.getCustomer_address());
		ps.setString(4, bean.getContractor_name());
		ps.setString(5, bean.getContractor_phone());		
		ps.setString(6, bean.getArchitech_name());
		ps.setString(7, bean.getArchitech_phone());
		ps.setString(8,bean.getConsultent_name());
		ps.setString(9, bean.getConsultent_phone());
		ps.setString(10, bean.getPmc_name());
		ps.setString(11, bean.getPmc_phone());
		ps.setDouble(12, bean.getProject_quantity());
		ps.setString(13, bean.getMonthly_requirnment());
		ps.setString(14, bean.getCurrnet_supplier());
		ps.setString(15, bean.getStage());
		ps.setInt(16, bean.getClint_id());
		int count=ps.executeUpdate();
		return count;
	}

	@Override
	public int deleteClint(int clint_id) throws Exception {
		ps=con.prepareStatement(DELETE_CLINT);
		ps.setInt(1, clint_id);
		int count=ps.executeUpdate();
		return count;
	}

}
