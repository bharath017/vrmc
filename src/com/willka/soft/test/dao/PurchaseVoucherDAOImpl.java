package com.willka.soft.test.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import com.willka.soft.test.bean.PurchaseVoucherBean;
import com.willka.soft.test.bean.PurchaseVoucherItemBean;
import com.willka.soft.util.DBUtil;

public  class PurchaseVoucherDAOImpl implements PurchaseVoucherDAO {

	private Connection con=null;
	private PreparedStatement ps=null;
	private ResultSet rs=null;
	private PreparedStatement ps1=null;
	private ResultSet rs1=null;
	
	
	//declare query here
	private static final String INSERT_PURCHASE_VOUCHER="insert into test_purchase_voucher(bill_no,purchase_date,"
			+ "discount_amount,supplier_id,rate_include_tax,round_off,gst_type,plant_id) values(?,?,?,?,?,?,?,?)";
	
	private static final String UPDATE_PURCHASE_VOUCHER="update test_purchase_voucher set bill_no=?,purchase_date=?,discount_amount=?,supplier_id=?,rate_include_tax=?,round_off=?,gst_type=?,plant_id=? where purchase_voucher_id=?";
	
	private static final String CANCEL_PURCHASE_VOUCHER="update test_purchase_voucher set voucher_status='cancelled' where purchase_voucher_id=?";
	
	private static final String ACTIVATE_VOUCHER1="update test_purchase_voucher set voucher_status='active' where purchase_voucher_id=?";
	
	private static final String INSERT_PURCHAES_VOUCHER_ITEM="insert into test_purchase_voucher_item(purchase_voucher_id,item_name,item_quantity,item_price,gst_percent,gross_amount,tax_amount,net_amount) values(?,?,?,?,?,?,?,?)";
	
	private static final String UPDATE_PURCHASE_VOUCHER_ITEM="update test_purchase_voucher_item set item_name=?,item_quantity=?,item_price=?,gst_percent=?,gross_amount=?,tax_amount=?,net_amount=? where pvi_id=?";
	
	private static final String DELETE_PURCHASE_VOUCHER_ITEM="delete from test_purchase_voucher_item set pvi_id=?";
	
	private static final String GET_MAX_VOUCHER_ID="select max(purchase_voucher_id) from test_purchase_voucher";
	
	private static final String GET_PURCHASE_VOUCHER_LIST="select p.purchase_voucher_id,"
			+ " (select plant_name from plant where plant_id=p.plant_id) as plant_name,"
			+ " p.bill_no,p.voucher_status,p.discount_amount,p.gst_type,s.supplier_name,DATE_FORMAT(p.purchase_date,'%d/%m/%Y') as purchase_date,"
			+ " p.round_off,p.rate_include_tax "
			+ " from test_purchase_voucher p,test_supplier s where p.supplier_id=s.supplier_id"
			+ " and p.bill_no like ?"
			+ " and p.supplier_id like if(0=?,'%%',?)"
			+ " and p.purchase_date between if(''=?,'2014-01-01',?) and if(''=?,'2088-01-01',?)"
			+ " and s.business_id like if(?=0,'%%',?)"
			+ " order by purchase_voucher_id desc"
			+ " limit ?,?";
	
