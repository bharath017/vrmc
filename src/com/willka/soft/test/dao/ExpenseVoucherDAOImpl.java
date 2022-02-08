package com.willka.soft.test.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.willka.soft.test.bean.ExpenseVoucherBean;
import com.willka.soft.test.bean.ExpenseVoucherItemBean;
import com.willka.soft.util.DBUtil;

public class ExpenseVoucherDAOImpl implements ExpenseVoucherDAO{

	private Connection con=null;
	private PreparedStatement ps=null;
	private ResultSet rs=null;
	private PreparedStatement ps1=null;
	private ResultSet rs1=null;
	
	
	
	private static final String INSERT_EXPENSE_QUERY="insert into test_expense_voucher(bill_no,bill_date"
			+ ",tds_amount,plant_id,remark,supplier_id,category_type,gst_category,rate_include_tax)"
			+ " values(?,?,?,?,?,?,?,?,?)";
	
	private static final String UPDATE_QUERY="update test_expense_voucher set bill_no=?,bill_date=?,"
			+ " tds_amount=?,plant_id=?,remark=?,supplier_id=?,category_type=?,gst_category=?,rate_include_tax=?"
			+ " where expense_voucher_id=?";
	
	private static final String CANCEL_VOUCHER="update test_expense_voucher set  voucher_status='cancelled' where expense_voucher_id=?";
	
	private static final String INSERT_VOUCHER_ITEM="insert into test_expense_voucher_item(expense_voucher_id,"
			+ "item_name,item_quantity,item_price,gst_percent,gross_amount,tax_amount,net_amount,category_id) values(?,?,?,?,?,?,?,?,?)";
	
	private static final String UPDATE_VOUCHER_ITEM="update test_expense_voucher_item set  item_name=?,"
			+ "item_quantity=?,item_price=?,gst_percent=?,gross_amount=?,tax_amount=?,net_amount=?,category_id=? where evi_id=?";
	
	private static final String DELETE_VOUCHER_ITEM="delete from test_purchase_voucher_item where pvi_id=?";
	
	private static final String GET_MAX_ID="select max(expense_voucher_id) from test_expense_voucher";
	
	private static final String INSERT_EXPENSE_CATEGORY="insert into expense_category(category_name,"
			+ "category_type,category_description) values(?,?,?)";
	
	private static final String UPDATE_EXPENSE_CATEGORY="update expense_category set category_name=?,"
			+ "category_type=?,category_description=? where category_id=?";
	
	private static final String DELETE_EXPENSE_CATEGORY="delete from expense_category where category_id=?";
	
	private static final String GET_EXPENSE_CATEGORY_LIST="select * from expense_category"
			+ " where (category_name like ? or category_type like ?) order by category_id desc limit ?,?";
	
	private static final String COUNT_EXPENSE_CATEGORY_LIST="select count(category_id) from expense_category"
			+ " where (category_name like ? or category_type like ?)";
	
	private static final String GET_SINGLE_CATEGORY_DETAILS="select * from expense_category where category_id=?";
	
	private static final String GET_CATEGORY_LIST_BY_TYPE="select category_id,category_name from expense_category where category_type=?";
	
	private static final String GET_EXPENSE_VOUCHER_LIST="select p.expense_voucher_id,"
			+ " (select plant_name from plant where plant_id=p.plant_id) as plant_name,"
			+ " p.bill_no,p.voucher_status,p.gst_category,s.supplier_name,DATE_FORMAT(p.bill_date,'%d/%m/%Y') as purchase_date,"
			+ " p.rate_include_tax "
			+ " from test_expense_voucher p,test_supplier s where p.supplier_id=s.supplier_id"
			+ " and p.bill_no like ?"
			+ " and p.supplier_id like if(0=?,'%%',?)"
			+ " and p.bill_date between if(''=?,'2014-01-01',?) and if(''=?,'2088-01-01',?)"
			+ " and s.business_id like if(?=0,'%%',?)"
			+ " order by expense_voucher_id desc"
			+ " limit ?,?";
	
