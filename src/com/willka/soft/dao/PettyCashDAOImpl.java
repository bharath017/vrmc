package com.willka.soft.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import com.willka.soft.bean.PettyCashBean;
import com.willka.soft.bean.PettyCashModificationBean;
import com.willka.soft.bean.PettyCashTransactionBean;
import com.willka.soft.util.DBUtil;

public class PettyCashDAOImpl implements PettyCashDAO{
	
	private Connection con=null;
	private PreparedStatement ps=null;
	private ResultSet rs=null;
	
	private static final String INSERT_PETTY_CASH="insert into petty_cash(plant_id,date,amount,added_by,received_by,purpose,bank_detail_id) values(?,?,?,?,?,?,?)";
	
	private static final String UPDATE_PETTY_CASH="update petty_cash set plant_id=?,date=?,"
			+ "amount=?,added_by=?,received_by=?,purpose=?,bank_detail_id=? where cash_id=?";
	
	private static final String DELETE_PETTY_CASH="delete from petty_cash where cash_id=?";
	
	private static final String INSERT_PETTY_CASH_MODIFICATION="insert into petty_cash_modification(cash_id,date,"
			+ "amount,new_amount,modified_by,received_by,plant_id,modification_type) values(?,?,?,?,?,?,?,?)";
	
	private static final String GET_SINGLE_PETTY_CASH_DETAILS="select * from petty_cash where cash_id=?";
	
	private static final String GET_PETTY_CASH_LIST="select p.cash_id,DATE_FORMAT(p.date,'%d/%m/%Y') as date,"
			+ " p.amount,u.user_name as received_by,p.purpose,pl.plant_name,p.approve_status "
			+ " from petty_cash p,user u,plant pl "
			+ " where p.received_by=u.user_id "
			+ " and p.plant_id=pl.plant_id"
			+ " and p.date between if(''=?,'2014-01-01',?) and if(''=?,'2088-01-01',?) "
			+ " and p.cash_id like if(''=?,'%%',?) "
			+ " and p.plant_id like if(0=?,'%%',?) "
			+ " order by cash_id desc "
			+ " limit ?,?";
	
	private static final String COUNT_PETTY_CASH_LIST="select count(cash_id)"
			+ " from petty_cash p"
			+ " where p.date between if(''=?,'2014-01-01',?) and if(''=?,'2088-01-01',?) "
			+ " and p.cash_id like if(''=?,'%%',?) "
			+ " and p.plant_id like if(0=?,'%%',?) "
			+ " order by cash_id desc ";
	
	private static final String GET_PETTY_CASH_MODIFICATION="select cash_id,DATE_FORMAT(date,'%d/%m/%Y') as date,"
			+ " amount,new_amount,modified_by,DATE_FORMAT(modification_timestamp,'%d/%m/%Y %h:%m') as modification_timestamp,p.plant_name,"
			+ " modification_type from petty_cash_modification m,plant p"
			+ " where m.plant_id=p.plant_id and  cash_id like if(''=?,'%%',?) "
			+ " order by id desc limit ?,?";
	
	private static final String COUNT_PETTY_CASH_MODIFICATION="select count(id) from petty_cash_modification where cash_id like if(''=?,'%%',?)";
	
	private static final String INSERT_PETTY_CASH_TRANSACTION="insert into petty_cash_transaction(date,amount,description,received_person,plant_id,purpose) values(?,?,?,?,?,?)";
	
	private static final String UPDATE_PETTY_CASH_TRANSACTION="update petty_cash_transaction set date=?,amount=?,"
			+ "description=?,received_person=?,plant_id=?,purpose=? where transaction_id=?";
	
	private static final String DELETE_PETTY_CASH_TRANSACTION="delete from petty_cash_transaction where transaction_id=?";
	
	private static final String GET_PETTY_CASH_TRANSACTION_LIST="select p.*,pl.plant_name,DATE_FORMAT(p.date,'%d/%m/%Y') as realdate,is_bill_received,e.employee_name as employee_name"
			+ " from petty_cash_transaction p,plant pl,employee e "
			+ " where p.plant_id=pl.plant_id and received_person=e.e_id "
			+ " and p.date between if(''=?,'2014-01-01',?) and if(''=?,'2088-01-01',?)"
			+ " and p.plant_id like if(0=?,'%%',?)  and is_bill_received like if(true=?,'%%',?)"
			+ " order by transaction_id desc "
			+ "  limit ?,?";
	
	private static final String COUNT_PETTY_CASH_TRANSACTION="select count(transaction_id) from petty_cash_transaction p"
			+ " where p.date between if(''=?,'2014-01-01',?) and if(''=?,'2088-01-01',?) "
			+ " and p.plant_id like if(0=?,'%%',?) and is_bill_received like if(true=?,'%%',?)";
	
