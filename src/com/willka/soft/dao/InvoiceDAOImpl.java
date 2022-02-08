package com.willka.soft.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Types;

import com.willka.soft.bean.ConsolidateInvoiceBean;
import com.willka.soft.bean.ConsolidateInvoiceItemBean;
import com.willka.soft.bean.InvoiceBean;
import com.willka.soft.bean.InvoiceModificationBean;
import com.willka.soft.util.DBUtil;

public class InvoiceDAOImpl implements InvoiceDAO {

	private Connection con=null;
	private PreparedStatement ps=null;
	private ResultSet rs=null;
	private CallableStatement cs=null;
	
	private static final String INSERT_INVOICE="call invoicesave(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
	
	private static final String INSERT_INVOICE_MODIFICATION="insert into invoice_modification(invoice_id,modification_type,comment,modification_user) values(?,?,?,?)";
	
	private static final String UPDATE_VEHICLE_PUMP="update invoice set vehicle_no=?,driver_name=?,pump=? where id=?";
	
	private static final String UPDATE_DATE_TIME="update invoice set invoice_date=?,invoice_time=? where id=?";
	
	private static final String UPDATE_FULL_INVOICE="update invoice set plant_id=?, customer_id=?, site_id=?, poi_id=?, invoice_date=?, invoice_time=?, quantity=?, rate=?, gross_amount=?, tax_amount=?, net_amount=?, vehicle_no=?, pump=?, driver_name=?, project_block=?,km_reading=?,tcs_amount=? where id=?";
	
	private static final String GENERATE_CONSOLIDATE_INVOICE="insert into consolidate_invoice(customer_id,pump_charge,"
			+ "advance_amount,plant_id,generate_date,cons_id,start_year,end_year,type) values(?,?,?,?,?,?,?,?,?)";
	
	private static final String ADD_CONSOLIDATE_INVOICE_ITEM="insert into consolidate_invoice_item(id,consolidate_invoice_id) values(?,?)";
	
	private static final String GET_MAX_CONSOLIDATE_INVOICE="select max(consolidate_invoice_id) from consolidate_invoice";
	
	private static final String GET_MAX_CONS_ID="select max(cons_id) from consolidate_invoice where start_year=? and end_year=?";
	
	private static final String CANCEL_CONSOLIDATE_INVOICE="delete from consolidate_invoice where consolidate_invoice_id=?";
	
	private static final String REFRESH_INVOICE="delete from batchingsheet where id=?";
	
	private static final String CANCEL_INVOICE="update invoice set invoice_status='cancelled' where id=?";
	
	private static final String CHANGE_DOCKET_NO="update invoice set docket_no=? where id=?";
	
	private static final String GET_INVOICE_NO="select max(invoice_id) as max_invoice from invoice where start_year=? and end_year=? and plant_id=?";
	
	private static final String DELETE_INVOICE="delete from invoice where id=?";
	
	private static final String GET_MAX_OF_ID="select max(id) from invoice";
	
	private static final String GET_ALL_NET_AMOUNT="select sum(net_amount) as net_amount from invoice where customer_id=? and start_year=? and end_year=?";
	
	
	
	public InvoiceDAOImpl() {
		con=DBUtil.getConnection();
	}
	@Override
	public int insertInvoice(InvoiceBean bean) throws Exception {
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
		cs.setDouble(16, bean.getKm_reading());
		cs.setString(17, bean.getProject_block());
		cs.setDouble(18, bean.getTcs_price());
		cs.execute();
		int invoice_id=cs.getInt(15);
		return invoice_id;
	}
	@Override
	public int insertInvoiceModification(InvoiceModificationBean bean) throws Exception {
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
	public int updateFullInvoice(InvoiceBean bean) throws Exception {
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
		ps.setDouble(16, bean.getKm_reading());
		ps.setDouble(17, bean.getTcs_price());
		ps.setInt(18, bean.getId());
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
	public int refreshInvoice(int id) throws Exception {
		ps=con.prepareStatement(REFRESH_INVOICE);
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
		//System.out.println(ps.toString());
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
		ps.setString(9, bean.getType());
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
	public double getTotalNetAmount(int customer_id, int start_year,int end_year) throws Exception {
		ps=con.prepareStatement(GET_ALL_NET_AMOUNT);
		ps.setInt(1, customer_id);
		ps.setInt(2, start_year);
		ps.setInt(3, end_year);
		rs=ps.executeQuery();
		if(rs.next()) {
			return rs.getDouble("net_amount");
		}else
			return 0;
	}

}
