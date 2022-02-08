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

import com.willka.soft.bean.ConsolidateInvoiceBean;
import com.willka.soft.bean.ConsolidateInvoiceItemBean;
import com.willka.soft.bean.DCBean;
import com.willka.soft.bean.DCModificationBean;
import com.willka.soft.util.DBUtil;

public class DCDAOImpl implements DCDAO {

	private Connection con=null;
	private PreparedStatement ps=null;
	private ResultSet rs=null;
	private CallableStatement cs=null;
	
	private static final String INSERT_INVOICE="call dcsave(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
	
	private static final String INSERT_INVOICE_MODIFICATION="insert into dc_modification(invoice_id,modification_type,comment,modification_user) values(?,?,?,?)";
	
	private static final String UPDATE_VEHICLE_PUMP="update dc set vehicle_no=?,driver_name=?,pump=? where id=?";
	
	private static final String UPDATE_DATE_TIME="update dc set invoice_date=?,invoice_time=? where id=?";
	
	private static final String UPDATE_FULL_INVOICE="update dc set plant_id=?, customer_id=?, site_id=?, poi_id=?, invoice_date=?, invoice_time=?, quantity=?, rate=?, gross_amount=?, tax_amount=?, net_amount=?, vehicle_no=?, pump=?, driver_name=?, project_block=?,km_reading=?,loaded_quantity=?,loaded_product_id=?,km_reading2=? where id=?";
	
	private static final String GENERATE_CONSOLIDATE_INVOICE="insert into consolidate_invoice(customer_id,pump_charge,advance_amount,plant_id,generate_date,cons_id,start_year,end_year) values(?,?,?,?,?,?,?,?)";
	
	private static final String ADD_CONSOLIDATE_INVOICE_ITEM="insert into consolidate_invoice_item(id,consolidate_invoice_id) values(?,?)";
	
	private static final String GET_MAX_CONSOLIDATE_INVOICE="select max(consolidate_invoice_id) from consolidate_invoice";
	
	private static final String GET_MAX_CONS_ID="select max(cons_id) from consolidate_invoice where start_year=? and end_year=?";
	
	private static final String CANCEL_CONSOLIDATE_INVOICE="delete from consolidate_invoice where consolidate_invoice_id=?";
	
	private static final String REFRESH_DC="delete from dcbatchingsheet where id=?";
	
	private static final String CANCEL_INVOICE="update dc set invoice_status='cancelled' where id=?";
	
	private static final String CHANGE_DOCKET_NO="update dc set docket_no=? where id=?";
	
	private static final String GET_INVOICE_NO="select max(invoice_id) as max_invoice from dc where start_year=? and end_year=? and plant_id=?";
	
	private static final String DELETE_INVOICE="delete from dc where id=?";
	
	private static final String GET_MAX_OF_ID="select max(id) from dc";
	
	
	private static final String DATE_WISE_REPORT=" select i.*,DATE_FORMAT(i.invoice_date,'%d/%m/%Y') as invoice_date,"
												+ " c.customer_name,s.site_name,s.site_address,pr.product_name,"
												+ " pr.product_id,p.plant_name,m.mp_name,c.customer_address,"
												+ " c.customer_gstin from dc i LEFT JOIN (customer c,site_detail s,"
												+ " purchase_order_item poi,product pr,plant p,purchase_order po,"
												+ " marketing_person m) ON i.customer_id=c.customer_id "
												+ " and i.site_id=s.site_id "
												+ " and i.poi_id=poi.poi_id "
												+ " and poi.order_id=poi.order_id "
												+ " and poi.product_id=pr.product_id "
												+ " and i.plant_id=p.plant_id "
												+ " and poi.order_id=po.order_id "
												+ " and po.marketing_person_id=m.mp_id "
												+ " where i.invoice_date between ? and ? "
												+ " and pr.product_id like if(''=?,'%%',?) "
												+ " and i.plant_id like if(''=?,'%%',?) "
												+ " and i.invoice_status='active' order by id asc ";
	
