package com.willka.soft.test.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.willka.soft.test.bean.PurchaseOrderBean;
import com.willka.soft.test.bean.PurchaseOrderItemBean;
import com.willka.soft.util.DBUtil;

public class PurchaseOrderDAOImpl implements PurchaseOrderDAO {

	//declare database variable
	private Connection con=null;
	private PreparedStatement ps=null;
	private ResultSet rs=null;
	private PreparedStatement ps1=null;
	private ResultSet rs1=null;
	
	//declare query here
	private static final String INSERT_QUERY="insert into test_purchase_order(po_date,po_valid_till,tax_group,customer_id,site_id,"
			+ "marketing_person_id,plant_id,po_number,rate_include_tax,gst_percent,order_type,bill_photo,credit_days,credit_limit,gst_id"
			+ ") values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
	
	private static final String UPDATE_QUERY="update test_purchase_order set po_date=?,po_valid_till=?,tax_group=?"
			+ ",customer_id=?,site_id=?,marketing_person_id=?,plant_id=?,po_number=?,"
			+ "rate_include_tax=?,gst_percent=?,order_type=?,bill_photo=?,credit_days=?,"
			+ "credit_limit=?,gst_id=? where order_id=?";
	
	private static final String INSERT_PURCHASE_ITEM="insert into test_purchase_order_item(product_id,quantity,rate,order_id) values(?,?,?,?)";
	
	private static final String UPDATE_PURCHASE_ITEM="update test_purchase_order_item set product_id=?,quantity=?,rate=?,order_id=? where poi_id=?";
	
	private static final String CANCEL_ORDER="update test_purchase_order set status='cancelled' where order_id=?";
	
	private static final String ACTIVATE_ORDER="update test_purchase_order set status='active' where order_id=?";
	
	private static final String GET_MAX_ORDER_ID="select max(order_id) from test_purchase_order";
	
	private static final String GET_PURCHASE_ORDER_LIST="select po.order_id,c.customer_name,s.site_name,m.mp_name,DATE_FORMAT(po_date,'%d/%m/%Y') as po_date,"+
														" (select plant_name from plant where plant_id=po.plant_id) as plant_name,po.rate_include_tax,"+
														" po.po_number,po.order_type,g.gst_percent,g.gst_category,po.status"+
														" from test_purchase_order po LEFT JOIN (test_customer c,test_site_detail s,gst_percent g,marketing_person m)"+
														" ON po.customer_id=c.customer_id"+
														" and po.site_id=s.site_id"+
														" and po.gst_id=g.gst_id"+
														" and po.marketing_person_id=m.mp_id"+
														" where po.customer_id like if(?=0,'%%',?)"+
														" and po.site_id like if(?=0,'%%',?)"+
														" and po.po_number like ?"+
														" and po.po_date between if(?='','2000-01-01',?) and if(?='','2050-01-01',?)"+
														" and c.business_id like if(0=?,'%%',?) and c.plant_id like if(?=0,'%%',?)"+
														" order by po.order_id desc"+
														" limit ?,?";
	
	
	private static final String COUNT_PURCHASE_ORDER_LIST="select count(order_id)"+
												" from test_purchase_order po,test_customer c"+
												" where po.customer_id=c.customer_id"+
												" and po.customer_id like if(?=0,'%%',?)"+
												" and po.site_id like if(?=0,'%%',?)"+
												" and po.po_number like ?"+
												" and po.po_date between if(?='','2000-01-01',?) and if(?='','2050-01-01',?)"+
												" and c.business_id like if(?=0,'%%',?) and c.plant_id like if(?=0,'%%',?)"; 
	
	private static final String GET_PURCHASE_ORDER_ITEM_LIST="select poi.poi_id,poi.rate,poi.quantity,p.product_name"+
													" from test_purchase_order_item poi,product p"+
													" where poi.product_id=p.product_id"+
													" and poi.order_id=?";

	private static final String GET_SINGLE_PURCHASE_ORDER_DETAILS="select c.customer_name,s.site_name,m.mp_name,b.group_name,"+
			" DATE_FORMAT(po_date,'%d/%m/%Y') as po_date,"+
			" (select plant_name from plant where plant_id=po.plant_id) as plant_name,po.rate_include_tax,"+
			" po.po_number,po.order_type,g.gst_percent,g.gst_category"+
			" from test_purchase_order po LEFT JOIN (test_customer c,test_site_detail s,gst_percent g,marketing_person m,business_group b)"+
			" ON po.customer_id=c.customer_id"+
			" and po.site_id=s.site_id"+
			" and po.gst_id=g.gst_id"+
			" and po.marketing_person_id=m.mp_id"+
			" and c.business_id=b.business_id"+
			" where po.order_id=?";
	
