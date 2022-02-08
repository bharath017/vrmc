package com.willka.soft.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.willka.soft.bean.UserBean;
import com.willka.soft.bean.UserDetailBean;
import com.willka.soft.util.DBUtil;

public class UserDAOImpl implements UserDAO{
	
	private Connection con=null;
	private PreparedStatement ps=null;
	private ResultSet rs=null;
	private Statement stmt=null;
	//write query part here
	
	private static final String INSERT_USER_DETAILS="insert into user(user_name,user_email,user_phone,user_type,"
			+ "user_address,user_login_id,plant_id,user_password,user_photo,business_id) values(?,?,?,?,?,?,?,?,?,?)";
	
	private static final String UPDATE_USER_DETAILS="update user set user_name=?,user_email=?,user_phone=?,"
			+ "user_type=?,plant_id=?,user_password=?,user_address=?,"
			+ "user_login_id=?,user_photo=?,business_id=? where user_id=?";
	
	private static final String CHANGE_USER_STATUS="update user set user_status=? where user_id=?";
	
	private static final String GET_SINGLE_USER_DETAILS="select user_id,user_name,"
			+ "	user_phone,user_email,user_password,user_type,business_id,u.plant_id,user_address,user_status,user_login_id,user_address,"
			+ "	(select plant_name from plant where plant_id=u.plant_id) as plant_name"
			+ " from user u"
			+ " where user_id=?";
	
	private static final String LOGIN_AS_USER="select * from user where user_login_id=? and user_password=? and user_status='active'";
	
	private static final String CHANGE_PASSWORD="update user set user_password=? where user_id=? and user_password=?";
	
	private static final String CHANGE_MP_PASSWORD="update marketing_person set mp_password=? where mp_id=? and mp_login_id=? and mp_password=?";
	
	private static final String LOGIN_AS_EMPLOYEE="select * from employee where employee_id=? and employee_password=?";
	
	private static final String LOGIN_AS_MARKETING="select * from marketing_person where mp_login_id=? and mp_password=?";
	
	private static final String GET_SINGLE_USER_DETAILS_BY_USER_ID="select user_id,user_name,user_email,user_type,"
			+ " user_login_id,user_phone,user_address "
			+ " from user where user_id=?";
	
	private static final String CHECK_ROLE_EXISTANCE="select role_id from user_role where user_id=? and role_id=?";
	
	private static final String INSERT_ROLE="insert into user_role(user_id,role_id) values(?,?)";
	
	private static final String GET_SINGLE_ROLES="select user_id,GROUP_CONCAT(role_id) as roles from user_role where user_id=?";
	
	private static final String DELETE_USER_ROLES="";
	
	private static final String GET_ALL_ROLES="select role_id from user_role where user_id=?";
	
	private static final String ADD_PLANT_ACCESS_SINGLE_VALUE="insert into user_plant_access(user_id,plant_id) values(?,?)";
	
	
	private static final String GET_ALL_USER_LIST_FOR_BILLING="select user_id,user_name,user_login_id,user_type,user_phone,user_status,"+
			" (select group_name from business_group where business_id=u.business_id) as group_name"+
			" from user u"+
			" where (u.user_name like ?"+
			" or u.user_phone like ?"+
			" or u.user_login_id like ?)"+
			" and business_id like if(?=0,'%%',?) and user_type not in ('gst','gstbilling','gstqc','sgst','gststore','gstaccount','gstadmin','gstmarketing')"+
			" order by user_name asc"+
			" limit ?,?";
	
	private static final String GET_ALL_USER_LIST_FOR_NON_BILLING="select user_id,user_name,user_login_id,user_type,user_phone,user_status,"+
			" (select group_name from business_group where business_id=u.business_id) as group_name"+
			" from user u"+
			" where (u.user_name like ?"+
			" or u.user_phone like ?"+
			" or u.user_login_id like ?)"+
			" and business_id like if(?=0,'%%',?) and"+
			" user_type not in ('billing','admin','marketing','qc','store','account','scheduling','purchasemanager','sales', 'sgst')"+
			" order by user_name asc"+
			" limit ?,?";
	
