package com.willka.soft.dao;

import java.sql.Connection;  
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.willka.soft.bean.DepartmentBean;
import com.willka.soft.bean.DesignationBean;
import com.willka.soft.bean.EmployeeBean;
import com.willka.soft.bean.EmployeeSalaryStructureBean;
import com.willka.soft.bean.SalaryStructureBean;
import com.willka.soft.util.DBUtil;

public class EmployeeDAOImpl implements EmployeeDAO {

		// Declare Database Variable
	
		private Connection con=null;
		private PreparedStatement ps=null;
		private ResultSet rs=null;

		// Declare Query Here
		private static final String INSERT_EMPLOYEE_DETAILS="insert into employee (employee_id,employee_name,current_address,"
				+ "residental_address,employee_qualification,employee_phone,employee_email,employee_pancard_number,employee_aadhar_number,"
				+ "employee_dob,employee_experience,employee_bank_name,employee_account_number,employee_ifsc_code,employee_pf_number,employee_joining_date,"
				+ "designation_id,employee_password,employee_working_location,employee_monthly_salary,employee_photo,employee_pancard_photo,"
				+ "employee_aadhar_photo,contact_number,licence_number,department_id,business_id) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
		
		private static final String UPDATE_EMPLOYEE_DETAILS="update employee set employee_id=?,employee_name=?,current_address=?,residental_address=?,"
				+ "employee_qualification=?,employee_phone=?,employee_email=?,employee_pancard_number=?,employee_aadhar_number=?,employee_dob=?,"
				+ "employee_experience=?,employee_bank_name=?,employee_account_number=?,employee_ifsc_code=?,employee_pf_number=?,employee_joining_date=?,"
				+ "designation_id=?,employee_password=?,employee_working_location=?,employee_monthly_salary=?,employee_photo=?,employee_pancard_photo=?,"
				+ "employee_aadhar_photo=?,contact_number=?,licence_number=?,department_id=?,business_id=?,esic_number=? where e_id=?";
		
		private static final String DELETE_EMPLOYEE="delete from employee where e_id=?";
		
		private static final String GET_SINGLE_EMPLOYEE="select * from employee where e_id=?";
		
		private static final String GET_EMPLOYEE_VALUE_PAIR="select e_id,employee_name,employee_id from employee where e_id like if(?=0,'%%',?)";
		
		private static final String CHECK_EMPLOYEE_ID="select e_id from employee where employee_id=?";
		
		private static final String CHECK_EMPLOYEE_ID_FOR_UPDATE="select count(e_id) from employee where employee_id=? and e_id!=?";
		
		private static final String UPDATE_SALARY_STRUCTURE="update employee set basic_pay=?,hra=?,da=?,other=?,pf=?,esic=?,prof_tax=?,	tds=? where e_id=?";
		
		
		
	public EmployeeDAOImpl() {
		con=DBUtil.getConnection();
	}
		

	
	@Override
	public int insertEmployee(EmployeeBean bean) throws Exception {
		
		ps=con.prepareStatement(INSERT_EMPLOYEE_DETAILS);
		
		ps.setString(1, bean.getEmployee_id());
		ps.setString(2, bean.getEmployee_name());
		ps.setString(3, bean.getCurrent_address());
		ps.setString(4, bean.getResidental_address());
		ps.setString(5, bean.getEmployee_qualification());
		ps.setString(6, bean.getEmployee_phone());
		ps.setString(7, bean.getEmployee_email());
		ps.setString(8, bean.getEmployee_pancard_number());
		ps.setString(9, bean.getEmployee_aadhar_number());
		ps.setString(10, bean.getEmployee_dob());
		ps.setString(11, bean.getEmployee_experience());
		ps.setString(12, bean.getEmployee_bank_name());
		ps.setString(13, bean.getEmployee_account_number());
		ps.setString(14, bean.getEmployee_ifsc_code());
		ps.setString(15, bean.getEmployee_pf_number());
		ps.setString(16, bean.getEmployee_joining_date());
		ps.setInt(17, bean.getDesignation_id());
		ps.setString(18, bean.getEmployee_password());
		ps.setString(19, bean.getEmployee_working_location());
		ps.setDouble(20, bean.getEmployee_monthly_salary());
		ps.setString(21, bean.getEmployee_photo());
		ps.setString(22, bean.getEmployee_pancard_photo());
		ps.setString(23, bean.getEmployee_aadhar_photo());
		ps.setString(24, bean.getContact_number());
		ps.setString(25, bean.getLicence_number());
        ps.setInt(26, bean.getDepartment_id());
        ps.setInt(27, bean.getBusiness_id());
        int count=ps.executeUpdate();
		return count;
	}

