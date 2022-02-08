package com.willka.soft.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.willka.soft.bean.DriverBean;
import com.willka.soft.dao.DriverDAOImpl;

@WebServlet("/DriverController")
public class DriverController extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 187687L;

	public void doPost(HttpServletRequest request,HttpServletResponse response)throws IOException,ServletException
	{
		
		response.setContentType("text/html");
		
		DriverDAOImpl dao=new DriverDAOImpl();
		String action=request.getParameter("button");
		try{
			HttpSession ses=request.getSession();
			if(action.equals("insert")){
				//get request parameter value
				String driver_name=request.getParameter("driver_name");
				String driver_phone=request.getParameter("driver_phone");
				String licence_no=request.getParameter("licence_no");
				String licence_valid_till=request.getParameter("licence_valid_till");
				DriverBean bean=new DriverBean();
				bean.setDriver_name(driver_name);
				bean.setDriver_phone(driver_phone);
				bean.setLicence_no(licence_no);
				bean.setLicence_valid_till(licence_valid_till);
				int count=dao.insertDriverDetail(bean);
				if(count>0){
					ses.setAttribute("result", "Driver Inserted Successfully");
					response.sendRedirect("DriverList.jsp");
					
				}
				else{
					ses.setAttribute("result", "<span style='color:red'>DRIVER INSERTION UNSUCCESSFUL</span>");
					response.sendRedirect("DriverList.jsp");
				}
				
			}
			else if(action.equals("update")){
				//get request parameter value
				int driver_id=Integer.parseInt(request.getParameter("driver_id"));
				String driver_name=request.getParameter("driver_name");
				String driver_phone=request.getParameter("driver_phone");
				String licence_no=request.getParameter("licence_no");
				String licence_valid_till=request.getParameter("licence_valid_till");
				//set to the bean object
				DriverBean bean=new DriverBean();
				bean.setDriver_id(driver_id);
				bean.setDriver_name(driver_name);
				bean.setDriver_phone(driver_phone);
				bean.setLicence_no(licence_no);
				bean.setLicence_valid_till(licence_valid_till);
				//call insert method
				int count=dao.updateDriverDetail(bean);
				if(count>0){
					ses.setAttribute("result", "DRIVER UPDATED SUCCESSFULLY");
					response.sendRedirect("DriverList.jsp");
					
				}
				else{
					ses.setAttribute("result", "<span style='color:red'>DRIVER UPDATION UNSUCCESSFUL</span>");
					response.sendRedirect("DriverList.jsp");
				}
				
			}
			else if(action.equals("delete")){
				int driver_id=Integer.parseInt(request.getParameter("driver_id"));
				int count=dao.deleteDriverDetail(driver_id);
				if(count>0){
					ses.setAttribute("result", "Driver deleted successfully");
					response.sendRedirect("DriverList.jsp");
				}
				else{
					ses.setAttribute("result", "<span style='color:red'>Deletion Failed</span>");
					response.sendRedirect("DriverList.jsp");
				}
			}
			
			else if(action.equals("InsertPump")) {
				String type=request.getParameter("type");
				String pump_name=request.getParameter("pump_name");
				int count=dao.insertAddPumpDG(type, pump_name);
				if(count>0) {
					ses.setAttribute("result", type+" inserted successfully");
					response.sendRedirect("PumpDGList.jsp");
				}else {
					ses.setAttribute("result", type+" insertion failed");
					response.sendRedirect("PumpDGList.jsp");
				}
			}
			
			else if(action.equals("UpdatePump")) {
				String type=request.getParameter("type");
				String pump_name=request.getParameter("pump_name");
				int pump_id=Integer.parseInt(request.getParameter("pump_id"));
				int count=dao.updateAddPumpDG(pump_id, type, pump_name);
				if(count>0) {
					ses.setAttribute("result", "Updated Successfully");
					response.sendRedirect("PumpDGList.jsp");
				}else {
					ses.setAttribute("result", "<span class='text-danger'>Updation Failed</span>");
					response.sendRedirect("PumpDGList.jsp");
				}
			}
			
			else if(action.equals("DeletePump")) {
				int pump_id=Integer.parseInt(request.getParameter("pump_id"));
				int count=dao.deletePumpDG(pump_id);
				if(count>0) {
					ses.setAttribute("result", "Successfully Deleted");
					response.sendRedirect("PumpDGList.jsp");
				}else {
					ses.setAttribute("result", "<span class='text-danger'>Deletion Failed</span>");
					response.sendRedirect("PumpDGList.jsp");
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		
	}
	
}