	private static final String GET_SINGLE_PURCHASE_ORDER_DETAILS_ITEMS="select poi.poi_id,poi.rate,"+
			" poi.quantity,p.product_name,(select sum(quantity) from test_invoice where poi_id=poi.poi_id) as tquantity"+
			" from test_purchase_order_item poi,product p"+
			" where poi.product_id=p.product_id"+
			" and poi.order_id=?";
	
	

	public PurchaseOrderDAOImpl() {
		con=DBUtil.getConnection();
	}
	@Override
	public int insertPurchaseOrder(PurchaseOrderBean bean) throws Exception {
		ps=con.prepareStatement(INSERT_QUERY);
		ps.setString(1, bean.getPo_date());
		ps.setString(2, bean.getPo_valid_till());
		ps.setString(3, bean.getTax_group());
		ps.setInt(4, bean.getCustomer_id());
		ps.setInt(5,bean.getAddress_id());
		ps.setInt(6, bean.getMarketing_person_id());
		ps.setInt(7, bean.getPlant_id());
		ps.setString(8, bean.getPo_number());
		ps.setString(9, bean.getRate_include_tax());
		ps.setFloat(10, bean.getGst_percent());
		ps.setString(11, bean.getOrder_type());
		ps.setString(12, bean.getBill_photo());
		ps.setInt(13, bean.getCredit_days());
		ps.setDouble(14, bean.getCredit_limit());
		ps.setInt(15, bean.getGst_id());
		int count=ps.executeUpdate();
		return count;
	}
	@Override
	public int insertPurchaseOrderItem(PurchaseOrderItemBean bean) throws Exception {
		ps=con.prepareStatement(INSERT_PURCHASE_ITEM);
		ps.setInt(1, bean.getProduct_id());
		ps.setDouble(2,  bean.getQuantity());
		ps.setDouble(3, bean.getRate());
		ps.setInt(4, bean.getOrder_id());
		int count=ps.executeUpdate();
		return count;
	}
	@Override
	public int getHighestOrderId() throws Exception {
		ps=con.prepareStatement(GET_MAX_ORDER_ID);
		rs=ps.executeQuery();
		if(rs.next()) {
			return rs.getInt(1);
		}
		else {
			return 0;
		}
	}
	@Override
	public int updatePurchaseOrder(PurchaseOrderBean bean) throws Exception {
		ps=con.prepareStatement(UPDATE_QUERY);
		ps.setString(1, bean.getPo_date());
		ps.setString(2, bean.getPo_valid_till());
		ps.setString(3, bean.getTax_group());
		ps.setInt(4, bean.getCustomer_id());
		ps.setInt(5,bean.getAddress_id());
		ps.setInt(6, bean.getMarketing_person_id());
		ps.setInt(7, bean.getPlant_id());
		ps.setString(8, bean.getPo_number());
		ps.setString(9, bean.getRate_include_tax());
		ps.setFloat(10, bean.getGst_percent());
		ps.setString(11, bean.getOrder_type());
		ps.setString(12, bean.getBill_photo());
		ps.setInt(13, bean.getCredit_days());
		ps.setDouble(14, bean.getCredit_limit());
		ps.setInt(15, bean.getGst_id());
		ps.setInt(16, bean.getOrder_id());
		int count=ps.executeUpdate();
		return count;
	}
	@Override
	public int updatePurchaseOrderItem(PurchaseOrderItemBean bean) throws Exception {
		ps=con.prepareStatement(UPDATE_PURCHASE_ITEM);
		ps.setInt(1, bean.getProduct_id());
		ps.setDouble(2,  bean.getQuantity());
		ps.setDouble(3, bean.getRate());
		ps.setInt(4, bean.getOrder_id());
		ps.setInt(5, bean.getPoi_id());
		int count=ps.executeUpdate();
		return count;
	}
	@Override
	public int cancelPurchaseOrder(int order_id) throws Exception {
		ps=con.prepareStatement(CANCEL_ORDER);
		ps.setInt(1, order_id);
		int count=ps.executeUpdate();
		return count;
	}
	@Override
	public int activatePurchaseOrder(int order_id) throws Exception {
		ps=con.prepareStatement(ACTIVATE_ORDER);
		ps.setInt(1, order_id);
		int count=ps.executeUpdate();
		return count;
	}
	
