package com.willka.soft.dao;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.willka.soft.bean.InventoryOutgoingBean;
import com.willka.soft.bean.InventoryOutgoingItem;
import com.willka.soft.bean.StockBean;
import com.willka.soft.util.DBUtil;

public class StockDAOImpl implements StockDAO {
	
	private Connection con=null;
	private PreparedStatement ps=null;
	private ResultSet rs=null;
	
	private static final String INSERT_INVENTORY_STOCK="insert into inventory_stock(inv_item_id,effective_date,quantity,plant_id)"
			+ " values(?,?,?,?)";
	
	private static final String UPDATE_INVENTORY_STOCK="update inventory_stock set quantity=?,effective_date=?,plant_id=?,inv_item_id=?"
			+ "  where stock_id=?";
	
	private static final String DELETE_INVENTORY_STOCK="delete from inventory_stock where stock_id=?";
	
	private static final String GET_INVENTORY_STOCK_LIST="select s.*,itt.inventory_name,"+
			" DATE_FORMAT(iss.effective_date,'%d/%m/%Y') as effective_date,"+
			" iss.quantity,pl.plant_name"+
			 " from ( select max(stock_id) as stk_id,inv_item_id,plant_id"+
					" from inventory_stock"+
					" GROUP by inv_item_id,plant_id"+
					" order by plant_id,inv_item_id asc"+
				  " ) as s,inventory_stock iss,plant pl,inventory_item itt "+
			" where s.stk_id=iss.stock_id "+
			" and iss.plant_id=pl.plant_id"+
			" and iss.inv_item_id=itt.inv_item_id";
	
	private static final String GET_SINGLE_OPENING_STOCK_DETAILS="select s.*,DATE_FORMAT(s.effective_date,'%d/%m/%Y') as date"
			+ " from inventory_stock s where stock_id=?";
	
	private static final String GET_ALL_INVENTORY_ITEM="select inv_item_id,inventory_name"
			+ " from inventory_item "
			+ " where item_status='active'";
	
	private static final String GET_GRADE_COMPOSITION="select g.sp_id as inv_item_id,inv.inventory_name,g.comp_weight as quantity"
			+ " from grade_composition g,inventory_item inv"
			+ " where g.sp_id=inv.inv_item_id"
			+ " and product_id=?";
	
	private static final String ADD_INVENTORY_OUTGOING="insert into inventory_outgoing(product_id,plant_id,date,"
			+ "comment,added_by,quantity,production_cost)"
			+ " values(?,?,?,?,?,?,?)";

	private static final String UPDATE_INVENTORY_OUTGOING="update  inventory_outgoing set product_id=?,plant_id=?,date=?,"
			+ "comment=?,added_by=?,quantity=?,production_cost=?  where invout_id=?";
	
	private static final String ADD_INVENTORY_OUTGOING_ONLY_FOR_CONSUMPTION="insert into inventory_outgoing(plant_id,date,"
			+ "comment,added_by)"
			+ " values(?,?,?,?)";
	
	private static final String ADD_INVENTORY_OUTGING_ITEM="insert into inventory_outgoing_item(inv_item_id,quantity,invout_id)"
			+ " values(?,?,?)";
	
	private static final String UPDATE_INVENTORY_OUTGING_ITEM="update inventory_outgoing_item set inv_item_id=?,quantity=? where invout_item_id=?";
	
	private static final String GET_LAST_ADDED_OUTGOING_ITEM="select max(invout_id) from inventory_outgoing";
	
	private static final String GET_PRODUCTION_LIST="select o.invout_id,p.product_name,pl.plant_name,"+
			" DATE_FORMAT(o.date,'%d/%m/%Y') as date,o.added_by,o.quantity,o.comment,o.production_cost,"+
			" (select sum(quantity) from inventory_outgoing_item where invout_id=o.invout_id) as totalquantity"+
			" from inventory_outgoing o LEFT JOIN (product p,plant pl)"+
			" ON o.product_id=p.product_id"+
			" and o.plant_id=pl.plant_id"+
			" where o.product_id like if(?=0,'%%',?)"+
			" and o.date between if(?='','2000-01-01',?) and if(''=?,'2050-01-01',?)"+
			" and o.plant_id like if(?=0,'%%',?)"+
			" order by o.invout_id desc"+
			" limit ?,?";
	
