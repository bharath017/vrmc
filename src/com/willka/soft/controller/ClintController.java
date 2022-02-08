package com.willka.soft.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.willka.soft.bean.ClintBean;
import com.willka.soft.dao.ClintDAO;
import com.willka.soft.dao.ClintDAOImpl;


@WebServlet("/ClintController")
public class ClintController extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 187687L;

	public void doPost(HttpServletRequest request,HttpServletResponse response)throws IOException,ServletException
	{
		
		response.setContentType("text/html");
		
		  ClintDAO dao=new ClintDAOImpl();
		    
		String action=request.getParameter("action");
		try{
			HttpSession ses=request.getSession();
			if(action.equals("AddClint")){
				String clint_name=request.getParameter("clint_name");
	    		String clint_phone=request.getParameter("clint_phone");
	    		String customer_address=request.getParameter("customer_address");
	    		String contractor_name=request.getParameter("contractor_name");
	    		String contractor_phone=request.getParameter("contractor_phone");
	    		String architech_name=request.getParameter("architech_name");
	    		String architech_phone=request.getParameter("architech_phone");
	    		String consultent_name=request.getParameter("consultent_name");
	    		String consultent_phone=request.getParameter("consultent_phone");
	    		String pmc_name=request.getParameter("pmc_name");
	    		String pmc_phone=request.getParameter("pmc_phone");
	    		Double project_quantity=(request.getParameter("project_quantity")==null || request.getParameter("project_quantity").trim().equals(""))?0.0:Double.parseDouble(request.getParameter("project_quantity"));
	    		String monthly_requirnment=request.getParameter("monthly_requirnment");
	    		String current_supplier=request.getParameter("currnet_supplier");
	    		String stage=request.getParameter("stage");
	    		
	    		
	    		ClintBean bean=new ClintBean();
	    		
	    		bean.setClint_name(clint_name);
	    		bean.setClint_phone(clint_phone);
	    		bean.setCustomer_address(customer_address);
	    		bean.setContractor_name(contractor_name);
	    		bean.setContractor_phone(contractor_phone);
	    		bean.setArchitech_name(architech_name);
	    		bean.setArchitech_phone(architech_phone);
	    		bean.setConsultent_name(consultent_name);
	    		bean.setConsultent_phone(consultent_phone);
	    		bean.setPmc_name(pmc_name);
	    		bean.setPmc_phone(pmc_phone);
	    		bean.setProject_quantity(project_quantity);
	    		bean.setMonthly_requirnment(monthly_requirnment);
	    		bean.setCurrnet_supplier(current_supplier);
	    		bean.setStage(stage);
	    		
	    		int count=dao.insertClint(bean);
				if(count>0){
					ses.setAttribute("result", "Driver Inserted Successfully");
					response.sendRedirect("ClientList.jsp");
					
				}
				else{
					ses.setAttribute("result", "<span style='color:red'>DRIVER INSERTION UNSUCCESSFUL</span>");
					response.sendRedirect("ClientList.jsp");
				}
				
			}
			else if (action.equals("UpdateClient")) {
				
				int clint_id=Integer.parseInt(request.getParameter("clint_id"));
				String clint_name=request.getParameter("clint_name");
	    		String clint_phone=request.getParameter("clint_phone");
	    		String customer_address=request.getParameter("customer_address");
	    		String contractor_name=request.getParameter("contractor_name");
	    		String contractor_phone=request.getParameter("contractor_phone");
	    		String architech_name=request.getParameter("architech_name");
	    		String architech_phone=request.getParameter("architech_phone");
	    		String consultent_name=request.getParameter("consultent_name");
	    		String consultent_phone=request.getParameter("consultent_phone");
	    		String pmc_name=request.getParameter("pmc_name");
	    		String pmc_phone=request.getParameter("pmc_phone");
	    		Double project_quantity=Double.parseDouble(request.getParameter("project_quantity"));
	    		String monthly_requirnment=request.getParameter("monthly_requirnment");
	    		String current_supplier=request.getParameter("currnet_supplier");
	    		String stage=request.getParameter("stage");
	    		
	    		ClintBean bean=new ClintBean();
	    		
	    		bean.setClint_id(clint_id);
	    		bean.setClint_name(clint_name);
	    		bean.setClint_phone(clint_phone);
	    		bean.setCustomer_address(customer_address);
	    		bean.setContractor_name(contractor_name);
	    		bean.setContractor_phone(contractor_phone);
	    		bean.setArchitech_name(architech_name);
	    		bean.setArchitech_phone(architech_phone);
	    		bean.setConsultent_name(consultent_name);
	    		bean.setConsultent_phone(consultent_phone);
	    		bean.setPmc_name(pmc_name);
	    		bean.setPmc_phone(pmc_phone);
	    		bean.setProject_quantity(project_quantity);
	    		bean.setMonthly_requirnment(monthly_requirnment);
	    		bean.setCurrnet_supplier(current_supplier);
	    		bean.setStage(stage);
	    		
	    		int count=dao.updateClint(bean);
	    		
	    		if(count>0){
					ses.setAttribute("result", "Client Updted Successfully");
					response.sendRedirect("ClientList.jsp");
					
				}
				else{
					ses.setAttribute("result", "<span style='color:red'>Client UPDATED UNSUCCESSFUL</span>");
					response.sendRedirect("ClientList.jsp");
				}
				
				
			}
			
			else if (action.equals("deleteClint")) {
				
				int clint_id=Integer.parseInt(request.getParameter("clint_id"));
				
				int count=dao.deleteClint(clint_id);
				
				
				
				if(count>0){
					ses.setAttribute("result", "Client Deleated Successfully");
					response.sendRedirect("ClientList.jsp");
					
				}
				else{
					ses.setAttribute("result", "<span style='color:red'>Client Deleted UNSUCCESSFUL</span>");
					response.sendRedirect("ClientList.jsp");
				}
				
				
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		
	}
	
}
