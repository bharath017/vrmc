package com.willka.soft.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.willka.soft.bean.GSTSettingBean;
import com.willka.soft.bean.MailSettingBean;
import com.willka.soft.bean.MoistureCorrectionBean;
import com.willka.soft.util.DBUtil;

public class SettingDAOImpl implements SettingDAO{

	//general settings
	private Connection con=null;
	private ResultSet rs=null;
	private PreparedStatement ps=null;
	
	//GST setting query here
	private static final String CHECK_GST_AVAILABLITITY="select * from gst_setting";
	
	private static final String INSERT_GST_SETTING="insert into gst_setting(cgst,sgst,igst) values(?,?,?)";
	
	private static final String UPDATE_GST_SETTING="update gst_setting set cgst=?,sgst=?,igst=?";
	
	//Mail setting query here
	private static final String CHECK_MAIL_AVAILABILITY="select * from mail_setting";
	
	private static final String INSERT_MAIL_SETTING="insert into mail_setting values(?,?,?,?,?,?)";
	
	private static final String UPDATE_MAIL_SETTING="update mail_setting set smtp_host=?, smtp_user=?, smtp_password=?, smtp_port=?, smtp_security=?, smtp_authontication_domain=?";
	
	private static final String GET_GST_DETAILS="select * from gst_setting";
	
	private static final String INSERT_GST_PERCENT="insert into gst_percent(gst_percent,gst_category) values(?,?)";
	
	private static final String DELETE_GST_PERCENT="delete from gst_percent where gst_id=?";
	
	private static final String INSERT_DIESEL_SETTING="insert into general_setting(diesel_id) values(?)";
	
	private static final String CHECK_DIESEL_AVAILABILITY="select * from general_setting";
	
	private static final String UPDATE_DIESEL_SETTING="update general_setting set diesel_id=?";
	
	private static final String CHECK_MOISTURE_AVAILABILITY="select * from moisture_correction ";
	
	private static final String CHECK_MOISTURE_AVAILABILITYY="select * from moisture_correction where plant_id=?";
	
	private static final String INSERT_MOISTURE_CORRECTION="insert into moisture_correction values(?,?,?,?,?,?,?,?,?)";
	
	private static final String UPDATE_MOISTURE_CORRECTION="update moisture_correction set aggr1_moi=?,aggr2_moi=?,aggr3_moi=?,aggr4_moi=?,aggr1_abs=?,aggr2_abs=?,aggr3_abs=?,aggr4_abs=? where plant_id=?";
	
	private static final String GET_EMAIL_SETTING="select * from mail_setting";
	
	private static final String GET_MOISTURE_DETAILS = "select * from moisture_correction where plant_id=?";
	
	private static final String ADD_BUSINESS_GROUP="insert into business_group(group_name,group_description) values(?,?)";
	
	private static final String DELETE_BUSINESS_GROUP="delete from business_group where business_id=?";
	
	private static final String GET_UNIT_LIST_FOR_OPTIONS="select unit_id,unit_name from unit";
	
	private static final String GET_GST_LIST="select distinct(gst_percent)  from gst_percent";
	
	
	
	
	public SettingDAOImpl() {
		con=DBUtil.getConnection();
	}
	
	
	@Override
	public int insertGSTSetting(GSTSettingBean bean) throws Exception {
		ps=con.prepareStatement(INSERT_GST_SETTING);
		ps.setFloat(1, bean.getCgst());
		ps.setFloat(2, bean.getSgst());
		ps.setFloat(3, bean.getIgst());
		System.out.println(ps.toString());
		int count=ps.executeUpdate();
		return count;
	}

	@Override
	public int updateGSTSetting(GSTSettingBean bean) throws Exception {
		ps=con.prepareStatement(UPDATE_GST_SETTING);
		ps.setFloat(1, bean.getCgst());
		ps.setFloat(2, bean.getSgst());
		ps.setFloat(3, bean.getIgst());
		int count=ps.executeUpdate();
		return count;
	}

	@Override
	public boolean checkAvailableOfGSTSetting() throws Exception {
		ps=con.prepareStatement(CHECK_GST_AVAILABLITITY);
		rs=ps.executeQuery();
		if(rs.next()) {
			return true;
		}else {
			return false;
		}
	}


	@Override
	public boolean checkAvailableOfMailSetting() throws Exception {
		ps=con.prepareStatement(CHECK_MAIL_AVAILABILITY);
		rs=ps.executeQuery();
		if(rs.next()) {
			return true;
		}
		else
		 return false;
	}


	@Override
	public int insertMailSetting(MailSettingBean bean) throws Exception {
		ps=con.prepareStatement(INSERT_MAIL_SETTING);
		ps.setString(1, bean.getSmtp_host());
		ps.setString(2, bean.getSmtp_user());
		ps.setString(3, bean.getSmtp_password());
		ps.setString(4, bean.getSmtp_port());
		ps.setString(5, bean.getSmtp_password());
		ps.setString(6, bean.getSmtp_authontication_domain());
		int count=ps.executeUpdate();
		return count;
	}	


