package com.willka.soft.dao;

import com.willka.soft.bean.ForecastBean;
import com.willka.soft.bean.ForecastItemBean;
import com.willka.soft.bean.SalesTargetBean;

public interface ForecastDAO {

	public int insertForecast(ForecastBean bean)throws Exception;
	
	public int updateForecast(ForecastBean bean)throws Exception;
	
	public int insertForecastItem(ForecastItemBean been)throws Exception;
	
	public int updateWeeklyForecast(ForecastItemBean been)throws Exception;
	
	public int insertSalesTarget(SalesTargetBean bean) throws Exception;
	
	public int deleteTarget(int target_id) throws Exception;
	
	public int deleteForecast(int forecast_id) throws Exception;
}