	private static final String CUSTOMER_WISE_REPORT=" select i.*,DATE_FORMAT(i.invoice_date,'%d/%m/%Y') as invoice_date,"
												+ " c.customer_name,s.site_name,s.site_address,pr.product_name,pr.product_id,p.plant_name,m.mp_name,"
												+ " c.customer_address,c.customer_gstin from dc i LEFT JOIN (customer c,site_detail s,purchase_order_item poi,"
												+ " product pr,plant p,purchase_order po,marketing_person m) "
												+ " ON i.customer_id=c.customer_id "
												+ " and i.site_id=s.site_id "
												+ " and i.poi_id=poi.poi_id "
												+ " and poi.order_id=poi.order_id "
												+ " and poi.product_id=pr.product_id "
												+ " and i.plant_id=p.plant_id "
												+ " and poi.order_id=po.order_id "
												+ " and po.marketing_person_id=m.mp_id "
												+ " where i.customer_id like if(0=?,'%%',?) "
												+ " and i.site_id like if(''=?,'%%',?) "
												+ " and pr.product_id like if(''=?,'%%',?) "
												+ " and i.plant_id like if(''=?,'%%',?) "
												+ " and i.invoice_status='active' order by id asc";
	
	private static final String MARKETING_PERSON_WISE_REPORT=" select i.*,DATE_FORMAT(i.invoice_date,'%d/%m/%Y') as invoice_date,"
												+ " c.customer_name,s.site_name,s.site_address,pr.product_name,"
												+ " pr.product_id,p.plant_name,m.mp_name,c.customer_address,"
												+ " c.customer_gstin from dc i LEFT JOIN (customer c,site_detail s,purchase_order_item poi,"
												+ " product pr,plant p,purchase_order po,marketing_person m) "
												+ " ON i.customer_id=c.customer_id "
												+ " and i.site_id=s.site_id "
												+ " and i.poi_id=poi.poi_id "
												+ " and poi.order_id=poi.order_id "
												+ " and poi.product_id=pr.product_id "
												+ " and i.plant_id=p.plant_id "
												+ " and poi.order_id=po.order_id "
												+ " and po.marketing_person_id=m.mp_id "
												+ " where po.marketing_person_id like if(''=?,'%%',?) "
												+ " and pr.product_id like if(''=?,'%%',?) "
												+ " and i.plant_id like if(''=?,'%%',?) "
												+ " and i.invoice_date between ? and ? "
												+ " and i.invoice_status='active' order by id asc";
	
	
	private static final String CUSTOMER_WITH_DATE_WISE_REPORT=" select i.*,DATE_FORMAT(i.invoice_date,'%d/%m/%Y') as invoice_date,"
												+ " c.customer_name,s.site_name,s.site_address,pr.product_name,pr.product_id,p.plant_name,m.mp_name,"
												+ " c.customer_address,c.customer_gstin from dc i LEFT JOIN (customer c,site_detail s,purchase_order_item poi,"
												+ " product pr,plant p,purchase_order po,marketing_person m) "
												+ " ON i.customer_id=c.customer_id "
												+ " and i.site_id=s.site_id "
												+ " and i.poi_id=poi.poi_id "
												+ " and poi.order_id=poi.order_id "
												+ " and poi.product_id=pr.product_id "
												+ " and i.plant_id=p.plant_id "
												+ " and poi.order_id=po.order_id "
												+ " and po.marketing_person_id=m.mp_id "
												+ " where i.customer_id like if(0=?,'%%',?) "
												+ " and i.invoice_date between ? and ? "
												+ " and i.site_id like if(''=?,'%%',?) "
												+ " and pr.product_id like if(''=?,'%%',?) "
												+ " and i.plant_id like if(''=?,'%%',?) "
												+ " and i.invoice_status='active' order by id,customer_name asc";
	
