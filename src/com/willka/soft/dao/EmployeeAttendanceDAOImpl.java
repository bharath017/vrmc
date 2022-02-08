package com.willka.soft.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.willka.soft.bean.EmployeeAttendanceBean;
import com.willka.soft.util.DBUtil;

import java.sql.PreparedStatement;

public class EmployeeAttendanceDAOImpl implements EmployeeAttendanceDAO{

	
	private Connection con=null;
	private PreparedStatement ps=null;
	private ResultSet rs=null;
	
	private static final String GET_EMPLOYEES_FOR_ATTENDANCE="select e.e_id,e.employee_id,e.employee_name,e.employee_phone,"+
			" a.attendance_date,a.start_time,a.end_time,a.status,a.description"+
			" from employee e LEFT JOIN employee_attendance a"+
			" on e.e_id=a.e_id"+
			" and a.attendance_date=?"+
			" where e.business_id=? and e.employee_status='active'";
	
	private static final String INSERT_EMPLOYEE_ATTENDANCE="insert into employee_attendance(e_id,"
			+ "attendance_date,start_time,end_time,status,user_id,description) values(?,?,?,?,?,?,?)";
	
	private static final String UPDATE_EMPLOYEE_ATTENDANCE="update employee_attendance set status=?,start_time=?,end_time=?,"
			+ "user_id=?,description=? where e_id=? and attendance_date=?";
	
	
	private static final String GET_ATTENDANCE_REPORT="select e.employee_id,e.employee_name,DATE_FORMAT(a.attendance_date,'%d/%m/%Y') as attendance_date,"+
			" a.start_time,a.end_time,a.status,a.description,"+
			" timediff(str_to_date(a.end_time,'%l:%i %p'),str_to_date(a.start_time,'%l:%i %p')) as ttime,"+
			" u.user_name"+
			" from (employee_attendance a,employee e)  left join user u"+
			" on a.user_id=u.user_id"+
			" where a.e_id=e.e_id"+
			" and a.e_id=?"+
			" and a.attendance_date between ? and ?";
	
	
	
	
	public EmployeeAttendanceDAOImpl() {
		con=DBUtil.getConnection();
	}

	
	@Override
	public List<Map<String, Object>> getEmployeeForAttendance(int business_id, String attendance_date)
			throws Exception {
		ps=con.prepareStatement(GET_EMPLOYEES_FOR_ATTENDANCE);
		ps.setString(1, attendance_date);
		ps.setInt(2, business_id);
		rs=ps.executeQuery();
		List<Map<String,Object>> data=new ArrayList<>();
		while(rs.next()) {
			Map<String,Object> item=new HashMap<>();
			item.put("e_id", rs.getInt("e_id"));
			item.put("employee_id", rs.getString("employee_id"));
			item.put("employee_name", rs.getString("employee_name"));
			item.put("attendance_date", rs.getString("attendance_date"));
			item.put("start_time", rs.getString("start_time"));
			item.put("employee_phone", rs.getString("employee_phone"));
			item.put("end_time", rs.getString("end_time"));
			item.put("status", (rs.getString("status")==null)?'n':rs.getString("status"));
			item.put("description", rs.getString("description"));
			item.put("isAvailable", (rs.getString("status")==null)?false:true);
			data.add(item);
		}
		return data;
	}


	@Override
	public int insertAttendance(List<EmployeeAttendanceBean> beanList) throws Exception {
		ps=con.prepareStatement(INSERT_EMPLOYEE_ATTENDANCE);
		for(EmployeeAttendanceBean bean:beanList) {
			ps.setInt(1, bean.getE_id());
			ps.setString(2, bean.getAttendance_date());
			ps.setString(3, bean.getStart_time());
			ps.setString(4, bean.getEnd_time());
			ps.setString(5, bean.getStatus());
			ps.setInt(6, bean.getUser_id());
			ps.setString(7, bean.getDescription());
			ps.addBatch();
		}
		int count[]=ps.executeBatch();
		return count.length;
	}

	@Override
	public int updateAttendance(List<EmployeeAttendanceBean> beanList) throws Exception {
		ps=con.prepareStatement(UPDATE_EMPLOYEE_ATTENDANCE);
		for(EmployeeAttendanceBean bean:beanList) {
			ps.setString(1, bean.getStatus());
			ps.setString(2, bean.getStart_time());
			ps.setString(3, bean.getEnd_time());
			ps.setInt(4, bean.getUser_id());
			ps.setString(5, bean.getDescription());
			ps.setInt(6, bean.getE_id());
			ps.setString(7, bean.getAttendance_date());
			ps.addBatch();
		}
		int[] count=ps.executeBatch();
		return count.length;
	}


	@Override
	public List<Map<String, Object>> getEmployeeAttendance(String from_date, String to_date, int e_id)
			throws Exception {
		ps=con.prepareStatement(GET_ATTENDANCE_REPORT);
		
		return null;
	}
	
	
}
