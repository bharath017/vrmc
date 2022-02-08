package com.willka.soft.test.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import com.willka.soft.test.bean.CustomerPaymentBean;
import com.willka.soft.util.DBUtil;

public class PaymentDAOImpl implements PaymentDAO{

	private Connection con=null;
	private PreparedStatement ps=null;
	private ResultSet rs=null;
	
	//write all query here
	private static final String INSERT_PAYMENT="insert into test_customer_payment(customer_id,payment_amount,payment_mode,check_dd_no, "
			+ "check_dd_validity,payment_date,payment_time,site_id,user_name,neft_no,bank_detail_id,category_id) values(?,?,?,?,?,?,?,?,?,?,?,?)";
	
	private static final String UPDATE_PAYMENT="update test_customer_payment set customer_id=?,payment_amount=?,payment_mode=?,"
			+ "check_dd_no=?,check_dd_validity=?,payment_date=?,site_id=?,neft_no=?,bank_detail_id=?,category_id=? where payment_id=?";
	
	private static final String GET_CREDIT_AMOUNT="select (select sum(net_amount) from test_invoice  "
			+ " where customer_id=? and invoice_status='active') as invoice_sum,(select sum(payment_amount)"
			+ " from test_customer_payment where customer_id=?) as payment_sum";
	
	private static final String GET_SINGLE_PAYMENT_DETAILS="select * from test_customer_payment where payment_id=?";
	
	private static final String INSERT_PAYMENT_MODIFICATION="insert into test_customer_payment_modification(payment_id,customer_id,payment_amount,modification_payment_amount,payment_mode,check_dd_no,check_dd_validity,payment_date,payment_time,modification_type,comment,modification_user) values(?,?,?,?,?,?,?,?,?,?,?,?)";
	
	private static final String DELETE_PAYMENT_DETAILS="delete from test_customer_payment where payment_id=?";
	
	private static final String GET_PAYMENT_LIST="select p.*,c.customer_name,"
			+ " DATE_FORMAT(p.payment_date,'%d/%m/%Y') as realdate, b.bank_name"
			+ " from test_customer_payment p,test_customer c,bank_detail b"
			+ " where p.customer_id=c.customer_id "
			+ " and p.bank_detail_id=b.bank_detail_id"
			+ " and p.payment_date between if(''=?,'2014-01-01',?) and if(''=?,'2088-01-01',?) "
			+ " and p.payment_id like if(''=?,'%%',?) "
			+ " and p.customer_id like if(?=0,'%%',?) "
			+"  and c.business_id like if(?=0,'%%',?)"
			+ " order by payment_id desc "
			+ " limit ?,?";
	
	private static final String COUNT_PAYMENT_LIST="select count(payment_id)"
			+ " from test_customer_payment p,test_customer c "
			+ " where p.customer_id=c.customer_id "
			+ " and p.payment_date between if(''=?,'2014-01-01',?) and if(''=?,'2088-01-01',?) "
			+ " and p.payment_id like if(''=?,'%%',?) "
			+ " and p.customer_id like if(?=0,'%%',?) "
			+"  and c.business_id like if(?=0,'%%',?)"
			+ " order by payment_id desc";
	
	private static final String GET_SALES_DOCUMENT_BALANCE_PAYMENT="select (select sum(sd.net_price) from test_sales_document s left join test_sales_document_item sd on sd.id=s.id where s.customer_id=? and s.invoice_status='active') as invoice_sum,"
			+ " (select sum(payment_amount) from test_customer_payment where customer_id=?) as payment_sum,"
			+ " (select sum(net_amount) from test_invoice where customer_id=?)";
	
	
	
	public PaymentDAOImpl() {
		con=DBUtil.getConnection();
	}
	@Override
	public int insertPayment(CustomerPaymentBean bean) throws Exception {
		ps=con.prepareStatement(INSERT_PAYMENT);
		ps.setInt(1, bean.getCustomer_id());
		ps.setDouble(2, bean.getPayment_amount());
		ps.setString(3, bean.getPayment_category());
		ps.setString(4, bean.getCheck_dd_number());
		ps.setString(5, bean.getCheck_dd_validity());
		ps.setString(6, bean.getPayment_date());
		ps.setString(7, bean.getPayment_time());
		ps.setInt(8, bean.getSite_id());
		ps.setString(9, bean.getUser_name());
		ps.setString(10, bean.getNeft_no());
		ps.setInt(11, bean.getBank_detail_id());
		ps.setInt(12, bean.getCategory_id());
		int count=ps.executeUpdate();
		return count;
	}