	@Override
	public int updateEmployee(EmployeeBean bean) throws Exception {
		ps=con.prepareStatement(UPDATE_EMPLOYEE_DETAILS);
		ps.setString(1, bean.getEmployee_id());
		ps.setString(2, bean.getEmployee_name());
		ps.setString(3, bean.getCurrent_address());
		ps.setString(4, bean.getResidental_address());
		ps.setString(5, bean.getEmployee_qualification());
		ps.setString(6, bean.getEmployee_phone());
		ps.setString(7, bean.getEmployee_email());
		ps.setString(8, bean.getEmployee_pancard_number());
		ps.setString(9, bean.getEmployee_aadhar_number());
		ps.setString(10, bean.getEmployee_dob());
		ps.setString(11, bean.getEmployee_experience());
		ps.setString(12, bean.getEmployee_bank_name());
		ps.setString(13, bean.getEmployee_account_number());
		ps.setString(14, bean.getEmployee_ifsc_code());
		ps.setString(15, bean.getEmployee_pf_number());
		ps.setString(16, bean.getEmployee_joining_date());
		ps.setInt(17, bean.getDesignation_id());
		ps.setString(18, bean.getEmployee_password());
		ps.setString(19, bean.getEmployee_working_location());
		ps.setDouble(20, bean.getEmployee_monthly_salary());
		ps.setString(21, bean.getEmployee_photo());
		ps.setString(22, bean.getEmployee_pancard_photo());
		ps.setString(23, bean.getEmployee_aadhar_photo());
		ps.setString(24, bean.getContact_number());
		ps.setString(25, bean.getLicence_number());
		ps.setInt(26, bean.getDepartment_id());
		ps.setInt(27, bean.getBusiness_id());
		ps.setString(28, bean.getEsic_number());
		ps.setInt(29, bean.getE_id());
		int count=ps.executeUpdate();
		return count;
	}

	@Override
	public int deleteEmployee(int e_id) throws Exception {
		
		ps=con.prepareStatement(DELETE_EMPLOYEE);
		ps.setInt(1, e_id);
		int count=ps.executeUpdate();
		return count;
	}

	
	
	@Override
	public EmployeeBean getSingleEmployeeDetails(int e_id) throws Exception {
			
		ps=con.prepareStatement(GET_SINGLE_EMPLOYEE);
		ps.setInt(1, e_id);
		rs=ps.executeQuery();
		if(rs.next())
		{
			EmployeeBean bean=new EmployeeBean();
			bean.setE_id(rs.getInt("e_id"));
			return bean;
		}
		else
		{	
			return null;
		}
	}

	