	private static final String COUNT_EXPENSE_VOUCHER="select count(expense_voucher_id)"
			+ " from test_expense_voucher p,test_supplier s where p.supplier_id=s.supplier_id"
			+ " and p.bill_no like ?"
			+ " and p.supplier_id like if(0=?,'%%',?)"
			+ " and p.bill_date between if(''=?,'2014-01-01',?) and if(''=?,'2088-01-01',?)"
			+ " and s.business_id like if(?=0,'%%',?)"
			+ " order by expense_voucher_id desc";
	
	private static final String GET_EXPENSE_VOUCHER_ITEM="select item_name,item_quantity,item_price,net_amount"
			+ " from test_expense_voucher_item"
			+ " where expense_voucher_id=?";
	
	private static final String DELETE_EXPENSE_VOUCHER="delete from test_expense_voucher where expense_voucher_id=?";
	
	private static final String GET_DASHBOARD="select (select sum(net_amount) from test_expense_voucher ex,test_expense_voucher_item exi "+
			" where ex.expense_voucher_id=exi.expense_voucher_id"+
			" and ex.bill_date between  DATE_SUB( LAST_DAY( DATE_ADD(NOW(), INTERVAL -1 MONTH) ), INTERVAL DAY( LAST_DAY( DATE_ADD(NOW(), INTERVAL -1 MONTH) ) )-1 DAY ) and  LAST_DAY( DATE_ADD(NOW(), INTERVAL -1 MONTH) ) and voucher_status='active') as lastmonth,"+
			" (select sum(net_amount) from test_expense_voucher ex,test_expense_voucher_item exi "+
			" where ex.expense_voucher_id=exi.expense_voucher_id"+
			" and ex.bill_date between  DATE_SUB( LAST_DAY( DATE_ADD(NOW(), INTERVAL 0 MONTH) ), INTERVAL DAY( LAST_DAY( DATE_ADD(NOW(), INTERVAL 0 MONTH) ) )-1 DAY )  and  LAST_DAY( DATE_ADD(NOW(), INTERVAL 0 MONTH) ) and voucher_status='active') as thismonth,"+
			" (select count(expense_voucher_id) from test_expense_voucher where bill_date=curdate() and voucher_status='active') as today";
	
	private static final String GET_EXPENSE_CATEGORY_TYPE="select category_type from expense_category_type";
	
	
	public ExpenseVoucherDAOImpl() {
		con=DBUtil.getConnection();
	}
	
	@Override
	public int insertExpenseVoucher(ExpenseVoucherBean bean) throws Exception {
		ps=con.prepareStatement(INSERT_EXPENSE_QUERY);
		ps.setString(1, bean.getBill_no());
		ps.setString(2, bean.getBill_date());
		ps.setDouble(3, bean.getTds_amount());
		ps.setInt(4, bean.getPlant_id());
		ps.setString(5, bean.getRemark());
		ps.setInt(6, bean.getSupplier_id());
		ps.setString(7, bean.getCategory_type());
		ps.setString(8, bean.getGst_category());
		ps.setBoolean(9, bean.isRate_include_tax());
		int count=ps.executeUpdate();
		return count;
	}
	
	@Override
	public int updateExpenseVoucher(ExpenseVoucherBean bean) throws Exception {
		ps=con.prepareStatement(UPDATE_QUERY);
		ps.setString(1, bean.getBill_no());
		ps.setString(2, bean.getBill_date());
		ps.setDouble(3, bean.getTds_amount());
		ps.setInt(4, bean.getPlant_id());
		ps.setString(5, bean.getRemark());
		ps.setInt(6, bean.getSupplier_id());
		ps.setString(7, bean.getCategory_type());
		ps.setString(8, bean.getGst_category());
		ps.setBoolean(9, bean.isRate_include_tax());
		ps.setInt(10,bean.getExpense_voucher_id());
		int count=ps.executeUpdate();
		return count;
	}