	private static final String COUNT_PRODUCTION_LIST="select count(o.invout_id) as count"+
			" from inventory_outgoing o"+
			" where o.product_id like if(?=0,'%%',?)"+
			" and o.date between if(?='','2000-01-01',?) and if(''=?,'2050-01-01',?)"+
			" and o.plant_id like if(?=0,'%%',?)";
	
	private static final String DELETE_PRODUCTION_DETAILS="delete from inventory_outgoing where invout_id=?";
	
	private static final String GET_CONVERSION_VALUE_DETAILS="select isConversionRequired,conversion_value from product where product_id=?";
	
	//report part here
	private static final String GET_DATE_WISE_PRODUCTION_REPORT="select p.product_name,p.unit_of_measurement,i.invout_id,i.quantity,i.production_cost,"+
			" DATE_FORMAT(i.date,'%d/%m/%Y') as date,i.added_by,pl.plant_name,"+
			" (select sum(quantity) from inventory_outgoing_item where invout_id=i.invout_id) as tquantity"+
			" from inventory_outgoing i LEFT JOIN (product p,plant pl)"+
			" ON i.product_id=p.product_id"+
			" and i.plant_id=pl.plant_id"+
			" where i.date between ? and ?"+
			" and i.product_id like if(?=0,'%%',?)"+
			" and i.plant_id like if(?=0,'%%',?)"+
			" order by i.invout_id asc";
	
	private static final String GET_STOCK_REPORT="select m.* from"+
											   " (select product_id,product_name,unit_of_measurement,"+
													" (select sum(quantity) from inventory_outgoing where date < ?"+ 
														" and product_id=p.product_id and plant_id=?) as opening_incoming,"+
													" (select sum(sdi.item_quantity) from sales_document sd,sales_document_item sdi,purchase_order_item poi"+ 
														" where sd.id=sdi.id and sdi.poi_id=poi.poi_id and sd.invoice_date < ? and poi.product_id=p.product_id and sd.plant_id=?) as opening_outgoing,"+
													" (select sum(sdi.item_quantity) from test_sales_document sd,test_sales_document_item sdi,test_purchase_order_item poi"+ 
														" where sd.id=sdi.id and sdi.poi_id=poi.poi_id and sd.invoice_date < ? and poi.product_id=p.product_id and sd.plant_id=?) as opening_outgoing_gst,"+
													" (select avg(production_cost) from inventory_outgoing "+
														" where date between ? and ? and product_id=p.product_id and plant_id=?) as avg_price,"+
													" (select sum(quantity) from inventory_outgoing"+
														" where date between ? and ? and product_id=p.product_id and plant_id=?) as total_production,"+
													" (select sum(sdi.item_quantity) from sales_document sd,sales_document_item sdi,purchase_order_item poi "+
														" where sd.id=sdi.id and sdi.poi_id=poi.poi_id and sd.invoice_date between "+
													    " ? and ?  and poi.product_id=p.product_id and sd.plant_id=? and sd.invoice_status='active') as total_sales,"+
													" (select sum(sdi.item_quantity) from test_sales_document sd,test_sales_document_item sdi,test_purchase_order_item poi "+
														" where sd.id=sdi.id and sdi.poi_id=poi.poi_id and sd.invoice_date between "+
													    " ? and ?  and poi.product_id=p.product_id and sd.plant_id=? and sd.invoice_status='active') as total_sales_gst"+
												" from product p "+
												" where product_status='active' and product_id like if(?=0,'%%',?)"+
											" ) as m"+
									    " where (m.opening_incoming>0 or m.opening_outgoing>0 or m.total_production>0 or total_sales>0)";
	
	
	private static final String GET_INVENTORY_OUTOGING_LIST="select i.invout_id,ii.invout_item_id,DATE_FORMAT(i.date,'%d/%m/%Y') as date,p.plant_name,"+
			" i.added_by,i.comment,ii.quantity,it.inventory_name"+
			" from inventory_outgoing i LEFT JOIN (inventory_outgoing_item ii,plant p,inventory_item it)"+
			" ON i.invout_id=ii.invout_id"+
			" and i.plant_id=p.plant_id"+
			" and ii.inv_item_id=it.inv_item_id"+
			" where i.date between  if(''=?,'2000-01-01',?) and if(''=?,'2050-01-01',?)"+
			" and ii.inv_item_id like if(?=0,'%%',?)"+
			" and i.plant_id like if(?=0,'%%',?)"+
			" and i.product_id is null"+
			" order by i.invout_id desc"+
			" limit ?,?";
	
