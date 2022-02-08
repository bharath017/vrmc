package com.willka.soft.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.willka.soft.bean.TransportChargeBean;
import com.willka.soft.util.DBUtil;

public class TransportChargeDAOImpl implements TransportChargeDAO{

	private Connection con=null;
	private PreparedStatement ps=null;
	private ResultSet rs=null;
	
	private static final String INSERT_TRANSPORT_CHARGE="insert into transport_charge(invoice_id,vehicle_no,opening_km,closing_km,price,invoice_date, "
			+ "invoice_time,start_year,end_year,plant_id,tax_type,tax_percent,gross_amount,tax_amount,net_amount) "
			+ "values(?,?,?,?,?,?,?,?,?,?,?,?,?)";
	
	private static final String UPDATE_TRANPORT_CHARGE="update tranport_charge set invoice_id=?,vehicle_no=?,opening_km=?,closing_km=?,price=?, "
			+ " invoice_date=?,invoice_time=?,plant_id=?,tax_type=?,tax_percent=? where id=?";
	
	private static final String CANCEL_TRANSPORT_CHARGE="update transport_charge set invoice_status=? where id=?";
	
	private static final String GET_INVOICE_NO="select invoice_id from transport_charge where start_year=?,end_year=?,plant_id=?";
	
	
	public TransportChargeDAOImpl() {
		con=DBUtil.getConnection();
	}
	
	@Override
	public int insertTranportCharge(TransportChargeBean bean) throws Exception {
		ps=con.prepareStatement(INSERT_TRANSPORT_CHARGE);
		ps.setInt(1, bean.getInvoice_id());
		ps.setString(2, bean.getVehicle_no());
		ps.setDouble(3,bean.getOpening_km());
		ps.setDouble(4, bean.getClosing_km());
		ps.setDouble(5, bean.getPrice());
		ps.setString(6, bean.getInvoice_date());
		ps.setString(7,bean.getInvoice_time());
		ps.setInt(8, bean.getStart_year());
		ps.setInt(9, bean.getEnd_year());
		ps.setInt(10, bean.getPlant_id());
		ps.setString(11, bean.getTax_type());
		ps.setDouble(12, bean.getTax_percent());
		ps.setDouble(13, bean.getGross_amount());
		ps.setDouble(14, bean.getTax_amount());
		ps.setDouble(15, bean.getNet_amount());
		int count=ps.executeUpdate();
		return count;
	}

	@Override
	public int updateTranportCharge(TransportChargeBean bean) throws Exception {
		ps=con.prepareStatement(UPDATE_TRANPORT_CHARGE);
		ps.setInt(1, bean.getInvoice_id());
		ps.setString(2, bean.getVehicle_no());
		ps.setDouble(3,bean.getOpening_km());
		ps.setDouble(4, bean.getClosing_km());
		ps.setDouble(5, bean.getPrice());
		ps.setString(6, bean.getInvoice_date());
		ps.setString(7,bean.getInvoice_time());
		ps.setInt(8, bean.getStart_year());
		ps.setInt(9, bean.getEnd_year());
		ps.setInt(10, bean.getPlant_id());
		ps.setString(11, bean.getTax_type());
		ps.setDouble(12, bean.getTax_percent());
		ps.setInt(13, bean.getId());
		int count=ps.executeUpdate();
		return count;
	}

	@Override
	public int cancelTransportCharge(int id, int invoice_id) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int getInvoiceId(int plant_id, int start_year, int end_year) throws Exception {
		ps=con.prepareStatement(GET_INVOICE_NO);
		ps.setInt(1, plant_id);
		ps.setInt(2, start_year);
		ps.setInt(3, end_year);
		rs=ps.executeQuery();
		if(rs.next()) {
			return rs.getInt(1);
		}else {
			return 1;
		}
	}

}
