package com.willka.soft.test.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import com.willka.soft.test.bean.SchedulingBean;
import com.willka.soft.test.bean.SchedulingItemBean;
import com.willka.soft.util.DBUtil;

public class SchedulingDAOImpl implements SchedulingDAO {

	private Connection con=null;
	private PreparedStatement ps=null;
	private ResultSet rs=null;
	private PreparedStatement ps1=null;
	private ResultSet rs1=null;
	
	
	private static final String INSERT_SCHEDULING="insert into test_scheduling(customer_id,site_id,scheduling_date,start_time,end_time,pump1,pump2,plant_id,added_by) values(?,?,?,?,?,?,?,?,?)";
	
	private static final String UPDATE_SCHEDULING="update test_scheduling set customer_id=?,site_id=?,scheduling_date=?,start_time=?,end_time=?,pump1=?,pump2=?,plant_id=? where  scheduling_id=?";
	
	private static final String INSERT_SCHEDULING_ITEM="insert into test_scheduling_item(product_id,production_quantity,scheduling_id) values(?,?,?)";
	
	private static final String UPDATE_SCHEDULING_ITEM="INSERT INTO test_scheduling_item (product_id, production_quantity, scheduling_id) VALUES(?,?,?) ON DUPLICATE KEY UPDATE " + 
			"production_quantity=?";
	
	//new query goes here
	private static final String GET_GRADE_FOR_SCHEDULING="select t.product_id,t.product_name,(select sum(quantity) from test_invoice where poi_id=t.poi_id) as totalinvoice, "+
			" (select quantity from test_purchase_order_item where poi_id=t.poi_id) as totalquantity from (select distinct p.product_name,poi.product_id,max(poi.poi_id) as poi_id from test_purchase_order po,test_purchase_order_item poi,product p where po.order_id=poi.order_id and poi.product_id=p.product_id and po.site_id=? and po.plant_id in (0,?) group by p.product_name,poi.product_id) as t";
	
	private static final String CHECK_SCHEDULING_EXISTANCE="select scheduling_id from test_scheduling where site_id=? and plant_id in (0,?) and scheduling_date=?";
	
	private static final String GET_SCHEDULED_GRADE="select si.product_id,p.product_name,si.scheduling_item_id,"
			+ "si.production_quantity as quantity from"
			+ " test_scheduling_item si,product p,test_scheduling s where"
			+ " s.scheduling_id=si.scheduling_id and  si.product_id=p.product_id and s.scheduling_id=?";
	
	private static final String GET_MAX_SCHEDULING_ID="select max(scheduling_id) from test_scheduling";
	
	private static final String DELETE_SCHEDULING_ITEM_DETAILS="delete from test_scheduling_item where product_id=? and scheduling_id=?";
	
	private static final String GET_SCHEDULING_LIST="select s.scheduling_id,c.customer_name,st.site_name,DATE_FORMAT(scheduling_date,'%d/%m/%Y') as scheduling_date,"
			+ " s.start_time,s.end_time,s.pump1,s.pump2,(select plant_name from plant where plant_id=s.plant_id) as plant_name from test_scheduling s LEFT JOIN(test_customer c,test_site_detail st) "
			+ " ON  s.customer_id=c.customer_id "
			+ " and s.site_id=st.site_id "
			+ " where s.customer_id like if(0=?,'%%',?)"
			+ " and s.site_id like if(0=?,'%%',?)"
			+ " and s.scheduling_date like if(''=?,'%%',?)"
			+ " order by scheduling_id desc "
			+ " limit ?,?";
	
	
	private static final String COUNT_SCHEDULING_LIST="select count(scheduling_id) from test_scheduling "
			+ " where customer_id like if(0=?,'%%',?)"
			+ " and site_id like if(0=?,'%%',?)"
			+ " and scheduling_date like if(''=?,'%%',?)";
	
	private static final String GET_SCHEDULING_ITEM_LIST="select p.product_name,si.production_quantity"
			+ " from test_scheduling_item si,product p "
			+ " where si.product_id=p.product_id "
			+ " and si.scheduling_id=?";
	
