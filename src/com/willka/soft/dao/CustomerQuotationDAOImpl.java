package com.willka.soft.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.willka.soft.bean.CustomerQuotationBean;
import com.willka.soft.bean.CustomerQuotationItemBean;
import com.willka.soft.util.DBUtil;

public class CustomerQuotationDAOImpl implements CustomerQuotationDAO {
	
	// Declare Database Variable
	private Connection con=null;
	private PreparedStatement ps=null;
	private ResultSet rs=null;

	// Declare Query Here
	private static final String INSERT_QUERY="insert into customer_quotation(customer_name,quotation_date,pump_charge,"
			+ " pump_quantity,site_address,customer_phone,mp_id,comment,customer_email,customer_gstin) values(?,?,?,?,?,?,?,?,?,?)";
	
	private static final String UPDATE_QUERY="update customer_quotation set customer_name=?,quotation_date=?,"
			+ " pump_charge=?,pump_quantity=?,site_address=?,customer_phone=?,comment=?,customer_gstin=?,mp_id=? where quotation_id=?";
	
	private static final String INSERT_QUOTATION_ITEM="insert into customer_quotation_item(grade_name,grade_price,quotation_id,ggbs_price,quantity)values(?,?,?,?,?)";
	
	private static final String UPDATE_QUOTATION_ITEM="update customer_quotation_item set grade_name=?,grade_price=?,quotation_id=?,ggbs_price=?,quantity=? where grade_id=? ";
	
	private static final String DELETE_QUOTATION="delete from customer_quotation where quotation_id=?";
	
	private static final String GET_MAX_QUOTATION_ID="select max(quotation_id) from customer_quotation";
	
	private static final String GET_SINGLE_CUSTOMER_QUOTATION="select * from customer_quotation where quotation_id=?";
	
	private static final String STATUS_QUOTATION="update customer_quotation set status=? where quotation_id=?";
	
	public CustomerQuotationDAOImpl() {
		con=DBUtil.getConnection();
	}
	
	@Override
	public int insertCustomerQuotation(CustomerQuotationBean bean) throws Exception {
		ps=con.prepareStatement(INSERT_QUERY);
		ps.setString(1, bean.getCustomer_name());
		ps.setString(2, bean.getQuotation_date());
		ps.setDouble(3, bean.getPump_charge());
		ps.setDouble(4, bean.getPump_quantity());
		ps.setString(5, bean.getSite_address());
		ps.setString(6, bean.getCustomer_phone());
		ps.setInt(7, bean.getMp_id());
		ps.setString(8, bean.getComment());
		ps.setString(9, bean.getCustomer_email());
		ps.setString(10, bean.getCustomer_gstin());
		int count=ps.executeUpdate();
		return count;
	}

	@Override
	public int updateCustomerQuotation(CustomerQuotationBean bean) throws Exception {
		ps=con.prepareStatement(UPDATE_QUERY);
		ps.setString(1, bean.getCustomer_name());
		ps.setString(2, bean.getQuotation_date());
		ps.setDouble(3, bean.getPump_charge());
		ps.setDouble(4, bean.getPump_quantity());
		ps.setString(5, bean.getSite_address());
		ps.setString(6, bean.getCustomer_phone());
		ps.setString(7, bean.getComment());
		ps.setString(8, bean.getCustomer_gstin());
		ps.setInt(9, bean.getMp_id());
		ps.setInt(10, bean.getQuotation_id());
		int count=ps.executeUpdate();
		return count;
	}

	@Override
	public int insertCustomerQuotationItem(CustomerQuotationItemBean bean) throws Exception {
		ps=con.prepareStatement(INSERT_QUOTATION_ITEM);
		ps.setString(1, bean.getGrade_name());
		ps.setDouble(2, bean.getGrade_price());
		ps.setInt(3, bean.getQuotation_id());
		ps.setDouble(4, bean.getGgbs_price());
		ps.setDouble(5, bean.getQuantity());
		int count=ps.executeUpdate();
		return count;
	}

	@Override
	public int updateCustomerQuotationItem(CustomerQuotationItemBean bean) throws Exception {
		ps=con.prepareStatement(UPDATE_QUOTATION_ITEM);
		ps.setString(1, bean.getGrade_name());
		ps.setDouble(2, bean.getGrade_price());
		ps.setInt(3, bean.getQuotation_id());
		ps.setDouble(4, bean.getGgbs_price());
		ps.setDouble(5, bean.getQuantity());
		ps.setInt(6, bean.getGrade_id());
		int count=ps.executeUpdate();
		return count;
	}

	@Override
	public int deleteCustomerQuotation(int quotation_id) throws Exception {
		ps=con.prepareStatement(DELETE_QUOTATION);
		ps.setInt(1, quotation_id);
		int count=ps.executeUpdate();
		return count;
	}

	@Override
	public CustomerQuotationBean getSingleCustomerQuotaionDetails(int quotation_id) throws Exception {
		ps=con.prepareStatement(GET_SINGLE_CUSTOMER_QUOTATION);
		ps.setInt(1, quotation_id);
		rs=ps.executeQuery();
		if(rs.next())
		{
			CustomerQuotationBean bean= new CustomerQuotationBean();
			bean.setQuotation_id(rs.getInt("quotation_id"));
			bean.setCustomer_name(rs.getString("customer_name"));
			bean.setCustomer_phone(rs.getString("customer_phone"));
			bean.setPump_charge(rs.getDouble("pump_charge"));
			bean.setPump_quantity(rs.getDouble("pump_quantity"));
			bean.setQuotation_date(rs.getString("quotation_date"));
			bean.setSite_address(rs.getString("site_address"));
			bean.setCustomer_email(rs.getString("customer_email"));
			return bean;
		}
		else {
		return null;
		}
	}

	@Override
	public int getHighestQuotationId() throws Exception {
		ps=con.prepareStatement(GET_MAX_QUOTATION_ID);
		rs=ps.executeQuery();
		if(rs.next())
		{
			return rs.getInt(1);
		}
		else
		{
			return 0;
		}
		
	}
	
	@Override
	public int statusCustomerQuotation(int quotation_id,String status) throws Exception {
		ps=con.prepareStatement(STATUS_QUOTATION);
		ps.setInt(2, quotation_id);
		ps.setString(1, status);
		int count=ps.executeUpdate();
		return count;
	}

}
