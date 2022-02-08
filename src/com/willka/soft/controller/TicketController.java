package com.willka.soft.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.willka.soft.bean.TicketBean;
import com.willka.soft.bean.UserDetailBean;
import com.willka.soft.dao.TicketDAO;
import com.willka.soft.dao.TicketDAOImpl;
import com.willka.soft.dao.VehicleDAO;
import com.willka.soft.dao.VehicleDAOImpl;

/**
 * Servlet implementation class TicketController
 */
@WebServlet("/TicketController")
public class TicketController extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html");
		PrintWriter writer=response.getWriter();
		HttpSession ses=request.getSession();
		TicketDAO tdao=new TicketDAOImpl();
		VehicleDAO vdao=new VehicleDAOImpl();
		try {
			String action=request.getParameter("action");
			if(action.equals("addTicket")) {
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
					count=vdao.updateEmptyWeight(vehicle_no,weight);
				}else {
					loaded_weight=weight;
					count=vdao.updateLoadedWeight(vehicle_no, weight);
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
				writer.println(result);
			}
			
			else if(action.equals("getTicketList")) {
				response.setContentType("application/json");
				response.setCharacterEncoding("utf-8");
				Gson gson=new Gson();
				int plant_id=Integer.parseInt(request.getParameter("plant_id"));
				int business_id=Integer.parseInt(request.getParameter("business_id"));
				int start=Integer.parseInt(request.getParameter("start"));
				int length=Integer.parseInt(request.getParameter("length"));
				Map<String,Object> data=new HashMap<>();
				String search=request.getParameter("search[value]");
				int draw=Integer.parseInt(request.getParameter("draw"));
				data.put("data", tdao.getTicketList(search, plant_id, business_id, start, length));
				data.put("draw", draw);
				int recordCount=tdao.countTicketList(search, plant_id, business_id);
				data.put("recordsTotal", recordCount);
				data.put("recordsFiltered", recordCount);
				writer.print(gson.toJson(data));
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
	}

}
