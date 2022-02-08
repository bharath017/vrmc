package com.willka.soft.test.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Types;

import com.willka.soft.test.bean.MixDesignBean;
import com.willka.soft.util.DBUtil;

public class MixDesignDAOImpl implements MixDesignDAO {
	
	private Connection con=null;
	private ResultSet rs=null;
	private PreparedStatement ps=null;
	private CallableStatement cs=null;
	
	//write all query here
	private static final String INSERT_MIX_DESIGN="INSERT INTO mix_design (recipe_code, recipe_name, aggregate1_name, aggregate1_value, aggregate2_name, aggregate2_value, aggregate3_name, aggregate3_value, aggregate4_name, aggregate4_value, aggregate5_name, aggregate5_value, aggregate6_name, aggregate6_value, aggregate7_name, aggregate7_value, aggregate8_name, aggregate8_value, aggregate9_name, aggregate9_value, aggregate10_name, aggregate10_value, aggregate11_name, aggregate11_value) VALUES (?,?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
	
	private static final String UPDATE_MIX_DESIGN="update mix_design set recipe_code=?, recipe_name=?, aggregate1_name=?, aggregate1_value=?, aggregate2_name=?, aggregate2_value=?, aggregate3_name=?, aggregate3_value=?, aggregate4_name=?, aggregate4_value=?, aggregate5_name=?, aggregate5_value=?, aggregate6_name=?, aggregate6_value=?, aggregate7_name=?, aggregate7_value=?, aggregate8_name=?, aggregate8_value=?, aggregate9_name=?, aggregate9_value=?, aggregate10_name=?, aggregate10_value=?, aggregate11_name=?, aggregate11_value=? where design_id=?";
	
	private static final String INSERT_RECEIPE="INSERT INTO test_receipe (customer_id,site_id,plant_id,product_id,recipe_code,"
			+ " aggregate1_name, aggregate1_value, aggregate2_name, aggregate2_value, aggregate3_name,"
			+ " aggregate3_value, aggregate4_name, aggregate4_value, aggregate5_name, aggregate5_value,"
			+ " aggregate6_name, aggregate6_value, aggregate7_name, aggregate7_value, aggregate8_name,"
			+ " aggregate8_value, aggregate9_name, aggregate9_value, aggregate10_name, aggregate10_value,"
			+ " aggregate11_name,aggregate11_value,cement_name) VALUES (?,?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? , ?, ?, ?, ?)";
	
	private static final String UPDATE_RECEIPE="update test_receipe set customer_id=?,site_id=?,plant_id=?,product_id=?,"
			+ "recipe_code=?, aggregate1_name=?, aggregate1_value=?, aggregate2_name=?, aggregate2_value=?,"
			+ " aggregate3_name=?, aggregate3_value=?, aggregate4_name=?, aggregate4_value=?, aggregate5_name=?,"
			+ " aggregate5_value=?, aggregate6_name=?, aggregate6_value=?, aggregate7_name=?, aggregate7_value=?,"
			+ " aggregate8_name=?, aggregate8_value=?, aggregate9_name=?, aggregate9_value=?, aggregate10_name=?,"
			+ " aggregate10_value=?, aggregate11_name=?, aggregate11_value=?,cement_name=? where receipe_id=?";
	
	private static final String DELETE_RECEIPE="delete from test_receipe where receipe_id=?";
	
	private static final String GET_SINGLE_MIX_DESIGN="select * from mix_design where recipe_code=?";
	
	private static final String DELETE_MIX_DESIGN="delete from mix_design where design_id=?";
	
	private static final String GET_SINGLE_RECEIPE="select r.*,c.customer_name,s.site_name,p.product_name from test_receipe r LEFT JOIN (test_customer c,test_site_detail s,product p) ON r.customer_id=c.customer_id and r.site_id=s.site_id and r.product_id=p.product_id where receipe_id=?";
	
	private static final String GENERATE_BATCH_SLIP="call batchsheetsave(?,?)";
	

	public MixDesignDAOImpl() {
		con=DBUtil.getConnection();
	}
	