	private static final String VEHICLE_WITH_DATE_WISE_REPORT=" select i.*,DATE_FORMAT(i.invoice_date,'%d/%m/%Y') as invoice_date,"
												+ " c.customer_name,s.site_name,s.site_address,pr.product_name,"
												+ " pr.product_id,p.plant_name,m.mp_name,c.customer_address,"
												+ " c.customer_gstin from dc i LEFT JOIN (customer c,site_detail s,"
												+ " purchase_order_item poi,product pr,plant p,purchase_order po,"
												+ " marketing_person m) ON i.customer_id=c.customer_id "
												+ " and i.site_id=s.site_id "
												+ " and i.poi_id=poi.poi_id "
												+ " and poi.order_id=poi.order_id "
												+ " and poi.product_id=pr.product_id "
												+ " and i.plant_id=p.plant_id "
												+ " and poi.order_id=po.order_id "
												+ " and po.marketing_person_id=m.mp_id "
												+ " where i.vehicle_no like if(0=?,'%%',?) "
												+ " and i.invoice_date between ? and ? "
												+ " and pr.product_id like if(''=?,'%%',?) "
												+ " and i.plant_id like if(''=?,'%%',?) "
												+ " and i.invoice_status='active' order by id,vehicle_no asc";
	
	
	private static final String GET_PENDING_DC_FOR_INVOICE = "select p.* from ( select i.*,DATE_FORMAT(i.invoice_date,'%d/%m/%Y') as inv_date,"
										+ " c.customer_name,s.site_name,s.site_address,pr.product_name,pr.product_id,p.plant_name,"
										+ " c.customer_address,c.customer_gstin,po.rate_include_tax,g.gst_category,g.gst_percent,poi.rate as realRate"
										+ " from dc i LEFT JOIN (customer c,site_detail s,purchase_order_item poi,"
										+ " product pr,plant p,purchase_order po,gst_percent g) "
										+ " ON i.customer_id=c.customer_id "
										+ " and i.site_id=s.site_id "
										+ " and i.poi_id=poi.poi_id "
										+ " and poi.order_id=poi.order_id "
										+ " and poi.product_id=pr.product_id "
										+ " and i.plant_id=p.plant_id "
										+ " and poi.order_id=po.order_id "
										+"  and po.gst_id=g.gst_id"
										+ " where i.customer_id=? "
										+ " and i.site_id=? "
										+ " and i.plant_id=? "
										+ " and i.invoice_status='active' order by id asc) as p LEFT OUTER JOIN sales_document sd"
										+ " on  p.sd_no  = sd.id where sd.id is null";

	
	
	public DCDAOImpl() {
		con=DBUtil.getConnection();
	}
	@Override
	public int insertInvoice(DCBean bean) throws Exception {
		cs=con.prepareCall(INSERT_INVOICE);
		cs.setInt(1, bean.getPlant_id());
		cs.setInt(2, bean.getCustomer_id());
		cs.setInt(3, bean.getSite_id());
		cs.setInt(4, bean.getPoi_id());
		cs.setString(5, bean.getInvoice_date());
		cs.setString(6, bean.getInvoice_time());
		cs.setDouble(7,bean.getRate());
		cs.setDouble(8, bean.getQuantity());
		cs.setDouble(9, bean.getGross_amount());
		cs.setDouble(10, bean.getTax_amount());
		cs.setDouble(11, bean.getNet_amount());
		cs.setString(12, bean.getVehicle_no());
		cs.setString(13, bean.getPump());
		cs.setString(14, bean.getDriver_name());
		cs.registerOutParameter(15, Types.BIGINT);
		cs.setString(16, bean.getKm_reading());
		cs.setString(17, bean.getProject_block());
		cs.setDouble(18, bean.getLoaded_quantity());
		cs.setInt(19, bean.getLoaded_product_id());
		cs.setString(20, bean.getKm_reading2());
		cs.execute();
		int invoice_id=cs.getInt(15);
		return invoice_id;
	}
	@Override
	public int insertInvoiceModification(DCModificationBean bean) throws Exception {
		ps=con.prepareStatement(INSERT_INVOICE_MODIFICATION);
		ps.setInt(1, bean.getInvoice_id());
		ps.setString(2, bean.getModification_type());
		ps.setString(3, bean.getComment());
		ps.setString(4, bean.getModification_user());
		int count=ps.executeUpdate();
		return count;
	}
	@Override
	public int updateVehiclePumpDetails(int id, String vehicle_no, String driver_name, String pump) throws Exception {
		ps=con.prepareStatement(UPDATE_VEHICLE_PUMP);
		ps.setString(1, vehicle_no);
		ps.setString(2, driver_name);
		ps.setString(3, pump);
		ps.setInt(4, id);
		int count=ps.executeUpdate();
		return count;
	}
	@Override
	public int updateInvoiceDateTime(int id, String invoice_date, String invoice_time) throws Exception {
		ps=con.prepareStatement(UPDATE_DATE_TIME);
		ps.setString(1, invoice_date);
		ps.setString(2, invoice_time);
		ps.setInt(3, id);
		int count=ps.executeUpdate();
		return count;
	}
	@Override
	public int updateFullInvoice(DCBean bean) throws Exception {
		ps=con.prepareStatement(UPDATE_FULL_INVOICE);
		ps.setInt(1, bean.getPlant_id());
		ps.setInt(2, bean.getCustomer_id());
		ps.setInt(3, bean.getSite_id());
		ps.setInt(4, bean.getPoi_id());
		ps.setString(5, bean.getInvoice_date());
		ps.setString(6, bean.getInvoice_time());
		ps.setDouble(7, bean.getQuantity());
		ps.setDouble(8, bean.getRate());
		ps.setDouble(9, bean.getGross_amount());
		ps.setDouble(10, bean.getTax_amount());
		ps.setDouble(11, bean.getNet_amount());
		ps.setString(12, bean.getVehicle_no());
		ps.setString(13, bean.getPump());
		ps.setString(14, bean.getDriver_name());
		ps.setString(15, bean.getProject_block());
		ps.setString(16, bean.getKm_reading());
		ps.setDouble(17, bean.getLoaded_quantity());
		ps.setInt(18, bean.getLoaded_product_id());
		ps.setString(19, bean.getKm_reading2());
		ps.setInt(20, bean.getId());
		int count=ps.executeUpdate();
		return count;
	}
	
