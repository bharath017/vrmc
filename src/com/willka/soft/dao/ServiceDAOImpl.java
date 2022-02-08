package com.willka.soft.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.willka.soft.bean.ServiceBean;
import com.willka.soft.util.DBUtil;



public class ServiceDAOImpl implements ServiceDAO {
	
	private Connection con=null;
	private PreparedStatement ps=null;
	private ResultSet rs=null;
	
	private static final String INSERT_SERVICE="insert into vehicle_service(vehicle_no,date,time, "
			+ " service_cost,present_skm,last_skm,vehicle_type,plant_id) values(?,?,?,?,?,?,?,?)";
	
	private static final String GET_SINGLE_VEHICLE_SERVICE_DETAILS="select * from vehicle_service "
			+ " where vs_id=(select max(vs_id) from vehicle_service where vehicle_no=?)";
	
	private static final String UPDATE_SERVICE="update vehicle_service set vehicle_no=?,date=?,time=?, "
			+ " service_cost=?,present_skm=?,last_skm=?,vehicle_type=?,plant_id=? where vs_id=?";
	
	private static final String DELETE_SERVICE="delete from vehicle_service where vs_id=?";
	
	public ServiceDAOImpl() {
		con=DBUtil.getConnection();
	}
	
	@Override
	public int insertService(ServiceBean bean) throws Exception {
		ps=con.prepareStatement(INSERT_SERVICE);
		ps.setString(1, bean.getVehicle_no());
		ps.setString(2, bean.getDate());
		ps.setString(3, bean.getTime());
		ps.setDouble(4, bean.getService_cost());
		ps.setDouble(5, bean.getPresent_skm());
		ps.setDouble(6, bean.getLast_skm());
		ps.setString(7, bean.getVehicle());
		ps.setInt(8, bean.getPlant_id());
		int count=ps.executeUpdate();
		return count;
		
	}
	
	@Override
	public ServiceBean getLastServiceDetailsByVehicle(String vehicle_no) throws Exception {
		ps=con.prepareStatement(GET_SINGLE_VEHICLE_SERVICE_DETAILS);
		ps.setString(1, vehicle_no);
		rs=ps.executeQuery();
		if(rs.next()) {
			ServiceBean bean=new ServiceBean();
			bean.setPresent_skm(rs.getDouble("present_skm"));
			bean.setVehicle_no(rs.getString("vehicle_no"));
			return bean;
		}
		else
			return null;
	 }

	@Override
	public int updateService(ServiceBean bean) throws Exception {
		ps=con.prepareStatement(UPDATE_SERVICE);
		ps.setString(1, bean.getVehicle_no());
		ps.setString(2, bean.getDate());
		ps.setString(3, bean.getTime());
		ps.setDouble(4, bean.getService_cost());
		ps.setDouble(5, bean.getPresent_skm());
		ps.setDouble(6, bean.getLast_skm());
		ps.setString(7, bean.getVehicle());
		ps.setInt(8, bean.getPlant_id());
		ps.setLong(9, bean.getVs_id());
		int count=ps.executeUpdate();
		return count;
	}

	@Override
	public int deleteService(int vs_id) throws Exception {
		ps=con.prepareStatement(DELETE_SERVICE);
		ps.setInt(1,vs_id);
		int count=ps.executeUpdate();
		return count;
	}

}