	@Override
	public int insertMixDesign(MixDesignBean bean) throws Exception {
		ps=con.prepareStatement(INSERT_MIX_DESIGN);
		ps.setString(1, bean.getReceipe_code());
		ps.setString(2, bean.getReceipe_name());
		ps.setString(3, bean.getAggregate1_name());
		ps.setInt(4, bean.getAggregate1_value());
		ps.setString(5, bean.getAggregate2_name());
		ps.setInt(6, bean.getAggregate2_value());
		ps.setString(7, bean.getAggregate3_name());
		ps.setInt(8, bean.getAggregate3_value());
		ps.setString(9, bean.getAggregate4_name());
		ps.setInt(10, bean.getAggregate4_value());
		ps.setString(11, bean.getAggregate5_name());
		ps.setInt(12, bean.getAggregate5_value());
		ps.setString(13, bean.getAggregate6_name());
		ps.setInt(14, bean.getAggregate6_value());
		ps.setString(15, bean.getAggregate7_name());
		ps.setInt(16, bean.getAggregate7_value());
		ps.setString(17, bean.getAggregate8_name());
		ps.setInt(18, bean.getAggregate8_value());
		ps.setString(19, bean.getAggregate9_name());
		ps.setDouble(20, bean.getAggregate9_value());
		ps.setString(21, bean.getAggregate10_name());
		ps.setDouble(22, bean.getAggregate10_value());
		ps.setString(23, bean.getAggregate11_name());
		ps.setInt(24, bean.getAggregate11_value());
		int count=ps.executeUpdate();
		return count;
	}

	@Override
	public int insertReceipe(MixDesignBean bean) throws Exception {
		ps=con.prepareStatement(INSERT_RECEIPE);
		ps.setInt(1, bean.getCustomer_id());
		ps.setInt(2, bean.getSite_id());
		ps.setInt(3, bean.getPlant_id());
		ps.setInt(4, bean.getProduct_id());
		ps.setString(5, bean.getReceipe_code());
		ps.setString(6, bean.getAggregate1_name());
		ps.setInt(7, bean.getAggregate1_value());
		ps.setString(8, bean.getAggregate2_name());
		ps.setInt(9, bean.getAggregate2_value());
		ps.setString(10, bean.getAggregate3_name());
		ps.setInt(11, bean.getAggregate3_value());
		ps.setString(12, bean.getAggregate4_name());
		ps.setInt(13, bean.getAggregate4_value());
		ps.setString(14, bean.getAggregate5_name());
		ps.setInt(15, bean.getAggregate5_value());
		ps.setString(16, bean.getAggregate6_name());
		ps.setInt(17, bean.getAggregate6_value());
		ps.setString(18, bean.getAggregate7_name());
		ps.setInt(19, bean.getAggregate7_value());
		ps.setString(20, bean.getAggregate8_name());
		ps.setInt(21, bean.getAggregate8_value());
		ps.setString(22, bean.getAggregate9_name());
		ps.setDouble(23, bean.getAggregate9_value());
		ps.setString(24, bean.getAggregate10_name());
		ps.setDouble(25, bean.getAggregate10_value());
		ps.setString(26, bean.getAggregate11_name());
		ps.setInt(27, bean.getAggregate11_value());
		ps.setString(28, bean.getCement_name());
		int count=ps.executeUpdate();
		return count;
	}