	@Override
	public int cancelConsolidateInvoice(int consolidate_invoice_id)throws Exception {
		ps=con.prepareStatement(CANCEL_CONSOLIDATE_INVOICE);
		ps.setInt(1, consolidate_invoice_id);
		int count=ps.executeUpdate();
		return count;
	}
	@Override
	public int refreshDC(int id) throws Exception {
		ps=con.prepareStatement(REFRESH_DC);
		ps.setInt(1, id);
		int count=ps.executeUpdate();
		return count;
	}
	@Override
	public int cancelInvoice(int id) throws Exception {
		ps=con.prepareStatement(CANCEL_INVOICE);
		ps.setInt(1, id);
		int count=ps.executeUpdate();
		return count;
	}
	
	
	@Override
	public int changeDocketNo(int id, String docket_no) throws Exception {
		ps=con.prepareStatement(CHANGE_DOCKET_NO);
		ps.setString(1, docket_no);
		ps.setInt(2, id);
		int count=ps.executeUpdate();
		return count;
	}

	@Override
	public int getInvoiceNo(int plant_id,int start_year,int end_year)throws Exception {
		ps=con.prepareStatement(GET_INVOICE_NO);
		ps.setInt(1,start_year);
		ps.setInt(2, end_year);
		ps.setInt(3, plant_id);
		rs=ps.executeQuery();
		if(rs.next()) {
			return rs.getInt(1);
		}else {
			return 0;
		}
	}
	@Override
	public int generateConsolidateInvoice(ConsolidateInvoiceBean bean) throws Exception {
		ps=con.prepareStatement(GENERATE_CONSOLIDATE_INVOICE);
		ps.setInt(1, bean.getCustomer_id());
		ps.setDouble(2, bean.getPump_charge());
		ps.setDouble(3, bean.getAdvance_amount());
		ps.setInt(4, bean.getPlant_id());
		ps.setString(5, bean.getGenerate_date());
		ps.setInt(6, bean.getCons_id());
		ps.setInt(7, bean.getStart_year());
		ps.setInt(8, bean.getEnd_year());
		int count=ps.executeUpdate();
		return count;
	}
	@Override
	public int addConsolidateInvoiceItem(ConsolidateInvoiceItemBean bean) throws Exception {
		ps=con.prepareStatement(ADD_CONSOLIDATE_INVOICE_ITEM);
		ps.setInt(1, bean.getId());
		ps.setInt(2, bean.getConsolidate_invoice_id());
		int count=ps.executeUpdate();
		return count;
	}
	@Override
	public int getMaxConsolidateInvoiceId() throws Exception {
		ps=con.prepareStatement(GET_MAX_CONSOLIDATE_INVOICE);
		rs=ps.executeQuery();
		if(rs.next()) {
			return rs.getInt(1);
		}else {
			return 1;
		}
	}
	@Override
	public int deleteInvoice(int id, int invoice_id) throws Exception {
		ps=con.prepareStatement(DELETE_INVOICE);
		ps.setInt(1, id);
		int count=ps.executeUpdate();
		return count;
	}
	
	
	@Override
	public int maxConsId(int start_year, int end_year) throws Exception {
		ps=con.prepareStatement(GET_MAX_CONS_ID);
		ps.setInt(1, start_year);
		ps.setInt(2, end_year);
		rs=ps.executeQuery();
		if(rs.next()) {
			return rs.getInt(1);
		}
		else
			return 0;
	}
	@Override
	public int getMaxOfId() throws Exception {
		ps=con.prepareStatement(GET_MAX_OF_ID);
		rs=ps.executeQuery();
		if(rs.next()) {
			return rs.getInt(1);
		}else
			return 0;
	}
	
	
	