	private static final String COUNT_INVENTORY_OUTGOING_LIST="select count(i.invout_id)"+
			" from inventory_outgoing i LEFT JOIN (inventory_outgoing_item ii)"+
			" ON i.invout_id=ii.invout_id"+
			" where i.date between  if(''=?,'2000-01-01',?) and if(''=?,'2050-01-01',?)"+
			" and ii.inv_item_id like if(?=0,'%%',?)"+
			" and i.plant_id like if(?=0,'%%',?)"+
			" and i.product_id is null";
	
	
	

	
	
	
	
    public StockDAOImpl() {
		con=DBUtil.getConnection();
	}
    

	@Override
	public int insertStockDAO(StockBean bean) throws Exception {
		ps=con.prepareStatement(INSERT_INVENTORY_STOCK);
		ps.setInt(1, bean.getInv_item_id());
		ps.setString(2, bean.getDate());
		ps.setDouble(3, bean.getQuantity());
		ps.setInt(4, bean.getPlant_id());
		return ps.executeUpdate();
	}

	@Override
	public int updateStockDAO(StockBean bean) throws Exception {
		ps=con.prepareStatement(UPDATE_INVENTORY_STOCK);
		ps.setDouble(1, bean.getQuantity());
		ps.setInt(3, bean.getPlant_id());
		ps.setString(2, bean.getDate());
		ps.setInt(4, bean.getInv_item_id());
		ps.setInt(5, bean.getStock_id());
		return ps.executeUpdate();
	}

	
	@Override
	public List<Map<String, Object>> getCurrentStock() throws Exception {
		ps=con.prepareStatement(GET_ALL_INVENTORY_ITEM);
		rs=ps.executeQuery();
		List<Map<String,Object>> itemList=new ArrayList<Map<String,Object>>();
		while(rs.next()) {
			Map<String,Object> data=new HashMap<String, Object>();
			data.put("inv_item_id", rs.getInt("inv_item_id"));
			data.put("inventory_name", rs.getString("inventory_name"));
			itemList.add(data);
		}
		return itemList;
	}
	

	@Override
	public List<Map<String, Object>> getAllStockItemList() throws Exception {
		ps=con.prepareStatement(GET_INVENTORY_STOCK_LIST);
		rs=ps.executeQuery();
		List<Map<String,Object>> list=new ArrayList<>();
		while(rs.next()) {
			Map<String,Object> map=new HashMap<>();
			map.put("stk_id", rs.getInt("stk_id"));
			map.put("inv_item_id", rs.getInt("inv_item_id"));
			map.put("effective_date", rs.getString("effective_date"));
			map.put("quantity", rs.getDouble("quantity"));
			map.put("plant_name", rs.getString("plant_name"));
			map.put("inventory_name", rs.getString("inventory_name"));
			list.add(map);
		}
		return list;
	}
	
