package com.willka.soft.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.willka.soft.bean.PlantBean;
import com.willka.soft.bean.PlantDeliveryAddressBean;

public interface PlantDAO {
	
	public int insertPlant(PlantBean bean) throws Exception;

	public int updatePlant(PlantBean bean) throws Exception;

	public int deletePlant(int plant_id) throws Exception;

	public ArrayList<PlantBean> getAllPlantBean() throws Exception;

	public PlantBean getplantById(int plant_id)throws Exception;

	public List<PlantBean> getAllPlantList() throws Exception;
	
	public int updateOnlyManager(String plant_manager_id,int plant_id)throws Exception;
	
	public int getMaxPlantId()throws Exception;
	
	public int insertPlantDeliveryAddress(PlantDeliveryAddressBean bean)throws Exception;
	
	public int updatePlantDeliveryAddress(PlantDeliveryAddressBean bean)throws Exception;
	
	public int changeDeliveryAddressStatus(int pl_delivery_address_id)throws Exception;
	
	public PlantDeliveryAddressBean getPlantDeliveryAddressById(int pl_delivery_address_id)throws Exception;
	
	ArrayList<PlantDeliveryAddressBean> getAllDevlieryAddressById(int plant_id)throws Exception;
	
	List<Map<String,Object>> getPlantDetailsByBusinessId(int business_id)throws Exception;
	
	public HashMap<Integer, String> getPlantListForSelect(int plant_id, int business_id)throws Exception;
	
}