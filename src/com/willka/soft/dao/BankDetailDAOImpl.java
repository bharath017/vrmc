// 
// Decompiled by Procyon v0.5.36
// 

package com.willka.soft.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import com.willka.soft.bean.BankTransactionBean;
import com.willka.soft.bean.BankDetailBean;
import com.willka.soft.util.DBUtil;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Connection;

public class BankDetailDAOImpl implements BankDetailDAO
{
    private Connection con;
    private ResultSet rs;
    private PreparedStatement ps;
    private static final String INSERT_TRANSACTION_DETAILS = "insert into bank_transaction(transaction_amount,transaction_date,"
    		+ "transaction_time,added_by,transaction_type,remarks,bank_id,receiver,business_id)values(?,?,?,?,?,?,?,?,?)";
    
    
    private static final String GET_BANK_TRANSACTION_LIST="select m1.*,DATE_FORMAT(m1.date,'%d/%m/%Y') as realdate"+
    		 " from ((select t.transaction_id as id,t.transaction_amount as amount,t.transaction_date as date,"+
    					" t.transaction_type as type,concat(t.remarks, '',t.receiver) as remark,b.bank_name,g.group_name"+
    					" from bank_transaction t LEFT JOIN (bank_detail b,business_group g)"+
    					" ON t.bank_id=b.bank_detail_id"+
    					" and b.business_id=g.business_id"+
    					" where t.transaction_date between if(''=?,'2000-01-01',STR_TO_DATE(?, '%d/%m/%Y')) and if(''=?,'2050-01-01',STR_TO_DATE(?, '%d/%m/%Y'))"+
    					" and t.business_id like if(0=?,'%%',?)"+
    					" and t.bank_id like if(0=?,'%%',?))"+
    					" UNION ALL "+
    					" (select p.payment_id as id,p.payment_amount as amount,p.payment_date as date,"+
    					" 'cuspay' as type,CONCAT('Payment Received From ',c.customer_name,' By ',p.payment_mode) as remark,b.bank_name,g.group_name"+
    					" from customer_payment p LEFT JOIN (customer c,bank_detail b,business_group g)"+
    					" ON p.customer_id=c.customer_id"+
    					" and p.bank_detail_id=b.bank_detail_id"+
    					" and c.business_id=g.business_id"+
    					" where p.payment_date between if(''=?,'2000-01-01',STR_TO_DATE(?, '%d/%m/%Y')) and if(''=?,'2050-01-01',STR_TO_DATE(?, '%d/%m/%Y'))"+
    					" and c.business_id like  if(0=?,'%%',?)"+
    					" and p.bank_detail_id like if(0=?,'%%',?))"+
    					" UNION ALL"+
    					" (select payment_id as id,p.payment_amount as amount,p.payment_date as date,"+
    					" 'suppay' as type,CONCAT('Paid to Vendor ', s.supplier_name, ' by ', p.payment_mode) as remark,b.bank_name,g.group_name"+
    					" from make_payment p LEFT JOIN (supplier s,bank_detail b,business_group g)"+
    					" ON p.supplier_id=s.supplier_id "+
    					" and p.bank_detail_id=b.bank_detail_id"+
    					" and s.business_id=g.business_id"+
    					" where p.payment_date between if(''=?,'2000-01-01',STR_TO_DATE(?, '%d/%m/%Y')) and if(''=?,'2050-01-01',STR_TO_DATE(?, '%d/%m/%Y'))"+
    					" and s.business_id like if(?=0,'%%',?)"+
    					" and p.bank_detail_id like if(0=?,'%%',?))"+
    				" ) as m1"+
    			" order by m1.date desc"+
    			" limit ?,?";

    
    private static final String COUNT_BANK_TRANSACTION_LIST="select m1.*"+
    		" from (select count(t.transaction_id) as count from bank_transaction t"+
    					" where t.transaction_date between if(''=?,'2000-01-01',STR_TO_DATE(?, '%d/%m/%Y')) and if(''=?,'2050-01-01',STR_TO_DATE(?, '%d/%m/%Y'))"+
    					" and t.business_id like if(0=?,'%%',?)"+
    					" and t.bank_id like if(0=?,'%%',?)"+
    					" UNION ALL "+
    					" select count(payment_id) as count"+
    					" from customer_payment p LEFT JOIN (customer c)"+
    					" ON p.customer_id=c.customer_id"+
    					" where p.payment_date between if(''=?,'2000-01-01',STR_TO_DATE(?, '%d/%m/%Y')) and if(''=?,'2050-01-01',STR_TO_DATE(?, '%d/%m/%Y'))"+
    					" and c.business_id like  if(0=?,'%%',?)"+
    					" and p.bank_detail_id like if(0=?,'%%',?)"+
    					" UNION ALL"+
    					" select count(payment_id) as count"+ 
    					" from make_payment p LEFT JOIN (supplier s)"+
    					" ON p.supplier_id=s.supplier_id "+
    					" where p.payment_date between if(''=?,'2000-01-01',STR_TO_DATE(?, '%d/%m/%Y')) and if(''=?,'2050-01-01',STR_TO_DATE(?, '%d/%m/%Y'))"+
    					" and s.business_id like if(?=0,'%%',?)"+
    					" and p.bank_detail_id like if(0=?,'%%',?)"+
    				" ) as m1";
    
    
    //GET REPORT PART HERE
    
