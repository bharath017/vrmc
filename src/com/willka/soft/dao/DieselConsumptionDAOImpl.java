package com.willka.soft.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.willka.soft.bean.DieselConsumptionBean;
import com.willka.soft.bean.DieselModificationBean;
import com.willka.soft.util.DBUtil;

public class DieselConsumptionDAOImpl implements DieselConsumptionDAO{
	
	private Connection con=null;
	private PreparedStatement ps=null;
	private ResultSet rs=null;
	
	private static final String INSERT_DIESEL_CONSUMPTION="insert into diesel_consumption(vehicle_no,issued_date,issued_time, "
			+ " issued_quantity,opening_km,closing_km,driver_name,issued_person,plant_id) values(?,?,?,?,?,?,?,?,?)";
	
	private static final String UPDATE_DIESEL_CONSUMPTION="update diesel_consumption set vehicle_no=?,issued_date=?,issued_time=?, "
			+ " issued_quantity=?,opening_km=?,closing_km=?,driver_name=?,issued_person=?,plant_id=? where diesel_id=?";
	
	private static final String DELETE_DIESEL_CONSUMPTION="delete from diesel_consumption where diesel_id=?";
	
	private static final String GET_SINGLE_VEHICLE_CONSUMPTION_DETAILS="select * from diesel_consumption "
			+ " where diesel_id=(select max(diesel_id) from diesel_consumption where vehicle_no=?)";
	
	private static final String INSERT_DIESEL_MODIFICATION="insert into diesel_modification(diesel_id,old_quantity,new_quantity,modification_type,modified_by,comment) "
			+ "values(?,?,?,?,?,?)";
	
	private static final String GET_SINGLE_DIESEL_BY_DIESEL_ID="select * from diesel_consumption where diesel_id=?";
	
	
	
	
	
	
	
			
	
	
	
	public DieselConsumptionDAOImpl() {
		con=DBUtil.getConnection();
	}
	
	@Override
	public int insertDieselConsumption(DieselConsumptionBean bean) throws Exception {
		ps=con.prepareStatement(INSERT_DIESEL_CONSUMPTION);
		ps.setString(1, bean.getVehicle_no());
		ps.setString(2, bean.getIssued_date());
		ps.setString(3, bean.getIssued_time());
		ps.setDouble(4, bean.getIssued_quantity());
		ps.setDouble(5, bean.getOpning_km());
		ps.setDouble(6, bean.getClosing_km());
		ps.setString(7, bean.getDriver_name());
		ps.setString(8, bean.getIssued_person());
		ps.setInt(9, bean.getPlant_id());
		int count=ps.executeUpdate();
		return count;
	}

	@Override
	public DieselConsumptionBean getLastConsumptionDetailsByVehicle(String vehicle_no) throws Exception {
		ps=con.prepareStatement(GET_SINGLE_VEHICLE_CONSUMPTION_DETAILS);
		ps.setString(1, vehicle_no);
		rs=ps.executeQuery();
		if(rs.next()) {
			DieselConsumptionBean bean=new DieselConsumptionBean();
			bean.setDriver_name(rs.getString("driver_name"));
			bean.setClosing_km(rs.getDouble("closing_km"));
			bean.setIssued_date(rs.getString("issued_date"));
			bean.setOpning_km(rs.getDouble("opening_km"));
			bean.setIssued_person(rs.getString("issued_person"));
			bean.setIssued_quantity(rs.getDouble("issued_quantity"));
			bean.setVehicle_no(rs.getString("vehicle_no"));
			return bean;
		}
		else
			return null;
	 }

	@Override
	public int insertdieselModificationDetails(DieselModificationBean bean) throws Exception {
		ps=con.prepareStatement(INSERT_DIESEL_MODIFICATION);
		ps.setInt(1, bean.getDiesel_id());
		ps.setDouble(2, bean.getOld_quantity());
		ps.setDouble(3, bean.getNew_quantity());
		ps.setString(4, bean.getModification_type());
		ps.setString(5, bean.getModified_by());
		ps.setString(6, bean.getComment());
		int count=ps.executeUpdate();
		return count;
	}

	@Override
	public DieselConsumptionBean getSingleDeiselDetailsByDieselId(int diesel_id) throws Exception {
		ps=con.prepareStatement(GET_SINGLE_DIESEL_BY_DIESEL_ID);
		ps.setLong(1, diesel_id);
		rs=ps.executeQuery();
		if(rs.next()) {
			DieselConsumptionBean bean=new DieselConsumptionBean();
			bean.setConsumption_id(rs.getLong("diesel_id"));
			bean.setIssued_date(rs.getString("issued_date"));
			bean.setIssued_time(rs.getString("issued_time"));
			bean.setIssued_quantity(rs.getDouble("issued_quantity"));
			bean.setClosing_km(rs.getDouble("closing_km"));
			bean.setOpning_km(rs.getDouble("opening_km"));
			bean.setIssued_person(rs.getString("issued_person"));
			return bean;
		}
		else
			return null;
	}

	@Override
	public int updateDieselConsumption(DieselConsumptionBean bean) throws Exception {
		ps=con.prepareStatement(UPDATE_DIESEL_CONSUMPTION);
		ps.setString(1, bean.getVehicle_no());
		ps.setString(2, bean.getIssued_date());
		ps.setString(3, bean.getIssued_time());
		ps.setDouble(4, bean.getIssued_quantity());
		ps.setDouble(5, bean.getOpning_km());
		ps.setDouble(6, bean.getClosing_km());
		ps.setString(7, bean.getDriver_name());
		ps.setString(8, bean.getIssued_person());
		ps.setInt(9, bean.getPlant_id());
		ps.setLong(10, bean.getConsumption_id());
		int count=ps.executeUpdate();
		return count;
	}

	@Override
	public int deleteDieselConsumption(int diesel_id) throws Exception {
		ps=con.prepareStatement(DELETE_DIESEL_CONSUMPTION);
		ps.setInt(1,diesel_id);
		int count=ps.executeUpdate();
		return count;
	}

	
	

}