	@Override
	public EmployeeBean singleEmployeeView(int e_id) throws Exception {
		ps=con.prepareStatement(GET_SINGLE_EMPLOYEE);
		ps.setInt(1, e_id);
		rs=ps.executeQuery();
		if(rs.next()) {
			EmployeeBean bean=new EmployeeBean();
			bean.setE_id(rs.getInt("e_id"));
			bean.setEmployee_id(rs.getString("employee_id"));
			bean.setEmployee_name(rs.getString("employee_name"));
			bean.setCurrent_address(rs.getString("current_address"));
			bean.setResidental_address(rs.getString("residental_address"));
			bean.setEmployee_qualification(rs.getString("employee_qualification"));
			bean.setEmployee_phone(rs.getString("employee_phone"));
			bean.setEmployee_email(rs.getString("employee_email"));
			bean.setEmployee_pancard_number(rs.getString("employee_pancard_number"));
			bean.setEmployee_aadhar_number(rs.getString("employee_aadhar_number"));
			bean.setEmployee_dob(rs.getString("employee_dob"));
			bean.setEmployee_experience(rs.getString("employee_experience"));
			bean.setEmployee_bank_name(rs.getString("employee_bank_name"));
			bean.setEmployee_account_number(rs.getString("employee_account_number"));
			bean.setEmployee_ifsc_code(rs.getString("employee_ifsc_code"));
			bean.setEmployee_pf_number(rs.getString("employee_pf_number"));
			bean.setEmployee_joining_date(rs.getString("employee_joining_date"));
			bean.setDesignation_id(rs.getInt("designation_id"));
			bean.setEmployee_password(rs.getString("employee_password"));
			bean.setEmployee_working_location(rs.getString("employee_working_location"));
			bean.setEmployee_monthly_salary(rs.getDouble("employee_monthly_salary"));
			bean.setEmployee_photo(rs.getString("employee_photo"));
			bean.setEmployee_pancard_photo(rs.getString("employee_pancard_photo"));
			bean.setEmployee_aadhar_photo(rs.getString("employee_aadhar_photo"));
			bean.setContact_number(rs.getString("contact_number"));
			bean.setLicence_number(rs.getString("licence_number"));
			return bean;
		}
			else
				return null;
	}

	@Override
	public ArrayList<HashMap<String, Object>> getEmployeeListWithValuePair(int employee_id) throws Exception {
		ps=con.prepareStatement(GET_EMPLOYEE_VALUE_PAIR);
		ps.setInt(1, employee_id);
		ps.setInt(2, employee_id);
		rs=ps.executeQuery();
		ArrayList<HashMap<String, Object>> employee_list=new ArrayList<HashMap<String,Object>>();
		while(rs.next()) {
			HashMap<String, Object> map=new HashMap<String, Object>();
			map.put("e_id", rs.getInt("e_id"));
			map.put("employee_id", rs.getString("employee_id"));
			map.put("employee_name", rs.getString("employee_name"));
			employee_list.add(map);
		}
		return employee_list;
	}



	@Override
	public boolean checkEmployeeId(String employee_id) throws Exception {
		ps=con.prepareStatement(CHECK_EMPLOYEE_ID);
		ps.setString(1, employee_id);
		rs=ps.executeQuery();
		if(rs.next())
			return true;
		else
			return false;
	}



	@Override
	public int checkExistanceEmployeeIdForUpdate(int e_id, String employee_id) throws Exception {
		ps=con.prepareStatement(CHECK_EMPLOYEE_ID_FOR_UPDATE);
		ps.setString(1, employee_id);
		ps.setInt(2, e_id);
		rs=ps.executeQuery();
		if(rs.next())
			return rs.getInt(1);
		else
			return 0;
	}



	@Override
	public int updateSalaryStructure(SalaryStructureBean bean) throws Exception {
		ps=con.prepareStatement(UPDATE_SALARY_STRUCTURE);
		ps.setDouble(1, bean.getBasic_pay());
		ps.setDouble(2, bean.getHra());
		ps.setDouble(3, bean.getDa());
		ps.setDouble(4, bean.getOther());
		ps.setDouble(5, bean.getPf());
		ps.setDouble(6, bean.getEsic());
		ps.setDouble(7, bean.getProf_tax());
		ps.setDouble(8, bean.getTds());
		ps.setInt(9, bean.getE_id());
		int count=ps.executeUpdate();
		return count;
	}

	



}