	private static final String GET_SCHEDULED_INVOICE_DETAILS="select t.invoice_id,t.product_name,t.rate,t.quantity,t.net_amount from "+
					" (select i.invoice_id,p.product_name,i.site_id,i.invoice_date,poi.product_id,i.quantity,i.rate,i.net_amount"+
					" from test_invoice i,test_purchase_order_item poi,product p"+
					" where i.poi_id=poi.poi_id"+
					" and poi.product_id=p.product_id) as t,test_scheduling s,test_scheduling_item si"+
					" where s.scheduling_id=si.scheduling_id"+
					" and t.site_id=s.site_id"+
					" and t.invoice_date=s.scheduling_date"+
					" and t.product_id=si.product_id"+
					" and s.scheduling_id=?";
	
	private static final String DELETE_SCHEDULING_DETAILS="delete from test_scheduling where scheduling_id=?";
	
	private static final String GET_SCHEDULING_DASHBOARD="select (select sum(si.production_quantity) from test_scheduling s,test_scheduling_item si"+
			" where s.scheduling_id=si.scheduling_id and s.scheduling_date=curdate()) as todayschedule,"+
			" (select sum(si.production_quantity) from test_scheduling s,test_scheduling_item si "+
			" where s.scheduling_id=si.scheduling_id and s.scheduling_date=CURDATE()+interval 1 day) as tomorrowschedule,"+
			" (select sum(si.production_quantity) from test_scheduling s,test_scheduling_item si "+
			" where s.scheduling_id=si.scheduling_id and s.scheduling_date between  DATE_SUB( LAST_DAY( DATE_ADD(NOW(), INTERVAL 0 MONTH) ), INTERVAL DAY( LAST_DAY( DATE_ADD(NOW(), INTERVAL 0 MONTH) ) )-1 DAY )  and  LAST_DAY( DATE_ADD(NOW(), INTERVAL 0 MONTH) )) as thismonthschedule,"+
			" (select sum(quantity) from test_invoice where invoice_date between  DATE_SUB( LAST_DAY( DATE_ADD(NOW(), INTERVAL 0 MONTH) ), INTERVAL DAY( LAST_DAY( DATE_ADD(NOW(), INTERVAL 0 MONTH) ) )-1 DAY )  and  LAST_DAY( DATE_ADD(NOW(), INTERVAL 0 MONTH) )) as thismonthinvoice";

	private static final String GET_SCHEDULED_QUANTITY_OF_PERTICULAR_POI="select si.production_quantity"+ 
			" from test_scheduling s,test_scheduling_item si,test_purchase_order po,test_purchase_order_item poi"+
			" where poi.order_id=po.order_id"+
			" and s.scheduling_id=si.scheduling_id"+
			" and s.customer_id=po.customer_id"+
			" and s.site_id=po.site_id"+
			" and si.product_id=poi.product_id"+ 
			" and poi.poi_id=?"+
			" and s.scheduling_date=curdate()";
	
	
	
	
	
	
	
	
	public SchedulingDAOImpl() {
		con=DBUtil.getConnection();
	}
	
	@Override
	public int insertScheduling(SchedulingBean bean) throws Exception {
		ps=con.prepareStatement(INSERT_SCHEDULING);
		ps.setInt(1, bean.getCustomer_id());
		ps.setInt(2, bean.getSite_id());
		ps.setString(3, bean.getScheduling_date());
		ps.setString(4, bean.getStart_time());
		ps.setString(5, bean.getEnd_time());
		ps.setString(6, bean.getPump1());
		ps.setString(7, bean.getPump2());
		ps.setInt(8, bean.getPlant_id());
		ps.setInt(9, bean.getUser_id());
		int count=ps.executeUpdate();
		return count;
	}

	@Override
	public int updateScheduling(SchedulingBean bean) throws Exception {
		ps=con.prepareStatement(UPDATE_SCHEDULING);
		ps.setInt(1, bean.getCustomer_id());
		ps.setInt(2, bean.getSite_id());
		ps.setString(3, bean.getScheduling_date());
		ps.setString(4, bean.getStart_time());
		ps.setString(5, bean.getEnd_time());
		ps.setString(6, bean.getPump1());
		ps.setString(7, bean.getPump2());
		ps.setInt(8, bean.getPlant_id());
		ps.setInt(9, bean.getScheduling_id());
		int count=ps.executeUpdate();
		return count;
	}

