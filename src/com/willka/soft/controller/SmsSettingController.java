package com.willka.soft.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.willka.soft.dao.SmsSenderDAOImpl;

/**
 * Servlet implementation class SmsSettingController
 */
@WebServlet("/SmsSettingController")
public class SmsSettingController extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session=request.getSession();
		PrintWriter writer=response.getWriter();
		SmsSenderDAOImpl dao=new SmsSenderDAOImpl();
		try {
			String action=request.getParameter("action");
			
			if(action.equals("SetSmsSetting")) {
				int checked=Integer.parseInt(request.getParameter("checked"));
				String sms_time=request.getParameter("sms_time");
				sms_time=(sms_time==null || sms_time.trim().equals(""))?"05:00":sms_time;
				int count=dao.changeSmsSetting(checked, sms_time);
				if(count>0) {
					writer.println("Setting changed Successfully");
				}else {
					writer.println("Setting Failed");
				}
			}
			
			else if(action.equals("InsertPhone")) {
				String phone=request.getParameter("phone");
				int count=dao.insertPhone(phone);
				if(count>0) {
					session.setAttribute("res", "Phone Inserted Successfully");
					response.sendRedirect("SmsSetting.jsp");
				}else {
					session.setAttribute("res", "Failed!!");
					response.sendRedirect("SmsSetting.jsp");
				}
			}
		}catch(Exception e) {
			
		}
		
	}

}
