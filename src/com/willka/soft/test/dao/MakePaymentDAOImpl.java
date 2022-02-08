package com.willka.soft.test.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.willka.soft.test.bean.MakePaymentBean;
import com.willka.soft.util.DBUtil;

public class MakePaymentDAOImpl implements MakePaymentDAO {
	
	private Connection con=null;
	private ResultSet rs=null;
	private PreparedStatement ps=null;
	
	private static final String GET_CREDIT_BALANCE="select (select sum(net_amount) from test_purchase_voucher p,test_purchase_voucher_item pi where p.purchase_voucher_id=pi.purchase_voucher_id and p.supplier_id=?) as total_purchase,"
			+ " (select sum(payment_amount) from test_make_payment where supplier_id=?) as total_payment";
	
	private static final String INSET_QUERY="insert into test_make_payment(payment_amount,payment_date,"
			+ "payment_time,payment_mode,check_dd_no,check_dd_validity,payment_details,"
			+ "supplier_id,remark,bank_detail_id,category_id) values(?,?,?,?,?,?,?,?,?,?,?)";
	
	private static final String UPDATE_QUERY="update  test_make_payment set  payment_amount=?,payment_date=?,payment_time=?,payment_mode=?,check_dd_no=?,check_dd_validity=?,payment_details=?,supplier_id=?,remark=?,bank_detail_id=? where payment_id=?";
	
	private static final String DELETE_QUERY="delete from test_make_payment where payment_id=?";
	
	private static final String GET_SINGLE_MAKE_PAYMENT="select * from test_make_payment where payment_id=?";
	
	private static final String INSERT_MAKE_PAYMENT_MODIFICATION="insert into test_make_payment_modification(payment_id,payment_date,"
			+ "payment_time,payment_amount,new_modified_amount,payment_mode,check_dd_no,"
			+ "check_dd_validity,comment,modification_user,modification_type) values(?,?,?,?,"
			+ "?,?,?,?,?,?,?)";
	
	private static final String GET_MAKE_PAYMENT_LIST="select m.*,s.supplier_name"
			+ " ,DATE_FORMAT(m.payment_date,'%d/%m/%Y') as realdate,b.bank_name"
			+ " from test_make_payment m,test_supplier s,bank_detail b"
			+ " where m.supplier_id=s.supplier_id "
			+ " and m.bank_detail_id=b.bank_detail_id"
			+ " and m.payment_date between if(''=?,'2014-01-01',?) and if(''=?,'2088-01-01',?) "
			+ " and m.supplier_id like if(0=?,'%%',?) "
			+ " and m.payment_id like if(''=?,'%%',?)"
			+ " and s.business_id like if(?=0,'%%',?)"
			+ " order by payment_id desc "
			+ " limit ?,?";
	
	private static final String COUNT_MAKE_PAYMENT_LIST="select COUNT(m.payment_id)"
			+ " from test_make_payment m, test_supplier s"
			+ " where m.supplier_id =s.supplier_id "
			+ " and m.payment_date between if(''=?,'2014-01-01',?) and if(''=?,'2088-01-01',?) "
			+ " and m.supplier_id like if(0=?,'%%',?) "
			+ " and m.payment_id like if(''=?,'%%',?)"
			+ " and s.business_id like if(''=?,'%%',?)"
			+ " order by payment_id desc";
	
	
	
	private static final String INSERT_PETTY_CASH="insert into petty_cash(plant_id,cash_amount,date,added_by,received_person,purpose,approved_by,card_detail) values(?,?,?,?,?,?,?,?);";
	
	private static final String UPDATE_PETTY_CASH="update petty_cash set plant_id=?,cash_amount=?,date=?,added_by=?,received_person=?,purpose=?,approved_by=?,card_detail=? where cash_id=?";
	
	private static final String DELETE_PETTY_CASH="delete from petty_cash where cash_id=?";
	
	private static final String GET_REMAING_BALANCE="select truncate((select sum(cash_amount) from petty_cash where plant_id=?)-(select sum(item_price*item_quantity) from expense_voucher e,expense_voucher_item ei where e.expense_voucher_id=ei.expense_voucher_id and e.plant_id=?),2) as old_balance";
	
	//report part
	
