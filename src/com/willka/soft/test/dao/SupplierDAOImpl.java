package com.willka.soft.test.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.willka.soft.test.bean.SupplierBean;
import com.willka.soft.util.DBUtil;

public class SupplierDAOImpl implements SupplierDAO {

	private Connection con=null;
	private PreparedStatement ps=null;
	private ResultSet rs=null;
	
	private static final String INSERT_QUERY="insert into test_supplier(supplier_name,supplier_phone,"
			+ "supplier_address,supplier_gstin,supplier_panno,business_id,opening_balance,supplier_email) values(?,?,?,?,?,?,?,?)";
	
	private static final String UPDATE_QUERY="update test_supplier set supplier_name=?,supplier_phone=?,supplier_address=?,"
			+ "supplier_gstin=?,supplier_panno=?,business_id=?,opening_balance=?, supplier_email=? where supplier_id=?";
	
	private static final String CHANGE_SUPPLIER_STATUS="update test_supplier set supplier_status=? where supplier_id=?";
	
	private static final String UPDATE_TALLYLEDGER = "update test_supplier set tally_ledger=? where supplier_id=?";
	
	private static final String GET_SUPPLIER_LIST="select supplier_id,supplier_name,supplier_phone,"+
			" supplier_address,b.group_name,supplier_gstin,supplier_status"+
			" from test_supplier s,business_group b"+
			" where s.business_id=b.business_id"+
			" and s.supplier_name like ?"+
			" and s.supplier_phone like ?"+
			" and s.business_id like if(0=?,'%%',?)"+
			" order by supplier_id desc"+
			" limit ?,?";
	
	private static final String COUNT_SUPPLIER_LIST="select count(supplier_id)"+
			" from test_supplier s"+
			" where s.supplier_name like ?"+
			" and s.supplier_phone like ?"+
			" and s.business_id like if(0=?,'%%',?)";
	
	private static final String GET_SINGLE_SUPPLIER_DETAILS_BY_SUPPLIER_ID="select s.*,b.group_name"
			+ " from test_supplier s,business_group b where s.business_id=b.business_id and  supplier_id=?";
	
	private static final String GET_SUPPLIER_LIST_BY_BUSINESS_GROUP="select supplier_id,supplier_name"
			+ " from test_supplier "
			+ " where business_id like if(?=0,'%%',?)"
			+ " and supplier_status='active'"
			+ " order by supplier_name asc";
	
	
	public SupplierDAOImpl() {
		con=DBUtil.getConnection();
	}
	
	@Override
	public int insertSupplier(SupplierBean bean) throws Exception {
		ps=con.prepareStatement(INSERT_QUERY);
		ps.setString(1, bean.getSupplier_name());
		ps.setString(2, bean.getSupplier_phone());
		ps.setString(3, bean.getSupplier_address());
		ps.setString(4, bean.getSupplier_gstin());
		ps.setString(5, bean.getSupplier_panno());
		ps.setInt(6, bean.getBusiness_id());
		ps.setDouble(7, bean.getOpening_balance());
		ps.setString(8, bean.getSupplier_email());
		int count=ps.executeUpdate();
		return count;
	}

	@Override
	public int updateSupplier(SupplierBean bean) throws Exception {
		ps=con.prepareStatement(UPDATE_QUERY);
		ps.setString(1, bean.getSupplier_name());
		ps.setString(2, bean.getSupplier_phone());
		ps.setString(3, bean.getSupplier_address());
		ps.setString(4, bean.getSupplier_gstin());
		ps.setString(5, bean.getSupplier_panno());
		ps.setInt(6, bean.getBusiness_id());
		ps.setDouble(7, bean.getOpening_balance());
		ps.setString(8, bean.getSupplier_email());
		ps.setInt(9, bean.getSupplier_id());
		int count=ps.executeUpdate();
		return count;
	}

