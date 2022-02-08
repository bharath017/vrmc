package com.willka.soft.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.willka.soft.bean.ContactPerson;
import com.willka.soft.bean.CustomerBean;
import com.willka.soft.bean.ProjectBlock;
import com.willka.soft.bean.SiteDetailBean;
import com.willka.soft.util.DBUtil;

public class CustomerDaoImpl implements CustomerDAO{
	
	private Connection con=null;
	
	private PreparedStatement ps=null;
	
	private ResultSet rs=null;
	
	
	private static final  String INSERT_QUERY="INSERT INTO customer (customer_name, customer_phone,"
			+ " customer_email, customer_gstin, customer_panno,"
			+ " customer_address, mp_id, business_id, opening_balance,last_dispatch_date,plant_id) VALUES (?,?,?,?,?,?,?,?,?,?,?)";
	
	private static final String UPDATE_CUSTOMER_DETAILS="update customer set customer_name=?,customer_phone=?,customer_email=?,"
			+ "customer_gstin=?,customer_panno=?,customer_address=?,mp_id=?,business_id=?,opening_balance=?,last_dispatch_date=?,plant_id=? where customer_id=?";
	
	private static final String INSERT_SITE_DETAILS="insert into site_detail(site_name,site_address,customer_id) values(?,?,?)";
	
	private static final String UPDATE_SITE_DETAILS="update site_detail set site_name=?,site_address=?,tally_ladger=? where site_id=?";
	
	private static final String UPDATE_CUSTOMER_STATUS="update customer set customer_status=? where customer_id=?";
	
	private static final String GET_MAX_ID="select max(customer_id) as customer_id from  customer";
	
	private static final String SELECT_SITE_USING_CUSTOMER="select * from site_detail where customer_id=?";
	
	private static final String GET_SITE_ADDRESS="select * from site_detail where site_id=?";
	
	private static final String CHANGE_SITE_STATUS="update site_detail set site_status=? where site_id=?";
	
	private static final String GET_SINGLE_CUSTOMER_DETAILS="select * from customer where customer_id=?";
	
	private static final String UPDATE_TALLY_LADGER="update site_detail set tally_ladger=? where site_id=?";
	
	private static final String INSERT_CONTACT_PERSON="insert into customer_contact_person(contact_name,phone,email,customer_id) values(?,?,?,?)";
	
	private static final String UPDATE_CONTACT_PERSON="update customer_contact_person set contact_name=?,phone=?,email=? where contact_id=?";
	
	private static final String DELETE_CONTACT_PERSON="delete from customer_contact_person where contact_id=?";
	
	private static final String INSERT_PROJECT_BLOCK="insert into customer_site_block(block_name,site_id) values(?,?)";
	
	private static final String DELETE_PROJECT_BLOCK="delete from customer_site_block where block_id=?";
	
	private static final String GET_ALL_PROJECT_BLOCK="select * from customer_site_block where site_id=?";

	private static final String UPDATE_CREDIT_LIMIT = "update customer set credit_limit=? where customer_id=?";
	
	private static final String GET_ALL_CUSTOMER_LIST="select c.*,m.mp_name,b.group_name"
			+ " from customer c LEFT JOIN (marketing_person m,business_group b) "
			+ " ON c.mp_id=m.mp_id and c.business_id=b.business_id"
			+ " where customer_name like ? "
			+ " and customer_phone like ? "
			+ " and customer_name like ?"
			+ " and customer_status=? and c.business_id like if(0=?,'%%',?) and c.plant_id like if(?=0,'%%',?) order by customer_name asc "
			+ " limit ?,?";
	private static final String COUNT_ALL_CUSTOMER_LIST="select count(customer_id) from customer "
			+ " where customer_name like ? "
			+ " and customer_phone like ? "
			+ " and customer_name like ?"
			+ " and customer_status=? and business_id like if(0=?,'%%',?) and plant_id like if(?=0,'%%',?) order by customer_name asc";
	
	private static final String GET_MARKETING_PERSON_DETAILS_OF_CUSTOMER="select c.mp_id,m.mp_name"
			+ " from customer c,marketing_person m"
			+ " where c.mp_id=m.mp_id"
			+ " and  customer_id=?";
	
//	private static final String GET_DASHBOARD_DETAILS="";
	