	private static final String GET_DATE_WISE_REPORT="select p.payment_id,p.payment_amount,DATE_FORMAT(p.payment_date,'%d/%m/%Y') as payment_date,"+
			" p.payment_mode,p.check_dd_no,p.check_dd_validity,s.supplier_name,b.bank_name,p.remark"+
			" from test_make_payment p LEFT JOIN (test_supplier s,bank_detail b)"+
			" ON p.supplier_id=s.supplier_id"+
			" and p.bank_detail_id=b.bank_detail_id"+
			" where s.business_id like if(?=0,'%%',?)"+
			" and p.payment_date between ? and ?"+
			" order by payment_id asc";
	
	private static final String GET_SUPPLIER_WISE_REPORT="select p.payment_id,p.payment_amount,DATE_FORMAT(p.payment_date,'%d/%m/%Y') as payment_date,"+
			" p.payment_mode,p.check_dd_no,p.check_dd_validity,s.supplier_name,b.bank_name,p.remark"+
			" from test_make_payment p LEFT JOIN (test_supplier s,bank_detail b)"+
			" ON p.supplier_id=s.supplier_id"+
			" and p.bank_detail_id=b.bank_detail_id"+
			" where s.business_id like if(?=0,'%%',?)"+
			" and p.supplier_id=?"+
			" order by payment_id asc";
	
	private static final String GET_SUPPLIER_WITH_DATE_WISE_REPORT="select p.payment_id,p.payment_amount,DATE_FORMAT(p.payment_date,'%d/%m/%Y') as payment_date,"+
			" p.payment_mode,p.check_dd_no,p.check_dd_validity,s.supplier_id,s.supplier_name,b.bank_name,p.remark"+
			" from test_make_payment p LEFT JOIN (test_supplier s,bank_detail b)"+
			" ON p.supplier_id=s.supplier_id"+
			" and p.bank_detail_id=b.bank_detail_id"+
			" where s.business_id like if(?=0,'%%',?)"+
			" and p.payment_date between ? and ?"+
			" and p.supplier_id like if(?=0,'%%',?)"+
			" order by s.supplier_name,s.supplier_id,payment_id asc";
	
	
	
	private static final String GET_TRANSACTION_PURCHASE_PAYMENT="select supplier_name,(select sum(net_amount) from test_purchase_voucher_item pvi,test_purchase_voucher pv"+
			 " where pv.purchase_voucher_id=pvi.purchase_voucher_id and pv.voucher_status='active'"+
			 " and pv.supplier_id=s.supplier_id and pv.purchase_date between ? and ?) as totalPurchase,"+
			 " (select sum(payment_amount) from test_make_payment where supplier_id=s.supplier_id and payment_date between ? and ?) as totalPaid"+
			 " from test_supplier s"+
			 " where s.business_id like if(?=0,'%%',?)";

	
	public MakePaymentDAOImpl() {
		con=DBUtil.getConnection();
	}

	@Override
	public int insertMakePayment(MakePaymentBean bean) throws Exception {
		ps=con.prepareStatement(INSET_QUERY);
		ps.setDouble(1, bean.getPayment_amount());
		ps.setString(2, bean.getPayment_date());
		ps.setString(3, bean.getPayment_time());
		ps.setString(4, bean.getPayment_mode());
		ps.setString(5, bean.getCheck_dd_no());
		ps.setString(6, bean.getCheck_dd_validity());
		ps.setString(7, bean.getPayment_details());
		ps.setInt(8, bean.getSupplier_id());
		ps.setString(9, bean.getRemark());
		ps.setInt(10, bean.getBank_detail_id());
		ps.setInt(11, bean.getCategory_id());
		int count=ps.executeUpdate();
		return count;
	}

	@Override
	public int updateMakePayment(MakePaymentBean bean) throws Exception {
		ps=con.prepareStatement(UPDATE_QUERY);
		ps.setDouble(1, bean.getPayment_amount());
		ps.setString(2, bean.getPayment_date());
		ps.setString(3, bean.getPayment_time());
		ps.setString(4, bean.getPayment_mode());
		ps.setString(5, bean.getCheck_dd_no());
		ps.setString(6, bean.getCheck_dd_validity());
		ps.setString(7, bean.getPayment_details());
		ps.setInt(8, bean.getSupplier_id());
		ps.setString(9, bean.getRemark());
		ps.setInt(10, bean.getBank_detail_id());
		ps.setInt(11, bean.getPayment_id());
		int count=ps.executeUpdate();
		return count;
	}

	@Override
	public int deleteMakePayment(int payment_id) throws Exception {
		ps=con.prepareStatement(DELETE_QUERY);
		ps.setInt(1, payment_id);
		int count=ps.executeUpdate();
		return count;
	}

