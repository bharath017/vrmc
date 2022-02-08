package com.willka.soft.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.willka.soft.bean.VehicleRepairBean;
import com.willka.soft.util.DBUtil;

public class RepairDAOImpl implements RepairDAO {
	
	private Connection con=null;
	private PreparedStatement ps=null;
	private ResultSet rs=null;
	
	
	private static final String INSERT_REPAIR="insert into repair (vehicle_no,repair_date,repair_time, "
			+ " repair_cost,description,remarks,place,vendor,plant_id,received_person) values(?,?,?,?,?,?,?,?,?,?)";
	
	private static final String UPDATE_REPAIR="update repair  set vehicle_no=?,repair_date=?,repair_time=?, "
			+ " repair_cost=?,description=?,remarks=?,place=?,vendor=?,plant_id=?,received_person=? where gp_no=?";
	
	private static final String DELETE_REPAIR="delete from repair where gp_no=?";
	
	
	public RepairDAOImpl() {
		con=DBUtil.getConnection();
	}

	@Override
	public int insertRepair(VehicleRepairBean bean) throws Exception {
		ps=con.prepareStatement(INSERT_REPAIR);
		ps.setString(1, bean.getVehicle_no());
		ps.setString(2, bean.getRepair_date());
		ps.setString(3, bean.getRepair_time());
		ps.setDouble(4, bean.getRepair_cost());
		ps.setString(5, bean.getDescription());
		ps.setString(6, bean.getRemarks());
		ps.setString(7, bean.getPlace());
		ps.setString(8, bean.getVendor());
		ps.setInt(9, bean.getPlant_id());
		ps.setString(10, bean.getReceived_person());
		int count=ps.executeUpdate();
		return count;
	}

	@Override
	public int updateRepair(VehicleRepairBean bean) throws Exception {
		ps=con.prepareStatement(UPDATE_REPAIR);
		ps.setString(1, bean.getVehicle_no());
		ps.setString(2, bean.getRepair_date());
		ps.setString(3, bean.getRepair_time());
		ps.setDouble(4, bean.getRepair_cost());
		ps.setString(5, bean.getDescription());
		ps.setString(6, bean.getRemarks());
		ps.setString(7, bean.getPlace());
		ps.setString(8, bean.getVendor());
		ps.setInt(9, bean.getPlant_id());
		ps.setString(10, bean.getReceived_person());
		ps.setInt(11, bean.getGp_no());
		int count=ps.executeUpdate();
		return count;
	}

	@Override
	public int deleteRepair(int gp_no) throws Exception {
		ps=con.prepareStatement(DELETE_REPAIR);
		ps.setInt(1,gp_no);
		int count=ps.executeUpdate();
		return count;
	}

}