    private static final String GET_OPENING_BALANCE="select sum(payment_amount) as credit,0 as debit"+ 
					" from customer_payment p,customer c"+
					" where p.customer_id=c.customer_id"+
					" and c.business_id like if(?=0,'%%',?)"+
					" and payment_date < STR_TO_DATE(?, '%d/%m/%Y') and"+  
					" bank_detail_id like if(0=?,'%%',?) and bank_detail_id!=1"+
					" UNION ALL"+
					" select 0 as credit,sum(payment_amount) as debit"+
					" from make_payment m,supplier s"+
					" where m.supplier_id=s.supplier_id"+
					" and s.business_id like if(?=0,'%%',?)"+
					" and payment_date < STR_TO_DATE(?, '%d/%m/%Y')"+
					" and bank_detail_id like if(0=?,'%%',?) and bank_detail_id!=1"+
					" UNION ALL "+
					" select IF(transaction_type='credit',sum(transaction_amount),0) as credit,IF(transaction_type='debit',sum(transaction_amount),0) as debit"+
					" from bank_transaction c,bank_detail b"+
					" where c.bank_id=b.bank_detail_id and "+
					" transaction_date < STR_TO_DATE(?, '%d/%m/%Y')"+
					" and c.bank_id like if(0=?,'%%',?) and bank_id!=1"+
					" and b.business_id like if(?=0,'%%',?)"+
					" and c.status='active'"+
					" group by transaction_type";
    
