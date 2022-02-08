package com.willka.soft.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.willka.soft.bean.VehicleRepairBean;
import com.willka.soft.dao.RepairDAOImpl;


/**
 * Servlet implementation class RepairController
 */
@WebServlet("/RepairController")
public class RepairController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RepairController() {
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
		HttpSession session=request.getSession();
		RepairDAOImpl dao=new RepairDAOImpl();
		
		
		try {
			String action=request.getParameter("action");
			if(action.equals("InsertRepair")) {
				String vehicle_no=request.getParameter("vehicle_no");
				String time=request.getParameter("repair_time");
				String date=request.getParameter("repair_date");
				double repair_cost=Double.parseDouble(request.getParameter("repair_cost"));
				int plant_id=Integer.parseInt(request.getParameter("plant_id"));
				String description=request.getParameter("description");
				String remarks=request.getParameter("remarks");
				String vendor=request.getParameter("vendor");
				String received_person=request.getParameter("received_person");
				String place=request.getParameter("place");
				
				
				
				VehicleRepairBean diesel=new VehicleRepairBean();
				diesel.setRepair_date(date);
				diesel.setRepair_time(time);
				diesel.setVehicle_no(vehicle_no);
				diesel.setRepair_cost(repair_cost);
				diesel.setDescription(description);
				diesel.setPlant_id(plant_id);
				diesel.setPlace(place);
				diesel.setRemarks(remarks);
				diesel.setPlant_id(plant_id);
				diesel.setVendor(vendor);
				diesel.setReceived_person(received_person);
				int count=dao.insertRepair(diesel);
				
				if(count>0) {
					session.setAttribute("res", "Repair Details Added Successfully");
					response.sendRedirect("VehicleRepairList.jsp");
				}else {
					session.setAttribute("res", "<span class='text-danger'>Failed!!</span>");
					response.sendRedirect("VehicleRepairList.jsp");
				}
			}
			
			
		
			
			else if(action.equals("UpdateRepair")) {
				String vehicle_no=request.getParameter("vehicle_no");
				String time=request.getParameter("repair_time");
				String date=request.getParameter("repair_date");
				double repair_cost=Double.parseDouble(request.getParameter("repair_cost"));
				int plant_id=Integer.parseInt(request.getParameter("plant_id"));
				String description=request.getParameter("description");
				String remarks=request.getParameter("remarks");
				String vendor=request.getParameter("vendor");
				String received_person=request.getParameter("received_person");
				String place=request.getParameter("place");
				int gp_no=Integer.parseInt(request.getParameter("gp_no"));
				
				VehicleRepairBean diesel=new VehicleRepairBean();
				diesel.setRepair_date(date);
				diesel.setRepair_time(time);
				diesel.setVehicle_no(vehicle_no);
				diesel.setRepair_cost(repair_cost);
				diesel.setDescription(description);
				diesel.setPlant_id(plant_id);
				diesel.setPlace(place);
				diesel.setRemarks(remarks);
				diesel.setPlant_id(plant_id);
				diesel.setVendor(vendor);
				diesel.setGp_no(gp_no);
				diesel.setReceived_person(received_person);
				int count=dao.updateRepair(diesel);
				
				if(count>0) {
					session.setAttribute("res", "Service Details Updated Successfully");
					response.sendRedirect("VehicleRepairList.jsp");
				}else {
					session.setAttribute("res", "<span class='text-danger'>Failed!!</span>");
					response.sendRedirect("VehicleRepairList.jsp");
				}
			}
			
			else if(action.equals("DeleteRepair")) {
				int gp_no=Integer.parseInt(request.getParameter("gp_no"));
				int plant_id=Integer.parseInt(request.getParameter("plant_id"));
				int count=dao.deleteRepair(gp_no);
				if(count>0) {
					
					
					session.setAttribute("res", "Repair Deleted Successfully");
					response.sendRedirect("VehicleRepairList.jsp");
				}else {
					session.setAttribute("res", "<span class='text-danger'>Failed!!</span>");
					response.sendRedirect("VehicleRepairList.jsp");
				}
			}
			
		
	}
		catch(Exception e) {
			e.printStackTrace();
		}
	}



}


