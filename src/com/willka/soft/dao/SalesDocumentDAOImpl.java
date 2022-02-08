package com.willka.soft.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.willka.soft.bean.SalesDocumentBean;
import com.willka.soft.bean.SalesDocumentItemBean;
import com.willka.soft.util.DBUtil;

public class SalesDocumentDAOImpl implements SalesDocumentDAO{
	private Connection con=null;
	private CallableStatement cs=null;
	private ResultSet rs=null;
	private PreparedStatement ps=null;
	private PreparedStatement ps1=null;
	private ResultSet rs1=null;
	
	
	private static final String INSERT_SALES_DOCUMENT="insert into sales_document(invoice_id,customer_id,"
			+ "site_id,invoice_date,invoice_time,plant_id,vehicle_no,driver_name,start_year,end_year,tcs_percent,round_off,documents) values(?,?,?,?,?,?,?,?,?,?,?,?,?)";
	
	private static final String UPDATE_SALES_DOCUMENT="update sales_document set customer_id=?,site_id=?,"
			+ "invoice_date=?,invoice_time=?,plant_id=?,vehicle_no=?,driver_name=?,tcs_percent=?,round_off=?,documents=?,invoice_id=? where id=?";
	
	private static final String INSERT_SALES_ITEM="insert into sales_document_item(id,poi_id,item_quantity,"
			+ "item_price,gross_price,tax_price,net_price,tcs_price) values(?,?,?,?,?,?,?,?)";
	
	private static final String UPDATE_SALES_ITEM="update sales_document_item set poi_id=?,item_quantity=?,"
							+ "item_price=?,gross_price=?,tax_price=?,net_price=?,tcs_price=? where sditem_id=?";
	
	private static final String CANCEL_SALES_DOCUMENT="update sales_document set invoice_status='cancelled' where id=?";
	
	private static final String GET_MAX_ID="select max(id) from sales_document";
	
	private static final String GET_INVOICE_NO="select IF(c.invoice_id IS NULL,1,c.invoice_id+1) as invoice_id"+
											" from (select max(id) as id FROM"+
											" sales_document s,plant p "+
											" where s.plant_id=p.plant_id"+
											" and start_year=?"+
											" and end_year = ?"+
											" and p.business_id=?"+
											" and p.plant_id=?"+
								 		" ) as t,sales_document c"+
								 	" where c.id =t.id";
	
	private static final String GET_SALES_DOCUMENT_LIST="select s.invoice_id,s.id,c.customer_name,st.site_name,DATE_FORMAT(s.invoice_date,'%d/%m/%Y') as invoice_date,"+
			" s.invoice_time,p.plant_name,s.vehicle_no,s.invoice_status,s.driver_name,s.invoice_status,s.documents"+
			" from sales_document s LEFT JOIN(customer c,site_detail st, plant p)"+
			" ON s.customer_id=c.customer_id"+
			" and s.site_id=st.site_id"+
			" and s.plant_id=p.plant_id"+
			" where s.customer_id like if(?=0,'%%',?)"+
			" and s.site_id like if(?=0,'%%',?)"+
			" and s.invoice_date between if(?='','2000-01-01',?) and if(?='','2050-01-01',?)"+
			" and p.business_id like if(?=0,'%%',?)"+
			" and s.plant_id like if(?=0,'%%',?)"+
			" and s.invoice_id like if(''=?,'%%',?)"+
			" and s.invoice_status='active'"+
			" order by s.id desc"+
			" limit ?,?";
	
	
	private static final String COUNT_SALES_DOCUMENT_LIST="select count(id) as count"+
			" from sales_document s,plant pl"+ 
			" where s.plant_id=pl.plant_id "+
			" and customer_id like if(?=0,'%%',?)"+
			" and site_id like if(?=0,'%%',?)"+
			" and invoice_date between if(?='','2000-01-01',?) and if(?='','2050-01-01',?)"+
			" and pl.business_id like if(?=0,'%%',?)"+
			" and s.plant_id like if(?=0,'%%',?)"+
			" and s.invoice_id like  if(''=?,'%%',?) and s.invoice_status='active'";
	
	
	private static final String GET_SALES_DOCUMENT_ITEM_LIST="select p.product_name,si.item_price,si.item_quantity,"+
			" si.gross_price,si.tax_price,si.net_price"+
			" from sales_document_item si,purchase_order_item poi,product p"+
			" where si.poi_id=poi.poi_id"+
			" and poi.product_id=p.product_id"+
			" and si.id=?";
	
