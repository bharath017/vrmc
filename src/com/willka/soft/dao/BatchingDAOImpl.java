package com.willka.soft.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import com.willka.soft.util.DBUtil;

public class BatchingDAOImpl implements BatchingDAO{

	private Connection con=null;
	private PreparedStatement ps=null;
	private ResultSet rs=null;
	
	private static final String GET_ALL_CUSTOMER_LIST="select distinct(CUSTOMER) from TRIPDETAIL order by CUSTOMER ASC";
	
	private static final String GET_COUNT_OF_BATCHING_LIST="select count(*) from TRIPDETAIL where (CUSTOMER LIKE ? or CUSTOMER IS NULL) and"
			+ " date(BATCHDATE) between if(''=?,'2014-01-01',?) and if(''=?,'2088-01-01',?)";
	
	private static final String GET_ALL_BATCHING_LIST="select BATCHID,TRIPNO,BATCHNO,CUSTOMER,RECIPE,SITE,TRUCK,DATE_FORMAT(BATCHDATE,'%d/%m/%Y %h:%m') as BATCHDATE,GRANDTOTAL"
			+ " from TRIPDETAIL "
			+ " WHERE (CUSTOMER LIKE ? or CUSTOMER IS NULL)"
			+ " and date(BATCHDATE) between if(''=?,'2014-01-01',?) and if(''=?,'2088-01-01',?)  "
			+ " order by BATCHID DESC "
			+ " limit ?,?";
	
	private static final String GET_TOTAL_TODAY_STOCK="select count(BATCHID) as batchid,ROUND(sum(BIN1),1) as bin1,ROUND(sum(BIN2),1) as bin2,"
			+ "ROUND(sum(BIN3),1) as bin3,ROUND(sum(BIN4),1) as bin4,"
			+ "ROUND(sum(CEMENT1),1) as cem1,ROUND(sum(CEMENT2),1) as cem2,ROUND(sum(ADDITIVE1),1) as add1,ROUND(sum(ADDITIVE2),1) as add2,"
			+ "ROUND(sum(WATER),1) as water,ROUND(sum(FLYASH),1) as flyash,ROUND(sum(TOTALWEIGHT),1) as tweight "
			+ " from ABATCHDETAIL where date(BATCHDATE) = curdate()";
	
	private static final String GET_SINGLE_TRIP_DETAILS="select T.*,DATE_FORMAT(T.BATCHDATE,'%d/%m/%Y %h:%m') as BATCHDATE from TRIPDETAIL T where TRIPNO=?";
	
	private static final String SINGLE_BATCH_LIST_DETAILS="select ROUND(BIN1,1) as bin1,ROUND(BIN2,1) as bin2,ROUND(BIN3,1) as bin3,ROUND(BIN4,1) as bin4,"
			+ "ROUND(CEMENT1,1) as cem1,ROUND(CEMENT2,1) AS cem2,ROUND(ADDITIVE1,1) as add1,ROUND(ADDITIVE2,1) as add2,ROUND(WATER,1) as water,"
			+ "ROUND(FLYASH,1) as flyash,ROUND(TOTALWEIGHT,1) as totalweight FROM  ABATCHDETAIL  where TRIPNO=?";
	
	
	
	
	
	public BatchingDAOImpl() {
		con=DBUtil.getConnection();
	}
	
	
	@Override
	public int countTotalBatchingCount(String from_date, String to_date, String customer_name) throws Exception {
		ps=con.prepareStatement(GET_COUNT_OF_BATCHING_LIST);
		ps.setString(1, "%"+customer_name+"%");
		ps.setString(2, from_date);
		ps.setString(3, from_date);
		ps.setString(4, to_date);
		ps.setString(5, to_date);
		rs=ps.executeQuery();
		if(rs.next())
			return rs.getInt(1);
		else
			return 0;
	}

	@Override
	public ArrayList<HashMap<String, Object>> getBatchingList(String from_date, String to_date, String customer_name,
			int start, int length) throws Exception {
		ps=con.prepareStatement(GET_ALL_BATCHING_LIST);
		ps.setString(1, "%"+customer_name+"%");
		ps.setString(2, from_date);
		ps.setString(3, from_date);
		ps.setString(4, to_date);
		ps.setString(5, to_date);
		ps.setInt(6, start);
		ps.setInt(7, length);
		rs=ps.executeQuery();
		ArrayList<HashMap<String, Object>> list=new ArrayList<HashMap<String,Object>>();
		while(rs.next()) {
			HashMap<String, Object> map=new HashMap<String, Object>();
			map.put("BATCHID", rs.getInt("BATCHID"));
			map.put("TRIPNO", rs.getInt("TRIPNO"));
			map.put("BATCHNO", rs.getInt("BATCHNO"));
			map.put("CUSTOMER", (rs.getString("CUSTOMER")==null)?"":rs.getString("CUSTOMER"));
			map.put("RECIPE", (rs.getString("RECIPE")==null)?"":rs.getString("RECIPE"));
			map.put("SITE", (rs.getString("SITE")==null)?"":rs.getString("SITE"));
			map.put("TRUCK", (rs.getString("TRUCK")==null)?"":rs.getString("TRUCK"));
			map.put("BATCHDATE", rs.getString("BATCHDATE"));
			map.put("GRANDTOTAL", rs.getDouble("GRANDTOTAL"));
			list.add(map);
		}
		return list;
	}

