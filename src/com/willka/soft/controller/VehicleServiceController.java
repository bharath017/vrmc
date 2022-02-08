package com.willka.soft.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.willka.soft.bean.DieselConsumptionBean;
import com.willka.soft.bean.DieselModificationBean;
import com.willka.soft.bean.InventoryStockBean;
import com.willka.soft.bean.ServiceBean;
import com.willka.soft.bean.UserDetailBean;
import com.google.gson.Gson;
import com.willka.soft.dao.InventoryDAO;
import com.willka.soft.dao.InventoryDAOImpl;
import com.willka.soft.dao.ServiceDAOImpl;
import com.willka.soft.dao.SettingDAO;
import com.willka.soft.dao.SettingDAOImpl;

/**
 * Servlet implementation class VehicleService
 */
@WebServlet("/VehicleServiceController")
public class VehicleServiceController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public VehicleServiceController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		PrintWriter writer=response.getWriter();
		HttpSession session=request.getSession();
		ServiceDAOImpl dao=new ServiceDAOImpl();
		SettingDAO settingdao=new SettingDAOImpl();
		InventoryDAO inventorydao=new InventoryDAOImpl();
		
		try {
			String action=request.getParameter("action");
			if(action.equals("InsertService")) {
				String vehicle_no=request.getParameter("vehicle_no");
				String vehicle=request.getParameter("vehicle_type");
				String time=request.getParameter("time");
				String date=request.getParameter("date");
				double last_skm=Double.parseDouble(request.getParameter("last_skm"));
				double present_skm=Double.parseDouble(request.getParameter("present_skm"));
				double service_cost=Double.parseDouble(request.getParameter("service_cost"));
				int plant_id=Integer.parseInt(request.getParameter("plant_id"));
				
				ServiceBean diesel=new ServiceBean();
				diesel.setDate(date);
				diesel.setTime(time);
				diesel.setLast_skm(last_skm);
				diesel.setPresent_skm(present_skm);
				diesel.setVehicle_no(vehicle_no);
				diesel.setService_cost(service_cost);
				diesel.setVehicle(vehicle);
				diesel.setPlant_id(plant_id);
				
				int count=dao.insertService(diesel);
				
				if(count>0) {
					session.setAttribute("res", "Service Details Added Successfully");
					response.sendRedirect("VehicleServiceList.jsp");
				}else {
					session.setAttribute("res", "<span class='text-danger'>Failed!!</span>");
					response.sendRedirect("VehicleServiceList.jsp");
				}
			}
			
			
			else if(action.equals("checkDetails")) {
				response.setContentType("application/json");
				response.setCharacterEncoding("utf-8");
				String vehicle_no=request.getParameter("vehicle_no");
				ServiceBean bean=dao.getLastServiceDetailsByVehicle(vehicle_no);
				Gson gson=new Gson();
				writer.println(gson.toJson(bean));
			}
			
			else if(action.equals("UpdateService")) {
				String vehicle_no=request.getParameter("vehicle_no");
				String vehicle=request.getParameter("vehicle_type");
				String time=request.getParameter("time");
				String date=request.getParameter("date");
				double last_skm=Double.parseDouble(request.getParameter("last_skm"));
				double present_skm=Double.parseDouble(request.getParameter("present_skm"));
				double service_cost=Double.parseDouble(request.getParameter("service_cost"));
				int plant_id=Integer.parseInt(request.getParameter("plant_id"));
				int vs_id=Integer.parseInt(request.getParameter("vs_id"));
				
				ServiceBean diesel=new ServiceBean();
				diesel.setDate(date);
				diesel.setTime(time);
				diesel.setLast_skm(last_skm);
				diesel.setPresent_skm(present_skm);
				diesel.setVehicle_no(vehicle_no);
				diesel.setService_cost(service_cost);
				diesel.setVehicle(vehicle);
				diesel.setPlant_id(plant_id);
				diesel.setVs_id(vs_id);
				
				int count=dao.updateService(diesel);
				
				if(count>0) {
					session.setAttribute("res", "Service Details Updated Successfully");
					response.sendRedirect("VehicleServiceList.jsp");
				}else {
					session.setAttribute("res", "<span class='text-danger'>Failed!!</span>");
					response.sendRedirect("VehicleServiceList.jsp");
				}
			}
			
			else if(action.equals("DeleteService")) {
				int vs_id=Integer.parseInt(request.getParameter("vs_id"));
				int plant_id=Integer.parseInt(request.getParameter("plant_id"));
				int count=dao.deleteService(vs_id);
				if(count>0) {
					
					
					session.setAttribute("res", "Consumption Deleted Successfully");
					response.sendRedirect("VehicleServiceList.jsp");
				}else {
					session.setAttribute("res", "<span class='text-danger'>Failed!!</span>");
					response.sendRedirect("VehicleServiceList.jsp");
				}
			}
			
		
	}
		catch(Exception e) {
			e.printStackTrace();
		}
	}



}