	private static final String GET_CUSTOMER_LIST_BY_GROUP_WISE="select customer_id,customer_name"
			+ " from customer  "
			+ " where  customer_status='active' and  business_id like if(?=0,'%%',?)";
	
	
	
	
	public CustomerDaoImpl() {
		con=DBUtil.getConnection();
	}

	@Override
	public int addCustomerDetails(CustomerBean bean) throws Exception {
		ps=con.prepareStatement(INSERT_QUERY);
		ps.setString(1,bean.getCustomer_name());
		ps.setString(2, bean.getCustomer_phone());
		ps.setString(3, bean.getCustomer_email());
		ps.setString(4, bean.getCustomer_gstin());
		ps.setString(5, bean.getCustomer_panno());
		ps.setString(6, bean.getCustomer_address());
		ps.setInt(7, bean.getMp_id());
		ps.setInt(8, bean.getBusiness_id());
		ps.setDouble(9, bean.getOpening_balance());
		ps.setString(10, bean.getLast_dispatch_date());
		ps.setInt(11, bean.getPlant_id());
		int count=ps.executeUpdate();
		return count;
	}

	@Override
	public int insertSiteDetails(SiteDetailBean bean) throws Exception {
		ps=con.prepareStatement(INSERT_SITE_DETAILS);
		ps.setString(1, bean.getSite_name());
		ps.setString(2, bean.getSite_address());
		ps.setInt(3, bean.getCustomer_id());
		int count=ps.executeUpdate();
		return count;
	}

	@Override
	public int getMaxCustomerId() throws Exception {
		ps=con.prepareStatement(GET_MAX_ID);
		rs=ps.executeQuery();
		if(rs.next()) {
			return rs.getInt("customer_id");
		}
		else	
		 return 0;
	}

	@Override
	public ArrayList<SiteDetailBean> getAllSiteAddress(int customer_id) throws Exception {
		ps=con.prepareStatement(SELECT_SITE_USING_CUSTOMER);
		ps.setInt(1,customer_id);
		rs=ps.executeQuery();
		ArrayList<SiteDetailBean> site_list=new ArrayList<>();
		while(rs.next()) {
			SiteDetailBean bean=new SiteDetailBean();
			bean.setSite_id(rs.getInt("site_id"));
			bean.setSite_name(rs.getString("site_name"));
			bean.setSite_address(rs.getString("site_address"));
			bean.setTally_ladger(rs.getString("tally_ladger"));
			site_list.add(bean);
		}
		return site_list;
	}

	@Override
	public SiteDetailBean getSiteDetailsUsingId(int site_id) throws Exception {
		ps=con.prepareStatement(GET_SITE_ADDRESS);
		ps.setInt(1, site_id);
		rs=ps.executeQuery();
		if(rs.next()) {
			SiteDetailBean bean=new SiteDetailBean();
			bean.setCustomer_id(rs.getInt("customer_id"));
			bean.setSite_id(rs.getInt("site_id"));
			bean.setSite_name(rs.getString("site_name"));
			bean.setSite_address(rs.getString("site_address"));
			bean.setTally_ladger(rs.getString("tally_ladger"));
			return bean;
		}
		else
			return null;
	}

	@Override
	public int updateCustomerDetails(CustomerBean bean) throws Exception {
		ps=con.prepareStatement(UPDATE_CUSTOMER_DETAILS);
		ps.setString(1,bean.getCustomer_name());
		ps.setString(2, bean.getCustomer_phone());
		ps.setString(3, bean.getCustomer_email());
		ps.setString(4, bean.getCustomer_gstin());
		ps.setString(5, bean.getCustomer_panno());
		ps.setString(6, bean.getCustomer_address());
		ps.setInt(7, bean.getMp_id());
		ps.setInt(8, bean.getBusiness_id());
		ps.setDouble(9, bean.getOpening_balance());
		ps.setString(10, bean.getLast_dispatch_date());
		ps.setInt(11, bean.getPlant_id());
		ps.setInt(12, bean.getCustomer_id());
		int count=ps.executeUpdate();
		return count;
	}

