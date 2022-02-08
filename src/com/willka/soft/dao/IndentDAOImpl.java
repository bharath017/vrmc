package com.willka.soft.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import com.willka.soft.bean.IndentBean;
import com.willka.soft.bean.IndentItemBean;
import com.willka.soft.util.DBUtil;

public class IndentDAOImpl implements IndentDAO{

	//Get Database Details
	private Connection con=null;
	private PreparedStatement ps=null;
	private ResultSet rs=null;
	
	
	//declare all query here
		private static final String INSERT_SUPPLIER_PURCHASE_ORDER="insert into indent(indent_date,required_date,budget_head,justification,plant_id,order_no,start_year,end_year,indentor,designation,type) values(?,?,?,?,?,?,?,?,?,?,?)";
		
		private static final String UPDATE_SUPPLIER_PURCHASE_ORDER="update indent set indent_date=?,required_date=?,budget_head=?,justification=?,plant_id=?,type=? where indent_id=?";
		
		private static final String DELETE_SUPPLIER_PURCHASE_ORDER="delete from indent where indent_id=?";
		
		private static final String INDENT_STATUS="update indent set status='approved' where indent_id=?";
		
		private static final String APPROVED_BY="update indent set approved_by=?,checked_by=? where indent_id=?";
		
		private static final String GET_SINGLE_SUPPLIER_PURCHASE_ORDER="select * from indent where indent_id=?";
		
		private static final String INSERT_SUPPLIER_PURCHASE_ORDER_ITEM="insert into indent_item(product_number,description1,quantity,unit_price,indent_id,unit) values(?,?,?,?,?,?)";
		
		private static final String UPDATE_SUPPLIER_PURCHASE_ORDER_ITEM="update indent_item set product_number=?,description1=?,quantity=?,unit_price=?,indent_id=?,unit=? where indent_item_id=?";
		
		private static final String DELETE_SUPPLIER_PURCHASE_ORDER_ITEM="delete from indent_item where indent_item_id=?";
		
		private static final String SELECT_SINGLE_SUPPLIER_PURCHASE_ORDER_ITEM="select * from indent_item where indent_id=?";
		
		private static final String GET_MAX_ID="select max(indent_id) from indent";
		
		private static final String GET_SUPPLIER_PRODUCT_BY_SUPPLIER_PURCHASE_ORDER="select * from indent_item where indent_id=?";
		
		private static final String GET_MAX_ORDER_NO="select max(order_no) from indent where plant_id=? and start_year=? and end_year=?";
		
		private static final String GET_USER_NAME="SELECT user_name from user where user_login_id=?";
		
		
		
		public IndentDAOImpl() {
				con=DBUtil.getConnection();
		}
		
	
	
	@Override
	public int insertIndent(IndentBean bean) throws Exception {
		ps=con.prepareStatement(INSERT_SUPPLIER_PURCHASE_ORDER);
		ps.setString(1, bean.getIndent_date());
		ps.setString(2, bean.getRequired_date());
		ps.setString(3, bean.getBudget_head());
		ps.setString(4, bean.getJustification());
		ps.setInt(5, bean.getPlant_id());
		ps.setInt(6, bean.getOrder_no());
		ps.setInt(7, bean.getStart_year());
		ps.setInt(8, bean.getEnd_year());
		ps.setString(9, bean.getIndentor());
		ps.setString(10, bean.getDesignation());
		ps.setString(11, bean.getType());
		int count=ps.executeUpdate();
		return count;
	}


	@Override
	public int updateIndent(IndentBean bean) throws Exception {
		ps=con.prepareStatement(UPDATE_SUPPLIER_PURCHASE_ORDER);
		ps.setString(1, bean.getIndent_date());
		ps.setString(2, bean.getRequired_date());
		ps.setString(3, bean.getBudget_head());
		ps.setString(4, bean.getJustification());
		ps.setInt(5, bean.getPlant_id());
		ps.setString(6, bean.getType());
		ps.setInt(7,bean.getIndent_id());
		int count=ps.executeUpdate();
		return count;
	}

	
	@Override
	public int deleteIndent(int indent_id) throws Exception {
		ps=con.prepareStatement(DELETE_SUPPLIER_PURCHASE_ORDER);
		ps.setInt(1, indent_id);
		
		int count=ps.executeUpdate();
		return count;
	}


	@Override
	public int insertIndentItem(IndentItemBean bean) throws Exception {
		ps=con.prepareStatement(INSERT_SUPPLIER_PURCHASE_ORDER_ITEM);
		ps.setString(1, bean.getProduct_number());
		ps.setString(2, bean.getDescription1());
		ps.setDouble(3,bean.getQuantity());
		ps.setDouble(4, bean.getUnit_price());
		ps.setInt(5, bean.getIndent_id());
		ps.setString(6, bean.getUnit());
		int count=ps.executeUpdate();
		return count;
	}