	@Override
	public int updatePayment(CustomerPaymentBean bean) throws Exception {
		ps=con.prepareStatement(UPDATE_PAYMENT);
		ps.setInt(1, bean.getCustomer_id());
		ps.setDouble(2, bean.getPayment_amount());
		ps.setString(3, bean.getPayment_category());
		ps.setString(4, bean.getCheck_dd_number());
		ps.setString(5, bean.getCheck_dd_validity());
		ps.setString(6, bean.getPayment_date());
		ps.setInt(7, bean.getSite_id());
		ps.setString(8, bean.getNeft_no());
		ps.setInt(9, bean.getBank_detail_id());
		ps.setInt(10, bean.getCategory_id());
		ps.setInt(11, bean.getPayment_id());
		int count=ps.executeUpdate();
		return count;
	}
	@Override
	public double getCreditAmmount(int customer_id) throws Exception {
		con=DBUtil.getConnection();
		ps=con.prepareStatement(GET_SALES_DOCUMENT_BALANCE_PAYMENT);
		ps.setInt(1, customer_id);
		ps.setInt(2, customer_id);
		ps.setInt(3, customer_id);
		rs=ps.executeQuery();
		
		double invoice_sum=0;
		double payment_sum=0;
		double net_sum=0;
		if(rs.next()) {
			invoice_sum=rs.getDouble(1);
			payment_sum=rs.getDouble(2);
			net_sum=rs.getDouble(3);
		}
		return (invoice_sum+net_sum)-payment_sum;
	}
	@Override
	public int insertModificationDetails(CustomerPaymentBean bean) throws Exception {
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
	public CustomerPaymentBean getSinglePaymentDetails(int payment_id) throws Exception {
		ps=con.prepareStatement(GET_SINGLE_PAYMENT_DETAILS);
		ps.setInt(1, payment_id);
		rs=ps.executeQuery();
		if(rs.next()) {
			CustomerPaymentBean bean=new CustomerPaymentBean();
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
		System.out.println(ps.toString());
		int count=ps.executeUpdate();
		return count;
	}
	@Override
	public ArrayList<HashMap<String, Object>> getPaymentList(String from_date, String to_date, String payment_id,
			int customer_id, int business_id, int start, int length) throws Exception {
		ps=con.prepareStatement(GET_PAYMENT_LIST);
		ps.setString(1, from_date);
		ps.setString(2, from_date);
		ps.setString(3, to_date);
		ps.setString(4, to_date);
		ps.setString(5, payment_id);
		ps.setString(6, payment_id);
		ps.setInt(7, customer_id);
		ps.setInt(8, customer_id);
		ps.setInt(9, business_id);
		ps.setInt(10, business_id);
		ps.setInt(11, start);
		ps.setInt(12, length);
		rs=ps.executeQuery();
		ArrayList<HashMap<String, Object>> list=new ArrayList<HashMap<String,Object>>();
		while(rs.next()) {
			HashMap<String, Object> map=new HashMap<String, Object>();
			map.put("payment_id", rs.getInt("payment_id"));
			map.put("customer_name", rs.getString("customer_name"));
			map.put("payment_amount", rs.getString("payment_amount"));
			map.put("payment_mode", rs.getString("payment_mode"));
			map.put("payment_date", rs.getString("realdate"));
			map.put("bank_name", rs.getString("bank_name"));
			String mode_no=(rs.getString("payment_mode").equals("CHECK/DD"))?rs.getString("check_dd_no"):rs.getString("neft_no");
			map.put("mode_no", (mode_no==null)?"":mode_no);
			map.put("payment_time", rs.getString("payment_time"));
			list.add(map);
		}
		return list;
	}
	@Override
	public int countPaymentList(String from_date, String to_date,
			String payment_id, int customer_id, int business_id) throws Exception {
		ps=con.prepareStatement(COUNT_PAYMENT_LIST);
		ps.setString(1, from_date);
		ps.setString(2, from_date);
		ps.setString(3, to_date);
		ps.setString(4, to_date);
		ps.setString(5, payment_id);
		ps.setString(6, payment_id);
		ps.setInt(7, customer_id);
		ps.setInt(8, customer_id);
		ps.setInt(9, business_id);
		ps.setInt(10, business_id);
		rs=ps.executeQuery();
		if(rs.next())
			return rs.getInt(1);
		else
			return 0;
	}

}
