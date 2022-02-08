package com.willka.soft.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.willka.soft.bean.SchedulingBean;
import com.willka.soft.bean.SchedulingItemBean;
import com.willka.soft.util.DBUtil;

public class SchedulingDAOImpl implements SchedulingDAO {

	private Connection con=null;
	private PreparedStatement ps=null;
	private ResultSet rs=null;
	private PreparedStatement ps1=null;
	private ResultSet rs1=null;
	
	private static final String INSERT_SCHEDULING="insert into scheduling(customer_id,site_id,scheduling_date,"
			+ "start_time,end_time,pump1,pump2,plant_id,added_by) values(?,?,?,?,?,?,?,?,?)";
	
	private static final String UPDATE_SCHEDULING="update scheduling set customer_id=?,site_id=?,scheduling_date=?,start_time=?,end_time=?,pump1=?,pump2=?,plant_id=? where  scheduling_id=?";
	
	private static final String INSERT_SCHEDULING_ITEM="insert into scheduling_item(product_id,production_quantity,scheduling_id) values(?,?,?)";
	
	private static final String UPDATE_SCHEDULING_ITEM="update scheduling_item set production_quantity=? where scheduling_item_id=?";
	
	private static final String GET_MAX_ID="select max(scheduling_id) from scheduling";
	
	private static final String GET_SCHEDULING_ITEMS="select si.*,p.product_name from scheduling_item si,schduling s,product p where si.scheduling_id=s.scheduling_id and si.product_id=p.product_id and s.site_id=? and s.date=? and s.plant_id=?";
	
	private static final String GET_SCHEDULING_DETAILS="select * from scheduling where site_id=? and scheduling_date=? and plant_id=?";
	
	private static final String GET_SCHEDULING_ITEMS_USING_SHCEULING_ID="select s.*,p.product_name from scheduling_item s,product p where s.product_id=p.product_id and scheduling_id=?";
	
	private static final String DELETE_SCHEDULING="delete from scheduling where scheduling_id=?";
	
	private static final String GET_SCHEDULING_LIST="select s.scheduling_id,c.customer_name,st.site_name,"+
			" DATE_FORMAT(s.scheduling_date,'%d/%m/%Y') as scheduling_date,"+
			" s.start_time,s.end_time,s.pump1,s.pump2,s.schStatus,s.prodTime,u.user_name,s.added_by"+
			" from (scheduling s,customer c,site_detail st) left join (user u)"+
			" on s.added_by=u.user_id"+
			" where s.customer_id=c.customer_id"+
			" and s.site_id=st.site_id"+
			" and s.scheduling_date between if(''=?,'2000-01-01',?) and if(''=?,'2050-01-01',?)"+
			" and s.customer_id like if(?=0,'%%',?)"+
			" and s.site_id like if(?=0,'%%',?)"+
			" order by scheduling_id desc "+
			" limit ?,?";
	
	private static final String GET_SCHEULING_ITEM_LIST="select si.scheduling_item_id,p.product_name,si.production_quantity"+
			" from scheduling_item si,product p "+
			" where si.product_id=p.product_id"+
			" and si.scheduling_id=?"+
			" and si.production_quantity > 0";
	
	private static final String COUNT_SCHEDULING_LIST="select count(s.scheduling_id)"+
			" from scheduling s"+
			" where s.scheduling_date between if(''=?,'2000-01-01',?) and if(''=?,'2050-01-01',?)"+
			" and s.customer_id like if(?=0,'%%',?)"+
			" and s.site_id like if(?=0,'%%',?)";
	
