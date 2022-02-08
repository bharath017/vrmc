package com.willka.soft.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.willka.soft.bean.GSTSettingBean;
import com.willka.soft.bean.MailSettingBean;
import com.willka.soft.bean.MoistureCorrectionBean;

public interface SettingDAO {

	public int insertGSTSetting(GSTSettingBean bean)throws Exception;
	
	public int updateGSTSetting(GSTSettingBean bean)throws Exception;
	
	public boolean checkAvailableOfGSTSetting()throws Exception;
	
	public boolean checkAvailableOfMailSetting()throws Exception;
	
	public int insertMailSetting(MailSettingBean bean)throws Exception;
	
	public int updateMailSetting(MailSettingBean bean)throws Exception;
	
	public GSTSettingBean getGstDetails()throws Exception;
	
	public int insertGST(float gst_percent,String gst_category)throws Exception;
	
	public int deleteGST(int gst_id)throws Exception;
	
	int getDieselId() throws Exception;
	
	public int insertDiscelSetting(int fleet_item_id) throws Exception;
	
	public boolean checkAvailableOfDieselSetting()throws Exception;
	
	public int updateDieselSetting(int fleet_item_id)throws Exception;
	
	public int addUnitDetails(String unit_name)throws Exception;
	
	public int deleteUnitDetails(int unit_id)throws Exception;
	
	public boolean checkAvailabilityMoisture(int plant_id)throws Exception;
	
	public int insertMoistureSetting(MoistureCorrectionBean bean)throws Exception;
	
	public int updateMoistureSetting(MoistureCorrectionBean bean)throws Exception;
	
	public MoistureCorrectionBean getMoistureDetails()throws Exception;
	
	public MailSettingBean getMailSetting()throws Exception;

	public MoistureCorrectionBean getMoistureDetails1(int plant_id) throws Exception;
	
	public MoistureCorrectionBean getPlantWiseMoisture(int plant_id)throws Exception;
	
	public int addBusinessGroup(String group_name,String group_description)throws Exception;
	
	public int deleteBusinessGroup(int business_id)throws Exception;
	
	public HashMap<Integer, String> getUnitListForOptions()throws Exception;
	
	public List<Map<String,Object>> getGstList()throws Exception;
	
	
	
}