    private static final String GET_TRANSACTION_REPORT="select t.* from (select payment_amount as credit,'' as debit,DATE_FORMAT(payment_date,'%d/%m/%Y') as payment_date,"+
    				" payment_date as fake_date,b.bank_name,cu.customer_name as person,'Customer payment' as remarks,concat(payment_mode,if(check_dd_no is null,'',concat(':',check_dd_no))) as mode"+
					" from customer_payment c,bank_detail b,customer cu"+
					" where c.bank_detail_id=b.bank_detail_id and c.customer_id=cu.customer_id"+
					" and payment_date between STR_TO_DATE(?, '%d/%m/%Y') and STR_TO_DATE(?, '%d/%m/%Y')"+
					" and c.bank_detail_id like if(0=?,'%%',?) and c.bank_detail_id!=1"+
					" and cu.business_id like if(0=?,'%%',?)"+
					" and c.payment_amount>0"+
					" UNION ALL"+
					" select '' as credit,payment_amount as debit,DATE_FORMAT(payment_date,'%d/%m/%Y') as payment_date,payment_date as fake_date ,"+
					" b.bank_name,s.supplier_name as person,'Supplier Payment' as remarks,concat(payment_mode,if(check_dd_no is null,'',concat(':',check_dd_no))) as mode"+
					" from make_payment m,bank_detail b,supplier s"+
					" where m.bank_detail_id=b.bank_detail_id and m.supplier_id=s.supplier_id"+
					" and payment_date between STR_TO_DATE(?, '%d/%m/%Y') and STR_TO_DATE(?, '%d/%m/%Y')"+
					" and m.bank_detail_id like if(0=?,'%%',?)  and m.bank_detail_id!=1"+
					" and s.business_id like if(?=0,'%%',?)"+
					" and m.payment_amount>0"+
					" UNION ALL"+
					" select IF(transaction_type='credit',transaction_amount,'') as credit,IF(transaction_type='debit',transaction_amount,'') as debit,"+
					" DATE_FORMAT(transaction_date,'%d/%m/%Y') as payment_date,transaction_date as fake_date,b.bank_name,c.receiver as person,c.remarks as remarks,'' as mode"+
				    " from bank_transaction c,bank_detail b"+
					" where c.bank_id=b.bank_detail_id and "+
					" transaction_date between STR_TO_DATE(?, '%d/%m/%Y') and STR_TO_DATE(?, '%d/%m/%Y')"+
					" and c.bank_id like if(0=?,'%%',?) and c.bank_id!=1"+
					" and b.business_id like if(?=0,'%%',?)"+
					" and c.status='active'"+
					" UNION ALL"+
					" select '' as credit, m.amount as debit,DATE_FORMAT(date,'%d/%m/%Y') as payment_date,date as fake_date,b.bank_name,"+
					" e.user_name as person,m.purpose as remarks,'' as mode"+
					" from petty_cash m,bank_detail b,user e,plant p"+
					" where m.bank_detail_id=b.bank_detail_id"+
					" and e.user_id=m.received_by"+
					" and m.plant_id=p.plant_id"+
					" and date between STR_TO_DATE(?, '%d/%m/%Y') and STR_TO_DATE(?, '%d/%m/%Y')"+
					" and m.bank_detail_id like if(0=?,'%%',?) and m.bank_detail_id!=1"+
					" and p.business_id like if(?=0,'%%',?)) as t"+
					" order by t.fake_date asc";
    
    private static final String GET_OLD_BALANCE_FOR_BANK="select sum(amount) as amount from bank_detail" +
				" where bank_detail_id like if(0=?,'%%',?)";
    
    
	    
    
    private static final String GET_BANK_LIST_BY_PAYMENT_TYPE="select bank_detail_id,bank_name"
    		+ " from bank_detail where business_id like if(?=0,'%%',?) and group_name=?";
    
    private static final String GET_BANK_LIST_BY_BUSINESS_GROUP="select bank_detail_id,bank_name,g.group_name"
    		+ " from bank_detail b,business_group g"
    		+ " where b.business_id=g.business_id and "
    		+ " b.business_id like if(?=0,'%%',?)";
    
    public BankDetailDAOImpl() {
        con = DBUtil.getConnection();
    }
    
    @Override
    public int insertBankDetails(final BankDetailBean bean) throws Exception {
        (this.ps = this.con.prepareStatement("insert into bank_detail(bank_name,ifsc_code"
        		+ ",account_no,branch_name,amount,business_id,group_name) values(?,?,?,?,?,?,?)")).setString(1, bean.getBank_name());
        this.ps.setString(2, bean.getIfsc_code());
        this.ps.setString(3, bean.getAccount_no());
        this.ps.setString(4, bean.getBranch_name());
        this.ps.setDouble(5, bean.getAmount());
        this.ps.setInt(6, bean.getBusiness_id());
        this.ps.setString(7, bean.getGroup());
        final int count = this.ps.executeUpdate();
        return count;
    }
    