	@Override
	public int changeCustomerStatus(int customer_id, String customer_status) throws Exception {
		ps=con.prepareStatement(UPDATE_CUSTOMER_STATUS);
		ps.setString(1, customer_status);
		ps.setInt(2, customer_id);
		int count=ps.executeUpdate();
		return count;
	}

	@Override
	public int updateSiteDetails(SiteDetailBean bean) throws Exception {
		ps=con.prepareStatement(UPDATE_SITE_DETAILS);
		ps.setString(1, bean.getSite_name());
		ps.setString(2, bean.getSite_address());
		ps.setString(3, bean.getTally_ladger());
		ps.setInt(4, bean.getSite_id());
		int count=ps.executeUpdate();
		return count;
	}

	@Override
	public int changeSiteStatus(int site_id, String site_status) throws Exception {
		ps=con.prepareStatement(CHANGE_SITE_STATUS);
		ps.setString(1, site_status);
		ps.setInt(2, site_id);
		int count=ps.executeUpdate();
		return count;
	}

	@Override
	public CustomerBean getSingleCustomerDetails(int customer_id) throws Exception {
		ps=con.prepareStatement(GET_SINGLE_CUSTOMER_DETAILS);
		ps.setInt(1, customer_id);
		rs=ps.executeQuery();
		if(rs.next()) {
			CustomerBean bean=new CustomerBean();
			bean.setCustomer_id(rs.getInt("customer_id"));
			bean.setCustomer_name(rs.getString("customer_name"));
			bean.setCustomer_address(rs.getString("customer_address"));
			bean.setCustomer_gstin(rs.getString("customer_gstin"));
			bean.setCustomer_email(rs.getString("customer_email"));
			bean.setCustomer_panno(rs.getString("customer_panno"));
			bean.setCustomer_phone(rs.getString("customer_phone"));
			return bean;
		}
		else
			return null;
	}

	@Override
	public int updateTallyLedger(int site_id, String tally_ledger) throws Exception {
		ps=con.prepareStatement(UPDATE_TALLY_LADGER);
		ps.setString(1, tally_ledger);
		ps.setInt(2, site_id);
		int count=ps.executeUpdate();
		return count;
	}

	@Override
	public int insertCotactPerson(ContactPerson bean) throws Exception {
		ps=con.prepareStatement(INSERT_CONTACT_PERSON);
		ps.setString(1, bean.getContact_name());
		ps.setString(2, bean.getPhone());
		ps.setString(3, bean.getEmail());
		ps.setInt(4, bean.getCustomer_id());
		int count=ps.executeUpdate();
		return count;
	}

	@Override
	public int updateContactPerson(ContactPerson bean) throws Exception {
		ps=con.prepareStatement(UPDATE_CONTACT_PERSON);
		ps.setString(1, bean.getContact_name());
		ps.setString(2, bean.getPhone());
		ps.setString(3, bean.getEmail());
		ps.setInt(4, bean.getContact_id());
		int count=ps.executeUpdate();
		return count;
	}

	@Override
	public int deleteContactPerson(int contact_id) throws Exception {
		ps=con.prepareStatement(DELETE_CONTACT_PERSON);
		ps.setInt(1, contact_id);
		int count=ps.executeUpdate();
		return count;
	}

	@Override
	public int insertProjectBlock(ProjectBlock bean) throws Exception {
		ps=con.prepareStatement(INSERT_PROJECT_BLOCK);
		ps.setString(1, bean.getBlock_name());
		ps.setInt(2, bean.getSite_id());
		int count=ps.executeUpdate();
		return count;
	}

	@Override
	public int deleteProjectBlock(int block_id) throws Exception {
		ps=con.prepareStatement(DELETE_PROJECT_BLOCK);
		ps.setInt(1, block_id);
		int count=ps.executeUpdate();
		return count;
	}

