package com.willka.soft.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import com.willka.soft.bean.SupplierPurchaseOrderBean;
import com.willka.soft.bean.SupplierPurchaseOrderItemBean;
import com.willka.soft.util.DBUtil;

public class SupplierPurchaseOrderDAOImpl implements SupplierPurchaseOrderDAO{

	//Get Database Details
	private Connection con=null;
	private PreparedStatement ps=null;
	private ResultSet rs=null;
	
	
	//declare all query here
		private static final String INSERT_SUPPLIER_PURCHASE_ORDER="insert into supplier_purchase_order(purchase_order_date,required_date,payment_term,description,supplier_id,gst_type,gst_percentage,order_validity,receiver_name,receiver_email,receiver_phone,quotation_no,discount,discount_type,pf_percent,terms,plant_id,order_no,start_year,end_year,pl_delivery_address_id) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
		
		private static final String UPDATE_SUPPLIER_PURCHASE_ORDER="update supplier_purchase_order set purchase_order_date=?,required_date=?,payment_term=?,description=?,supplier_id=?,gst_type=?,gst_percentage=?,order_validity=?,receiver_name=?,receiver_email=?,receiver_phone=?,quotation_no=?,discount=?,discount_type=?,pf_percent=?,terms=?,plant_id=? where supplier_purchase_order_id=?";
		
		private static final String DELETE_SUPPLIER_PURCHASE_ORDER="delete from supplier_purchase_order where supplier_purchase_order_id=?";
		
		private static final String GET_SINGLE_SUPPLIER_PURCHASE_ORDER="select * from supplier_purchase_order where supplier_purchase_order_id=?";
		
		private static final String INSERT_SUPPLIER_PURCHASE_ORDER_ITEM="insert into supplier_purchase_order_item(product_number,description1,quantity,unit_price,supplier_purchase_order_id,unit) values(?,?,?,?,?,?)";
		
		private static final String UPDATE_SUPPLIER_PURCHASE_ORDER_ITEM="update supplier_purchase_order_item set product_number=?,description1=?,quantity=?,unit_price=?,supplier_purchase_order_id=?,unit=? where spoi_id=?";
		
		private static final String DELETE_SUPPLIER_PURCHASE_ORDER_ITEM="delete from supplier_purchase_order_item where spoi_id=?";
		
		private static final String SELECT_SINGLE_SUPPLIER_PURCHASE_ORDER_ITEM="select * from supplier_purchase_order_item where supplier_purchase_order_id=?";
		
		private static final String GET_MAX_ID="select max(supplier_purchase_order_id) from supplier_purchase_order";
		
		private static final String GET_SUPPLIER_PRODUCT_BY_SUPPLIER_PURCHASE_ORDER="select * from supplier_purchase_order_item where supplier_purchase_order_id=?";
		
		private static final String GET_MAX_ORDER_NO="select max(order_no) from supplier_purchase_order where plant_id=? and start_year=? and end_year=?";
	
		private static final String APPROVE_SUPPLIER_PURCHASE_ORDER = "Update supplier_purchase_order set approved='yes' where supplier_purchase_order_id=?";
		

		
		public SupplierPurchaseOrderDAOImpl() {
				con=DBUtil.getConnection();
		}
		
	
	
	@Override
	public int insertSupplierPurchaseOrder(SupplierPurchaseOrderBean bean) throws Exception {
		ps=con.prepareStatement(INSERT_SUPPLIER_PURCHASE_ORDER);
		ps.setString(1, bean.getPurchase_order_date());
		ps.setString(2, bean.getRequired_date());
		ps.setString(3, bean.getPayment_term());
		ps.setString(4, bean.getDescription());
		ps.setInt(5, bean.getSupplier_id());
		ps.setString(6, bean.getGst_type());
		ps.setFloat(7, bean.getGst_percentage());
		ps.setString(8, bean.getOrder_validity());
		ps.setString(9, bean.getReceiver_name());
		ps.setString(10, bean.getReceiver_email());
		ps.setString(11, bean.getReceiver_phone());
		ps.setString(12, bean.getQuotation_no());
		ps.setDouble(13, bean.getDiscount());
		ps.setString(14, bean.getDiscount_type());
		ps.setDouble(15, bean.getPf_percent());
		ps.setString(16, bean.getTerms());
		ps.setInt(17, bean.getPlant_id());
		ps.setInt(18, bean.getOrder_no());
		ps.setInt(19, bean.getStart_year());
		ps.setInt(20, bean.getEnd_year());
		ps.setInt(21, bean.getPl_delivery_address_id());
		int count=ps.executeUpdate();
		return count;
	}


	@Override
	public int updateSupplierPurchaseOrder(SupplierPurchaseOrderBean bean) throws Exception {
		ps=con.prepareStatement(UPDATE_SUPPLIER_PURCHASE_ORDER);
		ps.setString(1, bean.getPurchase_order_date());
		ps.setString(2, bean.getRequired_date());
		ps.setString(3, bean.getPayment_term());
		ps.setString(4, bean.getDescription());
		ps.setInt(5, bean.getSupplier_id());
		ps.setString(6, bean.getGst_type());
		ps.setFloat(7, bean.getGst_percentage());
		ps.setString(8, bean.getOrder_validity());
		ps.setString(9, bean.getReceiver_name());
		ps.setString(10, bean.getReceiver_email());
		ps.setString(11, bean.getReceiver_phone());
		ps.setString(12, bean.getQuotation_no());
		ps.setDouble(13, bean.getDiscount());
		ps.setString(14, bean.getDiscount_type());
		ps.setDouble(15, bean.getPf_percent());
		ps.setString(16, bean.getTerms());
		ps.setInt(17, bean.getPlant_id());
		ps.setInt(18,bean.getSupplier_purchase_order_id());
		int count=ps.executeUpdate();
		return count;
	}


