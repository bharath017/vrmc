package com.willka.soft.test.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.willka.soft.test.bean.CubeTestBean;
import com.willka.soft.test.dao.CubeTestDAO;
import com.willka.soft.test.dao.CubeTestDAOImpl;

/**
 * Servlet implementation class CubeTestController
 */
@WebServlet("/CubeTestControllerTest")
public class CubeTestController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session=request.getSession();
		CubeTestDAO dao=new CubeTestDAOImpl();
		try {
			String action=request.getParameter("action");
			
			if(action.equals("InsertCubeTest")) {
				int customer_id=Integer.parseInt(request.getParameter("customer_id"));
				int site_id=Integer.parseInt(request.getParameter("site_id"));
				String product_name=request.getParameter("product_name");
				String supply_date=request.getParameter("supply_date");
				int testing_days=Integer.parseInt(request.getParameter("testing_days"));
				double mass1=Double.parseDouble(request.getParameter("mass1"));
				double mass2=Double.parseDouble(request.getParameter("mass2"));
				double mass3=Double.parseDouble(request.getParameter("mass3"));
				double maxld1=Double.parseDouble(request.getParameter("maxld1"));
				double maxld2=Double.parseDouble(request.getParameter("maxld2"));
				double maxld3=Double.parseDouble(request.getParameter("maxld3"));
				int dimension=Integer.parseInt(request.getParameter("dimension"));
				int plant_id=Integer.parseInt(request.getParameter("plant_id"));
				
				
				//get max of test id for cubetest id
				
				int test_id=dao.getMaxCubeTestId(plant_id);
				//create cubetest bean object
				CubeTestBean bean=new CubeTestBean();
				bean.setCustomer_id(customer_id);
				bean.setSite_id(site_id);
				bean.setProduct_name(product_name);
				bean.setSupply_date(supply_date);
				bean.setTesting_days(testing_days);
				bean.setMass1(mass1);
				bean.setMass2(mass2);
				bean.setMass3(mass3);
				bean.setMaxld1(maxld1);
				bean.setMaxld2(maxld2);
				bean.setMaxld3(maxld3);
				bean.setDimension(dimension);
				bean.setPlant_id(plant_id);
				bean.setTest_id(test_id);
				int count=dao.insertCubeTest(bean);
				if(count>0) {
					session.setAttribute("res", "Cube Test Inserted");
					response.sendRedirect("gst/CubeTestList.jsp");
				}else {
					session.setAttribute("res", "<span class='text-danger'>Failed!!</span>");
					response.sendRedirect("gst/CubeTestList.jsp");
				}
			}
			
			else if(action.equals("UpdateCubeTest")) {
				int customer_id=Integer.parseInt(request.getParameter("customer_id"));
				int site_id=Integer.parseInt(request.getParameter("site_id"));
				String product_name=request.getParameter("product_name");
				String supply_date=request.getParameter("supply_date");
				int testing_days=Integer.parseInt(request.getParameter("testing_days"));
				double mass1=Double.parseDouble(request.getParameter("mass1"));
				double mass2=Double.parseDouble(request.getParameter("mass2"));
				double mass3=Double.parseDouble(request.getParameter("mass3"));
				double maxld1=Double.parseDouble(request.getParameter("maxld1"));
				double maxld2=Double.parseDouble(request.getParameter("maxld2"));
				double maxld3=Double.parseDouble(request.getParameter("maxld3"));
				int dimension=Integer.parseInt(request.getParameter("dimension"));
				int plant_id=Integer.parseInt(request.getParameter("plant_id"));
				int tst_id=Integer.parseInt(request.getParameter("tst_id"));
				//create cubetest bean object
				CubeTestBean bean=new CubeTestBean();
				bean.setCustomer_id(customer_id);
				bean.setSite_id(site_id);
				bean.setProduct_name(product_name);
				bean.setSupply_date(supply_date);
				bean.setTesting_days(testing_days);
				bean.setMass1(mass1);
				bean.setMass2(mass2);
				bean.setMass3(mass3);
				bean.setMaxld1(maxld1);
				bean.setMaxld2(maxld2);
				bean.setMaxld3(maxld3);
				bean.setDimension(dimension);
				bean.setTst_id(tst_id);
				bean.setPlant_id(plant_id);
				
				int count=dao.updateCubeTest(bean);
				if(count>0) {
					session.setAttribute("res", "Cube Test Updated");
					response.sendRedirect("gst/CubeTestList.jsp");
				}else {
					session.setAttribute("res", "<span class='text-danger'>Failed!!</span>");
					response.sendRedirect("gst/CubeTestList.jsp");
				}
			}
			
			else if(action.equals("CancelTest")) {
				int tst_id=Integer.parseInt(request.getParameter("tst_id"));
				
				int count=dao.cancelReport(tst_id);
				
				if(count>0) {
					session.setAttribute("res", "Cube Test Cancelled");
					response.sendRedirect("gst/CubeTestList.jsp");
				}else {
					session.setAttribute("res", "<span class='text-danger'>Failed!!</span>");
					response.sendRedirect("gst/CubeTestList.jsp");
				}
				
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
	}

}
