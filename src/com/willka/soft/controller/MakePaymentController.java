package com.willka.soft.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
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
import com.willka.soft.bean.MakePaymentBean;
import com.willka.soft.bean.UserDetailBean;
import com.willka.soft.dao.MakePaymentDAO;
import com.willka.soft.dao.MakePaymentDAOImpl;
import com.willka.soft.util.IndianDateFormater;

/**
 * Servlet implementation class MakePaymentController
 */
@WebServlet("/MakePaymentController")
public class MakePaymentController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private Connection con=null;
	private PreparedStatement ps=null;
	private ResultSet rs=null;
	
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session=request.getSession();
		PrintWriter writer=response.getWriter();
		MakePaymentDAO dao=new MakePaymentDAOImpl();
		try{
			String action=request.getParameter("action");
			
			if(action.equals("checkBalance")){
				response.setContentType("application/json");
				response.setCharacterEncoding("utf-8");
				int supplier_id=Integer.parseInt(request.getParameter("supplier_id"));
				HashMap<String, Double> creditbalance=dao.getCreditBalance(supplier_id);
				
				double x=creditbalance.get("total_purchase");
				double y=creditbalance.get("total_payment");
				double credit=x-y;
				writer.println(credit);
				
			}
			
			else if(action.equals("InsertMakePayment")){
				double payment_amount=Double.parseDouble(request.getParameter("payment_amount"));
				String payment_date=IndianDateFormater
						.converToIndianFormat(request.getParameter("payment_date"));
				String payment_time=request.getParameter("payment_time");
				String payment_mode=request.getParameter("payment_mode");
				String check_dd_no=request.getParameter("check_dd_no");
				int supplier_id=Integer.parseInt(request.getParameter("supplier_id"));
				String remark=request.getParameter("remark");
				String check_dd_validity=request.getParameter("check_dd_validity");
				String payment_details=request.getParameter("payment_details");
				int bank_detail_id=Integer.parseInt(request.getParameter("bank_detail_id"));
				//now create makepayment bean object
				MakePaymentBean bean=new MakePaymentBean();
				bean.setPayment_amount(payment_amount);
				bean.setPayment_date(payment_date);
				bean.setPayment_time(payment_time);
				bean.setPayment_mode(payment_mode);
				bean.setCheck_dd_no(check_dd_no);
				bean.setCheck_dd_validity(check_dd_validity);
				bean.setPayment_details(payment_details);
				bean.setSupplier_id(supplier_id);
				bean.setRemark(remark);
				bean.setBank_detail_id(bank_detail_id);
				int count=dao.insertMakePayment(bean);
				
				if(count>0){
					session.setAttribute("res", "Payment Inserted Successfully");
					response.sendRedirect("MakePaymentList.jsp");
				}else{
					session.setAttribute("res", "<span class='text-danger'>Failed!!</span>");
					response.sendRedirect("MakePaymentList.jsp");
				}
			}
			
			else if(action.equals("UpdateMakePayment")){
				int payment_id=Integer.parseInt(request.getParameter("payment_id"));
				double payment_amount=Double.parseDouble(request.getParameter("payment_amount"));
				String payment_date=IndianDateFormater
						.converToIndianFormat(request.getParameter("payment_date"));
				int supplier_id=Integer.parseInt(request.getParameter("supplier_id"));
				String remark=request.getParameter("remark");
				String payment_time=request.getParameter("payment_time");
				String payment_mode=request.getParameter("payment_mode");
				String check_dd_no=request.getParameter("check_dd_no");
				String check_dd_validity=request.getParameter("check_dd_validity");
				String comment=request.getParameter("comment");
				String payment_details=request.getParameter("payment_details");
				int bank_detail_id=Integer.parseInt(request.getParameter("bank_detail_id"));
				//first get details of update payment
				MakePaymentBean been=dao.getSingleMakePayment(payment_id);
				//now create makepayment bean object
				MakePaymentBean bean=new MakePaymentBean();
				bean.setPayment_id(payment_id);
				bean.setPayment_amount(payment_amount);
				bean.setPayment_date(payment_date);
				bean.setPayment_time(payment_time);
				bean.setPayment_mode(payment_mode);
				bean.setCheck_dd_no(check_dd_no);
				bean.setCheck_dd_validity(check_dd_validity);
				bean.setPayment_details(payment_details);
				bean.setSupplier_id(supplier_id);
				bean.setRemark(remark);
				bean.setBank_detail_id(bank_detail_id);
				int count=dao.updateMakePayment(bean);
				
				if(count>0){
					//now add payment details to modified payment
					been.setComment(comment);
					UserDetailBean ubean=(UserDetailBean)session.getAttribute("bean");
					been.setModification_user(ubean.getUser_email());
					been.setNew_modified_amount(payment_amount);
					been.setModification_type("update");
					dao.insertMakePaymentModification(been);
					session.setAttribute("res", "Payment Updated Successfully");
					response.sendRedirect("MakePaymentList.jsp");
				}else{
					session.setAttribute("res", "<span class='text-danger'>Failed!!</span>");
					response.sendRedirect("MakePaymentList.jsp");
				}
			}
			
			else if(action.equals("DeleteMakePayment")){
				int payment_id=Integer.parseInt(request.getParameter("payment_id"));
				
				MakePaymentBean bean=dao.getSingleMakePayment(payment_id);
				bean.setComment("Delete");
				bean.setModification_type("delete");
				UserDetailBean ubean=(UserDetailBean)session.getAttribute("bean");
				bean.setModification_user(ubean.getUser_email());
				int count=dao.deleteMakePayment(payment_id);
				dao.insertMakePaymentModification(bean);
				writer.println(count);
			}
			
			else if(action.equals("GetMakePaymentList")) {
				response.setContentType("application/json");
				response.setCharacterEncoding("utf-8");
				Gson gson=new Gson();
				
				String from_date=request.getParameter("from_date");
				from_date=(from_date==null || from_date.trim().equals(""))?"":IndianDateFormater.converToIndianFormat(from_date);
				String to_date=request.getParameter("to_date");
				to_date=(to_date==null || to_date.trim().equals(""))?"":IndianDateFormater.converToIndianFormat(to_date);
				String payment_id=request.getParameter("payment_id");
				int supplier_id=(request.getParameter("supplier_id")==null || request.getParameter("supplier_id").trim().equals(""))?
						0:Integer.parseInt(request.getParameter("supplier_id"));
				int business_id=Integer.parseInt(request.getParameter("business_id"));
				int start=Integer.parseInt(request.getParameter("start"));
				int length=Integer.parseInt(request.getParameter("length"));
				Map<String,Object> data=new HashMap<>();
				int draw=Integer.parseInt(request.getParameter("draw"));
				data.put("data",dao.getAllMakePaymentList(from_date, to_date, payment_id, supplier_id, business_id, start, length));
				data.put("draw", draw);
				int recordCount=dao.countAllMakePaymentList(from_date, to_date, payment_id, supplier_id, business_id);
				data.put("recordsTotal", recordCount);
				data.put("recordsFiltered", recordCount);
				writer.print(gson.toJson(data));
			}
			
			//report part
			
			else if(action.equals("getDateWiseReport")) {
				response.setContentType("application/json");
				response.setContentType("application/json");
				Gson gson=new Gson();
				
				int business_id=Integer.parseInt(request.getParameter("business_id"));
				String from_date=IndianDateFormater
						.converToIndianFormat(request.getParameter("from_date"));
				String to_date=IndianDateFormater
						.converToIndianFormat(request.getParameter("to_date"));
				
				List<Map<String,Object>> list=dao.getDateWiseReport(from_date, to_date, business_id);
				writer.println(gson.toJson(list));
			}
			
			else if(action.equals("getSupplierWiseReport")) {
				response.setContentType("application/json");
				response.setContentType("application/json");
				Gson gson=new Gson();
				
				int business_id=Integer
						.parseInt(request.getParameter("business_id"));
				int supplier_id=Integer
						.parseInt(request.getParameter("supplier_id"));
				List<Map<String,Object>> list=dao.getSupplierWiseReport(supplier_id, business_id);
				writer.println(gson.toJson(list));
			}
			
			else if(action.equals("getSupplierWithDateWise")) {
				response.setContentType("application/json");
				response.setContentType("application/json");
				Gson gson=new Gson();
				
				int business_id=Integer
						.parseInt(request.getParameter("business_id"));
				int supplier_id=Integer
						.parseInt(request.getParameter("supplier_id"));
				String from_date=IndianDateFormater
						.converToIndianFormat(request.getParameter("from_date"));
				String to_date=IndianDateFormater
						.converToIndianFormat(request.getParameter("to_date"));
				
				List<Map<String,Object>> list=dao.getSupplierWithDateWise(supplier_id, from_date, to_date, business_id);
				writer.println(gson.toJson(list));
			}
			
			else if(action.equals("getBankWiseReport")) {
				response.setContentType("application/json");
				response.setContentType("application/json");
				Gson gson=new Gson();
				
				int business_id=Integer
						.parseInt(request.getParameter("business_id"));
				int bank_detail_id=Integer
						.parseInt(request.getParameter("bank_detail_id"));
				String from_date=IndianDateFormater
						.converToIndianFormat(request.getParameter("from_date"));
				String to_date=IndianDateFormater
						.converToIndianFormat(request.getParameter("to_date"));
				List<Map<String,Object>> list=dao.getBankWithDateWise(bank_detail_id, from_date, to_date, business_id);
				writer.println(gson.toJson(list));
			}
			
			else if(action.equals("getPurchaseTransaction")) {
				response.setContentType("application/json");
				response.setContentType("application/json");
				Gson gson=new Gson();
				String from_date=IndianDateFormater
						.converToIndianFormat(request.getParameter("from_date"));
				String to_date=IndianDateFormater
						.converToIndianFormat(request.getParameter("to_date"));
				int business_id=Integer.parseInt(request.getParameter("business_id"));
				List<Map<String,Object>> list=dao.getPurchaseTransactionReport(from_date, to_date, business_id);
				writer.println(gson.toJson(list));
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}
	}

}
