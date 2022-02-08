package com.willka.soft.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.willka.soft.bean.TicketBean;
import com.willka.soft.util.DBUtil;


public class TicketDAOImpl implements TicketDAO{

	private Connection con=null;
	private PreparedStatement ps=null;
	private ResultSet rs=null;
	
	private static final String INSERT_TICKET="insert into ticket(ticket_id,plant_id,vehicle_no,product_id,empty_weight,loaded_weight,ticket_type,user_name) values(?,?,?,?,?,?,?,?)";
	
	private static final String UPDATE_TICKET="update ticket set ticket_id=?,plant_id=?,vehicle_no=?,product_id=?,empty_weight=?,loaded_weight=? where t_id=?";
	
	private static final String CANCEL_TICKET="update ticket set ticket_status='cancelled' where t_id=?";
	
	private static final String GET_MAX_TICKET_NO="select max(ticket_id) from ticket where plant_id=? and ticket_type=?";
	
	private static final String GET_TICKET_LIST="select t.ticket_id,t.t_id,t.vehicle_no,p.product_name,"+
			" t.user_name,t.empty_weight,t.loaded_weight,DATE_FORMAT(t.timestamp,'%d/%m/%Y %h:%m') as date"+
			" from ticket t,product p,plant pl"+
			" where t.product_id=p.product_id"+
			" and t.plant_id=pl.plant_id"+
			" and t.vehicle_no like ?"+
			" and t.plant_id like if(?=0,'%%',?)"+
			" and pl.business_id like if(?=0,'%%',?)"+
			" order by t.t_id desc"+
			" limit ?,?";
	
	private static final String COUNT_TICKET_LIST="select count(t.t_id)"+
			" from ticket t,plant pl"+
			" where t.plant_id=pl.plant_id"+
			" and t.vehicle_no like ?"+
			" and t.plant_id like if(?=0,'%%',?)"+
			" and pl.business_id like if(?=0,'%%',?)";
	
	public TicketDAOImpl() {
		con=DBUtil.getConnection();
	}
	
	@Override
	public int insertTicketDetails(TicketBean bean) throws Exception {
		ps=con.prepareStatement(INSERT_TICKET);
		ps.setInt(1, bean.getTicket_id());
		ps.setInt(2, bean.getPlant_id());
		ps.setString(3, bean.getVehicle_no());
		ps.setInt(4, bean.getProduct_id());
		ps.setDouble(5, bean.getEmpty_weight());
		ps.setDouble(6, bean.getLoaded_weight());
		ps.setString(7, bean.getTicket_type());
		ps.setString(8, bean.getUser_name());
		int count=ps.executeUpdate();
		return count;
	}

	@Override
	public int updateTicketDetails(TicketBean bean) throws Exception {
		ps=con.prepareStatement(UPDATE_TICKET);
		ps.setInt(1, bean.getTicket_id());
		ps.setInt(2, bean.getPlant_id());
		ps.setString(3, bean.getVehicle_no());
		ps.setInt(4, bean.getProduct_id());
		ps.setDouble(5, bean.getEmpty_weight());
		ps.setDouble(6, bean.getLoaded_weight());
		ps.setInt(7, bean.getT_id());
		int count=ps.executeUpdate();
		return count;
	}

	@Override
	public int getMaxTicketAccordingPlant(int plant_id,String ticket_type) throws Exception {
		ps=con.prepareStatement(GET_MAX_TICKET_NO);
		ps.setInt(1, plant_id);
		ps.setString(2, ticket_type);
		rs=ps.executeQuery();
		if(rs.next()) {
			return rs.getInt(1);
		}else {
			return 0;
		}
	}

	@Override
	public int cancelTicketDetails(int t_id) throws Exception {
		ps=con.prepareStatement(CANCEL_TICKET);
		ps.setInt(1, t_id);
		int count=ps.executeUpdate();
		return count;
	}

	@Override
	public List<Map<String,Object>> getTicketList(String search,int plant_id, int business_id, int start, int length) throws Exception {
		ps=con.prepareStatement(GET_TICKET_LIST);
		ps.setString(1, "%"+search+"%");
		ps.setInt(2, plant_id);
		ps.setInt(3, plant_id);
		ps.setInt(4, business_id);
		ps.setInt(5, business_id);
		ps.setInt(6, start);
		ps.setInt(7, length);
		rs=ps.executeQuery();
		List<Map<String,Object>> list=new ArrayList<Map<String,Object>>();
		while(rs.next()) {
			Map<String,Object> data=new HashMap<String, Object>();
			data.put("vehicle_no", rs.getString("vehicle_no"));
			data.put("ticket_id", rs.getInt("ticket_id"));
			data.put("product_name", rs.getString("product_name"));
			data.put("user_name", rs.getString("user_name"));
			data.put("empty_weight", rs.getDouble("empty_weight"));
			data.put("loaded_weight", rs.getDouble("loaded_weight"));
			data.put("date", rs.getString("date"));
			data.put("t_id", rs.getInt("t_id"));
			list.add(data);
		}
		return list;
	}
	

	@Override
	public int countTicketList(String search, int plant_id, int business_id) throws Exception {
		ps=con.prepareStatement(COUNT_TICKET_LIST);
		ps.setString(1, "%"+search+"%");
		ps.setInt(2, plant_id);
		ps.setInt(3, plant_id);
		ps.setInt(4, business_id);
		ps.setInt(5, business_id);
		rs=ps.executeQuery();
		if(rs.next()) {
			return rs.getInt(1);
		}else
			return 0;
	}
	

}
