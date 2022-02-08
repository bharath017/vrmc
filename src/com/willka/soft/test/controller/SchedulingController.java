package com.willka.soft.test.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.willka.soft.test.bean.SchedulingBean;
import com.willka.soft.test.bean.SchedulingItemBean;
import com.willka.soft.test.dao.SchedulingDAOImpl;
import com.willka.soft.util.DBUtil;

/**
 * Servlet implementation class SchedulingController
 */
@WebServlet("/SchedulingControllerTest")
public class SchedulingController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private Connection con=null;
    private PreparedStatement ps=null;
    private ResultSet rs=null;
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session=request.getSession();
		response.setContentType("text/html");
		PrintWriter writer=response.getWriter();
		SchedulingDAOImpl dao=new SchedulingDAOImpl();
		try {
			String action=request.getParameter("action");
			
			if(action.equals("GetGradeDetails")) {
				response.setContentType("application/json");
				response.setCharacterEncoding("utf-8");
				Gson gson=new Gson();
				int site_id=Integer.parseInt(request.getParameter("site_id"));
				int plant_id=Integer.parseInt(request.getParameter("plant_id"));
				String scheduling_date=request.getParameter("date");
				HashMap<String, Object> map=new HashMap<String, Object>();
				int scheduling_id=dao.checkIfSchedulingIsExist(site_id, plant_id, scheduling_date);
				if(scheduling_id==0) {
					ArrayList<HashMap<String, Object>> list=dao.getGradeForSchedule(site_id, plant_id);
					map.put("list", list);
					map.put("scheduling_id", scheduling_id);
				}else {
					ArrayList<HashMap<String, Object>> oldlist=dao.getAllExistScheduleGrade(scheduling_id);
					ArrayList<HashMap<String, Object>> list=dao.getGradeForSchedule(site_id, plant_id);
					
					//get temp details and put existing detail's in scheduling
					ArrayList<HashMap<String, Object>> temp=new ArrayList<HashMap<String, Object>>();
					for(HashMap<String, Object> mp:list) {
						HashMap<String, Object> newmap=new HashMap<String, Object>();
						newmap.put("product_id", mp.get("product_id"));
						newmap.put("product_name", mp.get("product_name"));
						newmap.put("quantity", mp.get("quantity"));
						newmap.put("totalinvoice", mp.get("totalinvoice"));
						newmap.put("totalquantity", mp.get("totalquantity"));
						for(HashMap<String, Object> mp1:oldlist) {
							if(mp.get("product_id")==mp1.get("product_id")) {
								newmap.put("quantity", mp1.get("quantity"));
							}
						}
						temp.add(newmap);
					}
					//get temp details and add finished here
					map.put("list", temp);
					map.put("scheduling_id", scheduling_id);
				}
				writer.println(gson.toJson(map));
			}
			
			else if(action.equals("InsertorUpdate")) {
				synchronized (request) {
					int id=Integer.parseInt(request.getParameter("scheduling_id"));
					if(id==0) {
							int plant_id=Integer.parseInt(request.getParameter("plant_id"));
							int customer_id=Integer.parseInt(request.getParameter("customer_id"));
							int site_id=Integer.parseInt(request.getParameter("site_id"));
							String scheduling_date=request.getParameter("scheduling_date");
							String start_time=request.getParameter("start_time");
							String end_time=request.getParameter("end_time");
							String pump1=request.getParameter("pump1");
							String pump2=request.getParameter("pump2");
							int user_id=Integer.parseInt(request.getParameter("user_id"));
							int count=Integer.parseInt(request.getParameter("count"));
							
							
							SchedulingBean bean=new SchedulingBean();
							bean.setPlant_id(plant_id);
							bean.setCustomer_id(customer_id);
							bean.setSite_id(site_id);
							bean.setScheduling_date(scheduling_date);
							bean.setStart_time(start_time);
							bean.setEnd_time(end_time);
							bean.setPump1(pump1);
							bean.setPump2(pump2);
							bean.setEnd_time(end_time);
							
							int cnt=dao.insertScheduling(bean);
							int scheduling_id=dao.getMaxOfSchedulingId();
							for(int i=0;i<count;i++) {
								try {
									double quantity=Double.parseDouble(request.getParameter("quantity["+i+"]"));
									if(quantity>0) {
										SchedulingItemBean been=new SchedulingItemBean();
										been.setProduct_id(Integer.parseInt(request.getParameter("product_id["+i+"]")));
										been.setProduction_quantity(quantity);
										been.setScheduling_id(scheduling_id);
										dao.insertSchedulingItem(been);
									}
								}catch(Exception e) {e.printStackTrace();}
							}
							session.setAttribute("result", cnt);
							response.sendRedirect("gst/SchedulingList.jsp");
						}else {
							int plant_id=Integer.parseInt(request.getParameter("plant_id"));
							int customer_id=Integer.parseInt(request.getParameter("customer_id"));
							int site_id=Integer.parseInt(request.getParameter("site_id"));
							String scheduling_date=request.getParameter("scheduling_date");
							String start_time=request.getParameter("start_time");
							String end_time=request.getParameter("end_time");
							String pump1=request.getParameter("pump1");
							String pump2=request.getParameter("pump2");
							int count=Integer.parseInt(request.getParameter("count"));
							
							SchedulingBean bean=new SchedulingBean();
							bean.setPlant_id(plant_id);
							bean.setCustomer_id(customer_id);
							bean.setSite_id(site_id);
							bean.setScheduling_date(scheduling_date);
							bean.setStart_time(start_time);
							bean.setEnd_time(end_time);
							bean.setPump1(pump1);
							bean.setPump2(pump2);
							bean.setEnd_time(end_time);
							bean.setScheduling_id(id);
							int cnt=dao.updateScheduling(bean);
							System.out.println(id);
							for(int i=0;i<count;i++) {
								try {
									double quantity=Double.parseDouble(request.getParameter("quantity["+i+"]"));
									int product_id=Integer.parseInt(request.getParameter("product_id["+i+"]"));
									System.out.println(quantity);
									if(quantity>0.0) {
										SchedulingItemBean been=new SchedulingItemBean();
										been.setProduct_id(product_id);
										been.setProduction_quantity(quantity);
										been.setScheduling_id(id);
										dao.updateSchedulingItem(been);
									}else{
										//delete if exist
										dao.deleteSchedulingItemDetails(product_id,id);
									}
									
								}catch(Exception e) {e.printStackTrace();}
							}
							session.setAttribute("result", cnt);
							response.sendRedirect("gst/SchedulingList.jsp");
						}
						
					}
			}
			else if(action.equals("getAllSchedulingList")) {
				response.setContentType("application/json");
				response.setCharacterEncoding("utf-8");
				Gson gson=new Gson();
				String date=request.getParameter("date");
				int customer_id=Integer.parseInt(request.getParameter("customer_id"));
				int site_id=Integer.parseInt(request.getParameter("site_id"));
				int start=Integer.parseInt(request.getParameter("start"));
				int length=Integer.parseInt(request.getParameter("length"));
				Map<String,Object> data=new HashMap<>();
				int draw=Integer.parseInt(request.getParameter("draw"));
				data.put("data",dao.getAllSchedulingList(date, customer_id, site_id, start, length));
				data.put("draw", draw);
				int recordCount=dao.countAllSchedulingList(date, customer_id, site_id);
				data.put("recordsTotal", recordCount);
				data.put("recordsFiltered", recordCount);
				writer.print(gson.toJson(data));
			}
			
			else if(action.equals("GetScheduledGrades")) {
				response.setContentType("application/json");
				response.setCharacterEncoding("utf-8");
				Gson gson=new Gson();
				
				int scheduling_id=Integer.parseInt(request.getParameter("scheduling_id"));
				ArrayList<HashMap<String, Object>> list=dao.getScheduledInvoiceDetails(scheduling_id);
				writer.println(gson.toJson(list));
			}
			
			else if(action.equals("DeleteScheduling")) {
				int scheduling_id=Integer.parseInt(request.getParameter("scheduling_id"));
				int count=dao.deleteSchedulingDetails(scheduling_id);
				writer.print(count);
			}
			
			else if(action.equals("ShowScheduleDashboard")) {
				response.setContentType("application/json");
				response.setCharacterEncoding("utf-8");
				Gson gson=new Gson();
				HashMap<String, Object> map=dao.getScheduleDashBoard();
				writer.println(gson.toJson(map));
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
	}

}
