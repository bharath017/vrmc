package com.willka.soft.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import com.willka.soft.bean.GradeComposition;
import com.willka.soft.bean.ProductBean;
import com.willka.soft.util.DBUtil;

public class ProductDAOImpl implements ProductDAO{
	//declare all database variable
		private Connection con=null;
		private PreparedStatement ps=null;
		private ResultSet rs=null;
		
		private static final String GET_PRODUCT_NAME_FOR_SUGESTION="select product_name from product";
		
		private static final String GET_ALL_PRODUCT_LIST="select product_id,product_name,product_detail,unit_of_measurement,product_status,b.group_name"
				+ " from product p ,business_group b where p.business_id=b.business_id and product_name like ? and p.business_id like if(?=0,'%%',?) order by product_id desc limit ?,?";
		
		private static final String COUNT_ALL_PRODUCT_LIST="select count(product_id) from product where product_name like ? and business_id like if(0=?,'%%',?)";
		
		private static final String INSERT_PRODUCT="insert into product(product_name,product_detail,unit_of_measurement,business_id,hsn_code,isConversionRequired,conversion_value)"
				+ " values(?,?,?,?,?,?,?)";
		
		private static final String GET_SINGLE_PRODUCT_DETAILS="select product_id,product_name,product_detail,unit_of_measurement,"
				+ "cem_type,cem_quantity,max_aggregate,product_status,max_wc,business_id,hsn_code,isConversionRequired,conversion_value"
				+ " from product where product_id=?";
		
		private static final String UPDATE_PRODUCT="update product set product_name=?,product_detail=?,"
				+ "unit_of_measurement=?,business_id=?,hsn_code=?,isConversionRequired=?,conversion_value=? where product_id=?";
		
		private static final String GET_GRADE_COMPOSITION="select c.comp_id,c.comp_weight,i.inventory_name from grade_composition c,inventory_item i where c.sp_id=i.inv_item_id and c.product_id=?";
		
		private static final String INSERT_GRADE_COMPOSITION="insert into grade_composition(product_id,comp_weight,sp_id) values(?,?,?)";
		
		private static final String UPDAT_OTHER_DETAILS="update product set cem_type=?,cem_quantity=?,max_aggregate=?,max_wc=? where product_id=?";
		
		private static final String DELETE_COMP_DETAILS="delete from grade_composition where comp_id=?";
		
		private static final String CHANGE_PRODUCT_STAUTS="update product set product_status=? where product_id=?";
		
		
		
		
		
		
		
		
		
		public ProductDAOImpl() {
			con=DBUtil.getConnection();
		}



		@Override
		public ArrayList<String> getAllProductNamesForSuggestion() throws Exception {
			ps=con.prepareStatement(GET_PRODUCT_NAME_FOR_SUGESTION);
			rs=ps.executeQuery();
			ArrayList<String> list=new ArrayList<String>();
			while(rs.next())
				list.add(rs.getString(1));
			return list;
		}



		@Override
		public ArrayList<HashMap<String, Object>> getAllProductList(String search, int business_id, int start, int length)
				throws Exception {
			ps=con.prepareStatement(GET_ALL_PRODUCT_LIST);
			ps.setString(1, "%"+search+"%");
			ps.setInt(2, business_id);
			ps.setInt(3, business_id);
			ps.setInt(4, start);
			ps.setInt(5, length);
			rs=ps.executeQuery();
			ArrayList<HashMap<String, Object>> list=new ArrayList<HashMap<String,Object>>();
			while(rs.next()) {
				HashMap<String, Object> map=new HashMap<String, Object>();
				map.put("product_id", rs.getInt("product_id"));
				map.put("product_name", rs.getString("product_name"));
				map.put("product_detail", rs.getString("product_detail"));
				map.put("unit_of_measurement", rs.getString("unit_of_measurement"));
				map.put("product_status", rs.getString("product_status"));
				map.put("group_name", rs.getString("group_name"));
				list.add(map);
			}
			return list;
		}



		@Override
		public int countAllProductList(String search, int business_id) throws Exception {
			ps=con.prepareStatement(COUNT_ALL_PRODUCT_LIST);
			ps.setString(1, "%"+search+"%");
			ps.setInt(2, business_id);
			ps.setInt(3, business_id);
			rs=ps.executeQuery();
			if(rs.next())
				return rs.getInt(1);
			else
				return 0;
		}



