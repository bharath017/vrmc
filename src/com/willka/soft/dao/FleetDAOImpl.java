package com.willka.soft.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import com.willka.soft.bean.FleetIncomingBean;
import com.willka.soft.bean.FleetIncomingEditBean;
import com.willka.soft.bean.FleetIncomingItemBean;
import com.willka.soft.bean.FleetItemBean;
import com.willka.soft.bean.FleetItemModificationBean;
import com.willka.soft.bean.FleetOutgoingBean;
import com.willka.soft.bean.FleetOutgoingEditBean;
import com.willka.soft.bean.FleetOutgoingItemBean;
import com.willka.soft.bean.SiteDetailBean;
import com.willka.soft.util.DBUtil;

public class FleetDAOImpl implements FleetDAO{

	private Connection con=null;
	private PreparedStatement ps=null;
	private ResultSet rs=null;

	
	private static final String INSERT_FLEET_ITEM="insert into fleet_item(item_name,item_cost,item_stock_quantity,plant_id) values(?,?,?,?)";
	
	private static final String UPDATE_FLEET_ITEM="update fleet_item set item_name=?,item_cost=?,plant_id=? where fleet_item_id=?";
	
	private static final String CHANGE_FLEET_STATUS="update fleet_item set item_status=? where fleet_item_id=?";
	
	private static final String CHANGE_FLEET_STOCK_QUANTITY="update fleet_item set item_stock_quantity=? where fleet_item_id=?";
	
	private static final String ADD_FLEET_MODIFICATION="insert into fleet_item_modification(fleet_item_id,old_stock_quantity,new_stock_quantity,modification_comment,modified_user) values(?,?,?,?,?)";
	
	private static final String GET_SINGLE_FLEET_ITEM_DETAILS="select * from fleet_item where fleet_item_id=?";
	
	private static final String INSERT_FLEET_INCOMING="insert into fleet_incoming(bill_no,incoming_date,incoming_time,purchaser_name,fleet_type,fleet_supplier,plant_id) values(?,?,?,?,?,?,?)";
	
	private static final String UPDATE_FLEET_INCOMING="update fleet_incoming set  bill_no=?,incoming_date=?,incoming_time=?,purchaser_name=?,fleet_type=?,fleet_supplier=?,plant_id=? where fleet_id=?";
	
	private static final String CANCEL_FLEET_INCOMING="update fleet_incoming set fleet_status='deactive' where fleet_id=?";
	
	private static final String INSERT_FLEET_INCOMING_EDIT="insert into fleet_incoming_edit(old_amount,new_amount,edited_user,edited_comment) values(?,?,?,?)";
	
	private static final String INSERT_FLEET_INCOMING_ITEM="insert into fleet_incoming_item(fleet_id,fleet_item_id,quantity,rate,gst_percent,gross_amount,tax_amount,net_amount) values(?,?,?,?,?,?,?,?)";
	
	private static final String UPDATE_FLEET_INCOMING_ITEM="update fleet_incoming_item set fleet_item_id=?,quantity=?,rate=?,gst_percent=?,gross_amount=?,tax_amount=?,net_amount=? where fi_item_id=?";
	
	private static final String DELETE_FLEET_INCOMING_ITEM="delete from fleet_incoming_item where fi_item_id=?";
	
	private static final String INSERT_FLEET_OUTGOING="insert into fleet_outgoing(issued_date,issued_time,received_person,returnable,return_status,outgoing_comment,plant_id) values(?,?,?,?,?,?,?)";
	
	private static final String INSERT_FLEET_OUTGOING_EDIT="insert into fleet_outgoing_edit(edited_user,edited_comment) values(?,?)";
	
	private static final String UPDATE_FLEET_OUTGOING="update fleet_outgoing set issued_date=?,issued_time=?,received_person=?,returnable=?,return_status=?,outgoing_comment=?,plant_id=? where fleet_outgoing_id=?";
	
	private static final String INSERT_FLEET_OUTGOING_ITEM="insert into fleet_outgoing_item(fleet_outgoing_id,fleet_item_id,quantity) values(?,?,?)";
	
	private static final String UPDATE_FLEET_OUTGOING_ITEM="update fleet_outgoing_item set fleet_outgoing_id=?,fleet_item_id=?,quantity=? where fo_item_id=?";

	private static final String GET_QUANTITY="select * from fleet_item where fleet_item_id=?";
	
	private static final String GET_MAX_FLEET_ID="select max(fleet_id) from fleet_incoming";
	
	private static final String GET_MAX_FLEET_OUT_ID="select max(fleet_outgoing_id) from fleet_outgoing";
	
