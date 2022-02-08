package com.willka.soft.test.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.willka.soft.test.bean.SalesDocumentBean;
import com.willka.soft.test.bean.SalesDocumentItemBean;
import com.willka.soft.util.DBUtil;

public class SalesDocumentDAOImpl implements SalesDocumentDAO{
	private Connection con=null;
	private CallableStatement cs=null;
	private ResultSet rs=null;
	private PreparedStatement ps=null;
	private PreparedStatement ps1=null;
	private ResultSet rs1=null;
	
	
	private static final String INSERT_SALES_DOCUMENT="insert into test_sales_document(invoice_id,customer_id,"
			+ "site_id,invoice_date,invoice_time,plant_id,vehicle_no,driver_name,start_year,end_year) values(?,?,?,?,?,?,?,?,?,?)";
	
	private static final String UPDATE_SALES_DOCUMENT="update test_sales_document set customer_id=?,site_id=?,"
			+ "invoice_date=?,invoice_time=?,plant_id=?,vehicle_no=?,driver_name=? where id=?";
	
	private static final String INSERT_SALES_ITEM="insert into test_sales_document_item(id,poi_id,item_quantity,item_price,gross_price,tax_price,net_price) values(?,?,?,?,?,?,?)";
	
	private static final String UPDATE_SALES_ITEM="update test_sales_document_item set poi_id=?,item_quantity=?,"
							+ "item_price=?,gross_price=?,tax_price=?,net_price=? where sditem_id=?";
	
	private static final String CANCEL_SALES_DOCUMENT="update test_sales_document set invoice_status='cancelled' where id=?";
	
	private static final String GET_MAX_ID="select max(id) from test_sales_document";
	
	private static final String GET_INVOICE_NO="select IF(c.invoice_id IS NULL,1,c.invoice_id+1) as invoice_id"+
											" from (select max(id) as id FROM"+
											" test_sales_document "+
											" where start_year=?"+
											" and end_year = ?"+
											" and plant_id=?"+
								 		" ) as t,test_sales_document c"+
								 	" where c.id =t.id";
	
	private static final String GET_SALES_DOCUMENT_LIST="select s.invoice_id,s.id,c.customer_name,st.site_name,DATE_FORMAT(s.invoice_date,'%d/%m/%Y') as invoice_date,"+
			" s.invoice_time,p.plant_name,s.vehicle_no,s.invoice_status,s.driver_name,s.invoice_status"+
			" from test_sales_document s LEFT JOIN(test_customer c,test_site_detail st, plant p)"+
			" ON s.customer_id=c.customer_id"+
			" and s.site_id=st.site_id"+
			" and s.plant_id=p.plant_id"+
			" where s.customer_id like if(?=0,'%%',?)"+
			" and s.site_id like if(?=0,'%%',?)"+
			" and s.invoice_date between if(?='','2000-01-01',?) and if(?='','2050-01-01',?)"+
			" and p.business_id like if(?=0,'%%',?)"+
			" and s.plant_id like if(?=0,'%%',?)"+
			" and s.invoice_id like if(?='','%%',?)"+
			" order by s.id desc"+
			" limit ?,?";
	
	
	private static final String COUNT_SALES_DOCUMENT_LIST="select count(id) as count"+
			" from test_sales_document s,plant pl"+ 
			" where s.plant_id=pl.plant_id "+
			" and customer_id like if(?=0,'%%',?)"+
			" and site_id like if(?=0,'%%',?)"+
			" and invoice_date between if(?='','2000-01-01',?) and if(?='','2050-01-01',?)"+
			" and pl.business_id like if(?=0,'%%',?)"+
			" and s.plant_id like if(?=0,'%%',?)"+
			" and s.invoice_id like if(?='','%%',?)";
	
	
	private static final String GET_SALES_DOCUMENT_ITEM_LIST="select p.product_name,si.item_price,si.item_quantity,"+
			" si.gross_price,si.tax_price,si.net_price"+
			" from test_sales_document_item si,test_purchase_order_item poi,product p"+
			" where si.poi_id=poi.poi_id"+
			" and poi.product_id=p.product_id"+
			" and si.id=?";

