package com.willka.soft.test.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.willka.soft.test.bean.ContactPerson;
import com.willka.soft.test.bean.SiteDetailBean;
import com.willka.soft.test.dao.CustomerDaoImpl;

@WebServlet("/CustomerViewControllerTest")
public class CustomerViewController extends HttpServlet {
	private static final long serialVersionUID = 14343L;
  
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int customer_id=Integer.parseInt(request.getParameter("customer_id"));
		HttpSession session=request.getSession();
		session.setAttribute("customer_id", customer_id);
		response.sendRedirect("gst/ViewCustomer.jsp");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		PrintWriter writer=response.getWriter();
		HttpSession ses=request.getSession();
		CustomerDaoImpl dao=new CustomerDaoImpl();
		try {
			String action=request.getParameter("action");
			
			if(action.equals("addSiteDetails")) {
				int customer_id=Integer.parseInt(request.getParameter("customer_id"));
				String site_name=request.getParameter("site_name");
				String site_address=request.getParameter("site_address");
				
				SiteDetailBean bean=new SiteDetailBean();
				bean.setCustomer_id(customer_id);
				bean.setSite_name(site_name);
				bean.setSite_address(site_address);
				
				int count=dao.insertSiteDetails(bean);
				if(count>0) {
					response.sendRedirect("gst/ViewCustomer.jsp");
				}else {
					response.sendRedirect("gst/ViewCustomer.jsp");
				}
			}
			
			else if(action.equals("updateSiteDetails")) {
				int site_id=Integer.parseInt(request.getParameter("site_id"));
				String site_name=request.getParameter("site_name");
				String site_address=request.getParameter("site_address");
				String tally_ledger=request.getParameter("tally_ledger");
				
				SiteDetailBean bean=new SiteDetailBean();
				bean.setSite_address(site_address);
				bean.setSite_name(site_name);
				bean.setSite_id(site_id);
				bean.setTally_ladger(tally_ledger);
				
				int count=dao.updateSiteDetails(bean);
				if(count>0) {
					response.sendRedirect("gst/ViewCustomer.jsp");
				}else {
					response.sendRedirect("gst/ViewCustomer.jsp");
				}
			}
			
			else if(action.equals("changeSiteStatus")) {
				int site_id=Integer.parseInt(request.getParameter("site_id"));
				String site_status=request.getParameter("site_status");
				int count=dao.changeSiteStatus(site_id, site_status);
				if(count>0) {
					response.sendRedirect("gst/ViewCustomer.jsp");
				}else {
					response.sendRedirect("gst/ViewCustomer.jsp");
				}
			}
			
			else if(action.equals("InsertContactPerson")) {
				int customer_id=Integer.parseInt(request.getParameter("customer_id"));
				String contact_name=request.getParameter("contact_name");
				String phone=request.getParameter("phone");
				String email=request.getParameter("email");
				
				ContactPerson bean=new ContactPerson();
				bean.setPhone(phone);
				bean.setCustomer_id(customer_id);
				bean.setEmail(email);
				bean.setContact_name(contact_name);
				
				//int count=dao.insertCotactPerson(bean);
				
				/*
				 * if(count>0) { response.sendRedirect("ViewCustomer.jsp"); }else {
				 * response.sendRedirect("ViewCustomer.jsp"); }
				 */
			}
			
			else if(action.equals("DeleteContactPerson")) {
				int contact_id=Integer.parseInt(request.getParameter("contact_id"));
				/*
				 * int count=dao.deleteContactPerson(contact_id);
				 * 
				 * if(count>0) { response.sendRedirect("ViewCustomer.jsp"); }else {
				 * response.sendRedirect("ViewCustomer.jsp"); }
				 */
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
	}

}
