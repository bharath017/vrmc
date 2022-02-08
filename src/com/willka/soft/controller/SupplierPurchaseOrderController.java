package com.willka.soft.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Calendar;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.willka.soft.bean.SupplierPurchaseOrderBean;
import com.willka.soft.bean.SupplierPurchaseOrderItemBean;
import com.willka.soft.dao.SupplierPurchaseOrderDAOImpl;


@WebServlet("/SupplierPurchaseOrderController")
public class SupplierPurchaseOrderController extends HttpServlet {
	private static final long serialVersionUID = 1487L;
       
   	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//General Settings
		PrintWriter writer=response.getWriter();
		
		//Get Session Object
		HttpSession session=request.getSession();
		SupplierPurchaseOrderDAOImpl dao=new SupplierPurchaseOrderDAOImpl();
		
		try {
			
			String pressed_button=request.getParameter("action");
			System.out.println("one");
			if(pressed_button.equals("insert")) 
			{
				synchronized (this) {
					//Get Request Purchase Order
					String purchase_order_date=request.getParameter("purchase_order_date");
					String required_date=request.getParameter("required_date");
					String payment_term=request.getParameter("payment_term");
					String description=request.getParameter("description");
					int supplier_id=Integer.parseInt(request.getParameter("supplier_id"));
					String gst_type=request.getParameter("gst_type");
					float gst_percentage=Float.parseFloat(request.getParameter("gst_percentage"));
					String order_validity=request.getParameter("order_validity");
					String receiver_name=request.getParameter("receiver_name");
					String receiver_phone=request.getParameter("receiver_phone");
					String receiver_email=request.getParameter("receiver_email");
					String quotation_no=request.getParameter("quotation_no");
					double discount=(request.getParameter("discount")==null || request.getParameter("discount").trim().equals(""))?0.0:Double.parseDouble(request.getParameter("discount"));
					String discount_type=request.getParameter("discount_type");
					double pf_percent=(request.getParameter("pf_percent")==null || request.getParameter("pf_percent").trim().equals(""))?0.0:Double.parseDouble(request.getParameter("pf_percent"));
					String terms=request.getParameter("terms");
					int plant_id=Integer.parseInt(request.getParameter("plant_id"));
					int pl_delivery_address_id=Integer.parseInt(request.getParameter("pl_delivery_address_id"));
					
					String[] product_number=request.getParameterValues("product_number");
					String[] description1=request.getParameterValues("description1");
					String quantity[]=request.getParameterValues("quantity");
					String[] unit_price=request.getParameterValues("unit_price");
					String unit[]=request.getParameterValues("unit");
					
					//Create Supplier Purchase Order Bean Object
					SupplierPurchaseOrderBean bean=new SupplierPurchaseOrderBean();
					bean.setPurchase_order_date(purchase_order_date);
					bean.setRequired_date(required_date);
					bean.setPayment_term(payment_term);
					bean.setDescription(description);
					bean.setSupplier_id(supplier_id);
					bean.setGst_type(gst_type);
					bean.setGst_percentage(gst_percentage);
					bean.setOrder_validity(order_validity);
					bean.setReceiver_name(receiver_name);
					bean.setReceiver_phone(receiver_phone);
					bean.setReceiver_email(receiver_email);
					bean.setQuotation_no(quotation_no);
					bean.setDiscount(discount);
					bean.setDiscount_type(discount_type);
					bean.setPf_percent(pf_percent);
					bean.setTerms(terms);
					bean.setPlant_id(plant_id);
					bean.setPl_delivery_address_id(pl_delivery_address_id);
					//get start and end year here
					Calendar cal=Calendar.getInstance();
					int year=cal.get(Calendar.YEAR);
					int month=cal.get(Calendar.MONTH);
					
					int start_year=0;
					int end_year=0;
					
					start_year=(month>=4)?year:year-1;
					end_year=(month>4)?year+1:year;
					
					int order_no=dao.getMaxOrderNo(plant_id, start_year, end_year);
					bean.setOrder_no(order_no);
					bean.setStart_year(start_year);
					bean.setEnd_year(end_year);
					
					//Now Insert GST Value
					int count=dao.insertSupplierPurchaseOrder(bean);
					
					//Get Max Id
					int supplier_purchase_order_id=dao.getMaxSupplierPurchaseOrderId();
					int val=0;
					if(count>0) {
						for(int i=0;i<product_number.length;i++)
						{
							val++;
							
							SupplierPurchaseOrderItemBean been=new SupplierPurchaseOrderItemBean();
							if(product_number[i]!=null && !product_number[i].trim().equals(""))
							{
								been.setProduct_number(product_number[i]);
								been.setDescription1(description1[i]);
								been.setQuantity((quantity[i]==null || quantity[i].trim().equals(""))?0.0:Double.parseDouble(quantity[i]));
								been.setUnit_price((unit_price[i]==null || unit_price[i].trim().equals(""))?0.0:Double.parseDouble(unit_price[i]));
								been.setUnit(unit[i]);
								been.setSupplier_purchase_order_id(supplier_purchase_order_id);
								dao.insertSupplierPurchaseOrderItem(been);
							}
						}
						
						if(val>0){
							//set session attribute value
							session.setAttribute("result", "SUPPLIER PURCHASE ORDER INSERTED SUCCESSFULLY");
							response.sendRedirect("SupplierPurchaseOrderList.jsp");
						}
						else{
							//set session attribute value
							session.setAttribute("result", "<span style='color:red;'>SUPPLIER PURCHASE ORDER INSERTION UNSUCCESSFUL<span>");
							response.sendRedirect("SupplierPurchaseOrderList.jsp");
						}
						
					}
					
					else{
						session.setAttribute("result", "<span style='color:red;'>SUPPLIER PURCHASE ORDER INSERTION UNSUCCESSFUL<span>");
						response.sendRedirect("SupplierPurchaseOrderList.jsp");
					}
					
				}
			}
			
		
			else if(pressed_button.equals("getProduct"))
			{
				response.setContentType("application/json");
				response.setCharacterEncoding("UTF-8");
				Gson gson=new Gson();
				
				int supplier_purchase_order_id=Integer.parseInt(request.getParameter("supplier_purchase_order_id"));
				ArrayList<SupplierPurchaseOrderItemBean> list=dao.getAllSupplierPurchaseOrderItem(supplier_purchase_order_id);
				writer.println(gson.toJson(list));
			}
			
			else if(pressed_button.equals("delete"))
			{
				int supplier_purchase_order_id=Integer.parseInt(request.getParameter("supplier_purchase_order_id"));
				int count=dao.deleteSupplierPurchaseOrder(supplier_purchase_order_id);
				if(count>0)
				{
					session.setAttribute("result", "SUPPLIER PURCHASE ORDER ID : "+supplier_purchase_order_id+" DELETED SUCCESSFULLY");
					response.sendRedirect("SupplierPurchaseOrderList.jsp");
				}
				else
				{
					session.setAttribute("result", "<span style='color:red;'>SUPPLIER PO ID : "+supplier_purchase_order_id+" DELETION UNSUCCESSFUL<span>");
					response.sendRedirect("SupplierPurchaseOrderList.jsp");
				}
			}
			
			else if(pressed_button.equals("approve"))
			{
				int supplier_purchase_order_id=Integer.parseInt(request.getParameter("supplier_purchase_order_id"));
				int count=dao.approveSupplierPurchaseOrder(supplier_purchase_order_id);
				if(count>0)
				{
					session.setAttribute("result", "SUPPLIER PURCHASE ORDER ID : "+supplier_purchase_order_id+" APPROVED SUCCESSFULLY");
					response.sendRedirect("SupplierPurchaseOrderList.jsp");
				}
				else
				{
					session.setAttribute("result", "<span style='color:red;'>SUPPLIER PO ID : "+supplier_purchase_order_id+" APPROVAL UNSUCCESSFUL<span>");
					response.sendRedirect("SupplierPurchaseOrderList.jsp");
				}
			}
			
			
			else if(pressed_button.equals("deletesp")){
				int spoi_id=Integer.parseInt(request.getParameter("spoi_id"));
				int count=dao.deleteSupplierPurchaseOrderItem(spoi_id);
				if(count>0){
					writer.println("DELETED SUCCESSFULLY");
				}
			}
			
			else if(pressed_button.equals("update")) {
				int supplier_purchase_order_id=Integer.parseInt(request.getParameter("supplier_purchase_order_id"));
				String purchase_order_date=request.getParameter("purchase_order_date");
				String required_date=request.getParameter("required_date");
				String payment_term=request.getParameter("payment_term");
				String description=request.getParameter("description");
				int supplier_id=Integer.parseInt(request.getParameter("supplier_id"));
				String gst_type=request.getParameter("gst_type");
				float gst_percentage=Float.parseFloat(request.getParameter("gst_percentage"));
				String order_validity=request.getParameter("order_validity");
				String receiver_name=request.getParameter("receiver_name");
				String receiver_phone=request.getParameter("receiver_phone");
				String receiver_email=request.getParameter("receiver_email");
				String quotation_no=request.getParameter("quotation_no");
				double discount=(request.getParameter("discount")==null || request.getParameter("discount").trim().equals(""))?0.0:Double.parseDouble(request.getParameter("discount"));
				String discount_type=request.getParameter("discount_type");
				double pf_percent=(request.getParameter("pf_percent")==null || request.getParameter("pf_percent").trim().equals(""))?0.0:Double.parseDouble(request.getParameter("pf_percent"));
				String terms=request.getParameter("terms");
				int plant_id=Integer.parseInt(request.getParameter("plant_id"));
				
				
				String[] spoi_id=request.getParameterValues("spoi_id");
				String[] product_number=request.getParameterValues("product_number");
				String[] description1=request.getParameterValues("description1");
				String quantity[]=request.getParameterValues("quantity");
				String[] unit_price=request.getParameterValues("unit_price");
				String unit[]=request.getParameterValues("unit");
				
				SupplierPurchaseOrderBean bean=new SupplierPurchaseOrderBean();
				bean.setSupplier_purchase_order_id(supplier_purchase_order_id);
				bean.setPurchase_order_date(purchase_order_date);
				bean.setRequired_date(required_date);
				bean.setPayment_term(payment_term);
				bean.setDescription(description);
				bean.setSupplier_id(supplier_id);
				bean.setGst_type(gst_type);
				bean.setGst_percentage(gst_percentage);
				bean.setOrder_validity(order_validity);
				bean.setReceiver_name(receiver_name);
				bean.setReceiver_phone(receiver_phone);
				bean.setReceiver_email(receiver_email);
				bean.setQuotation_no(quotation_no);
				bean.setDiscount(discount);
				bean.setDiscount_type(discount_type);
				bean.setPf_percent(pf_percent);
				bean.setTerms(terms);
				bean.setPlant_id(plant_id);
				//Update Supplier Purchase Order
				
				int count=dao.updateSupplierPurchaseOrder(bean);
				int val=0;
				if(count>0)
				{
					for(int i=0;i<product_number.length;i++)
					{
						val++;
						
						try {
							
							SupplierPurchaseOrderItemBean been=new SupplierPurchaseOrderItemBean();
							been.setSpoi_id(Integer.parseInt(spoi_id[i]));
							been.setProduct_number(product_number[i]);
							been.setDescription1(description1[i]);
							been.setQuantity((quantity[i]==null || quantity[i].trim().equals(""))?0.0:Double.parseDouble(quantity[i]));
							been.setUnit_price((unit_price[i]==null || unit_price[i].trim().equals(""))?0.0:Double.parseDouble(unit_price[i]));
							been.setSupplier_purchase_order_id(supplier_purchase_order_id);
							been.setUnit(unit[i]);
							dao.updateSupplierPurchaseOrderItem(been);
						}
						catch(ArrayIndexOutOfBoundsException e)
						{
							if(product_number[i]!=null && !product_number[i].trim().equals("")) {
								SupplierPurchaseOrderItemBean been=new SupplierPurchaseOrderItemBean();
								been.setProduct_number(product_number[i]);
								been.setDescription1(description1[i]);
								been.setQuantity((quantity[i]==null || quantity[i].trim().equals(""))?0.0:Double.parseDouble(quantity[i]));
								been.setUnit_price((unit_price[i]==null || unit_price[i].trim().equals(""))?0.0:Double.parseDouble(unit_price[i]));
								been.setSupplier_purchase_order_id(supplier_purchase_order_id);
								been.setUnit(unit[i]);
								dao.insertSupplierPurchaseOrderItem(been);
							}
						}
					}
					
					if(val>0){
						session.setAttribute("res", "SUPPLIER PURCHASE ORDER ID : "+supplier_id+" UPDATED SUCCESSFULLY");
						response.sendRedirect("SupplierPurchaseOrderList.jsp");
					}else{
						session.setAttribute("res", "<span style='color:red;'>SUPPLIER PURCHASE ORDER ID : "+supplier_id+" UPDATION  UNSUCCESSFUL<span>");
						response.sendRedirect("SupplierPurchaseOrderList.jsp");
					}
				}
				
			}
			
		}
		catch(Exception e)
		{
			e.printStackTrace();
			session.setAttribute("res", "<span style='color:red;'>INTERNAL ERROR OCCURED!!!<span>");
			response.sendRedirect("SupplierPurchaseOrderList.jsp");
		}
	
	}

}
