package com.willka.soft.controller;

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

import com.willka.soft.bean.ForecastBean;
import com.willka.soft.bean.ForecastItemBean;
import com.willka.soft.bean.SalesTargetBean;
import com.willka.soft.dao.ForecastDAOImpl;
import com.willka.soft.util.DBUtil;

/**
 * Servlet implementation class ForecastController
 */
@WebServlet("/ForecastController")
public class ForecastController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private Connection con=null;
	private PreparedStatement ps=null;
	private ResultSet rs=null;
  
   

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession sessoin=request.getSession();
		response.setContentType("text/html");
		ForecastDAOImpl dao=new ForecastDAOImpl();
		PrintWriter writer=response.getWriter();
		try {
			String action=request.getParameter("action");
			if(action.equals("InsertForecast")) {
				synchronized (request) {
						int customer_id=Integer.parseInt(request.getParameter("customer_id"));
						int site_id=Integer.parseInt(request.getParameter("site_id"));
						int plant_id=Integer.parseInt(request.getParameter("plant_id"));
						int mp_id=Integer.parseInt(request.getParameter("mp_id"));
						/*Double forecast_quantity=Double.parseDouble(request.getParameter("forecast_quantity"));*/
						Double project_quantity=Double.parseDouble(request.getParameter("project_quantity"));
		
						ForecastBean bean=new ForecastBean();
						bean.setCustomer_id(customer_id);
						bean.setSite_id(site_id);
						bean.setPlant_id(plant_id);
						bean.setMp_id(mp_id);
						bean.setProject_quantity(project_quantity);
					/*	bean.setForecast_quantity(forecast_quantity);*/
						int count=dao.insertForecast(bean);
						
						if(count>0) {
							sessoin.setAttribute("res", "Forecast Added Successfully");
							response.sendRedirect("ForecastList.jsp");
						}else {
							sessoin.setAttribute("res", "<span class='text-danger'>Failed!!</span>");
							response.sendRedirect("ForecastList.jsp");
						}
					}
				}else if(action.equals("updateForecast")) {
				synchronized (request) {
						int customer_id=Integer.parseInt(request.getParameter("customer_id"));
						int site_id=Integer.parseInt(request.getParameter("site_id"));
						int plant_id=Integer.parseInt(request.getParameter("plant_id"));
						int forecast_id=Integer.parseInt(request.getParameter("forecast_id"));
						int mp_id=Integer.parseInt(request.getParameter("mp_id"));
					/*	Double forecast_quantity=Double.parseDouble(request.getParameter("forecast_quantity"));*/
						Double project_quantity=Double.parseDouble(request.getParameter("project_quantity"));
		
						ForecastBean bean=new ForecastBean();
						bean.setCustomer_id(customer_id);
						bean.setSite_id(site_id);
						bean.setPlant_id(plant_id);
						bean.setMp_id(mp_id);
						bean.setForecast_id(forecast_id);
						bean.setProject_quantity(project_quantity);
						/*bean.setForecast_quantity(forecast_quantity);*/
						int count=dao.updateForecast(bean);
						
						if(count>0) {
							sessoin.setAttribute("res", "Forecast Added Successfully");
							response.sendRedirect("ForecastList.jsp");
						}else {
							sessoin.setAttribute("res", "<span class='text-danger'>Failed!!</span>");
							response.sendRedirect("ForecastList.jsp");
						}
					}
				}else if(action.equals("UpdateWeeklyForecast")) {
					synchronized (request) {
						String type=request.getParameter("forecast_type");
						Double forecast_quantity=Double.parseDouble(request.getParameter("forecast_quantity"));
						String forecast_date=request.getParameter("forecast_date");
						int forecast_id=Integer.parseInt(request.getParameter("forecast_id"));
						Double average_c1=(request.getParameter("average_c1")==null || request.getParameter("average_c1").trim().equals(""))?0.0: Double.parseDouble(request.getParameter("average_c1"));
						
						ForecastItemBean been=new ForecastItemBean();
						been.setForecast_date(forecast_date);
						been.setForecast_id(forecast_id);
						been.setForecast_quantity(forecast_quantity);
						been.setType(type);
						been.setAverage_c1(average_c1);
						int count=0;
						if (type.equals("monthly_forecast")) {
							count=dao.insertForecastItem(been);
						}else {
							count=dao.updateWeeklyForecast(been);
						}
						
					if(count>0) {
							sessoin.setAttribute("res", " Weekly Forecast Updated Successfully");
							response.sendRedirect("ForecastList.jsp");
						}else {
							sessoin.setAttribute("res", "<span class='text-danger'>Failed!!</span>");
							response.sendRedirect("ForecastList.jsp");
						}
					}
					}else if(action.equals("InsertSalesTarget")) {
						synchronized (request) {
							int mp_id=Integer.parseInt(request.getParameter("mp_id"));
							String date=request.getParameter("date");
							Double target_quantity=Double.parseDouble(request.getParameter("target_quantity"));
			
							SalesTargetBean bean=new SalesTargetBean();
							bean.setMp_id(mp_id);
							bean.setDate(date);
							bean.setQuantity(target_quantity);
							int count=dao.insertSalesTarget(bean);
							
							if(count>0) {
								sessoin.setAttribute("res", "Forecast Added Successfully");
								response.sendRedirect("ScoreCard.jsp");
							}else {
								sessoin.setAttribute("res", "<span class='text-danger'>Failed!!</span>");
								response.sendRedirect("ScoreCard.jsp");
							}
						}
					}else if (action.equals("deleteTarget")) {
						synchronized(request) {
							int target_id=Integer.parseInt(request.getParameter("target_id"));
							int count=dao.deleteTarget(target_id);
							if (count>0) {
								sessoin.setAttribute("res", "Target Deleted Successfully");
								response.sendRedirect("ScoreCard.jsp");
							}else {
								sessoin.setAttribute("res", "<span class='text-danger'>Failed!!</span>");
								response.sendRedirect("ScoreCard.jsp");
							}
						}
					}
					else if (action.equals("getProjectQuantity")) {
						synchronized(request) {
							response.setContentType("application/json");
							response.setCharacterEncoding("utf-8");
							int customer_id=Integer.parseInt(request.getParameter("customer_id"));
							int site_id=Integer.parseInt(request.getParameter("site_id"));
							con=DBUtil.getConnection();
							ps=con.prepareStatement("select project_quantity from forecast where forecast_id=(SELECT  max(forecast_id) FROM `forecast` WHERE customer_id=? and site_id=?)");
							ps.setInt(1, customer_id);
							ps.setInt(2, site_id);
							rs=ps.executeQuery();
							if(rs.next()) {
								writer.println(rs.getInt("project_quantity"));
							}else {
								writer.println(0);
							}
						}
					}else if (action.equals("deleteForecast")) {
						synchronized(request) {
							int forecast_id=Integer.parseInt(request.getParameter("forecast_id"));
							int count=dao.deleteForecast(forecast_id);
							if (count>0) {
								sessoin.setAttribute("res", "Forecast Deleted Successfully");
								response.sendRedirect("ForecastList.jsp");
							}else {
								sessoin.setAttribute("res", "<span class='text-danger'>Failed!!</span>");
								response.sendRedirect("ForecastList.jsp");
							}
						}
					}

}catch(Exception e) {
	e.printStackTrace();
}
	}
}
