package com.willka.soft.test.dao;

import java.sql.Connection; 
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.willka.soft.test.bean.Inventory;
import com.willka.soft.test.bean.InventoryItemBean;
import com.willka.soft.test.bean.InventoryItemModification;
import com.willka.soft.test.bean.InventoryModificationBean;
import com.willka.soft.test.bean.InventoryStockBean;
import com.willka.soft.util.DBUtil;

public class InventoryDAOImpl implements InventoryDAO{
	
	private Connection con=null;
	private PreparedStatement ps=null;
	private ResultSet rs=null;
	
	private static final String INSERT_INVENTORY_ITEM="insert into inventory_item(inventory_name,stock_unit) values(?,?)";
	
	private static final String UPDATE_INVENTORY_ITEM="update inventory_item set inventory_name=?,stock_unit=? where inv_item_id=?";
	
	private static final String INSERT_INVENTORY_STOCK="insert into inventory_stock(inv_item_id,plant_id,stock_quantity) values(?,?,?)";
	
	private static final String CHECK_STOCK_AVAILABILITY="select * from inventory_stock where inv_item_id=? and plant_id=?";
	
	private static final String UPDATE_INVENTORY_STOCK="update inventory_stock set stock_quantity=? where inv_item_id=? and plant_id=?";
	
	private static final String CHANGE_ITEM_ITEM_QUANTITY="update inventory_item set item_quantity=? where inv_item_id=?";
	
	private static final String GET_INVENTORY_ITEM_LIST="select inv_item_id,inventory_name"
			+ " from inventory_item ";
	
	private static final String GET_SINGLE_INVENTORY_ITEM="select * from inventory_item where inv_item_id=?";
	
	private static final String INSERT_INVENTORY_ITEM_MODIFICATION="insert into inventory_item_modification(inv_item_id,old_quantity,new_quantity,modification_user,modification_comment) values(?,?,?,?,?)";
	
	private static final String CHANGE_INVENTORY_ITEM_STATUS="update inventory_item set item_status=? where inv_item_id=?";
	
	private static final String INSERT_INVENTORY="insert into test_inventory(inv_item_id,date,time,empty_weight,loaded_weight,net_weight,supplier_weight,"
			+ " bill_no,plant_id,supplier_id,vehicle_no,gatepass_no,unit,"
			+ " moisture_percent,after_weight,pl_delivery_address_id,"
			+ " royalty_no,inventory_document) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
	
	private static final String UPDATE_INVENTORY="update test_inventory set inv_item_id=?,date=?,time=?,empty_weight=?, "
			+ "loaded_weight=?,net_weight=?,supplier_weight=?,bill_no=?,plant_id=?,supplier_id=?,vehicle_no=?,gatepass_no=?,unit=?,pl_delivery_address_id=?,moisture_percent=?,after_weight=?,royalty_no=? where inventory_id=?";
	
	private static final String INSERT_INVENTORY_MODIFICATION="insert into test_inventory_modification(inventory_id,old_net_weight,new_net_weight,old_supplier_weight,new_supplier_weight,modification_user,modification_comment) values(?,?,?,?,?,?,?)";
	
	private static final String INSERT_INVENTORY_OUTGOING="insert into inventory_outgoing(inv_item_id,consumption_quantity,consumption_date,consumption_time,comment,added_by,plant_id) values(?,?,?,?,?,?,?)";
	
	private static final String UPDATE_INVENTORY_OUTGOING="update inventory_outgoing set inv_item_id=?,consumption_quantity=?,consumption_date=?,consumption_time=?,plant_id=? where invout_id=?";
	
	private static final String DELETE_INVENTORY_OUTGOING="delete from inventory_outgoing where invout_id=?";
	
	private static final String DELETE_INVENTORY="delete from inventory where inventory_id=?";
	
	private static final String DELETE_INVENTORY_ITEM="delete from inventory_item where inv_item_id=?";
	
	private static final String CANCEL_INVENTORY_ITEM="update inventory_item set item_status='cancelled'  where inv_item_id=?";
	
