package com.willka.soft.test.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.willka.soft.bean.UserDetailBean;
import com.willka.soft.test.bean.CustomerPaymentBean;
import com.willka.soft.test.bean.SalesComissionBean;
import com.willka.soft.test.dao.SalesComissionDAO;
import com.willka.soft.test.dao.SalesComissionDAOImpl;

/**
 * Servlet implementation class SalesComissionController
 */
@WebServlet("/TestSalesComissionController")
public class SalesComissionController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SalesComissionController() {
        super();
        // TODO Auto-generated constructor stub
    }


    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter writer=response.getWriter();
		HttpSession session=request.getSession();
		
		SalesComissionDAO dao=new SalesComissionDAOImpl();
		try {
			String action=request.getParameter("action");
			if(action.equals("InsertPayment")) {
				int customer_id=Integer.parseInt(request.getParameter("customer_id"));
				int site_id=Integer.parseInt(request.getParameter("site_id"));
				double payment_amount=Double.parseDouble(request.getParameter("payment_amount"));
				String payment_type=request.getParameter("payment_mode");
				String check_dd_no=request.getParameter("check_dd_no");
				String check_dd_validity=request.getParameter("check_dd_validity");
				String payment_date=request.getParameter("payment_date");
				String payment_time=request.getParameter("payment_time");
				String paid_to=request.getParameter("paid_to");
				
				SalesComissionBean bean=new SalesComissionBean();
				bean.setCustomer_id(customer_id);
				bean.setSite_id(site_id);
				bean.setPayment_amount(payment_amount);
				bean.setPayment_category(payment_type);
				bean.setCheck_dd_number(check_dd_no);
				bean.setCheck_dd_validity(check_dd_validity);
				bean.setPayment_date(payment_date);
				bean.setPayment_time(payment_time);
				bean.setPaid_to(paid_to);
				
				int count=dao.insertPayment(bean);
				
				if(count>0) {
					session.setAttribute("res", "Payment Added Successfully");
					response.sendRedirect("gst/SalesComissionList.jsp");
				}else {
					session.setAttribute("res", "<span class='text-danger'>Failed!!</span>");
					response.sendRedirect("gst/SalesComissionList.jsp");
				}
			}
			
			
			else if(action.equals("GetCreditAmount")) {
				int customer_id=Integer.parseInt(request.getParameter("customer_id"));
				//get credit ammount here
				double credit_amount=dao.getCreditAmmount(customer_id);
				writer.println(credit_amount);
			}
			
			
			else if(action.equals("UpdatePayment")) {
				
				//get request parameter vlaue
				int payment_id=Integer.parseInt(request.getParameter("payment_id"));
				int customer_id=Integer.parseInt(request.getParameter("customer_id"));
				double payment_amount=Double.parseDouble(request.getParameter("payment_amount"));
				String payment_date=request.getParameter("payment_date");
				String payment_time=request.getParameter("payment_time");
				String payment_type=request.getParameter("payment_mode");
				String check_dd_no=request.getParameter("check_dd_no");
				String check_dd_validity=request.getParameter("check_dd_validity");
				String comment=request.getParameter("comment");
				String paid_to=request.getParameter("paid_to");
				
				//now set details to updatebean object
				SalesComissionBean updatebean=new SalesComissionBean();
				updatebean.setCustomer_id(customer_id);
				updatebean.setPayment_amount(payment_amount);
				updatebean.setPayment_category(payment_type);
				updatebean.setCheck_dd_number(check_dd_no);
				updatebean.setCheck_dd_validity(check_dd_validity);
				updatebean.setPayment_date(payment_date);
				updatebean.setPayment_time(payment_time);
				updatebean.setPayment_id(payment_id);
				updatebean.setPaid_to(paid_to);
				
				/*SalesComissionBean bean=dao.getSinglePaymentDetails(payment_id);*/
				//now update payment details
				int count=dao.updatePayment(updatebean);
				if(count>0) {
					//set modification details
				/*	bean.setModification_payment_amount(payment_amount);
					bean.setModification_type("update");
					bean.setComment(comment);
					//get username from session object
					UserDetailBean ubean=(UserDetailBean)session.getAttribute("bean");
					bean.setModification_user(ubean.getUser_email());
					dao.insertModificationDetails(bean);*/
					session.setAttribute("res", "Payment Updated Successfully");
					response.sendRedirect("gst/SalesComissionList.jsp");
				}else {
					session.setAttribute("res", "<span class='text-danger'>Failed!!</span>");
					response.sendRedirect("gst/SalesComissionList.jsp");
				}
				
			}
			
			else if(action.equals("DeletePayment")) {
				int payment_id=Integer.parseInt(request.getParameter("payment_id"));
				//now get payment details 
				SalesComissionBean bean=dao.getSinglePaymentDetails(payment_id);
				
				//now delete payment details
				int count=dao.deletePaymentDetails(payment_id);
				if(count>0) {
					//now insert to payment modification
					/*bean.setModification_type("delete");
					UserDetailBean ubean=(UserDetailBean)session.getAttribute("bean");
					bean.setModification_user(ubean.getUser_email());
					dao.insertModificationDetails(bean);*/
					session.setAttribute("res", "Payment Deleted Successfully");
					response.sendRedirect("gst/SalesComissionList.jsp");
				}else {
					session.setAttribute("res", "<span class='text-danger'>Failed!!</span>");
					response.sendRedirect("gst/SalesComissionList.jsp");
				}
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	

}