	private static final String GET_SINGLE_PETTY_CASH_TRANSACTION_DETAILS="select p.*,e.employee_name as employee_name from petty_cash_transaction p,employee e where p.transaction_id=?  and p.received_person=e.e_id";
	
	private static final String APPROVE_PETTY_CASH="update petty_cash set approve_status='accepted',approved_by=? where cash_id=?";
	
	
	private static final String GET_PETTY_CASH_DETAILS="select (select sum(amount) from petty_cash where year(date) between if(month(curdate())>=4,year(curdate()),year(curdate())-1) and " + 
			" if(month(curdate())>=4,year(curdate())+1,year(curdate()))  and approve_status='accepted' and plant_id like if(?=0,'%%',?)) totalpettycash," + 
			" (select sum(amount) from petty_cash_transaction where year(date) between if(month(curdate())>=4,year(curdate()),year(curdate())-1) and " + 
			" if(month(curdate())>=4,year(curdate())+1,year(curdate())) and plant_id like if(?=0,'%%',?)) as tataltrans,(select count(cash_id) from petty_cash where year(date) between if(month(curdate())>=4,year(curdate()),year(curdate())-1) and " + 
			" if(month(curdate())>=4,year(curdate())+1,year(curdate())) and approve_status='pending' and plant_id like if(?=0,'%%',?)) as pendingpettycash,"+
			" (select count(transaction_id) from petty_cash_transaction where year(date) between if(month(curdate())>=4,year(curdate()),year(curdate())-1) and " + 
			" if(month(curdate())>=4,year(curdate())+1,year(curdate())) and is_bill_received=false and plant_id like if(?=0,'%%',?)) as pendingtransaction";
	
	private static final String CHANGE_PETTY_CASH_TRANSACTION_STATUS="update petty_cash_transaction set is_bill_received=? where transaction_id=?";
	
	
									 
	
	
	
	
	public PettyCashDAOImpl() {
		con=DBUtil.getConnection();
	}

	@Override
	public int insertPettyCash(PettyCashBean bean) throws Exception {
		ps=con.prepareStatement(INSERT_PETTY_CASH);
		ps.setInt(1, bean.getPlant_id());
		ps.setString(2, bean.getDate());
		ps.setDouble(3, bean.getAmount());
		ps.setInt(4, bean.getAdded_by());
		ps.setInt(5, bean.getReceived_by());
		ps.setString(6, bean.getPurpose());
		ps.setInt(7, bean.getBank_id());
		int count=ps.executeUpdate();
		return count;
	}

	@Override
	public int updatePettyCash(PettyCashBean bean) throws Exception {
		ps=con.prepareStatement(UPDATE_PETTY_CASH);
		ps.setInt(1, bean.getPlant_id());
		ps.setString(2, bean.getDate());
		ps.setDouble(3, bean.getAmount());
		ps.setInt(4, bean.getAdded_by());
		ps.setInt(5, bean.getReceived_by());
		ps.setString(6, bean.getPurpose());
		ps.setInt(7, bean.getBank_id());
		ps.setLong(8, bean.getCash_id());
		int count=ps.executeUpdate();
		return count;
	}

	@Override
	public int deletePettyCash(long cash_id) throws Exception {
		ps=con.prepareStatement(DELETE_PETTY_CASH);
		ps.setLong(1, cash_id);
		int count=ps.executeUpdate();
		return count;
	}

	@Override
	public int insertPettyCashModification(PettyCashModificationBean bean) throws Exception {
		ps=con.prepareStatement(INSERT_PETTY_CASH_MODIFICATION);
		ps.setLong(1, bean.getCash_id());
		ps.setString(2, bean.getDate());
		ps.setDouble(3, bean.getAmount());
		ps.setDouble(4, bean.getNew_amount());
		ps.setString(5, bean.getModified_by());
		ps.setInt(6, bean.getReceived_by());
		ps.setInt(7, bean.getPlant_id());
		ps.setString(8,bean.getModification_type());
		int count=ps.executeUpdate();
		return count;
	}

	@Override
	public PettyCashBean getSinglePettyCashDetails(long cash_id) throws Exception {
		ps=con.prepareStatement(GET_SINGLE_PETTY_CASH_DETAILS);
		ps.setLong(1, cash_id);
		rs=ps.executeQuery();
		if(rs.next()) {
			PettyCashBean bean=new PettyCashBean();
			bean.setCash_id(rs.getLong("cash_id"));
			bean.setDate(rs.getString("date"));
			bean.setAmount(rs.getDouble("amount"));
			bean.setAdded_by(rs.getInt("added_by"));
			bean.setReceived_by(rs.getInt("received_by"));
			bean.setPlant_id(rs.getInt("plant_id"));
			return bean;
		}
		else
			return null;
	}