	@Override
	public ArrayList<ProjectBlock> getAllProjectBlock(int site_id) throws Exception {
		ps=con.prepareStatement(GET_ALL_PROJECT_BLOCK);
		ps.setInt(1, site_id);
		rs=ps.executeQuery();
		ArrayList<ProjectBlock> list=new ArrayList<>();
		while(rs.next()) {
			ProjectBlock block=new ProjectBlock();
			block.setBlock_id(rs.getInt("block_id"));
			block.setBlock_name(rs.getString("block_name"));
			block.setSite_id(rs.getInt("site_id"));
			list.add(block);
		}
		return list;
	}

	public int updateCreditLimit(int customer_id, double credit_limit) throws Exception{
		ps=con.prepareStatement(UPDATE_CREDIT_LIMIT);
		ps.setDouble(1, credit_limit);
		ps.setInt(2, customer_id);
		int count=ps.executeUpdate();
		return count;
	}
	
	@Override
	public ArrayList<HashMap<String, Object>> getAllCustomerList(String name, String phone, String status, String alp,int business_id,int plant_id,
			int start, int length) throws Exception {
		ps=con.prepareStatement(GET_ALL_CUSTOMER_LIST);
		ps.setString(1, "%"+name+"%");
		ps.setString(2, "%"+phone+"%");
		ps.setString(3, alp+"%");
		ps.setString(4, status);
		ps.setInt(5, business_id);
		ps.setInt(6, business_id);
		ps.setInt(7, plant_id);
		ps.setInt(8, plant_id);
		ps.setInt(9, start);
		ps.setInt(10, length);
		rs=ps.executeQuery();
		ArrayList<HashMap<String, Object>> list=new ArrayList<HashMap<String,Object>>();
		while(rs.next()) {
			HashMap<String, Object> map=new HashMap<String, Object>();
			map.put("customer_id", rs.getInt("customer_id"));
			map.put("customer_name", rs.getString("customer_name"));
			map.put("customer_phone", rs.getString("customer_phone"));
			map.put("customer_address", rs.getString("customer_address"));
			map.put("customer_email", rs.getString("customer_email"));
			map.put("customer_status", rs.getString("customer_status"));
			map.put("customer_gstin", rs.getString("customer_gstin"));
			map.put("customer_pan", rs.getString("customer_panno"));
			map.put("mp_name", rs.getString("mp_name"));
			map.put("group_name", rs.getString("group_name"));
			map.put("opening_balance", rs.getDouble("opening_balance"));
			list.add(map);
		}
		return list;
	}
	
	@Override
	public int countAllCustomerList(String name, String phone, String status, String alp,int business_id, int plant_id) throws Exception {
		ps=con.prepareStatement(COUNT_ALL_CUSTOMER_LIST);
		ps.setString(1, "%"+name+"%");
		ps.setString(2, "%"+phone+"%");
		ps.setString(3, alp+"%");
		ps.setString(4, status);
		ps.setInt(5, business_id);
		ps.setInt(6, business_id);
		ps.setInt(7, plant_id);
		ps.setInt(8, plant_id);
		rs=ps.executeQuery();
		if(rs.next())
			return rs.getInt(1);
		else
			return 0;
	}

	@Override
	public Map<String,Object> getMarketingPersonDetails(int customer_id) throws Exception {
		ps=con.prepareStatement(GET_MARKETING_PERSON_DETAILS_OF_CUSTOMER);
		ps.setInt(1, customer_id);
		rs=ps.executeQuery();
		Map<String,Object> map=new HashMap<String, Object>();
		if(rs.next()) {
			map.put("mp_id", rs.getInt("mp_id"));
			map.put("mp_name", rs.getString("mp_name"));
			return map;
		}else{
			return null;
		}
	}

	@Override
	public Map<String, Object> getDashboardDetails() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Map<String, Object>> getCustomerListByBusinessGroup(int business_id) throws Exception {
		ps=con.prepareStatement(GET_CUSTOMER_LIST_BY_GROUP_WISE);
		ps.setInt(1, business_id);
		ps.setInt(2, business_id);
		rs=ps.executeQuery();
		List<Map<String,Object>> list=new ArrayList<Map<String,Object>>();
		while(rs.next()) {
			Map<String,Object> map=new HashMap<String, Object>();
			map.put("customer_id", rs.getInt("customer_id"));
			map.put("customer_name", rs.getString("customer_name"));
			list.add(map);
		}
		return list;
	}
	
}
