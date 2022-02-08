package com.willka.soft.controller;


import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;




import com.willka.soft.bean.JobCardBean;
import com.willka.soft.dao.JobcardDAOImp;

/**
 * Servlet implementation class JobCardController
 */
@WebServlet("/JobCardController")
public class JobCardController extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html");
	    PrintWriter writer = response.getWriter();	
		//create HttpSession object
	    HttpSession session=request.getSession();
	    JobcardDAOImp dao=new JobcardDAOImp();
	    try {

			String action = request.getParameter("action");
			if (action.equals("InsertJobCard")) {
				String vehicle_details = request.getParameter("vehicle_details");
				String reg_no=request.getParameter("reg_no");
				int kilo_meters = Integer.parseInt(request.getParameter("kilo_meters"));
				String hours=request.getParameter("hours");
				String driver_name=request.getParameter("driver_name");
				String arrival_time=request.getParameter("arrival_time");
				String jobstarted_time=request.getParameter("jobstarted_time");
				String jobcompleted_time=request.getParameter("jobcompleted_time");
				String attended_by=request.getParameter("attended_by");
				String frontengine=request.getParameter("frontengine");
				String backengine=request.getParameter("backengine");
				String drumgearbox=request.getParameter("drumgearbox");
				String frontgear=request.getParameter("frontgear");
				String hydraulic=request.getParameter("hydraulic");
				String coollent=request.getParameter("coollent");
				String clutchoil=request.getParameter("clutchoil");
				String steering=request.getParameter("steering");
				String housing=request.getParameter("housing");
				String breakoil=request.getParameter("breakoil");
				
				
				JobCardBean bean = new JobCardBean();
				bean.setVehicle_details(vehicle_details);
				bean.setReg_no(reg_no);
				bean.setKilo_meters(kilo_meters);
				bean.setHours(hours);				
				bean.setDriver_name(driver_name);
				bean.setArrival_time(arrival_time);
				bean.setJobstarted_time(jobstarted_time);
				bean.setJobcompleted_time(jobcompleted_time);
				bean.setAttended_by(attended_by);
				bean.setFrontengine(frontengine);
				bean.setBackengine(backengine);
				bean.setDrumgearbox(drumgearbox);
				bean.setFrontgear(frontgear);
				bean.setHydraulic(hydraulic);
				bean.setCoollent(coollent);
				bean.setClutchoil(clutchoil);
				bean.setSteering(steering);
				bean.setHousing(housing);
				bean.setBreakoil(breakoil);
				
				int count = dao.insertJobCard(bean);
				
				if (count > 0) {
					session.setAttribute("res", "Job Card Inserted Successfully");
					response.sendRedirect("JobCardList.jsp"); 
				} else {
					session.setAttribute("res", "<span class='text-danger'>Failed!!</span>");
					response.sendRedirect("JobCardList.jsp");
				}
			}
	    
			else if(action.equals("UpdateJobCard"))
				
			{
				
				String vehicle_details = request.getParameter("vehicle_details");
				String reg_no=request.getParameter("reg_no");
				int kilo_meters = Integer.parseInt(request.getParameter("kilo_meters"));
				String hours=request.getParameter("hours");
				String driver_name=request.getParameter("driver_name");
				String arrival_time=request.getParameter("arrival_time");
				String jobstarted_time=request.getParameter("jobstarted_time");
				String jobcompleted_time=request.getParameter("jobcompleted_time");
				String attended_by=request.getParameter("attended_by");
				String frontengine=request.getParameter("frontengine");
				String backengine=request.getParameter("backengine");
				String drumgearbox=request.getParameter("drumgearbox");
				String frontgear=request.getParameter("frontgear");
				String hydraulic=request.getParameter("hydraulic");
				String coollent=request.getParameter("coollent");
				String clutchoil=request.getParameter("clutchoil");
				String steering=request.getParameter("steering");
				String housing=request.getParameter("housing");
				String breakoil=request.getParameter("breakoil");
				int id=Integer.parseInt(request.getParameter("id"));
				
				
				JobCardBean bean = new JobCardBean();
				
				bean.setVehicle_details(vehicle_details);
				bean.setReg_no(reg_no);
				bean.setKilo_meters(kilo_meters);
				bean.setHours(hours);				
				bean.setDriver_name(driver_name);
				bean.setArrival_time(arrival_time);
				bean.setJobstarted_time(jobstarted_time);
				bean.setJobcompleted_time(jobcompleted_time);
				bean.setAttended_by(attended_by);
				bean.setFrontengine(frontengine);
				bean.setHydraulic(hydraulic);
				bean.setBackengine(backengine);
				bean.setDrumgearbox(drumgearbox);
				bean.setFrontgear(frontgear);
				bean.setCoollent(coollent);
				bean.setClutchoil(clutchoil);
				bean.setSteering(steering);
				bean.setHousing(housing);
				bean.setBreakoil(breakoil);
				bean.setId(id);
				
				int count = dao.updateJobCard(bean);
				
				if (count > 0) {
					session.setAttribute("res", "Job Card Updated Successfully");
					response.sendRedirect("JobCardList.jsp"); 
				} else {
					session.setAttribute("res", "<span class='text-danger'>Failed!!</span>");
					response.sendRedirect("JobCardList.jsp");
				}
			}
			else if(action.equals("CancelJobCard")) {
				int id=Integer.parseInt(request.getParameter("id"));
				
				int count=dao.deletJobCard(id);
				System.out.println("Harsha");
				if (count > 0) {
					session.setAttribute("res", "Job Card Updated Successfully");
					response.sendRedirect("JobCardList.jsp"); 
				} else {
					session.setAttribute("res", "<span class='text-danger'>Failed!!</span>");
					response.sendRedirect("JobCardList.jsp");
				}
				
			}
	    }
			
	
	    catch (Exception ex) {
			System.out.println(ex.getMessage());
		}

	}
}