	@Override
	public ArrayList<HashMap<String, Object>> getPettyCashList(String from_date, String to_date, String cash_id,
			int plant_id, int start, int length) throws Exception {
		ps=con.prepareStatement(GET_PETTY_CASH_LIST);
		ps.setString(1, from_date);
		ps.setString(2, from_date);
		ps.setString(3, to_date);
		ps.setString(4, to_date);
		ps.setString(5, cash_id);
		ps.setString(6, cash_id);
		ps.setInt(7, plant_id);
		ps.setInt(8, plant_id);
		ps.setInt(9, start);
		ps.setInt(10, length);
		rs=ps.executeQuery();
		ArrayList<HashMap<String, Object>> list=new ArrayList<HashMap<String,Object>>();
		while(rs.next()) {
			HashMap<String, Object> map=new HashMap<String, Object>();
			map.put("cash_id", rs.getInt("cash_id"));
			map.put("date", rs.getString("date"));
			map.put("amount", rs.getDouble("amount"));
			map.put("received_by", rs.getString("received_by"));
			map.put("plant_name", rs.getString("plant_name"));
			map.put("purpose", rs.getString("purpose"));
			map.put("approve_status", rs.getString("approve_status"));
			list.add(map);
		}
		return list;
	}

	@Override
	public int countPettyCashList(String from_date, String to_date, String cash_id, int plant_id) throws Exception {
		ps=con.prepareStatement(COUNT_PETTY_CASH_LIST);
		ps.setString(1, from_date);
		ps.setString(2, from_date);
		ps.setString(3, to_date);
		ps.setString(4, to_date);
		ps.setString(5, cash_id);
		ps.setString(6, cash_id);
		ps.setInt(7, plant_id);
		ps.setInt(8, plant_id);
		rs=ps.executeQuery();
		if(rs.next())
			return rs.getInt(1);
		else
			return 0;
	}

	@Override
	public ArrayList<HashMap<String, Object>> getPettyCashModificationList(String cash_id, int start, int length)
			throws Exception {
		ps=con.prepareStatement(GET_PETTY_CASH_MODIFICATION);
		ps.setString(1, cash_id);
		ps.setString(2, cash_id);
		ps.setInt(3, start);
		ps.setInt(4, length);
		rs=ps.executeQuery();
		ArrayList<HashMap<String, Object>> list=new ArrayList<HashMap<String,Object>>();
		while(rs.next()) {
			HashMap<String, Object> map=new HashMap<String, Object>();
			map.put("cash_id", rs.getInt("cash_id"));
			map.put("date", rs.getString("date"));
			map.put("amount", rs.getString("amount"));
			map.put("new_amount", rs.getString("new_amount"));
			map.put("modified_by", rs.getString("modified_by"));
			map.put("modification_timestamp", rs.getString("modification_timestamp"));
			map.put("plant_name", rs.getString("plant_name"));
			map.put("modification_type", rs.getString("modification_type"));
			list.add(map);
		}
		return list;
	}

	@Override
	public int countPettyCashModificationList(String cash_id) throws Exception {
		ps=con.prepareStatement(COUNT_PETTY_CASH_MODIFICATION);
		ps.setString(1, cash_id);
		ps.setString(2, cash_id);
		rs=ps.executeQuery();
		if(rs.next())
			return rs.getInt(1);
		else
			return 0;
	}

	@Override
	public int insertPettyCashTransaction(PettyCashTransactionBean bean) throws Exception {
		ps=con.prepareStatement(INSERT_PETTY_CASH_TRANSACTION);
		ps.setString(1, bean.getDate());
		ps.setDouble(2, bean.getAmount());
		ps.setString(3, bean.getDescription());
		ps.setInt(4, bean.getReceived_person());
		ps.setInt(5, bean.getPlant_id());
		ps.setString(6, bean.getPurpose());
		int count=ps.executeUpdate();
		return count;
	}

	@Override
	public int updatePettyCashTransaction(PettyCashTransactionBean bean) throws Exception {
		ps=con.prepareStatement(UPDATE_PETTY_CASH_TRANSACTION);
		ps.setString(1, bean.getDate());
		ps.setDouble(2, bean.getAmount());
		ps.setString(3, bean.getDescription());
		ps.setInt(4, bean.getReceived_person());
		ps.setInt(5, bean.getPlant_id());
		ps.setString(6, bean.getPurpose());
		ps.setLong(7, bean.getTransaction_id());
		int count=ps.executeUpdate();
		return count;
	}