	@Override
	public MakePaymentBean getSingleMakePayment(int payment_id) throws Exception {
		ps=con.prepareStatement(GET_SINGLE_MAKE_PAYMENT);
		ps.setInt(1, payment_id);
		rs=ps.executeQuery();
		if(rs.next()){
			MakePaymentBean bean=new MakePaymentBean();
			bean.setPayment_id(rs.getInt("payment_id"));
			bean.setPayment_date(rs.getString("payment_date"));
			bean.setPayment_time(rs.getString("payment_time"));
			bean.setPayment_amount(rs.getDouble("payment_amount"));
			bean.setPayment_mode(rs.getString("payment_mode"));
			bean.setCheck_dd_no(rs.getString("check_dd_no"));
			bean.setCheck_dd_validity(rs.getString("check_dd_validity"));
			return bean;
		}else{
			return null;
		}
	}

	@Override
	public int insertMakePaymentModification(MakePaymentBean bean) throws Exception {
		ps=con.prepareStatement(INSERT_MAKE_PAYMENT_MODIFICATION);
		ps.setInt(1, bean.getPayment_id());
		ps.setString(2, bean.getPayment_date());
		ps.setString(3, bean.getPayment_time());
		ps.setDouble(4, bean.getPayment_amount());
		ps.setDouble(5, bean.getNew_modified_amount());
		ps.setString(6, bean.getPayment_mode());
		ps.setString(7, bean.getCheck_dd_no());
		ps.setString(8, bean.getCheck_dd_validity());
		ps.setString(9, bean.getComment());
		ps.setString(10, bean.getModification_user());
		ps.setString(11, bean.getModification_type());
		int count=ps.executeUpdate();
		return count;
	}

	@Override
	public HashMap<String, Double> getCreditBalance(int supplier_id) throws Exception {
		ps=con.prepareStatement(GET_CREDIT_BALANCE);
		ps.setInt(1, supplier_id);
		ps.setInt(2, supplier_id);
		rs=ps.executeQuery();
		if(rs.next()) {
			HashMap<String, Double> myval=new HashMap<>();
			myval.put("total_purchase", rs.getDouble(1));
			myval.put("total_payment", rs.getDouble(2));
			return myval;
		}
		else
			return null;
	}

	@Override
	public ArrayList<HashMap<String, Object>> getAllMakePaymentList(String from_date, String to_date, String payment_id,
			int supplier_id, int business_id, int start, int length) throws Exception {
		ps=con.prepareStatement(GET_MAKE_PAYMENT_LIST);
		ps.setString(1, from_date);
		ps.setString(2, from_date);
		ps.setString(3, to_date);
		ps.setString(4, to_date);
		ps.setInt(5, supplier_id);
		ps.setInt(6, supplier_id);
		ps.setString(7, payment_id);
		ps.setString(8, payment_id);
		ps.setInt(9, business_id);
		ps.setInt(10, business_id);
		ps.setInt(11, start);
		ps.setInt(12, length);
		System.out.println(ps.toString());
		rs=ps.executeQuery();
		ArrayList<HashMap<String, Object>> list=new ArrayList<HashMap<String,Object>>();
		while(rs.next()) {
			HashMap<String,Object> map=new HashMap<String, Object>();
			map.put("payment_id", rs.getInt("payment_id"));
			map.put("payment_amount", rs.getDouble("payment_amount"));
			map.put("payment_date", rs.getString("realdate"));
			map.put("payment_time", rs.getString("payment_time"));
			map.put("payment_mode", rs.getString("payment_mode"));
			map.put("mode_no", rs.getString("check_dd_no")==null?"":rs.getString("check_dd_no"));
			map.put("bank_name", rs.getString("bank_name"));
			map.put("supplier_name", rs.getString("supplier_name"));
			list.add(map);
		}
		return list;
	}