	@Override
	public int addInventoryOutgoing(InventoryOutgoingBean bean) throws Exception {
		ps=con.prepareStatement(ADD_INVENTORY_OUTGOING);
		ps.setInt(1, bean.getProduct_id());
		ps.setInt(2, bean.getPlant_id());
		ps.setString(3, bean.getDate());
		ps.setString(4, bean.getComment());
		ps.setString(5, bean.getAdded_by());
		ps.setDouble(6, bean.getQuantity());
		ps.setDouble(7, bean.getProduction_cost());
		return ps.executeUpdate();
	}

	
	@Override
	public int updateInventoryOutgoing(InventoryOutgoingBean bean) throws Exception {
		ps=con.prepareStatement(UPDATE_INVENTORY_OUTGOING);
		ps.setInt(1, bean.getProduct_id());
		ps.setInt(2, bean.getPlant_id());
		ps.setString(3, bean.getDate());
		ps.setString(4, bean.getComment());
		ps.setString(5, bean.getAdded_by());
		ps.setDouble(6, bean.getQuantity());
		ps.setDouble(7, bean.getProduction_cost());
		ps.setInt(8, bean.getInvout_id());
		return ps.executeUpdate();
	}
	
	@Override
	public int addInventoryOutgoingForOnlyConsumption(InventoryOutgoingBean bean) throws Exception {
		ps=con.prepareStatement(ADD_INVENTORY_OUTGOING_ONLY_FOR_CONSUMPTION);
		ps.setInt(1, bean.getPlant_id());
		ps.setString(2, bean.getDate());
		ps.setString(3, bean.getComment());
		ps.setString(4, bean.getAdded_by());
		return ps.executeUpdate();
	}
	

	@Override
	public List<Map<String, Object>> getGradeCompositionDetails(int product_id) throws Exception {
		ps=con.prepareStatement(GET_GRADE_COMPOSITION);
		ps.setInt(1, product_id);
		rs=ps.executeQuery();
		List<Map<String,Object>> list=new ArrayList<>();
		while(rs.next()) { 
 			Map<String,Object> map=new HashMap<>();
 			map.put("inv_item_id", rs.getInt("inv_item_id"));
 			map.put("inventory_name", rs.getString("inventory_name"));
 			map.put("quantity", rs.getString("quantity"));
 			list.add(map);
		}
		return list;
	}


	@Override
	public int[] addInventoryOutgoingItem(List<InventoryOutgoingItem> list, int invout_id) throws Exception {
		ps=con.prepareStatement(ADD_INVENTORY_OUTGING_ITEM);
		System.out.println(list);
		for(InventoryOutgoingItem item:list) {
			ps.setInt(1, item.getInv_item_id());
			ps.setDouble(2, item.getQuantity());
			ps.setInt(3, invout_id);
			ps.addBatch();
		}
		int count[]=ps.executeBatch();
		return count;
	}
	
	
	@Override
	public int[] updateInventoryOutogingItem(List<InventoryOutgoingItem> list) throws Exception {
		ps=con.prepareStatement(UPDATE_INVENTORY_OUTGING_ITEM);
		for(InventoryOutgoingItem item:list) {
			ps.setInt(1, item.getInv_item_id());
			ps.setDouble(2, item.getQuantity());
			ps.setInt(3, item.getInvout_item_id());
			ps.addBatch();
		}
		
		int count[]=ps.executeBatch();
		return count;
	}


	@Override
	public int getLastAddedOutgoinId() throws Exception {
		ps=con.prepareStatement(GET_LAST_ADDED_OUTGOING_ITEM);
		rs=ps.executeQuery();
		if(rs.next())
			return rs.getInt(1);
		else
			return 0;
	}


	@Override
	public List<Map<String, Object>> getProductionList(int product_id, String from_date, String to_date,
			int plant_id,int start,int length) throws Exception {
		ps=con.prepareStatement(GET_PRODUCTION_LIST);
		ps.setInt(1, product_id);
		ps.setInt(2, product_id);
		ps.setString(3, from_date);
		ps.setString(4, from_date);
		ps.setString(5, to_date);
		ps.setString(6, to_date);
		ps.setInt(7, plant_id);
		ps.setInt(8, plant_id);
		ps.setInt(9, start);
		ps.setInt(10, length);
		rs=ps.executeQuery();
		List<Map<String,Object>> list=new ArrayList<>();
		while(rs.next()) {
			Map<String,Object> data=new HashMap<>();
			data.put("invout_id", rs.getInt("invout_id"));
			data.put("product_name", rs.getString("product_name"));
			data.put("plant_name", rs.getString("plant_name"));
			data.put("date", rs.getString("date"));
			data.put("added_by", rs.getString("added_by"));
			data.put("comment", rs.getString("comment"));
			data.put("production_cost", rs.
							getDouble("production_cost"));
			data.put("totalquantity", rs.
							getDouble("totalquantity"));
			data.put("quantity", rs.
							getDouble("quantity"));
			list.add(data);
		}
		return list;
	}
	

