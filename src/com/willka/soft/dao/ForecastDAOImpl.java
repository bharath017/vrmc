package com.willka.soft.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.willka.soft.bean.ForecastBean;
import com.willka.soft.bean.ForecastItemBean;
import com.willka.soft.bean.SalesTargetBean;
import com.willka.soft.util.DBUtil;

public class ForecastDAOImpl implements ForecastDAO {

	private Connection con=null;
	private PreparedStatement ps=null;
	private ResultSet rs=null;
	
	
	private static final String INSERT_FORECAST="insert into forecast(customer_id,site_id,plant_id,mp_id,project_quantity) values(?,?,?,?,?)";
	
	private static final String UPDATE_FORECAST="update forecast set customer_id=?,site_id=?,plant_id=?,mp_id=?,project_quantity=? where forecast_id=?";
	
	private static final String INSERT_SALES_TARGET="INSERT into sales_target(mp_id,date,target_quantity) values(?,?,?)";
	
	private static final String DELETE_TARGET="delete from sales_target where target_id=?";
	
	private static final String INSERT_FORECAST_ITEM="insert into forecast_item (forecast_id,monthly_forecast,forecast_date,average_c1) values(?,?,?,?)";
	
	private static final String DELETE_FORECAST="delete from forecast where forecast_id=?";
	
	public ForecastDAOImpl() {
		con=DBUtil.getConnection();
	}
	
	@Override
	public int insertForecast(ForecastBean bean) throws Exception {
		ps=con.prepareStatement(INSERT_FORECAST);
		ps.setInt(1, bean.getCustomer_id());
		ps.setInt(2, bean.getSite_id());
		ps.setInt(3, bean.getPlant_id());
		ps.setInt(4, bean.getMp_id());
		ps.setDouble(5, bean.getProject_quantity());
		/*ps.setDouble(7, bean.getForecast_quantity());*/
		int count=ps.executeUpdate();
		return count;
	}
	@Override
	public int updateForecast(ForecastBean bean) throws Exception {
		ps=con.prepareStatement(UPDATE_FORECAST);
		ps.setInt(1, bean.getCustomer_id());
		ps.setInt(2, bean.getSite_id());
		ps.setInt(3, bean.getPlant_id());
		ps.setInt(4, bean.getMp_id());
		ps.setDouble(5, bean.getProject_quantity());
		/*ps.setDouble(7, bean.getForecast_quantity());*/
		ps.setInt(6, bean.getForecast_id());
		int count=ps.executeUpdate();
		return count;
	}

	
	@Override
	public int insertForecastItem(ForecastItemBean been)throws Exception {
		ps=con.prepareStatement(INSERT_FORECAST_ITEM);
		ps.setInt(1, been.getForecast_id());
		ps.setDouble(2, been.getForecast_quantity());
		ps.setString(3, been.getForecast_date());
		ps.setDouble(4, been.getAverage_c1());
		int count=ps.executeUpdate();
		return count;
	}
	@Override
	public int updateWeeklyForecast(ForecastItemBean been)throws Exception {
		String forecast_type=been.getType();
		ps=con.prepareStatement("update forecast_item set "+forecast_type+" =? where forecast_item_id=?");
		ps.setDouble(1, been.getForecast_quantity());
		ps.setInt(2, been.getForecast_id());
		int count=ps.executeUpdate();
		return count;
	}
	
	@Override
	public int insertSalesTarget(SalesTargetBean bean) throws Exception {
		ps=con.prepareStatement(INSERT_SALES_TARGET);
		ps.setInt(1, bean.getMp_id());
		ps.setString(2, bean.getDate());
		ps.setDouble(3, bean.getQuantity());
		int count=ps.executeUpdate();
		return count;
	}
	@Override
	public int deleteTarget(int target_id) throws Exception{
		ps=con.prepareStatement(DELETE_TARGET);
		ps.setInt(1, target_id);
		int count=ps.executeUpdate();
		return count;
	}
	
	@Override
	public int deleteForecast(int forecast_id) throws Exception{
		ps=con.prepareStatement(DELETE_FORECAST);
		ps.setInt(1, forecast_id);
		int count=ps.executeUpdate();
		return count;
	}

}