	private static final String DELETE_SINGLE_SALES_DOCUMENT_ITEM="delete from test_sales_document_item where sditem_id=?";
	
	
	
	public SalesDocumentDAOImpl() {
		con=DBUtil.getConnection();
	}
	
	@Override
	public int insertSalesDocument(SalesDocumentBean bean) throws Exception {
		ps=con.prepareStatement(INSERT_SALES_DOCUMENT);
		ps.setInt(1, bean.getInvoice_id());
		ps.setInt(2, bean.getCustomer_id());
		ps.setInt(3, bean.getSite_id());
		ps.setString(4,  bean.getInvoice_date());
		ps.setString(5,  bean.getInvoice_time());
		ps.setInt(6, bean.getPlant_id());
		ps.setString(7, bean.getVehicle_no());
		ps.setString(8, bean.getDriver_name());
		ps.setInt(9, bean.getStart_year());
		ps.setInt(10, bean.getEnd_year());
		return ps.executeUpdate();
		
	}

	@Override
	public int updateSalesDocument(SalesDocumentBean bean) throws Exception {
		ps=con.prepareStatement(UPDATE_SALES_DOCUMENT);
		ps.setInt(1, bean.getCustomer_id());
		ps.setInt(2, bean.getSite_id());
		ps.setString(3, bean.getInvoice_date());
		ps.setString(4, bean.getInvoice_time());
		ps.setInt(5, bean.getPlant_id());
		ps.setString(6, bean.getVehicle_no());
		ps.setString(7, bean.getDriver_name());
		ps.setInt(8,bean.getId());
		int count=ps.executeUpdate();
		return count;
	}

	@Override
	public int insertSalesDocumentItem(SalesDocumentItemBean bean) throws Exception {
		ps=con.prepareStatement(INSERT_SALES_ITEM);
		ps.setInt(1, bean.getId());
		ps.setInt(2, bean.getPoi_id());
		ps.setDouble(3, bean.getItem_quantity());
		ps.setDouble(4, bean.getItem_price());
		ps.setDouble(5, bean.getGross_price());
		ps.setDouble(6, bean.getTax_price());
		ps.setDouble(7, bean.getNet_price());
		int count=ps.executeUpdate();
		return count;
	}

	@Override
	public int updateSalesDocumentItem(SalesDocumentItemBean bean) throws Exception {
		ps=con.prepareStatement(UPDATE_SALES_ITEM);
		ps.setInt(1, bean.getPoi_id());
		ps.setDouble(2, bean.getItem_quantity());
		ps.setDouble(3, bean.getItem_price());
		ps.setDouble(4, bean.getGross_price());
		ps.setDouble(5, bean.getTax_price());
		ps.setDouble(6, bean.getNet_price());
		ps.setInt(7, bean.getSditem_id());
		int count=ps.executeUpdate();
		return count;
	}

	@Override
	public int cancelSalesDocument(int id) throws Exception {
		ps=con.prepareStatement(CANCEL_SALES_DOCUMENT);
		ps.setInt(1, id);
		int count=ps.executeUpdate();
		return count;
	}

	@Override
	public int getMaxId() throws Exception {
		ps=con.prepareStatement(GET_MAX_ID);
		rs=ps.executeQuery();
		if(rs.next()) {
			return rs.getInt(1);
		}
		else {
			return 0;
		}
	}

	@Override
	public int getLastInvoiceNo(int plant_id, int start_year, int end_year) throws Exception {
		ps=con.prepareStatement(GET_INVOICE_NO);
		ps.setInt(1,start_year);
		ps.setInt(2, end_year);
		ps.setInt(3, plant_id);
		rs=ps.executeQuery();
		if(rs.next()) {
			return rs.getInt(1);
		}else {
			return 1;
		}
	}

