package com.willka.soft.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.willka.soft.bean.TicketBean;
import com.willka.soft.bean.UserDetailBean;
import com.willka.soft.bean.VehiclesBean;
import com.willka.soft.dao.TicketDAOImpl;
import com.willka.soft.dao.VehicleDAOImpl;

@WebServlet("/VehicleController")
public class VehicleController extends HttpServlet {

	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void doPost(HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException{
		//general settings
		response.setContentType("text/html");
		//get pressed button
		String pressed_button=request.getParameter("button");
		VehicleDAOImpl dao=new VehicleDAOImpl();
		TicketDAOImpl tdao=new TicketDAOImpl();
		HttpSession ses=request.getSession();
		PrintWriter writer=response.getWriter();
		try{
			if(pressed_button.equals("insert")){
				//create HttpSession object
				
				try {
					//get request parameter
					String vehicle_no=request.getParameter("vehicle_no");
					String vehicle_name=request.getParameter("vehicle_name");
					String driver_name=request.getParameter("driver_name");
					String insurance_valid_till=request.getParameter("insurance_valid_till");
					String insurance_no=request.getParameter("insurance_no");
					String vehicle_type=request.getParameter("vehicle_type");
					double meter_reading=(request.getParameter("meter_reading")==null || request.getParameter("meter_reading").trim().equals(""))?0.0:Double.parseDouble(request.getParameter("meter_reading"));
					String fc_date=request.getParameter("fc_date");
					String tax_date=request.getParameter("tax_date");
					double vehicle_weight=(request.getParameter("vehicle_weight")==null || request.getParameter("vehicle_weight").trim().equals(""))?0.0:Double.parseDouble(request.getParameter("vehicle_weight"));
					String vehicle_cat=request.getParameter("vehicle_cat");
					
					//create VehicleBean object
					VehiclesBean bean=new VehiclesBean();
					//set value to bean object
					bean.setVehicle_no(vehicle_no);
					bean.setVehicle_name(vehicle_name);
					bean.setDriver_name(driver_name);
					bean.setInsurance_valid_till(insurance_valid_till);
					bean.setInsurance_no(insurance_no);
					bean.setVehicle_type(vehicle_type);
					bean.setMeter_reading(meter_reading);
					bean.setFc_date(fc_date);
					bean.setTax_date(tax_date);
					bean.setVehicle_weight(vehicle_weight);
					bean.setVehicle_cat(vehicle_cat);
					
					
					int count=dao.insertVehicleDetail(bean);
					
					if(count>0) {
						ses.setAttribute("result", "Vehicle No "+vehicle_no+" Inserted Successfully");
						response.sendRedirect("VehicleList.jsp");
					}else {
						ses.setAttribute("result", "<span class='text-danger'>Failed!!</span>");
						response.sendRedirect("VehicleList.jsp");
					}
				}catch(Exception e) {
					e.printStackTrace();
					ses.setAttribute("result", "Vehicle Already Exist");
					response.sendRedirect("VehicleList.jsp");
					
				}
			}
			
			else if(pressed_button.equals("addedByJavaScript")) {
				try {
					//get request parameter
					String vehicle_no=request.getParameter("vehicle_no");
					String vehicle_name=request.getParameter("vehicle_name");
					String driver_name=request.getParameter("driver_name");
					String insurance_valid_till=request.getParameter("insurance_valid_till");
					String insurance_no=request.getParameter("insurance_no");
					String vehicle_type=request.getParameter("vehicle_type");
					double meter_reading=(request.getParameter("meter_reading")==null || request.getParameter("meter_reading").trim().equals(""))?0.0:Double.parseDouble(request.getParameter("meter_reading"));
					String fc_date=request.getParameter("fc_date");
					String tax_date=request.getParameter("tax_date");
					double vehicle_weight=(request.getParameter("vehicle_weight")==null || request.getParameter("vehicle_weight").trim().equals(""))?0.0:Double.parseDouble(request.getParameter("vehicle_weight"));
					String vehicle_cat=request.getParameter("vehicle_cat");
					
					//create VehicleBean object
					VehiclesBean bean=new VehiclesBean();
					//set value to bean object
					bean.setVehicle_no(vehicle_no);
					bean.setVehicle_name(vehicle_name);
					bean.setDriver_name(driver_name);
					bean.setInsurance_valid_till(insurance_valid_till);
					bean.setInsurance_no(insurance_no);
					bean.setVehicle_type(vehicle_type);
					bean.setMeter_reading(meter_reading);
					bean.setFc_date(fc_date);
					bean.setTax_date(tax_date);
					bean.setVehicle_weight(vehicle_weight);
					bean.setVehicle_cat(vehicle_cat);
					int count=dao.insertVehicleDetail(bean);
					writer.println(count);
				}catch(Exception e) {
					writer.println(-1);
					
				}
			}
			
			
			else if(pressed_button.equals("update")){

				try {
					//get request parameter
					String vehicle_no=request.getParameter("vehicle_no");
					String vehicle_name=request.getParameter("vehicle_name");
					String driver_name=request.getParameter("driver_name");
					String insurance_valid_till=request.getParameter("insurance_valid_till");
					String insurance_no=request.getParameter("insurance_no");
					String vehicle_type=request.getParameter("vehicle_type");
					double meter_reading=(request.getParameter("meter_reading")==null || request.getParameter("meter_reading").trim().equals(""))?0.0:Double.parseDouble(request.getParameter("meter_reading"));
					String fc_date=request.getParameter("fc_date");
					String tax_date=request.getParameter("tax_date");
					double vehicle_weight=(request.getParameter("vehicle_weight")==null || request.getParameter("vehicle_weight").trim().equals(""))?0.0:Double.parseDouble(request.getParameter("vehicle_weight"));
					String vehicle_cat=request.getParameter("vehicle_cat");
					
					//create VehicleBean object
					VehiclesBean bean=new VehiclesBean();
					//set value to bean object
					bean.setVehicle_no(vehicle_no);
					bean.setVehicle_name(vehicle_name);
					bean.setDriver_name(driver_name);
					bean.setInsurance_valid_till(insurance_valid_till);
					bean.setInsurance_no(insurance_no);
					bean.setVehicle_type(vehicle_type);
					bean.setMeter_reading(meter_reading);
					bean.setFc_date(fc_date);
					bean.setTax_date(tax_date);
					bean.setVehicle_weight(vehicle_weight);
					bean.setVehicle_cat(vehicle_cat);
					
					
					int count=dao.updateVehicleDetail(bean);
					
					if(count>0) {
						ses.setAttribute("result", "Vehicle No "+vehicle_no+" Updated Successfully");
						response.sendRedirect("VehicleList.jsp");
					}else {
						ses.setAttribute("result", "<span class='text-danger'>Failed!!</span>");
						response.sendRedirect("VehicleList.jsp");
					}
				}catch(Exception e) {
					e.printStackTrace();
					ses.setAttribute("result", "Vehicle No Already Exist");
					response.sendRedirect("VehicleList.jsp");
					
				}
				
			}
			else if(pressed_button.equals("delete")){
				try {
					//create HttpSession object
					String vehicle_no=request.getParameter("vehicle_no");
					int count=dao.deleteVehicleSingleVehicle(vehicle_no);
					if(count>0){
						ses.setAttribute("result","Deleted Successfully");
						response.sendRedirect("VehicleList.jsp");
					}
					else{
						ses.setAttribute("result","<span class='text-danger'>Cann't delete</span>");
						response.sendRedirect("VehicleList.jsp");
					}
				}catch(Exception e) {
					ses.setAttribute("result","<span class='text-danger'>Cann't delete!! Already in use</span>");
					response.sendRedirect("VehicleList.jsp");
				}
			}
			
			
			else if(pressed_button.equals("getAllVehicle")) {
				response.setContentType("application/json");
				response.setCharacterEncoding("utf-8");
				Gson gson=new Gson();
				List<String> data=dao.getAllVehicleForOption();
				writer.println(gson.toJson(data));
			}
			
			
			else if(pressed_button.equals("WeightDetails")) {
				String vehicle_no=request.getParameter("vehicle_no");
				double weight=Double.parseDouble(request.getParameter("weight"));
				String weight_type=request.getParameter("weight_type");
				int product_id=Integer.parseInt(request.getParameter("product_id"));
				int plant_id=Integer.parseInt(request.getParameter("plant_id"));
				double empty_weight=0;
				double loaded_weight=0;
				int  count=0;
				if(weight_type.equals("empty")) {
					empty_weight=weight;
					count=dao.updateEmptyWeight(vehicle_no,weight);
				}else {
					loaded_weight=weight;
					count=dao.updateLoadedWeight(vehicle_no, weight);
				}
				//now add to ticket list
				TicketBean tbean=new TicketBean();
				tbean.setPlant_id(plant_id);
				tbean.setEmpty_weight(empty_weight);
				tbean.setLoaded_weight(loaded_weight);
				tbean.setProduct_id(product_id);
				int ticket_id=tdao.getMaxTicketAccordingPlant(plant_id,"wb")+1;
				tbean.setTicket_id(ticket_id);
				tbean.setVehicle_no(vehicle_no);
				tbean.setTicket_type("wb");
				UserDetailBean ubean=(UserDetailBean)ses.getAttribute("bean");
				tbean.setUser_name(ubean.getUser_email());
				int result=tdao.insertTicketDetails(tbean);
				
				if(result>0) {
					ses.setAttribute("res", "Ticket Id : "+ticket_id+"Generated Successfully");
					response.sendRedirect("TicketList.jsp");
				}else {
					ses.setAttribute("res", "<span classs='text-danger'>Failed!!</span>");
					response.sendRedirect("TicketList.jsp");
				}
				
			}
			
			
			else if(pressed_button.equals("InsertTempVehicle")) {
				try {
					String vehicle_no=request.getParameter("vehicle_no");
					VehiclesBean bean=new VehiclesBean();
					bean.setVehicle_no(vehicle_no);
					bean.setVehicle_type("temp");
					
					int count=dao.insertVehicleDetail(bean);
					if(count>0) {
						ses.setAttribute("res", "Vehicle Inserted");
						response.sendRedirect("Ticket.jsp");
					}else {
						ses.setAttribute("res", "<span class='text-danger'>Failed!!</span>");
						response.sendRedirect("Ticket.jsp");
					}
				}catch(Exception e) {
					e.printStackTrace();
					ses.setAttribute("res", "<span class='text-danger'>Already Exist!! Please Search..</span>");
					response.sendRedirect("Ticket.jsp");
				}
				
			}
			
			else if(pressed_button.equals("GetEmptyWeight")){
				//get ticket id also
				response.setContentType("application/json");
				response.setCharacterEncoding("UTF-8");
				Gson gson=new Gson();
				HashMap<String, Object> myval=new HashMap<>();
				String vehicle_no=request.getParameter("vehicle_no");
				int ticket_id=dao.getLastTicketRised(vehicle_no);
				double empty_weight=dao.getEmptyWeight(vehicle_no);
				myval.put("empty_weight", empty_weight);
				myval.put("ticket_id", ticket_id);
				writer.print(gson.toJson(myval));
			}
			
			else if(pressed_button.trim().equals("loadedWeight")) {
				response.setContentType("application/json");
				response.setCharacterEncoding("UTF-8");
				Gson gson=new Gson();
				HashMap<String, Object> myval=new HashMap<>();
				String vehicle_no=request.getParameter("vehicle_no");
				double loaded_weight=dao.getLoadedWeight(vehicle_no);
				int ticket_id=dao.getLastTicketRised(vehicle_no);
				myval.put("loaded_weight", loaded_weight);
				myval.put("ticket_id", ticket_id);
				writer.print(gson.toJson(myval));
			}
	}
catch(Exception e){
		e.printStackTrace();	
		}
		
		
	}
}