    @Override
    public int updateBankDetails(final BankDetailBean bean) throws Exception {
        (this.ps = this.con.prepareStatement("update bank_detail set bank_name=?,ifsc_code=?,"
        		+ " account_no=?,branch_name=?,amount=?,business_id=?,group_name=? where bank_detail_id=?")).setString(1, bean.getBank_name());
        this.ps.setString(2, bean.getIfsc_code());
        this.ps.setString(3, bean.getAccount_no());
        this.ps.setString(4, bean.getBranch_name());
        this.ps.setDouble(5, bean.getAmount());
        this.ps.setInt(6, bean.getBusiness_id());
        this.ps.setString(7, bean.getGroup());
        this.ps.setInt(8, bean.getBank_detail_id());
        final int count = this.ps.executeUpdate();
        return count;
    }
    
    @Override
    public int deleteBankDetails(final int bank_detail_id) throws Exception {
        (this.ps = this.con.prepareStatement("delete from bank_detail where bank_detail_id=?")).setInt(1, bank_detail_id);
        final int count = this.ps.executeUpdate();
        return count;
    }
    
    @Override
    public int insertTransactionDetail(final BankTransactionBean bean) throws Exception {
        ps = con.prepareStatement(INSERT_TRANSACTION_DETAILS);
        ps.setDouble(1, bean.getTransaction_amount());
        ps.setString(2, bean.getTransaction_date());
        ps.setString(3, bean.getTransaction_time());
        ps.setInt(4, bean.getAdded_by());
        ps.setString(5, bean.getTransaction_type());
        ps.setString(6, bean.getRemarks());
        ps.setInt(7, bean.getBank_id());
        ps.setString(8,	bean.getReceiver());
        ps.setInt(9, bean.getBusiness_id());
        int count = ps.executeUpdate();
        return count;
    }
    
    @Override
    public int updateTransactionDetail(final BankTransactionBean bean) throws Exception {
        (this.ps = this.con.prepareStatement("update bank_transaction set transaction_amount=?,transaction_date=?,transaction_time=?,"
        		+ "added_by=?,transaction_type=?,remarks=?,business_id=?,bank_id=? where transaction_id=?")).setDouble(1, bean.getTransaction_amount());
        this.ps.setString(2, bean.getTransaction_date());
        this.ps.setString(3, bean.getTransaction_time());
        this.ps.setInt(4, bean.getAdded_by());
        this.ps.setString(5, bean.getTransaction_type());
        this.ps.setString(6, bean.getRemarks());
        this.ps.setInt(7, bean.getBusiness_id());
        this.ps.setInt(8, bean.getBank_id());
        this.ps.setInt(9, bean.getTransaction_id());
        final int count = this.ps.executeUpdate();
        return count;
    }
    
    @Override
    public int deleteTransactionDetail(final int transaction_id) throws Exception {
        (this.ps = this.con.prepareStatement("delete from bank_transaction where transaction_id=? ")).setInt(1, transaction_id);
        final int count = this.ps.executeUpdate();
        return count;
    }
    
    @Override
    public int cancelTransactionDetail(final int transaction_id) throws Exception {
        (this.ps = this.con.prepareStatement("update  bank_transaction set status='inactive' where transaction_id=?")).setInt(1, transaction_id);
        final int count = this.ps.executeUpdate();
        return count;
    }
    
   

