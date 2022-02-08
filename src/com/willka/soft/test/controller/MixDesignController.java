package com.willka.soft.test.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.willka.soft.test.bean.MixDesignBean;
import com.willka.soft.test.dao.MixDesignDAO;
import com.willka.soft.test.dao.MixDesignDAOImpl;

/**
 * Servlet implementation class MixDesignController
 */
@WebServlet("/MixDesignControllerTest")
public class MixDesignController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		PrintWriter writer=response.getWriter();
		HttpSession session=request.getSession();
		MixDesignDAO dao=new MixDesignDAOImpl();
		try {
				String action=request.getParameter("action");
				
				if(action.equals("InsertMixDesign")) {
					String receipe_code=request.getParameter("receipe_code");
					String receipe_name=request.getParameter("receipe_name");
					String aggregate1_name=(request.getParameter("aggregate1_name")==null || request.getParameter("aggregate1_name").trim().equals(""))?"Aggr1":request.getParameter("aggregate1_name");
					int aggregate1_value=(request.getParameter("aggregate1_value")==null || request.getParameter("aggregate1_value").trim().equals(""))?0:Integer.parseInt(request.getParameter("aggregate1_value"));
					String aggregate2_name=(request.getParameter("aggregate2_name")==null || request.getParameter("aggregate2_name").trim().equals(""))?"Aggr2":request.getParameter("aggregate2_name");
					int aggregate2_value=(request.getParameter("aggregate2_value")==null || request.getParameter("aggregate2_value").trim().equals(""))?0:Integer.parseInt(request.getParameter("aggregate2_value"));
					String aggregate3_name=(request.getParameter("aggregate3_name")==null || request.getParameter("aggregate3_name").trim().equals(""))?"Aggr3":request.getParameter("aggregate3_name");
					int aggregate3_value=(request.getParameter("aggregate3_value")==null || request.getParameter("aggregate3_value").trim().equals(""))?0:Integer.parseInt(request.getParameter("aggregate3_value"));
					String aggregate4_name=(request.getParameter("aggregate4_name")==null || request.getParameter("aggregate4_name").trim().equals(""))?"Aggr4":request.getParameter("aggregate4_name");
					int aggregate4_value=(request.getParameter("aggregate4_value")==null || request.getParameter("aggregate4_value").trim().equals(""))?0:Integer.parseInt(request.getParameter("aggregate4_value"));
					String aggregate5_name=(request.getParameter("aggregate5_name")==null || request.getParameter("aggregate5_name").trim().equals(""))?"Cem1":request.getParameter("aggregate5_name");
					int aggregate5_value=(request.getParameter("aggregate5_value")==null || request.getParameter("aggregate5_value").trim().equals(""))?0:Integer.parseInt(request.getParameter("aggregate5_value"));
					String aggregate6_name=(request.getParameter("aggregate6_name")==null || request.getParameter("aggregate6_name").trim().equals(""))?"Cem2":request.getParameter("aggregate6_name");
					int aggregate6_value=(request.getParameter("aggregate6_value")==null || request.getParameter("aggregate6_value").trim().equals(""))?0:Integer.parseInt(request.getParameter("aggregate6_value"));
					String aggregate7_name=(request.getParameter("aggregate7_name")==null || request.getParameter("aggregate7_name").trim().equals(""))?"Cem3":request.getParameter("aggregate7_name");
					int aggregate7_value=(request.getParameter("aggregate7_value")==null || request.getParameter("aggregate7_value").trim().equals(""))?0:Integer.parseInt(request.getParameter("aggregate7_value"));
					String aggregate8_name=(request.getParameter("aggregate8_name")==null || request.getParameter("aggregate8_name").trim().equals(""))?"Water":request.getParameter("aggregate8_name");
					int aggregate8_value=(request.getParameter("aggregate8_value")==null || request.getParameter("aggregate8_value").trim().equals(""))?0:Integer.parseInt(request.getParameter("aggregate8_value"));
					String aggregate9_name=(request.getParameter("aggregate9_name")==null || request.getParameter("aggregate9_name").trim().equals(""))?"Admix1":request.getParameter("aggregate9_name");
					double aggregate9_value=(request.getParameter("aggregate9_value")==null || request.getParameter("aggregate9_value").trim().equals(""))?0:Double.parseDouble(request.getParameter("aggregate9_value"));
					String aggregate10_name=(request.getParameter("aggregate10_name")==null || request.getParameter("aggregate10_name").trim().equals(""))?"Admix2":request.getParameter("aggregate10_name");
					double aggregate10_value=(request.getParameter("aggregate10_value")==null || request.getParameter("aggregate10_value").trim().equals(""))?0:Double.parseDouble(request.getParameter("aggregate10_value"));
					String aggregate11_name=(request.getParameter("aggregate11_name")==null || request.getParameter("aggregate11_name").trim().equals(""))?"Aggr5":request.getParameter("aggregate11_name");
					int aggregate11_value=(request.getParameter("aggregate11_value")==null || request.getParameter("aggregate11_value").trim().equals(""))?0:Integer.parseInt(request.getParameter("aggregate11_value"));
					
					//create bean object
					MixDesignBean bean=new MixDesignBean();
					bean.setReceipe_code(receipe_code);
					bean.setReceipe_name(receipe_name);
					bean.setAggregate1_name(aggregate1_name);
					bean.setAggregate1_value(aggregate1_value);
					bean.setAggregate2_name(aggregate2_name);
					bean.setAggregate2_value(aggregate2_value);
					bean.setAggregate3_name(aggregate3_name);
					bean.setAggregate3_value(aggregate3_value);
					bean.setAggregate4_name(aggregate4_name);
					bean.setAggregate4_value(aggregate4_value);
					bean.setAggregate5_name(aggregate5_name);
					bean.setAggregate5_value(aggregate5_value);
					bean.setAggregate6_name(aggregate6_name);
					bean.setAggregate6_value(aggregate6_value);
					bean.setAggregate7_name(aggregate7_name);
					bean.setAggregate7_value(aggregate7_value);
					bean.setAggregate8_name(aggregate8_name);
					bean.setAggregate8_value(aggregate8_value);
					bean.setAggregate9_name(aggregate9_name);
					bean.setAggregate9_value(aggregate9_value);
					bean.setAggregate10_name(aggregate10_name);
					bean.setAggregate10_value(aggregate10_value);
					bean.setAggregate11_name(aggregate11_name);
					bean.setAggregate11_value(aggregate11_value);
					
					int  count=dao.insertMixDesign(bean);
					
					if(count>0) {
						session.setAttribute("res", "Mix Design Inserted");
						response.sendRedirect("gst/MixDesignList.jsp");
					}else {
						session.setAttribute("res", "<span class='text-danger'>Failed!!</span>");
						response.sendRedirect("gst/MixDesignList.jsp");
					}
					
				}
				
				else if(action.equals("UpdateMixDesign")) {
					int design_id=Integer.parseInt(request.getParameter("design_id"));
					String receipe_code=request.getParameter("receipe_code");
					String receipe_name=request.getParameter("receipe_name");
					String aggregate1_name=(request.getParameter("aggregate1_name")==null || request.getParameter("aggregate1_name").trim().equals(""))?"Aggr1":request.getParameter("aggregate1_name");
					int aggregate1_value=(request.getParameter("aggregate1_value")==null || request.getParameter("aggregate1_value").trim().equals(""))?0:Integer.parseInt(request.getParameter("aggregate1_value"));
					String aggregate2_name=(request.getParameter("aggregate2_name")==null || request.getParameter("aggregate2_name").trim().equals(""))?"Aggr2":request.getParameter("aggregate2_name");
					int aggregate2_value=(request.getParameter("aggregate2_value")==null || request.getParameter("aggregate2_value").trim().equals(""))?0:Integer.parseInt(request.getParameter("aggregate2_value"));
					String aggregate3_name=(request.getParameter("aggregate3_name")==null || request.getParameter("aggregate3_name").trim().equals(""))?"Aggr3":request.getParameter("aggregate3_name");
					int aggregate3_value=(request.getParameter("aggregate3_value")==null || request.getParameter("aggregate3_value").trim().equals(""))?0:Integer.parseInt(request.getParameter("aggregate3_value"));
					String aggregate4_name=(request.getParameter("aggregate4_name")==null || request.getParameter("aggregate4_name").trim().equals(""))?"Aggr4":request.getParameter("aggregate4_name");
					int aggregate4_value=(request.getParameter("aggregate4_value")==null || request.getParameter("aggregate4_value").trim().equals(""))?0:Integer.parseInt(request.getParameter("aggregate4_value"));
					String aggregate5_name=(request.getParameter("aggregate5_name")==null || request.getParameter("aggregate5_name").trim().equals(""))?"Cem1":request.getParameter("aggregate5_name");
					int aggregate5_value=(request.getParameter("aggregate5_value")==null || request.getParameter("aggregate5_value").trim().equals(""))?0:Integer.parseInt(request.getParameter("aggregate5_value"));
					String aggregate6_name=(request.getParameter("aggregate6_name")==null || request.getParameter("aggregate6_name").trim().equals(""))?"Cem2":request.getParameter("aggregate6_name");
					int aggregate6_value=(request.getParameter("aggregate6_value")==null || request.getParameter("aggregate6_value").trim().equals(""))?0:Integer.parseInt(request.getParameter("aggregate6_value"));
					String aggregate7_name=(request.getParameter("aggregate7_name")==null || request.getParameter("aggregate7_name").trim().equals(""))?"Cem3":request.getParameter("aggregate7_name");
					int aggregate7_value=(request.getParameter("aggregate7_value")==null || request.getParameter("aggregate7_value").trim().equals(""))?0:Integer.parseInt(request.getParameter("aggregate7_value"));
					String aggregate8_name=(request.getParameter("aggregate8_name")==null || request.getParameter("aggregate8_name").trim().equals(""))?"Water":request.getParameter("aggregate8_name");
					int aggregate8_value=(request.getParameter("aggregate8_value")==null || request.getParameter("aggregate8_value").trim().equals(""))?0:Integer.parseInt(request.getParameter("aggregate8_value"));
					String aggregate9_name=(request.getParameter("aggregate9_name")==null || request.getParameter("aggregate9_name").trim().equals(""))?"Admix1":request.getParameter("aggregate9_name");
					double aggregate9_value=(request.getParameter("aggregate9_value")==null || request.getParameter("aggregate9_value").trim().equals(""))?0:Double.parseDouble(request.getParameter("aggregate9_value"));
					String aggregate10_name=(request.getParameter("aggregate10_name")==null || request.getParameter("aggregate10_name").trim().equals(""))?"Admix2":request.getParameter("aggregate10_name");
					double aggregate10_value=(request.getParameter("aggregate10_value")==null || request.getParameter("aggregate10_value").trim().equals(""))?0:Double.parseDouble(request.getParameter("aggregate10_value"));
					String aggregate11_name=(request.getParameter("aggregate11_name")==null || request.getParameter("aggregate11_name").trim().equals(""))?"Aggr5":request.getParameter("aggregate11_name");
					int aggregate11_value=(request.getParameter("aggregate11_value")==null || request.getParameter("aggregate11_value").trim().equals(""))?0:Integer.parseInt(request.getParameter("aggregate11_value"));
					
					//create bean object
					MixDesignBean bean=new MixDesignBean();
					bean.setDesign_id(design_id);
					bean.setReceipe_code(receipe_code);
					bean.setReceipe_name(receipe_name);
					bean.setAggregate1_name(aggregate1_name);
					bean.setAggregate1_value(aggregate1_value);
					bean.setAggregate2_name(aggregate2_name);
					bean.setAggregate2_value(aggregate2_value);
					bean.setAggregate3_name(aggregate3_name);
					bean.setAggregate3_value(aggregate3_value);
					bean.setAggregate4_name(aggregate4_name);
					bean.setAggregate4_value(aggregate4_value);
					bean.setAggregate5_name(aggregate5_name);
					bean.setAggregate5_value(aggregate5_value);
					bean.setAggregate6_name(aggregate6_name);
					bean.setAggregate6_value(aggregate6_value);
					bean.setAggregate7_name(aggregate7_name);
					bean.setAggregate7_value(aggregate7_value);
					bean.setAggregate8_name(aggregate8_name);
					bean.setAggregate8_value(aggregate8_value);
					bean.setAggregate9_name(aggregate9_name);
					bean.setAggregate9_value(aggregate9_value);
					bean.setAggregate10_name(aggregate10_name);
					bean.setAggregate10_value(aggregate10_value);
					bean.setAggregate11_name(aggregate11_name);
					bean.setAggregate11_value(aggregate11_value);
					bean.setAggregate1_name(aggregate1_name);
					bean.setAggregate1_value(aggregate1_value);
					
					int  count=dao.updateMixDesign(bean);
					
					if(count>0) {
						session.setAttribute("res", "Receipe Code : "+receipe_code+" Details Updated Successfully");
						response.sendRedirect("gst/MixDesignList.jsp");
					}else {
						session.setAttribute("res", "<span class='text-danger'>Failed!!</span>");
						response.sendRedirect("gst/MixDesignList.jsp");
					}
				}
				
				else if(action.equals("InsertReceipe")) {
					try {
						int customer_id=Integer.parseInt(request.getParameter("customer_id"));
						int site_id=Integer.parseInt(request.getParameter("site_id"));
						int plant_id=Integer.parseInt(request.getParameter("plant_id"));
						int product_id=Integer.parseInt(request.getParameter("product_id"));
						String receipe_code=request.getParameter("receipe_code");
						String aggregate1_name=(request.getParameter("aggregate1_name")==null || request.getParameter("aggregate1_name").trim().equals(""))?"Aggr1":request.getParameter("aggregate1_name");
						int aggregate1_value=(request.getParameter("aggregate1_value")==null || request.getParameter("aggregate1_value").trim().equals(""))?0:Integer.parseInt(request.getParameter("aggregate1_value"));
						String aggregate2_name=(request.getParameter("aggregate2_name")==null || request.getParameter("aggregate2_name").trim().equals(""))?"Aggr2":request.getParameter("aggregate2_name");
						int aggregate2_value=(request.getParameter("aggregate2_value")==null || request.getParameter("aggregate2_value").trim().equals(""))?0:Integer.parseInt(request.getParameter("aggregate2_value"));
						String aggregate3_name=(request.getParameter("aggregate3_name")==null || request.getParameter("aggregate3_name").trim().equals(""))?"Aggr3":request.getParameter("aggregate3_name");
						int aggregate3_value=(request.getParameter("aggregate3_value")==null || request.getParameter("aggregate3_value").trim().equals(""))?0:Integer.parseInt(request.getParameter("aggregate3_value"));
						String aggregate4_name=(request.getParameter("aggregate4_name")==null || request.getParameter("aggregate4_name").trim().equals(""))?"Aggr4":request.getParameter("aggregate4_name");
						int aggregate4_value=(request.getParameter("aggregate4_value")==null || request.getParameter("aggregate4_value").trim().equals(""))?0:Integer.parseInt(request.getParameter("aggregate4_value"));
						String aggregate5_name=(request.getParameter("aggregate5_name")==null || request.getParameter("aggregate5_name").trim().equals(""))?"Cem1":request.getParameter("aggregate5_name");
						int aggregate5_value=(request.getParameter("aggregate5_value")==null || request.getParameter("aggregate5_value").trim().equals(""))?0:Integer.parseInt(request.getParameter("aggregate5_value"));
						String aggregate6_name=(request.getParameter("aggregate6_name")==null || request.getParameter("aggregate6_name").trim().equals(""))?"Cem2":request.getParameter("aggregate6_name");
						int aggregate6_value=(request.getParameter("aggregate6_value")==null || request.getParameter("aggregate6_value").trim().equals(""))?0:Integer.parseInt(request.getParameter("aggregate6_value"));
						String aggregate7_name=(request.getParameter("aggregate7_name")==null || request.getParameter("aggregate7_name").trim().equals(""))?"Cem3":request.getParameter("aggregate7_name");
						int aggregate7_value=(request.getParameter("aggregate7_value")==null || request.getParameter("aggregate7_value").trim().equals(""))?0:Integer.parseInt(request.getParameter("aggregate7_value"));
						String aggregate8_name=(request.getParameter("aggregate8_name")==null || request.getParameter("aggregate8_name").trim().equals(""))?"Water":request.getParameter("aggregate8_name");
						int aggregate8_value=(request.getParameter("aggregate8_value")==null || request.getParameter("aggregate8_value").trim().equals(""))?0:Integer.parseInt(request.getParameter("aggregate8_value"));
						String aggregate9_name=(request.getParameter("aggregate9_name")==null || request.getParameter("aggregate9_name").trim().equals(""))?"Admix1":request.getParameter("aggregate9_name");
						double aggregate9_value=(request.getParameter("aggregate9_value")==null || request.getParameter("aggregate9_value").trim().equals(""))?0:Double.parseDouble(request.getParameter("aggregate9_value"));
						String aggregate10_name=(request.getParameter("aggregate10_name")==null || request.getParameter("aggregate10_name").trim().equals(""))?"Admix2":request.getParameter("aggregate10_name");
						double aggregate10_value=(request.getParameter("aggregate10_value")==null || request.getParameter("aggregate10_value").trim().equals(""))?0:Double.parseDouble(request.getParameter("aggregate10_value"));
						String aggregate11_name=(request.getParameter("aggregate11_name")==null || request.getParameter("aggregate11_name").trim().equals(""))?"Aggr5":request.getParameter("aggregate11_name");
						int aggregate11_value=(request.getParameter("aggregate11_value")==null || request.getParameter("aggregate11_value").trim().equals(""))?0:Integer.parseInt(request.getParameter("aggregate11_value"));
						String cement_name=request.getParameter("cement_name");
						
						//create bean object
						MixDesignBean bean=new MixDesignBean();
						bean.setReceipe_code(receipe_code);
						bean.setAggregate1_name(aggregate1_name);
						bean.setAggregate1_value(aggregate1_value);
						bean.setAggregate2_name(aggregate2_name);
						bean.setAggregate2_value(aggregate2_value);
						bean.setAggregate3_name(aggregate3_name);
						bean.setAggregate3_value(aggregate3_value);
						bean.setAggregate4_name(aggregate4_name);
						bean.setAggregate4_value(aggregate4_value);
						bean.setAggregate5_name(aggregate5_name);
						bean.setAggregate5_value(aggregate5_value);
						bean.setAggregate6_name(aggregate6_name);
						bean.setAggregate6_value(aggregate6_value);
						bean.setAggregate7_name(aggregate7_name);
						bean.setAggregate7_value(aggregate7_value);
						bean.setAggregate8_name(aggregate8_name);
						bean.setAggregate8_value(aggregate8_value);
						bean.setAggregate9_name(aggregate9_name);
						bean.setAggregate9_value(aggregate9_value);
						bean.setAggregate10_name(aggregate10_name);
						bean.setAggregate10_value(aggregate10_value);
						bean.setAggregate11_name(aggregate11_name);
						bean.setAggregate11_value(aggregate11_value);
						bean.setPlant_id(plant_id);
						bean.setProduct_id(product_id);
						bean.setSite_id(site_id);
						bean.setCustomer_id(customer_id);
						bean.setCement_name(cement_name);
						
						int  count=dao.insertReceipe(bean);
						
						if(count>0) {
							session.setAttribute("res", "Receipe Inserted Successfully");
							response.sendRedirect("gst/ReceipeList.jsp");
						}else {
							session.setAttribute("res", "<span class='text-danger'>Failed!!</span>");
							response.sendRedirect("gst/ReceipeList.jsp");
						}
					}catch(Exception e) {
						session.setAttribute("res", "<span class='text-danger'>Receipe Already Exist Please Search..</span>");
						response.sendRedirect("gst/ReceipeList.jsp");
					}
				}
				
				else if(action.equals("UpdateReceipe")) {
					int receipe_id=Integer.parseInt(request.getParameter("receipe_id"));
					int customer_id=Integer.parseInt(request.getParameter("customer_id"));
					int site_id=Integer.parseInt(request.getParameter("site_id"));
					int plant_id=Integer.parseInt(request.getParameter("plant_id"));
					int product_id=Integer.parseInt(request.getParameter("product_id"));
					String receipe_code=request.getParameter("receipe_code");
					String aggregate1_name=(request.getParameter("aggregate1_name")==null || request.getParameter("aggregate1_name").trim().equals(""))?"Aggr1":request.getParameter("aggregate1_name");
					int aggregate1_value=(request.getParameter("aggregate1_value")==null || request.getParameter("aggregate1_value").trim().equals(""))?0:Integer.parseInt(request.getParameter("aggregate1_value"));
					String aggregate2_name=(request.getParameter("aggregate2_name")==null || request.getParameter("aggregate2_name").trim().equals(""))?"Aggr2":request.getParameter("aggregate2_name");
					int aggregate2_value=(request.getParameter("aggregate2_value")==null || request.getParameter("aggregate2_value").trim().equals(""))?0:Integer.parseInt(request.getParameter("aggregate2_value"));
					String aggregate3_name=(request.getParameter("aggregate3_name")==null || request.getParameter("aggregate3_name").trim().equals(""))?"Aggr3":request.getParameter("aggregate3_name");
					int aggregate3_value=(request.getParameter("aggregate3_value")==null || request.getParameter("aggregate3_value").trim().equals(""))?0:Integer.parseInt(request.getParameter("aggregate3_value"));
					String aggregate4_name=(request.getParameter("aggregate4_name")==null || request.getParameter("aggregate4_name").trim().equals(""))?"Aggr4":request.getParameter("aggregate4_name");
					int aggregate4_value=(request.getParameter("aggregate4_value")==null || request.getParameter("aggregate4_value").trim().equals(""))?0:Integer.parseInt(request.getParameter("aggregate4_value"));
					String aggregate5_name=(request.getParameter("aggregate5_name")==null || request.getParameter("aggregate5_name").trim().equals(""))?"Cem1":request.getParameter("aggregate5_name");
					int aggregate5_value=(request.getParameter("aggregate5_value")==null || request.getParameter("aggregate5_value").trim().equals(""))?0:Integer.parseInt(request.getParameter("aggregate5_value"));
					String aggregate6_name=(request.getParameter("aggregate6_name")==null || request.getParameter("aggregate6_name").trim().equals(""))?"Cem2":request.getParameter("aggregate6_name");
					int aggregate6_value=(request.getParameter("aggregate6_value")==null || request.getParameter("aggregate6_value").trim().equals(""))?0:Integer.parseInt(request.getParameter("aggregate6_value"));
					String aggregate7_name=(request.getParameter("aggregate7_name")==null || request.getParameter("aggregate7_name").trim().equals(""))?"Cem3":request.getParameter("aggregate7_name");
					int aggregate7_value=(request.getParameter("aggregate7_value")==null || request.getParameter("aggregate7_value").trim().equals(""))?0:Integer.parseInt(request.getParameter("aggregate7_value"));
					String aggregate8_name=(request.getParameter("aggregate8_name")==null || request.getParameter("aggregate8_name").trim().equals(""))?"Water":request.getParameter("aggregate8_name");
					int aggregate8_value=(request.getParameter("aggregate8_value")==null || request.getParameter("aggregate8_value").trim().equals(""))?0:Integer.parseInt(request.getParameter("aggregate8_value"));
					String aggregate9_name=(request.getParameter("aggregate9_name")==null || request.getParameter("aggregate9_name").trim().equals(""))?"Admix1":request.getParameter("aggregate9_name");
					double aggregate9_value=(request.getParameter("aggregate9_value")==null || request.getParameter("aggregate9_value").trim().equals(""))?0:Double.parseDouble(request.getParameter("aggregate9_value"));
					String aggregate10_name=(request.getParameter("aggregate10_name")==null || request.getParameter("aggregate10_name").trim().equals(""))?"Admix2":request.getParameter("aggregate10_name");
					double aggregate10_value=(request.getParameter("aggregate10_value")==null || request.getParameter("aggregate10_value").trim().equals(""))?0:Double.parseDouble(request.getParameter("aggregate10_value"));
					String aggregate11_name=(request.getParameter("aggregate11_name")==null || request.getParameter("aggregate11_name").trim().equals(""))?"Aggr5":request.getParameter("aggregate11_name");
					int aggregate11_value=(request.getParameter("aggregate11_value")==null || request.getParameter("aggregate11_value").trim().equals(""))?0:Integer.parseInt(request.getParameter("aggregate11_value"));
					String cement_name=request.getParameter("cement_name");
					
					//create bean object
					MixDesignBean bean=new MixDesignBean();
					bean.setReceipe_id(receipe_id);
					bean.setReceipe_code(receipe_code);
					bean.setAggregate1_name(aggregate1_name);
					bean.setAggregate1_value(aggregate1_value);
					bean.setAggregate2_name(aggregate2_name);
					bean.setAggregate2_value(aggregate2_value);
					bean.setAggregate3_name(aggregate3_name);
					bean.setAggregate3_value(aggregate3_value);
					bean.setAggregate4_name(aggregate4_name);
					bean.setAggregate4_value(aggregate4_value);
					bean.setAggregate5_name(aggregate5_name);
					bean.setAggregate5_value(aggregate5_value);
					bean.setAggregate6_name(aggregate6_name);
					bean.setAggregate6_value(aggregate6_value);
					bean.setAggregate7_name(aggregate7_name);
					bean.setAggregate7_value(aggregate7_value);
					bean.setAggregate8_name(aggregate8_name);
					bean.setAggregate8_value(aggregate8_value);
					bean.setAggregate9_name(aggregate9_name);
					bean.setAggregate9_value(aggregate9_value);
					bean.setAggregate10_name(aggregate10_name);
					bean.setAggregate10_value(aggregate10_value);
					bean.setAggregate11_name(aggregate11_name);
					bean.setAggregate11_value(aggregate11_value);
					bean.setPlant_id(plant_id);
					bean.setProduct_id(product_id);
					bean.setSite_id(site_id);
					bean.setCustomer_id(customer_id);
					bean.setReceipe_id(receipe_id);
					bean.setCement_name(cement_name);
					
					int  count=dao.updateReceipe(bean);
					
					if(count>0) {
						session.setAttribute("res", "Updated Successfully");
						response.sendRedirect("gst/ReceipeList.jsp");
					}else {
						session.setAttribute("res", "<span class='text-danger'>Failed!!</span>");
						response.sendRedirect("gst/ReceipeList.jsp");
					}
				}
				
				else if(action.equals("DeleteReceipe")) {
					int receipe_id=Integer.parseInt(request.getParameter("receipe_id"));
					int count=dao.deleteReceipe(receipe_id);
					if(count>0) {
						session.setAttribute("res", "Receipe Deleted Successfully");
						response.sendRedirect("gst/ReceipeList.jsp");
					}else {
						session.setAttribute("res", "<span class='text-danger'>Failed!!</span>");
						response.sendRedirect("gst/ReceipeList.jsp");
					}
				}
				
				else if(action.equals("GetSingleMixDesign")) {
					response.setContentType("application/json");
					response.setCharacterEncoding("UTF-8");
					Gson gson=new Gson();
					String receipe_code=request.getParameter("receipe_code");
					MixDesignBean bean=dao.getSingleMixDesignDetails(receipe_code);
					writer.println(gson.toJson(bean));
				}
				
				else if(action.equals("deleteMixDesign")) {
					int design_id=Integer.parseInt(request.getParameter("design_id"));
					int count=dao.deleteMixDesign(design_id);
					
					if(count>0) {
						session.setAttribute("res", "Mix Design Deleted");
						response.sendRedirect("MixDesignList.jsp");
					}else {
						session.setAttribute("resq", "<span class='text-danger'>Failed!!</span>");
						response.sendRedirect("MixDesignList.jsp");
					}
				}
				
				else if(action.equals("GetSingleReceipe")) {
					response.setContentType("application/json");
					response.setCharacterEncoding("UTF-8");
					Gson gson=new Gson();
					int receipe_id=Integer.parseInt(request.getParameter("receipe_id"));
					MixDesignBean bean=dao.getSingleReceipeDetails(receipe_id);
					writer.println(gson.toJson(bean));
				}
				
				else if(action.equals("DeleteReceipe")) {
					int receipe_id=Integer.parseInt(request.getParameter("receipe_id"));
					int count=dao.deleteReceipe(receipe_id);
					if(count>0) {
						session.setAttribute("res", "Deleted Successfully");
						response.sendRedirect("ReceipeList.jsp");
					}else {
						session.setAttribute("res", "<span class='text-danger'>Failed!!</span>");
						response.sendRedirect("ReceipeList.jsp");
					}
				}
		}catch(Exception e) {
			e.printStackTrace();
		}
	}

}
