package com.willka.soft.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.willka.soft.bean.CubeTestBean;
import com.willka.soft.bean.CubeTestItemBean;
import com.willka.soft.dao.CubeTestDAO;
import com.willka.soft.dao.CubeTestDAOImpl;

/**
 * Servlet implementation class CubeTestController
 */
@WebServlet("/CubeTestController")
public class CubeTestController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session=request.getSession();
		CubeTestDAO dao=new CubeTestDAOImpl();
		PrintWriter writer=response.getWriter();
		try {
			String action=request.getParameter("action");
			
			if(action.equals("InsertCubeTest")) {
				int customer_id=Integer.parseInt(request.getParameter("customer_id"));
				int site_id=Integer.parseInt(request.getParameter("site_id"));
				String product_name=request.getParameter("product_name");
				String supply_date=request.getParameter("supply_date");
				int testing_days=Integer.parseInt(request.getParameter("testing_days"));
				int dimension=Integer.parseInt(request.getParameter("dimension"));
				int plant_id=Integer.parseInt(request.getParameter("plant_id"));
				
				String mass1[]=request.getParameterValues("mass1");
				String mass2[]=request.getParameterValues("mass2");
				String mass3[]=request.getParameterValues("mass3");
				String maxld1[]=request.getParameterValues("maxld1");
				String maxld2[]=request.getParameterValues("maxld2");
				String maxld3[]=request.getParameterValues("maxld3");
				String cube_id[]=request.getParameterValues("cube_id");
				
				
				//create cubetest bean object
				CubeTestBean bean=new CubeTestBean();
				bean.setCustomer_id(customer_id);
				bean.setSite_id(site_id);
				bean.setProduct_name(product_name);
				bean.setSupply_date(supply_date);
				bean.setTesting_days(testing_days);
				bean.setDimension(dimension);
				bean.setPlant_id(plant_id);
				int count=dao.insertCubeTest(bean);
				if(count>0) {
					int maxTstId=dao.getLatestCubeTest();
					for(int i=0;i<mass1.length;i++) {
						CubeTestItemBean been=new CubeTestItemBean();
						been.setTst_id(maxTstId);
						been.setMass1(Double.parseDouble(mass1[i]));
						been.setMass2(Double.parseDouble(mass2[i]));
						been.setMass3(Double.parseDouble(mass3[i]));
						been.setMaxld1(Double.parseDouble(maxld1[i]));
						been.setMaxld2(Double.parseDouble(maxld2[i]));
						been.setMaxld3(Double.parseDouble(maxld3[i]));
						been.setCube_id(cube_id[i]);
						dao.insertCubeTestItem(been);
					}
					session.setAttribute("res", "Cube Test Inserted");
					response.sendRedirect("CubeTestList.jsp");
				}else {
					session.setAttribute("res", "<span class='text-danger'>Failed!!</span>");
					response.sendRedirect("CubeTestList.jsp");
				}
			}
			
			else if(action.equals("UpdateCubeTest")) {
				int customer_id=Integer.parseInt(request.getParameter("customer_id"));
				int site_id=Integer.parseInt(request.getParameter("site_id"));
				String product_name=request.getParameter("product_name");
				String supply_date=request.getParameter("supply_date");
				int testing_days=Integer.parseInt(request.getParameter("testing_days"));
				int dimension=Integer.parseInt(request.getParameter("dimension"));
				int tst_id=Integer.parseInt(request.getParameter("tst_id"));
				int plant_id=Integer.parseInt(request.getParameter("plant_id"));
				
				
				String mass1[]=request.getParameterValues("mass1");
				String mass2[]=request.getParameterValues("mass2");
				String mass3[]=request.getParameterValues("mass3");
				String maxld1[]=request.getParameterValues("maxld1");
				String maxld2[]=request.getParameterValues("maxld2");
				String maxld3[]=request.getParameterValues("maxld3");
				String tst_item_id[]=request.getParameterValues("tst_item_id");
				String cube_id[]=request.getParameterValues("cube_id");
				
				//create cubetest bean object
				CubeTestBean bean=new CubeTestBean();
				bean.setCustomer_id(customer_id);
				bean.setSite_id(site_id);
				bean.setProduct_name(product_name);
				bean.setSupply_date(supply_date);
				bean.setTesting_days(testing_days);
				bean.setDimension(dimension);
				bean.setTst_id(tst_id);
				bean.setPlant_id(plant_id);
				
				int count=dao.updateCubeTest(bean);
				if(count>0) {
					for(int i=0;i<mass1.length;i++) {
						try {
							CubeTestItemBean been=new CubeTestItemBean();
							been.setMass1(Double.parseDouble(mass1[i]));
							been.setMass2(Double.parseDouble(mass2[i]));
							been.setMass3(Double.parseDouble(mass3[i]));
							been.setMaxld1(Double.parseDouble(maxld1[i]));
							been.setMaxld2(Double.parseDouble(maxld2[i]));
							been.setMaxld3(Double.parseDouble(maxld3[i]));
							been.setTst_item_id(Integer.parseInt(tst_item_id[i]));
							been.setCube_id(cube_id[i]);
							dao.updateCubeTestItem(been);
						}catch(Exception e) {
							CubeTestItemBean been=new CubeTestItemBean();
							been.setMass1(Double.parseDouble(mass1[i]));
							been.setMass2(Double.parseDouble(mass2[i]));
							been.setMass3(Double.parseDouble(mass3[i]));
							been.setMaxld1(Double.parseDouble(maxld1[i]));
							been.setMaxld2(Double.parseDouble(maxld2[i]));
							been.setMaxld3(Double.parseDouble(maxld3[i]));
							been.setCube_id(cube_id[i]);
							dao.insertCubeTestItem(been);
						}
					}
					session.setAttribute("res", "Cube Test Updated");
					response.sendRedirect("CubeTestList.jsp");
				}else {
					session.setAttribute("res", "<span class='text-danger'>Failed!!</span>");
					response.sendRedirect("CubeTestList.jsp");
				}
			}
			
			else if(action.equals("CancelTest")) {
				int tst_id=Integer.parseInt(request.getParameter("tst_id"));
				
				int count=dao.cancelReport(tst_id);
				
				if(count>0) {
					session.setAttribute("res", "Cube Test Cancelled");
					response.sendRedirect("CubeTestList.jsp");
				}else {
					session.setAttribute("res", "<span class='text-danger'>Failed!!</span>");
					response.sendRedirect("CubeTestList.jsp");
				}
				
			}
			
			else if(action.equals("GetSupplyDetails")) {
				String product_name=request.getParameter("product_name");
				int customer_id=(request.getParameter("customer_id")==null || request.getParameter("customer_id").trim().equals(""))?0:Integer.parseInt(request.getParameter("customer_id"));
				int site_id=(request.getParameter("site_id")==null || request.getParameter("site_id").trim().equals(""))?0:Integer.parseInt(request.getParameter("site_id"));
				List<String> supply_dates=dao.getSupplyList(customer_id, site_id, product_name);
				Gson gson=new Gson();
				writer.print(gson.toJson(supply_dates));
			}
			
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}

}
