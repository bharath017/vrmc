package com.willka.soft.test.dao;

import com.willka.soft.test.bean.CubeTestBean;

public interface CubeTestDAO {

	public int insertCubeTest(CubeTestBean bean)throws Exception;
	
	public int updateCubeTest(CubeTestBean bean)throws Exception;
	
	public int cancelReport(int tst_id)throws Exception;
	
	public int getMaxCubeTestId(int plant_id)throws Exception;
	
}
