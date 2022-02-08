package com.willka.soft.test.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.willka.soft.test.bean.SalesComissionBean;
import com.willka.soft.util.DBUtil;

public class SalesComissionDAOImpl implements SalesComissionDAO {

	private Connection con=null;
	private PreparedStatement ps=null;
	private ResultSet rs=null;
	
	//write all query here
	private static final String INSERT_PAYMENT="insert into test_sales_comission(customer_id,payment_amount,payment_mode,check_dd_no,check_dd_validity,payment_date,payment_time,paid_to,site_id) values(?,?,?,?,?,?,?,?,?)";
	
	private static final String UPDATE_PAYMENT="update test_sales_comission set customer_id=?,payment_amount=?,payment_mode=?,check_dd_no=?,check_dd_validity=?,payment_date=?,payment_time=?,paid_to=?,site_id=? where payment_id=?";
	
	private static final String GET_CREDIT_AMOUNT="select (select sum(net_amount) from test_invoice  where customer_id=? and invoice_status='active') as invoice_sum,(select sum(payment_amount) from test_customer_payment where customer_id=?) as payment_sum";
	
	private static final String GET_SINGLE_PAYMENT_DETAILS="select * from test_sales_comission where payment_id=?";
	
	private static final String INSERT_PAYMENT_MODIFICATION="insert into test_sales_comission_modification(payment_id,customer_id,payment_amount,modification_payment_amount,payment_mode,check_dd_no,check_dd_validity,payment_date,payment_time,modification_type,comment,modification_user) values(?,?,?,?,?,?,?,?,?,?,?,?)";
	
	private static final String DELETE_PAYMENT_DETAILS="delete from test_sales_comission where payment_id=?";
	
	
	
	public SalesComissionDAOImpl() {
		con=DBUtil.getConnection();
	}
	@Override
	public int insertPayment(SalesComissionBean bean) throws Exception {
		ps=con.prepareStatement(INSERT_PAYMENT);
		ps.setInt(1, bean.getCustomer_id());
		ps.setDouble(2, bean.getPayment_amount());
		ps.setString(3, bean.getPayment_category());
		ps.setString(4, bean.getCheck_dd_number());
		ps.setString(5, bean.getCheck_dd_validity());
		ps.setString(6, bean.getPayment_date());
		ps.setString(7, bean.getPayment_time());
		ps.setString(8, bean.getPaid_to());
		ps.setInt(9, bean.getSite_id());
		int count=ps.executeUpdate();
		return count;
	}

	@Override
	public int updatePayment(SalesComissionBean bean) throws Exception {
		ps=con.prepareStatement(UPDATE_PAYMENT);
		ps.setInt(1, bean.getCustomer_id());
		ps.setDouble(2, bean.getPayment_amount());
		ps.setString(3, bean.getPayment_category());
		ps.setString(4, bean.getCheck_dd_number());
		ps.setString(5, bean.getCheck_dd_validity());
		ps.setString(6, bean.getPayment_date());
		ps.setString(7, bean.getPayment_time());
		ps.setString(8, bean.getPaid_to());
		ps.setInt(9, bean.getSite_id());
		ps.setInt(10, bean.getPayment_id());
		int count=ps.executeUpdate();
		return count;
	}
	@Override
	public double getCreditAmmount(int customer_id) throws Exception {
		con=DBUtil.getConnection();
		ps=con.prepareStatement(GET_CREDIT_AMOUNT);
		ps.setInt(1, customer_id);
		ps.setInt(2, customer_id);
		rs=ps.executeQuery();
		
		double invoice_sum=0;
		double payment_sum=0;
		if(rs.next()) {
			invoice_sum=rs.getDouble(1);
			payment_sum=rs.getDouble(2);
		}
		return invoice_sum-payment_sum;
	}
	@Override
	public int insertModificationDetails(SalesComissionBean bean) throws Exception {
		ps=con.prepareStatement(INSERT_PAYMENT_MODIFICATION);
		ps.setInt(1, bean.getPayment_id());
		ps.setInt(2, bean.getCustomer_id());
		ps.setDouble(3, bean.getPayment_amount());
		ps.setDouble(4, bean.getModification_payment_amount());
		ps.setString(5,bean.getPayment_category());
		ps.setString(6, bean.getCheck_dd_number());
		ps.setString(7, bean.getCheck_dd_validity());
		ps.setString(8, bean.getPayment_date());
		ps.setString(9, bean.getPayment_time());
		ps.setString(10, bean.getModification_type());
		ps.setString(11, bean.getComment());
		ps.setString(12, bean.getModification_user());
		int count=ps.executeUpdate();
		return count;
	}
	@Override
	public SalesComissionBean getSinglePaymentDetails(int payment_id) throws Exception {
		ps=con.prepareStatement(GET_SINGLE_PAYMENT_DETAILS);
		ps.setInt(1, payment_id);
		rs=ps.executeQuery();
		if(rs.next()) {
			SalesComissionBean bean=new SalesComissionBean();
			bean.setPayment_id(rs.getInt("payment_id"));
			bean.setCustomer_id(rs.getInt("customer_id"));
			bean.setPayment_amount(rs.getDouble("payment_amount"));
			bean.setPayment_category(rs.getString("payment_mode"));
			bean.setPayment_date(rs.getString("payment_date"));
			bean.setPayment_time(rs.getString("payment_time"));
			bean.setCheck_dd_number(rs.getString("check_dd_no"));
			bean.setCheck_dd_validity(rs.getString("check_dd_validity"));
			return bean;
		}else {
			return null;
		}
	}
	@Override
	public int deletePaymentDetails(int payment_id) throws Exception {
		ps=con.prepareStatement(DELETE_PAYMENT_DETAILS);
		ps.setInt(1, payment_id);
		int count=ps.executeUpdate();
		return count;
	}
}