	@Override
	public int insertSchedulingItem(SchedulingItemBean bean) throws Exception {
		ps=con.prepareStatement(INSERT_SCHEDULING_ITEM);
		ps.setInt(1, bean.getProduct_id());
		ps.setDouble(2, bean.getProduction_quantity());
		ps.setInt(3, bean.getScheduling_id());
		int count=ps.executeUpdate();
		return count;
	}

	@Override
	public int updateSchedulingItem(SchedulingItemBean bean) throws Exception {
		ps=con.prepareStatement(UPDATE_SCHEDULING_ITEM);
		ps.setInt(1, bean.getProduct_id());
		ps.setDouble(2, bean.getProduction_quantity());
		ps.setInt(3, bean.getScheduling_id());
		ps.setDouble(4, bean.getProduction_quantity());
		int count=ps.executeUpdate();
		return count;
	}


	@Override
	public ArrayList<HashMap<String, Object>> getGradeForSchedule(int site_id, int plant_id) throws Exception {
		ps=con.prepareStatement(GET_GRADE_FOR_SCHEDULING);
		ps.setInt(1, site_id);
		ps.setInt(2, plant_id);
		System.out.println(ps.toString());
		rs=ps.executeQuery();
		ArrayList<HashMap<String, Object>> list=new ArrayList<HashMap<String, Object>>();
		while(rs.next()) {
			HashMap<String, Object> map=new HashMap<String, Object>();
			map.put("product_id", rs.getInt("product_id"));
			map.put("product_name", rs.getString("product_name"));
			map.put("quantity", 0);
			map.put("totalinvoice", rs.getDouble("totalinvoice"));
			map.put("totalquantity", rs.getDouble("totalquantity"));
			list.add(map);
		}
		return list;
	}

	@Override
	public int checkIfSchedulingIsExist(int site_id, int plant_id, String scheduling_date) throws Exception {
		ps=con.prepareStatement(CHECK_SCHEDULING_EXISTANCE);
		ps.setInt(1, site_id);
		ps.setInt(2, plant_id);
		ps.setString(3, scheduling_date);
		rs=ps.executeQuery();
		if(rs.next())
			return rs.getInt(1);
		else
			return 0;
	}

	@Override
	public ArrayList<HashMap<String, Object>> getAllExistScheduleGrade(int scheduling_id) throws Exception {
		ps=con.prepareStatement(GET_SCHEDULED_GRADE);
		ps.setInt(1, scheduling_id);
		rs=ps.executeQuery();
		ArrayList<HashMap<String, Object>> list=new ArrayList<HashMap<String,Object>>();
		while(rs.next()) {
			HashMap<String, Object> map=new HashMap<String, Object>();
			map.put("product_id", rs.getInt("product_id"));
			map.put("quantity", rs.getDouble("quantity"));
			map.put("product_name", rs.getString("product_name"));
			list.add(map);
		}
		return list;
	}

	@Override
	public int getMaxOfSchedulingId() throws Exception {
		ps=con.prepareStatement(GET_MAX_SCHEDULING_ID);
		rs=ps.executeQuery();
		if(rs.next())
			return rs.getInt(1);
		else
			return 0;
	}

	@Override
	public int deleteSchedulingItemDetails(int product_id,
			int scheduling_id) throws Exception {
		ps=con.prepareStatement(DELETE_SCHEDULING_ITEM_DETAILS);
		ps.setInt(1, product_id);
		ps.setInt(2, scheduling_id);
		System.out.println(ps.toString());
		int count=ps.executeUpdate();
		return count;
	}
	
	