	@Override
	public List<Map<String, Object>> getBankTransactionList(String from_date, String to_date, int bank_id,int business_id,
			int start, int length) throws Exception {
		ps=con.prepareStatement(GET_BANK_TRANSACTION_LIST);
		ps.setString(1, from_date);
		ps.setString(2, from_date);
		ps.setString(3, to_date);
		ps.setString(4, to_date);
		ps.setInt(5, business_id);
		ps.setInt(6, business_id);
		ps.setInt(7, bank_id);
		ps.setInt(8, bank_id);
		ps.setString(9, from_date);
		ps.setString(10, from_date);
		ps.setString(11, to_date);
		ps.setString(12, to_date);
		ps.setInt(13, business_id);
		ps.setInt(14, business_id);
		ps.setInt(15, bank_id);
		ps.setInt(16, bank_id);
		ps.setString(17, from_date);
		ps.setString(18, from_date);
		ps.setString(19, to_date);
		ps.setString(20, to_date);
		ps.setInt(21, business_id);
		ps.setInt(22, business_id);
		ps.setInt(23, bank_id);
		ps.setInt(24, bank_id);
		ps.setInt(25, start);
		ps.setInt(26, length);
		System.out.println(ps.toString());
		rs=ps.executeQuery();
		List<Map<String,Object>> list=new ArrayList<Map<String,Object>>();
		while(rs.next()) {
			Map<String,Object> data=new HashMap<String, Object>();
			data.put("id", rs.getInt("id"));
			data.put("date", rs.getString("realdate"));
			data.put("amount", rs.getDouble("amount"));
			data.put("type", rs.getString("type"));
			data.put("remark", rs.getString("remark"));
			data.put("bank_name", rs.getString("bank_name"));
			data.put("group_name", rs.getString("group_name"));
			list.add(data);
		}
		return list;
	}

	@Override
	public int countBankTransactionList(String from_date, String to_date,
			int bank_id, int business_id) throws Exception {
		ps=con.prepareStatement(COUNT_BANK_TRANSACTION_LIST);
		ps.setString(1, from_date);
		ps.setString(2, from_date);
		ps.setString(3, to_date);
		ps.setString(4, to_date);
		ps.setInt(5, business_id);
		ps.setInt(6, business_id);
		ps.setInt(7, bank_id);
		ps.setInt(8, bank_id);
		ps.setString(9, from_date);
		ps.setString(10, from_date);
		ps.setString(11, to_date);
		ps.setString(12, to_date);
		ps.setInt(13, business_id);
		ps.setInt(14, business_id);
		ps.setInt(15, bank_id);
		ps.setInt(16, bank_id);
		ps.setString(17, from_date);
		ps.setString(18, from_date);
		ps.setString(19, to_date);
		ps.setString(20, to_date);
		ps.setInt(21, business_id);
		ps.setInt(22, business_id);
		ps.setInt(23, bank_id);
		ps.setInt(24, bank_id);
		rs=ps.executeQuery();
		int count=0;
		while(rs.next()) {
			count+=rs.getInt(1);
		}
		return count;
	}

	@Override
	public List<Map<String, Object>> getBankListByPaymentType(String group_name, int business_id) throws Exception {
		ps=con.prepareStatement(GET_BANK_LIST_BY_PAYMENT_TYPE);
		ps.setInt(1, business_id);
		ps.setInt(2, business_id);
		ps.setString(3, group_name);
		rs=ps.executeQuery();
		List<Map<String,Object>> list=new ArrayList<>();
		while(rs.next()) {
			Map<String,Object> map=new HashMap<>();
			map.put("bank_detail_id", rs.getInt("bank_detail_id"));
			map.put("bank_name", rs.getString("bank_name"));
			list.add(map);
		}
		return list;
	}

	@Override
	public List<Map<String, Object>> getBanksByBusinessGroup(int business_id) throws Exception {
		ps=con.prepareStatement(GET_BANK_LIST_BY_BUSINESS_GROUP);
		ps.setInt(1, business_id);
		ps.setInt(2, business_id);
		rs=ps.executeQuery();
		List<Map<String,Object>> list=new ArrayList<>();
		while(rs.next()) {
			Map<String,Object> data=new HashMap<>();
			data.put("bank_detail_id", rs.getInt("bank_detail_id"));
			data.put("bank_name", rs.getString("bank_name"));
			data.put("group_name", rs.getString("group_name"));
			list.add(data);
		}
		return list;
	}

