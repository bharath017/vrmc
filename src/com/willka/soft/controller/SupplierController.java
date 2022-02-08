package com.willka.soft.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.willka.soft.bean.SupplierBean;
import com.willka.soft.dao.SupplierDAO;
import com.willka.soft.dao.SupplierDAOImpl;

/**
 * Servlet implementation class SupplierController
 */
@WebServlet("/SupplierController")
public class SupplierController extends HttpServlet {
	
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session=request.getSession();
		SupplierDAO dao=new SupplierDAOImpl();
		PrintWriter writer=response.getWriter();
		
		try {
			String action=request.getParameter("action");
			
			if(action.equals("InsertSupplier")) {
				String supplier_name=request.getParameter("supplier_name");
				String supplier_phone=request.getParameter("supplier_phone");
				String supplier_address=request.getParameter("supplier_address");
				String supplier_gstin=request.getParameter("supplier_gstin");
				String supplier_panno=request.getParameter("supplier_panno");
				int business_id=Integer.parseInt(request.getParameter("business_id"));
				double opening_balance=Double.parseDouble(request.getParameter("opening_balance"));
				
				SupplierBean bean=new SupplierBean();
				bean.setSupplier_name(supplier_name);
				bean.setSupplier_phone(supplier_phone);
				bean.setSupplier_address(supplier_address);
				bean.setSupplier_gstin(supplier_gstin);
				bean.setSupplier_panno(supplier_panno);
				bean.setBusiness_id(business_id);
				bean.setOpening_balance(opening_balance);
				int count=dao.insertSupplier(bean);
				
				writer.println(count);
				
				
			}
			
			else if(action.equals("UpdateSupplier")) {
				int supplier_id=Integer.parseInt(request.getParameter("supplier_id"));
				String supplier_name=request.getParameter("supplier_name");
				String supplier_phone=request.getParameter("supplier_phone");
				String supplier_address=request.getParameter("supplier_address");
				String supplier_gstin=request.getParameter("supplier_gstin");
				String supplier_panno=request.getParameter("supplier_panno");
				int business_id=Integer.parseInt(request.getParameter("business_id"));
				double opening_balance=Double.parseDouble(request.getParameter("opening_balance"));
				String supplier_email=request.getParameter("supplier_email");
				
				SupplierBean bean=new SupplierBean();
				bean.setSupplier_name(supplier_name);
				bean.setSupplier_phone(supplier_phone);
				bean.setSupplier_address(supplier_address);
				bean.setSupplier_id(supplier_id);
				bean.setSupplier_gstin(supplier_gstin);
				bean.setSupplier_panno(supplier_panno);
				bean.setOpening_balance(opening_balance);
				bean.setBusiness_id(business_id);
				bean.setSupplier_email(supplier_email);
				
				int count=dao.updateSupplier(bean);
				
				writer.println(count);
			}
			
			
			else if(action.equals("getSinglesupplierDetailsForUpdate")) {
				response.setContentType("application/json");
				response.setCharacterEncoding("utf-8");
				Gson gson=new Gson();
				int supplier_id=Integer.parseInt(request.getParameter("supplier_id"));
				SupplierBean bean=dao.getSingleSupplierDetails(supplier_id);
				writer.println(gson.toJson(bean));
			}
			
			else if(action.equals("UpdateStatus")) {
					int supplier_id=Integer.parseInt(request.getParameter("supplier_id"));
					String supplier_status=request.getParameter("supplier_status");
					int count=dao.changeSupplierStatus(supplier_id, supplier_status);
					writer.println(count);
			}
			else if(action.equals("UpdateTallyLedger")) {
				String[] tally_ledger=request.getParameterValues("tally_ledger");
				String[] supplier_id=(request.getParameterValues("supplier_id"));
				for( int i=0; i<supplier_id.length;i++) {
					int suppier_id=Integer.parseInt(supplier_id[i]);
				int count=dao.UpdateTallyLedger(suppier_id,tally_ledger[i]);
				}
				response.sendRedirect("PurchaseVoucherReport.jsp");
			}
			
			else if(action.equals("getSupplierList")) {
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
				data.put("data", dao.getSupplierList(search, business_id, start, length));
				data.put("draw", draw);
				int recordCount=dao.countSupplierList(search, business_id);
				data.put("recordsTotal", recordCount);
				data.put("recordsFiltered", recordCount);
				writer.print(gson.toJson(data));
			}
			
			else if(action.equals("getSupplierListByBusinessGroup")) {
				response.setContentType("application/json");
				response.setCharacterEncoding("utf-8");
				Gson gson=new Gson();
				int business_id=Integer.parseInt(request.getParameter("business_id"));
				List<Map<String,Object>> list=dao.getSupplierListByBusinessGroup(business_id);
				writer.println(gson.toJson(list));
			}
			
		}catch(Exception e) {
			e.printStackTrace();
			
		}
		
		
	}

}