	@Override
	public int updateIndentItem(IndentItemBean bean) throws Exception {
		ps=con.prepareStatement(UPDATE_SUPPLIER_PURCHASE_ORDER_ITEM);
		ps.setString(1, bean.getProduct_number());
		ps.setString(2, bean.getDescription1());
		ps.setDouble(3,bean.getQuantity());
		ps.setDouble(4, bean.getUnit_price());
		ps.setInt(5, bean.getIndent_id());
		ps.setString(6, bean.getUnit());
		ps.setInt(7, bean.getIndent_item_id());
		int count=ps.executeUpdate();
		return count;
	}


	@Override
	public int statusIndent(int indent_id) throws Exception {
		ps=con.prepareStatement(INDENT_STATUS);
		ps.setInt(1, indent_id);
		int count=ps.executeUpdate();
		return count;
	}

	/*@Override
	public int deleteIndentItem(int indent_item_id) throws Exception {
		ps=con.prepareStatement(DELETE_SUPPLIER_PURCHASE_ORDER_ITEM);
		ps.setInt(1, indent_item_id);
		int count=ps.executeUpdate();
		return count;
	}*/
	
	@Override
	public IndentBean getSingleIndent(int indent_id) throws Exception {
		ps=con.prepareStatement(GET_SINGLE_SUPPLIER_PURCHASE_ORDER);
		ps.setInt(1, indent_id);
		rs=ps.executeQuery();
		if(rs.next()){
			//create Supplier Purchase Order bean object
			IndentBean bean=new IndentBean();
			bean.setIndent_id(rs.getInt("indent_id"));
			bean.setIndent_date(rs.getString("indent_date"));
			bean.setRequired_date(rs.getString("required_date"));
			bean.setBudget_head(rs.getString("budget_head"));
			bean.setSupplier_id(rs.getInt("supplier_id"));
		//	bean.setSupplier_id(rs.getString("supplier_id"));
			return bean;
		}
		else
		{
			return null;
		}
	}


	@Override
	public IndentItemBean getSingleIndentItem(int indent_item_id) throws Exception {
		ps=con.prepareStatement(SELECT_SINGLE_SUPPLIER_PURCHASE_ORDER_ITEM);
		ps.setInt(1, indent_item_id);
		rs=ps.executeQuery();
		if(rs.next()){
			//create bean object
			IndentItemBean  bean=new IndentItemBean();
			bean.setProduct_number(rs.getString("product_number"));
			bean.setDescription1(rs.getString("description1"));
			bean.setQuantity(rs.getDouble("quantity"));
			bean.setUnit_price(rs.getDouble("unit_price"));
			bean.setIndent_id(rs.getInt("indent_id"));
			bean.setIndent_item_id(rs.getInt("indent_item_id"));
			return bean;
		}
		else
		{
			return null;
		}
	}


	@Override
	public int getMaxIndentId() throws Exception {
		ps=con.prepareStatement(GET_MAX_ID);
		rs=ps.executeQuery();
		if(rs.next()){
			return rs.getInt(1);
		}
		else
		{
		 return 0;
		}
	}


	@Override
	public ArrayList<IndentItemBean> getAllIndentItem(int indent_id)
			throws Exception {
		ps=con.prepareStatement(SELECT_SINGLE_SUPPLIER_PURCHASE_ORDER_ITEM);
		ps.setInt(1, indent_id);
		rs=ps.executeQuery();
		ArrayList<IndentItemBean> list=new ArrayList<>();
		while(rs.next()){
			//create supplierpoproductbean object
			IndentItemBean bean=new IndentItemBean();
		//	bean.setPart_no(rs.getString("part_no"));
			bean.setProduct_number(rs.getString("product_number"));
			bean.setDescription1(rs.getString("description1"));
			bean.setQuantity(rs.getDouble("quantity"));
			bean.setUnit_price(rs.getDouble("unit_price"));
			bean.setIndent_id(rs.getInt("indent_id"));
			bean.setIndent_item_id(rs.getInt("indent_item_id"));
			list.add(bean);
		}
		return list;
	}



	@Override
	public int getMaxOrderNo(int plant_id, int start_year, int end_year) throws Exception {
		ps=con.prepareStatement(GET_MAX_ORDER_NO);
		ps.setInt(1, plant_id);
		ps.setInt(2, start_year);
		ps.setInt(3, end_year);
		rs=ps.executeQuery();
		if(rs.next()) {
			return rs.getInt(1)+1;
		}else {
			return 1;
		}
	}


	@Override
	public String getTheUserName(String user_login_id) throws Exception {
		ps=con.prepareStatement(GET_USER_NAME);
		ps.setString(1, user_login_id);
		rs=ps.executeQuery();
		if(rs.next()){
			return rs.getString(1);
		}
		else
		{
		 return user_login_id;
		}
	}

	@Override
	public int approvedBy(String approved_by, int indent_id) throws Exception {
		ps=con.prepareStatement(APPROVED_BY);
		ps.setString(1, approved_by);
		ps.setString(2, approved_by);
		ps.setInt(3, indent_id);
		int count=ps.executeUpdate();
		return count;
	}

	



	@Override
	public int deleteIndentItem(int indent_item_id) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}
	

	

}