	private static final String COUNT_PURCHASE_VOUCHER="select count(purchase_voucher_id)"
			+ " from test_purchase_voucher p,test_supplier s where p.supplier_id=s.supplier_id"
			+ " and p.bill_no like ?"
			+ " and p.supplier_id like if(0=?,'%%',?)"
			+ " and p.purchase_date between if(''=?,'2014-01-01',?) and if(''=?,'2088-01-01',?)"
			+ " and s.business_id like if(?=0,'%%',?)"
			+ " order by purchase_voucher_id desc";
	
	
	private static final String GET_PURCHASE_VOUCHER_ITEM="select item_name,item_quantity,item_price,net_amount"
			+ " from test_purchase_voucher_item"
			+ " where purchase_voucher_id=?";
	private static final String DELETE_VOUCHER = "delete from test_purchase_voucher where purchase_voucher_id=?";
	private static final String ACTIVATE_VOUCHER = null;
	
	
	
	
	public PurchaseVoucherDAOImpl() {
		con=DBUtil.getConnection();
	}
	@Override
	public int insertPurchaseVoucher(PurchaseVoucherBean bean) throws Exception {
		ps=con.prepareStatement(INSERT_PURCHASE_VOUCHER);
		ps.setString(1, bean.getBill_no());
		ps.setString(2, bean.getPurhcase_date());
		ps.setDouble(3, bean.getDiscount_amount());
		ps.setInt(4, bean.getSupplier_id());
		ps.setString(5, bean.getRate_include_tax());
		ps.setDouble(6, bean.getRound_off());
		ps.setString(7, bean.getGst_type());
		ps.setInt(8, bean.getPlant_id());
		int count=ps.executeUpdate();
		return count;
	}

	@Override
	public int updatePurchaseVoucher(PurchaseVoucherBean bean) throws Exception {
		ps=con.prepareStatement(UPDATE_PURCHASE_VOUCHER);
		ps.setString(1, bean.getBill_no());
		ps.setString(2, bean.getPurhcase_date());
		ps.setDouble(3, bean.getDiscount_amount());
		ps.setInt(4, bean.getSupplier_id());
		ps.setString(5, bean.getRate_include_tax());
		ps.setDouble(6, bean.getRound_off());
		ps.setString(7, bean.getGst_type());
		ps.setInt(8, bean.getPlant_id());
		ps.setInt(9, bean.getPurchase_voucher_id());
		int count=ps.executeUpdate();
		return count;
	}

	@Override
	public int changePurchaseVoucherStatus(int purchase_voucher_id, String voucher_status) throws Exception {
		ps=con.prepareStatement(CANCEL_PURCHASE_VOUCHER);
		ps.setInt(1, purchase_voucher_id);
		int count=ps.executeUpdate();
		return count;
	}

	@Override
	public int insertPurchaseVoucherItem(PurchaseVoucherItemBean bean) throws Exception {
		ps=con.prepareStatement(INSERT_PURCHAES_VOUCHER_ITEM);
		ps.setInt(1, bean.getPurchase_voucher_id());
		ps.setString(2, bean.getItem_name());
		ps.setDouble(3, bean.getItem_quantity());
		ps.setDouble(4, bean.getItem_price());
		ps.setFloat(5, bean.getGst_percent());
		ps.setDouble(6, bean.getGross_amount());
		ps.setDouble(7, bean.getTax_amount());
		ps.setDouble(8, bean.getNet_amount());
		int count=ps.executeUpdate();
		return count;
	}

	@Override
	public int updatePurchaseVoucherItem(PurchaseVoucherItemBean bean) throws Exception {
		ps=con.prepareStatement(UPDATE_PURCHASE_VOUCHER_ITEM);
		ps.setString(1, bean.getItem_name());
		ps.setDouble(2, bean.getItem_quantity());
		ps.setDouble(3, bean.getItem_price());
		ps.setFloat(4, bean.getGst_percent());
		ps.setDouble(5, bean.getGross_amount());
		ps.setDouble(6, bean.getTax_amount());
		ps.setDouble(7, bean.getNet_amount());
		ps.setInt(8, bean.getPvi_id());
		int count=ps.executeUpdate();
		return count;
	}