	@Override
	public List<Map<String, Object>> getAllPurchaseOrderList(int customer_id, int site_id, String from_date,
			String to_date, String po_number, int business_id, int plant_id, int start, int length) throws Exception {
		ps=con.prepareStatement(GET_PURCHASE_ORDER_LIST);
		ps1=con.prepareStatement(GET_PURCHASE_ORDER_ITEM_LIST);
		ps.setInt(1, customer_id);
		ps.setInt(2, customer_id);
		ps.setInt(3, site_id);
		ps.setInt(4, site_id);
		ps.setString(5, "%"+po_number+"%");
		ps.setString(6, from_date);
		ps.setString(7, from_date);
		ps.setString(8, to_date);
		ps.setString(9, to_date);
		ps.setInt(10, business_id);
		ps.setInt(11, business_id);
		ps.setInt(12, plant_id);
		ps.setInt(13, plant_id);
		ps.setInt(14, start);
		ps.setInt(15, length);
		rs=ps.executeQuery();
		System.out.println(ps.toString());
		List<Map<String,Object>> poList=new ArrayList<Map<String,Object>>();
		while(rs.next()) {
			//set for poItemList
			ps1.setInt(1, rs.getInt("order_id"));
			rs1=ps1.executeQuery();
			
			//set po value here
			Map<String,Object> poData=new HashMap<String, Object>();
			poData.put("order_id", rs.getInt("order_id"));
			poData.put("customer_name", rs.getString("customer_name"));
			poData.put("site_name", rs.getString("site_name"));
			poData.put("po_date", rs.getString("po_date"));
			poData.put("plant_name", rs.getString("plant_name"));
			poData.put("rate_include_tax", rs.getString("rate_include_tax"));
			poData.put("po_number", rs.getString("po_number"));
			poData.put("order_type", rs.getString("order_type"));
			poData.put("gst_percent", rs.getDouble("gst_percent"));
			poData.put("gst_category", rs.getString("gst_category"));
			poData.put("status", rs.getString("status"));
			poData.put("mp_name", rs.getString("mp_name"));
			List<Map<String,Object>> poItemList=new ArrayList<Map<String,Object>>();
			while(rs1.next()) {
				Map<String,Object> poItem=new HashMap<String, Object>();
				poItem.put("poi_id", rs1.getInt("poi_id"));
				poItem.put("rate", rs1.getDouble("rate"));
				poItem.put("quantity", rs1.getDouble("quantity"));
				poItem.put("product_name", rs1.getString("product_name"));
				poItemList.add(poItem);
			}
			poData.put("poItemList", poItemList);
			poList.add(poData);
		}
		return poList;
	}
	
	@Override
	public int countAllPurchaseOrderList(int customer_id, int site_id, String from_date, String to_date,
			String po_number,int business_id, int plant_id) throws Exception {
		ps=con.prepareStatement(COUNT_PURCHASE_ORDER_LIST);
		ps.setInt(1, customer_id);
		ps.setInt(2, customer_id);
		ps.setInt(3, site_id);
		ps.setInt(4, site_id);
		ps.setString(5, "%"+po_number+"%");
		ps.setString(6, from_date);
		ps.setString(7, from_date);
		ps.setString(8, to_date);
		ps.setString(9, to_date);
		ps.setInt(10, business_id);
		ps.setInt(11, business_id);
		ps.setInt(12, plant_id);
		ps.setInt(13, plant_id);
		rs=ps.executeQuery();
		if(rs.next()) {
			return rs.getInt(1);
		}else
			return 0;
	}
	
	
	@Override
	public Map<String, Object> getPurchaseOrderDetails(int order_id) throws Exception {
		ps=con.prepareStatement(GET_SINGLE_PURCHASE_ORDER_DETAILS);
		ps1=con.prepareStatement(GET_SINGLE_PURCHASE_ORDER_DETAILS_ITEMS);
		ps.setInt(1, order_id);
		ps1.setInt(1, order_id);
		rs=ps.executeQuery();
		rs1=ps1.executeQuery();
		Map<String,Object> data=new HashMap<String, Object>();
		while(rs.next()) {
			//set the data
			data.put("customer_name", rs.getString("customer_name"));
			data.put("site_address", rs.getString("site_name"));
			data.put("mp_name", rs.getString("mp_name"));
			data.put("po_date", rs.getString("po_date"));
			data.put("plant_name", rs.getString("plant_name"));
			data.put("rate_include_tax", rs.getString("rate_include_tax"));
			data.put("po_number", rs.getString("po_number"));
			data.put("order_type", rs.getString("order_type"));
			data.put("gst_percent", rs.getString("gst_percent"));
			data.put("gst_category", rs.getString("gst_category"));
			data.put("group_name", rs.getString("group_name"));
			List<Map<String,Object>> itemList=new ArrayList<Map<String,Object>>();
			while(rs1.next()) {
				Map<String,Object> item=new HashMap<String, Object>();
				item.put("product_name", rs1.getString("product_name"));
				item.put("rate", rs1.getDouble("rate"));
				item.put("quantity", rs1.getDouble("quantity"));
				item.put("tquantity", rs1.getDouble("tquantity"));
				itemList.add(item);
			}
			data.put("itemList", itemList);
		}
		return data;
	}	
	
	
}
