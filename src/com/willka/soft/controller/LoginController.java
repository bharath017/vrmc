package com.willka.soft.controller;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.willka.soft.bean.UserDetailBean;
import com.willka.soft.service.LoginService;


/**
 * Servlet implementation class LoginController
 */
@WebServlet("/LoginController")
public class LoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			doPost(request,response);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter writer=response.getWriter();
		response.setContentType("text/html");
		HttpSession session=request.getSession();
		LoginService service=new LoginService();
		
		try {
			String action=request.getParameter("button");
			if(action.equals("login")) {
				int count=0;
				String username=request.getParameter("username");
				String password=request.getParameter("password");
				UserDetailBean bean=service.loginAsSuperAdmin(username, password);
				if(bean!=null) {
					count++;
					session.setAttribute("bean", bean);
					response.sendRedirect("dashboard.jsp");
				}
				//login as user
				if(count==0) {
					bean=service.loginAsUser(username, password);
					if(bean!=null && !(bean.getUsertype().equals("gst")) && 
								!(bean.getUsertype().equals("sgst")) && !(bean.getUsertype().equals("gstbilling"))
								&& !(bean.getUsertype().equals("gstqc")) && !(bean.getUsertype().equals("gstaccount"))
								&& !(bean.getUsertype().equals("gstmarketing")) && !(bean.getUsertype().equals("gstadmin"))
								&& !(bean.getUsertype().equals("gststore"))) {
						count++;
						session.setAttribute("bean", bean);
						response.sendRedirect("dashboard.jsp");
					}else {
						count++;
						session.setAttribute("bean", bean);
						response.sendRedirect("gst/dashboard.jsp");
					}
				}
				if(bean==null){
					session.setAttribute("error", "Invalid Credential");
					response.sendRedirect("login.jsp");
				}
			}
			
			else if(action.equals("logout")) {
				session.invalidate();
				System.gc();
				response.sendRedirect("login.jsp");
			}
			
			else if(action.equals("ChangePassword")) {
				UserDetailBean bean=(UserDetailBean) session.getAttribute("bean");
				String old_password=request.getParameter("old_password");
				String new_password=request.getParameter("new_password");
				if(bean.getUsertype().equals("sadmin")) {
					int count=service.changeSuperAdminPassword(old_password, new_password);
					session.setAttribute("result", count);
					response.sendRedirect("Security.jsp");
				}else {
					int count=service.changeUserPassword(old_password, new_password, bean.getUser_id());
					session.setAttribute("result", count);
					response.sendRedirect("Security.jsp");
				}
				
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}

}