	@Override
	public int deletePurchaseVoucherItem(int pvi_id) throws Exception {
		ps=con.prepareStatement(DELETE_PURCHASE_VOUCHER_ITEM);
		ps.setInt(1, pvi_id);
		int count=ps.executeUpdate();
		return count;
	}
	@Override
	public int getMaxPurchaseVoucherId() throws Exception {
		ps=con.prepareStatement(GET_MAX_VOUCHER_ID);
		rs=ps.executeQuery();
		if(rs.next()) {
			return rs.getInt(1);
		}else {
			return 0;
		}
	}
	@Override
	public ArrayList<HashMap<String, Object>> getPurchaseVoucherList(String bill_no, String from_date, String to_date,
			int supplier_id, int business_id, int start, int length) throws Exception {
		ps=con.prepareStatement(GET_PURCHASE_VOUCHER_LIST);
		ps1=con.prepareStatement(GET_PURCHASE_VOUCHER_ITEM);
		ps.setString(1, "%"+bill_no+"%");
		ps.setInt(2, supplier_id);
		ps.setInt(3, supplier_id);
		ps.setString(4, from_date);
		ps.setString(5, from_date);
		ps.setString(6, to_date);
		ps.setString(7, to_date);
		ps.setInt(8, business_id);
		ps.setInt(9, business_id);
		ps.setInt(10, start);
		ps.setInt(11, length);
		rs=ps.executeQuery();
		ArrayList<HashMap<String, Object>> list=new ArrayList<HashMap<String,Object>>();
		while(rs.next()) {
			HashMap<String, Object> map=new HashMap<String, Object>();
			map.put("bill_no", rs.getString("bill_no"));
			map.put("purchase_voucher_id", rs.getInt("purchase_voucher_id"));
			map.put("supplier_name", rs.getString("supplier_name"));
			map.put("purchase_date", rs.getString("purchase_date"));
			map.put("round_off", rs.getString("round_off"));
			map.put("rate_include_tax", rs.getString("rate_include_tax"));
			map.put("voucher_status", rs.getString("voucher_status"));
			map.put("gst_type", rs.getString("gst_type"));
			map.put("plant_name", rs.getString("plant_name"));
			map.put("discount_amount",rs.getDouble("discount_amount"));
			//get item details here
			ps1.setInt(1, rs.getInt("purchase_voucher_id"));
			rs1=ps1.executeQuery();
			ArrayList<HashMap<String, Object>> itemlist=new ArrayList<HashMap<String,Object>>();
			while(rs1.next()) {
				HashMap<String, Object> item=new HashMap<String, Object>();
				item.put("item_name", rs1.getString("item_name"));
				item.put("item_quantity", rs1.getDouble("item_quantity"));
				item.put("item_price", rs1.getDouble("item_price"));
				item.put("net_amount", rs1.getDouble("net_amount"));
				itemlist.add(item);
			}
			map.put("itemlist", itemlist);
			
			list.add(map);
		}
		return list;
	}
	@Override
	public int countPurchaseVoucherList(String bill_no, String from_date, String to_date, int supplier_id, int business_id)
			throws Exception {
		ps=con.prepareStatement(COUNT_PURCHASE_VOUCHER);
		ps.setString(1, "%"+bill_no+"%");
		ps.setInt(2, supplier_id);
		ps.setInt(3, supplier_id);
		ps.setString(4, from_date);
		ps.setString(5, from_date);
		ps.setString(6, to_date);
		ps.setString(7, to_date);
		ps.setInt(8, business_id);
		ps.setInt(9, business_id);
		rs=ps.executeQuery();
		if(rs.next())
			return rs.getInt(1);
		else
			return 0;
	}
	@Override
	public int DeletePurchaseVoucher(int purchase_voucher_id) throws Exception {
		ps=con.prepareStatement(DELETE_VOUCHER);
		ps.setInt(1, purchase_voucher_id);
		int count=ps.executeUpdate();
		return count;
	}
	@Override
	public int activatePurchaseVoucherStatus(int purchase_voucher_id, String string) throws Exception {
		ps=con.prepareStatement(ACTIVATE_VOUCHER1);
		ps.setInt(1, purchase_voucher_id);
		int count=ps.executeUpdate();
		return count;
	}

}