	@Override
	public int changeSupplierStatus(int supplier_id,String supplier_status) throws Exception {
		ps=con.prepareStatement(CHANGE_SUPPLIER_STATUS);
		ps.setString(1, supplier_status);
		ps.setInt(2, supplier_id);
		int count=ps.executeUpdate();
		return count;
	}

	@Override
	public int UpdateTallyLedger(int supplier_id, String tally_ledger) throws Exception {
		ps=con.prepareStatement(UPDATE_TALLYLEDGER);
		ps.setString(1, tally_ledger);
		ps.setInt(2, supplier_id);
		int count=ps.executeUpdate();
		System.out.println(ps.toString());
		return count;
	}

	@Override
	public List<Map<String, Object>> getSupplierList(String search, int business_id, int start, int length)
			throws Exception {
		ps=con.prepareStatement(GET_SUPPLIER_LIST);
		ps.setString(1, "%"+search+"%");
		ps.setString(2, "%"+search+"%");
		ps.setInt(3, business_id);
		ps.setInt(4, business_id);
		ps.setInt(5, start);
		ps.setInt(6, length);
		rs=ps.executeQuery();
		List<Map<String,Object>> list=new ArrayList<Map<String,Object>>();
		while(rs.next()) {
			Map<String,Object> data=new HashMap<String, Object>();
			data.put("supplier_name", rs.getString("supplier_name"));
			data.put("supplier_phone", rs.getString("supplier_phone"));
			data.put("supplier_id", rs.getInt("supplier_id"));
			data.put("supplier_address", rs.getString("supplier_address"));
			data.put("supplier_gstin", rs.getString("supplier_gstin"));
			data.put("group_name", rs.getString("group_name"));
			data.put("supplier_status", rs.getString("supplier_status"));
			list.add(data);
		}
		return list;
	}

	@Override
	public int countSupplierList(String search, int business_id) throws Exception {
		ps=con.prepareStatement(COUNT_SUPPLIER_LIST);
		ps.setString(1, "%"+search+"%");
		ps.setString(2, "%"+search+"%");
		ps.setInt(3, business_id);
		ps.setInt(4, business_id);
		rs=ps.executeQuery();
		if(rs.next())
			return rs.getInt(1);
		else
			return 0;
	}

	@Override
	public SupplierBean getSingleSupplierDetails(int supplier_id) throws Exception {
		ps=con.prepareStatement(GET_SINGLE_SUPPLIER_DETAILS_BY_SUPPLIER_ID);
		ps.setInt(1, supplier_id);
		rs=ps.executeQuery();
		if(rs.next()) {
			SupplierBean bean=new SupplierBean();
			bean.setBusiness_id(rs.getInt("business_id"));
			bean.setSupplier_id(rs.getInt("supplier_id"));
			bean.setSupplier_name(rs.getString("supplier_name"));
			bean.setSupplier_phone(rs.getString("supplier_phone"));
			bean.setSupplier_gstin(rs.getString("supplier_gstin"));
			bean.setSupplier_email(rs.getString("supplier_email"));
			bean.setSupplier_panno(rs.getString("supplier_panno"));
			bean.setBusiness_id(rs.getInt("business_id"));
			bean.setOpening_balance(rs.getDouble("opening_balance"));
			bean.setSupplier_address(rs.getString("supplier_address"));
			bean.setGroup_name(rs.getString("group_name"));
			return bean;
		}
		else
			return null;
	}
	
	

	@Override
	public List<Map<String, Object>> getSupplierListByBusinessGroup(int business_id) throws Exception {
		ps=con.prepareStatement(GET_SUPPLIER_LIST_BY_BUSINESS_GROUP);
		ps.setInt(1, business_id);
		ps.setInt(2, business_id);
		rs=ps.executeQuery();
		List<Map<String,Object>> list=new ArrayList<>();
		while(rs.next()) {
			Map<String,Object> map=new HashMap<>();
			map.put("supplier_id", rs.getString("supplier_id"));
			map.put("supplier_name", rs.getString("supplier_name"));
			list.add(map);
		}
		return list;
	}
	
	

}
