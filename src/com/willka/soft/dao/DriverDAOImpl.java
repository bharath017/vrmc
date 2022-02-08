package com.willka.soft.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import com.willka.soft.bean.DriverBean;
import com.willka.soft.util.DBUtil;


public class DriverDAOImpl implements DriverDAO{
	//all database variable here
	private Connection con=null;
	private PreparedStatement ps=null;
	private ResultSet rs=null;
	
	//write all query here
	private static final String INSERT_DRIVER_DETAIL="insert into driver(driver_name,driver_phone,licence_no,licence_valid_till) values(?,?,?,?)";
	
	private static final String UPDATE_DRIVER_DETAILS="update driver set driver_name=?,driver_phone=?,licence_no=?,licence_valid_till=? where driver_id=?";
	
	private static final String DELETE_DRIVER_DETAILS="delete from driver where driver_id=?";
	
	private static final String SELECT_SINGLE_DRIVER_DETAIL="select * from driver where driver_id=?";
	
	private static final String GET_ALL_DRIVER_DETAILS="select * from driver";
	
	private static final String INSERT_PUMP_DG="insert into pump(type,pump_name) values(?,?)";
	
	private static final String UPDATE_PUMP_DG="update pump set type=?,pump_name=? where pump_id=?";
	
	private static final String DELETE_PUMP_DG="delete from pump where pump_id=?";
	
	
	

	public DriverDAOImpl() {
		con=DBUtil.getConnection();
	}
	@Override
	public int insertDriverDetail(DriverBean bean) throws Exception {
		ps=con.prepareStatement(INSERT_DRIVER_DETAIL);
		ps.setString(1, bean.getDriver_name());
		ps.setString(2, bean.getDriver_phone());
		ps.setString(3, bean.getLicence_no());
		ps.setString(4, bean.getLicence_valid_till());
		int count=ps.executeUpdate();
		return count;
	}

	@Override
	public int updateDriverDetail(DriverBean bean) throws Exception {
		ps=con.prepareStatement(UPDATE_DRIVER_DETAILS);
		ps.setString(1, bean.getDriver_name());
		ps.setString(2, bean.getDriver_phone());
		ps.setString(3, bean.getLicence_no());
		ps.setString(4, bean.getLicence_valid_till());
		ps.setInt(5,bean.getDriver_id());
		int count=ps.executeUpdate();
		return count;
	}

	@Override
	public int deleteDriverDetail(int driver_id) throws Exception {
		ps=con.prepareStatement(DELETE_DRIVER_DETAILS);
		ps.setInt(1, driver_id);
		int count=ps.executeUpdate();
		return count;
	}

	@Override
	public DriverBean getSingleDriverDetail(int driver_id) throws Exception {
		ps=con.prepareStatement(SELECT_SINGLE_DRIVER_DETAIL);
		ps.setInt(1, driver_id);
		rs=ps.executeQuery();
		if(rs.next()){
			//create driverbean object
			DriverBean bean=new DriverBean();
			bean.setDriver_id(rs.getInt("driver_id"));
			bean.setDriver_name(rs.getString("driver_name"));
			bean.setDriver_phone(rs.getString("driver_phone"));
			bean.setDriver_address(rs.getString("driver_address"));
			bean.setLicence_no(rs.getString("licence_no"));
			bean.setLicence_valid_till(rs.getString("licence_valid_till"));
			bean.setPlant_id(rs.getInt("plant_id"));
			return bean;
		}
		else
		return null;
	}

	@Override
	public ArrayList<DriverBean> getAllDriverList() throws Exception {
		ps=con.prepareStatement(GET_ALL_DRIVER_DETAILS);
		rs=ps.executeQuery();
		ArrayList<DriverBean> driver_list=new ArrayList<DriverBean>();
		while(rs.next()){
			//create driverbean object
			DriverBean bean=new DriverBean();
			bean.setDriver_id(rs.getInt("driver_id"));
			bean.setDriver_name(rs.getString("driver_name"));
			bean.setDriver_phone(rs.getString("driver_phone"));
			bean.setLicence_no(rs.getString("licence_no"));
			bean.setLicence_valid_till(rs.getString("licence_valid_till"));
			driver_list.add(bean);
		}
		return driver_list;
	}
	@Override
	public int insertAddPumpDG(String type, String pump_name) throws Exception {
		ps=con.prepareStatement(INSERT_PUMP_DG);
		ps.setString(1, type);
		ps.setString(2, pump_name);
		int count=ps.executeUpdate();
		return count;
	}
	
	@Override
	public int updateAddPumpDG(int pump_id, String type, String pump_name) throws Exception {
		ps=con.prepareStatement(UPDATE_PUMP_DG);
		ps.setString(1, type);
		ps.setString(2, pump_name);
		ps.setInt(3, pump_id);
		int count=ps.executeUpdate();
		return count;
	}
	@Override
	public int deletePumpDG(int pump_id) throws Exception {
		ps=con.prepareStatement(DELETE_PUMP_DG);
		ps.setInt(1, pump_id);
		int count=ps.executeUpdate();
		return count;
	}

	
}