	@Override
	public int countProductionList(int product_id, String from_date,
					String to_date,int plant_id) throws Exception {
		ps=con.prepareStatement(COUNT_PRODUCTION_LIST);
		ps.setInt(1, product_id);
		ps.setInt(2, product_id);
		ps.setString(3, from_date);
		ps.setString(4, from_date);
		ps.setString(5, to_date);
		ps.setString(6, to_date);
		ps.setInt(7, plant_id);
		ps.setInt(8, plant_id);
		rs=ps.executeQuery();
		if(rs.next())
			return rs.getInt(1);
		else
			return 0;
	}


	@Override
	public int deleteProductionDetails(int invout_id) throws Exception {
		ps=con.prepareStatement(DELETE_PRODUCTION_DETAILS);
		ps.setInt(1, invout_id);
		return ps.executeUpdate();
	}


	@Override
	public List<Map<String, Object>> getDateWiseReportOfProductionReport(String from_date, String to_date,
			int product_id, int plant_id) throws Exception {
		ps=con.prepareStatement(GET_DATE_WISE_PRODUCTION_REPORT);
		ps.setString(1, from_date);
		ps.setString(2, to_date);
		ps.setInt(3, product_id);
		ps.setInt(4, product_id);
		ps.setInt(5, plant_id);
		ps.setInt(6, plant_id);
		rs=ps.executeQuery();
		List<Map<String,Object>> list=new ArrayList<>();
		while(rs.next()) {
			Map<String,Object> data=new HashMap<>();
			data.put("product_name", rs.getString("product_name"));
			data.put("unit_of_measurement", rs.getString("unit_of_measurement"));
			data.put("invout_id", rs.getInt("invout_id"));
			data.put("quantity", rs.getDouble("quantity"));
			data.put("production_cost", rs.getDouble("production_cost"));
			data.put("tquantity", rs.getDouble("tquantity"));
			data.put("plant_name", rs.getString("plant_name"));
			data.put("added_by", rs.getString("added_by"));
			data.put("date", rs.getString("date"));
			list.add(data);
 		}
		return list;
	}

	@Override
	public List<Map<String, Object>> getStockReport(String from_date, String to_date, int product_id, int plant_id)
			throws Exception {
		ps=con.prepareStatement(GET_STOCK_REPORT);
		ps.setString(1, from_date);
		ps.setInt(2, plant_id);
		ps.setString(3, from_date);
		ps.setInt(4, plant_id);
		ps.setString(5, from_date);
		ps.setInt(6, plant_id);
		ps.setString(7,from_date);
		ps.setString(8, to_date);
		ps.setInt(9, plant_id);
		ps.setString(10,from_date);
		ps.setString(11, to_date);
		ps.setInt(12, plant_id);
		ps.setString(13,from_date);
		ps.setString(14, to_date);
		ps.setInt(15, plant_id);
		ps.setString(16,from_date);
		ps.setString(17, to_date);
		ps.setInt(18, plant_id);
		ps.setInt(19,product_id);
		ps.setInt(20, product_id);
		rs=ps.executeQuery();
		List<Map<String,Object>> list=new ArrayList<>();
		while(rs.next()) {
			Map<String,Object> map=new HashMap<>();
			map.put("product_id", rs.getInt("product_id"));
			map.put("product_name", rs.getString("product_name"));
			map.put("unit_of_measurement", rs.getString("unit_of_measurement"));
			map.put("opening_incoming", rs.getDouble("opening_incoming"));
			map.put("opening_outgoing",rs.getDouble("opening_outgoing"));
			map.put("opening_outgoing_gst",rs.getDouble("opening_outgoing_gst"));
			map.put("avg_price", rs.getDouble("avg_price"));
			map.put("total_production", rs.getDouble("total_production"));
			map.put("total_sales", rs.getDouble("total_sales"));
			map.put("total_sales_gst", rs.getDouble("total_sales_gst"));
			list.add(map);
		}
		return list;
	}


