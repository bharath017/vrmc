package com.willka.soft.test.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.willka.soft.bean.UserDetailBean;
import com.willka.soft.dao.CompanyDAO;
import com.willka.soft.dao.CompanyDAOImpl;
import com.willka.soft.dao.UserDAO;
import com.willka.soft.dao.UserDAOImpl;

/**
 * Servlet implementation class LoginController
 */
@WebServlet("/LoginControllerTest")
public class LoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			doPost(request,response);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//general setting
		PrintWriter writer=response.getWriter();
		response.setContentType("text/html");
		//create dao objec there
		CompanyDAO dao=new CompanyDAOImpl();
		UserDAO udao=new UserDAOImpl();
		try {
			String action=request.getParameter("button");
			if(action.equals("login")) {
				String username=request.getParameter("username");
				String password=request.getParameter("password");
				
				int count=0;
				UserDetailBean bean=dao.loginAsUser(username, password);
				//create session object here
				HttpSession session=request.getSession();
				if(bean!=null){
					count++;
					session.setAttribute("bean", bean);
					session.setAttribute("usertype", "superadmin");
					response.sendRedirect("dashboard.jsp");
				}
				
				//if not search in user table
				if(count==0) {
					bean=udao.loginAsUser(username, password);
					if(bean!=null && bean.getUsertype().equals("gst")){
						session.setAttribute("bean", bean);
						session.setAttribute("usertype", "gst");
						response.sendRedirect("gst/dashboard.jsp");
					}else if(bean!=null && bean.getUsertype().equals("gstbilling")){
						session.setAttribute("bean", bean);
						session.setAttribute("usertype", "gstbilling");
						response.sendRedirect("gst/dashboard.jsp");
					}else if(bean!=null && bean.getUsertype().equals("gstqc")){
						session.setAttribute("bean", bean);
						session.setAttribute("usertype", "gstqc");
						response.sendRedirect("gst/dashboard.jsp");
					}else if(bean!=null && bean.getUsertype().equals("billing")) {
						session.setAttribute("bean", bean);
						session.setAttribute("usertype", "billing");
						response.sendRedirect("DashboardBilling.jsp");
					}else if(bean!=null && bean.getUsertype().equals("admin")) {
						session.setAttribute("bean", bean);
						session.setAttribute("usertype", "admin");
						response.sendRedirect("dashboard.jsp");
					}else if(bean!=null && bean.getUsertype().equals("qc")) {
						session.setAttribute("bean", bean);
						session.setAttribute("usertype", "qc");
						response.sendRedirect("DashboardQc.jsp");
					}else if(bean!=null && bean.getUsertype().equals("store")) {
						session.setAttribute("bean", bean);
						session.setAttribute("usertype", "store");
						response.sendRedirect("DashboardStore.jsp");
					}else if(bean!=null && bean.getUsertype().equals("account")) {
						session.setAttribute("bean", bean);
						session.setAttribute("usertype", "account");
						response.sendRedirect("DashboardAccount.jsp");
					}else if(bean!=null && bean.getUsertype().equals("scheduling")) {
						session.setAttribute("bean", bean);
						session.setAttribute("usertype", "scheduling");
						response.sendRedirect("DashboardScheduling.jsp");
					}
					
					
					if(bean==null){
						session.setAttribute("error", "Invalid Credential");
						response.sendRedirect("login.jsp");
					}
				}
			}
			
			else if(action.equals("logout")) {
				HttpSession session=request.getSession();
				session.invalidate();
				System.gc();
				response.sendRedirect("login.jsp");
			}
			
			
			else if(action.equals("ChangePassword")) {
				HttpSession session=request.getSession();
				UserDetailBean bean=(UserDetailBean)session.getAttribute("bean");
				String usertype=(String)session.getAttribute("usertype");
				String old_password=request.getParameter("old_password");
				String new_password=request.getParameter("new_password");
				String new_password2=request.getParameter("new_password2");
				//check old password and new password 
				
				if(new_password.equals(new_password2)) {
					//proceed
					int val=0;
					if(usertype.equals("superadmin")) {
						int count=dao.changePassword(bean.getUsername(), old_password, new_password);
						val=count;
					}
					if(val==0) {
						int count=udao.changePasword(bean.getUser_id(), old_password, new_password);
						if(count>0) {
							session.setAttribute("res", "Password changed successfully");
							response.sendRedirect("gst/Security.jsp");
						}else {
							session.setAttribute("res", "<span class='text-danger'>Old password doesn't match</span>");
							response.sendRedirect("gst/Security.jsp");
						}
					}else {
						session.setAttribute("res", "Password Changed Successfully");
						response.sendRedirect("gst/Security.jsp");
					}
				}else {
					session.setAttribute("res", "<span class='text-danger'>Password doesn't match</span>");
					response.sendRedirect("Security.jsp");
				}
			}
			
			else if(action.equals("ChangePasswordWGST")) {
				HttpSession session=request.getSession();
				UserDetailBean bean=(UserDetailBean)session.getAttribute("bean");
				String usertype=(String)session.getAttribute("usertype");
				String old_password=request.getParameter("old_password");
				String new_password=request.getParameter("new_password");
				UserDetailBean been=udao.loginAsUser(bean.getUser_email(), old_password);
				if(been==null) {
					session.setAttribute("res", "<span class='text-danger'>Incorrect Old Password</span>");
					response.sendRedirect("gst/ChangePassword.jsp");
				}else {
					//now change here the password
					udao.changePasword(bean.getUser_id(), old_password, new_password);
					session.setAttribute("res", "Password Changed Successfully");
					response.sendRedirect("gst/ChangePassword.jsp");
				}
				
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}

}
