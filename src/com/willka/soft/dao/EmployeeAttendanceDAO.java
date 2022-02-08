package com.willka.soft.dao;

import java.util.List;
import java.util.Map;

import com.willka.soft.bean.EmployeeAttendanceBean;

public interface EmployeeAttendanceDAO {

	public List<Map<String,Object>> getEmployeeForAttendance(int business_id, String attendance_date)throws Exception;
	
	public int insertAttendance(List<EmployeeAttendanceBean> bean)throws Exception;
	
	public int updateAttendance(List<EmployeeAttendanceBean> bean)throws Exception;
	
	public List<Map<String,Object>> getEmployeeAttendance(String from_date, String to_date, int e_id)throws Exception;
}