	@Override
	public int cancelExpenseVoucher(int expense_voucher_id) throws Exception {
		ps=con.prepareStatement(CANCEL_VOUCHER);
		ps.setInt(1, expense_voucher_id);
		int count=ps.executeUpdate();
		return count;
	}

	@Override
	public int getMaxExpenseVoucher() throws Exception {
		ps=con.prepareStatement(GET_MAX_ID);
		rs=ps.executeQuery();
		if(rs.next()){
			return rs.getInt(1);
		}else{
			return 0;
		}
	}

	@Override
	public int insertExpenseVoucherItem(ExpenseVoucherItemBean bean) throws Exception {
		ps=con.prepareStatement(INSERT_VOUCHER_ITEM);
		ps.setInt(1, bean.getExpense_voucher_id());
		ps.setString(2, bean.getItem_name());
		ps.setDouble(3, bean.getItem_quantity());
		ps.setDouble(4, bean.getItem_price());
		ps.setFloat(5, bean.getGst_percent());
		ps.setDouble(6, bean.getGross_amount());
		ps.setDouble(7, bean.getTax_amount());
		ps.setDouble(8, bean.getNet_amount());
		ps.setInt(9, bean.getCategory_id());
		int count=ps.executeUpdate();
		return count;
	}

	@Override
	public int updateExpenseVoucherItem(ExpenseVoucherItemBean bean) throws Exception {
		ps=con.prepareStatement(UPDATE_VOUCHER_ITEM);
		ps.setString(1, bean.getItem_name());
		ps.setDouble(2, bean.getItem_quantity());
		ps.setDouble(3, bean.getItem_price());
		ps.setFloat(4, bean.getGst_percent());
		ps.setDouble(5, bean.getGross_amount());
		ps.setDouble(6, bean.getTax_amount());
		ps.setDouble(7, bean.getNet_amount());
		ps.setInt(8, bean.getCategory_id());
		ps.setInt(9, bean.getEvi_id());
		int count=ps.executeUpdate();
		return count;
	}

	@Override
	public int deleteExpenseVoucherItm(int evi_id) throws Exception {
		ps=con.prepareStatement(DELETE_VOUCHER_ITEM);
		ps.setInt(1, evi_id);
		int count=ps.executeUpdate();
		return count;
	}
	
	
	@Override
	public int insertExpenseCategory(String category_name, String category_type, String category_description)
			throws Exception {
		ps=con.prepareStatement(INSERT_EXPENSE_CATEGORY);
		ps.setString(1, category_name);
		ps.setString(2, category_type);
		ps.setString(3, category_description);
		int count=ps.executeUpdate();
		return count;
	}
	@Override
	public int updateExpenseCategory(int category_id, String category_name, String category_type,
			String category_description) throws Exception {
		ps=con.prepareStatement(UPDATE_EXPENSE_CATEGORY);
		ps.setString(1, category_name);
		ps.setString(2, category_type);
		ps.setString(3, category_description);
		ps.setInt(4, category_id);
		int count=ps.executeUpdate();
		return count;
	}
	
	@Override
	public int deleteExpenseCategory(int category_id) throws Exception {
		ps=con.prepareStatement(DELETE_EXPENSE_CATEGORY);
		ps.setInt(1, category_id);
		int count=ps.executeUpdate();
		return count;
	}
	
	@Override
	public List<Map<String, Object>> getExpenseCategoryList(String search, int start, int length) throws Exception {
		ps=con.prepareStatement(GET_EXPENSE_CATEGORY_LIST);
		ps.setString(1, "%"+search+"%");
		ps.setString(2, "%"+search+"%");
		ps.setInt(3, start);
		ps.setInt(4, length);
		rs=ps.executeQuery();
		List<Map<String,Object>> list=new ArrayList<Map<String,Object>>();
		while(rs.next()) {
			Map<String,Object> map=new HashMap<String, Object>();
			map.put("category_id", rs.getInt("category_id"));
			map.put("category_name", rs.getString("category_name"));
			map.put("category_description", rs.getString("category_description"));
			map.put("category_type", rs.getString("category_type"));
			list.add(map);
		}
		return list;
	}
	
