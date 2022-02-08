package com.willka.soft.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.willka.soft.dao.HRMSettingDAOImpl;

@WebServlet("/HRMSettingController")
public class HRMSettingController extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 8734931L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html");
		PrintWriter writer=response.getWriter();
		HRMSettingDAOImpl dao=new HRMSettingDAOImpl();
		try {
			String action=request.getParameter("action");
			
			if(action.equals("InsertDesignation")) {
				try {
					String designation_name=request.getParameter("designation_name");
					int count=dao.insertDesignation(designation_name);
					writer.print(count);
				}catch(Exception e) {
					writer.println(0);
				}
			}
			
			else if(action.equals("UpdateDesignation")) {
				try {
					int designation_id=Integer.parseInt(request.getParameter("designation_id"));
					String designation_name=request.getParameter("designation_name");
					int count=dao.updateDesignation(designation_id, designation_name);
					writer.println(count);
				}catch(Exception e) {
					e.printStackTrace();
				}
			}
			
			else if(action.equals("DeleteDesignation")) {
				try {
					int designation_id=Integer.parseInt(request.getParameter("designation_id"));
					int count=dao.deleteDesignation(designation_id);
					writer.print(count);
				}catch(Exception e) {
					//e.printStackTrace();
					writer.println(0);
				}
			}
			
			else if(action.equals("GetDesignationList")) {
				response.setContentType("application/json");
				response.setCharacterEncoding("utf-8");
				Gson gson=new Gson();
				String search=request.getParameter("search[value]");
				int start=Integer.parseInt(request.getParameter("start"));
				int length=Integer.parseInt(request.getParameter("length"));
				Map<String,Object> data=new HashMap<>();
				int draw=Integer.parseInt(request.getParameter("draw"));
				data.put("data", dao.getDesignationList(start, length, search));
				data.put("draw", draw);
				int recordCount=dao.countDesignationList(search);
				data.put("recordsTotal", recordCount);
				data.put("recordsFiltered", recordCount);
				writer.print(gson.toJson(data));
			}
			
			else if(action.equals("InsertDepartment")) {
				String department_name=request.getParameter("department_name");
				int count=dao.insertDepartment(department_name);
				writer.print(count);
			}
			
			else if(action.equals("UpdateDepartment")) {
				String department_name=request.getParameter("department_name");
				int department_id=Integer.parseInt(request.getParameter("department_id"));
				int count=dao.updateDepartment(department_name, department_id);
				writer.println(count);
			}
			
			else if(action.equals("DeleteDepartment")) {
				try {
					int department_id=Integer.parseInt(request.getParameter("department_id"));
					int count=dao.deleteDepartment(department_id);
					writer.println(count);
				}catch(Exception e) {
					writer.println(0);
				}
			}
			
			else if(action.equals("GetAllDepartmentList")) {
				response.setContentType("application/json");
				response.setCharacterEncoding("utf-8");
				Gson gson=new Gson();
				String search=request.getParameter("search[value]");
				int start=Integer.parseInt(request.getParameter("start"));
				int length=Integer.parseInt(request.getParameter("length"));
				Map<String,Object> data=new HashMap<>();
				int draw=Integer.parseInt(request.getParameter("draw"));
				data.put("data", dao.getAllDepartmentList(search, start, length));
				data.put("draw", draw);
				int recordCount=dao.countAllDepartmentList(search);
				data.put("recordsTotal", recordCount);
				data.put("recordsFiltered", recordCount);
				writer.print(gson.toJson(data));
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
	}

}
