package com.willka.soft.test.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.willka.soft.test.bean.CubeTestBean;
import com.willka.soft.util.DBUtil;

public class CubeTestDAOImpl implements CubeTestDAO {

	private Connection con=null;
	private PreparedStatement ps=null;
	private ResultSet rs=null;
	
	//declare all query here
	private static final String INSERT_CUBE_TEST="insert into test_cube_test(customer_id,site_id,product_name,supply_date,testing_days,mass1,mass2,mass3,maxld1,maxld2,maxld3,dimension,plant_id,test_id) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
	
	private static final String UPDATE_CUBE_TEST="update test_cube_test set customer_id=?,site_id=?,product_name=?,supply_date=?,testing_days=?,mass1=?,mass2=?,mass3=?,maxld1=?,maxld2=?,maxld3=?,dimension=?,plant_id=? where tst_id=?";
	
	private static final String CANCEL_REPORT="update test_cube_test set cube_status='cancelled' where tst_id=?";
	
	private static final String GET_MAX_CUBE_TEST_ID="select max(test_id) as test_id from test_cube_test where plant_id=?";
	
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
		ps.setDouble(6, bean.getMass1());
		ps.setDouble(7, bean.getMass2());
		ps.setDouble(8, bean.getMass3());
		ps.setDouble(9, bean.getMaxld1());
		ps.setDouble(10, bean.getMaxld2());
		ps.setDouble(11, bean.getMaxld3());
		ps.setInt(12, bean.getDimension());
		ps.setInt(13, bean.getPlant_id());
		ps.setInt(14, bean.getTest_id());
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
		ps.setDouble(6, bean.getMass1());
		ps.setDouble(7, bean.getMass2());
		ps.setDouble(8, bean.getMass3());
		ps.setDouble(9, bean.getMaxld1());
		ps.setDouble(10, bean.getMaxld2());
		ps.setDouble(11, bean.getMaxld3());
		ps.setInt(12, bean.getDimension());
		ps.setInt(13, bean.getPlant_id());
		ps.setInt(14, bean.getTst_id());
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
	public int getMaxCubeTestId(int plant_id) throws Exception {
		ps=con.prepareStatement(GET_MAX_CUBE_TEST_ID);
		ps.setInt(1, plant_id);
		rs=ps.executeQuery();
		if(rs.next()) {
			return rs.getInt(1);
		}else {
			return 0;
		}
	}

}