	private static final String CHANGE_SCHEDULING_STATUS="update scheduling set schStatus=? where scheduling_id=?";
	

	
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
		ps.setDouble(1, bean.getProduction_quantity());
		ps.setInt(2, bean.getScheduling_item_id());
		int count=ps.executeUpdate();
		return count;
	}

	@Override
	public int getMaxSchedulingId() throws Exception {
		ps=con.prepareStatement(GET_MAX_ID);
		rs=ps.executeQuery();
		if(rs.next()) {
			return rs.getInt(1);
		}else {
			return 0;
		}
	}

	@Override
	public ArrayList<SchedulingItemBean> getProductDetailsUsingSiteDate(int site_id, String date,int plant_id) throws Exception {
		ps=con.prepareStatement(GET_SCHEDULING_ITEMS);
		ps.setInt(1, site_id);
		ps.setString(2, date);
		ps.setInt(3, plant_id);
		rs=ps.executeQuery();
		ArrayList<SchedulingItemBean> item_list=new ArrayList<>();
		while(rs.next()) {
			SchedulingItemBean bean=new SchedulingItemBean();
			bean.setProduct_id(rs.getInt("product_id"));
			bean.setProduction_quantity(rs.getDouble("production_quantity"));
			bean.setScheduling_item_id(rs.getInt("scheduling_item_id"));
			bean.setScheduling_id(rs.getInt("scheduling_id"));
			bean.setProduct_name(rs.getString("product_name"));
			item_list.add(bean);
		}
		return item_list;
	}

	@Override
	public SchedulingBean getSchedulingDetails(int site_id, String date,int plant_id) throws Exception {
		ps=con.prepareStatement(GET_SCHEDULING_DETAILS);
		ps.setInt(1, site_id);
		ps.setString(2, date);
		ps.setInt(3, plant_id);
		rs=ps.executeQuery();
		if(rs.next()) {
			SchedulingBean bean=new SchedulingBean();
			bean.setCustomer_id(rs.getInt("customer_id"));
			bean.setScheduling_id(rs.getInt("scheduling_id"));
			bean.setSite_id(rs.getInt("site_id"));
			bean.setScheduling_date(rs.getString("scheduling_date"));
			bean.setStart_time(rs.getString("start_time"));
			bean.setEnd_time(rs.getString("end_time"));
			bean.setPump1(rs.getString("pump1"));
			bean.setPump2(rs.getString("pump2"));
			return  bean;
		}else {
			return null;
		}
	}

	@Override
	public ArrayList<SchedulingItemBean> getSchedulingItems(int scheduling_id) throws Exception {
		ps=con.prepareStatement(GET_SCHEDULING_ITEMS_USING_SHCEULING_ID);
		ps.setInt(1, scheduling_id);
		rs=ps.executeQuery();
		ArrayList<SchedulingItemBean> item_list=new ArrayList<>();
		while(rs.next()) {
			SchedulingItemBean bean=new SchedulingItemBean();
			bean.setProduct_id(rs.getInt("product_id"));
			bean.setProduction_quantity(rs.getDouble("production_quantity"));
			bean.setScheduling_item_id(rs.getInt("scheduling_item_id"));
			bean.setScheduling_id(rs.getInt("scheduling_id"));
			bean.setProduct_name(rs.getString("product_name"));
			item_list.add(bean);
		}
		return item_list;
	}

	@Override
	public int deleteScheduling(int scheduling_id) throws Exception {
		ps=con.prepareStatement(DELETE_SCHEDULING);
		ps.setInt(1, scheduling_id);
		int count=ps.executeUpdate();
		return count;
	}

	@Override
	public List<Map<String, Object>> getSchedulingList(String from_date, String to_date, int customer_id, int site_id,
			int start, int length) throws Exception {
		ps=con.prepareStatement(GET_SCHEDULING_LIST);
		ps1=con.prepareStatement(GET_SCHEULING_ITEM_LIST);
		ps.setString(1, from_date);
		ps.setString(2, from_date);
		ps.setString(3, to_date);
		ps.setString(4, to_date);
		ps.setInt(5, customer_id);
		ps.setInt(6, customer_id);
		ps.setInt(7, site_id);
		ps.setInt(8, site_id);
		ps.setInt(9, start);
		ps.setInt(10, length);
		rs=ps.executeQuery();
		List<Map<String,Object>> data=new ArrayList<>();
		while(rs.next()) {
			Map<String,Object> singleData=new HashMap<String, Object>();
			singleData.put("scheduling_id", rs.getInt("scheduling_id"));
			singleData.put("customer_name", rs.getString("customer_name"));
			singleData.put("site_name", rs.getString("site_name"));
			singleData.put("scheduling_date", rs.getString("scheduling_date"));
			singleData.put("start_time", rs.getString("start_time"));
			singleData.put("end_time", rs.getString("end_time"));
			singleData.put("pump1", rs.getString("pump1"));
			singleData.put("pump2", rs.getString("pump2"));
			singleData.put("schStatus", rs.getString("schStatus"));
			singleData.put("added_by", rs.getInt("added_by"));
			
			//get scheduling item list
			ps1.setInt(1, rs.getInt("scheduling_id"));
			rs1=ps1.executeQuery();
			List<Map<String,Object>> itemList=new ArrayList<>();
			while(rs1.next()) {
				Map<String,Object> item=new HashMap<>();
				item.put("scheduling_item_id", rs1.getInt("scheduling_item_id"));
				item.put("product_name", rs1.getString("product_name"));
				item.put("production_quantity", rs1.getDouble("production_quantity"));
				itemList.add(item);
			}
			
			singleData.put("itemList", itemList);
			data.add(singleData);
		}
		return data;
	}

	@Override
	public int countSchedulingList(String from_date, String to_date, int customer_id, int site_id) throws Exception {
		ps=con.prepareStatement(COUNT_SCHEDULING_LIST);
		ps.setString(1, from_date);
		ps.setString(2, from_date);
		ps.setString(3, to_date);
		ps.setString(4, to_date);
		ps.setInt(5, customer_id);
		ps.setInt(6, customer_id);
		ps.setInt(7, site_id);
		ps.setInt(8, site_id);
		rs=ps.executeQuery();
		if(rs.next())
			return rs.getInt(1);
		else
			return 0;
	}

	@Override
	public int changeSchedulingStatus(int scheduling_id, String schStatus) throws Exception {
		ps=con.prepareStatement(CHANGE_SCHEDULING_STATUS);
		ps.setString(1, schStatus);
		ps.setInt(2, scheduling_id);
		return ps.executeUpdate();
	}
	

}