	@Override
	public int updateMixDesign(MixDesignBean bean) throws Exception {
		ps=con.prepareStatement(UPDATE_MIX_DESIGN);
		ps.setString(1, bean.getReceipe_code());
		ps.setString(2, bean.getReceipe_name());
		ps.setString(3, bean.getAggregate1_name());
		ps.setInt(4, bean.getAggregate1_value());
		ps.setString(5, bean.getAggregate2_name());
		ps.setInt(6, bean.getAggregate2_value());
		ps.setString(7, bean.getAggregate3_name());
		ps.setInt(8, bean.getAggregate3_value());
		ps.setString(9, bean.getAggregate4_name());
		ps.setInt(10, bean.getAggregate4_value());
		ps.setString(11, bean.getAggregate5_name());
		ps.setInt(12, bean.getAggregate5_value());
		ps.setString(13, bean.getAggregate6_name());
		ps.setInt(14, bean.getAggregate6_value());
		ps.setString(15, bean.getAggregate7_name());
		ps.setInt(16, bean.getAggregate7_value());
		ps.setString(17, bean.getAggregate8_name());
		ps.setInt(18, bean.getAggregate8_value());
		ps.setString(19, bean.getAggregate9_name());
		ps.setDouble(20, bean.getAggregate9_value());
		ps.setString(21, bean.getAggregate10_name());
		ps.setDouble(22, bean.getAggregate10_value());
		ps.setString(23, bean.getAggregate11_name());
		ps.setInt(24, bean.getAggregate11_value());
		ps.setInt(25, bean.getDesign_id());
		int count=ps.executeUpdate();
		return count;
	}

	@Override
	public int updateReceipe(MixDesignBean bean) throws Exception {
		ps=con.prepareStatement(UPDATE_RECEIPE);
		ps.setInt(1, bean.getCustomer_id());
		ps.setInt(2, bean.getSite_id());
		ps.setInt(3, bean.getPlant_id());
		ps.setInt(4, bean.getProduct_id());
		ps.setString(5, bean.getReceipe_code());
		ps.setString(6, bean.getAggregate1_name());
		ps.setInt(7, bean.getAggregate1_value());
		ps.setString(8, bean.getAggregate2_name());
		ps.setInt(9, bean.getAggregate2_value());
		ps.setString(10, bean.getAggregate3_name());
		ps.setInt(11, bean.getAggregate3_value());
		ps.setString(12, bean.getAggregate4_name());
		ps.setInt(13, bean.getAggregate4_value());
		ps.setString(14, bean.getAggregate5_name());
		ps.setInt(15, bean.getAggregate5_value());
		ps.setString(16, bean.getAggregate6_name());
		ps.setInt(17, bean.getAggregate6_value());
		ps.setString(18, bean.getAggregate7_name());
		ps.setInt(19, bean.getAggregate7_value());
		ps.setString(20, bean.getAggregate8_name());
		ps.setInt(21, bean.getAggregate8_value());
		ps.setString(22, bean.getAggregate9_name());
		ps.setDouble(23, bean.getAggregate9_value());
		ps.setString(24, bean.getAggregate10_name());
		ps.setDouble(25, bean.getAggregate10_value());
		ps.setString(26, bean.getAggregate11_name());
		ps.setInt(27, bean.getAggregate11_value());
		ps.setString(28, bean.getCement_name());
		ps.setInt(29, bean.getReceipe_id());
		int count=ps.executeUpdate();
		return count;
	}

	@Override
	public int deleteReceipe(int receipe_id) throws Exception {
		ps=con.prepareStatement(DELETE_RECEIPE);
		ps.setInt(1, receipe_id);
		int count=ps.executeUpdate();
		return count;
	}

	@Override
	public MixDesignBean getSingleMixDesignDetails(String receipe_code) throws Exception {
		ps=con.prepareStatement(GET_SINGLE_MIX_DESIGN);
		ps.setString(1, receipe_code);
		rs=ps.executeQuery();
		if(rs.next()) {
			MixDesignBean bean=new MixDesignBean();
			bean.setReceipe_code(rs.getString("recipe_code"));
			bean.setReceipe_name(rs.getString("recipe_name"));
			bean.setAggregate1_name(rs.getString("aggregate1_name"));
			bean.setAggregate1_value(rs.getInt("aggregate1_value"));
			bean.setAggregate2_name(rs.getString("aggregate2_name"));
			bean.setAggregate2_value(rs.getInt("aggregate2_value"));
			bean.setAggregate3_name(rs.getString("aggregate3_name"));
			bean.setAggregate3_value(rs.getInt("aggregate3_value"));
			bean.setAggregate4_name(rs.getString("aggregate4_name"));
			bean.setAggregate4_value(rs.getInt("aggregate4_value"));
			bean.setAggregate5_name(rs.getString("aggregate5_name"));
			bean.setAggregate5_value(rs.getInt("aggregate5_value"));
			bean.setAggregate6_name(rs.getString("aggregate6_name"));
			bean.setAggregate6_value(rs.getInt("aggregate6_value"));
			bean.setAggregate7_name(rs.getString("aggregate7_name"));
			bean.setAggregate7_value(rs.getInt("aggregate7_value"));
			bean.setAggregate8_name(rs.getString("aggregate8_name"));
			bean.setAggregate8_value(rs.getInt("aggregate8_value"));
			bean.setAggregate9_name(rs.getString("aggregate9_name"));
			bean.setAggregate9_value(rs.getDouble("aggregate9_value"));
			bean.setAggregate10_name(rs.getString("aggregate10_name"));
			bean.setAggregate10_value(rs.getDouble("aggregate10_value"));
			bean.setAggregate11_name(rs.getString("aggregate11_name"));
			bean.setAggregate11_value(rs.getInt("aggregate11_value"));
			return bean;
		}else {
			return null;
		}
	}