	private static final String GET_SALES_CONSOLIDATE_INVOICE="select c.consolidate_invoice_id,p.plant_name,c.cons_id,c.invoice_status"+
			" ,DATE_FORMAT(c.generate_date,'%d/%m/%Y') as realdate,cu.customer_name,"+
			" (select count(id) from consolidate_invoice_item where consolidate_invoice_id=c.consolidate_invoice_id) as noofinvoice"+
			" from consolidate_invoice c,customer cu,plant p"+
			" where c.customer_id=cu.customer_id"+
			" and c.plant_id=p.plant_id"+
			" and c.customer_id like if(0=?,'%%',?)"+
			" and c.cons_id like if(?='','%%',?)"+
			" and c.generate_date between if(''=?,'2000-01-01',?) and if(''=?,'2050-01-01',?)"+
			" and p.business_id like if(?=0,'%%',?)"+
			" and c.plant_id like if(?=0,'%%',?)"+
			" and c.type='sales'"+
			" order by consolidate_invoice_id desc"+
			" limit ?,?";
	
	private static final String COUNT_CONSOLIDATE_INVOICE="select count(c.consolidate_invoice_id)"+
			" from consolidate_invoice c,plant p"+
			" where c.plant_id=p.plant_id"+
			" and c.customer_id like if(0=?,'%%',?)"+
			" and c.cons_id like if(?='','%%',?)"+
			" and c.generate_date between if(''=?,'2000-01-01',?) and if(''=?,'2050-01-01',?)"+
			" and p.business_id like if(?=0,'%%',?)"+
			" and c.plant_id like if(?=0,'%%',?)"+
			" and c.type='sales'";
	
	private static final String GET_PLANT_ID_BY_BUSNESS_ID="select business_id from plant where plant_id=?";

	private static final  String GET_TOTAL_NET_AMOUNT="select sum(net_price) from sales_document_item sdi,sales_document sd where  sd.id=sdi.id and sd.customer_id=? and sd.start_year=? and sd.end_year=?";
	
	private static final String GET_TOTAL_NET_AMOUNT_OF_INVOICE="select sum(net_amount) from invoice where customer_id=? and start_year=? and end_year=?";
	
	
	
	
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
		ps.setDouble(11, bean.getTcs_percent());
		ps.setDouble(12, bean.getRound_off());
		ps.setString(13, bean.getDocuments());
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
		ps.setDouble(8, bean.getTcs_percent());
		ps.setDouble(9, bean.getRound_off());
		ps.setString(10, bean.getDocuments());
		ps.setInt(11, bean.getInvoice_id());
		ps.setInt(12,bean.getId());
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
		ps.setDouble(8, bean.getTcs_price());
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
		ps.setDouble(7, bean.getTcs_price());
		ps.setInt(8, bean.getSditem_id());
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
	public int getLastInvoiceNo(int business_id, int start_year, int end_year, int plant_id) throws Exception {
		ps=con.prepareStatement(GET_INVOICE_NO);
		ps.setInt(1,start_year);
		ps.setInt(2, end_year);
		ps.setInt(3, business_id);
		ps.setInt(4, plant_id);
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
		ps.setString(13, invoice_id);
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
			data.put("documents", rs.getString("documents"));
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
		ps.setString(13, invoice_id);
		ps.setString(14, invoice_id);
		rs=ps.executeQuery();
		if(rs.next())
			return rs.getInt(1);
		else
			return 0;
	}