	@Override
	public int updateMailSetting(MailSettingBean bean) throws Exception {
		ps=con.prepareStatement(UPDATE_MAIL_SETTING);
		ps.setString(1, bean.getSmtp_host());
		ps.setString(2, bean.getSmtp_user());
		ps.setString(3, bean.getSmtp_password());
		ps.setString(4, bean.getSmtp_port());
		ps.setString(5, bean.getSmtp_password());
		ps.setString(6, bean.getSmtp_authontication_domain());
		int count=ps.executeUpdate();
		return count;
	}


	@Override
	public GSTSettingBean getGstDetails() throws Exception {
		ps=con.prepareStatement(GET_GST_DETAILS);
		rs=ps.executeQuery();
		if(rs.next()) {
			GSTSettingBean bean=new GSTSettingBean();
			bean.setCgst(rs.getFloat("cgst"));
			bean.setSgst(rs.getFloat("sgst"));
			bean.setIgst(rs.getFloat("igst"));
			return bean;
		}else {
			return null;
		}
	}
	
	@Override
	public int insertGST(float gst_percent,String gst_category) throws Exception {
		ps=con.prepareStatement(INSERT_GST_PERCENT);
		ps.setFloat(1, gst_percent);
		ps.setString(2, gst_category);
		int count=ps.executeUpdate();
		return count;
	}
	@Override
	public int deleteGST(int gst_id) throws Exception {
		ps=con.prepareStatement(DELETE_GST_PERCENT);
		ps.setInt(1, gst_id);
		int count=ps.executeUpdate();
		return count;
	}
	
	@Override
	public int getDieselId()throws Exception {
		ps=con.prepareStatement("select diesel_id from general_setting");
		rs=ps.executeQuery();
		if(rs.next()){
			return rs.getInt("diesel_id");
		}else{
			return 0;
		}
	}

	@Override
	public boolean checkAvailableOfDieselSetting() throws Exception {
		ps=con.prepareStatement(CHECK_DIESEL_AVAILABILITY);
		rs=ps.executeQuery();
		if(rs.next()) {
			return true;
		}
		else
		 return false;
	}
	
	
	
	@Override
	public int insertDiscelSetting(int fleet_item_id) throws Exception {
		ps=con.prepareStatement(INSERT_DIESEL_SETTING);
		ps.setInt(1, fleet_item_id);
		int count=ps.executeUpdate();
		return count;
	}


	@Override
	public int updateDieselSetting(int fleet_item_id) throws Exception {
		ps=con.prepareStatement(UPDATE_DIESEL_SETTING);
		ps.setInt(1, fleet_item_id);
		int count=ps.executeUpdate();
		return count;
	}
	
	@Override
	public int addUnitDetails(String unit_name) throws Exception {
		ps=con.prepareStatement("insert into unit(unit_name) values(?)");
		ps.setString(1, unit_name);
		int count=ps.executeUpdate();
		return count;
	}
	@Override
	public int deleteUnitDetails(int unit_id) throws Exception {
		ps=con.prepareStatement("delete from unit where unit_id=?");
		ps.setInt(1, unit_id);
		int count=ps.executeUpdate();
		return count;
	}


	@Override
	public boolean checkAvailabilityMoisture(int plant_id) throws Exception {
		ps=con.prepareStatement(CHECK_MOISTURE_AVAILABILITYY);
		ps.setInt(1, plant_id);
		rs=ps.executeQuery();
		if(rs.next()) {
			return true;
		}else {
			return false;
		}
	}


	@Override
	public int insertMoistureSetting(MoistureCorrectionBean bean) throws Exception {
		ps=con.prepareStatement(INSERT_MOISTURE_CORRECTION);
		ps.setInt(1, bean.getPlant_id());
		ps.setFloat(2, bean.getAggr1_moi());
		ps.setFloat(3, bean.getAggr2_moi());
		ps.setFloat(4, bean.getAggr3_moi());
		ps.setFloat(5, bean.getAggr4_moi());
		ps.setFloat(6, bean.getAggr1_abs());
		ps.setFloat(7, bean.getAggr2_abs());
		ps.setFloat(8, bean.getAggr3_abs());
		ps.setFloat(9, bean.getAggr4_abs());
		int count=ps.executeUpdate();
		return count;
		
	}


	@Override
	public int updateMoistureSetting(MoistureCorrectionBean bean) throws Exception {
		ps=con.prepareStatement(UPDATE_MOISTURE_CORRECTION);
		ps.setFloat(1, bean.getAggr1_moi());
		ps.setFloat(2, bean.getAggr2_moi());
		ps.setFloat(3, bean.getAggr3_moi());
		ps.setFloat(4, bean.getAggr4_moi());
		ps.setFloat(5, bean.getAggr1_abs());
		ps.setFloat(6, bean.getAggr2_abs());
		ps.setFloat(7, bean.getAggr3_abs());
		ps.setFloat(8, bean.getAggr4_abs());
		ps.setInt(9, bean.getPlant_id());
		int count=ps.executeUpdate();
		return count;
	}


