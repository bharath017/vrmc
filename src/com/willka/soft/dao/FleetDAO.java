package com.willka.soft.dao;

import java.util.ArrayList;

import com.willka.soft.bean.FleetIncomingBean;
import com.willka.soft.bean.FleetIncomingEditBean;
import com.willka.soft.bean.FleetIncomingItemBean;
import com.willka.soft.bean.FleetItemBean;
import com.willka.soft.bean.FleetItemModificationBean;
import com.willka.soft.bean.FleetOutgoingBean;
import com.willka.soft.bean.FleetOutgoingEditBean;
import com.willka.soft.bean.FleetOutgoingItemBean;

public interface FleetDAO {

	public int insertFleetItem(FleetItemBean bean)throws Exception;
	
	public int updateFleetItem(FleetItemBean bean)throws Exception;
	
	public int changeFleetItemStatus(int fleet_item_id,String item_status)throws Exception;
	
	public int updateFleetItemQuantity(int fleet_item_id,double item_stock_quantity)throws Exception;
	
	public int addFleetItemQuantityModification(FleetItemModificationBean bean)throws Exception;
	
	public FleetItemBean getSingleItemDetails(int fleet_item_id)throws Exception;
	
	public int getMaxFleetId()throws Exception;
	
	public int getMaxFleetOutgoingId() throws Exception;
	
	public int insertFleetIncoming(FleetIncomingBean bean)throws Exception;
	
	public int updateFleetIncoming(FleetIncomingBean bean)throws Exception;
	
	public int cancelFleetIncoming(int fleet_id)throws Exception;
	
	public int insertFletIncomingEdit(FleetIncomingEditBean bean)throws Exception;
	
	public int insertFleetIncomingItem(FleetIncomingItemBean bean)throws Exception;
	
	public int updateFleetIncomingItem(FleetIncomingItemBean bean)throws Exception;
	
	public int deleteFleetIncomingItem(int fi_item_id)throws Exception;
	
	public int insertFleetOutgoing(FleetOutgoingBean bean)throws Exception;
	
	public int updateFleetOutgoing(FleetOutgoingBean bean)throws Exception;
	
	public int updateFleetOutgoingEdit(FleetOutgoingEditBean bean)throws Exception;
	
	public int insertFleetOutgoingItem(FleetOutgoingItemBean bean)throws Exception;
	
	public int updateFleetOutgoingItem(FleetOutgoingItemBean bean)throws Exception;
	
	public ArrayList<FleetOutgoingItemBean> getAllFleetItemUsingFleet(int fleet_outgoing_id) throws Exception;
	
	public int updateReturnStatus(int fleet_outgoing_id, String time) throws Exception;
	
	public FleetIncomingBean getSingleFleetIncomingDetails(int fleet_id)throws Exception;
	
	public FleetOutgoingItemBean getSingleFleetOutgoingItemDetails(int fo_item_id)throws Exception;
	
	public FleetItemBean getQuantityDetailsUsingId(int fleet_item_id) throws Exception;
	
	
	
	
	
	 
	
}