	@Override
	public StockBean getSingleOpeningStock(int stock_id) throws Exception {
		ps=con.prepareStatement(GET_SINGLE_OPENING_STOCK_DETAILS);
		ps.setInt(1, stock_id);
		rs=ps.executeQuery();
		StockBean bean=new StockBean();
		if(rs.next()) {
			bean.setStock_id(rs.getInt("stock_id"));
			bean.setDate(rs.getString("date"));
			bean.setPlant_id(rs.getInt("plant_id"));
			bean.setQuantity(rs.getDouble("quantity"));
			bean.setInv_item_id(rs.getInt("inv_item_id"));
		}
		return bean;
	}

	
	@Override
	public int deleteClosingStock(int stock_id) throws Exception {
		ps=con.prepareStatement(DELETE_INVENTORY_STOCK);
		ps.setInt(1, stock_id);
		System.out.println(ps.toString());
		int count=ps.executeUpdate();
		return count;
	}


	@Override
	public List<Map<String, Object>> getInventoryOutgoingList(String from_date, String to_date, int inv_item_id,
			int plant_id, int start, int length) throws Exception {
		ps=con.prepareStatement(GET_INVENTORY_OUTOGING_LIST);
		ps.setString(1, from_date);
		ps.setString(2, from_date);
		ps.setString(3, to_date);
		ps.setString(4, to_date);
		ps.setInt(5, inv_item_id);
		ps.setInt(6, inv_item_id);
		ps.setInt(7, plant_id);
		ps.setInt(8, plant_id);
		ps.setInt(9, start);
		ps.setInt(10, length);
		rs=ps.executeQuery();
		List<Map<String,Object>> list=new ArrayList<>();
		while(rs.next()) {
			Map<String,Object> map=new HashMap<>();
			map.put("invout_id", rs.getInt("invout_id"));
			map.put("date", rs.getString("date"));
			map.put("plant_name", rs.getString("plant_name"));
			map.put("added_by", rs.getString("added_by"));
			map.put("comment", rs.getString("comment"));
			map.put("quantity", rs.getDouble("quantity"));
			map.put("inventory_name", rs.getString("inventory_name"));
			map.put("invout_item_id", rs.getInt("invout_item_id"));
			list.add(map);
		}
		return list;
	}


	@Override
	public int countInventoryOutgoingList(String from_date, String to_date, int inv_item_id, int plant_id)
			throws Exception {
		ps=con.prepareStatement(COUNT_INVENTORY_OUTGOING_LIST);
		ps.setString(1, from_date);
		ps.setString(2, from_date);
		ps.setString(3, to_date);
		ps.setString(4, to_date);
		ps.setInt(5, inv_item_id);
		ps.setInt(6, inv_item_id);
		ps.setInt(7, plant_id);
		ps.setInt(8, plant_id);
		rs=ps.executeQuery();
		if(rs.next()) {
			return rs.getInt(1);
		}
		else
			return 0;
	}


	@Override
	public Map<String, Object> getConversionValueDetails(int product_id) throws Exception {
		ps=con.prepareStatement(GET_CONVERSION_VALUE_DETAILS);
		ps.setInt(1, product_id);
		rs=ps.executeQuery();
		Map<String,Object> data=new HashMap<>();
		if(rs.next()) {
			data.put("conversion_value", rs.getDouble("conversion_value"));
			data.put("isConversionRequired", rs.getBoolean("isConversionRequired"));
		}
		return data;
	}


	


	

	
	
	
}