	private static final String CANCEL_INVENTORY="update test_inventory set inventory_status='deactive' where inventory_id=?";
	
	private static final String GET_SINGLE_INVENTORY="select * from test_inventory where inventory_id=?";
	
	private static final String CHANGE_INVENTORY_QUANTITY="update inventory set empty_weight=?,loaded_weight=?,net_weight=?,inventory_status='active' where inventory_id=?";

	private static final String GET_SINGLE_INVENTORY_OUTGOING="select * from inventory_outgoing where invout_id=?";
	
	private static final String INSERT_INVENTORY_VEHICLE="insert into temp_vehicle(vehicle_no) values(?)";
	
	private static final String UPDATE_LOADED_WEIGHT="update temp_vehicle set loaded_weight=? where vehicle_no=?";
	
	private static final String GET_LOADED_WEIGHT="select loaded_weight from temp_vehicle where vehicle_no=?";
	
	private static final String GET_INVENTORY_ITEM_UNIT="select stock_unit  from inventory_item where inv_item_id=?";
	
	private static final String UPDATE_STOCK_QUANTITY="update inventory_stock set stock_quantity=? where stock_id=?";
	
	private static final String  GET_INVENTORY_REPORT="select i.inventory_id,it.inventory_name,DATE_FORMAT(i.date,'%d/%m/%Y') as date,"+
			" i.time,i.bill_no,p.plant_name,s.supplier_name,i.vehicle_no,i.gatepass_no,i.unit,"+
			" i.empty_weight,i.loaded_weight,i.net_weight,i.supplier_weight"+
			" from test_inventory i LEFT JOIN (test_supplier s,inventory_item it,plant p)"+
			" ON i.supplier_id=s.supplier_id"+
			" and i.inv_item_id=it.inv_item_id"+
			" and i.plant_id=p.plant_id"+
			" where i.supplier_id like if(0=?,'%%',?)"+
			" and i.date between if(''=?,'2000-01-01',?) and if(''=?,'2050-01-01',?)"+
			" and i.inv_item_id like if(0=?,'%%',?)"+
			" and i.plant_id like if(0=?,'%%',?)"+
			" and s.business_id like if(?=0,'%%',?)"+
			" and i.inventory_status='active'";
	
	private static final String  GET_SUPPLIERWITHDATE_INVENTORY_REPORT="select i.inventory_id,it.inventory_name,DATE_FORMAT(i.date,'%d/%m/%Y') as date,"+
			" i.time,i.bill_no,p.plant_name,s.supplier_name,i.vehicle_no,i.gatepass_no,i.unit,"+
			" i.empty_weight,i.loaded_weight,i.net_weight,i.supplier_weight,i.supplier_id"+
			" from test_inventory i LEFT JOIN (test_supplier s,inventory_item it,plant p)"+
			" ON i.supplier_id=s.supplier_id"+
			" and i.inv_item_id=it.inv_item_id"+
			" and i.plant_id=p.plant_id"+
			" where i.supplier_id like if(0=?,'%%',?)"+
			" and i.date between if(''=?,'2000-01-01',?) and if(''=?,'2050-01-01',?)"+
			" and i.inv_item_id like if(0=?,'%%',?)"+
			" and i.plant_id like if(0=?,'%%',?)"+
			" and s.business_id like if(?=0,'%%',?)"+
			" and i.inventory_status='active'"+
			" order by i.supplier_id asc,i.inventory_id asc";
	