	private static final String GET_SINGLE_FLEET_DETAILS="select f.*,(select sum(net_amount) from fleet_incoming_item where fleet_id=f.fleet_id) as total_net_amount from fleet_incoming f where fleet_id=?";
	
	private static final String GET_SINGLE_FLEET_INCOMING_ITEM_DETAILS="select * from fleet_incoming_item where fi_item_id=?";
	
	
	private static final String SELECT_ALL_FO_ITEM="select * from fleet_outgoing_item where fo_item_id=?";
	
	private static final String UPDATE_RETURN_STATUS="update fleet_outgoing  set return_status='RETURNED',returned_time=? where fleet_outgoing_id=?";
	
	
	public FleetDAOImpl() {
		con=DBUtil.getConnection();
	}
	
	@Override
	public int insertFleetItem(FleetItemBean bean) throws Exception {
		ps=con.prepareStatement(INSERT_FLEET_ITEM);
		ps.setString(1, bean.getItem_name());
		ps.setDouble(2,bean.getItem_cost());
		ps.setDouble(3, bean.getItem_stock_quantity());
		ps.setInt(4, bean.getPlant_id());
		int  count=ps.executeUpdate();
		return count;
	}

	@Override
	public int updateFleetItem(FleetItemBean bean) throws Exception {
		ps=con.prepareStatement(UPDATE_FLEET_ITEM);
		ps.setString(1, bean.getItem_name());
		ps.setDouble(2,bean.getItem_cost());
		ps.setInt(3, bean.getPlant_id());
		ps.setInt(4, bean.getFleet_item_id());
		int  count=ps.executeUpdate();
		return count;
	}

	@Override
	public int changeFleetItemStatus(int fleet_item_id, String item_status) throws Exception {
		ps=con.prepareStatement(CHANGE_FLEET_STATUS);
		ps.setString(1, item_status);
		ps.setInt(2, fleet_item_id);
		int count=ps.executeUpdate();
		return count;
	}

	@Override
	public int updateFleetItemQuantity(int fleet_item_id, double item_stock_quantity) throws Exception {
		ps=con.prepareStatement(CHANGE_FLEET_STOCK_QUANTITY);
		ps.setDouble(1, item_stock_quantity);
		ps.setInt(2, fleet_item_id);
		int count=ps.executeUpdate();
		return count;
	}

	@Override
	public int addFleetItemQuantityModification(FleetItemModificationBean bean) throws Exception {
		ps=con.prepareStatement(ADD_FLEET_MODIFICATION);
		ps.setInt(1, bean.getFleet_item_id());
		ps.setDouble(2, bean.getOld_stock_quantity());
		ps.setDouble(3, bean.getNew_stock_quantity());
		ps.setString(4, bean.getModification_comment());
		ps.setString(5, bean.getModified_user());
		int count=ps.executeUpdate();
		return count;
	}

	@Override
	public FleetItemBean getSingleItemDetails(int fleet_item_id) throws Exception {
		ps=con.prepareStatement(GET_SINGLE_FLEET_ITEM_DETAILS);
		ps.setInt(1, fleet_item_id);
		rs=ps.executeQuery();
		
		if(rs.next()) {
			FleetItemBean bean=new FleetItemBean();
			bean.setFleet_item_id(rs.getInt("fleet_item_id"));
			bean.setItem_name(rs.getString("item_name"));
			bean.setItem_cost(rs.getDouble("item_cost"));
			bean.setItem_stock_quantity(rs.getDouble("item_stock_quantity"));
			bean.setPlant_id(rs.getInt("plant_id"));
			bean.setItem_status(rs.getString("item_status"));
			return bean;
		}else {
			return null;
		}
	}

	@Override
	public int insertFleetIncoming(FleetIncomingBean bean) throws Exception {
		ps=con.prepareStatement(INSERT_FLEET_INCOMING);
		ps.setString(1, bean.getBill_no());
		ps.setString(2, bean.getIncoming_date());
		ps.setString(3, bean.getIncoming_time());
		ps.setString(4, bean.getPurchaser_name());
		ps.setString(5, bean.getFleet_type());
		ps.setString(6, bean.getFleet_supplier());
		ps.setInt(7,bean.getPlant_id());
		int count=ps.executeUpdate();
		return count;
	}

