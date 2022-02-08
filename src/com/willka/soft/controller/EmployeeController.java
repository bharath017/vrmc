package com.willka.soft.controller;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.Properties;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.willka.soft.bean.DepartmentBean;
import com.willka.soft.bean.DesignationBean;
import com.willka.soft.bean.EmployeeBean;
import com.willka.soft.bean.EmployeeSalaryStructureBean;
import com.willka.soft.bean.SalaryStructureBean;
import com.willka.soft.dao.EmployeeDAO;
import com.willka.soft.dao.EmployeeDAOImpl;
import com.willka.soft.util.IndianDateFormater;

import javazoom.upload.MultipartFormDataRequest;
import javazoom.upload.UploadBean;
import javazoom.upload.UploadFile;


/**
 * Servlet implementation class MixDesignController
 */
@WebServlet("/EmployeeController")
public class EmployeeController extends HttpServlet {
	private static final long serialVersionUID = 14568L;
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		PrintWriter writer=response.getWriter();
		HttpSession session=request.getSession();
		EmployeeDAO dao=new EmployeeDAOImpl();
		
		try {
				String action=request.getParameter("action");
				
				
				
			 if(action.equals("upload_file")){
					System.out.println("Hello this is coming");
					Properties prop=new Properties();
					ClassLoader classLoader = Thread.currentThread().getContextClassLoader();
					InputStream input = classLoader.getResourceAsStream("com/willka/soft/util/Util.properties");
					prop.load(input);
					String path=prop.getProperty("hrmpath");
					UploadBean bean=null;
					MultipartFormDataRequest nreq=null;
					Hashtable ht=null;
					Enumeration e=null;
					nreq=new MultipartFormDataRequest(request);
					bean=new UploadBean();
					bean.setFolderstore(path);
					bean.setOverwrite(true);
					//completing file uploading
					ht=nreq.getFiles();
					e=ht.elements();
					while(e.hasMoreElements()){
						UploadFile f=(UploadFile)e.nextElement();
					}
					bean.store(nreq);
					//display the names of the uploaded files
					ht=nreq.getFiles();
					e=ht.elements();
					String file_name=null;
					while(e.hasMoreElements()){
						UploadFile file=(UploadFile)e.nextElement();
						file_name=file.getFileName();
					}
					writer.println(file_name);
				}
			 
			 
			 	else if(action.equals("checkEmployeeID")) {
			 		String employee_id=request.getParameter("employee_id");
			 		boolean isAvailable=dao.checkEmployeeId(employee_id);
			 		if(isAvailable)
			 			writer.println("exist");
			 	}
			 
			 	
			 	else if(action.equals("checkEmployeeIdForUpdate")) {
			 		String employee_id=request.getParameter("employee_id");
			 		int e_id=Integer.parseInt(request.getParameter("e_id"));
			 		int count=dao.checkExistanceEmployeeIdForUpdate(e_id, employee_id);
			 		if(count>0)
			 			writer.println("exist");
			 	}
				
				
				else if(action.equals("insertEmployee")) {
					try {
						String employee_id=request.getParameter("employee_id");
						String employee_name=request.getParameter("employee_name");
						String current_address=request.getParameter("current_address");
						String residental_address=request.getParameter("residental_address");
						String employee_qualification=request.getParameter("employee_qualification");
						String employee_phone=request.getParameter("employee_phone");
						String employee_email=request.getParameter("employee_email");
						String employee_pancard_number=request.getParameter("employee_pancard_number");
						String employee_aadhar_number=request.getParameter("employee_aadhar_number");
						String employee_dob=(request.getParameter("employee_dob")!=null)?IndianDateFormater
								.converToIndianFormat(request.getParameter("employee_dob")):null;
						String employee_experience=request.getParameter("employee_experience");
						String employee_bank_name=request.getParameter("employee_bank_name");
						String employee_account_number=request.getParameter("employee_account_number");
						String employee_ifsc_code=request.getParameter("employee_ifsc_code");
						String employee_pf_number=request.getParameter("employee_pf_number");
						String employee_joining_date=(request.getParameter("employee_joining_date")!=null)?IndianDateFormater
								.converToIndianFormat(request.getParameter("employee_joining_date")):null;
						int designation_id=Integer.parseInt(request.getParameter("designation_id"));
						String 	employee_password=request.getParameter("employee_password");
						String employee_working_location=request.getParameter("employee_working_location");
						double employee_monthly_salary=(request.getParameter("employee_monthly_salary")==null 
								|| request.getParameter("employee_monthly_salary").trim().equals(""))?
								0.0:Double.parseDouble(request.getParameter("employee_monthly_salary"));
						String employee_photo=request.getParameter("employee_photo");
						String employee_pancard_photo=request.getParameter("employee_pancard_photo");
						String employee_aadhar_photo=request.getParameter("employee_aadhar_photo");
						String contact_number=request.getParameter("contact_number");
						String licence_number=request.getParameter("licence_number");
						String ua_number=request.getParameter("ua_number");
						int department_id=Integer.parseInt(request.getParameter("department_id"));
						int  business_id=Integer.parseInt(request.getParameter("business_id"));
						
						EmployeeBean bean=new EmployeeBean();
						bean.setEmployee_id(employee_id);
						bean.setEmployee_name(employee_name);
						bean.setCurrent_address(current_address);
						bean.setResidental_address(residental_address);
						bean.setEmployee_qualification(employee_qualification);
						bean.setEmployee_phone(employee_phone);
						bean.setEmployee_email(employee_email);
						bean.setEmployee_pancard_number(employee_pancard_number);
						bean.setEmployee_aadhar_number(employee_aadhar_number);
						bean.setEmployee_dob(employee_dob);
						bean.setEmployee_experience(employee_experience);
						bean.setEmployee_bank_name(employee_bank_name);
						bean.setEmployee_account_number(employee_account_number);
						bean.setEmployee_ifsc_code(employee_ifsc_code);
						bean.setEmployee_pf_number(employee_pf_number);
						bean.setEmployee_joining_date(employee_joining_date);
						bean.setDesignation_id(designation_id);
						bean.setEmployee_password(employee_password);
						bean.setEmployee_working_location(employee_working_location);
						bean.setEmployee_monthly_salary(employee_monthly_salary);
						bean.setEmployee_photo(employee_photo);
						bean.setEmployee_pancard_photo(employee_pancard_photo);
						bean.setEmployee_aadhar_photo(employee_aadhar_photo);
						bean.setContact_number(contact_number);
						bean.setLicence_number(licence_number);
						bean.setUa_number(ua_number);
						bean.setBusiness_id(business_id);
						bean.setDepartment_id(department_id);
						int count=dao.insertEmployee(bean);
						if(count>0)
						{
							session.setAttribute("res", "Employee Details Inserted Successfully");
							response.sendRedirect("EmployeeList.jsp");
						}
						else
						{
							session.setAttribute("res", "Failed");
							response.sendRedirect("EmployeeList.jsp");
						}
						
					}
					
					
					catch(Exception e)
					{
						e.printStackTrace();
					}
				}
				
				else if(action.equals("updateEmployee")) {
					String employee_id=request.getParameter("employee_id");
					String employee_name=request.getParameter("employee_name");
					String current_address=request.getParameter("current_address");
					String residental_address=request.getParameter("residental_address");
					String employee_qualification=request.getParameter("employee_qualification");
					String employee_phone=request.getParameter("employee_phone");
					String employee_email=request.getParameter("employee_email");
					String employee_pancard_number=request.getParameter("employee_pancard_number");
					String employee_aadhar_number=request.getParameter("employee_aadhar_number");
					String employee_dob=IndianDateFormater
							.converToIndianFormat(request.getParameter("employee_dob"));
					String employee_experience=request.getParameter("employee_experience");
					String employee_bank_name=request.getParameter("employee_bank_name");
					String employee_account_number=request.getParameter("employee_account_number");
					String employee_ifsc_code=request.getParameter("employee_ifsc_code");
					String employee_pf_number=request.getParameter("employee_pf_number");
					String employee_joining_date=IndianDateFormater
							.converToIndianFormat(request.getParameter("employee_joining_date"));
					int designation_id=Integer.parseInt(request.getParameter("designation_id"));
					String 	employee_password=request.getParameter("employee_password");
					String employee_working_location=request.getParameter("employee_working_location");
					double employee_monthly_salary=Double.parseDouble(request.getParameter("employee_monthly_salary"));
					String employee_photo=request.getParameter("employee_photo");
					String employee_pancard_photo=request.getParameter("employee_pancard_photo");
					String employee_aadhar_photo=request.getParameter("employee_aadhar_photo");
					String contact_number=request.getParameter("contact_number");
					String licence_number=request.getParameter("licence_number");
					int e_id=Integer.parseInt(request.getParameter("e_id"));
					String ua_number=request.getParameter("ua_number");
					String esic_number=request.getParameter("esic_number");
					int department_id=Integer.parseInt(request.getParameter("department_id"));
					int business_id=Integer.parseInt(request.getParameter("business_id"));
					
			
					//DesignationBean bean= new DesignationBean();
					EmployeeBean bean=new EmployeeBean();	
					bean.setEmployee_id(employee_id);
					bean.setEmployee_name(employee_name);
					bean.setCurrent_address(current_address);
					bean.setResidental_address(residental_address);
					bean.setEmployee_qualification(employee_qualification);
					bean.setEmployee_phone(employee_phone);
					bean.setEmployee_email(employee_email);
					bean.setEmployee_pancard_number(employee_pancard_number);
					bean.setEmployee_aadhar_number(employee_aadhar_number);
					bean.setEmployee_dob(employee_dob);
					bean.setEmployee_experience(employee_experience);
					bean.setEmployee_bank_name(employee_bank_name);
					bean.setEmployee_account_number(employee_account_number);
					bean.setEmployee_ifsc_code(employee_ifsc_code);
					bean.setEmployee_pf_number(employee_pf_number);
					bean.setEmployee_joining_date(employee_joining_date);
					bean.setDesignation_id(designation_id);
					bean.setEmployee_password(employee_password);
					bean.setEmployee_working_location(employee_working_location);
					bean.setEmployee_monthly_salary(employee_monthly_salary);
					bean.setEmployee_photo(employee_photo);
					bean.setEmployee_pancard_photo(employee_pancard_photo);
					bean.setEmployee_aadhar_photo(employee_aadhar_photo);
					bean.setContact_number(contact_number);
					bean.setLicence_number(licence_number);
					bean.setUa_number(ua_number);
					bean.setE_id(e_id);
					bean.setEsic_number(esic_number);
					bean.setDepartment_id(department_id);
					bean.setBusiness_id(business_id);
					
					int count=dao.updateEmployee(bean);
					
					if(count>0) {
						session.setAttribute("res", "Employee Name : "+employee_name+" Details Updated Successfully");
						response.sendRedirect("EmployeeList.jsp");
					}else {
						session.setAttribute("res", "<span class='text-danger'>Failed!!</span>");
						response.sendRedirect("EmployeeList.jsp");
					}
					
				}
				
				else if(action.equals("deleteEmployee")) {
					
					int e_id=Integer.parseInt(request.getParameter("e_id"));
					
					int count=dao.deleteEmployee(e_id);
					if(count>0) {
						session.setAttribute("res", "Employee Deleted Successfully");
						response.sendRedirect("EmployeeList.jsp");
					}else {
						session.setAttribute("res", "<span class='text-danger'>Failed!!</span>");
						response.sendRedirect("EmployeeList.jsp");
					}
				}
				
			 	
				else if(action.equals("GetSingleEmployee")) {
					response.setContentType("application/json");
					response.setCharacterEncoding("UTF-8");
					Gson gson=new Gson();
					
					int e_id=Integer.parseInt(request.getParameter("e_id"));
					EmployeeBean bean=dao.getSingleEmployeeDetails(e_id);
					writer.println(gson.toJson(bean));
					
				}
				

				else if(action.equals("viewEmployee")) {
					Gson gson=new Gson();
					response.setContentType("application/json");
					response.setCharacterEncoding("utf-8");
					int e_id=Integer.parseInt(request.getParameter("e_id"));
					EmployeeBean bean=dao.singleEmployeeView(e_id);
					writer.println(gson.toJson(bean));
				}
				
				else if(action.equals("GetEmployees")) {
					response.setContentType("application/json");
					response.setCharacterEncoding("utf-8");
					int e_id=Integer.parseInt(request.getParameter("employee_id"));
					ArrayList<HashMap<String, Object>> emp_list=dao.getEmployeeListWithValuePair(e_id);
					Gson gson=new Gson();
					writer.println(gson.toJson(emp_list));
				}
			 
				else if(action.equals("updateEmployeeSalaryStructure")) {
					int e_id=Integer.parseInt(request.getParameter("e_id"));
					double basic_pay=Double.parseDouble(request.getParameter("basic_pay"));
					double hra=Double.parseDouble(request.getParameter("hra"));
					double da=Double.parseDouble(request.getParameter("da"));
					double other=Double.parseDouble(request.getParameter("other"));
					double pf=Double.parseDouble(request.getParameter("pf"));
					double esic=Double.parseDouble(request.getParameter("esic"));
					double prof_tax=Double.parseDouble(request.getParameter("prof_tax"));
					double tds=Double.parseDouble(request.getParameter("tds"));
					
					SalaryStructureBean bean=new SalaryStructureBean();
					bean.setE_id(e_id);
					bean.setBasic_pay(basic_pay);
					bean.setHra(hra);
					bean.setDa(da);
					bean.setOther(other);
					bean.setPf(pf);
					bean.setEsic(esic);
					bean.setProf_tax(prof_tax);
					bean.setTds(tds);
					
					int count=dao.updateSalaryStructure(bean);
					writer.print(count);
				}

		}
		catch(Exception e) {
			e.printStackTrace();
		}
	}

}
