package com.willka.soft.dao;

import java.util.List;

import com.willka.soft.bean.CubeTestBean;
import com.willka.soft.bean.CubeTestItemBean;

public interface CubeTestDAO {

	public int insertCubeTest(CubeTestBean bean)throws Exception;
	
	public int updateCubeTest(CubeTestBean bean)throws Exception;
	
	public int insertCubeTestItem(CubeTestItemBean bean)throws Exception;
	
	public int updateCubeTestItem(CubeTestItemBean bean)throws Exception;
	
	public int cancelReport(int tst_id)throws Exception;
	
	public int getMaxTestIdUsingPlant(int plant_id)throws Exception;
	
	public int getLatestCubeTest()throws Exception;
	
	public List<String> getSupplyList(int customer_id,int site_id,String product_name)throws Exception;
	
	
	
	
	
}
