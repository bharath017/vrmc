package com.willka.soft.dao;

import java.util.ArrayList;
import java.util.HashMap;


public interface HRMSettingDAO {
	public int insertDesignation(String designation)throws Exception;
	
	public int updateDesignation(int designation_id,String designation)throws Exception;
	
	public int deleteDesignation(int designation_id)throws Exception;
	
	public ArrayList<HashMap<String, Object>> getDesignationList(int start,int length,String search)throws Exception;
	
	public int countDesignationList(String search)throws Exception;
	
	public int insertDepartment(String department_name)throws Exception;
	
	public int updateDepartment(String department_name,int department_id)throws Exception;
	
	public int deleteDepartment(int department_id)throws Exception;
	
	public ArrayList<HashMap<String, Object>> getAllDepartmentList(String search,int start,int length)throws Exception;
	
	public int countAllDepartmentList(String search)throws Exception;
}
