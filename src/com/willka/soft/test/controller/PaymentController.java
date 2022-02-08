package com.willka.soft.test.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.DecimalFormat;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.willka.soft.bean.UserDetailBean;
import com.willka.soft.test.bean.CustomerPaymentBean;
import com.willka.soft.test.dao.PaymentDAO;
import com.willka.soft.test.dao.PaymentDAOImpl;
import com.willka.soft.util.IndianDateFormater;

import javazoom.upload.MultipartFormDataRequest;
import javazoom.upload.UploadBean;
import javazoom.upload.UploadFile;

/**
 * Servlet implementation class PaymentController
 */
@WebServlet("/PaymentControllerTest")
public class PaymentController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		PrintWriter writer=response.getWriter();
		HttpSession session=request.getSession();
		
		PaymentDAO dao=new PaymentDAOImpl();
		try {
			String action=request.getParameter("action");
			if(action.equals("InsertPayment")) {
				int customer_id=Integer.parseInt(request.getParameter("customer_id"));
				double payment_amount=Double.parseDouble(request.getParameter("payment_amount"));
				String payment_type=request.getParameter("payment_mode");
				String check_dd_no=request.getParameter("check_dd_no");
				String check_dd_validity=request.getParameter("check_dd_validity");
				String payment_date=IndianDateFormater.
								converToIndianFormat(request.getParameter("payment_date"));
				String payment_time=request.getParameter("payment_time");
				int site_id=Integer.parseInt(request.getParameter("site_id"));
				String bill_photo=request.getParameter("bill_photo");
				String neft_no=request.getParameter("neft_no");
				int bank_detail_id=Integer.parseInt(request.getParameter("bank_detail_id"));
				
				CustomerPaymentBean bean=new CustomerPaymentBean();
				bean.setCustomer_id(customer_id);
				bean.setPayment_amount(payment_amount);
				bean.setPayment_category(payment_type);
				bean.setCheck_dd_number(check_dd_no);
				bean.setCheck_dd_validity(check_dd_validity);
				bean.setPayment_date(payment_date);
				bean.setPayment_time(payment_time);
				bean.setSite_id(site_id);
				bean.setBill_photo(bill_photo);
				bean.setNeft_no(neft_no);
				bean.setBank_detail_id(bank_detail_id);
				UserDetailBean ubean=(UserDetailBean)session.getAttribute("bean");
				bean.setUser_name(ubean.getUser_email());
				
				int count=dao.insertPayment(bean);
				
				if(count>0) {
					session.setAttribute("res", "Payment Added Successfully");
					response.sendRedirect("gst/CustomerPaymentList.jsp");
				}else {
					session.setAttribute("res", "<span class='text-danger'>Failed!!</span>");
					response.sendRedirect("gst/CustomerPaymentList.jsp");
				}
			}
			
			
			else if(action.equals("GetCreditAmount")) {
				int customer_id=Integer.parseInt(request.getParameter("customer_id"));
				//get credit ammount here
				double credit_amount=dao.getCreditAmmount(customer_id);
				writer.println(new DecimalFormat("#.##").format(credit_amount));
			}
			
			
			else if(action.equals("UpdatePayment")) {
				
				//get request parameter vlaue
				int payment_id=Integer.parseInt(request.getParameter("payment_id"));
				int customer_id=Integer.parseInt(request.getParameter("customer_id"));
				double payment_amount=Double.parseDouble(request.getParameter("payment_amount"));
				String payment_date=IndianDateFormater.
								converToIndianFormat(request.getParameter("payment_date"));
				String payment_time=request.getParameter("payment_time");
				String payment_type=request.getParameter("payment_mode");
				String check_dd_no=request.getParameter("check_dd_no");
				String check_dd_validity=request.getParameter("check_dd_validity");
				String comment=request.getParameter("comment");
				String neft_no=request.getParameter("neft_no");
				int bank_detail_id=Integer.parseInt(request.getParameter("bank_detail_id"));
				
				//now set details to updatebean object
				CustomerPaymentBean updatebean=new CustomerPaymentBean();
				updatebean.setCustomer_id(customer_id);
				updatebean.setPayment_amount(payment_amount);
				updatebean.setPayment_category(payment_type);
				updatebean.setCheck_dd_number(check_dd_no);
				updatebean.setCheck_dd_validity(check_dd_validity);
				updatebean.setPayment_date(payment_date);
				updatebean.setPayment_time(payment_time);
				updatebean.setPayment_id(payment_id);
				updatebean.setNeft_no(neft_no);
				updatebean.setBank_detail_id(bank_detail_id);
				
				CustomerPaymentBean bean=dao.getSinglePaymentDetails(payment_id);
				//now update payment details
				int count=dao.updatePayment(updatebean);
				if(count>0) {
					//set modification details
					bean.setModification_payment_amount(payment_amount);
					bean.setModification_type("update");
					bean.setComment(comment);
					//get username from session object
					UserDetailBean ubean=(UserDetailBean)session.getAttribute("bean");
					bean.setModification_user(ubean.getUser_email());
					dao.insertModificationDetails(bean);
					session.setAttribute("res", "Payment Updated Successfully");
					response.sendRedirect("gst/CustomerPaymentList.jsp");
				}else {
					session.setAttribute("res", "<span class='text-danger'>Failed!!</span>");
					response.sendRedirect("gst/CustomerPaymentList.jsp");
				}
				
			}
			
			else if(action.equals("DeletePayment")) {
				int payment_id=Integer.parseInt(request.getParameter("payment_id"));
				String comment=request.getParameter("comment");
				//now get payment details 
				CustomerPaymentBean bean=dao.getSinglePaymentDetails(payment_id);
				
				//now delete payment details
				int count=dao.deletePaymentDetails(payment_id);
				if(count>0) {
					//now insert to payment modification
					bean.setModification_type("delete");
					UserDetailBean ubean=(UserDetailBean)session.getAttribute("bean");
					bean.setComment(comment);
					bean.setModification_user(ubean.getUser_email());
					dao.insertModificationDetails(bean);
					session.setAttribute("res", "Payment Deleted Successfully");
					response.sendRedirect("gst/CustomerPaymentList.jsp");
				}else {
					session.setAttribute("res", "<span class='text-danger'>Failed!!</span>");
					response.sendRedirect("gst/CustomerPaymentList.jsp");
				}
			}
			
			else if(action.equals("upload_file")){
				String relativeWebPath = "/WebContent/document/";
				String my_path = getServletContext().getRealPath(relativeWebPath);
				//System.out.println(my_path);
				String path="/opt/tomcat1/webapps/altima/document";
				UploadBean bean=null;
				MultipartFormDataRequest nreq=null;
				Hashtable ht=null;
				Enumeration e=null;
				nreq=new MultipartFormDataRequest(request);
				bean=new UploadBean();
				bean.setFolderstore(path);
				bean.setOverwrite(true);
				//completing file uploading
				ht=nreq.getFiles();
				e=ht.elements();
				while(e.hasMoreElements()){
					UploadFile f=(UploadFile)e.nextElement();
				}
				bean.store(nreq);
				//display the names of the uploaded files
				ht=nreq.getFiles();
				e=ht.elements();
				String file_name=null;
				while(e.hasMoreElements()){
					UploadFile file=(UploadFile)e.nextElement();
					file_name=file.getFileName();
				}
				writer.println(file_name);
			}
			
			else if(action.equals("getPaymentList")) {
				response.setContentType("application/json");
				response.setCharacterEncoding("utf-8");
				Gson gson=new Gson();
				
				String from_date=request.getParameter("from_date");
				from_date=(from_date==null || from_date.trim().equals(""))?"":IndianDateFormater.converToIndianFormat(from_date);
				String to_date=request.getParameter("to_date");
				to_date=(to_date==null || to_date.trim().equals(""))?"":IndianDateFormater.converToIndianFormat(to_date);
				String payment_id=request.getParameter("payment_id");
				int customer_id=(request.getParameter("customer_id")==null || request.getParameter("customer_id").trim().equals(""))?
						0:Integer.parseInt(request.getParameter("customer_id"));
				int business_id=Integer.parseInt(request.getParameter("business_id"));
				int start=Integer.parseInt(request.getParameter("start"));
				int length=Integer.parseInt(request.getParameter("length"));
				Map<String,Object> data=new HashMap<>();
				int draw=Integer.parseInt(request.getParameter("draw"));
				data.put("data",dao.getPaymentList(from_date, to_date, payment_id, customer_id, business_id, start, length));
				data.put("draw", draw);
				int recordCount=dao.countPaymentList(from_date, to_date, payment_id, customer_id, business_id);
				data.put("recordsTotal", recordCount);
				data.put("recordsFiltered", recordCount);
				writer.print(gson.toJson(data));
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
	}

}