	@Override
	public ArrayList<HashMap<String, Object>> getAllSchedulingList(String scheduling_date, int customer_id, int site_id,
			int start, int length) throws Exception {
		ps=con.prepareStatement(GET_SCHEDULING_LIST);
		ps1=con.prepareStatement(GET_SCHEDULING_ITEM_LIST);
		ps.setInt(1, customer_id);
		ps.setInt(2, customer_id);
		ps.setInt(3, site_id);
		ps.setInt(4, site_id);
		ps.setString(5, scheduling_date);
		ps.setString(6, scheduling_date);
		ps.setInt(7, start);
		ps.setInt(8, length);
		rs=ps.executeQuery();
		ArrayList<HashMap<String, Object>> list=new ArrayList<HashMap<String,Object>>();
		while(rs.next()) {
			HashMap<String, Object> map=new HashMap<String, Object>();
			map.put("customer_name", rs.getString("customer_name"));
			map.put("site_name", rs.getString("site_name"));
			map.put("scheduling_id", rs.getInt("scheduling_id"));
			map.put("plant_name", (rs.getString("plant_name")==null || rs.getString("plant_name").trim().equals(""))?"ALL PLANT":rs.getString("plant_name"));
			map.put("start_time", rs.getString("start_time"));
			map.put("end_time", rs.getString("end_time"));
			map.put("pump1", rs.getString("pump1"));
			map.put("date", rs.getString("scheduling_date"));
			map.put("pump2", rs.getString("pump2"));
			//get item's here
			
			ps1.setInt(1, rs.getInt("scheduling_id"));
			rs1=ps1.executeQuery();
			ArrayList<HashMap<String, Object>> gradelist=new ArrayList<HashMap<String,Object>>();
			while(rs1.next()) {
				HashMap<String, Object> grade=new HashMap<String, Object>();
				grade.put("grade", rs1.getString("product_name"));
				grade.put("quantity", rs1.getDouble("production_quantity"));
				gradelist.add(grade);
			}
			map.put("grades", gradelist);
			list.add(map);
		}
		return list;
	}

	@Override
	public int countAllSchedulingList(String scheduling_date, int customer_id, int site_id) throws Exception {
		ps=con.prepareStatement(COUNT_SCHEDULING_LIST);
		ps.setInt(1, customer_id);
		ps.setInt(2, customer_id);
		ps.setInt(3, site_id);
		ps.setInt(4, site_id);
		ps.setString(5, scheduling_date);
		ps.setString(6, scheduling_date);
		rs=ps.executeQuery();
		if(rs.next())
			return rs.getInt(1);
		else
			return 0;
	}

	@Override
	public ArrayList<HashMap<String, Object>> getScheduledInvoiceDetails(int scheduling_id) throws Exception {
		ps=con.prepareStatement(GET_SCHEDULED_INVOICE_DETAILS);
		ps.setInt(1, scheduling_id);
		rs=ps.executeQuery();
		ArrayList<HashMap<String, Object>> list=new ArrayList<HashMap<String,Object>>();
		while(rs.next()) {
			HashMap<String, Object> map=new HashMap<String, Object>();
			map.put("invoice_id", rs.getInt("invoice_id"));
			map.put("product_name", rs.getString("product_name"));
			map.put("rate", rs.getDouble("rate"));
			map.put("quantity", rs.getDouble("quantity"));
			map.put("net_amount", rs.getDouble("net_amount"));
			list.add(map);
		}
		return list;
	}

	@Override
	public int deleteSchedulingDetails(int scheduling_id) throws Exception {
		ps=con.prepareStatement(DELETE_SCHEDULING_DETAILS);
		ps.setInt(1, scheduling_id);
		int count=ps.executeUpdate();
		return count;
	}

	@Override
	public HashMap<String, Object> getScheduleDashBoard() throws Exception {
		ps=con.prepareStatement(GET_SCHEDULING_DASHBOARD);
		System.out.println(ps.toString());
		rs=ps.executeQuery();
		HashMap<String, Object> map=new HashMap<String, Object>();
		if(rs.next()) {
			map.put("todayschedule", rs.getDouble("todayschedule"));
			map.put("tomorrowschedule", rs.getDouble("tomorrowschedule"));
			map.put("thismonthschedule", rs.getDouble("thismonthschedule"));
			map.put("thismonthinvoice", rs.getDouble("thismonthinvoice"));
		}
		return map;
	}

	@Override
	public double getScheduledQuantityOfPerticularProductId(int poi_id) throws Exception {
		ps=con.prepareStatement(GET_SCHEDULED_QUANTITY_OF_PERTICULAR_POI);
		ps.setInt(1, poi_id);
		System.out.println(ps.toString());
		rs=ps.executeQuery();
		if(rs.next())
			return rs.getDouble(1);
		else
			return 0;
	}
	
	
	

}
