package com.willka.soft.dao;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.willka.soft.bean.DepartmentBean;
import com.willka.soft.bean.DesignationBean; 
import com.willka.soft.bean.EmployeeBean;
import com.willka.soft.bean.EmployeeSalaryStructureBean;
import com.willka.soft.bean.SalaryStructureBean;

public interface EmployeeDAO {
	
	public boolean checkEmployeeId(String employee_id)throws Exception;
	
	public int insertEmployee(EmployeeBean bean)throws Exception; 

	public int updateEmployee(EmployeeBean bean)throws Exception; 

	public int deleteEmployee(int e_id)throws Exception; 
	
	public EmployeeBean getSingleEmployeeDetails(int e_id) throws Exception;
	
	public EmployeeBean singleEmployeeView(int e_id)throws Exception;
	
	public  ArrayList<HashMap<String, Object>> getEmployeeListWithValuePair(int employee_id)throws Exception;
	
	public int checkExistanceEmployeeIdForUpdate(int e_id,String employee_id)throws Exception;
	
	//salary structure related method
	
	public int updateSalaryStructure(SalaryStructureBean bean)throws Exception;
	
	

}
