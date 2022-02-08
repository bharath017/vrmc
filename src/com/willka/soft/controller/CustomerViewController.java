package com.willka.soft.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.willka.soft.bean.ContactPerson;
import com.willka.soft.bean.CustomerPaymentBean;
import com.willka.soft.bean.PurchaseOrderBean;
import com.willka.soft.bean.PurchaseOrderItemBean;
import com.willka.soft.bean.SiteDetailBean;
import com.willka.soft.bean.UserDetailBean;
import com.willka.soft.dao.CustomerDaoImpl;
import com.willka.soft.dao.PaymentDAO;
import com.willka.soft.dao.PaymentDAOImpl;
import com.willka.soft.dao.PurchaseOrderDAO;
import com.willka.soft.dao.PurchaseOrderDAOImpl;

@WebServlet("/CustomerViewController")
public class CustomerViewController extends HttpServlet {
	private static final long serialVersionUID = 14343L;
  
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int customer_id=Integer.parseInt(request.getParameter("customer_id"));
		HttpSession session=request.getSession();
		session.setAttribute("customer_id", customer_id);
		response.sendRedirect("ViewCustomer.jsp");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		PrintWriter writer=response.getWriter();
		HttpSession ses=request.getSession();
		CustomerDaoImpl dao=new CustomerDaoImpl();
		PurchaseOrderDAO pdao=new PurchaseOrderDAOImpl();
		PaymentDAO paydao=new PaymentDAOImpl();
		try {
			String action=request.getParameter("action");
			
			if(action.equals("addSiteDetails")) {
				int customer_id=Integer.parseInt(request.getParameter("customer_id"));
				String site_name=request.getParameter("site_name");
				String site_address=request.getParameter("site_address");
				
				SiteDetailBean bean=new SiteDetailBean();
				bean.setCustomer_id(customer_id);
				bean.setSite_name(site_name);
				bean.setSite_address(site_address);
				
				int count=dao.insertSiteDetails(bean);
				if(count>0) {
					response.sendRedirect("ViewCustomer.jsp");
				}else {
					response.sendRedirect("ViewCustomer.jsp");
				}
			}
			
			else if(action.equals("updateSiteDetails")) {
				int site_id=Integer.parseInt(request.getParameter("site_id"));
				String site_name=request.getParameter("site_name");
				String site_address=request.getParameter("site_address");
				String tally_ledger=request.getParameter("tally_ledger");
				
				SiteDetailBean bean=new SiteDetailBean();
				bean.setSite_address(site_address);
				bean.setSite_name(site_name);
				bean.setSite_id(site_id);
				bean.setTally_ladger(tally_ledger);
				
				int count=dao.updateSiteDetails(bean);
				if(count>0) {
					response.sendRedirect("ViewCustomer.jsp");
				}else {
					response.sendRedirect("ViewCustomer.jsp");
				}
			}
			
			else if(action.equals("changeSiteStatus")) {
				int site_id=Integer.parseInt(request.getParameter("site_id"));
				String site_status=request.getParameter("site_status");
				int count=dao.changeSiteStatus(site_id, site_status);
				if(count>0) {
					response.sendRedirect("ViewCustomer.jsp");
				}else {
					response.sendRedirect("ViewCustomer.jsp");
				}
			}
			
			else if(action.equals("InsertContactPerson")) {
				int customer_id=Integer.parseInt(request.getParameter("customer_id"));
				String contact_name=request.getParameter("contact_name");
				String phone=request.getParameter("phone");
				String email=request.getParameter("email");
				
				ContactPerson bean=new ContactPerson();
				bean.setPhone(phone);
				bean.setCustomer_id(customer_id);
				bean.setEmail(email);
				bean.setContact_name(contact_name);
				
				int count=dao.insertCotactPerson(bean);
				
				if(count>0) {
					response.sendRedirect("ViewCustomer.jsp");
				}else {
					response.sendRedirect("ViewCustomer.jsp");
				}
			}
			
			else if(action.equals("DeleteContactPerson")) {
				int contact_id=Integer.parseInt(request.getParameter("contact_id"));
				int count=dao.deleteContactPerson(contact_id);
				
				if(count>0) {
					response.sendRedirect("ViewCustomer.jsp");
				}else {
					response.sendRedirect("ViewCustomer.jsp");
				}
			}
			
			else if(action.equals("InsertPO")) {
				synchronized (this) {
					//get request parameter value
					int customer_id=Integer.parseInt(request.getParameter("customer_id"));
					String po_date=request.getParameter("po_date");
					String po_valid_till=request.getParameter("po_valid_till");
					String credit_date=request.getParameter("credit_date");
					int address_id=Integer.parseInt(request.getParameter("site_id"));
					String po_number=request.getParameter("po_number");
					String tax_group=request.getParameter("gst_type");
					int plant_id=Integer.parseInt(request.getParameter("plant_id"));
					String bill_photo=request.getParameter("bill_photo");
					String rate_include_tax=(request.getParameterValues("rate_include_tax")==null)?"no":"yes";
					int mp_id=Integer.parseInt(request.getParameter("mp_id"));
					float gst_percent=(request.getParameter("gst_percent")==null || request.getParameter("gst_percent").trim().equals(""))?0.0f:Float.parseFloat(request.getParameter("gst_percent"));
					String order_type=request.getParameter("order_type");
					int credit_days=(request.getParameter("credit_days")==null || request.getParameter("credit_days").trim().equals(""))?0:Integer.parseInt(request.getParameter("credit_days"));
					double credit_limit=(request.getParameter("credit_limit")==null || request.getParameter("credit_limit").trim().equals(""))?0.0:Double.parseDouble(request.getParameter("credit_limit"));
					int gst_id=Integer.parseInt(request.getParameter("gst_id"));
					
	
					
					//get grade detail
					String product_id[]=request.getParameterValues("product_id");
					String quantity[]=request.getParameterValues("quantity");
					String rate[]=request.getParameterValues("rate");
					
					
					
					//first insert po detail
					PurchaseOrderBean bean=new PurchaseOrderBean();
					bean.setCustomer_id(customer_id);
					bean.setPo_date(po_date);
					bean.setPo_valid_till(po_valid_till);
					bean.setCredit_date(credit_date);
					bean.setAddress_id(address_id);
					bean.setPo_number(po_number);
					bean.setTax_group(tax_group);
					bean.setPlant_id(plant_id);
					bean.setRate_include_tax(rate_include_tax);
					bean.setGst_percent(gst_percent);
					bean.setOrder_type(order_type);
					bean.setMarketing_person_id(mp_id);
					bean.setBill_photo(bill_photo);
					bean.setCredit_days(credit_days);
					bean.setCredit_limit(credit_limit);
					bean.setGst_id(gst_id);
					//insert po
					int count=pdao.insertPurchaseOrder(bean);
					int order_id=pdao.getHighestOrderId();
					if(count>0){
						//insert po grade
						for(int i=0;i<product_id.length;i++){
							PurchaseOrderItemBean been=new PurchaseOrderItemBean();
							been.setOrder_id(order_id);
							been.setProduct_id(Integer.parseInt(product_id[i]));
							been.setQuantity((quantity[i]==null || quantity[i].trim().equals(""))?0.0:Double.parseDouble(quantity[i]));
							been.setRate((rate[i]==null || rate[i].trim().equals(""))?0.0:Double.parseDouble(rate[i]));
							pdao.insertPurchaseOrderItem(been);
						}
						
						ses.setAttribute("result", "Po Raised Successfully");
						response.sendRedirect("ViewPurchaseOrder.jsp");
						
					}else{
						ses.setAttribute("result", "<span style='color:red;'>Failed!!</span>");
						response.sendRedirect("ViewPurchaseOrder.jsp");
					}
				}
			}
			
			else if(action.equals("InsertPayment")) {
				int customer_id=Integer.parseInt(request.getParameter("customer_id"));
				double payment_amount=Double.parseDouble(request.getParameter("payment_amount"));
				String payment_type=request.getParameter("payment_mode");
				String check_dd_no=request.getParameter("check_dd_no");
				String check_dd_validity=request.getParameter("check_dd_validity");
				String payment_date=request.getParameter("payment_date");
				String payment_time=request.getParameter("payment_time");
				int mp_id=Integer.parseInt(request.getParameter("mp_id"));
				int site_id=Integer.parseInt(request.getParameter("site_id"));
				String comment=request.getParameter("comment");
				CustomerPaymentBean bean=new CustomerPaymentBean();
				bean.setCustomer_id(customer_id);
				bean.setPayment_amount(payment_amount);
				bean.setPayment_category(payment_type);
				bean.setCheck_dd_number(check_dd_no);
				bean.setCheck_dd_validity(check_dd_validity);
				bean.setPayment_date(payment_date);
				bean.setPayment_time(payment_time);
				bean.setMp_id(mp_id);
				bean.setSite_id(site_id);
				UserDetailBean ubean=(UserDetailBean)ses.getAttribute("bean");
				bean.setUser_name(ubean.getUser_email());
				bean.setComment(comment);
				
				
				int count=paydao.insertPayment(bean);
				
				if(count>0) {
					ses.setAttribute("res", "Payment Added Successfully");
					response.sendRedirect("ViewPayment.jsp");
				}else {
					ses.setAttribute("res", "<span class='text-danger'>Failed!!</span>");
					response.sendRedirect("ViewPayment.jsp");
				}
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
	}

}
