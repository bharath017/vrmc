package com.willka.soft.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import com.willka.soft.util.DBUtil;

public class HRMSettingDAOImpl implements HRMSettingDAO{
	
	private Connection con=null;
	private PreparedStatement ps=null;
	private ResultSet rs=null;
	
	
	
	private static final String INSERT_DESIGNATION="insert into designation(designation_name) values(?)";
	
	private static final String UPDATE_DESIGNATION="update designation set designation_name=? where designation_id=?";
	
	private static final String DELETE_DESIGNATION="delete from designation where designation_id=?";
	
	private static final String GET_DESIGNATION_LIST="select * from designation where designation_name like ? order by designation_id desc limit ?,?";
	
	private static final String GET_DESIGNATION_COUNT="select count(designation_id) from designation where designation_name like ?";
	
	private static final String INSERT_DEPARTMENT="insert into department(department_name) values(?)";
	
	private static final String UPDATE_DEPARTMENT="update department set department_name=? where department_id=?";
	
	private static final String DELETE_DEPARTMENT="delete from department where department_id=?";
	
	private static final String GET_ALL_DEPARTMENT_LIST="select * from department where department_name like ? order by department_id desc limit ?,?";
	
	private static final String COUNT_ALL_DEPARTMENT_LIST="select count(department_id) from department where department_name like ?";
	
	
	
	public HRMSettingDAOImpl() {
		con=DBUtil.getConnection();
	}


	@Override
	public int insertDesignation(String designation) throws Exception {
		ps=con.prepareStatement(INSERT_DESIGNATION);
		ps.setString(1, designation);
		int count=ps.executeUpdate();
		return count;
	}

	@Override
	public int updateDesignation(int designation_id, String designation) throws Exception {
		ps=con.prepareStatement(UPDATE_DESIGNATION);
		ps.setString(1, designation);
		ps.setInt(2, designation_id);
		int count=ps.executeUpdate();
		return count;
	}

	@Override
	public int deleteDesignation(int designation_id) throws Exception {
		ps=con.prepareStatement(DELETE_DESIGNATION);
		ps.setInt(1,designation_id);
		int count=ps.executeUpdate();
		return count;
	}
	

	@Override
	public ArrayList<HashMap<String, Object>> getDesignationList(int start, int length, String search)
			throws Exception {
		ps=con.prepareStatement(GET_DESIGNATION_LIST);
		ps.setString(1, "%"+search+"%");
		ps.setInt(2, start);
		ps.setInt(3, length);
		rs=ps.executeQuery();
		ArrayList<HashMap<String, Object>> list=new ArrayList<HashMap<String,Object>>();
		int count=1;
		while(rs.next()) {
			HashMap<String , Object> map=new HashMap<String, Object>();
			map.put("count", count);
			map.put("designation_id", rs.getInt("designation_id"));
			map.put("designation_name", rs.getString("designation_name"));
			list.add(map);
			count++;
		}
		return list;
	}

	@Override
	public int countDesignationList(String search) throws Exception {
		ps=con.prepareStatement(GET_DESIGNATION_COUNT);
		ps.setString(1, "%"+search+"%");
		rs=ps.executeQuery();
		if(rs.next()) {
			return rs.getInt(1);
		}else
			return 0;
	}

	@Override
	public int insertDepartment(String department_name) throws Exception {
		ps=con.prepareStatement(INSERT_DEPARTMENT);
		ps.setString(1, department_name);
		int count=ps.executeUpdate();
		return count;
	}
	

	@Override
	public int updateDepartment(String department_name, int department_id) throws Exception {
		ps=con.prepareStatement(UPDATE_DEPARTMENT);
		ps.setString(1, department_name);
		ps.setInt(2, department_id);
		int count=ps.executeUpdate();
		return count;
	}

	@Override
	public int deleteDepartment(int department_id) throws Exception {
		ps=con.prepareStatement(DELETE_DEPARTMENT);
		ps.setInt(1, department_id);
		int count=ps.executeUpdate();
		return count;
	}

	@Override
	public ArrayList<HashMap<String, Object>> getAllDepartmentList(String search, int start, int length)
			throws Exception {
		ps=con.prepareStatement(GET_ALL_DEPARTMENT_LIST);
		ps.setString(1, "%"+search+"%");
		ps.setInt(2,start);
		ps.setInt(3, length);
		rs=ps.executeQuery();
		ArrayList<HashMap<String, Object>> list=new ArrayList<HashMap<String,Object>>();
		while(rs.next()) {
			HashMap<String, Object> map=new HashMap<String, Object>();
			map.put("department_id", rs.getInt("department_id"));
			map.put("department_name", rs.getString("department_name"));
			list.add(map);
		}
		return list;
	}

	@Override
	public int countAllDepartmentList(String search) throws Exception {
		ps=con.prepareStatement(COUNT_ALL_DEPARTMENT_LIST);
		ps.setString(1, "%"+search+"%");
		rs=ps.executeQuery();
		if(rs.next())
			return rs.getInt(1);
		else
			return 0;
	}

	

}