	private static final String GET_STOCK_REPORT="select p.* from ( "+
			  " select t.inv_item_id,t.inventory_name,t.stock_unit,"+
			  " if(t.opening_incoming is null,0,t.opening_incoming) as opening_incoming,"+
			  " if(t.opening_outgoing is null,0,t.opening_outgoing) as opening_outgoing,"+
			  " if(t.total_incoming is null,0,t.total_incoming) as total_incoming,"+
			  " if(t.total_outgoing is null,0,t.total_outgoing) as total_outgoing"+
			  " from (select fit.inv_item_id,fit.inventory_name,fit.stock_unit,"+
			  	" (select sum(net_weight) from inventory fii WHERE fii.date < ? and fii.inv_item_id=fit.inv_item_id and fii.plant_id=? and fii.inventory_status='active') as opening_incoming,"+
			  	" (select sum(foi.quantity) from inventory_outgoing fo,inventory_outgoing_item foi where fo.invout_id=foi.invout_id and  fo.date < ? and foi.inv_item_id=fit.inv_item_id and fo.plant_id=?) as opening_outgoing,"+
			  	" (select sum(net_weight) from inventory fii where fii.date between  ? and ? and fii.inv_item_id=fit.inv_item_id and fii.plant_id=? and fii.inventory_status='active') as total_incoming,"+
			  	" (select sum(foi.quantity) from inventory_outgoing fo,inventory_outgoing_item foi  where fo.invout_id=foi.invout_id and  fo.date between ? and ? and foi.inv_item_id=fit.inv_item_id and fo.plant_id=?) as total_outgoing"+
			  	" from inventory_item fit"+
			  	" ) as t where inv_item_id like if(?=0,'%%',?)  "+
			  " ) as p where ((p.opening_incoming-p.opening_outgoing)+p.total_incoming)-p.total_outgoing != 0";	
	
	private static final String GET_DATE_GROUP_BY_ITEM_REPORT="select sum(net_weight) as net_weight,DATE_FORMAT(i.date,'%d/%m/%Y') as inventory_date,"+
													" it.inventory_name,i.inv_item_id"+
													" from test_inventory i,inventory_item it"+ 
													" where i.inv_item_id=it.inv_item_id"+
													" and i.date between ? and ?"+
													" and i.inv_item_id like if(?=0,'%%',?)"+
													" and i.plant_id like if(?=0,'%%',?)"+
													" and i.inventory_status='active'"+
													" group by i.date,i.inv_item_id,it.inventory_name";
	
	private static final String GET_SUPPLIER_WISE_REPORT="select i.supplier_id,s.supplier_name,"+
													" sum(net_weight) as net_weight,i.inv_item_id,it.inventory_name"+
													" from test_inventory i,test_supplier s,inventory_item it "+
													" where i.inv_item_id=it.inv_item_id"+
													" and i.supplier_id=s.supplier_id"+
													" and i.supplier_id like if(?=0,'%%',?)"+
													" and i.inv_item_id like if(?=0,'%%',?)"+
													" and i.plant_id like if(?=0,'%%',?)"+
													" and i.inventory_status='active'"+
													" group by i.inv_item_id,i.supplier_id,s.supplier_name,it.inventory_name";
	
	
	private static final String GET_SUPPLIER_WITH_DATE_WISE_GROUP_REPORT="select i.supplier_id,s.supplier_name,sum(net_weight) as net_weight,"+
													" i.inv_item_id,it.inventory_name,DATE_FORMAT(i.date,'%d/%m/%Y') as date"+
													" from test_inventory i,test_supplier s,inventory_item it "+
													" where i.inv_item_id=it.inv_item_id"+
													" and i.supplier_id=s.supplier_id"+
													" and i.date between ? and ?"+
													" and i.supplier_id like if(?=0,'%%',?)"+
													" and i.inv_item_id like if(?=0,'%%',?)"+
													" and i.plant_id like if(?=0,'%%',?)"+
													" and i.inventory_status='active'"+
													" group by i.supplier_id,s.supplier_name,i.inv_item_id,it.inventory_name,i.date"+
													" order by i.supplier_id,i.date,i.inv_item_id asc";
	
	
	
	
	
	
	
	
	
	
	
	public InventoryDAOImpl() {
		con=DBUtil.getConnection();
	}

	@Override
	public int insertInventoryItem(String inventory_name,String stock_unit) throws Exception {
		ps=con.prepareStatement(INSERT_INVENTORY_ITEM);
		ps.setString(1, inventory_name);
		ps.setString(2,stock_unit);
		int count=ps.executeUpdate();
		return count;
	}

