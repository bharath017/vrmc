package com.willka.soft.test.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.willka.soft.test.bean.SalesDocumentBean;
import com.willka.soft.test.bean.SalesDocumentItemBean;
import com.willka.soft.test.dao.CustomerDaoImpl;
import com.willka.soft.test.dao.SalesDocumentDAO;
import com.willka.soft.test.dao.SalesDocumentDAOImpl;
import com.willka.soft.util.DBUtil;
import com.willka.soft.util.IndianDateFormater;


/**
 * Servlet implementation class SalesDocumentController
 */
@WebServlet("/SalesDocumentControllerTest")
public class SalesDocumentController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private PreparedStatement ps=null;
	private ResultSet rs=null;
	private Connection con=null;
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		PrintWriter writer=response.getWriter();
		HttpSession session=request.getSession();
		SalesDocumentDAO dao=new SalesDocumentDAOImpl();
		CustomerDaoImpl cdao=new CustomerDaoImpl();
		try {
				String action=request.getParameter("action");
				if(action.equals("InsertDocument")) {
					synchronized (request) {
						int customer_id=Integer.parseInt(request.getParameter("customer_id"));
						int plant_id=Integer.parseInt(request.getParameter("plant_id"));
						int site_id=Integer.parseInt(request.getParameter("site_id"));
						String invoice_date=IndianDateFormater.
											converToIndianFormat(request.getParameter("invoice_date"));
						String invoice_time=request.getParameter("invoice_time");
						String vehicle_no=request.getParameter("vehicle_no");
						String driver_name=request.getParameter("driver_name");
						Map<String,Integer> data=IndianDateFormater.getFinancialYearByDate(request.getParameter("invoice_date"));
						int invoice_id=dao.getLastInvoiceNo(plant_id, data.get("start_year"), data.get("end_year"));
						int count=Integer.parseInt(request.getParameter("count"));
						
						SalesDocumentBean  bean=new SalesDocumentBean();
						bean.setCustomer_id(customer_id);
						bean.setPlant_id(plant_id);
						bean.setSite_id(site_id);
						bean.setInvoice_date(invoice_date);
						bean.setInvoice_time(invoice_time);
						bean.setVehicle_no(vehicle_no);
						bean.setDriver_name(driver_name);
						bean.setInvoice_id(invoice_id);
						bean.setStart_year(data.get("start_year"));
						bean.setEnd_year(data.get("end_year"));
						
						
						int cnt=dao.insertSalesDocument(bean);
						int id=dao.getMaxId();
						int vv=0;
						
						if(cnt>0) {
							for(int i=0;i<count;i++) {
								SalesDocumentItemBean been=new SalesDocumentItemBean();
								been.setPoi_id(Integer.parseInt(request.getParameter("poi_id["+i+"]")));
								been.setItem_quantity(Double.parseDouble(request.getParameter("quantity["+i+"]"))); 
								been.setItem_price(Double.parseDouble(request.getParameter("rate["+i+"]")));
								been.setGross_price(Double.parseDouble(request.getParameter("gross_amount["+i+"]")));
								been.setTax_price(Double.parseDouble(request.getParameter("tax_amount["+i+"]")));
								been.setNet_price(Double.parseDouble(request.getParameter("net_amount["+i+"]")));
								been.setId(id);
								dao.insertSalesDocumentItem(been);
								vv++;
							}
						}
						
						if(vv>0) {
							session.setAttribute("res", "Invoice Id : "+invoice_id+" Added Successfully");
							response.sendRedirect("gst/SalesDocumentList.jsp");
						}else {
							session.setAttribute("res", "<span class='text-danger'>Failed!!</span>");
							response.sendRedirect("gst/SalesDocumentList.jsp");
						}
					}
				}
				
				
				else if(action.equals("getSalesDocumentList")) {
					response.setContentType("application/json");
					response.setCharacterEncoding("utf-8");
					Gson gson = new Gson();
					String from_date = request.getParameter("from_date");
					String to_date = request.getParameter("to_date");
					from_date=(from_date==null || from_date.trim().equals(""))?
							"":IndianDateFormater.converToIndianFormat(from_date);
					to_date=(to_date==null || to_date.trim().equals(""))?"":
								IndianDateFormater.converToIndianFormat(to_date);
					int customer_id=Integer.parseInt(request.getParameter("customer_id"));
					int site_id=Integer.parseInt(request.getParameter("site_id"));
					int business_id=Integer.parseInt(request.getParameter("business_id"));
					int plant_id=Integer.parseInt(request.getParameter("plant_id"));
					String invoice_id = request.getParameter("invoice_id");
					int start = Integer.parseInt(request.getParameter("start"));
					int length = Integer.parseInt(request.getParameter("length"));
					Map<String, Object> data = new HashMap<>();
					int draw = Integer.parseInt(request.getParameter("draw"));
					data.put("data", dao.getSalesDocumentList(customer_id, site_id, from_date, to_date,
							invoice_id, plant_id, business_id, start, length));
					data.put("draw", draw);
					int recordCount = dao.countSalesDocumentList(customer_id, site_id, from_date,
							to_date, invoice_id, plant_id, business_id);
					data.put("recordsTotal", recordCount);
					data.put("recordsFiltered", recordCount);
					writer.print(gson.toJson(data));
				}
				
				
				else if(action.equals("getInvoiceNo")) {
					int plant_id=Integer.parseInt(request.getParameter("plant_id"));
					Calendar c=Calendar.getInstance();
					int month=c.get(Calendar.MONTH);
					int start_year=(month>=3)?c.get(Calendar.YEAR):c.get(Calendar.YEAR)-1;
					int end_year=(month>=3)?c.get(Calendar.YEAR)+1:c.get(Calendar.YEAR);
					int invoice_no=dao.getLastInvoiceNo(plant_id, start_year, end_year);
					writer.println(invoice_no);
				}
				
			
				
				else if(action.equals("CancelInvoice")) {
					int id=Integer.parseInt(request.getParameter("id"));
					int count=dao.cancelSalesDocument(id);
					writer.println(count);
				}
				
				
				else if(action.equals("updateSalesDocument")) {
					synchronized (request) {
						int id=Integer.parseInt(request.getParameter("id"));
						int customer_id=Integer.parseInt(request.getParameter("customer_id"));
						int plant_id=Integer.parseInt(request.getParameter("plant_id"));
						int site_id=Integer.parseInt(request.getParameter("site_id"));
						String invoice_date=IndianDateFormater.
											converToIndianFormat(request.getParameter("invoice_date"));
						String invoice_time=request.getParameter("invoice_time");
						String vehicle_no=request.getParameter("vehicle_no");
						String driver_name=request.getParameter("driver_name");
						Map<String,Integer> data=IndianDateFormater.getFinancialYearByDate(request.getParameter("invoice_date"));
						String invoice_id=request.getParameter("invoice_no");
						int count=Integer.parseInt(request.getParameter("count"));
						
						SalesDocumentBean  bean=new SalesDocumentBean();
						bean.setCustomer_id(customer_id);
						bean.setPlant_id(plant_id);
						bean.setSite_id(site_id);
						bean.setInvoice_date(invoice_date);
						bean.setInvoice_time(invoice_time);
						bean.setVehicle_no(vehicle_no);
						bean.setDriver_name(driver_name);
						bean.setStart_year(data.get("start_year"));
						bean.setEnd_year(data.get("end_year"));
						bean.setId(id);
						
						int cnt=dao.updateSalesDocument(bean);
						int vv=0;
						
						if(cnt>0) {
							for(int i=0;i<count;i++) {
								try {
									SalesDocumentItemBean been=new SalesDocumentItemBean();
									been.setSditem_id(Integer.parseInt(request.getParameter("sditem_id["+i+"]")));
									been.setPoi_id(Integer.parseInt(request.getParameter("poi_id["+i+"]")));
									been.setItem_quantity(Double.parseDouble(request.getParameter("quantity["+i+"]"))); 
									been.setItem_price(Double.parseDouble(request.getParameter("rate["+i+"]")));
									been.setGross_price(Double.parseDouble(request.getParameter("gross_amount["+i+"]")));
									been.setTax_price(Double.parseDouble(request.getParameter("tax_amount["+i+"]")));
									been.setNet_price(Double.parseDouble(request.getParameter("net_amount["+i+"]")));
									been.setId(id);
									dao.updateSalesDocumentItem(been);
									vv++;
								}catch(Exception e) {
									e.printStackTrace();
									SalesDocumentItemBean been=new SalesDocumentItemBean();
									been.setPoi_id(Integer.parseInt(request.getParameter("poi_id["+i+"]")));
									been.setItem_quantity(Double.parseDouble(request.getParameter("quantity["+i+"]"))); 
									been.setItem_price(Double.parseDouble(request.getParameter("rate["+i+"]")));
									been.setGross_price(Double.parseDouble(request.getParameter("gross_amount["+i+"]")));
									been.setTax_price(Double.parseDouble(request.getParameter("tax_amount["+i+"]")));
									been.setNet_price(Double.parseDouble(request.getParameter("net_amount["+i+"]")));
									been.setId(id);
									dao.insertSalesDocumentItem(been);
									vv++;
								}
							}
						}
						
						if(vv>0) {
							session.setAttribute("res", "Invoice Id : "+invoice_id+" updated Successfully");
							response.sendRedirect("gst/SalesDocumentList.jsp");
						}else {
							session.setAttribute("res", "<span class='text-danger'>Failed!!</span>");
							response.sendRedirect("gst/SalesDocumentList.jsp");
						}
						
					}
				}
				
				else if(action.equals("deleteSalesDocumentSingleItem")) {
					int sditem_id=Integer.parseInt(request.getParameter("sditem_id"));
					int count=dao.deleteSingleSalesDocumentItem(sditem_id);
					writer.println(count);
				}
				
				else if(action.equals("TallyXml")) {
					System.out.println("it's coming here");
					//set setting here
					response.setContentType("application/json");
					response.setCharacterEncoding("UTF-8");
					Gson gson=new Gson();
					
					String report_type=request.getParameter("report_type");
					String from_date=request.getParameter("from_date");
					from_date=(from_date==null || from_date.trim().equals(""))?
							"":IndianDateFormater.converToIndianFormat(from_date);
					String to_date=request.getParameter("to_date");
					to_date=(to_date==null || to_date.trim().equals(""))?
							"":IndianDateFormater.converToIndianFormat(to_date);
					int plant_id=(request.getParameter("plant_id")==null || request.getParameter("plant_id").trim().equals(""))
								?0:Integer.parseInt(request.getParameter("plant_id"));
					con=DBUtil.getConnection();
					if(report_type.equals("date")) {
						ps=con.prepareStatement("select i.id,i.invoice_id,i.site_id,"+
								" c.customer_name,s.site_name,s.site_address,"+
								" s.tally_ladger" + 
								" from test_sales_document i LEFT JOIN (test_customer c,plant p,test_site_detail s)" + 
								" ON i.customer_id=c.customer_id" + 
								" and i.site_id=s.site_id"+
								" and i.plant_id=p.plant_id" + 
								" where i.invoice_date between ? and ?" + 
								" and i.plant_id like if(0=?,'%%',?)" + 
								" and i.invoice_status='active'" + 
								" order by id asc");
						ps.setString(1, from_date);
						ps.setString(2, to_date);
						ps.setInt(3, plant_id);
						ps.setInt(4, plant_id);
					}
					
					rs=ps.executeQuery();
					HashMap<Integer, Object> tallyladger=new HashMap<>();
					while(rs.next()) {
						HashMap<String, String> map=new HashMap<>();
						if(rs.getString("tally_ladger")==null || rs.getString("tally_ladger").trim().equals("")) {
							map.put("name", rs.getString("customer_name"));
							map.put("address", rs.getString("site_address"));
							tallyladger.put(rs.getInt("site_id"), map);
						}
					}
					writer.println(gson.toJson(tallyladger));
				}
				
				
				else if(action.equals("UpdateTallyLedger")) {
					String[] site_id=request.getParameterValues("site_id");
					String[] tally_ladger=request.getParameterValues("tally_ladger");
					for(int i=0;i<site_id.length;i++) {
						cdao.updateTallyLedger(Integer.parseInt(site_id[i]), tally_ladger[i]);
					}
					response.sendRedirect("gst/SalesDocumentReportBulk.jsp");
				}
				
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}

}
