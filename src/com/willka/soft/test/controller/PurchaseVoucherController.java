package com.willka.soft.test.controller;

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
import com.willka.soft.test.bean.PurchaseVoucherBean;
import com.willka.soft.test.bean.PurchaseVoucherItemBean;
import com.willka.soft.test.dao.PurchaseVoucherDAO;
import com.willka.soft.test.dao.PurchaseVoucherDAOImpl;
import com.willka.soft.util.IndianDateFormater;

/**
 * Servlet implementation class PurchaseVoucherController
 */
@WebServlet("/PurchaseVoucherControllerTest")
public class PurchaseVoucherController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String action=request.getParameter("action");
			HttpSession session=request.getSession();
			PurchaseVoucherDAO dao=new PurchaseVoucherDAOImpl();
			PrintWriter writer=response.getWriter();
			
			if(action.equals("InsertVoucher")) {
				synchronized (this) {
					//get request parameter value data
					String   bill_no=request.getParameter("bill_no");
					String purchase_date=IndianDateFormater
									.converToIndianFormat(request.getParameter("purchase_date"));
					String rate_include_tax=(request.getParameterValues("rate_include_tax")==null)?"no":"yes";
					int supplier_id=Integer.parseInt(request.getParameter("supplier_id"));
					double discount_amount=(request.getParameter("discount_amount")==null || request.getParameter("discount_amount").trim().equals(""))?0.0:Double.parseDouble(request.getParameter("discount_amount"));
					double round_off=Double.parseDouble(request.getParameter("round_off"));
					String item_name[]=request.getParameterValues("item_name");
					String item_quantity[]=request.getParameterValues("item_quantity");
					String item_price[]=request.getParameterValues("item_price");
					String gst_percent[]=request.getParameterValues("gst_percent");
					String tax_amount[]=request.getParameterValues("tax_amount");
					String gross_amount[]=request.getParameterValues("gross_amount");
					String net_amount[]=request.getParameterValues("net_amount");
					String gst_type=request.getParameter("gst_type");
					int plant_id=Integer.parseInt(request.getParameter("plant_id"));
					
					
					
					
					//insert purchase voucher details
					PurchaseVoucherBean bean=new PurchaseVoucherBean();
					bean.setBill_no(bill_no);
					bean.setDiscount_amount(discount_amount);
					bean.setPurhcase_date(purchase_date);
					bean.setRate_include_tax(rate_include_tax);
					bean.setSupplier_id(supplier_id);
					bean.setRound_off(round_off);
					bean.setGst_type(gst_type);
					bean.setPlant_id(plant_id);
					
					//now insert purchase voucher
					
					int count=dao.insertPurchaseVoucher(bean);
					
					if(count>0) {
						//now insert purchse voucher items
						int purchase_voucher_id=dao.getMaxPurchaseVoucherId();
						for(int i=0;i<item_name.length;i++){
							PurchaseVoucherItemBean ibean=new PurchaseVoucherItemBean();
							ibean.setItem_name(item_name[i]);
							ibean.setItem_quantity(Double.parseDouble(item_quantity[i]));
							ibean.setItem_price(Double.parseDouble(item_price[i]));
							ibean.setPurchase_voucher_id(purchase_voucher_id);
							ibean.setGst_percent(Float.parseFloat(gst_percent[i]));
							ibean.setTax_amount(Double.parseDouble(tax_amount[i]));
							ibean.setNet_amount(Double.parseDouble(net_amount[i]));
							ibean.setGross_amount(Double.parseDouble(gross_amount[i]));
							dao.insertPurchaseVoucherItem(ibean);
						}
						session.setAttribute("result", "insert");
						response.sendRedirect("gst/PurchaseVoucherList.jsp");
					}else {
						session.setAttribute("result", "insert_failed");
						response.sendRedirect("gst/PurchaseVoucherList.jsp");
					}
					
					
					}
			}
			
			else if(action.equals("UpdatePurchasevoucher")) {
				//get request parameter value data
				String   bill_no=request.getParameter("bill_no");
				String purchase_date=IndianDateFormater.
							converToIndianFormat(request.getParameter("purchase_date"));
				int supplier_id=Integer.parseInt(request.getParameter("supplier_id"));
				double discount_amount=(request.getParameter("discount_amount")==null || request.getParameter("discount_amount").trim().equals(""))?
							0.0:Double.parseDouble(request.getParameter("discount_amount"));
				double round_off=Double.parseDouble(request.getParameter("round_off"));
				String item_name[]=request.getParameterValues("item_name");
				String item_quantity[]=request.getParameterValues("item_quantity");
				String item_price[]=request.getParameterValues("item_price");
				String rate_include_tax=(request.getParameterValues("rate_include_tax")==null)?"no":"yes";
				int purchase_voucher_id=Integer.parseInt(request.getParameter("purchase_voucher_id"));
				String pvi_id[]=request.getParameterValues("pvi_id");
				String gst_percent[]=request.getParameterValues("gst_percent");
				String tax_amount[]=request.getParameterValues("tax_amount");
				String gross_amount[]=request.getParameterValues("gross_amount");
				String net_amount[]=request.getParameterValues("net_amount");
				String gst_type=request.getParameter("gst_type");
				int plant_id=Integer.parseInt(request.getParameter("plant_id"));
				
				//insert purchase voucher details
				PurchaseVoucherBean bean=new PurchaseVoucherBean();
				bean.setBill_no(bill_no);
				bean.setDiscount_amount(discount_amount);
				bean.setPurhcase_date(purchase_date);
				bean.setPurchase_voucher_id(purchase_voucher_id);
				bean.setRate_include_tax(rate_include_tax);
				bean.setSupplier_id(supplier_id);
				bean.setRound_off(round_off);
				bean.setGst_type(gst_type);
				bean.setPlant_id(plant_id);
				//now insert purchase voucher
				
				int count=dao.updatePurchaseVoucher(bean);
				
				if(count>0) {
					//now insert purchse voucher items
					for(int i=0;i<item_name.length;i++){
						try {
							PurchaseVoucherItemBean ibean=new PurchaseVoucherItemBean();
							ibean.setItem_name(item_name[i]);
							ibean.setItem_quantity(Double.parseDouble(item_quantity[i]));
							ibean.setItem_price(Double.parseDouble(item_price[i]));
							ibean.setPurchase_voucher_id(purchase_voucher_id);
							ibean.setPvi_id(Integer.parseInt(pvi_id[i]));
							ibean.setGst_percent(Float.parseFloat(gst_percent[i]));
							ibean.setTax_amount(Double.parseDouble(tax_amount[i]));
							ibean.setNet_amount(Double.parseDouble(net_amount[i]));
							ibean.setGross_amount(Double.parseDouble(gross_amount[i]));
							dao.updatePurchaseVoucherItem(ibean);
						}catch(Exception e) {
							PurchaseVoucherItemBean ibean=new PurchaseVoucherItemBean();
							ibean.setItem_name(item_name[i]);
							ibean.setItem_quantity(Double.parseDouble(item_quantity[i]));
							ibean.setItem_price(Double.parseDouble(item_price[i]));
							ibean.setPurchase_voucher_id(purchase_voucher_id);
							ibean.setGst_percent(Float.parseFloat(gst_percent[i]));
							ibean.setTax_amount(Double.parseDouble(tax_amount[i]));
							ibean.setNet_amount(Double.parseDouble(net_amount[i]));
							ibean.setGross_amount(Double.parseDouble(gross_amount[i]));
							dao.insertPurchaseVoucherItem(ibean);
						}
					}
					session.setAttribute("result", "update");
					response.sendRedirect("gst/PurchaseVoucherList.jsp");
				}else {
					session.setAttribute("result", "insert_failed");
					response.sendRedirect("gst/PurchaseVoucherList.jsp");
				}
				
			}
			
			else if(action.equals("CancelPurchaseVoucher")) {
				int purchase_voucher_id=Integer.parseInt(request.getParameter("purchase_voucher_id"));
				int count=dao.changePurchaseVoucherStatus(purchase_voucher_id, "cancelled");
				writer.println(count);
			}
			else if(action.equals("activatePurchaseVoucher")) {
				int purchase_voucher_id=Integer.parseInt(request.getParameter("purchase_voucher_id"));
				int count=dao.activatePurchaseVoucherStatus(purchase_voucher_id, "active");
				writer.println(count);
			}
			
			else if(action.equals("deletePurchaseVoucher")) {
				int purchase_voucher_id=Integer.parseInt(request.getParameter("purchase_voucher_id"));
				int count=dao.DeletePurchaseVoucher(purchase_voucher_id);
				writer.println(count);
			}
			
			else if(action.equals("getAllPurchaseVoucherList")) {
				response.setContentType("application/json");
				response.setCharacterEncoding("utf-8");
				Gson gson=new Gson();
				String from_date=request.getParameter("from_date");
				from_date=(from_date==null || from_date.trim().equals(""))?"":IndianDateFormater.converToIndianFormat(from_date);
				String to_date=request.getParameter("to_date");
				to_date=(to_date==null || to_date.trim().equals(""))?"":IndianDateFormater.converToIndianFormat(to_date);
				int supplier_id=(request.getParameter("supplier_id")==null || request.getParameter("supplier_id").trim().equals(""))?
						0:Integer.parseInt(request.getParameter("supplier_id"));
				String bill_no=request.getParameter("bill_no");
				int start=Integer.parseInt(request.getParameter("start"));
				int length=Integer.parseInt(request.getParameter("length"));
				int business_id=Integer.parseInt(request.getParameter("business_id"));
				Map<String,Object> data=new HashMap<>();
				int draw=Integer.parseInt(request.getParameter("draw"));
				data.put("data",dao.getPurchaseVoucherList(bill_no, from_date, to_date, supplier_id,business_id, start, length));
				data.put("draw", draw);
				int recordCount=dao.countPurchaseVoucherList(bill_no, from_date, to_date, supplier_id,business_id);
				data.put("recordsTotal", recordCount);
				data.put("recordsFiltered", recordCount);
				writer.print(gson.toJson(data));
	   	}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}

}