	@Override
	public int countExpenseCategoryList(String search) throws Exception {
		ps=con.prepareStatement(COUNT_EXPENSE_CATEGORY_LIST);
		ps.setString(1, "%"+search+"%");
		ps.setString(2, "%"+search+"%");
		rs=ps.executeQuery();
		if(rs.next())
			return rs.getInt(1);
		else
			return 0;
	}
	
	@Override
	public Map<String, Object> getSingleCategory(int category_id) throws Exception {
		ps=con.prepareStatement(GET_SINGLE_CATEGORY_DETAILS);
		ps.setInt(1, category_id);
		rs=ps.executeQuery();
		Map<String,Object> map=new HashMap<>();
		if(rs.next()) {
			map.put("category_id", rs.getInt("category_id"));
			map.put("category_name", rs.getString("category_name"));
			map.put("category_type", rs.getString("category_type"));
			map.put("category_description", rs.getString("category_description"));
		}
		return map;
	}
	@Override
	public List<Map<String, Object>> getCategoryListById(String category_type) throws Exception {
		ps=con.prepareStatement(GET_CATEGORY_LIST_BY_TYPE);
		ps.setString(1, category_type);
		rs=ps.executeQuery();
		List<Map<String,Object>> list=new ArrayList<>();
		while(rs.next()) {
			Map<String,Object> data=new HashMap<>();
			data.put("category_id", rs.getInt("category_id"));
			data.put("category_name", rs.getString("category_name"));
			list.add(data);
		}
		return list;
	}
	
	@Override
	public ArrayList<HashMap<String, Object>> getExpenseVoucherList(String bill_no, String from_date, String to_date,
			int supplier_id, int business_id, int start, int length) throws Exception {
		ps=con.prepareStatement(GET_EXPENSE_VOUCHER_LIST);
		ps1=con.prepareStatement(GET_EXPENSE_VOUCHER_ITEM);
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
			map.put("expense_voucher_id", rs.getInt("expense_voucher_id"));
			map.put("supplier_name", rs.getString("supplier_name"));
			map.put("purchase_date", rs.getString("purchase_date"));
			map.put("rate_include_tax", rs.getString("rate_include_tax"));
			map.put("voucher_status", rs.getString("voucher_status"));
			map.put("gst_type", rs.getString("gst_category"));
			map.put("plant_name", rs.getString("plant_name"));
			//get item details here
			ps1.setInt(1, rs.getInt("expense_voucher_id"));
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
	public int countExpenseVoucherList(String bill_no, String from_date, String to_date, int supplier_id, int business_id)
			throws Exception {
		ps=con.prepareStatement(COUNT_EXPENSE_VOUCHER);
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
	public int deleteExpenseVoucher(int expense_voucher_id) throws Exception {
		ps=con.prepareStatement(DELETE_EXPENSE_VOUCHER);
		ps.setInt(1, expense_voucher_id);
		int count=ps.executeUpdate();
		return count;
	}

	@Override
	public Map<String, Object> getExpenseVoucherDashboard() throws Exception {
		ps=con.prepareStatement(GET_DASHBOARD);
		rs=ps.executeQuery();
		Map<String,Object> data=new HashMap<>();
		if(rs.next()) {
			data.put("lastmonth", rs.getDouble("lastmonth"));
			data.put("thismonth", rs.getDouble("thismonth"));
			data.put("today", rs.getInt("today"));
		}
		return data;
	}

	@Override
	public List<String> getExpenseCategoryType() throws Exception {
		ps=con.prepareStatement(GET_EXPENSE_CATEGORY_TYPE);
		rs=ps.executeQuery();
		List<String> data=new ArrayList<>();
		while(rs.next())
			data.add(rs.getString(1));
		return data;
	}

	
}
