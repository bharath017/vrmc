package com.willka.soft.controller;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.willka.soft.bean.DieselConsumptionBean;
import com.willka.soft.bean.DieselModificationBean;
import com.willka.soft.bean.InventoryStockBean;
import com.willka.soft.bean.UserDetailBean;
import com.willka.soft.dao.DieselConsumptionDAOImpl;
import com.willka.soft.dao.InventoryDAO;
import com.willka.soft.dao.InventoryDAOImpl;
import com.willka.soft.dao.SettingDAO;
import com.willka.soft.dao.SettingDAOImpl;



/**
 * Servlet implementation class DieselConsumptionController
 */
@WebServlet("/DieselConsumptionController")
public class DieselConsumptionController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		PrintWriter writer=response.getWriter();
		HttpSession session=request.getSession();
		DieselConsumptionDAOImpl dao=new DieselConsumptionDAOImpl();
		SettingDAO settingdao=new SettingDAOImpl();
		InventoryDAO inventorydao=new InventoryDAOImpl();
		
		try {
			String action=request.getParameter("action");
			if(action.equals("InsertConsumption")) {
				String vehicle_no=request.getParameter("vehicle_no");
				String issued_date=request.getParameter("issued_date");
				String issued_time=request.getParameter("issued_time");
				double opening_km=Double.parseDouble(request.getParameter("opening_km"));
				double closing_km=Double.parseDouble(request.getParameter("closing_km"));
				double issued_quantity=Double.parseDouble(request.getParameter("issued_quantity"));
				String driver_name=request.getParameter("driver_name");
				String issued_person=request.getParameter("issued_person");
				int plant_id=Integer.parseInt(request.getParameter("plant_id"));
				
				DieselConsumptionBean diesel=new DieselConsumptionBean();
				diesel.setIssued_date(issued_date);
				diesel.setIssued_time(issued_time);
				diesel.setClosing_km(closing_km);
				diesel.setOpning_km(opening_km);
				diesel.setVehicle_no(vehicle_no);
				diesel.setIssued_quantity(issued_quantity);
				diesel.setDriver_name(driver_name);
				diesel.setIssued_person(issued_person);
				diesel.setPlant_id(plant_id);
				
				int count=dao.insertDieselConsumption(diesel);
				
				if(count>0) {
					//Now consume from store
					int diesel_id=settingdao.getDieselId();
					InventoryStockBean stock=inventorydao.getStockDetails(diesel_id, plant_id);
					if(stock!=null) {
						stock.setStock_quantity(stock.getStock_quantity()-issued_quantity);
						inventorydao.updateInventoryStock(stock);
					}
					session.setAttribute("res", "Consumption Added Successfully");
					response.sendRedirect("consumption_list.jsp");
				}else {
					session.setAttribute("res", "<span class='text-danger'>Failed!!</span>");
					response.sendRedirect("consumption_list.jsp");
				}
			}
			
			else if(action.equals("checkDetails")) {
				response.setContentType("application/json");
				response.setCharacterEncoding("utf-8");
				String vehicle_no=request.getParameter("vehicle_no");
				DieselConsumptionBean bean=dao.getLastConsumptionDetailsByVehicle(vehicle_no);
				Gson gson=new Gson();
				writer.println(gson.toJson(bean));
			}
			
			else if(action.equals("UpdateConsumption")) {
				String vehicle_no=request.getParameter("vehicle_no");
				String issued_date=request.getParameter("issued_date");
				String issued_time=request.getParameter("issued_time");
				double opening_km=Double.parseDouble(request.getParameter("opening_km"));
				double closing_km=Double.parseDouble(request.getParameter("closing_km"));
				double issued_quantity=Double.parseDouble(request.getParameter("issued_quantity"));
				String driver_name=request.getParameter("driver_name");
				String issued_person=request.getParameter("issued_person");
				int plant_id=Integer.parseInt(request.getParameter("plant_id"));
				int diesel_id=Integer.parseInt(request.getParameter("diesel_id"));
				String comment=request.getParameter("comment");
				
				DieselConsumptionBean diesel=new DieselConsumptionBean();
				diesel.setIssued_date(issued_date);
				diesel.setIssued_time(issued_time);
				diesel.setClosing_km(closing_km);
				diesel.setOpning_km(opening_km);
				diesel.setVehicle_no(vehicle_no);
				diesel.setIssued_quantity(issued_quantity);
				diesel.setDriver_name(driver_name);
				diesel.setIssued_person(issued_person);
				diesel.setPlant_id(plant_id);
				diesel.setConsumption_id(diesel_id);
				
				DieselConsumptionBean diselbean=dao.getSingleDeiselDetailsByDieselId(diesel_id);
				int count=dao.updateDieselConsumption(diesel);
				
				if(count>0) {
					int d_id=settingdao.getDieselId();
					InventoryStockBean stock=inventorydao.getStockDetails(d_id, plant_id);
					stock.setStock_quantity(stock.getStock_quantity()-(issued_quantity-diselbean.getIssued_quantity()));
					inventorydao.updateInventoryStock(stock);
					
					DieselModificationBean bean=new DieselModificationBean();
					bean.setComment(comment);
					bean.setDiesel_id(diesel_id);
					bean.setModification_type("update");
					UserDetailBean been=(UserDetailBean)session.getAttribute("bean");
					bean.setModified_by(been.getUsername());
					bean.setOld_quantity(diselbean.getIssued_quantity());
					bean.setNew_quantity(issued_quantity);
					dao.insertdieselModificationDetails(bean);
					
					
					session.setAttribute("res", "Consumption Updated Successfully");
					response.sendRedirect("consumption_list.jsp");
				}else {
					session.setAttribute("res", "<span class='text-danger'>Failed!!</span>");
					response.sendRedirect("consumption_list.jsp");
				}
			}
			
			else if(action.equals("DeleteConsumption")) {
				int diesel_id=Integer.parseInt(request.getParameter("diesel_id"));
				DieselConsumptionBean diselbean=dao.getSingleDeiselDetailsByDieselId(diesel_id);
				int plant_id=Integer.parseInt(request.getParameter("plant_id"));
				String comment=request.getParameter("comment");
				int count=dao.deleteDieselConsumption(diesel_id);
				if(count>0) {
					int d_id=settingdao.getDieselId();
					InventoryStockBean stock=inventorydao.getStockDetails(d_id, plant_id);
					stock.setStock_quantity(stock.getStock_quantity()+diselbean.getIssued_quantity());
					inventorydao.updateInventoryStock(stock);
					
					DieselModificationBean bean=new DieselModificationBean();
					bean.setComment(comment);
					bean.setDiesel_id(diesel_id);
					bean.setModification_type("delete");
					UserDetailBean been=(UserDetailBean)session.getAttribute("bean");
					bean.setModified_by(been.getUsername());
					bean.setOld_quantity(diselbean.getIssued_quantity());
					bean.setNew_quantity(0);
					dao.insertdieselModificationDetails(bean);
					
					session.setAttribute("res", "Consumption Deleted Successfully");
					response.sendRedirect("consumption_list.jsp");
				}else {
					session.setAttribute("res", "<span class='text-danger'>Failed!!</span>");
					response.sendRedirect("consumption_list.jsp");
				}
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
	}

}