	@Override
	public List<Map<String, Object>> getSalesConsolidateInvoiceList(String cons_id, int customer_id, String form_date,
			String to_date, int business_id, int plant_id, int start, int length) throws Exception {
		ps=con.prepareStatement(GET_SALES_CONSOLIDATE_INVOICE);
		ps.setInt(1, customer_id);
		ps.setInt(2, customer_id);
		ps.setString(3, cons_id);
		ps.setString(4, cons_id);
		ps.setString(5, form_date);
		ps.setString(6, form_date);
		ps.setString(7, to_date);
		ps.setString(8, to_date);
		ps.setInt(9, business_id);
		ps.setInt(10, business_id);
		ps.setInt(11, plant_id);
		ps.setInt(12, plant_id);
		ps.setInt(13, start);
		ps.setInt(14, length);
		rs=ps.executeQuery();
		List<Map<String,Object>> list=new ArrayList<>();
		while(rs.next()) {
			Map<String,Object> data=new HashMap<>();
			data.put("consolidate_invoice_id", rs.getInt("consolidate_invoice_id"));
			data.put("plant_name", rs.getString("plant_name"));
			data.put("cons_id", rs.getString("cons_id"));
			data.put("invoice_status", rs.getString("invoice_status"));
			data.put("realdate", rs.getString("realdate"));
			data.put("customer_name", rs.getString("customer_name"));
			data.put("noofinvoice", rs.getInt("noofinvoice"));
			list.add(data);
		}
		return list;
	}

	@Override
	public int countSalesConsolidateInvoice(String cons_id, int customer_id, String from_date, String to_date,
			int plant_id, int business_id) throws Exception {
		ps=con.prepareStatement(COUNT_CONSOLIDATE_INVOICE);
		ps.setInt(1, customer_id);
		ps.setInt(2, customer_id);
		ps.setString(3, cons_id);
		ps.setString(4, cons_id);
		ps.setString(5, from_date);
		ps.setString(6, from_date);
		ps.setString(7, to_date);
		ps.setString(8, to_date);
		ps.setInt(9, business_id);
		ps.setInt(10, business_id);
		ps.setInt(11, plant_id);
		ps.setInt(12, plant_id);
		rs=ps.executeQuery();
		if(rs.next())
			return rs.getInt(1);
		else
			return 0;
	}

	@Override
	public int getBusinessIdByPlantId(int plant_id) throws Exception {
		ps=con.prepareStatement(GET_PLANT_ID_BY_BUSNESS_ID);
		ps.setInt(1, plant_id);
		rs=ps.executeQuery();
		if(rs.next()) {
			return rs.getInt(1);
		}else
			return 0;
	}

	@Override
	public double getTotalNetAmount(int customer_id, int start_year, int end_year) throws Exception {
		ps=con.prepareStatement(GET_TOTAL_NET_AMOUNT);
		ps.setInt(1, customer_id);
		ps.setInt(2, start_year);
		ps.setInt(3, end_year);
		rs=ps.executeQuery();
		double net_amount=0;
		if(rs.next()) {
			net_amount+=rs.getDouble(1);
		}
		
		ps=con.prepareStatement(GET_TOTAL_NET_AMOUNT_OF_INVOICE);
		ps.setInt(1, customer_id);
		ps.setInt(2, start_year);
		ps.setInt(3,end_year);
		rs=ps.executeQuery();
		if(rs.next()) {
			net_amount+=rs.getDouble(1);
		}
		return net_amount;
	}
	
	
	
	@Override
	public int[] updateInvoiceNoInDC(String[] dc_nos,int id) throws Exception {
		ps=con.prepareStatement("update dc set sd_no=? where id=?");
		for(String dc_no:dc_nos) {
			int dc_id=Integer.parseInt(dc_no);
			ps.setInt(1, id);
			ps.setInt(2, dc_id);
			ps.addBatch();
		}
		
		return ps.executeBatch();
		
	}

}