	@Override
	public List<Map<String, Object>> getSalesDocumentList(int customer_id, int site_id, String from_date,
			String to_date, String invoice_id, int plant_id, int business_id, int start, int length) throws Exception {
		ps=con.prepareStatement(GET_SALES_DOCUMENT_LIST);
		ps1=con.prepareStatement(GET_SALES_DOCUMENT_ITEM_LIST);
		ps.setInt(1, customer_id);
		ps.setInt(2, customer_id);
		ps.setInt(3, site_id);
		ps.setInt(4, site_id);
		ps.setString(5, from_date);
		ps.setString(6, from_date);
		ps.setString(7, to_date);
		ps.setString(8, to_date);
		ps.setInt(9, business_id);
		ps.setInt(10, business_id);
		ps.setInt(11, plant_id);
		ps.setInt(12, plant_id);
		ps.setString(13,invoice_id);
		ps.setString(14, invoice_id);
		ps.setInt(15, start);
		ps.setInt(16, length);
		rs=ps.executeQuery();
		List<Map<String,Object>> list=new ArrayList<Map<String,Object>>();
		while(rs.next()) {
			ps1.setInt(1, rs.getInt("id"));
			rs1=ps1.executeQuery();
			Map<String,Object> data=new HashMap<String, Object>();
			data.put("id", rs.getInt("id"));
			data.put("invoice_id", rs.getInt("invoice_id"));
			data.put("customer_name", rs.getString("customer_name"));
			data.put("site_name", rs.getString("site_name"));
			data.put("invoice_date", rs.getString("invoice_date"));
			data.put("invoice_time", rs.getString("invoice_time"));
			data.put("plant_name", rs.getString("plant_name"));
			data.put("vehicle_no", rs.getString("vehicle_no"));
			data.put("driver_nem", rs.getString("driver_name"));
			data.put("invoice_status", rs.getString("invoice_status"));
			List<Map<String,Object>> itemList=new ArrayList<Map<String,Object>>();
			while(rs1.next()) {
				Map<String,Object> item=new HashMap<String, Object>();
				item.put("product_name", rs1.getString("product_name"));
				item.put("item_price", rs1.getDouble("item_price"));
				item.put("item_quantity", rs1.getDouble("item_quantity"));
				item.put("gross_price", rs1.getDouble("gross_price"));
				item.put("tax_price", rs1.getDouble("tax_price"));
				item.put("net_price", rs1.getDouble("net_price"));
				itemList.add(item);
			}
			
			data.put("itemList", itemList);
			list.add(data);
			
			
		}
		return list;
	}

	@Override
	public int countSalesDocumentList(int customer_id, int site_id, String from_date, String to_date, String invoice_id,
			int plant_id, int business_id) throws Exception {
		ps=con.prepareStatement(COUNT_SALES_DOCUMENT_LIST);
		ps.setInt(1, customer_id);
		ps.setInt(2, customer_id);
		ps.setInt(3, site_id);
		ps.setInt(4, site_id);
		ps.setString(5, from_date);
		ps.setString(6, from_date);
		ps.setString(7, to_date);
		ps.setString(8, to_date);
		ps.setInt(9, business_id);
		ps.setInt(10, business_id);
		ps.setInt(11, plant_id);
		ps.setInt(12, plant_id);
		ps.setString(13,invoice_id);
		ps.setString(14, invoice_id);
		rs=ps.executeQuery();
		if(rs.next())
			return rs.getInt(1);
		else
			return 0;
	}

	@Override
	public int deleteSingleSalesDocumentItem(int sditem_id) throws Exception {
		ps=con.prepareStatement(DELETE_SINGLE_SALES_DOCUMENT_ITEM);
		ps.setInt(1, sditem_id);
		int count=ps.executeUpdate();
		return count;
	}

}