	private static final String COUNT_ALL_USER_LIST_BILLING="select count(user_id)"+
			" from user u"+
			" where (u.user_name like ?"+
			" or u.user_phone like ?"+
			" or u.user_login_id like ?)"+
			" and business_id like if(?=0,'%%',?) and user_type not in ('gst','gstbilling','gstqc','sgst','gststore','gstaccount','gstadmin','gstmarketing')";
	
	private static final String COUNT_ALL_USER_LIST_NON_BILLING="select count(user_id)"+
			" from user u"+
			" where (u.user_name like ?"+
			" or u.user_phone like ?"+
			" or u.user_login_id like ?)"+
			" and business_id like if(?=0,'%%',?) and user_type not in ('billing','admin','marketing','qc','store','account','scheduling','purchasemanager','sales','sgst')";
	

	
	
	public UserDAOImpl() {
		con=DBUtil.getConnection();
	}

	
	@Override
	public int insertUserDetails(UserBean bean) throws Exception {
		ps=con.prepareStatement(INSERT_USER_DETAILS);
		ps.setString(1, bean.getUser_name());
		ps.setString(2, bean.getUser_email());
		ps.setString(3, bean.getUser_phone());
		ps.setString(4, bean.getUser_type());
		ps.setString(5, bean.getUser_address());
		ps.setString(6, bean.getUser_login_id());
		ps.setInt(7, bean.getPlant_id());
		ps.setString(8, bean.getUser_password());
		ps.setString(9, bean.getUser_photo());
		ps.setInt(10, bean.getBusiness_id());
		int count=ps.executeUpdate();
		return count;
	}

	
	@Override
	public int updateUserDetails(UserBean bean) throws Exception {
		ps=con.prepareStatement(UPDATE_USER_DETAILS);
		ps.setString(1, bean.getUser_name());
		ps.setString(2, bean.getUser_email());
		ps.setString(3, bean.getUser_phone());
		ps.setString(4, bean.getUser_type());
		ps.setInt(5, bean.getPlant_id());
		ps.setString(6, bean.getUser_password());
		ps.setString(7, bean.getUser_address());
		ps.setString(8, bean.getUser_login_id());
		ps.setString(9, bean.getUser_photo());
		ps.setInt(10, bean.getBusiness_id());
		ps.setInt(11, bean.getUser_id());
		System.out.println(ps.toString());
		int count=ps.executeUpdate();
		return count;
	}

	
	@Override
	public int changeUserStatus(int user_id, String user_status) throws Exception {
		ps=con.prepareStatement(CHANGE_USER_STATUS);
		ps.setString(1, user_status);
		ps.setInt(2, user_id);
		int count=ps.executeUpdate();
		return count;
	}

	@Override
	public UserBean getSingleUserDetails(int user_id) throws Exception {
		ps=con.prepareStatement(GET_SINGLE_USER_DETAILS);
		ps.setInt(1, user_id);
		rs=ps.executeQuery();
		if(rs.next()) {
			UserBean bean=new UserBean();
			bean.setPlant_id(rs.getInt("plant_id"));
			bean.setUser_email(rs.getString("user_email"));
			bean.setUser_id(rs.getInt("user_id"));
			bean.setUser_name(rs.getString("user_name"));
			bean.setUser_password(rs.getString("user_password"));
			bean.setUser_phone(rs.getString("user_phone"));
			bean.setUser_status(rs.getString("user_status"));
			bean.setUser_login_id(rs.getString("user_login_id"));
			bean.setUser_type(rs.getString("user_type"));
			bean.setBusiness_id(rs.getInt("business_id"));
			bean.setUser_plant_name(rs.getString("plant_name"));
			bean.setUser_address(rs.getString("user_address"));
			return bean;
		}else {
			return null;
		}
	}