	@Override
	public int updateFleetIncoming(FleetIncomingBean bean) throws Exception {
		ps=con.prepareStatement(UPDATE_FLEET_INCOMING);
		ps.setString(1, bean.getBill_no());
		ps.setString(2, bean.getIncoming_date());
		ps.setString(3, bean.getIncoming_time());
		ps.setString(4, bean.getPurchaser_name());
		ps.setString(5, bean.getFleet_type());
		ps.setString(6, bean.getFleet_supplier());
		ps.setInt(7, bean.getPlant_id());
		ps.setInt(8, bean.getFleet_id());
		int count=ps.executeUpdate();
		return count;
	}

	@Override
	public int cancelFleetIncoming(int fleet_id) throws Exception {
		ps=con.prepareStatement(CANCEL_FLEET_INCOMING);
		ps.setInt(1, fleet_id);
		int count=ps.executeUpdate();
		return count;
	}
	
	@Override
	public int insertFletIncomingEdit(FleetIncomingEditBean bean) throws Exception {
		ps=con.prepareStatement(INSERT_FLEET_INCOMING_EDIT);
		ps.setDouble(1, bean.getOld_amount());
		ps.setDouble(2, bean.getNew_amount());
		ps.setString(3, bean.getEdited_user());
		ps.setString(4, bean.getEdited_comment());
		int count=ps.executeUpdate();
		return count;
	}

	@Override
	public int insertFleetIncomingItem(FleetIncomingItemBean bean) throws Exception {
		ps=con.prepareStatement(INSERT_FLEET_INCOMING_ITEM);
		ps.setInt(1, bean.getFleet_id());
		ps.setInt(2, bean.getFleet_item_id());
		ps.setDouble(3, bean.getQuantity());
		ps.setDouble(4, bean.getRate());
		ps.setDouble(5, bean.getGst_percent());
		ps.setDouble(6, bean.getGross_amount());
		ps.setDouble(7, bean.getTax_amount());
		ps.setDouble(8, bean.getNet_amount());
		int count=ps.executeUpdate();
		return count;
	}

	@Override
	public int updateFleetIncomingItem(FleetIncomingItemBean bean) throws Exception {
		ps=con.prepareStatement(UPDATE_FLEET_INCOMING_ITEM);
		ps.setInt(1, bean.getFleet_item_id());
		ps.setDouble(2, bean.getQuantity());
		ps.setDouble(3, bean.getRate());
		ps.setDouble(4, bean.getGst_percent());
		ps.setDouble(5, bean.getGross_amount());
		ps.setDouble(6, bean.getTax_amount());
		ps.setDouble(7, bean.getNet_amount());
		ps.setInt(8, bean.getFi_item_id());
		int count=ps.executeUpdate();
		return count;
	}

