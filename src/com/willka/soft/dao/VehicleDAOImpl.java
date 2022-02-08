package com.willka.soft.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.willka.soft.bean.VehiclesBean;
import com.willka.soft.util.DBUtil;

public class VehicleDAOImpl implements VehicleDAO{
	//declare all database variable here
	Connection con=null;
	PreparedStatement ps,ps1=null;
	ResultSet rs,rs1=null;
	
	//all query declared here
	private static final String INSERT_QUERY="insert into vehicle(vehicle_no,"
			+ "vehicle_name,driver_name,insurance_valid_till,insurance_no,vehicle_type,"
			+ "	meter_reading,fc_date,tax_date,vehicle_weight,vehicle_cat) values(?,?,?,?,?,?,?,?,?,?,?)";
	
	private static final String UPDATE_QUERY="update vehicle set vehicle_name=?, driver_name=?, insurance_valid_till=?, insurance_no=?, vehicle_type=?, meter_reading=?, fc_date=?, tax_date=?, vehicle_weight=?,vehicle_cat=?  where vehicle_no=?";
	
	private static final String DELETE_VEHICLE="delete from vehicle where vehicle_no=?";
	
	private static final String GET_ALL_VEHICLE_FOR_OPTION="select vehicle_no from vehicle";
	
	private static final String SELECT_ALL_VEHICLE="select * from vehicle";
	
	private static final String SELECT_FROM_RENTAL_VEHICLE="select * from rental_vehicle where vehicle_no=?";
	
	private static final String GET_ALL_OWN_VEHICLE="select * from vehicle where vehicle_type='own'";
	
	private static final String GET_ALL_RENTAL_VEHICLE="select * from vehicle where vehicle_type='rental'";
	
	private static final String GET_SINGLE_VEHICLE_INFORMATION_USING_VEHICLE_NUMBER="select * from  vehicle where vehicle_no=?";
	
	private static final String UPDATE_METER_READING="update vehicle set meter_reading=? where vehicle_no=?";
	
	private static final String UPDATE_EMPTY_VEHICLE="update vehicle set empty_weight=? where vehicle_no=?";
	
	private static final String UPDATE_LOADED_VEHICLE="update vehicle set loaded_weight=? where vehicle_no=?";
	
	private static final String GET_EMPTY_WEIGHT="select empty_weight from vehicle where vehicle_no=?";
	
	private static final String GET_LOADED_WEIGHT="select loaded_weight from vehicle where vehicle_no=?";
	
	private static final String GET_LAST_TICKET_RISED="select max(t_id) from ticket where vehicle_no=?";
	
	
	public VehicleDAOImpl() {
		con=DBUtil.getConnection();
	}
	
	
	public int insertVehicleDetail(VehiclesBean bean) throws Exception {
		int count=0;
		//connect to the database
		ps=con.prepareStatement(INSERT_QUERY);
		ps.setString(1, bean.getVehicle_no());
		ps.setString(2, bean.getVehicle_name());
		ps.setString(3, bean.getDriver_name());
		ps.setString(4, bean.getInsurance_valid_till());
		ps.setString(5, bean.getInsurance_no());
		ps.setString(6, bean.getVehicle_type());
		ps.setDouble(7, bean.getMeter_reading());
		ps.setString(8, bean.getFc_date());
		ps.setString(9, bean.getTax_date());
		ps.setDouble(10, bean.getVehicle_weight());
		ps.setString(11, (bean.getVehicle_cat()==null)?"Km":bean.getVehicle_cat());
		count=ps.executeUpdate();
		return count;
	}
	
