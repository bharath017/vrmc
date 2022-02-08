package com.willka.soft.dao;

import java.net.URL;
import java.net.URLConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.willka.soft.bean.InvoiceBean;
import com.willka.soft.bean.InvoiceSMSBean;
import com.willka.soft.util.DBUtil;

public class SMSDAOImpl implements SMSDAO  {
	
	private Connection con=null;
	private PreparedStatement ps=null;
	private ResultSet rs=null;
	
	private static final String GET_SINGLE_INVOICE_DETAILS="select i.*,c.customer_name,s.site_address"
			+ ",c.customer_phone,p.product_name from invoice i,customer c,site_detail s,purchase_order_item poi,product p where i.customer_id=c.customer_id and i.site_id=s.site_id and i.poi_id=poi.poi_id and poi.product_id=p.product_id  and i.id=?";
	public SMSDAOImpl(){
		con=DBUtil.getConnection();
	}

	@Override
	public boolean sendSMSForEveryInvoice(InvoiceSMSBean bean) throws Exception {
		String message="Name : "+bean.getCustomer_name()+",%0DGrade : "+bean.getGrade()+",%0DQuantity : "+bean.getQuantity()+",%0DVehicle : "+bean.getVehicle_no()+",%0DDriver : "+bean.getDriver_name()+",%0DDate : "+bean.getDate()+",%0DSite : "+bean.getSite_address();
		String newmessage=message.replace(" ","%20");
		URL myURL = new URL("http://alerts.variforrm.in/api?method=sms.normal&api_key=d856d249220d507900e2624037115599&to="+bean.getCustomer_phone()+"&sender=WISOFT&message="+newmessage);
		System.out.println(myURL.toString());
		URLConnection myURLConnection = myURL.openConnection();
		System.out.println(myURLConnection.getContentLength());
		return true;
	}

	@Override
	public InvoiceSMSBean getSingleInvoiceDetails(int id) throws Exception {
		ps=con.prepareStatement(GET_SINGLE_INVOICE_DETAILS);
		ps.setInt(1, id);
		System.out.println(ps.toString());
		rs=ps.executeQuery();
		InvoiceSMSBean bean=new InvoiceSMSBean();
		if(rs.next()) {
			bean.setCustomer_name(rs.getString("customer_name"));
			bean.setCustomer_phone(rs.getString("customer_phone"));
			bean.setAmount(rs.getDouble("net_amount"));
			bean.setDate(rs.getString("invoice_date"));
			bean.setDriver_name(rs.getString("driver_name"));
			bean.setQuantity(rs.getDouble("quantity"));
			bean.setVehicle_no(rs.getString("vehicle_no"));
			bean.setGrade(rs.getString("product_name"));
			bean.setSite_address(rs.getString("site_address"));
		}
		return bean;
	}

}