	@Override
	public MoistureCorrectionBean getMoistureDetails()throws Exception {
		ps=con.prepareStatement(CHECK_MOISTURE_AVAILABILITY);
		rs=ps.executeQuery();
		MoistureCorrectionBean bean=new MoistureCorrectionBean();
		if(rs.next()) {
			bean.setAggr1_moi(rs.getFloat("aggr1_moi"));
			bean.setAggr2_moi(rs.getFloat("aggr2_moi"));
			bean.setAggr3_moi(rs.getFloat("aggr3_moi"));
			bean.setAggr4_moi(rs.getFloat("aggr4_moi"));
			bean.setAggr1_abs(rs.getFloat("aggr1_abs"));
			bean.setAggr2_abs(rs.getFloat("aggr2_abs"));
			bean.setAggr3_abs(rs.getFloat("aggr3_abs"));
			bean.setAggr4_abs(rs.getFloat("aggr4_abs"));
		}
		return bean;
	}


	@Override
	public MailSettingBean getMailSetting() throws Exception {
		ps=con.prepareStatement(GET_EMAIL_SETTING);
		rs=ps.executeQuery();
		MailSettingBean bean=new MailSettingBean();
		if(rs.next()) {
			 bean.setSmtp_host(rs.getString("smtp_host"));
			 bean.setSmtp_port(rs.getString("smtp_port"));
			 bean.setSmtp_user(rs.getString("smtp_user"));
			 bean.setSmtp_password(rs.getString("smtp_password"));
			 bean.setSmtp_security(rs.getString("smtp_security"));
			 bean.setSmtp_authontication_domain(rs.getString("smtp_authontication_domain"));
		}
		return bean;
	}


	@Override
	public MoistureCorrectionBean getMoistureDetails1(int plant_id) throws Exception {
		ps=con.prepareStatement(GET_MOISTURE_DETAILS);
		ps.setInt(1, plant_id);
		rs=ps.executeQuery();
		MoistureCorrectionBean bean=new MoistureCorrectionBean();
		if(rs.next()) {
			bean.setAggr1_moi(rs.getFloat("aggr1_moi"));
			bean.setAggr2_moi(rs.getFloat("aggr2_moi"));
			bean.setAggr3_moi(rs.getFloat("aggr3_moi"));
			bean.setAggr4_moi(rs.getFloat("aggr4_moi"));
			bean.setAggr1_abs(rs.getFloat("aggr1_abs"));
			bean.setAggr2_abs(rs.getFloat("aggr2_abs"));
			bean.setAggr3_abs(rs.getFloat("aggr3_abs"));
			bean.setAggr4_abs(rs.getFloat("aggr4_abs"));
			bean.setPlant_id(rs.getInt("plant_id"));
		}
		return bean;
	}


	@Override
	public MoistureCorrectionBean getPlantWiseMoisture(int plant_id) throws Exception {
		ps=con.prepareStatement(CHECK_MOISTURE_AVAILABILITYY);
		ps.setInt(1, plant_id);
		rs=ps.executeQuery();
		MoistureCorrectionBean bean=new MoistureCorrectionBean();
		if(rs.next()) {
			bean.setAggr1_moi(rs.getFloat("aggr1_moi"));
			bean.setAggr2_moi(rs.getFloat("aggr2_moi"));
			bean.setAggr3_moi(rs.getFloat("aggr3_moi"));
			bean.setAggr4_moi(rs.getFloat("aggr4_moi"));
			bean.setAggr1_abs(rs.getFloat("aggr1_abs"));
			bean.setAggr2_abs(rs.getFloat("aggr2_abs"));
			bean.setAggr3_abs(rs.getFloat("aggr3_abs"));
			bean.setAggr4_abs(rs.getFloat("aggr4_abs"));
		}
		return bean;
	}


	@Override
	public int addBusinessGroup(String group_name, String group_description) throws Exception {
		ps=con.prepareStatement(ADD_BUSINESS_GROUP);
		ps.setString(1, group_name);
		ps.setString(2, group_description);
		int count=ps.executeUpdate();
		return count;
	}


	@Override
	public int deleteBusinessGroup(int business_id) throws Exception {
		ps=con.prepareStatement(DELETE_BUSINESS_GROUP);
		ps.setInt(1, business_id);
		int count=ps.executeUpdate();
		return count;
	}
	
	@Override
	public HashMap<Integer, String> getUnitListForOptions() throws Exception {
		ps=con.prepareStatement(GET_UNIT_LIST_FOR_OPTIONS);
		rs=ps.executeQuery();
		HashMap<Integer, String> map=new HashMap<Integer, String>();
		while(rs.next()) {
			map.put(rs.getInt("unit_id"), rs.getString("unit_name"));
		}
		return map;
	}


	@Override
	public List<Map<String, Object>> getGstList() throws Exception {
		ps=con.prepareStatement(GET_GST_LIST);
		rs=ps.executeQuery();
		List<Map<String,Object>> list=new ArrayList<Map<String,Object>>();
		while(rs.next()) {
			Map<String,Object> data=new HashMap<>();
			data.put("gst_percent", rs.getDouble("gst_percent"));
			list.add(data);
		}
		return list;
	}

}