	@Override
	public int countAllMakePaymentList(String from_date, String to_date, String payment_id, int supplier_id, int business_id)
			throws Exception {
		ps=con.prepareStatement(COUNT_MAKE_PAYMENT_LIST);
		ps.setString(1, from_date);
		ps.setString(2, from_date);
		ps.setString(3, to_date);
		ps.setString(4, to_date);
		ps.setInt(5, supplier_id);
		ps.setInt(6, supplier_id);
		ps.setString(7, payment_id);
		ps.setString(8, payment_id);
		ps.setInt(9, business_id);
		ps.setInt(10, business_id);
		rs=ps.executeQuery();
		if(rs.next())
			return rs.getInt(1);
		else
			return 0;
	}	
	
	
	@Override
	public List<Map<String, Object>> getDateWiseReport(String from_date, String to_date, int business_id ) throws Exception {
		ps=con.prepareStatement(GET_DATE_WISE_REPORT);
		ps.setInt(1, business_id);
		ps.setInt(2, business_id);
		ps.setString(3, from_date);
		ps.setString(4, to_date);
		rs=ps.executeQuery();
		List<Map<String,Object>> list=new ArrayList<>();
		while(rs.next()) {
			Map<String,Object> data=new HashMap<>();
			data.put("payment_id", rs.getInt("payment_id"));
			data.put("payment_amount", rs.getString("payment_amount"));
			data.put("payment_date", rs.getString("payment_date"));
			data.put("payment_mode", rs.getString("payment_mode"));
			data.put("check_dd_no", rs.getString("check_dd_no"));
			data.put("check_dd_validity", rs.getString("check_dd_validity"));
			data.put("supplier_name", rs.getString("supplier_name"));
			data.put("bank_name", rs.getString("bank_name"));
			list.add(data);
		}
		return list;
	}

	@Override
	public List<Map<String, Object>> getSupplierWiseReport(int supplier_id, int business_id) throws Exception {
		ps=con.prepareStatement(GET_SUPPLIER_WISE_REPORT);
		ps.setInt(1, business_id);
		ps.setInt(2, business_id);
		ps.setInt(3, supplier_id);
		rs=ps.executeQuery();
		List<Map<String,Object>> list=new ArrayList<>();
		while(rs.next()) {
			Map<String,Object> data=new HashMap<>();
			data.put("payment_id", rs.getInt("payment_id"));
			data.put("payment_amount", rs.getString("payment_amount"));
			data.put("payment_date", rs.getString("payment_date"));
			data.put("payment_mode", rs.getString("payment_mode"));
			data.put("check_dd_no", rs.getString("check_dd_no"));
			data.put("check_dd_validity", rs.getString("check_dd_validity"));
			data.put("supplier_name", rs.getString("supplier_name"));
			data.put("bank_name", rs.getString("bank_name"));
			list.add(data);
		}
		return list;
	}

	@Override
	public List<Map<String, Object>> getSupplierWithDateWise(int supplier_id, String from_date, String to_date, int business_id)
			throws Exception {
		ps=con.prepareStatement(GET_SUPPLIER_WITH_DATE_WISE_REPORT);
		ps.setInt(1, business_id);
		ps.setInt(2, business_id);
		ps.setString(3, from_date);
		ps.setString(4, to_date);
		ps.setInt(5, supplier_id);
		ps.setInt(6, supplier_id);
		rs=ps.executeQuery();
		List<Map<String,Object>> list=new ArrayList<>();
		while(rs.next()) {
			Map<String,Object> data=new HashMap<>();
			data.put("payment_id", rs.getInt("payment_id"));
			data.put("payment_amount", rs.getString("payment_amount"));
			data.put("payment_date", rs.getString("payment_date"));
			data.put("payment_mode", rs.getString("payment_mode"));
			data.put("check_dd_no", rs.getString("check_dd_no"));
			data.put("check_dd_validity", rs.getString("check_dd_validity"));
			data.put("supplier_name", rs.getString("supplier_name"));
			data.put("bank_name", rs.getString("bank_name"));
			data.put("supplier_id", rs.getInt("supplier_id"));
			list.add(data);
		}
		return list;
	}

	

	@Override
	public List<Map<String, Object>> getPurchaseTransactionReport(String from_date, String to_date, int business_id) throws Exception {
		ps=con.prepareStatement(GET_TRANSACTION_PURCHASE_PAYMENT);
		ps.setString(1, from_date);
		ps.setString(2, to_date);
		ps.setString(3, from_date);
		ps.setString(4, to_date);
		ps.setInt(5, business_id);
		ps.setInt(6,business_id);
		rs=ps.executeQuery();
		List<Map<String,Object>> list=new ArrayList<>();
		while(rs.next()) {
			Map<String,Object> data=new HashMap<>();
			data.put("supplier_name", rs.getString("supplier_name"));
			data.put("totalPurchase", rs.getDouble("totalPurchase"));
			data.put("totalPaid", rs.getDouble("totalPaid"));
			list.add(data);
		}
		return list;
	}	

}