	@Override
	public int deleteMixDesign(int design_id) throws Exception {
		ps=con.prepareStatement(DELETE_MIX_DESIGN);
		ps.setInt(1, design_id);
		int count=ps.executeUpdate();
		return count;
	}

	@Override
	public MixDesignBean getSingleReceipeDetails(int receipe_id) throws Exception {
		ps=con.prepareStatement(GET_SINGLE_RECEIPE);
		ps.setInt(1, receipe_id);
		rs=ps.executeQuery();
		if(rs.next()) {
			MixDesignBean bean=new MixDesignBean();
			bean.setCustomer_name(rs.getString("customer_name"));
			bean.setSite_name(rs.getString("site_name"));
			bean.setProduct_name(rs.getString("product_name"));
			bean.setCustomer_id(rs.getInt("customer_id"));
			bean.setProduct_id(rs.getInt("product_id"));
			bean.setSite_id(rs.getInt("site_id"));
			bean.setReceipe_code(rs.getString("recipe_code"));
			bean.setAggregate1_name(rs.getString("aggregate1_name"));
			bean.setAggregate1_value(rs.getInt("aggregate1_value"));
			bean.setAggregate2_name(rs.getString("aggregate2_name"));
			bean.setAggregate2_value(rs.getInt("aggregate2_value"));
			bean.setAggregate3_name(rs.getString("aggregate3_name"));
			bean.setAggregate3_value(rs.getInt("aggregate3_value"));
			bean.setAggregate4_name(rs.getString("aggregate4_name"));
			bean.setAggregate4_value(rs.getInt("aggregate4_value"));
			bean.setAggregate5_name(rs.getString("aggregate5_name"));
			bean.setAggregate5_value(rs.getInt("aggregate5_value"));
			bean.setAggregate6_name(rs.getString("aggregate6_name"));
			bean.setAggregate6_value(rs.getInt("aggregate6_value"));
			bean.setAggregate7_name(rs.getString("aggregate7_name"));
			bean.setAggregate7_value(rs.getInt("aggregate7_value"));
			bean.setAggregate8_name(rs.getString("aggregate8_name"));
			bean.setAggregate8_value(rs.getInt("aggregate8_value"));
			bean.setAggregate9_name(rs.getString("aggregate9_name"));
			bean.setAggregate9_value(rs.getDouble("aggregate9_value"));
			bean.setAggregate10_name(rs.getString("aggregate10_name"));
			bean.setAggregate10_value(rs.getDouble("aggregate10_value"));
			bean.setAggregate11_name(rs.getString("aggregate11_name"));
			bean.setAggregate11_value(rs.getInt("aggregate11_value"));
			return bean;
		}
		else {
			return null;
		}
	}

	@Override
	public boolean generateBatchSheet(int id) throws Exception {
		cs=con.prepareCall(GENERATE_BATCH_SLIP);
		cs.setInt(1, id);
		cs.registerOutParameter(2, Types.VARCHAR);
		boolean check=cs.execute();
		return check;
	}	

}