	@Override
	public int updateInventoryItem(String inventory_name,int inv_item_id, String stock_unit) throws Exception {
		ps=con.prepareStatement(UPDATE_INVENTORY_ITEM);
		ps.setString(1, inventory_name);
		ps.setString(2, stock_unit);
		ps.setInt(3, inv_item_id);
		int count=ps.executeUpdate();
		return count;
	}

	
	@Override
	public int insertInventoryStock(InventoryStockBean bean) throws Exception {
		ps=con.prepareStatement(INSERT_INVENTORY_STOCK);
		ps.setInt(1, bean.getInv_item_id());
		ps.setInt(2, bean.getPlant_id());
		ps.setDouble(3, bean.getStock_quantity());
		int count=ps.executeUpdate();
		return count;
	}

	@Override
	public InventoryStockBean getStockDetails(int inv_item_id, int plant_id) throws Exception {
		ps=con.prepareStatement(CHECK_STOCK_AVAILABILITY);
		ps.setInt(1, inv_item_id);
		ps.setInt(2, plant_id);
		rs=ps.executeQuery();
		if(rs.next()) {
			InventoryStockBean bean=new InventoryStockBean();
			bean.setInv_item_id(rs.getInt("inv_item_id"));
			bean.setPlant_id(rs.getInt("plant_id"));
			bean.setStock_quantity(rs.getDouble("stock_quantity"));
			return bean;
		}else {
			return null;
		}
	}

	@Override
	public int updateInventoryStock(InventoryStockBean bean) throws Exception {
		ps=con.prepareStatement(UPDATE_INVENTORY_STOCK);
		ps.setDouble(1, bean.getStock_quantity());
		ps.setInt(2, bean.getInv_item_id());
		ps.setInt(3, bean.getPlant_id());
		int count=ps.executeUpdate();
		return count;
	}
	
	@Override
	public int changeInventoryItemQuantity(int inv_item_id, double item_quantity) throws Exception {
		ps=con.prepareStatement(CHANGE_ITEM_ITEM_QUANTITY);
		ps.setDouble(1, item_quantity);
		ps.setInt(2, inv_item_id);
		int count=ps.executeUpdate();
		return count;
	}

	@Override
	public InventoryItemBean getSingleInventoryItemDetails(int inv_item_id) throws Exception {
		ps=con.prepareStatement(GET_SINGLE_INVENTORY_ITEM);
		ps.setInt(1, inv_item_id);
		rs=ps.executeQuery();
		if(rs.next()) {
			InventoryItemBean bean=new InventoryItemBean();
			bean.setInv_item_id(rs.getInt("inv_item_id"));
			bean.setInventory_name(rs.getString("inventory_name"));
			bean.setItem_quantity(rs.getDouble("item_quantity"));
			bean.setItem_unit(rs.getString("item_unit"));
			bean.setItem_status(rs.getString("item_status"));
			return bean;
		}
		else
		 return null;
	}

	@Override
	public int insertInventoryItemModification(InventoryItemModification bean) throws Exception {
		ps=con.prepareStatement(INSERT_INVENTORY_ITEM_MODIFICATION);
		ps.setInt(1, bean.getInv_item_id());
		ps.setDouble(2, bean.getOld_quantity());
		ps.setDouble(3, bean.getNew_quantity());
		ps.setString(4, bean.getModification_user());
		ps.setString(5, bean.getModification_comment());
		int count=ps.executeUpdate();
		return count;
	}

	@Override
	public int changeInventoryItemStatus(int inv_item_id, String status) throws Exception {
		ps=con.prepareStatement(CHANGE_INVENTORY_ITEM_STATUS);
		ps.setString(1, status);
		ps.setInt(2, inv_item_id);
		int count=ps.executeUpdate();
		return count;
	}