	@Override
	public ArrayList<String> getAllCustomerList() throws Exception {
		ps=con.prepareStatement(GET_ALL_CUSTOMER_LIST);
		rs=ps.executeQuery();
		ArrayList<String> list=new ArrayList<String>();
		while(rs.next()) {
			list.add(rs.getString(1));
		}
		return list;
	}

	@Override
	public HashMap<String, Object> getTotalQuantityOfStockToday() throws Exception {
		ps=con.prepareStatement(GET_TOTAL_TODAY_STOCK);
		rs=ps.executeQuery();
		HashMap<String, Object> map=new HashMap<String, Object>();
		if(rs.next()) {
			map.put("COUNT", rs.getInt("batchid"));
			map.put("RSAND", rs.getDouble("bin1"));
			map.put("CRUSHER", rs.getDouble("bin2"));
			map.put("jjj", rs.getDouble("bin3"));
			map.put("kkk", rs.getDouble("bin4"))  ;
			map.put("CEMENT1", rs.getDouble("cem1"));
			map.put("CEMENT2", rs.getDouble("cem2"));
			map.put("ADDITIVE1", rs.getDouble("add1"));
			map.put("ADDITIVE2", rs.getDouble("add2"));
			map.put("WATER", rs.getDouble("water"));
			map.put("FLYASH", rs.getDouble("flyash"));
			map.put("TOTAL WEIGHT", rs.getDouble("tweight"));
		}
		return map;
	}


	@Override
	public HashMap<String, Object> getSingleTripDetails(int BatchID) throws Exception {
		ps=con.prepareStatement(GET_SINGLE_TRIP_DETAILS);
		ps.setInt(1, BatchID);
		rs=ps.executeQuery();
		HashMap<String, Object> map=new HashMap<String, Object>();
		if(rs.next()) {
			map.put("CUSTOMER", rs.getString("CUSTOMER"));
			map.put("SITE", rs.getString("SITE"));
			map.put("TRUCK", rs.getString("TRUCK"));
			map.put("RECIPE", rs.getString("RECIPE"));
			map.put("BATCHNO", rs.getInt("BATCHNO"));
			map.put("ACTBATCH", rs.getInt("ACTBATCH"));
			map.put("TRIPNO", rs.getString("TRIPNO"));
			map.put("BATCHDATE", rs.getString("BATCHDATE"));
			map.put("AGG1", rs.getString("SETBIN1Material"));
			map.put("AGG2", rs.getString("SETBIN2Material"));
			map.put("AGG3", rs.getString("SETBIN3Material"));
			map.put("AGG5", rs.getString("SETBIN4Material"));
			map.put("AGG6", rs.getString("SETCEMENT1Material"));
			map.put("AGG7", rs.getString("SETCEMENT2Material"));
			map.put("AGG8", rs.getString("SETFLYASHMaterial"));
			map.put("AGG9", rs.getString("SETWATERMaterial"));
			map.put("AGG10", rs.getString("SETADDTIVE1Material"));
			map.put("AGG11", rs.getString("SETADDITIVE2Material"));
			map.put("total1", rs.getString("TOTALBIN1"));
			map.put("total2", rs.getString("TOTALBIN2"));
			map.put("total3", rs.getString("TOTALBIN3"));
			map.put("total4", rs.getString("TOTALBIN4"));
			map.put("total5", rs.getString("TOTALCEMENT1"));
			map.put("total6", rs.getString("TOTALCEMENT2"));
			map.put("total7", rs.getString("TOTALFLYASH"));
			map.put("total8", rs.getString("TOTALWATER"));
			map.put("total9", rs.getString("TOTALADDTIVE1"));
			map.put("total10", rs.getString("TOTALADDITIVE2"));
			map.put("set1", rs.getString("SETBIN1"));
			map.put("set2", rs.getString("SETBIN2"));
			map.put("set3", rs.getString("SETBIN3"));
			map.put("set4", rs.getString("SETBIN4"));
			map.put("set5", rs.getString("SETCEMENT1"));
			map.put("set6", rs.getString("SETCEMENT2"));
			map.put("set7", rs.getString("SETFLYASH"));
			map.put("set8", rs.getString("SETWATER"));
			map.put("set9", rs.getString("SETADDTIVE1"));
			map.put("set10", rs.getString("SETADDITIVE2"));
		}
		return map;
	}

	

	@Override
	public ArrayList<HashMap<String, Object>> getSingleBatchListDetails(int BatchID) throws Exception {
		ps=con.prepareStatement(SINGLE_BATCH_LIST_DETAILS);
		ps.setInt(1, BatchID);
		rs=ps.executeQuery();
		ArrayList<HashMap<String, Object>> list=new ArrayList<HashMap<String,Object>>();
		while(rs.next()) {
			HashMap<String, Object> map=new HashMap<String, Object>();
			map.put("bin1", rs.getDouble("bin1"));
			map.put("bin2", rs.getDouble("bin2"));
			map.put("bin3", rs.getDouble("bin3"));
			map.put("bin4", rs.getDouble("bin4"))  ;
			map.put("cem1", rs.getDouble("cem1"));
			map.put("cem2", rs.getDouble("cem2"));
			map.put("add1", rs.getDouble("add1"));
			map.put("add2", rs.getDouble("add2"));
			map.put("water", rs.getDouble("water"));
			map.put("flyash", rs.getDouble("flyash"));
			map.put("totalweight", rs.getDouble("totalweight"));
			list.add(map);
		}
		return list;
	}
	
	

	
	
	
	
	
}