	@Override
	public UserDetailBean loginAsUser(String user_name, String password) throws Exception {
		ps=con.prepareStatement(LOGIN_AS_USER);
		ps.setString(1, user_name);
		ps.setString(2, password);
		rs=ps.executeQuery();
		if(rs.next()) {
			//get user details bean
			UserDetailBean bean=new UserDetailBean();
			bean.setUsertype(rs.getString("user_type"));
			bean.setUsername(rs.getString("user_login_id"));
			bean.setUsers_name(rs.getString("user_name"));
			bean.setPlant_id(rs.getInt("plant_id"));
			bean.setUser_email(rs.getString("user_email"));
			bean.setUser_id(rs.getInt("user_id"));
			return bean;
		}else {
			return null;
		}
	}


	@Override
	public int changePasword(int user_id, String old_password, String new_password) throws Exception {
		ps=con.prepareStatement(CHANGE_PASSWORD);
		ps.setString(1, new_password);
		ps.setInt(2, user_id);
		ps.setString(3, old_password);
		int count=ps.executeUpdate();
		return count;
	}


	@Override
	public UserDetailBean getEmployeeLogin(String employee_id, String password) throws Exception {
		ps=con.prepareStatement(LOGIN_AS_EMPLOYEE);
		ps.setString(1, employee_id);
		ps.setString(2, password);
		rs=ps.executeQuery();
		if(rs.next()) {
			UserDetailBean bean=new UserDetailBean();
			bean.setPlant_id(0);
			bean.setUser_email(rs.getString("employee_email"));
			bean.setUser_id(rs.getInt("e_id"));
			bean.setUsername(rs.getString("employee_id"));
			bean.setUsers_name(rs.getString("employee_name"));
			bean.setUsertype("employee");
			return bean;
		}else {
			return null;
		}
	}
	@Override
	public UserDetailBean getMarketingLogin(String user_name, String password) throws Exception {
		ps=con.prepareStatement(LOGIN_AS_MARKETING);
		ps.setString(1, user_name);
		ps.setString(2, password);
		rs=ps.executeQuery();
		if(rs.next()) {
			//get user details bean
			UserDetailBean bean=new UserDetailBean();
			bean.setUsertype(rs.getString("mp_type"));
			bean.setUsername(rs.getString("mp_login_id"));
			bean.setUsers_name(rs.getString("mp_name"));
			bean.setUser_email(rs.getString("mp_email"));
			bean.setUser_id(rs.getInt("mp_id"));
			return bean;
			
		}else {
			return null;
		}
	}
	@Override
	public int changeMpPassword(int user_id,String user_name, String old_password, String new_password)throws Exception {
		ps=con.prepareStatement(CHANGE_MP_PASSWORD);
		ps.setString(1, new_password);
		ps.setInt(2, user_id);
		ps.setString(3, user_name);
		ps.setString(4, old_password);
		int count=ps.executeUpdate();
		return count;
	}

	

	@Override
	public UserBean getSingleUserByUserID(int user_id) throws Exception {
		ps=con.prepareStatement(GET_SINGLE_USER_DETAILS_BY_USER_ID);
		ps.setInt(1, user_id);
		rs=ps.executeQuery();
		if(rs.next()) {
			UserBean bean=new UserBean();
			bean.setUser_id(rs.getInt("user_id"));
			bean.setUser_name(rs.getString("user_name"));
			bean.setUser_phone(rs.getString("user_phone"));
			bean.setUser_address(rs.getString("user_address"));
			bean.setUser_email(rs.getString("user_email"));
			bean.setUser_type(rs.getString("user_type"));
			return bean;
		}
		else
			return null;
	}


	@Override
	public int insertRoles(int user_id, int role_id) throws Exception {
		ps=con.prepareStatement(INSERT_ROLE);
		ps.setInt(1, user_id);
		ps.setInt(2, role_id);
		int count=ps.executeUpdate();
		return count;
	}