		@Override
		public int insertProduct(ProductBean bean) throws Exception {
			ps=con.prepareStatement(INSERT_PRODUCT);
			ps.setString(1, bean.getProduct_name());
			ps.setString(2, bean.getProduct_detail());
			ps.setString(3, bean.getUnit_of_measurement());
			ps.setInt(4, bean.getBusiness_id());
			ps.setString(5, bean.getHsn_code());
			ps.setBoolean(6, bean.isConversionRequired());
			ps.setDouble(7, bean.getConversion_value());
			int count=ps.executeUpdate();
			return count;
		}



		@Override
		public int updateProduct(ProductBean bean) throws Exception {
			ps=con.prepareStatement(UPDATE_PRODUCT);
			ps.setString(1, bean.getProduct_name());
			ps.setString(2, bean.getProduct_detail());
			ps.setString(3, bean.getUnit_of_measurement());
			ps.setInt(4, bean.getBusiness_id());
			ps.setString(5, bean.getHsn_code());
			ps.setBoolean(6, bean.isConversionRequired());
			ps.setDouble(7, bean.getConversion_value());
			ps.setInt(8, bean.getProduct_id());
			int count=ps.executeUpdate();
			return count;
		}

		@Override
		public int changeProductStatus(int product_id, String status) throws Exception {
			ps=con.prepareStatement(CHANGE_PRODUCT_STAUTS);
			ps.setString(1, status);
			ps.setInt(2, product_id);
			int count=ps.executeUpdate();
			return count;
		}



		@Override
		public HashMap<String, Object> getSingleProductDetails(int product_id) throws Exception {
			ps=con.prepareStatement(GET_SINGLE_PRODUCT_DETAILS);
			ps.setInt(1, product_id);
			rs=ps.executeQuery();
			HashMap<String, Object> map=new HashMap<String, Object>();
			while(rs.next()) {
				map.put("product_id", rs.getInt("product_id"));
				map.put("product_name", rs.getString("product_name"));
				map.put("product_detail", rs.getString("product_detail"));
				map.put("unit_of_measurement", rs.getString("unit_of_measurement"));
				map.put("cem_type", rs.getString("cem_type"));
				map.put("cem_quantity", rs.getString("cem_quantity"));
				map.put("max_aggregate", rs.getString("max_aggregate"));
				map.put("max_wc", rs.getFloat("max_wc"));
				map.put("business_id", rs.getInt("business_id"));
				map.put("hsn_code", rs.getString("hsn_code"));
				map.put("conversion_value", rs.getDouble("conversion_value"));
				map.put("isConversionRequired", rs.getBoolean("isConversionRequired"));
			}
			return map;
		}



		@Override
		public ArrayList<HashMap<String, Object>> getSingleGradecompositionDetails(int product_id) throws Exception {
			ps=con.prepareStatement(GET_GRADE_COMPOSITION);
			ps.setInt(1, product_id);
			rs=ps.executeQuery();
			ArrayList<HashMap<String, Object>> list=new ArrayList<HashMap<String,Object>>();
			while(rs.next()) {
				HashMap<String, Object> map=new HashMap<String, Object>();
				map.put("comp_id", rs.getInt("comp_id"));
				map.put("comp_weight", rs.getDouble("comp_weight"));
				map.put("comp_id", rs.getInt("comp_id"));
				map.put("inventory", rs.getString("inventory_name"));
				list.add(map);
			}
			return list;
		}



		@Override
		public int addComposition(GradeComposition bean) throws Exception {
			ps=con.prepareStatement(INSERT_GRADE_COMPOSITION);
			ps.setInt(1, bean.getProduct_id());
			ps.setDouble(2, bean.getComp_weight());
			ps.setInt(3, bean.getSp_id());
			int count=ps.executeUpdate();
			return count;
		}


		@Override
		public int removeComposition(int comp_id) throws Exception {
			ps=con.prepareStatement(DELETE_COMP_DETAILS);
			ps.setInt(1, comp_id);
			int count=ps.executeUpdate();
			return count;
		}

		@Override
		public int updateOtherDetails(ProductBean bean) throws Exception {
			ps=con.prepareStatement(UPDAT_OTHER_DETAILS);
			ps.setString(1, bean.getCem_type());
			ps.setDouble(2, bean.getCem_quantity());
			ps.setString(3, bean.getMax_aggregate());
			ps.setDouble(4, bean.getMax_wc());
			ps.setInt(5, bean.getProduct_id());
			int count=ps.executeUpdate();
			return count;
		}

		
}
