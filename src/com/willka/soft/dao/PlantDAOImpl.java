package com.willka.soft.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.willka.soft.bean.PlantBean;
import com.willka.soft.bean.PlantDeliveryAddressBean;
import com.willka.soft.util.DBUtil;


public class PlantDAOImpl implements PlantDAO  {
	
	
private Connection conn;	


private Connection con=null;
private PreparedStatement ps=null;
private ResultSet rs=null;

//declare all database variable here

private static final String SELECT_QUERY="select * from plant";
private static final String INSERT_PLANT="insert into plant(plant_name,plant_address,"
		+ "plant_manager,plant_phones,plant_email,plant_domain,plant_gstin,plant_cst,plant_panno,"
		+ "plant_transport,plant_regno,delivery_address,business_id) values(?,?,?,?,?,?,?,?,?,?,?,?,?)";
private static final String UPDATE_PLANT="update plant set plant_name=?,plant_address=?,plant_manager=?,plant_phones=?,"
		+ "plant_email=?,plant_domain=?,plant_gstin=?,plant_cst=?,plant_panno=?,"
		+ "plant_transport=?,plant_regno=?,delivery_address=?,business_id=? where plant_id=?";
private static final String CHECK_PLANT_EXISTANCE ="select * from plant where plant_name=?";
private static final String UPDATE_ONLY_MANAGER="update plant set plant_manager_id=? where plant_id=?";
private static final String GET_MAX_PLANT_ID="select max(plant_id) from plant";
private static final String INSERT_DELIVERY_ADDRESS="insert into plant_delivery_address(plant_id,delivery_address) values(?,?)";
private static final String UPDATE_DELIVERY_ADDRESS="update plant_delivery_address set delivery_address=? where pl_delivery_add_id=?";
private static final String CHANGE_DELIVERY_STATUS="update plant_delivery_address set status=if(status='active','inactive','active') where pl_delivery_add_id=?";
private static final String GET_PLANT_DELIVERY_ADDRESS="select * from plant_delivery_address where pl_delivery_add_id=?";
private static final String GET_ALL_PLANT_DELIVERY_ADDRESS="select * from plant_delivery_address where plant_id=?";
private static final String GET_PLANT_LIST_BY_BUSINESS_ID="select plant_id,plant_name from plant where business_id=?";

private static final String GET_PLANT_LIST_FOR_SELECT="select plant_id,plant_name from plant"
		+ "	 where plant_id like if(-1=?,'%%',if(0=?,'%%',?)) and business_id like if(0=?,'%%',?)"
		+ "  order by plant_name asc";



public PlantDAOImpl()
{
	conn = DBUtil.getConnection();
}

public int insertPlant(PlantBean bean)throws Exception
{
		int count=0;
        ps = conn.prepareStatement(INSERT_PLANT);
        ps.setString( 1, bean.getPlant_name());
        ps.setString( 2, bean.getPlant_address());
        ps.setString( 3, bean.getPlant_manager());
        ps.setString( 4, bean.getPlant_phones());
        ps.setString(5, bean.getPlant_email());
        ps.setString(6, bean.getPlant_domain());
        ps.setString(7, bean.getPlant_gstin());
        ps.setString(8, bean.getPlant_cst());
        ps.setString(9, bean.getPlant_panno());
        ps.setString(10, bean.getPlant_transport());
        ps.setString(11, bean.getPlant_regno());
        ps.setString(12, bean.getBilling_address());
        ps.setInt(13, bean.getBusiness_id());
        count=ps.executeUpdate();
		return count;
	}


public int updatePlant(PlantBean bean)throws Exception
{
	int count=0;
    ps = conn.prepareStatement(UPDATE_PLANT);
    ps.setString(1, bean.getPlant_name());
    ps.setString(2, bean.getPlant_address());
    ps.setString(3, bean.getPlant_manager());
    ps.setString(4, bean.getPlant_phones());
    ps.setString(5, bean.getPlant_email());
    ps.setString(6, bean.getPlant_domain());
    ps.setString(7, bean.getPlant_gstin());
    ps.setString(8, bean.getPlant_cst());
    ps.setString(9, bean.getPlant_panno());
    ps.setString(10, bean.getPlant_transport());
    ps.setString(11, bean.getPlant_regno());
    ps.setString(12, bean.getBilling_address());
    ps.setInt(13, bean.getBusiness_id());
    ps.setInt(14, bean.getPlant_id());
    count=ps.executeUpdate();
	return count;
}

        
        
public int deletePlant(int plant_id)throws Exception
{
	
        String query ="delete from plant where plant_id=?";
        PreparedStatement ps = conn.prepareStatement(query);
        ps.setInt(1, plant_id);
        return ps.executeUpdate();
        
       
}    
	


public  ArrayList<PlantBean>getAllPlantBean()throws Exception

{
	ArrayList<PlantBean> plant_list = new ArrayList<PlantBean>();
	
    
        Statement statement = conn.createStatement();
        ResultSet rs = statement.executeQuery("select * from plant order by plant_id desc");
        
        while(rs.next()) {
            PlantBean bean = new PlantBean();
            bean.setPlant_id(rs.getInt("plant_id"));
            bean.setPlant_name(rs.getString("plant_name"));
            bean.setPlant_address(rs.getString("plant_address"));
            bean.setPlant_manager(rs.getString("plant_manager"));
            bean.setPlant_phones(rs.getString("plant_phones"));
            bean.setPlant_email(rs.getString("plant_email"));
            bean.setPlant_domain(rs.getString("plant_domain"));
            bean.setPlant_gstin(rs.getString("plant_gstin"));
            bean.setPlant_cst(rs.getString("plant_cst"));
            bean.setPlant_panno(rs.getString("plant_panno"));
            bean.setPlant_transport(rs.getString("plant_transport"));
            bean.setPlant_regno(rs.getString("plant_regno"));
            plant_list.add(bean);
    }
        	return plant_list;
}


public PlantBean getplantById(int plant_id)throws Exception
{
	PlantBean bean = new PlantBean();
	
    
        String query = "select * from plant where plant_id=?";
        PreparedStatement ps = conn.prepareStatement( query );
        ps.setInt(1,plant_id);
        ResultSet rs = ps.executeQuery();
        
        while( rs.next() ) {
        	
             bean.setPlant_id(rs.getInt("plant_id"));
             bean.setPlant_name(rs.getString("plant_name"));
             bean.setPlant_address(rs.getString("plant_address"));
             bean.setPlant_manager(rs.getString("plant_manager"));
        }
       
	return bean ;
}


public List<PlantBean> getAllPlantList() throws Exception {
	int count=0;
	//get database variable
	con=DBUtil.getConnection();
	ps=con.prepareStatement(SELECT_QUERY,ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
	rs=ps.executeQuery();
	//create ArrayList object with PlantBean object
	List<PlantBean> plant_list=new ArrayList<PlantBean>();
	while(rs.next()){
		count++;
		//create plantbean object
		PlantBean bean=new PlantBean();
		bean.setPlant_id(rs.getInt("plant_id"));
		bean.setPlant_name(rs.getString("plant_name"));
		plant_list.add(bean);
	}
	if(count>0){
		return plant_list;
	}
	else{
		return null;
	}
}

public boolean checkPlantExistance(String plant_name) throws SQLException {
	con=DBUtil.getConnection();
	ps=con.prepareStatement(CHECK_PLANT_EXISTANCE,ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
	ps.setString(1, plant_name);
	rs=ps.executeQuery();
	if(rs.next()){
		return true;
	}
	else{
		return false;
	}

	
}

@Override
public int updateOnlyManager(String plant_manager_id,int plant_id) throws Exception {
	con=DBUtil.getConnection();
	ps=con.prepareStatement(UPDATE_ONLY_MANAGER);
	ps.setString(1, plant_manager_id);
	ps.setInt(2, plant_id);
	int count=ps.executeUpdate();
	
	return count;
}

@Override
public int getMaxPlantId() throws Exception {
	con=DBUtil.getConnection();
	ps=con.prepareStatement(GET_MAX_PLANT_ID);
	rs=ps.executeQuery();
	if(rs.next())
		return rs.getInt(1);
	else
		return 0;
}

@Override
public int insertPlantDeliveryAddress(PlantDeliveryAddressBean bean) throws Exception {
	con=DBUtil.getConnection();
	ps=con.prepareStatement(INSERT_DELIVERY_ADDRESS);
	ps.setInt(1, bean.getPlant_id());
	ps.setString(2, bean.getDelivery_address());
	int count=ps.executeUpdate();
	return count;
}

@Override
public int updatePlantDeliveryAddress(PlantDeliveryAddressBean bean) throws Exception {
	con=DBUtil.getConnection();
	ps=con.prepareStatement(UPDATE_DELIVERY_ADDRESS);
	ps.setString(1, bean.getDelivery_address());
	ps.setInt(2, bean.getPl_delivery_address_id());
	int count=ps.executeUpdate();
	return count;
}

@Override
public int changeDeliveryAddressStatus(int pl_delivery_address_id) throws Exception {
	con=DBUtil.getConnection();
	ps=con.prepareStatement(CHANGE_DELIVERY_STATUS);
	ps.setInt(1, pl_delivery_address_id);
	int count=ps.executeUpdate();
	return count;
}

@Override
public PlantDeliveryAddressBean getPlantDeliveryAddressById(int pl_delivery_address_id) throws Exception {
	con=DBUtil.getConnection();
	ps=con.prepareStatement(GET_PLANT_DELIVERY_ADDRESS);
	ps.setInt(1, pl_delivery_address_id);
	rs=ps.executeQuery();
	if(rs.next()) {
		PlantDeliveryAddressBean bean=new PlantDeliveryAddressBean();
		bean.setDelivery_address(rs.getString("delivery_address"));
		bean.setPl_delivery_address_id(rs.getInt("pl_delivery_add_id"));
		bean.setPlant_id(rs.getInt("plant_id"));
		bean.setStatus(rs.getString("status"));
		return bean;
	}else
		return null;
}

@Override
public ArrayList<PlantDeliveryAddressBean> getAllDevlieryAddressById(int plant_id) throws Exception {
	con=DBUtil.getConnection();
	ps=con.prepareStatement(GET_ALL_PLANT_DELIVERY_ADDRESS);
	ps.setInt(1, plant_id);
	//System.out.println(ps.toString());
	rs=ps.executeQuery();
	ArrayList<PlantDeliveryAddressBean> list=new ArrayList<PlantDeliveryAddressBean>();
	while(rs.next()) {
		PlantDeliveryAddressBean bean=new PlantDeliveryAddressBean();
		bean.setDelivery_address(rs.getString("delivery_address"));
		bean.setPl_delivery_address_id(rs.getInt("pl_delivery_add_id"));
		bean.setPlant_id(rs.getInt("plant_id"));
		list.add(bean);
	}
	return list;
}


@Override
public List<Map<String, Object>> getPlantDetailsByBusinessId(int business_id) throws Exception {
	con=DBUtil.getConnection();
	ps=con.prepareStatement(GET_PLANT_LIST_BY_BUSINESS_ID);
	ps.setInt(1, business_id);
	rs=ps.executeQuery();
	List<Map<String,Object>> list=new ArrayList<Map<String,Object>>();
	while(rs.next()) {
		Map<String,Object> data=new HashMap<String, Object>();
		data.put("plant_id", rs.getInt("plant_id"));
		data.put("plant_name", rs.getString("plant_name"));
		list.add(data);
	}
	return list;
}	


@Override
public HashMap<Integer, String> getPlantListForSelect(int plant_id, int business_id) throws Exception {
	con=DBUtil.getConnection();
	ps=con.prepareStatement(GET_PLANT_LIST_FOR_SELECT);
	ps.setInt(1, plant_id);
	ps.setInt(2, plant_id);
	ps.setInt(3, plant_id);
	ps.setInt(4,business_id);
	ps.setInt(5, business_id);
	rs=ps.executeQuery();
	HashMap<Integer, String> map=new HashMap<Integer, String>();
	while(rs.next()) {
		map.put(rs.getInt("plant_id"), rs.getString("plant_name"));
	}
	return map;
}
	
}