	@Override
	public int insertInventory(Inventory bean) throws Exception {
		ps=con.prepareStatement(INSERT_INVENTORY);
		ps.setInt(1, bean.getInv_item_id());
		ps.setString(2, bean.getDate());
		ps.setString(3, bean.getTime());
		ps.setDouble(4, bean.getEmpty_weight());
		ps.setDouble(5, bean.getLoaded_weight());
		ps.setDouble(6, bean.getNet_weight());
		ps.setDouble(7, bean.getSupplier_weight());
		ps.setString(8, bean.getBill_no());
		ps.setInt(9, bean.getPlant_id());
		ps.setInt(10, bean.getSupplier_id());
		ps.setString(11, bean.getVehicle_no());
		ps.setString(12, bean.getGatepass_no());
		ps.setString(13, bean.getUnit());
		ps.setFloat(14, bean.getMoisture_percent());
		ps.setDouble(15, bean.getAfter_weight());
		ps.setInt(16, bean.getPl_delivery_address_id());
		ps.setString(17, bean.getRoyalty_no());
		ps.setString(18, bean.getInventory_document());
		int count=ps.executeUpdate();
		return count;
	}

	@Override
	public int updateInventory(Inventory bean) throws Exception {
		ps=con.prepareStatement(UPDATE_INVENTORY);
		ps.setInt(1, bean.getInv_item_id());
		ps.setString(2, bean.getDate());
		ps.setString(3, bean.getTime());
		ps.setDouble(4, bean.getEmpty_weight());
		ps.setDouble(5, bean.getLoaded_weight());
		ps.setDouble(6, bean.getNet_weight());
		ps.setDouble(7, bean.getSupplier_weight());
		ps.setString(8, bean.getBill_no());
		ps.setInt(9, bean.getPlant_id());
		ps.setInt(10, bean.getSupplier_id());
		ps.setString(11, bean.getVehicle_no());
		ps.setString(12, bean.getGatepass_no());
		ps.setString(13, bean.getUnit());
		ps.setInt(14, bean.getPl_delivery_address_id());
		ps.setFloat(15, bean.getMoisture_percent());
		ps.setDouble(16, bean.getAfter_weight());
		ps.setString(17, bean.getRoyalty_no());
		ps.setInt(18, bean.getInventory_id());
		int count=ps.executeUpdate();
		return count;
	}

	@Override
	public int cancelInventory(int inventory_id) throws Exception {
		ps=con.prepareStatement(CANCEL_INVENTORY);
		ps.setInt(1, inventory_id);
		int count=ps.executeUpdate();
		return count;
	}

	@Override
	public int deleteInventory(int inventory_id) throws Exception {
		ps=con.prepareStatement(DELETE_INVENTORY);
		ps.setInt(1, inventory_id);
		int count=ps.executeUpdate();
		return count;
	}
	
	@Override
	public int deleteInventoryItem(int inv_item_id) throws Exception {
		ps=con.prepareStatement(DELETE_INVENTORY_ITEM);
		ps.setInt(1, inv_item_id);
		int count=ps.executeUpdate();
		return count;
	}
	
	@Override
	public int CancelInventoryItem(int inv_item_id) throws Exception {
		ps=con.prepareStatement(CANCEL_INVENTORY_ITEM);
		ps.setInt(1, inv_item_id);
		int count=ps.executeUpdate();
		return count;
	}

	@Override
	public int CancelInventory(int inventory_id, String status) throws Exception {
		ps=con.prepareStatement(CANCEL_INVENTORY);
		ps.setInt(1, inventory_id);
		ps.setString(2, status);
		int count=ps.executeUpdate();
		return count;
	}
	
	
	
