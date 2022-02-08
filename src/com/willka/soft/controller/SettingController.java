package com.willka.soft.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.willka.soft.bean.FleetItemBean;
import com.willka.soft.bean.GSTSettingBean;
import com.willka.soft.bean.MailSettingBean;
import com.willka.soft.bean.MoistureCorrectionBean;
import com.willka.soft.dao.SettingDAO;
import com.willka.soft.dao.SettingDAOImpl;

/**
 * Servlet implementation class SettingController
 */
@WebServlet("/SettingController")
public class SettingController extends HttpServlet {
	
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 4641L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html");
		HttpSession session=request.getSession();
		PrintWriter writer=response.getWriter();
		SettingDAO dao=new SettingDAOImpl();
		
		try {
			String action=request.getParameter("action");
			
			if(action.equals("changeGSTSetting")) {
				float cgst=(request.getParameter("cgst")==null || request.getParameter("cgst").trim().equals(""))?0.0f:Float.parseFloat(request.getParameter("cgst"));
				float sgst=(request.getParameter("sgst")==null || request.getParameter("sgst").trim().equals(""))?0.0f:Float.parseFloat(request.getParameter("sgst"));
				float igst=(request.getParameter("igst")==null || request.getParameter("igst").trim().equals(""))?0.0f:Float.parseFloat(request.getParameter("igst"));
				
				GSTSettingBean bean=new GSTSettingBean();
				bean.setCgst(cgst);
				bean.setSgst(sgst);
				bean.setIgst(igst);
				boolean checkAvailability=dao.checkAvailableOfGSTSetting();
				if(checkAvailability==true) {
					dao.updateGSTSetting(bean);
				}else {
					dao.insertGSTSetting(bean);
				}
				
				session.setAttribute("result", "Setting Saved Successfully");
				response.sendRedirect("GSTSetting.jsp");
			}
			
			else if(action.equals("changeEmailSetting")) {
				String smtp_host=request.getParameter("smtp_host");
				String smtp_user=request.getParameter("smtp_user");
				String smtp_password=request.getParameter("smtp_password");
				String smtp_port=request.getParameter("smtp_port");
				String smtp_security=request.getParameter("smtp_security");
				String smtp_authontication_domain=request.getParameter("smtp_authentication_domain");
				
				MailSettingBean bean=new MailSettingBean();
				bean.setSmtp_host(smtp_host);
				bean.setSmtp_user(smtp_user);
				bean.setSmtp_port(smtp_port);
				bean.setSmtp_authontication_domain(smtp_authontication_domain);
				bean.setSmtp_security(smtp_security);
				bean.setSmtp_password(smtp_password);
				
				boolean available=dao.checkAvailableOfMailSetting();
				if(available==true) {
					dao.updateMailSetting(bean);
				}else {
					dao.insertMailSetting(bean);
				}
				session.setAttribute("result","Mail Setting Saved");
				response.sendRedirect("MailSetting.jsp");
			}
			
			else if(action.equals("getGstDetails")) {
				String gst_type=request.getParameter("gst_type");
				GSTSettingBean bean=dao.getGstDetails();
				if(bean!=null) {
					if(gst_type.equalsIgnoreCase("GST")) {
						writer.print(bean.getCgst()+bean.getSgst());
					}else {
						writer.println(bean.getIgst());
					}
				}
			}
			
			else if(action.equals("InsertGSTPercent")){
				try {
					float gst_percent=(request.getParameter("gst_percent")==null || request.getParameter("gst_percent").trim().equals(""))?0.0f:Float.parseFloat(request.getParameter("gst_percent"));
					String gst_category=request.getParameter("gst_category");
					
					int count=dao.insertGST(gst_percent,gst_category);
					
					if(count>0){
						session.setAttribute("res", "GST Percent Inserted");
						response.sendRedirect("GSTPercent.jsp");
					}else{
						session.setAttribute("res", "<span class='text-danger'>Failed!!</span>");
						response.sendRedirect("GSTPercent.jsp");
					}
				}catch(Exception e) {
					session.setAttribute("res", "<span style='color:red;'>GST  Already Exist</span>");
					response.sendRedirect("GSTPercent.jsp");
				}
			}
			
			else if(action.equals("DeleteSetting")){
				try {
					int gst_id=Integer.parseInt(request.getParameter("gst_id"));
					int count=dao.deleteGST(gst_id);
					if(count>0){
						session.setAttribute("res", "Gst Deleted Successfully");
						response.sendRedirect("GSTPercent.jsp");
					}else{
						session.setAttribute("res", "<span class='text-danger'>Failed!!</span>");
						response.sendRedirect("GSTPercent.jsp");
					}
				}catch(Exception e) {
					session.setAttribute("res", "<span class='text-danger'>Cann't delete already in use!!!</span>");
					response.sendRedirect("GSTPercent.jsp");
				}
			}
			
			else if(action.equals("changeDIESELSetting")) {
				int fleet_item_id=Integer.parseInt(request.getParameter("fleet_item_id"));
				
				FleetItemBean bean=new FleetItemBean();
				bean.setFleet_item_id(fleet_item_id);
				
				boolean available=dao.checkAvailableOfDieselSetting();
				if(available==true) {
					dao.updateDieselSetting(fleet_item_id);
				}else {
					dao.insertDiscelSetting(fleet_item_id);
				}
				session.setAttribute("result","Diesel Setting Saved");
				response.sendRedirect("OtherSetting.jsp");
			}
			
			
			else if(action.equals("InsertUnit")) {
				String unit_name=request.getParameter("unit_name");
				int count=dao.addUnitDetails(unit_name);
				if(count>0){
					session.setAttribute("res", "Unit Inserted Successfully");
					response.sendRedirect("Units.jsp");
				}else{
					session.setAttribute("res", "<span class='text-danger'>Failed!!</span>");
					response.sendRedirect("Units.jsp");
				}
			}
			
			else if(action.equals("DeleteUnit")) {
				int unit_id=Integer.parseInt(request.getParameter("unit_id"));
				int count=dao.deleteUnitDetails(unit_id);
				if(count>0){
					session.setAttribute("res", "Unit Deleted Successfully");
					response.sendRedirect("Units.jsp");
				}else{
					session.setAttribute("res", "<span class='text-danger'>Failed!!</span>");
					response.sendRedirect("Units.jsp");
				}
			}
			
			else if(action.equals("insertMoistureSetting")) {
				float aggr1_moi=Float.parseFloat(request.getParameter("aggr1_moi"));
				float aggr2_moi=Float.parseFloat(request.getParameter("aggr2_moi"));
				float aggr3_moi=Float.parseFloat(request.getParameter("aggr3_moi"));
				float aggr4_moi=Float.parseFloat(request.getParameter("aggr4_moi"));
				float aggr1_abs=Float.parseFloat(request.getParameter("aggr1_abs"));
				float aggr2_abs=Float.parseFloat(request.getParameter("aggr2_abs"));
				float aggr3_abs=Float.parseFloat(request.getParameter("aggr3_abs"));
				float aggr4_abs=Float.parseFloat(request.getParameter("aggr4_abs"));
				int plant_id=Integer.parseInt(request.getParameter("plant_id"));
				
				MoistureCorrectionBean bean=new
							MoistureCorrectionBean();
				bean.setAggr1_moi(aggr1_moi);
				bean.setAggr2_moi(aggr2_moi);
				bean.setAggr3_moi(aggr3_moi);
				bean.setAggr4_moi(aggr4_moi);
				bean.setAggr1_abs(aggr1_abs);
				bean.setAggr2_abs(aggr2_abs);
				bean.setAggr3_abs(aggr3_abs);
				bean.setAggr4_abs(aggr4_abs);
				bean.setPlant_id(plant_id);
				
				boolean check=dao.checkAvailabilityMoisture(plant_id);
				if(check==false) {
					dao.insertMoistureSetting(bean);
				}else {
					dao.updateMoistureSetting(bean);
				}
				session.setAttribute("result", "Saved Successfully");
				response.sendRedirect("MoistureCorrection.jsp");
			}
			
			else if (action.equals("getMoistureDetails")) {
				response.setContentType("application/json");
				response.setCharacterEncoding("utf-8");
				Gson gson=new Gson();
				int plant_id=Integer.parseInt(request.getParameter("plant_id"));
				MoistureCorrectionBean bean= new MoistureCorrectionBean();
				bean=dao.getMoistureDetails1(plant_id);
				writer.println(gson.toJson(bean));
				
			}
			
			else if(action.equals("addBusinessGroup")) {
				String group_name=request.getParameter("group_name");
				String group_description=request.getParameter("group_description");
				int count=dao.addBusinessGroup(group_name, group_description);
				if(count>0){
					session.setAttribute("res", "Business Group Added");
					response.sendRedirect("BusinessGroup.jsp");
				}else{
					session.setAttribute("res", "<span class='text-danger'>Failed!!</span>");
					response.sendRedirect("BusinessGroup.jsp");
				}
			}
			
			else if(action.equals("DeleteBusinessGroup")) {
				try {
					int business_id=Integer.parseInt(request.getParameter("business_id"));
					int count=dao.deleteBusinessGroup(business_id);
					if(count>0){
						session.setAttribute("res", "Deleted Successfully");
						response.sendRedirect("BusinessGroup.jsp");
					}else{
						session.setAttribute("res", "<span class='text-danger'>Failed!!</span>");
						response.sendRedirect("BusinessGroup.jsp");
					}
				}catch(Exception e) {
						session.setAttribute("res", "<span class='text-danger'>Already in use!!</span>");
						response.sendRedirect("BusinessGroup.jsp");
				}
			}
			
			else if(action.equals("getUnitListForOption")) {
				response.setContentType("application/json");
				response.setCharacterEncoding("utf-8");
				Gson gson=new Gson();
				HashMap<Integer, String> units=dao.getUnitListForOptions();
				writer.println(gson.toJson(units));
			}
			
			else if(action.equals("getGstList")) {
				response.setContentType("application/json");
				response.setCharacterEncoding("utf-8");
				Gson gson=new Gson();
				List<Map<String,Object>> list=dao.getGstList();
				writer.println(gson.toJson(list));
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}

}
