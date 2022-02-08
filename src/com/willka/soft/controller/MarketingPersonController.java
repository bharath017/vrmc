package com.willka.soft.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.willka.soft.bean.MarketingPersonBean;
import com.willka.soft.dao.MarketingPersonDAOImpl;

@WebServlet("/MarketingPersonController")
public class MarketingPersonController extends HttpServlet {
	
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 8797891L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession ses=request.getSession();
		MarketingPersonDAOImpl dao=new MarketingPersonDAOImpl();
		try{
			String action=request.getParameter("action");
			
			if(action.equals("InsertMarketingPerson")){
				String mp_name=request.getParameter("mp_name");
				String mp_address=request.getParameter("mp_address");
				String mp_phone=request.getParameter("mp_phone");
				String mp_email=request.getParameter("mp_email");
				String mp_type=request.getParameter("mp_type");
				int plant_id=Integer.parseInt(request.getParameter("plant_id"));
				int mp_head=(request.getParameter("mp_head")==null || request.getParameter("mp_head").trim().equals(""))?0:Integer.parseInt(request.getParameter("mp_head"));
				String mp_login_id=request.getParameter("mp_login_id");
				String mp_password=request.getParameter("mp_password");
				
				MarketingPersonBean bean=new MarketingPersonBean();
				bean.setMp_name(mp_name);
				bean.setMp_address(mp_address);
				bean.setMp_phone(mp_phone);
				bean.setMp_email(mp_email);
				bean.setMp_type(mp_type);
				bean.setPlant_id(plant_id);
				bean.setMp_head(mp_head);
				/*bean.setMp_acno(mp_acno);
				bean.setMp_ifsc(mp_ifsc);
				bean.setMp_accholder(mp_accholder);*/
				bean.setMp_login_id(mp_login_id);
				bean.setMp_password(mp_password);
				int count=dao.insertMarketingPerson(bean);
				if(count>0){
					ses.setAttribute("result", "Marketing person added successfully");
					response.sendRedirect("MarketingPersonList.jsp");
				}else{
					ses.setAttribute("result", "Insertion unsuccessful");
					response.sendRedirect("MarketingPersonList.jsp");
				}
			}
			
			else if(action.equals("UpdateMaketingPerson")) {
				int mp_id=Integer.parseInt(request.getParameter("mp_id"));
				String mp_name=request.getParameter("mp_name");
				String mp_address=request.getParameter("mp_address");
				String mp_phone=request.getParameter("mp_phone");
				String mp_email=request.getParameter("mp_email");
				String mp_type=request.getParameter("mp_type");
				int plant_id=Integer.parseInt(request.getParameter("plant_id"));
				int mp_head=(request.getParameter("mp_head")==null)?0:Integer.parseInt(request.getParameter("mp_head"));
				String mp_login_id=request.getParameter("mp_login_id");
				String mp_password=request.getParameter("mp_password");
				
				MarketingPersonBean bean=new MarketingPersonBean();
				bean.setMp_name(mp_name);
				bean.setMp_address(mp_address);
				bean.setMp_phone(mp_phone);
				bean.setMp_email(mp_email);
				bean.setMp_type(mp_type);
				bean.setPlant_id(plant_id);
				bean.setMp_head(mp_head);
				bean.setMp_login_id(mp_login_id);
				bean.setMp_password(mp_password);
				bean.setMp_id(mp_id);
				
				int count=dao.updateMarketingPerson(bean);
				if(count>0){
					ses.setAttribute("result", "Marketing Person Updated successfully");
					response.sendRedirect("MarketingPersonList.jsp");
				}else{
					ses.setAttribute("result", "<span class='text-danger'>Failed!!</span>");
					response.sendRedirect("MarketingPersonList.jsp");
				}
			}
			
			else if(action.equals("changeMarketingStatus")) {
				int mp_id=Integer.parseInt(request.getParameter("mp_id"));
				String mp_status=request.getParameter("mp_status");
				
				int count=dao.changeMarketingStatus(mp_id, mp_status);
				if(count>0) {
					ses.setAttribute("res", "Marketing Status Changed");
					response.sendRedirect("MarketingPersonList.jsp");
				}else {
					ses.setAttribute("res", "<span class='text-danger'>Failed!!</span>");
					response.sendRedirect("MarketingPersonList.jsp");
				}
			}
			
			
		}catch(Exception e){
			e.printStackTrace();
		}
	}

}