	@Override
	public List<Map<String, Object>> getOpeningBalanceList(String from_date, int bank_detail_id, int business_id)
			throws Exception {
		ps=con.prepareStatement(GET_OPENING_BALANCE);
		ps.setInt(1, business_id);
		ps.setInt(2, business_id);
		ps.setString(3, from_date);
		ps.setInt(4, bank_detail_id);
		ps.setInt(5, bank_detail_id);
		ps.setInt(6, business_id);
		ps.setInt(7, business_id);
		ps.setString(8, from_date);
		ps.setInt(9, bank_detail_id);
		ps.setInt(10, bank_detail_id);
		ps.setString(11, from_date);
		ps.setInt(12, bank_detail_id);
		ps.setInt(13, bank_detail_id);
		ps.setInt(14, business_id);
		ps.setInt(15, business_id);
		rs=ps.executeQuery();
		List<Map<String,Object>> list=new ArrayList<>();
		while(rs.next()) {
			Map<String,Object> map=new HashMap<>();
			map.put("credit", rs.getDouble("credit"));
			map.put("debit", rs.getDouble("debit"));
			list.add(map);
		}
		return list;
	}	

	
	@Override
	public List<Map<String, Object>> getTransactionReport(String from_date, String to_date, int bank_detail_id,
			int business_id) throws Exception {
		ps=con.prepareStatement(GET_TRANSACTION_REPORT);
		ps.setString(1, from_date);
		ps.setString(2, to_date);
		ps.setInt(3, bank_detail_id);
		ps.setInt(4, bank_detail_id);
		ps.setInt(5, business_id);
		ps.setInt(6, business_id);
		ps.setString(7, from_date);
		ps.setString(8, to_date);
		ps.setInt(9, bank_detail_id);
		ps.setInt(10, bank_detail_id);
		ps.setInt(11, business_id);
		ps.setInt(12, business_id);
		ps.setString(13, from_date);
		ps.setString(14, to_date);
		ps.setInt(15, bank_detail_id);
		ps.setInt(16, bank_detail_id);
		ps.setInt(17, business_id);
		ps.setInt(18, business_id);
		ps.setString(19, from_date);
		ps.setString(20, to_date);
		ps.setInt(21, bank_detail_id);
		ps.setInt(22, bank_detail_id);
		ps.setInt(23, business_id);
		ps.setInt(24, business_id);
		rs=ps.executeQuery();
		List<Map<String,Object>> list=new ArrayList<>();
		while(rs.next()) {
			Map<String,Object> map=new HashMap<>();
			map.put("payment_date", rs.getString("payment_date"));
			map.put("person", rs.getString("person"));
			map.put("credit", rs.getDouble("credit"));
			map.put("debit", rs.getDouble("debit"));
			map.put("bank_name", rs.getString("bank_name"));
			map.put("remarks", rs.getString("remarks"));
			map.put("mode", rs.getString("mode"));
			list.add(map);
		}
		return list;
	}

	@Override
	public double getOldBankBalance(int bank_detail_id) throws Exception {
		ps=con.prepareStatement(GET_OLD_BALANCE_FOR_BANK);
		ps.setInt(1, bank_detail_id);
		ps.setInt(2, bank_detail_id);
		rs=ps.executeQuery();
		if(rs.next())
			return rs.getDouble(1);
		else
			return 0;
	}

	@Override
	public Map<String, Object> processTransactionReport(String from_date, String to_date, int bank_detail_id,
			int business_id) throws Exception {
		double openingBalance=0;
		double oldBalance=this.getOldBankBalance(bank_detail_id);
		openingBalance+=oldBalance;
		List<Map<String,Object>> list=this.getOpeningBalanceList(from_date, bank_detail_id, business_id);
		Iterator<Map<String,Object>> itr=list.iterator();
		while(itr.hasNext()) {
			Map<String,Object> openingBalanceData=itr.next();
			openingBalance+=(Double)openingBalanceData.get("credit")-(Double)openingBalanceData.get("debit");
		}
		List<Map<String,Object>> transactions=this.getTransactionReport(from_date, to_date, bank_detail_id, business_id);
		Map<String,Object> data=new HashMap<>();
		data.put("opening", openingBalance);
		data.put("list", transactions);
		return data;
	}
}
