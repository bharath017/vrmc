package com.willka.soft.test.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLIntegrityConstraintViolationException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;

import com.google.gson.Gson;
import com.willka.soft.bean.ProjectBlock;
import com.willka.soft.bean.UserDetailBean;
import com.willka.soft.test.bean.CustomerBean;
import com.willka.soft.test.bean.SiteDetailBean;
import com.willka.soft.test.dao.CustomerDaoImpl;
import com.willka.soft.util.DBUtil;

/**
 * Servlet implementation class CustomerController
 */
@WebServlet("/CustomerControllerTest")
public class CustomerController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private Connection con=null;
	private PreparedStatement ps=null;
	private ResultSet rs=null;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.setContentType("text/html");
	    PrintWriter writer = response.getWriter();	
		//create HttpSession object
	    HttpSession ses=request.getSession();	
		CustomerDaoImpl dao=new CustomerDaoImpl();
		try	
		{
			String action=request.getParameter("action");
			
			if(action.equals("AddCustomer")) {
				try {
					synchronized (this) {
						String customer_name=request.getParameter("customer_name");
						String customer_email=request.getParameter("customer_email");
						String customer_phone=request.getParameter("customer_phone");
						String customer_address=request.getParameter("customer_address");
						String customer_gstin=request.getParameter("customer_gstin");
						String customer_panno=request.getParameter("customer_panno");
						int mp_id=Integer.parseInt(request.getParameter("mp_id"));
						int business_id=Integer.parseInt(request.getParameter("business_id"));
						double opening_balance=Double.parseDouble(request.getParameter("opening_balance"));
						String last_dispatch_date=request.getParameter("last_dispatch_date");
						int plant_id=Integer.parseInt(request.getParameter("plant_id"));
						
						CustomerBean bean=new CustomerBean();
						bean.setCustomer_name(customer_name);
						bean.setCustomer_address(customer_address);
						bean.setCustomer_email(customer_email);
						bean.setCustomer_gstin(customer_gstin);
						bean.setCustomer_panno(customer_panno);
						bean.setCustomer_phone(customer_phone);
						bean.setMp_id(mp_id);
						bean.setBusiness_id(business_id);
						bean.setOpening_balance(opening_balance);
						bean.setLast_dispatch_date(last_dispatch_date);
						bean.setPlant_id(plant_id);
						
						//Add Customer detail's and get customer id details
						int count=dao.addCustomerDetails(bean);
						if(count>0) {
							int customer_id=dao.getMaxCustomerId();
							String[] site_name=request.getParameterValues("site_name");
							String[] site_address=request.getParameterValues("site_address");
							
							for(int i=0;i<site_name.length;i++) {
								SiteDetailBean sitebean=new SiteDetailBean();
								sitebean.setSite_name(site_name[i]);
								sitebean.setSite_address(site_address[i]);
								sitebean.setCustomer_id(customer_id);
								dao.insertSiteDetails(sitebean);
							}
							
							ses.setAttribute("res", "Customer inserted successfully");
							response.sendRedirect("gst/CustomerList.jsp");
						}
					}
					
					
				}catch(SQLIntegrityConstraintViolationException e) {
					ses.setAttribute("res","<span class='text-danger'>Customer Detail's already exist</span>");
					response.sendRedirect("gst/CustomerList.jsp");
				}
			}
			
			else if(action.equals("changeCustomer")) {
				int customer_id=(request.getParameter("customer_id")==null || request.getParameter("customer_id").trim().equals(""))?0:Integer.parseInt(request.getParameter("customer_id"));
				ses.setAttribute("customer_id", customer_id);
			}
			
			else if(action.equals("addSiteDetails")) {
				int customer_id=Integer.parseInt(request.getParameter("customer_id"));
				String site_name=request.getParameter("site_name");
				String site_address=request.getParameter("site_address");
				
				SiteDetailBean bean=new SiteDetailBean();
				bean.setCustomer_id(customer_id);
				bean.setSite_name(site_name);
				bean.setSite_address(site_address);
				
				int count=dao.insertSiteDetails(bean);
				if(count>0) {
					ses.setAttribute("res", "Site Added Successfully");
					response.sendRedirect("gst/CustomerAddressDetails.jsp");
				}else {
					ses.setAttribute("res", "<span class='text-danger'>Failed</span>");
					response.sendRedirect("gst/CustomerAddressDetails.jsp");
				}
			}
			
			else if(action.equals("getCustomerSiteDetails")){
				response.setContentType("application/json");
				response.setCharacterEncoding("utf-8");
				int customer_id=Integer.parseInt(request.getParameter("customer_id"));
				ArrayList<SiteDetailBean> site_list=dao.getAllSiteAddress(customer_id);
				Gson gson=new Gson();
				writer.println(gson.toJson(site_list));
			}
			
			else if(action.equals("siteDetailsUsingId")) {
				int site_id=Integer.parseInt(request.getParameter("site_id"));
				SiteDetailBean bean=dao.getSiteDetailsUsingId(site_id);
				writer.println(bean.getSite_address());
			}
			
			else if(action.equals("UpdateCustomer")) {
				String customer_name=request.getParameter("customer_name");
				String customer_email=request.getParameter("customer_email");
				String customer_phone=request.getParameter("customer_phone");
				String customer_address=request.getParameter("customer_address");
				String customer_gstin=request.getParameter("customer_gstin");
				String customer_panno=request.getParameter("customer_panno");
				int customer_id=Integer.parseInt(request.getParameter("customer_id"));
				int mp_id=Integer.parseInt(request.getParameter("mp_id"));
				int business_id=Integer.parseInt(request.getParameter("business_id"));
				double opening_balance=Double.parseDouble(request.getParameter("opening_balance"));
				String last_dispatch_date=request.getParameter("last_dispatch_date");
				int plant_id=Integer.parseInt(request.getParameter("plant_id"));
				
				CustomerBean bean=new CustomerBean();
				bean.setCustomer_name(customer_name);
				bean.setCustomer_address(customer_address);
				bean.setCustomer_email(customer_email);
				bean.setCustomer_gstin(customer_gstin);
				bean.setCustomer_panno(customer_panno);
				bean.setCustomer_phone(customer_phone);
				bean.setCustomer_id(customer_id);
				bean.setMp_id(mp_id);
				bean.setBusiness_id(business_id);
				bean.setOpening_balance(opening_balance);
				bean.setLast_dispatch_date(last_dispatch_date);
				bean.setPlant_id(plant_id);
				
				int count=dao.updateCustomerDetails(bean);
				if(count>0) {
					ses.setAttribute("res", "Customer Updated Successfully");
					response.sendRedirect("gst/CustomerList.jsp");
				}else {
					ses.setAttribute("res", "<span class='text-danger'>Updatation Failed</span>");
					response.sendRedirect("gst/CustomerList.jsp");
				}
			}
			
			else if(action.equals("changeCustomerStatus")) {
				int customer_id=Integer.parseInt(request.getParameter("customer_id"));
				String customer_status=request.getParameter("customer_status");
				int count=dao.changeCustomerStatus(customer_id, customer_status);
				if(count>0) {
					ses.setAttribute("res", "Customer Status Changed Successfully");
					response.sendRedirect("gst/CustomerList.jsp");
				}
				else {
					ses.setAttribute("res", "<span class='text-danger'>Changing Failed</span>");
					response.sendRedirect("gst/CustomerList.jsp");
				}
			}
			
			else if(action.equals("getSiteDetailsForUpdate")) {
				response.setContentType("application/json");
				response.setCharacterEncoding("utf-8");
				int site_id=Integer.parseInt(request.getParameter("site_id"));
				SiteDetailBean bean=dao.getSiteDetailsUsingId(site_id);
				Gson gson=new Gson();
				writer.println(gson.toJson(bean));
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
					ses.setAttribute("res", "Address Updated Successfully");
					response.sendRedirect("gst/CustomerAddressDetails.jsp");
				}else {
					ses.setAttribute("res", "<span class='text-danger'>Updation Failed</span>");
					response.sendRedirect("gst/CustomerAddressDetails.jsp");
				}
			}
			
			else if(action.equals("changeSiteStatus")) {
				int site_id=Integer.parseInt(request.getParameter("site_id"));
				String site_status=request.getParameter("site_status");
				int count=dao.changeSiteStatus(site_id, site_status);
				if(count>0) {
					ses.setAttribute("res", "Site Status Changed");
					response.sendRedirect("gst/CustomerAddressDetails.jsp");
				}else {
					ses.setAttribute("res", "<span class='text-danger'>Internal Error Occured!!</span>");
					response.sendRedirect("gst/CustomerAddressDetails.jsp");
				}
			}
			
			else if(action.equals("GetSiteName")) {
				response.setContentType("application/json");
				response.setCharacterEncoding("UTF-8");
				Gson gson=new Gson();
				int site_id=Integer.parseInt(request.getParameter("site_id"));
				SiteDetailBean bean=dao.getSiteDetailsUsingId(site_id);
				writer.println(gson.toJson(bean));
			}
			
			else if(action.equals("GetCustomerDetails")) {
				response.setContentType("application/json");
				response.setCharacterEncoding("UTF-8");
				Gson gson=new Gson();
				int customer_id=Integer.parseInt(request.getParameter("customer_id"));
				CustomerBean bean=dao.getSingleCustomerDetails(customer_id);
				writer.println(gson.toJson(bean));
			}
			
			else if(action.equals("insertProjectBlock")) {
				int site_id=Integer.parseInt(request.getParameter("site_id"));
				String block_name=request.getParameter("block_name");
				ProjectBlock block=new ProjectBlock();
				block.setSite_id(site_id);
				block.setBlock_name(block_name);
				int count=dao.insertProjectBlock(block);
				if(count>0) {
					response.sendRedirect("gst/ViewCustomer.jsp");
				}
			}
			
			else if(action.equals("deleteProjectBlock")) {
				int block_id=Integer.parseInt(request.getParameter("block_id"));
				int count=dao.deleteProjectBlock(block_id);
				if(count>0) {
					response.sendRedirect("gst/ViewCustomer.jsp");
				}
			}
			
			else if(action.equals("getProjectBlocks")) {
				response.setContentType("application/json");
				response.setCharacterEncoding("UTF-8");
				int site_id=Integer.parseInt(request.getParameter("site_id"));
				ArrayList<ProjectBlock> list=dao.getAllProjectBlock(site_id);
				Gson gson=new Gson();
				writer.print(gson.toJson(list));
			}
			
			else if(action.equals("getCount")) {
				response.setContentType("application/json");
				response.setCharacterEncoding("UTF-8");
				String client_id=(request.getParameter("client_id"));
				con=DBUtil.getConnection();
				UserDetailBean been=(UserDetailBean)ses.getAttribute("bean");
				int user_id	= been.getUser_id();			
				ps=con.prepareStatement("select count(client) as nums from follow_up_report where client=? and user_id=?");
				ps.setString(1, client_id);
				ps.setInt(2, user_id);
				rs=ps.executeQuery();
				if(rs.next()){
					int number=rs.getInt("nums");
					number++;
					writer.print(number);
				}else {
					writer.print(1);
				}
				
			}
			else if(action.equals("getNewCustomer")) {
				response.setContentType("application/json");
				response.setCharacterEncoding("UTF-8");
				int user_id=Integer.parseInt(request.getParameter("user_id"));
				String date=request.getParameter("date");
				JSONArray array=new JSONArray();
				con=DBUtil.getConnection();
				ps=con.prepareStatement("select * from customer where mp_id=? and date(timestamp)=?");
				ps.setInt(1, user_id);
				ps.setString(2, date);
				rs=ps.executeQuery();
				while(rs.next()) {
					JSONObject object=new JSONObject();
					object.put("customer_name", rs.getString("customer_name"));
					object.put("site_address", rs.getString("customer_address"));
					object.put("phone", rs.getString("customer_phone"));
					array.put(object);
				}
				writer.println(array);
			}
			else if(action.equals("updateCreditLimit")) {
				int customer_id=Integer.parseInt(request.getParameter("customer_id"));
				double credit_limit= Double.parseDouble(request.getParameter("credit_limit"));
				int count=dao.updateCreditLimit(customer_id, credit_limit);
				if(count>0) {
					ses.setAttribute("res", "Customer credit Limit updated Successfully");
					response.sendRedirect("gst/CustomerList.jsp");
				}
				else {
					ses.setAttribute("res", "<span class='text-danger'>Updation Failed</span>");
					response.sendRedirect("gst/CustomerList.jsp");
				}
			}
			
			
			else if(action.equals("GetAllCustomerList")) {
				response.setContentType("application/json");
				response.setCharacterEncoding("utf-8");
				Gson gson=new Gson();
				String customer_name=request.getParameter("customer_name");
				String customer_phone=request.getParameter("customer_phone");
				int business_id=Integer.parseInt(request.getParameter("business_id"));
				int plant_id=Integer.parseInt(request.getParameter("plant_id"));
				String alp=request.getParameter("alp");
				String status=request.getParameter("status");
				int start=Integer.parseInt(request.getParameter("start"));
				int length=Integer.parseInt(request.getParameter("length"));
				Map<String,Object> data=new HashMap<>();
				int draw=Integer.parseInt(request.getParameter("draw"));
				data.put("data",dao.getAllCustomerList(customer_name, customer_phone, status, alp, business_id, plant_id, start, length));
				data.put("draw", draw);
				int recordCount=dao.countAllCustomerList(customer_name, customer_phone, status, alp, business_id,plant_id);
				data.put("recordsTotal", recordCount);
				data.put("recordsFiltered", recordCount);
				writer.print(gson.toJson(data));
			}
			
			else if(action.equals("getCustomerMarketingPerson")) {
				response.setContentType("application/json");
				response.setCharacterEncoding("utf-8");
				Gson gson=new Gson();
				int customer_id=Integer.parseInt(request.getParameter("customer_id"));
				Map<String,Object> data=dao.getMarketingPersonDetails(customer_id);
				writer.println(gson.toJson(data));
			}
			
			else if(action.equals("getCustomerListByBusinessGroup")) {
				response.setContentType("application/json");
				response.setCharacterEncoding("utf-8");
				Gson gson=new Gson();
				int business_id=Integer.parseInt(request.getParameter("business_id"));
				List<Map<String,Object>> list=dao.getCustomerListByGroup(business_id);
				writer.println(gson.toJson(list));
			}
			
			
			
			
		}
		catch (Exception e) {
			e.printStackTrace();
		}
	
	}

}