	@Override
	public int insertInventoryModification(InventoryModificationBean bean) throws Exception {
		ps=con.prepareStatement(INSERT_INVENTORY_MODIFICATION);
		ps.setInt(1, bean.getInventory_id());
		ps.setDouble(2, bean.getOld_net_weight());
		ps.setDouble(3, bean.getNew_net_weight());
		ps.setDouble(4, bean.getOld_supplier_weight());
		ps.setDouble(5, bean.getNew_supplier_weight());
		ps.setString(6, bean.getModification_user());
		ps.setString(7,bean.getModification_comment());
		int count=ps.executeUpdate();
		return count;
	}
	@Override
	public int changeInventoryQuantity(int inventory_id, double empty_quantity,double loaded_quantity,double net_weight) throws Exception {
		ps=con.prepareStatement(CHANGE_INVENTORY_QUANTITY);
		ps.setDouble(1, empty_quantity);
		ps.setInt(4, inventory_id);
		ps.setDouble(2, loaded_quantity);
		ps.setDouble(3, net_weight);
		int count=ps.executeUpdate();
		return count;
	}

	
	@Override
	public Inventory getSingleInventoryDetails(int inventory_id) throws Exception {
		ps=con.prepareStatement(GET_SINGLE_INVENTORY);
		ps.setInt(1, inventory_id);
		rs=ps.executeQuery();
		if(rs.next()) {
			
			Inventory bean=new Inventory();
			
			bean.setInv_item_id(rs.getInt("inv_item_id"));
			bean.setBill_no(rs.getString("bill_no"));
			bean.setDate(rs.getString("date"));
			bean.setTime(rs.getString("time"));
			bean.setEmpty_weight(rs.getDouble("empty_weight"));
			bean.setLoaded_weight(rs.getDouble("loaded_weight"));
			bean.setSupplier_weight(rs.getDouble("supplier_weight"));
			bean.setNet_weight(rs.getDouble("net_weight"));
			bean.setInventory_status(rs.getString("inventory_status"));
			bean.setPlant_id(rs.getInt("plant_id"));
			bean.setVehicle_no(rs.getString("inventory_status"));
			
			return bean;
		}
		else
		 return null;
	}

	@Override
	public int insertInventoryVehicle(String vehicle_no) throws Exception {
		ps=con.prepareStatement(INSERT_INVENTORY_VEHICLE);
		ps.setString(1, vehicle_no);
		int count=ps.executeUpdate();
		return count;
	}

	@Override
	public int updateLoadedWeight(String vehicle_no, double loaded_weight) throws Exception {
		ps=con.prepareStatement(UPDATE_LOADED_WEIGHT);
		ps.setDouble(1, loaded_weight);
		ps.setString(2, vehicle_no);
		int count=ps.executeUpdate();
		return count;
		
	}

	@Override
	public double getLoadedWeight(String vehicle_no) throws Exception {
		ps=con.prepareStatement(GET_LOADED_WEIGHT);
		ps.setString(1, vehicle_no);
		rs=ps.executeQuery();
		if(rs.next()) {
			return rs.getDouble(1);
		}else {
			return 0.0;
		}
		
	}

	@Override
	public String getItemUnitName(int inv_item_id) throws Exception {
		ps=con.prepareStatement(GET_INVENTORY_ITEM_UNIT);
		ps.setInt(1, inv_item_id);
		rs=ps.executeQuery();
		if(rs.next()) {
			return rs.getString(1);
		}
		else
		return null;
	}

	@Override
	public int changeStockQuantity(int stock_id, double stock_quantity) throws Exception {
		ps=con.prepareStatement(UPDATE_STOCK_QUANTITY);
		ps.setInt(2, stock_id);
		ps.setDouble(1, stock_quantity);
		int count=ps.executeUpdate();
		return count;
	}

	@Override
	public Map<Integer, String> getInventoryItemList() throws Exception {
		ps=con.prepareStatement(GET_INVENTORY_ITEM_LIST);
		rs=ps.executeQuery();
		Map<Integer,String> data=new HashMap<Integer, String>();
		while(rs.next()) {
			data.put(rs.getInt("inv_item_id"), rs.getString("inventory_name"));
		}
		return data;
	}	
	
	
	
