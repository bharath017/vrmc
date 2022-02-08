package com.willka.soft.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.willka.soft.util.DBUtil;

public class SmsSenderDAOImpl implements SmsSenderDAO{

	private Connection con=null;
	private PreparedStatement ps=null;
	private ResultSet rs=null;
	
	private static final String GET_WITH_BILL_DETAILS="select sum(i.quantity) as tqty,p.product_name from"
			+ " invoice i LEFT JOIN(purchase_order_item poi,purchase_order po,product p,marketing_person m) ON"
			+ " i.poi_id=poi.poi_id and poi.product_id=p.product_id and poi.order_id=po.order_id"
			+ " and po.marketing_person_id=m.mp_id where i.invoice_date=CURDATE()-interval 1 day group by p.product_name "
			+ "";
	
	private static final String GET_WITHOUT_BILL_DETAILS="select sum(i.quantity) as tqty,p.product_name from"
			+ " test_invoice i LEFT JOIN(test_purchase_order_item poi,test_purchase_order po,product p,marketing_person m) ON"
			+ " i.poi_id=poi.poi_id and poi.product_id=p.product_id and poi.order_id=po.order_id"
			+ " and po.marketing_person_id=m.mp_id where i.invoice_date=CURDATE()-interval 1 day group by p.product_name "
			+ "";
	
	private static final String CHANGE_SMS_SETTING="update general_setting set sms=?,sms_time=?";
	
	private static final String INSERT_PHONE="insert into sms_phone(phone) values(?)";
	
	private static final String DELETE_PHONE="delete from sms_phone where id=?";
	
	
	
	
	public SmsSenderDAOImpl() {
		con=DBUtil.getConnection();
	}
	
	@Override
	public String getWithBillDetails() throws Exception {
		ps=con.prepareStatement(GET_WITH_BILL_DETAILS);
		System.out.println(ps.toString());
		rs=ps.executeQuery();
		StringBuffer buffer=new StringBuffer("");
		buffer.append("WithBill[");
		while(rs.next()) {
			buffer.append(rs.getString("tqty")+" - "+rs.getString("product_name")+", ");
		}
		buffer.append("]%0D");
		return buffer.toString();
	}

	@Override
	public String getWithoutBillDetails() throws Exception {
		ps=con.prepareStatement(GET_WITHOUT_BILL_DETAILS);
		rs=ps.executeQuery();
		StringBuffer buffer=new StringBuffer("");
		buffer.append("WithOut Bill[");
		while(rs.next()) {
			buffer.append(rs.getString("tqty")+","+rs.getString("product_name")+", ");
		}
		buffer.append("]%0D");
		return buffer.toString();
	}

	@Override
	public int changeSmsSetting(int sms, String sms_time) throws Exception {
		ps=con.prepareStatement(CHANGE_SMS_SETTING);
		ps.setInt(1, sms);
		ps.setString(2, sms_time);
		int count=ps.executeUpdate();
		return count;
	}

	@Override
	public int insertPhone(String phone) throws Exception {
		ps=con.prepareStatement(INSERT_PHONE);
		ps.setString(1,phone);
		int count=ps.executeUpdate();
		return count;
	}

	@Override
	public int deletePhone(int id) throws Exception {
		ps=con.prepareStatement(DELETE_PHONE);
		ps.setInt(1, id);
		int count=ps.executeUpdate();
		return count;
	}
	
	
	
}
