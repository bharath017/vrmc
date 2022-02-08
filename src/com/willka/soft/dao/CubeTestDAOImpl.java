package com.willka.soft.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.willka.soft.bean.CubeTestBean;
import com.willka.soft.bean.CubeTestItemBean;
import com.willka.soft.util.DBUtil;

public class CubeTestDAOImpl implements CubeTestDAO {

	private Connection con=null;
	private PreparedStatement ps=null;
	private ResultSet rs=null;
	
	//declare all query here
	private static final String INSERT_CUBE_TEST="insert into cube_test(customer_id,site_id,product_name,supply_date,testing_days,dimension,plant_id,test_id) values(?,?,?,?,?,?,?,?)";
	
	private static final String UPDATE_CUBE_TEST="update cube_test set customer_id=?,site_id=?,product_name=?,supply_date=?,testing_days=?,dimension=?,plant_id=? where tst_id=?";
	
	private static final String INSERT_CUBE_TEST_ITEM="insert into cube_test_item(tst_id,mass1,mass2,mass3,maxld1,maxld2,maxld3,cube_id) values(?,?,?,?,?,?,?,?)";
	
	private static final String UPDATE_CUBE_TEST_ITEM="update cube_test_item set mass1=?,mass2=?,mass3=?,maxld1=?,maxld2=?,maxld3=?,cube_id=? where tst_item_id=?";
	
	private static final String CANCEL_REPORT="update cube_test set cube_status='cancelled' where tst_id=?";
	
	private static final String GET_MAX_ID_USING_PLANT="select max(test_id) from cube_test where plant_id=?";
	
	private static final String GET_MAX_CUBE_ID="select max(tst_id) from cube_test";
	
	private static final String GET_DATE_LIST="select distinct(i.invoice_date) as supply_date from invoice i LEFT JOIN(purchase_order_item poi,product p) "
			+ " ON i.poi_id=poi.poi_id and poi.product_id=p.product_id where p.product_name=? and i.customer_id=? and i.site_id=?";
	
	public CubeTestDAOImpl() {
		con=DBUtil.getConnection();
	}
	
	@Override
	public int insertCubeTest(CubeTestBean bean) throws Exception {
		ps=con.prepareStatement(INSERT_CUBE_TEST);
		ps.setInt(1, bean.getCustomer_id());
		ps.setInt(2, bean.getSite_id());
		ps.setString(3, bean.getProduct_name());
		ps.setString(4, bean.getSupply_date());
		ps.setInt(5, bean.getTesting_days());
		ps.setInt(6, bean.getDimension());
		ps.setInt(7, bean.getPlant_id());
		ps.setInt(8, bean.getTest_id());
		int count=ps.executeUpdate();
		return count;
	}

	@Override
	public int updateCubeTest(CubeTestBean bean) throws Exception {
		ps=con.prepareStatement(UPDATE_CUBE_TEST);
		ps.setInt(1, bean.getCustomer_id());
		ps.setInt(2, bean.getSite_id());
		ps.setString(3, bean.getProduct_name());
		ps.setString(4, bean.getSupply_date());
		ps.setInt(5, bean.getTesting_days());
		ps.setInt(6, bean.getDimension());
		ps.setInt(7, bean.getPlant_id());
		ps.setInt(8, bean.getTst_id());
		int count=ps.executeUpdate();
		return count;
	}

	@Override
	public int cancelReport(int tst_id) throws Exception {
		ps=con.prepareStatement(CANCEL_REPORT);
		ps.setInt(1, tst_id);
		int count=ps.executeUpdate();
		return count;
	}

	@Override
	public int getMaxTestIdUsingPlant(int plant_id) throws Exception {
		ps=con.prepareStatement(GET_MAX_ID_USING_PLANT);
		ps.setInt(1, plant_id);
		rs=ps.executeQuery();
		if(rs.next()) {
			return rs.getInt(1);
		}else {
			return 0;
		}
	}

	@Override
	public int insertCubeTestItem(CubeTestItemBean bean) throws Exception {
		ps=con.prepareStatement(INSERT_CUBE_TEST_ITEM);
		ps.setInt(1, bean.getTst_id());
		ps.setDouble(2, bean.getMass1());
		ps.setDouble(3, bean.getMass2());
		ps.setDouble(4, bean.getMass3());
		ps.setDouble(5, bean.getMaxld1());
		ps.setDouble(6, bean.getMaxld2());
		ps.setDouble(7, bean.getMaxld3());
		ps.setString(8, bean.getCube_id());
		int count=ps.executeUpdate();
		return count;
	}

	@Override
	public int updateCubeTestItem(CubeTestItemBean bean) throws Exception {
		ps=con.prepareStatement(UPDATE_CUBE_TEST_ITEM);
		ps.setDouble(1, bean.getMass1());
		ps.setDouble(2, bean.getMass2());
		ps.setDouble(3, bean.getMass3());
		ps.setDouble(4, bean.getMaxld1());
		ps.setDouble(5, bean.getMaxld2());
		ps.setDouble(6, bean.getMaxld3());
		ps.setString(7, bean.getCube_id());
		ps.setInt(8, bean.getTst_item_id());
		int count=ps.executeUpdate();
		return count;
	}

	@Override
	public int getLatestCubeTest() throws Exception {
		ps=con.prepareStatement(GET_MAX_CUBE_ID);
		rs=ps.executeQuery();
		if(rs.next()) {
			return rs.getInt(1);
		}else {
			return 0;
		}
	}

	@Override
	public List<String> getSupplyList(int customer_id,int site_id,String product_name) throws Exception {
		ps=con.prepareStatement(GET_DATE_LIST);
		ps.setString(1, product_name);
		ps.setInt(2, customer_id);
		ps.setInt(3, site_id);
		rs=ps.executeQuery();
		List<String> list=new ArrayList<>();
		while(rs.next()) {
			list.add(rs.getString("supply_date"));
		}
		return list;
	}

}