	@Override
	public List<Map<String, Object>> getDatewiseReport(String from_date, String to_date, int supplier_id,
			int inv_item_id, int plant_id,int business_id) throws Exception {
		ps=con.prepareStatement(GET_INVENTORY_REPORT);
		ps.setInt(1, supplier_id);
		ps.setInt(2, supplier_id);
		ps.setString(3, from_date);
		ps.setString(4,from_date);
		ps.setString(5,to_date);
		ps.setString(6,to_date);
		ps.setInt(7,inv_item_id);
		ps.setInt(8,inv_item_id);
		ps.setInt(9, plant_id);
		ps.setInt(10,plant_id);
		ps.setInt(11, business_id);
		ps.setInt(12,business_id);
		rs=ps.executeQuery();
		List<Map<String,Object>> list=new ArrayList<Map<String,Object>>();
		while(rs.next()) {
			Map<String,Object> map=new HashMap<String,Object>();
			map.put("inventory_id",rs.getInt("inventory_id"));
			map.put("inventory_name",rs.getString("inventory_name"));
			map.put("date",rs.getString("date"));
			map.put("time",rs.getString("time"));
			map.put("bill_no",rs.getString("bill_no"));
			map.put("plant_name",rs.getString("plant_name"));
			map.put("supplier_name",rs.getString("supplier_name"));
			map.put("vehicle_no",rs.getString("vehicle_no"));
			map.put("gatepass_no",rs.getString("gatepass_no"));
			map.put("unit",rs.getString("unit"));
			map.put("empty_weight",rs.getDouble("empty_weight"));
			map.put("loaded_weight",rs.getDouble("loaded_weight"));
			map.put("net_weight",rs.getDouble("net_weight"));
			map.put("supplier_weight",rs.getDouble("supplier_weight"));
			list.add(map);
		}
		return list;
	}

	@Override
	public List<Map<String, Object>> supplierwithDatewiseReport(String from_date, String to_date, int supplier_id,
			int inv_item_id, int plant_id, int business_id) throws Exception {
		ps=con.prepareStatement(GET_SUPPLIERWITHDATE_INVENTORY_REPORT);
		ps.setInt(1, supplier_id);
		ps.setInt(2, supplier_id);
		ps.setString(3, from_date);
		ps.setString(4,from_date);
		ps.setString(5,to_date);
		ps.setString(6,to_date);
		ps.setInt(7,inv_item_id);
		ps.setInt(8,inv_item_id);
		ps.setInt(9, plant_id);
		ps.setInt(10,plant_id);
		ps.setInt(11, business_id);
		ps.setInt(12,business_id);
		rs=ps.executeQuery();
		List<Map<String,Object>> list=new ArrayList<Map<String,Object>>();
		while(rs.next()) {
			Map<String,Object> map=new HashMap<String,Object>();
			map.put("inventory_id",rs.getInt("inventory_id"));
			map.put("inventory_name",rs.getString("inventory_name"));
			map.put("date",rs.getString("date"));
			map.put("time",rs.getString("time"));
			map.put("bill_no",rs.getString("bill_no"));
			map.put("plant_name",rs.getString("plant_name"));
			map.put("supplier_name",rs.getString("supplier_name"));
			map.put("vehicle_no",rs.getString("vehicle_no"));
			map.put("gatepass_no",rs.getString("gatepass_no"));
			map.put("unit",rs.getString("unit"));
			map.put("empty_weight",rs.getDouble("empty_weight"));
			map.put("loaded_weight",rs.getDouble("loaded_weight"));
			map.put("net_weight",rs.getDouble("net_weight"));
			map.put("supplier_weight",rs.getDouble("supplier_weight"));
			map.put("supplier_id", rs.getInt("supplier_id"));
			list.add(map);
		}
		return list;
	}	

	
	@Override
	public List<Map<String, Object>> getStockReport(String from_date, String to_date,
			int inv_item_id, int plant_id)
			throws Exception {
		ps=con.prepareStatement(GET_STOCK_REPORT);
		ps.setString(1, from_date);
		ps.setInt(2, plant_id);
		ps.setString(3, from_date);
		ps.setInt(4, plant_id);
		ps.setString(5, from_date);
		ps.setString(6, to_date);
		ps.setInt(7, plant_id);
		ps.setString(8, from_date);
		ps.setString(9, to_date);
		ps.setInt(10, plant_id);
		ps.setInt(11, inv_item_id);
		ps.setInt(12, inv_item_id);
		rs=ps.executeQuery();
		
		List<Map<String,Object>> list=new ArrayList<>();
		while(rs.next()) {
			Map<String,Object> map=new HashMap<>();
			map.put("inv_item_id", rs.getInt("inv_item_id"));
			map.put("inventory_name", rs.getString("inventory_name"));
			map.put("stock_unit", rs.getString("stock_unit"));
			map.put("opening_incoming", rs.getDouble("opening_incoming"));
			map.put("opening_outgoing", rs.getDouble("opening_outgoing"));
			map.put("total_incoming", rs.getDouble("total_incoming"));
			map.put("total_outgoing", rs.getDouble("total_outgoing"));
			list.add(map);
		}
		return list;
	}