	@Override
	public HashMap<String, Object> getDatewiseReport(String from_date, String to_date, int product_id, int plant_id)
			throws Exception {
		ps=con.prepareStatement(DATE_WISE_REPORT);
		ps.setString(1, from_date);
		ps.setString(2, to_date);
		ps.setInt(3, product_id);
		ps.setInt(4, product_id);
		ps.setInt(5, plant_id);
		ps.setInt(6, plant_id);
		rs=ps.executeQuery();
		HashMap<String, Object> map=new HashMap<String, Object>();
		if(rs.next()) {
			map.put("invoice_date", rs.getString("invoice_date"));
			map.put("invoice_id", rs.getInt("invoice_id"));
			map.put("customer_name", rs.getString("customer_name"));
			map.put("site_name", rs.getString("site_name"));
			map.put("site_address", rs.getString("site_address"));
			map.put("product_name", rs.getString("product_name"));
			map.put("invoice_time", rs.getString("invoice_time"));
			map.put("quantity", rs.getDouble("quantity"));
			map.put("rate", rs.getDouble("rate"));
			map.put("gross_amount", rs.getDouble("gross_amount"));
			map.put("tax_amount", rs.getDouble("tax_amount"));
			map.put("net_amount", rs.getDouble("net_amount"));
			map.put("vehicle_no", rs.getString("vehicle_no"));
			map.put("driver_name", rs.getString("driver_name"));
			map.put("pump", rs.getString("pump"));
			map.put("customer_address", rs.getString("customer_address"));
			map.put("customer_gstin", rs.getString("customer_gstin"));
			map.put("customer_phone", rs.getString("customer_phone"));
			map.put("mp_name", rs.getString("mp_name"));
			map.put("plant_name", rs.getString("plant_name"));
			
		}
		return map;
	}
	@Override
	public HashMap<String, Object> getCustomerWiseReport(int customer_id, int site_id, int product_id, int plant_id)
			throws Exception {
		ps=con.prepareStatement(CUSTOMER_WISE_REPORT);
		ps.setInt(1, customer_id);
		ps.setInt(2, customer_id);
		ps.setInt(3, site_id);
		ps.setInt(4, site_id);
		ps.setInt(5, product_id);
		ps.setInt(6, product_id);
		ps.setInt(7, plant_id);
		ps.setInt(8, plant_id);
		rs=ps.executeQuery();
		HashMap<String, Object> map=new HashMap<String, Object>();
		if(rs.next()) {
			map.put("invoice_date", rs.getString("invoice_date"));
			map.put("invoice_id", rs.getInt("invoice_id"));
			map.put("customer_name", rs.getString("customer_name"));
			map.put("site_name", rs.getString("site_name"));
			map.put("site_address", rs.getString("site_address"));
			map.put("product_name", rs.getString("product_name"));
			map.put("invoice_time", rs.getString("invoice_time"));
			map.put("quantity", rs.getDouble("quantity"));
			map.put("rate", rs.getDouble("rate"));
			map.put("gross_amount", rs.getDouble("gross_amount"));
			map.put("tax_amount", rs.getDouble("tax_amount"));
			map.put("net_amount", rs.getDouble("net_amount"));
			map.put("vehicle_no", rs.getString("vehicle_no"));
			map.put("driver_name", rs.getString("driver_name"));
			map.put("pump", rs.getString("pump"));
			map.put("customer_address", rs.getString("customer_address"));
			map.put("customer_gstin", rs.getString("customer_gstin"));
			map.put("customer_phone", rs.getString("customer_phone"));
			map.put("mp_name", rs.getString("mp_name"));
			map.put("plant_name", rs.getString("plant_name"));
			
		}
		return map;
	}
	@Override
	public HashMap<String, Object> getCustomerWithDateWiseReport(String from_date, String to_date, int customer_id,
			int site_id, int product_id, int plant_id) throws Exception {
		ps=con.prepareStatement(CUSTOMER_WITH_DATE_WISE_REPORT);
		ps.setInt(1, customer_id);
		ps.setInt(2, customer_id);
		ps.setString(3, from_date);
		ps.setString(4, to_date);
		ps.setInt(5, site_id);
		ps.setInt(6, site_id);
		ps.setInt(7, product_id);
		ps.setInt(8, product_id);
		ps.setInt(9, plant_id);
		ps.setInt(10, plant_id);
		rs=ps.executeQuery();
		HashMap<String, Object> map=new HashMap<String, Object>();
		if(rs.next()) {
			map.put("invoice_date", rs.getString("invoice_date"));
			map.put("invoice_id", rs.getInt("invoice_id"));
			map.put("customer_name", rs.getString("customer_name"));
			map.put("site_name", rs.getString("site_name"));
			map.put("site_address", rs.getString("site_address"));
			map.put("product_name", rs.getString("product_name"));
			map.put("invoice_time", rs.getString("invoice_time"));
			map.put("quantity", rs.getDouble("quantity"));
			map.put("rate", rs.getDouble("rate"));
			map.put("gross_amount", rs.getDouble("gross_amount"));
			map.put("tax_amount", rs.getDouble("tax_amount"));
			map.put("net_amount", rs.getDouble("net_amount"));
			map.put("vehicle_no", rs.getString("vehicle_no"));
			map.put("driver_name", rs.getString("driver_name"));
			map.put("pump", rs.getString("pump"));
			map.put("customer_address", rs.getString("customer_address"));
			map.put("customer_gstin", rs.getString("customer_gstin"));
			map.put("customer_phone", rs.getString("customer_phone"));
			map.put("mp_name", rs.getString("mp_name"));
			map.put("plant_name", rs.getString("plant_name"));
			
		}
		return map;
	}
	@Override
	public HashMap<String, Object> getVehicleWithDateWiseReport(String from_date, String to_date, String vehicle_no,
			int product_id, int plant_id) throws Exception {
		ps=con.prepareStatement(VEHICLE_WITH_DATE_WISE_REPORT);
		ps.setString(1, vehicle_no);
		ps.setString(2, vehicle_no);
		ps.setString(3, from_date);
		ps.setString(4, to_date);
		ps.setInt(5, product_id);
		ps.setInt(6, product_id);
		ps.setInt(7, plant_id);
		ps.setInt(8, plant_id);
		rs=ps.executeQuery();
		HashMap<String, Object> map=new HashMap<String, Object>();
		if(rs.next()) {
			map.put("invoice_date", rs.getString("invoice_date"));
			map.put("invoice_id", rs.getInt("invoice_id"));
			map.put("customer_name", rs.getString("customer_name"));
			map.put("site_name", rs.getString("site_name"));
			map.put("site_address", rs.getString("site_address"));
			map.put("product_name", rs.getString("product_name"));
			map.put("invoice_time", rs.getString("invoice_time"));
			map.put("quantity", rs.getDouble("quantity"));
			map.put("rate", rs.getDouble("rate"));
			map.put("gross_amount", rs.getDouble("gross_amount"));
			map.put("tax_amount", rs.getDouble("tax_amount"));
			map.put("net_amount", rs.getDouble("net_amount"));
			map.put("vehicle_no", rs.getString("vehicle_no"));
			map.put("driver_name", rs.getString("driver_name"));
			map.put("pump", rs.getString("pump"));
			map.put("customer_address", rs.getString("customer_address"));
			map.put("customer_gstin", rs.getString("customer_gstin"));
			map.put("customer_phone", rs.getString("customer_phone"));
			map.put("mp_name", rs.getString("mp_name"));
			map.put("plant_name", rs.getString("plant_name"));
			
		}
		return map;
	}
	@Override
	public HashMap<String, Object> getMarketingPersonWiseReport(String from_date, String to_date, int mp_id,
			int product_id, int plant_id) throws Exception {
		ps=con.prepareStatement(MARKETING_PERSON_WISE_REPORT);
		ps.setInt(1, mp_id);
		ps.setInt(2, mp_id);
		ps.setInt(3, product_id);
		ps.setInt(4, product_id);
		ps.setInt(5, plant_id);
		ps.setInt(6, plant_id);
		ps.setString(7, from_date);
		ps.setString(8, to_date);
		rs=ps.executeQuery();
		HashMap<String, Object> map=new HashMap<String, Object>();
		if(rs.next()) {
			map.put("invoice_date", rs.getString("invoice_date"));
			map.put("invoice_id", rs.getInt("invoice_id"));
			map.put("customer_name", rs.getString("customer_name"));
			map.put("site_name", rs.getString("site_name"));
			map.put("site_address", rs.getString("site_address"));
			map.put("product_name", rs.getString("product_name"));
			map.put("invoice_time", rs.getString("invoice_time"));
			map.put("quantity", rs.getDouble("quantity"));
			map.put("rate", rs.getDouble("rate"));
			map.put("gross_amount", rs.getDouble("gross_amount"));
			map.put("tax_amount", rs.getDouble("tax_amount"));
			map.put("net_amount", rs.getDouble("net_amount"));
			map.put("vehicle_no", rs.getString("vehicle_no"));
			map.put("driver_name", rs.getString("driver_name"));
			map.put("pump", rs.getString("pump"));
			map.put("customer_address", rs.getString("customer_address"));
			map.put("customer_gstin", rs.getString("customer_gstin"));
			map.put("customer_phone", rs.getString("customer_phone"));
			map.put("mp_name", rs.getString("mp_name"));
			map.put("plant_name", rs.getString("plant_name"));
			
		}
		return map;
	}
	
	
	@Override
	public List<Map<String,Object>> getPendingDC(int customer_id, int site_id, int plant_id) throws Exception {
		ps=con.prepareStatement(GET_PENDING_DC_FOR_INVOICE);
		ps.setInt(1, customer_id);
		ps.setInt(2, site_id);
		ps.setInt(3, plant_id);
		rs=ps.executeQuery();
		List<Map<String,Object>> itemList=new ArrayList<Map<String,Object>>();
		while(rs.next()) {
			HashMap<String, Object> map=new HashMap<String, Object>();
			map.put("invoice_date", rs.getString("inv_date"));
			map.put("invoice_id", rs.getInt("invoice_id"));
			map.put("customer_name", rs.getString("customer_name"));
			map.put("site_name", rs.getString("site_name"));
			map.put("site_address", rs.getString("site_address"));
			map.put("product_name", rs.getString("product_name"));
			map.put("invoice_time", rs.getString("invoice_time"));
			map.put("quantity", rs.getDouble("quantity"));
			map.put("rate", rs.getDouble("realRate"));
			map.put("gross_amount", rs.getDouble("gross_amount"));
			map.put("tax_amount", rs.getDouble("tax_amount"));
			map.put("net_amount", rs.getDouble("net_amount"));
			map.put("vehicle_no", rs.getString("vehicle_no"));
			map.put("driver_name", rs.getString("driver_name"));
			map.put("pump", rs.getString("pump"));
			map.put("plant_name", rs.getString("plant_name"));
			map.put("dc_id", rs.getString("id"));
			map.put("poi_id", rs.getString("poi_id"));
			map.put("rate_include_tax", rs.getString("rate_include_tax"));
			map.put("gst_category", rs.getString("gst_category"));
			map.put("gst_percent", rs.getDouble("gst_percent"));
			itemList.add(map);
		}
		return itemList;
	}
	
	
	

}
