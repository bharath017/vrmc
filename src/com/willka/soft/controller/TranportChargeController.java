package com.willka.soft.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.willka.soft.bean.TransportChargeBean;
import com.willka.soft.dao.TransportChargeDAO;
import com.willka.soft.dao.TransportChargeDAOImpl;

/**
 * Servlet implementation class TranportChargeController
 */
@WebServlet("/TranportChargeController")
public class TranportChargeController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session=request.getSession();
		PrintWriter writer=response.getWriter();
		response.setContentType("text/html");

		
		TransportChargeDAO dao=new TransportChargeDAOImpl();
		
		try {
			
			String action=request.getParameter("action");
			if(action.equals("InsertTranportCharge")) {
				synchronized (this) {
					String vehicle_no=request.getParameter("vehicle_no");
					double opening_km=Double.parseDouble(request.getParameter("opening_km"));
					double closing_km=Double.parseDouble(request.getParameter("closing_km"));
					double price=Double.parseDouble(request.getParameter("price"));
					String invoice_date=request.getParameter("invoice_date");
					String invoice_time=request.getParameter("invoice_time");
					int plant_id=Integer.parseInt(request.getParameter("plant_id"));
					String tax_type=request.getParameter("tax_type");
					double tax_percent=Double.parseDouble(request.getParameter("tax_percent"));
					double gross_amount=Double.parseDouble(request.getParameter("gross_amount"));
					double tax_amount=Double.parseDouble(request.getParameter("tax_amount"));
					double net_amount=Double.parseDouble(request.getParameter("net_amount"));
					
					
					String split[]=invoice_date.split("-");
					int year=(split[0]==null || split[0].trim().equals(""))?0:Integer.parseInt(split[0]);
					int month=(split[1]==null || split[1].trim().equals(""))?0:Integer.parseInt(split[1]);
					
					int start_year=0;
					int end_year=0;
					if(month>3) {
						start_year=year;
						end_year=year+1;
					}else {
						start_year=year-1;
						end_year=year;
					}
					int invoice_id=dao.getInvoiceId(plant_id, start_year, end_year);
					
					TransportChargeBean bean=new TransportChargeBean();
					bean.setVehicle_no(vehicle_no);
					bean.setInvoice_id(invoice_id);
					bean.setOpening_km(opening_km);
					bean.setClosing_km(closing_km);
					bean.setInvoice_date(invoice_date);
					bean.setInvoice_time(invoice_time);
					bean.setStart_year(start_year);
					bean.setEnd_year(end_year);
					bean.setPrice(price);
					bean.setTax_type(tax_type);
					bean.setTax_percent(tax_percent);
					bean.setGross_amount(gross_amount);
					bean.setTax_amount(tax_amount);
					bean.setNet_amount(net_amount);
					
					int count=dao.insertTranportCharge(bean);
					
					if(count>0) {
						session.setAttribute("result", "Inserted Successfully");
						
					}
					
				}
				
			}else if(action.equals("GetTranportInvoice")) {
				String invoice_date=request.getParameter("invoice_date");
				int plant_id=Integer.parseInt(request.getParameter("plant_id"));
				
				String split[]=invoice_date.split("-");
				int year=(split[0]==null || split[0].trim().equals(""))?0:Integer.parseInt(split[0]);
				int month=(split[1]==null || split[1].trim().equals(""))?0:Integer.parseInt(split[1]);
				
				int start_year=0;
				int end_year=0;
				if(month>3) {
					start_year=year;
					end_year=year+1;
				}else {
					start_year=year-1;
					end_year=year;
				}
				
				int invoice_id=dao.getInvoiceId(plant_id, start_year, end_year);
				
				writer.println(invoice_id);
			}
			
		}catch(Exception e) {
			
		}
	}

}