	@Override
	public int deleteFleetIncomingItem(int fi_item_id) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}
	
	@Override
	public int insertFleetOutgoing(FleetOutgoingBean bean) throws Exception {
		ps=con.prepareStatement(INSERT_FLEET_OUTGOING);
		ps.setString(1, bean.getIssued_date());
		ps.setString(2, bean.getIssued_time());
		ps.setString(3, bean.getReceived_person());
		ps.setString(4, bean.getReturnable());
		ps.setString(5, bean.getReturn_status());
		ps.setString(6, bean.getOutgoing_comment());
		ps.setInt(7, bean.getPlant_id());
		int count=ps.executeUpdate();
		return count;
	}
	
	@Override
	public int updateFleetOutgoing(FleetOutgoingBean bean) throws Exception {
		ps=con.prepareStatement(UPDATE_FLEET_OUTGOING);
		ps.setString(1, bean.getIssued_date());
		ps.setString(2, bean.getIssued_time());
		ps.setString(3, bean.getReceived_person());
		ps.setString(4, bean.getReturnable());
		ps.setString(5, bean.getReturn_status());
		ps.setString(6, bean.getOutgoing_comment());
		ps.setInt(7, bean.getPlant_id());
		ps.setInt(8, bean.getFleet_outgoing_id());
		int count=ps.executeUpdate();
		return count;
	}
	
	@Override
	public int updateFleetOutgoingEdit(FleetOutgoingEditBean bean) throws Exception {
		ps=con.prepareStatement(INSERT_FLEET_OUTGOING_EDIT);
		ps.setString(1, bean.getEdited_user());
		ps.setString(2, bean.getEdited_comment());
		int  count=ps.executeUpdate();
		return count;
	}
	@Override
	public int insertFleetOutgoingItem(FleetOutgoingItemBean bean) throws Exception {
		ps=con.prepareStatement(INSERT_FLEET_OUTGOING_ITEM);
		ps.setInt(1, bean.getFleet_outgoing_id());
		ps.setInt(2,bean.getFleet_item_id());
		ps.setDouble(3, bean.getQuantity());
		int  count=ps.executeUpdate();
		return count;
	}

	@Override
	public int updateFleetOutgoingItem(FleetOutgoingItemBean bean) throws Exception {
		ps=con.prepareStatement(UPDATE_FLEET_OUTGOING_ITEM);
		ps.setInt(1, bean.getFleet_outgoing_id());
		ps.setInt(2,bean.getFleet_item_id());
		ps.setDouble(3, bean.getQuantity());
		ps.setInt(4, bean.getFo_item_id());
	
		int  count=ps.executeUpdate();
		return count;
	}

	@Override
	public int getMaxFleetId() throws Exception {
		ps=con.prepareStatement(GET_MAX_FLEET_ID);
		rs=ps.executeQuery();
		if(rs.next()) {
			return rs.getInt(1);
		}else {
			return 0;
		}
	}
	
	@Override
	public int getMaxFleetOutgoingId() throws Exception {
		ps=con.prepareStatement(GET_MAX_FLEET_OUT_ID);
		rs=ps.executeQuery();
		if(rs.next()) {
			return rs.getInt(1);
		}else {
			return 0;
		}
	}
	
	
	@Override
	public FleetIncomingBean getSingleFleetIncomingDetails(int fleet_id) throws Exception {
		ps=con.prepareStatement(GET_SINGLE_FLEET_DETAILS);
		ps.setInt(1, fleet_id);
		rs=ps.executeQuery();
		if(rs.next()) {
			FleetIncomingBean bean=new FleetIncomingBean();
			bean.setBill_no(rs.getString("bill_no"));
			bean.setFleet_id(rs.getInt("fleet_id"));
			bean.setFleet_supplier(rs.getString("fleet_supplier"));
			bean.setFleet_type(rs.getString("fleet_type"));
			bean.setIncoming_date(rs.getString("incoming_date"));
			bean.setIncoming_time(rs.getString("incoming_time"));
			bean.setTotal_net_amount(rs.getDouble("total_net_amount"));
			return bean;
		}else {
			return null;
		}
	}

	@Override
	public FleetItemBean getQuantityDetailsUsingId(int fleet_item_id) throws Exception {
		ps=con.prepareStatement(GET_QUANTITY);
		ps.setInt(1, fleet_item_id);
		rs=ps.executeQuery();
		if(rs.next()) {
			FleetItemBean bean=new FleetItemBean();
			bean.setFleet_item_id(rs.getInt("fleet_item_id"));
			bean.setItem_cost(rs.getInt("item_cost"));
			bean.setItem_stock_quantity(rs.getDouble("item_stock_quantity"));
		
			return bean;
		}
		else
			return null;
	}
	
	@Override
	public ArrayList<FleetOutgoingItemBean> getAllFleetItemUsingFleet(int fleet_item_id) throws Exception {
		ps=con.prepareStatement(SELECT_ALL_FO_ITEM);
		ps.setInt(1,fleet_item_id);
		rs=ps.executeQuery();
		ArrayList<FleetOutgoingItemBean> foi_list=new ArrayList<>();
		while(rs.next()){
		//create bean object
			FleetOutgoingItemBean been=new FleetOutgoingItemBean();
			been.setFo_item_id(rs.getInt("fo_item_id"));
			been.setFleet_outgoing_id(rs.getInt("fleet_outgoing_id"));
			been.setFleet_item_id(rs.getInt("fleet_item_id"));
			been.setQuantity(rs.getInt("quantity"));
			foi_list.add(been);
		}
		return foi_list;
	}
	@Override
	public int updateReturnStatus(int fleet_outgoing_id, String time) throws Exception {
		ps=con.prepareStatement(UPDATE_RETURN_STATUS);
		ps.setString(1, time);
		ps.setInt(2, fleet_outgoing_id);
		int count=ps.executeUpdate();
		return count;
	}


	
	@Override
	public FleetOutgoingItemBean getSingleFleetOutgoingItemDetails(int fo_item_id) throws Exception {
		ps=con.prepareStatement(GET_SINGLE_FLEET_ITEM_DETAILS);
		ps.setInt(1, fo_item_id);
		rs=ps.executeQuery();
		
		if(rs.next()) {
			FleetOutgoingItemBean bean=new FleetOutgoingItemBean();
			bean.setFleet_item_id(rs.getInt("fleet_item_id"));
			bean.setFo_item_id(rs.getInt("fo_item_id"));
			bean.setQuantity(rs.getInt("quantity"));
			return bean;
		}else {
			return null;
		}
	}
}