	@Override
	public int deletePettyCashTransaction(long transaction_id) throws Exception {
		ps=con.prepareStatement(DELETE_PETTY_CASH_TRANSACTION);
		ps.setLong(1, transaction_id);
		int count=ps.executeUpdate();
		return count;
	}

	@Override
	public ArrayList<HashMap<String, Object>> getPettyCashTransactionList(String from_date, String to_date,int plant_id,boolean checked, int start,
			int length) throws Exception {
		ps=con.prepareStatement(GET_PETTY_CASH_TRANSACTION_LIST);
		ps.setString(1, from_date);
		ps.setString(2, from_date);
		ps.setString(3, to_date);
		ps.setString(4, to_date);
		ps.setInt(5, plant_id);
		ps.setInt(6, plant_id);
		ps.setBoolean(7, checked);
		ps.setBoolean(8, checked);
		ps.setInt(9, start);
		ps.setInt(10, length);
		rs=ps.executeQuery();
		ArrayList<HashMap<String, Object>> list=new ArrayList<HashMap<String,Object>>();
		while(rs.next()) {
			HashMap<String, Object> map=new HashMap<String, Object>();
			map.put("transaction_id", rs.getInt("transaction_id"));
			map.put("date", rs.getString("realdate"));
			map.put("amount", rs.getDouble("amount"));
			map.put("received_person", rs.getString("employee_name"));
			map.put("description", rs.getString("description"));
			map.put("plant_name", rs.getString("plant_name"));
			map.put("is_bill_received", rs.getBoolean("is_bill_received"));
			list.add(map);
		}
		return list;
	}

	@Override
	public int countPettyCashTransactionList(String from_date, String to_date,int plant_id,boolean checked) throws Exception {
		ps=con.prepareStatement(COUNT_PETTY_CASH_TRANSACTION);
		ps.setString(1, from_date);
		ps.setString(2, from_date);
		ps.setString(3, to_date);
		ps.setString(4, to_date);
		ps.setInt(5, plant_id);
		ps.setInt(6, plant_id);
		ps.setBoolean(7, checked);
		ps.setBoolean(8, checked);
		rs=ps.executeQuery();
		if(rs.next())
			return rs.getInt(1);
		else
			return 0;
	}

	@Override
	public PettyCashTransactionBean getSinglePettyCashTransaction(long transaction_id) throws Exception {
		ps=con.prepareStatement(GET_SINGLE_PETTY_CASH_TRANSACTION_DETAILS);
		ps.setLong(1,transaction_id);
		rs=ps.executeQuery();
		if(rs.next()) {
			PettyCashTransactionBean bean=new PettyCashTransactionBean();
			bean.setAmount(rs.getDouble("amount"));
			bean.setDate(rs.getString("date"));
			bean.setDescription(rs.getString("description"));
			bean.setReceived_person(rs.getInt("received_person"));
			bean.setPurpose(rs.getString("purpose"));
			bean.setPlant_id(rs.getInt("plant_id"));
			bean.setTransaction_id(rs.getLong("transaction_id"));
			return bean;
		}
		return null;
	}

	@Override
	public int approvePettyCash(long cash_id,String received_by) throws Exception {
		ps=con.prepareStatement(APPROVE_PETTY_CASH);
		ps.setString(1, received_by);
		ps.setLong(2, cash_id);
		int count=ps.executeUpdate();
		return count;
	}

	@Override
	public HashMap<String, Object> getDetailsSumOfPettyCash(int plant_id) throws Exception {
		ps=con.prepareStatement(GET_PETTY_CASH_DETAILS);
		ps.setInt(1, plant_id);
		ps.setInt(2, plant_id);
		ps.setInt(3, plant_id);
		ps.setInt(4, plant_id);
		ps.setInt(5, plant_id);
		ps.setInt(6, plant_id);
		ps.setInt(7, plant_id);
		ps.setInt(8, plant_id);
		rs=ps.executeQuery();
		if(rs.next()) {
			HashMap<String, Object> map=new HashMap<String, Object>();
			map.put("totalpettycash", rs.getDouble("totalpettycash"));
			map.put("totaltrans", rs.getDouble("tataltrans"));
			map.put("pendingpettycash", rs.getInt("pendingpettycash"));
			map.put("pendingtransaction", rs.getInt("pendingtransaction"));
			return map;
		}
		return null;
	}

	@Override
	public int changePettyCashTransactionBillStatus(long transaction_id, boolean status) throws Exception {
		ps=con.prepareStatement(CHANGE_PETTY_CASH_TRANSACTION_STATUS);
		ps.setBoolean(1, status);
		ps.setLong(2, transaction_id);
		int count=ps.executeUpdate();
		return count;
	}

	
}
