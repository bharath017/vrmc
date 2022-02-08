package com.willka.soft.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.willka.soft.bean.EmployeeAttendanceBean;
import com.willka.soft.dao.EmployeeAttendanceDAO;
import com.willka.soft.dao.EmployeeAttendanceDAOImpl;
import com.willka.soft.util.IndianDateFormater;


@WebServlet("/AttendanceController")
public class AttendanceController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter writer=response.getWriter();
		HttpSession session=request.getSession();
		EmployeeAttendanceDAO dao=new EmployeeAttendanceDAOImpl();
		try {
			String action=request.getParameter("action");
			if(action.equals("getEmployeeForAttendance")) {
				response.setContentType("application/json");
				response.setCharacterEncoding("utf-8");
				Gson gson=new Gson();
				String attendance_date=IndianDateFormater
						.converToIndianFormat(request.getParameter("attendance_date"));
				int business_id=Integer.parseInt(request.getParameter("business_id"));
				List<Map<String,Object>> data=dao.getEmployeeForAttendance(business_id, attendance_date);
				writer.println(gson.toJson(data));
			}
			
			else if(action.equals("updateEmployeeAttendance")) {
				String attendance_date=IndianDateFormater
						.converToIndianFormat(request.getParameter("attendance_date"));
				int count=Integer.parseInt(request.getParameter("count"));
				int user_id=Integer
						.parseInt(request.getParameter("user_id"));
				int resultCount=0;
				List<EmployeeAttendanceBean> insertList=new ArrayList<EmployeeAttendanceBean>();
				List<EmployeeAttendanceBean> updateList=new ArrayList<>();
				for(int i=0;i<count;i++) {
					EmployeeAttendanceBean bean=new EmployeeAttendanceBean();
					bean.setE_id(Integer.parseInt(request.getParameter("e_id["+i+"]")));
					bean.setStatus(request.getParameter("status["+i+"]"));
					bean.setAttendance_date(attendance_date);
					bean.setStart_time(request.getParameter("start_time["+i+"]"));
					bean.setEnd_time(request.getParameter("end_time["+i+"]"));
					bean.setDescription(request.getParameter("description["+i+"]"));
					if(Boolean.parseBoolean(request.getParameter("isAvailable["+i+"]"))) 
							updateList.add(bean);
					else
						 	insertList.add(bean);
				}
				resultCount+=dao.insertAttendance(insertList);
				resultCount+=dao.updateAttendance(updateList);
				writer.println(resultCount);
			}
			
			else if(action.equals("getEmployeeAttendance")) {
				String from_date=IndianDateFormater
						.converToIndianFormat(request.getParameter("from_date"));
				String to_date=IndianDateFormater
						.converToIndianFormat(request.getParameter("to_date"));
				int e_id=Integer
						.parseInt(request.getParameter("e_id"));
				
				
				
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
	}

}
