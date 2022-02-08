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
import com.willka.soft.bean.UserBean;
import com.willka.soft.dao.UserDAO;
import com.willka.soft.dao.UserDAOImpl;

/**
 * Servlet implementation class UserController
 */
@WebServlet("/UserController")
public class UserController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		UserDAO dao=new UserDAOImpl();
		HttpSession session=request.getSession();
		PrintWriter writer=response.getWriter();
		
		try {
			String action=request.getParameter("action");
			
			if(action.equals("InsertUser")) {
				try {
					String user_name=request.getParameter("user_name");
					String user_phone=request.getParameter("user_phone");
					String user_address=request.getParameter("user_address");
					String user_email=request.getParameter("user_email");
					String user_login_id=request.getParameter("user_login_id");
					int plant_id=Integer.parseInt(request.getParameter("plant_id"));
					String user_type=request.getParameter("user_type");
					String user_password=request.getParameter("user_password");
					String user_photo=request.getParameter("user_photo");
					int business_id=Integer.parseInt(request.getParameter("business_id"));
					
					UserBean bean=new UserBean();
					bean.setUser_name(user_name);
					bean.setUser_phone(user_phone);
					bean.setUser_address(user_address);
					bean.setUser_email(user_email);
					bean.setUser_login_id(user_login_id);
					bean.setPlant_id(plant_id);
					bean.setUser_type(user_type);
					bean.setUser_password(user_password);
					bean.setUser_photo(user_photo);
					bean.setBusiness_id(business_id);
					int count=dao.insertUserDetails(bean);
					writer.println(count);
				}catch(Exception e) {
					e.printStackTrace();
					writer.println(-1);
				}
				
			}else if(action.equals("UpdateUser")) {
				try {
					String user_name=request.getParameter("user_name");
					String user_phone=request.getParameter("user_phone");
					String user_address=request.getParameter("user_address");
					String user_email=request.getParameter("user_email");
					String user_login_id=request.getParameter("user_login_id");
					int plant_id=Integer.parseInt(request.getParameter("plant_id"));
					String user_type=request.getParameter("user_type");
					String user_password=request.getParameter("user_password");
					String user_photo=request.getParameter("user_photo");
					int user_id=Integer.parseInt(request.getParameter("user_id"));
					int business_id=Integer.parseInt(request.getParameter("business_id"));
					
					UserBean bean=new UserBean();
					bean.setUser_name(user_name);
					bean.setUser_phone(user_phone);
					bean.setUser_address(user_address);
					bean.setUser_email(user_email);
					bean.setUser_login_id(user_login_id);
					bean.setPlant_id(plant_id);
					bean.setUser_type(user_type);
					bean.setUser_password(user_password);
					bean.setUser_photo(user_photo);
					bean.setUser_id(user_id);
					bean.setBusiness_id(business_id);
					
					int count=dao.updateUserDetails(bean);
					writer.println(count);
				}catch(Exception e) {
					e.printStackTrace();
					writer.println(-1);
				}
				
			}
			
			else if(action.equals("changeUserStatus")) {
				int user_id=Integer.parseInt(request.getParameter("user_id"));
				String user_status=request.getParameter("user_status");
				int count=dao.changeUserStatus(user_id, user_status);
				writer.println(count);
			}
			
			
			else if(action.equals("getSingleUserDetails")) {
				response.setCharacterEncoding("utf-8");
				response.setContentType("application/json");
				Gson gson=new Gson();
				int user_id=Integer.parseInt(request.getParameter("user_id"));
				UserBean bean=dao.getSingleUserByUserID(user_id);
				writer.println(gson.toJson(bean));
			}
			
			else if(action.equals("getSingleUserDetailsForUpdate")) {
				response.setCharacterEncoding("utf-8");
				response.setContentType("application/json");
				Gson gson=new Gson();
				int user_id=Integer.parseInt(request.getParameter("user_id"));
				UserBean bean=dao.getSingleUserDetails(user_id);
				writer.println(gson.toJson(bean));
			}
			
			
			else if(action.equals("getSingleRoles")) {
				response.setContentType("application/json");
				response.setCharacterEncoding("utf-8");
				Gson gson=new Gson();
				int user_id=Integer.parseInt(request.getParameter("user_id"));
				HashMap<String, Object> map=dao.getSingleUserRoles(user_id);
				writer.println(gson.toJson(map));
			}
			
			else if(action.equals("updateRole")) {
				int user_id=Integer.parseInt(request.getParameter("user_id"));
				String roles=request.getParameter("roles");
				int count=dao.updateRoleDetails(user_id, roles);
				writer.println(count);
			}
			
			
			else if(action.equals("getAllUserList")) {
				response.setContentType("application/json");
				response.setCharacterEncoding("utf-8");
				Gson gson=new Gson();
				int business_id=Integer.parseInt(request.getParameter("business_id"));
				int start=Integer.parseInt(request.getParameter("start"));
				int length=Integer.parseInt(request.getParameter("length"));
				Map<String,Object> data=new HashMap<>();
				String search=request.getParameter("search[value]");
				String type=request.getParameter("type");
				int draw=Integer.parseInt(request.getParameter("draw"));
				data.put("data", dao.getAllUserList(search, business_id, type, start, length));
				data.put("draw", draw);
				int recordCount=dao.countAllUserList(search, business_id, type);
				data.put("recordsTotal", recordCount);
				data.put("recordsFiltered", recordCount);
				writer.print(gson.toJson(data));
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
	}

}