	@Override
	public List<Map<String, Object>> getDateWithItemGroupWiseReport(String from_date, String to_date, int inv_item_id, int plant_id)
			throws Exception {
		ps=con.prepareStatement(GET_DATE_GROUP_BY_ITEM_REPORT);
		ps.setString(1, from_date);
		ps.setString(2, to_date);
		ps.setInt(3, inv_item_id);
		ps.setInt(4, inv_item_id);
		ps.setInt(5, plant_id);
		ps.setInt(6, plant_id);
		rs=ps.executeQuery();
		List<Map<String,Object>> list=new ArrayList<>();
		while(rs.next()) {
			Map<String,Object> data=new HashMap<>();
			data.put("net_weight", rs.getDouble("net_weight"));
			data.put("inventory_date", rs.getString("inventory_date"));
			data.put("inventory_name", rs.getString("inventory_name"));
			data.put("inv_item_id", rs.getInt("inv_item_id"));
			list.add(data);
		}
		return list;
	}

	@Override
	public List<Map<String, Object>> getSupplierWithItemWiseReport(int inv_item_id,
			int supplier_id, int plant_id) throws Exception {
		ps=con.prepareStatement(GET_SUPPLIER_WISE_REPORT);
		ps.setInt(1, supplier_id);
		ps.setInt(2, supplier_id);
		ps.setInt(3, inv_item_id);
		ps.setInt(4, inv_item_id);
		ps.setInt(5, plant_id);
		ps.setInt(6, plant_id);
		rs=ps.executeQuery();
		List<Map<String,Object>> list=new ArrayList<>();
		while(rs.next()) {
			Map<String,Object> data=new HashMap<>();
			data.put("net_weight", rs.getDouble("net_weight"));
			data.put("inventory_name", rs.getString("inventory_name"));
			data.put("inv_item_id", rs.getInt("inv_item_id"));
			data.put("supplier_name", rs.getString("supplier_name"));
			data.put("supplier_id", rs.getInt("supplier_id"));
			list.add(data);
		}
		return list;
	}

	@Override
	public List<Map<String, Object>> getSupplierWithDateWiseItemReport(String from_date, String to_date,
			int inv_item_id, int supplier_id, int plant_id) throws Exception {
		ps=con.prepareStatement(GET_SUPPLIER_WITH_DATE_WISE_GROUP_REPORT);
		ps.setString(1, from_date);
		ps.setString(2, to_date);
		ps.setInt(3, supplier_id);
		ps.setInt(4, supplier_id);
		ps.setInt(5, inv_item_id);
		ps.setInt(6, inv_item_id);
		ps.setInt(7, plant_id);
		ps.setInt(8, plant_id);
		rs=ps.executeQuery();
		List<Map<String,Object>> list=new ArrayList<>();
		while(rs.next()) {
			Map<String,Object> data=new HashMap<>();
			data.put("net_weight", rs.getDouble("net_weight"));
			data.put("inventory_name", rs.getString("inventory_name"));
			data.put("inv_item_id", rs.getInt("inv_item_id"));
			data.put("supplier_name", rs.getString("supplier_name"));
			data.put("supplier_id", rs.getInt("supplier_id"));
			data.put("date", rs.getString("date"));
			list.add(data);
		}
		return list;
	}
	
}