	@Override
	public int deleteSupplierPurchaseOrder(int supplier_purchase_order_id) throws Exception {
		ps=con.prepareStatement(DELETE_SUPPLIER_PURCHASE_ORDER);
		ps.setInt(1, supplier_purchase_order_id);
		
		int count=ps.executeUpdate();
		return count;
	}


	@Override
	public int insertSupplierPurchaseOrderItem(SupplierPurchaseOrderItemBean bean) throws Exception {
		ps=con.prepareStatement(INSERT_SUPPLIER_PURCHASE_ORDER_ITEM);
		ps.setString(1, bean.getProduct_number());
		ps.setString(2, bean.getDescription1());
		ps.setDouble(3,bean.getQuantity());
		ps.setDouble(4, bean.getUnit_price());
		ps.setInt(5, bean.getSupplier_purchase_order_id());
		ps.setString(6, bean.getUnit());
		int count=ps.executeUpdate();
		return count;
	}


	@Override
	public int updateSupplierPurchaseOrderItem(SupplierPurchaseOrderItemBean bean) throws Exception {
		ps=con.prepareStatement(UPDATE_SUPPLIER_PURCHASE_ORDER_ITEM);
		ps.setString(1, bean.getProduct_number());
		ps.setString(2, bean.getDescription1());
		ps.setDouble(3,bean.getQuantity());
		ps.setDouble(4, bean.getUnit_price());
		ps.setInt(5, bean.getSupplier_purchase_order_id());
		ps.setString(6, bean.getUnit());
		ps.setInt(7, bean.getSpoi_id());
		int count=ps.executeUpdate();
		return count;
	}


	@Override
	public int deleteSupplierPurchaseOrderItem(int spoi_id) throws Exception {
		ps=con.prepareStatement(DELETE_SUPPLIER_PURCHASE_ORDER_ITEM);
		ps.setInt(1, spoi_id);
		int count=ps.executeUpdate();
		return count;
	}


	@Override
	public SupplierPurchaseOrderBean getSingleSupplierPurchaseOrder(int supplier_purchase_order_id) throws Exception {
		ps=con.prepareStatement(GET_SINGLE_SUPPLIER_PURCHASE_ORDER);
		ps.setInt(1, supplier_purchase_order_id);
		rs=ps.executeQuery();
		if(rs.next()){
			//create Supplier Purchase Order bean object
			SupplierPurchaseOrderBean bean=new SupplierPurchaseOrderBean();
			bean.setSupplier_purchase_order_id(rs.getInt("supplier_purchase_order_id"));
			bean.setPurchase_order_date(rs.getString("purchase_order_date"));
			bean.setRequired_date(rs.getString("required_date"));
			bean.setDescription(rs.getString("description"));
			//bean.setGst_percent(rs.getFloat("gst_percent"));
			bean.setGst_percentage(rs.getFloat("gst_percentage"));
			bean.setGst_type(rs.getString("gst_type"));
			bean.setPayment_term(rs.getString("payment_term"));
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
	public SupplierPurchaseOrderItemBean getSingleSupplierPurchaseOrderItem(int spoi_id) throws Exception {
		ps=con.prepareStatement(SELECT_SINGLE_SUPPLIER_PURCHASE_ORDER_ITEM);
		ps.setInt(1, spoi_id);
		rs=ps.executeQuery();
		if(rs.next()){
			//create bean object
			SupplierPurchaseOrderItemBean  bean=new SupplierPurchaseOrderItemBean();
			bean.setProduct_number(rs.getString("product_number"));
			bean.setDescription1(rs.getString("description1"));
			bean.setQuantity(rs.getDouble("quantity"));
			bean.setUnit_price(rs.getDouble("unit_price"));
			bean.setSupplier_purchase_order_id(rs.getInt("supplier_purchase_order_id"));
			bean.setSupplier_purchase_order_id(rs.getInt("supplier_purchase_order_id"));
			return bean;
		}
		else
		{
			return null;
		}
	}


	@Override
	public int getMaxSupplierPurchaseOrderId() throws Exception {
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
	public ArrayList<SupplierPurchaseOrderItemBean> getAllSupplierPurchaseOrderItem(int supplier_purchase_order_id)
			throws Exception {
		ps=con.prepareStatement(SELECT_SINGLE_SUPPLIER_PURCHASE_ORDER_ITEM);
		ps.setInt(1, supplier_purchase_order_id);
		rs=ps.executeQuery();
		ArrayList<SupplierPurchaseOrderItemBean> list=new ArrayList<>();
		while(rs.next()){
			//create supplierpoproductbean object
			SupplierPurchaseOrderItemBean bean=new SupplierPurchaseOrderItemBean();
		//	bean.setPart_no(rs.getString("part_no"));
			bean.setProduct_number(rs.getString("product_number"));
			bean.setDescription1(rs.getString("description1"));
			bean.setQuantity(rs.getDouble("quantity"));
			bean.setUnit_price(rs.getDouble("unit_price"));
			bean.setSupplier_purchase_order_id(rs.getInt("supplier_purchase_order_id"));
			bean.setSpoi_id(rs.getInt("spoi_id"));
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
	public int approveSupplierPurchaseOrder(int supplier_purchase_order_id) throws Exception{
	ps=con.prepareStatement(APPROVE_SUPPLIER_PURCHASE_ORDER);
	ps.setInt(1, supplier_purchase_order_id);
	int count=ps.executeUpdate();
	return count;
	}

}
