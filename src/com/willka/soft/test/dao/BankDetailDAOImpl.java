// 
// Decompiled by Procyon v0.5.36
// 

package com.willka.soft.test.dao;

import java.util.ArrayList;
import java.util.HashMap;
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
    		 " from ((select p.payment_id as id,p.payment_amount as amount,p.payment_date as date,"+
    					" 'cuspay' as type,CONCAT('Payment Received From ',c.customer_name,' By ',p.payment_mode) as remark,b.bank_name,g.group_name"+
    					" from test_customer_payment p LEFT JOIN (test_customer c,bank_detail b,business_group g)"+
    					" ON p.customer_id=c.customer_id"+
    					" and p.bank_detail_id=b.bank_detail_id"+
    					" and c.business_id=g.business_id"+
    					" where p.payment_date between if(''=?,'2000-01-01',STR_TO_DATE(?, '%d/%m/%Y')) and if(''=?,'2050-01-01',STR_TO_DATE(?, '%d/%m/%Y'))"+
    					" and c.business_id like  if(0=?,'%%',?)"+
    					" and p.bank_detail_id like if(0=?,'%%',?))"+
    					" UNION ALL"+
    					" (select payment_id as id,p.payment_amount as amount,p.payment_date as date,"+
    					" 'suppay' as type,CONCAT('Paid to Vendor ', s.supplier_name, ' by ', p.payment_mode) as remark,b.bank_name,g.group_name"+
    					" from test_make_payment p LEFT JOIN (test_supplier s,bank_detail b,business_group g)"+
    					" ON p.supplier_id=s.supplier_id "+
    					" and p.bank_detail_id=b.bank_detail_id"+
    					" and s.business_id=g.business_id"+
    					" where p.payment_date between if(''=?,'2000-01-01',STR_TO_DATE(?, '%d/%m/%Y')) and if(''=?,'2050-01-01',STR_TO_DATE(?, '%d/%m/%Y'))"+
    					" and s.business_id like if(?=0,'%%',?)"+
    					" and p.bank_detail_id like if(0=?,'%%',?))"+
    					" UNION ALL"+
    					" (select cash_id as id,p.amount as amount,p.date as date,"+
    					" 'Pettycash' as type,p.purpose as remark,b.bank_name,g.group_name"+
    					" from test_petty_cash p LEFT JOIN (bank_detail b,business_group g)"+
    					" ON p.bank_detail_id=b.bank_detail_id"+
    					" and b.business_id=g.business_id"+
    					" where p.date between if(''=?,'2000-01-01',STR_TO_DATE(?, '%d/%m/%Y')) and if(''=?,'2050-01-01',STR_TO_DATE(?, '%d/%m/%Y'))"+
    					" and b.business_id like if(?=0,'%%',?)"+
    					" and p.bank_detail_id like if(0=?,'%%',?))"+
    				" ) as m1"+
    			" order by m1.date desc"+
    			" limit ?,?";

    
    private static final String COUNT_BANK_TRANSACTION_LIST="select m1.*"+
    		" from (select count(t.cash_id) as count from test_petty_cash t,bank_detail b"+
    					" where t.bank_detail_id=b.bank_detail_id and  t.date between if(''=?,'2000-01-01',STR_TO_DATE(?, '%d/%m/%Y')) and if(''=?,'2050-01-01',STR_TO_DATE(?, '%d/%m/%Y'))"+
    					" and b.business_id like if(0=?,'%%',?)"+
    					" and t.bank_detail_id like if(0=?,'%%',?)"+
    					" UNION ALL "+
    					" select count(payment_id) as count"+
    					" from test_customer_payment p LEFT JOIN (test_customer c)"+
    					" ON p.customer_id=c.customer_id"+
    					" where p.payment_date between if(''=?,'2000-01-01',STR_TO_DATE(?, '%d/%m/%Y')) and if(''=?,'2050-01-01',STR_TO_DATE(?, '%d/%m/%Y'))"+
    					" and c.business_id like  if(0=?,'%%',?)"+
    					" and p.bank_detail_id like if(0=?,'%%',?)"+
    					" UNION ALL"+
    					" select count(payment_id) as count"+ 
    					" from test_make_payment p LEFT JOIN (test_supplier s)"+
    					" ON p.supplier_id=s.supplier_id "+
    					" where p.payment_date between if(''=?,'2000-01-01',STR_TO_DATE(?, '%d/%m/%Y')) and if(''=?,'2050-01-01',STR_TO_DATE(?, '%d/%m/%Y'))"+
    					" and s.business_id like if(?=0,'%%',?)"+
    					" and p.bank_detail_id like if(0=?,'%%',?)"+
    				" ) as m1";
    
    
    private static final String GET_BANK_LIST_BY_PAYMENT_TYPE="select bank_detail_id,bank_name"
    		+ " from bank_detail where business_id like if(?=0,'%%',?) and group_name=?";
    
    private static final String INSERT_DOCUMENT="insert into documents(doc_id,doc_type,fileName)"
    		+ " values(?,?,?)";
    
    
    private static final String GET_DOCUMENT_LIST="select id,doc_id,doc_type,fileName from documents where doc_id=? and doc_type=?";
    
    private static final String DELETE_DOCUMENT="delete from documents where id=?";
    
    
    public BankDetailDAOImpl() {
        con = DBUtil.getConnection();
    }
    
   

    @Override
    public int updateBankDetails(final BankDetailBean bean) throws Exception {
        (this.ps = this.con.prepareStatement("update bank_detail set bank_name=?,ifsc_code=?,"
        		+ " account_no=?,branch_name=?,nb_amount=?,business_id=? where bank_detail_id=?")).setString(1, bean.getBank_name());
        this.ps.setString(2, bean.getIfsc_code());
        this.ps.setString(3, bean.getAccount_no());
        this.ps.setString(4, bean.getBranch_name());
        this.ps.setDouble(5, bean.getAmount());
        this.ps.setInt(6, bean.getBusiness_id());
        this.ps.setInt(7, bean.getBank_detail_id());
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
	public int insertFileUploadData(int id, String type, String file_name) throws Exception {
		ps=con.prepareStatement(INSERT_DOCUMENT);
		ps.setInt(1, id);
		ps.setString(2, type);
		ps.setString(3, file_name);
		int count=ps.executeUpdate();
		return count;
	}

	@Override
	public List<Map<String, Object>> getDocumentList(int id, String type) throws Exception {
		ps=con.prepareStatement(GET_DOCUMENT_LIST);
		ps.setInt(1, id);
		ps.setString(2, type);
		rs=ps.executeQuery();
		List<Map<String,Object>> data=new ArrayList<>();
		while(rs.next()) {
			Map<String,Object> map=new HashMap<>();
			map.put("id", rs.getInt("id"));
			map.put("doc_id", rs.getInt("doc_id"));
			map.put("doc_type", rs.getString("doc_type"));
			map.put("fileName", rs.getString("fileName"));
			data.add(map);
		}
		return data;
	}



	@Override
	public int deleteDocumentFileName(int id) throws Exception {
		ps=con.prepareStatement(DELETE_DOCUMENT);
		ps.setInt(1, id);
		int count=ps.executeUpdate();
		return count;
	}
	
}