	@Override
	public int updateVehicleDetail(VehiclesBean bean) throws Exception {
		int count=0;
		//connect to the database
		con=DBUtil.getConnection();
		ps=con.prepareStatement(UPDATE_QUERY);
		ps.setString(11, bean.getVehicle_no());
		ps.setString(1, bean.getVehicle_name());
		ps.setString(2, bean.getDriver_name());
		ps.setString(3, bean.getInsurance_valid_till());
		ps.setString(4, bean.getInsurance_no());
		ps.setString(5, bean.getVehicle_type());
		ps.setDouble(6, bean.getMeter_reading());
		ps.setString(7, bean.getFc_date());
		ps.setString(8, bean.getTax_date());
		ps.setDouble(9, bean.getVehicle_weight());
		ps.setString(10, (bean.getVehicle_cat()==null)?"KM":bean.getVehicle_cat());
		count=ps.executeUpdate();
		return count;
	}
	@Override
	public int deleteVehicleSingleVehicle(String vehicle_no) throws Exception {
		int count=0;
		con=DBUtil.getConnection();
		ps=con.prepareStatement(DELETE_VEHICLE);
		ps.setString(1, vehicle_no);
		count=ps.executeUpdate();
		return count;
	}
	@Override
	public ArrayList<VehiclesBean> getAllVehicle() throws Exception {
		//get connection object
		con=DBUtil.getConnection();
		ps=con.prepareStatement(SELECT_ALL_VEHICLE,ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
		rs=ps.executeQuery();
		//create VehicleBean list object
		ArrayList<VehiclesBean> vehicle_list=new ArrayList<VehiclesBean>();
		while(rs.next()){
		//create VehicleBean object
		VehiclesBean bean=new VehiclesBean();
		bean.setVehicle_no(rs.getString("vehicle_no"));
		bean.setVehicle_name(rs.getString("vehicle_name"));
		bean.setPlant_id(rs.getInt("plant_id"));
		bean.setLocation(rs.getString("location"));
		bean.setInsurance_valid_till(rs.getString("insurance_valid_till"));
		bean.setInsurance_no(rs.getString("insurance_no"));
		bean.setVehicle_type(rs.getString("vehicle_type"));
		bean.setMeter_reading(rs.getDouble("meter_reading"));
		bean.setFc_date(rs.getString("fc_date"));
		bean.setTax_date(rs.getString("tax_date"));
		if(rs.getString("vehicle_type").equals("rental")){
			//get rental vehicle information
			ps1=con.prepareStatement(SELECT_FROM_RENTAL_VEHICLE);
			ps1.setString(1, rs.getString("vehicle_no"));
			rs1=ps1.executeQuery();
			rs1.next();
			bean.setFrom_date(rs1.getString("rental_start_date"));
			bean.setTo_date(rs1.getString("rental_end_date"));
			bean.setAmount(rs1.getString("rental_amount"));
		}
		
		bean.setDriver_name(rs.getString("driver_name"));
		vehicle_list.add(bean);
		}
		return vehicle_list;

	}
	@Override
	public ArrayList<VehiclesBean> getOwnVehicle() throws Exception {
		//get connection object
				con=DBUtil.getConnection();
				ps=con.prepareStatement(GET_ALL_OWN_VEHICLE,ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
				rs=ps.executeQuery();
				//create VehicleBean list object
				ArrayList<VehiclesBean> vehicle_list=new ArrayList<VehiclesBean>();
				while(rs.next()){
				//create VehicleBean object
				VehiclesBean bean=new VehiclesBean();
				bean.setVehicle_no(rs.getString("vehicle_no"));
				bean.setVehicle_name(rs.getString("vehicle_name"));
				bean.setPlant_id(rs.getInt("plant_id"));
				bean.setLocation(rs.getString("location"));
				bean.setInsurance_valid_till(rs.getString("insurance_valid_till"));
				bean.setInsurance_no(rs.getString("insurance_no"));
				bean.setVehicle_type(rs.getString("vehicle_type"));
				bean.setDriver_name(rs.getString("driver_name"));
				bean.setMeter_reading(rs.getDouble("meter_reading"));
				bean.setFc_date(rs.getString("fc_date"));
				bean.setTax_date(rs.getString("tax_date"));
				vehicle_list.add(bean);
				}
				return vehicle_list;
	}
	@Override
	public ArrayList<VehiclesBean> getRentalVehicle() throws Exception {
		con=DBUtil.getConnection();
		ps=con.prepareStatement(GET_ALL_RENTAL_VEHICLE,ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
		rs=ps.executeQuery();
		//create VehicleBean list object
		ArrayList<VehiclesBean> vehicle_list=new ArrayList<VehiclesBean>();
		while(rs.next()){
		//create VehicleBean object
		VehiclesBean bean=new VehiclesBean();
		bean.setVehicle_no(rs.getString("vehicle_no"));
		bean.setVehicle_name(rs.getString("vehicle_name"));
		bean.setPlant_id(rs.getInt("plant_id"));
		bean.setLocation(rs.getString("location"));
		bean.setInsurance_valid_till(rs.getString("insurance_valid_till"));
		bean.setInsurance_no(rs.getString("insurance_no"));
		bean.setVehicle_type(rs.getString("vehicle_type"));
		bean.setDriver_name(rs.getString("driver_name"));
		bean.setMeter_reading(rs.getDouble("meter_reading"));
		bean.setFc_date(rs.getString("fc_date"));
		bean.setTax_date(rs.getString("tax_date"));
		ps1=con.prepareStatement(SELECT_FROM_RENTAL_VEHICLE);
		ps1.setString(1, rs.getString("vehicle_no"));
		rs1=ps1.executeQuery();
		rs1.next();
		bean.setFrom_date(rs1.getString("rental_start_date"));
		bean.setTo_date(rs1.getString("rental_end_date"));
		bean.setAmount(rs1.getString("rental_amount"));
		vehicle_list.add(bean);
		}
		return vehicle_list;
	}
	@Override
	public VehiclesBean getVehicleDetailUsingVehicleNo(String vehicle_number) throws Exception {
		con=DBUtil.getConnection();
		ps=con.prepareStatement(GET_SINGLE_VEHICLE_INFORMATION_USING_VEHICLE_NUMBER);
		ps.setString(1, vehicle_number);
		rs=ps.executeQuery();
		//create vechile bean object
		VehiclesBean bean=new VehiclesBean();
		if(rs.next()){
			bean.setVehicle_no(rs.getString("vehicle_no"));
			bean.setVehicle_name(rs.getString("vehicle_name"));
			bean.setVehicle_type(rs.getString("vehicle_type"));
			bean.setDriver_name(rs.getString("driver_name"));
			bean.setMeter_reading(rs.getDouble("meter_reading"));
			return bean;
		}
		else
		return null;
	}
	@Override
	public int updateVehicleMeterReading(String vehicle_no, double meter_reading) throws Exception {
		ps=con.prepareStatement(UPDATE_METER_READING);
		ps.setString(2, vehicle_no);
		ps.setDouble(1, meter_reading);
		int count=ps.executeUpdate();
		return count;
	}
	
	

	@Override
	public int updateEmptyWeight(String vehicle_no, double empty_weight) throws Exception {
		ps=con.prepareStatement(UPDATE_EMPTY_VEHICLE);
		ps.setDouble(1, empty_weight);
		ps.setString(2, vehicle_no);
		int count=ps.executeUpdate();
		return count;
	}


	@Override
	public int updateLoadedWeight(String vehicle_no, double loaded_weight) throws Exception {
		ps=con.prepareStatement(UPDATE_LOADED_VEHICLE);
		ps.setDouble(1, loaded_weight);
		ps.setString(2, vehicle_no);
		int  count=ps.executeUpdate();
		return count;
	}


	@Override
	public double getEmptyWeight(String vehicle_no) throws Exception {
		ps=con.prepareStatement(GET_EMPTY_WEIGHT);
		ps.setString(1, vehicle_no);
		rs=ps.executeQuery();
		if(rs.next()) {
			return rs.getDouble("empty_weight");
		}else {
			return 0.0;
		}
	}


	@Override
	public double getLoadedWeight(String vehicle_no) throws Exception {
		ps=con.prepareStatement(GET_LOADED_WEIGHT);
		ps.setString(1,vehicle_no);
		rs=ps.executeQuery();
		if(rs.next()) {
			return rs.getDouble(1);
		}else {
			return 0.0;
		}
	}


	@Override
	public int getLastTicketRised(String vehicle_no) throws Exception {
		ps=con.prepareStatement(GET_LAST_TICKET_RISED);
		ps.setString(1,vehicle_no);
		rs=ps.executeQuery();
		if(rs.next()) {
		return rs.getInt(1);
		}else {
			return 0;
		}
	}


	@Override
	public List<String> getAllVehicleForOption() throws Exception {
		ps=con.prepareStatement(GET_ALL_VEHICLE_FOR_OPTION);
		rs=ps.executeQuery();
		List<String> data=new ArrayList<String>();
		while(rs.next()) {
			data.add(rs.getString("vehicle_no"));
		}
		return data;
	}
	

	
}
