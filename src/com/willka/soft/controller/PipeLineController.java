 package com.willka.soft.controller;

import java.io.IOException;
import java.io.PrintWriter;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


import com.willka.soft.bean.PipelineBean;
import com.willka.soft.dao.PipeLineDAO;
import com.willka.soft.dao.PipeLineDAOImpl;

/**
 * Servlet implementation class CustomerController
 */
@WebServlet("/PipeLineController")
public class PipeLineController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.setContentType("text/html");
	  /*  PrintWriter writer = response.getWriter();	*/
		//create HttpSession object
	    HttpSession ses=request.getSession();	
		PipeLineDAO dao=new PipeLineDAOImpl();
		try	
		{
			String action=request.getParameter("action");
			
						if (action.equals("insert")) {				
							String unit=request.getParameter("unit");
							String bdm=request.getParameter("bdm");							
							String customer_id=request.getParameter("customer_id");							
							int total_volume=Integer.parseInt(request.getParameter("total_volume"));
							int period_month=Integer.parseInt(request.getParameter("period_month"));
							System.out.println(period_month);
							int vol_month=Integer.parseInt(request.getParameter("vol_month"));
							String target_date=request.getParameter("target_date");
							String remark_as=request.getParameter("remark_as");
							String status=request.getParameter("status");
							System.out.println(unit);
							
							PipelineBean bean=new PipelineBean();
							bean.setUnit(unit);
							bean.setBdm(bdm);
							bean.setCustomer_id(customer_id);
							bean.setTotal_volume(total_volume);
							bean.setPeriod_month(period_month);
							bean.setVol_month(vol_month);
							bean.setTarget_date(target_date);
							bean.setRemark_as(remark_as);
							bean.setStatus(status);
							
							int count=dao.insertPipeLine(bean);
							if (count>0) {
								ses.setAttribute("result", "PipeLine Inserted Successfully");
								response.sendRedirect("PipeLineList.jsp");
								
							}
					}else if (action.equals("update")) {
						int pipe_id=Integer.parseInt(request.getParameter("pipe_id"));
						String unit=request.getParameter("unit");
						String bdm=request.getParameter("bdm");							
						String customer_id=request.getParameter("customer_id");							
						int total_volume=Integer.parseInt(request.getParameter("total_volume"));
						int period_month=Integer.parseInt(request.getParameter("period_month"));						
						int vol_month=Integer.parseInt(request.getParameter("vol_month"));
						String target_date=request.getParameter("target_date");
						String remark_as=request.getParameter("remark_as");
						String status=request.getParameter("status");
						
						PipelineBean bean=new PipelineBean();
						bean.setPipe_id(pipe_id);
						bean.setUnit(unit);
						bean.setBdm(bdm);
						bean.setCustomer_id(customer_id);
						bean.setTotal_volume(total_volume);
						bean.setPeriod_month(period_month);
						bean.setVol_month(vol_month);
						bean.setTarget_date(target_date);
						bean.setRemark_as(remark_as);
						bean.setStatus(status);
						
						int count=dao.updatePipeline(bean);
						if (count>0) {
							ses.setAttribute("result", "PipeLine Inserted Successfully");
							response.sendRedirect("PipeLineList.jsp");
							
						}
						
					}
					
					
					
				
			
		}
			
		
		catch (Exception e) {
			
			e.printStackTrace();
		}
		
	
	}
	
}
