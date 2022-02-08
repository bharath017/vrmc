package com.willka.soft.controller;

import java.io.IOException; 
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;

import com.willka.soft.bean.CustomerQuotationBean;
import com.willka.soft.bean.CustomerQuotationItemBean;
import com.willka.soft.dao.CustomerQuotationDAO;
import com.willka.soft.dao.CustomerQuotationDAOImpl;
import com.willka.soft.dao.SettingDAOImpl;
import com.willka.soft.util.DBUtil;
import com.willka.soft.util.JavaMail;

@WebServlet("/CustomerQuotationController")
public class CustomerQuotationController extends HttpServlet {

	private static final long serialVersionUID = 154L;
	private Connection con=null;
	private PreparedStatement ps=null;
	private ResultSet rs=null;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
		System.out.println("hello world");
		response.setContentType("text/html");
		HttpSession session=request.getSession();
		PrintWriter writer=response.getWriter();
		CustomerQuotationDAO dao=new CustomerQuotationDAOImpl();
		try {
			String action=request.getParameter("action");
			if(action.equals("insert")) {
				synchronized (this) {
					// Get Request Parameter Value
					// Get Customer Quotation
					String customer_name=request.getParameter("customer_name");
					String quotation_date=request.getParameter("quotation_date");
					double pump_charge=(request.getParameter("pump_charge")==null || request.getParameter("pump_charge").trim().equals(""))?0:Double.parseDouble(request.getParameter("pump_charge"));
					double pump_quantity=(request.getParameter("pump_quantity")==null || request.getParameter("pump_quantity").trim().equals(""))?0:Double.parseDouble(request.getParameter("pump_quantity"));
					String site_address=request.getParameter("site_address");
					String customer_phone=request.getParameter("customer_phone");
					String comment=request.getParameter("comment");
					int mp_id=Integer.parseInt(request.getParameter("mp_id"));
					String customer_email=request.getParameter("customer_email");
					String customer_gstin=request.getParameter("customer_gstin");
					
					// Get Customer Quotation Item Details
					String grade_name[]=request.getParameterValues("grade_name");
					String grade_price[]=request.getParameterValues("grade_price");
					String ggbs_price[]=request.getParameterValues("ggbs_price");
					String quantity[]=request.getParameterValues("quantity");
				//	double grade_price[]=Double.parseDouble("grade_price");
					
					//Insert Customer Quotation Details
					CustomerQuotationBean bean=new CustomerQuotationBean();
					bean.setCustomer_name(customer_name);
					bean.setQuotation_date(quotation_date);
					bean.setPump_charge(pump_charge);
					bean.setPump_quantity(pump_quantity);
					bean.setSite_address(site_address);
					bean.setCustomer_phone(customer_phone);
					bean.setComment(comment);
					bean.setMp_id(mp_id);
					bean.setCustomer_email(customer_email);
					bean.setCustomer_gstin(customer_gstin);
					
					//Insert Customer Quotation Grade
					int count=dao.insertCustomerQuotation(bean);
					int quotation_id=dao.getHighestQuotationId();
					if(count>0) {
						for(int i=0;i<grade_name.length;i++)
						{
							CustomerQuotationItemBean been=new CustomerQuotationItemBean();
							been.setGrade_name(grade_name[i]);
							been.setGrade_price((grade_price[i]==null || grade_price[i].trim().equals(""))?0.0:Double.parseDouble(grade_price[i]));
					        been.setGgbs_price((ggbs_price[i]==null || ggbs_price[i].trim().equals(""))?0.0:Double.parseDouble(ggbs_price[i]));
					        been.setQuantity((quantity[i]==null || quantity[i].trim().equals(""))?0.0:Double.parseDouble(quantity[i]));
							been.setQuotation_id(quotation_id);
							dao.insertCustomerQuotationItem(been);
						}
						
						session.setAttribute("res", "Customer Quotation Inserted Successfully");
						response.sendRedirect("CustomerQuotationList.jsp");
					}
					else
					{
						session.setAttribute("res", "<span style='color:red'>Failed!!</span>");
						response.sendRedirect("CustomerQuotationList.jsp");
					}
				}
				
			}
			
			else if(action.equals("UpdateCustomerQuotation")) {
				// Get Request Parameter Value
				// Get Customer Quotation
				int quotation_id=Integer.parseInt(request.getParameter("quotation_id"));
				String customer_name=request.getParameter("customer_name");
				String quotation_date=request.getParameter("quotation_date");
				double pump_charge=Double.parseDouble(request.getParameter("pump_charge"));
				double pump_quantity=Double.parseDouble(request.getParameter("pump_quantity"));
				String site_address=request.getParameter("site_address");
				String customer_phone=request.getParameter("customer_phone");
				String comment=request.getParameter("comment");
				int mp_id=Integer.parseInt(request.getParameter("mp_id"));
				String customer_gstin=request.getParameter("customer_gstin");
				
				// Get Customer Quotation Item Details
				String grade_id[]=request.getParameterValues("grade_id");
				String grade_name[]=request.getParameterValues("grade_name");
				String grade_price[]=request.getParameterValues("grade_price");
				String ggbs_price[]=request.getParameterValues("ggbs_price");
				String quantity[]=request.getParameterValues("quantity");
				
				//Insert Customer Quotation Details
				CustomerQuotationBean bean=new CustomerQuotationBean();
				bean.setCustomer_name(customer_name);
				bean.setQuotation_date(quotation_date);
				bean.setPump_charge(pump_charge);
				bean.setPump_quantity(pump_quantity);
				bean.setSite_address(site_address);
				bean.setCustomer_phone(customer_phone);
				bean.setComment(comment);
				bean.setMp_id(mp_id);
				bean.setQuotation_id(quotation_id);
				bean.setCustomer_gstin(customer_gstin);
				
				//Insert Customer Quotation Grade
				int count=dao.updateCustomerQuotation(bean);
				if(count>0) {
					for(int i=0;i<grade_name.length;i++)
					{
						try {
							CustomerQuotationItemBean been=new CustomerQuotationItemBean();
							been.setGrade_id((grade_id[i]==null || grade_id[i].trim().equals(""))?0:Integer.parseInt(grade_id[i]));
							been.setGrade_name(grade_name[i]);
							been.setGrade_price((grade_price[i]==null || grade_price[i].trim().equals(""))?0.0:Double.parseDouble(grade_price[i]));
							been.setGgbs_price((ggbs_price[i]==null || ggbs_price[i].trim().equals(""))?0.0:Double.parseDouble(ggbs_price[i]));
					        been.setQuotation_id(quotation_id);
					        been.setQuantity((quantity[i]==null || quantity[i].trim().equals(""))?0.0:Double.parseDouble(quantity[i]));
							dao.updateCustomerQuotationItem(been);
						}catch(Exception e) {
							e.printStackTrace();
							CustomerQuotationItemBean been=new CustomerQuotationItemBean();
							been.setGrade_name(grade_name[i]);
							been.setGrade_price((grade_price[i]==null || grade_price[i].trim().equals(""))?0.0:Double.parseDouble(grade_price[i]));
							been.setGgbs_price((ggbs_price[i]==null || ggbs_price[i].trim().equals(""))?0.0:Double.parseDouble(ggbs_price[i]));
							been.setQuantity((quantity[i]==null || quantity[i].trim().equals(""))?0.0:Double.parseDouble(quantity[i]));
					        been.setQuotation_id(quotation_id);
							dao.insertCustomerQuotationItem(been);
						}
					}
					
					session.setAttribute("res", "Customer Quotation Updated Successfully");
					response.sendRedirect("CustomerQuotationList.jsp");
				}
				else
				{
					session.setAttribute("res", "<span style='color:red'>Failed!!</span>");
					response.sendRedirect("CustomerQuotationList.jsp");
				}
				
			}
			
			else if(action.equals("deletequotaion"))
			{
				int quotation_id=Integer.parseInt(request.getParameter("quotation_id"));
				int count = dao.deleteCustomerQuotation(quotation_id);
				if (count > 0) {
					session.setAttribute("res", "Customer Deleted");
					response.sendRedirect("CustomerQuotationList.jsp");
				} else {
					session.setAttribute("res", "Failed");
					response.sendRedirect("CustomerQuotationList.jsp");
				}

			}
			
			else if(action.equals("sendMail")) {
				int quotation_id=Integer.parseInt(request.getParameter("quotation_id"));
				String[] email=request.getParameterValues("email");
				List<String> email_list=Arrays.asList(email);
				CustomerQuotationBean bean=dao.getSingleCustomerQuotaionDetails(quotation_id);
				String val=request.getRequestURI();
				String url = request.getScheme()
					      + "://"
					      + request.getServerName()
					      + ":"
					      + request.getServerPort()+"/"
					      + val.substring(1,val.substring(1).indexOf("/")+1)+"/PrintCustomerQuotation.jsp?quotation_id=";
				bean.setHost(url);
				boolean send=JavaMail.sendEmail(bean, email_list,new SettingDAOImpl().getMailSetting());
				
			  if(send) { 
				  session.setAttribute("res", "Mail send successfully");
				  response.sendRedirect("CustomerQuotationList.jsp");
			  }else
			  {
			  session.setAttribute("res",
			  "<span style='color:red;'>Mail sending failed!!</span>");
			  response.sendRedirect("CustomerQuotationList.jsp"); 
			  }
				 
				
				
			}
			
			else if(action.equals("getQuotationDetails")) {
				response.setContentType("application/json");
				response.setCharacterEncoding("UTF-8");
				int user_id=Integer.parseInt(request.getParameter("user_id"));
				String date=request.getParameter("date");
				JSONArray array=new JSONArray();
				con=DBUtil.getConnection();
				ps=con.prepareStatement("select qi.*,q.customer_name,q.site_address,date(q.quotation_date) as quotation_date from customer_quotation_item qi left join customer_quotation q on q.quotation_id=qi.quotation_id where q.mp_id=? and date(q.quotation_date)=? ");
				ps.setInt(1, user_id);
				ps.setString(2, date);
				rs=ps.executeQuery();
				while(rs.next()) {
					JSONObject object=new JSONObject();
					object.put("date", rs.getString("quotation_date"));
					object.put("customer_name", rs.getString("customer_name"));
					object.put("site_address", rs.getString("site_address"));
					object.put("grade", rs.getString("grade_name"));
					object.put("quantity", rs.getDouble("quantity"));
					object.put("price", rs.getDouble("grade_price"));
					array.put(object);
				}
				writer.println(array);
			}
			
			
			else if(action.equals("changeStatus"))
			{
				int quotation_id=Integer.parseInt(request.getParameter("quotation_id"));
				String status=request.getParameter("status");
				int count=dao.statusCustomerQuotation(quotation_id,status);
				if (count > 0) {
					session.setAttribute("res", "Approved Successfully");
					response.sendRedirect("CustomerQuotationList.jsp");
				} else {
					session.setAttribute("res", "Failed");
					response.sendRedirect("CustomerQuotationList.jsp");
				}
			}
			
			
		}
		
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
	}
}