	@Override
	public boolean checkRoleExistance(int user_id,int role_id) throws Exception {
		ps=con.prepareStatement(CHECK_ROLE_EXISTANCE);
		ps.setInt(1, user_id);
		ps.setInt(2, role_id);
		rs=ps.executeQuery();
		if(rs.next())
			return true;
		else
			return false;
	}


	@Override
	public HashMap<String, Object> getSingleUserRoles(int user_id) throws Exception {
		ps=con.prepareStatement(GET_SINGLE_ROLES);
		ps.setInt(1, user_id);
		rs=ps.executeQuery();
		HashMap<String, Object> map=new HashMap<String, Object>();
		if(rs.next()) {
			map.put("user_id", rs.getInt("user_id"));
			map.put("roles", rs.getString("roles"));
		}
		return map;
	}


	@Override
	public int deleteRoles(int user_id, String roles) throws Exception {
		String role="("+roles+")";
		stmt=con.createStatement();
		int count=stmt.executeUpdate("delete from user_role where user_id="+user_id+" and role_id not in "+role);
		return count;
	}


	@Override
	public ArrayList<Integer> getAllRoles(int user_id) throws Exception {
		ps=con.prepareStatement(GET_ALL_ROLES);
		ps.setInt(1, user_id);
		rs=ps.executeQuery();
		ArrayList<Integer> list=new ArrayList<Integer>();
		while(rs.next()) {
			list.add(rs.getInt(1));
		}
		return list;
	}


	
	public int updateRoleDetails(int user_id,String roles)throws Exception {
		//split the string 
		String role[]=roles.split(",");
		int count=0;
		for(String r:role) {
			//now check the available data
			int role_id=Integer.parseInt(r);
			if(this.checkRoleExistance(user_id, role_id)==false) 
				this.insertRoles(user_id, role_id);
			
			//after delete all the role except that role
			int delete=this.deleteRoles(user_id, roles);
			count++;
		}
		return count;
	}



	@Override
	public List<Map<String, Object>> getAllUserList(String search, int business_id, String type, int start, int length)
			throws Exception {
		if(type.equals("billing")) {
			ps=con.prepareStatement(GET_ALL_USER_LIST_FOR_BILLING);
		}else {
			ps=con.prepareStatement(GET_ALL_USER_LIST_FOR_NON_BILLING);
		}
		System.out.println("coming here");
		ps.setString(1, "%"+search+"%");
		ps.setString(2, "%"+search+"%");
		ps.setString(3, "%"+search+"%");
		ps.setInt(4, business_id);
		ps.setInt(5, business_id);
		ps.setInt(6, start);
		ps.setInt(7, length);
		rs=ps.executeQuery();
		List<Map<String,Object>> userList=new ArrayList<Map<String,Object>>();
		while(rs.next()) {
			Map<String,Object> userData=new HashMap<String, Object>();
			userData.put("user_name", rs.getString("user_name"));
			userData.put("user_login_id", rs.getString("user_login_id"));
			userData.put("user_phone", rs.getString("user_phone"));
			userData.put("group_name", rs.getString("group_name"));
			userData.put("user_type", rs.getString("user_type"));
			userData.put("user_id", rs.getInt("user_id"));
			userData.put("user_status", rs.getString("user_status"));
			userList.add(userData);
		}
		return userList;
	}


	@Override
	public int countAllUserList(String search, int business_id, String type) throws Exception {
		if(type.equals("billing")) {
			ps=con.prepareStatement(COUNT_ALL_USER_LIST_BILLING);
		}else {
			ps=con.prepareStatement(COUNT_ALL_USER_LIST_NON_BILLING);
		}
		ps.setString(1, "%"+search+"%");
		ps.setString(2, "%"+search+"%");
		ps.setString(3, "%"+search+"%");
		ps.setInt(4, business_id);
		ps.setInt(5, business_id);
		rs=ps.executeQuery();
		if(rs.next())
			return rs.getInt(1);
		else
			return 0;
	}


	


}