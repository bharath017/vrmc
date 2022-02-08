package com.willka.soft.test.controller;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Calendar;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.willka.soft.test.bean.ConsolidateInvoiceBean;
import com.willka.soft.test.bean.InvoiceBean;
import com.willka.soft.test.bean.InvoiceModificationBean;
import com.willka.soft.bean.ConsolidateInvoiceItemBean;
import com.willka.soft.bean.UserDetailBean;
import com.willka.soft.test.dao.CustomerDAO;
import com.willka.soft.test.dao.CustomerDaoImpl;
import com.willka.soft.test.dao.InvoiceDAO;
import com.willka.soft.test.dao.InvoiceDAOImpl;
import com.willka.soft.util.DBUtil;

/**
 * Servlet implementation class InvoiceController
 */
@WebServlet("/InvoiceControllerTest")
public class InvoiceController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private Connection con=null;
    private PreparedStatement ps=null;
    private ResultSet rs=null;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request,response);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session=request.getSession();
		InvoiceDAO dao=new InvoiceDAOImpl();
		CustomerDAO cdao=new CustomerDaoImpl();
		PrintWriter writer=response.getWriter();
		try {
			String action=request.getParameter("action");
			
			if(action.equals("InsertInvoice")) {
				int plant_id=Integer.parseInt(request.getParameter("plant_id"));
				int customer_id=Integer.parseInt(request.getParameter("customer_id"));
				int site_id=Integer.parseInt(request.getParameter("site_id"));
				int poi_id=Integer.parseInt(request.getParameter("poi_id"));
				String invoice_date=request.getParameter("invoice_date");
				String invoice_time=request.getParameter("invoice_time");
				double rate=Double.parseDouble(request.getParameter("rate"));
				double quantity=Double.parseDouble(request.getParameter("quantity"));
				double gross_amount=Double.parseDouble(request.getParameter("gross_price"));
				double tax_amount=Double.parseDouble(request.getParameter("tax_price"));
				double net_amount=Double.parseDouble(request.getParameter("net_price"));
				String vehicle_no=request.getParameter("vehicle_no");
				String pump=request.getParameter("pump");
				String driver_name=request.getParameter("driver_name");
				int invoice_id=(request.getParameter("invoice_id")==null || request.getParameter("invoice_id").trim().equals(""))?0:Integer.parseInt(request.getParameter("invoice_id"));
				double km_reading=Double.parseDouble(request.getParameter("km_reading"));
				
				
				InvoiceBean bean=new InvoiceBean();
				bean.setPlant_id(plant_id);
				bean.setCustomer_id(customer_id);
				bean.setSite_id(site_id);
				bean.setPoi_id(poi_id);
				bean.setInvoice_date(invoice_date);
				bean.setInvoice_time(invoice_time);
				bean.setRate(rate);
				bean.setQuantity(quantity);
				bean.setGross_amount(gross_amount);
				bean.setTax_amount(tax_amount);
				bean.setNet_amount(net_amount);
				bean.setVehicle_no(vehicle_no);
				bean.setPump(pump);
				bean.setDriver_name(driver_name);
				bean.setInvoice_id(invoice_id);
				bean.setKm_reading(km_reading);
				
				int count=dao.insertInvoice(bean);
				
				if(count>0) {
					session.setAttribute("res", "Invoice Id "+count+" generated succesfully");
					response.sendRedirect("gst/InvoiceList.jsp");
				}else {
					session.setAttribute("res", "<span class='text-danger'>Failed!!</span>");
					response.sendRedirect("gst/InvoiceList.jsp");
				}
			}
			
			else if(action.equals("UpdateVehicle")) {
				int id=Integer.parseInt(request.getParameter("id"));
				String vehicle_no=request.getParameter("vehicle_no");
				String driver_name=request.getParameter("driver_name");
				String pump=request.getParameter("pump");
				String comment=request.getParameter("comment");
				int invoice_id=Integer.parseInt(request.getParameter("invoice_id"));
				//now update 
				int count=dao.updateVehiclePumpDetails(id, vehicle_no, driver_name, pump);
				if(count>0) {
					InvoiceModificationBean bean=new InvoiceModificationBean();
					bean.setComment(comment);
					bean.setInvoice_id(invoice_id);
					bean.setModification_type("update");
					
					//get user name
					UserDetailBean been=(UserDetailBean)session.getAttribute("bean");
					bean.setModification_user(been.getUsername());
					dao.insertInvoiceModification(bean);
					session.setAttribute("res", "Updated Successfully");
					response.sendRedirect("gst/InvoiceList.jsp");
				}else {
					session.setAttribute("res", "<span class='text-danger'>Failed</span>");
					response.sendRedirect("gst/InvoiceList.jsp");
				}
			}
			
			else if(action.equals("UpdateDateTime")) {
				int id=Integer.parseInt(request.getParameter("id"));
				String invoice_date=request.getParameter("invoice_date");
				String invoice_time=request.getParameter("invoice_time");
				String comment=request.getParameter("comment");
				int invoice_id=Integer.parseInt(request.getParameter("invoice_id"));
				//now update 
				int count=dao.updateInvoiceDateTime(id, invoice_date, invoice_time);
				if(count>0) {
					InvoiceModificationBean bean=new InvoiceModificationBean();
					bean.setComment(comment);
					bean.setInvoice_id(invoice_id);
					bean.setModification_type("update");
					//get user name
					UserDetailBean been=(UserDetailBean)session.getAttribute("bean");
					bean.setModification_user(been.getUsername());
					dao.insertInvoiceModification(bean);
					session.setAttribute("res", "Updated Successfully");
					response.sendRedirect("gst/InvoiceList.jsp");
				}else {
					session.setAttribute("res", "<span class='text-danger'>Failed</span>");
					response.sendRedirect("gst/InvoiceList.jsp");
				}
				
			}
			
			else if(action.equals("UpdateInvoice")) {
				int id=Integer.parseInt(request.getParameter("id"));
				int invoice_id=Integer.parseInt(request.getParameter("invoice_id"));
				int plant_id=Integer.parseInt(request.getParameter("plant_id"));
				int customer_id=Integer.parseInt(request.getParameter("customer_id"));
				int site_id=Integer.parseInt(request.getParameter("site_id"));
				int poi_id=Integer.parseInt(request.getParameter("poi_id"));
				String invoice_date=request.getParameter("invoice_date");
				String invoice_time=request.getParameter("invoice_time");
				double rate=Double.parseDouble(request.getParameter("rate"));
				double quantity=Double.parseDouble(request.getParameter("quantity"));
				double gross_amount=Double.parseDouble(request.getParameter("gross_price"));
				double tax_amount=Double.parseDouble(request.getParameter("tax_price"));
				double net_amount=Double.parseDouble(request.getParameter("net_price"));
				String vehicle_no=request.getParameter("vehicle_no");
				String pump=request.getParameter("pump");
				String driver_name=request.getParameter("driver_name");
				String comment=request.getParameter("comment");
				Double km_reading=Double.parseDouble(request.getParameter("km_reading"));
				
				InvoiceBean bean=new InvoiceBean();
				bean.setPlant_id(plant_id);
				bean.setCustomer_id(customer_id);
				bean.setSite_id(site_id);
				bean.setPoi_id(poi_id);
				bean.setInvoice_date(invoice_date);
				bean.setInvoice_time(invoice_time);
				bean.setRate(rate);
				bean.setQuantity(quantity);
				bean.setGross_amount(gross_amount);
				bean.setTax_amount(tax_amount);
				bean.setNet_amount(net_amount);
				bean.setVehicle_no(vehicle_no);
				bean.setPump(pump);
				bean.setDriver_name(driver_name);
				bean.setId(id);
				bean.setInvoice_id(invoice_id);
				bean.setKm_reading(km_reading);
				
				int count=dao.updateFullInvoice(bean);
				
				if(count>0) {
					InvoiceModificationBean been=new InvoiceModificationBean();
					been.setComment(comment);
					been.setInvoice_id(invoice_id);
					been.setModification_type("update");
					//get user name
					UserDetailBean bein=(UserDetailBean)session.getAttribute("bean");
					been.setModification_user(bein.getUsername());
					dao.insertInvoiceModification(been);
					session.setAttribute("res", "Invoice Id "+invoice_id+" Updated succesfully");
					response.sendRedirect("gst/InvoiceList.jsp");
				}else {
					session.setAttribute("res", "<span class='text-danger'>Failed!!</span>");
					response.sendRedirect("gst/InvoiceList.jsp");
				}
			}
			
			
			else if(action.equals("CancelInvoice")) {
				int invoice_id=Integer.parseInt(request.getParameter("invoice_id"));
				int id=Integer.parseInt(request.getParameter("id"));
				String comment=request.getParameter("comment");
				int count=dao.cancelInvoice(id);
				
				if(count>0) {
					InvoiceModificationBean bean=new InvoiceModificationBean();
					bean.setComment(comment);
					bean.setInvoice_id(invoice_id);
					bean.setModification_type("cancel");
					//get user name
					UserDetailBean been=(UserDetailBean)session.getAttribute("bean");
					bean.setModification_user(been.getUsername());
					dao.insertInvoiceModification(bean);
					session.setAttribute("res", "Invoice Id : "+invoice_id+" Cancelled");
					response.sendRedirect("gst/InvoiceList.jsp");
				}else {
					session.setAttribute("res", "<span class='text-danger'>Failed!!</span>");
					response.sendRedirect("gst/InvoiceList.jsp");
				}
			}
			
			else if(action.equals("generatecons")) {
				synchronized (this) {
					int customer_id=Integer.parseInt(request.getParameter("customer_id"));
					double advance_amount=(request.getParameter("advance_amount")==null || request.getParameter("advance_amount").trim().equals(""))?0:Double.parseDouble(request.getParameter("advance_amount"));
					double pump_charge=Double.parseDouble(request.getParameter("pump_charge"));
					int plant_id=Integer.parseInt(request.getParameter("plant_id"));
					String[] idd=request.getParameterValues("idd");
					
					ConsolidateInvoiceBean bean=new ConsolidateInvoiceBean();
					bean.setCustomer_id(customer_id);
					bean.setAdvance_amount(advance_amount);
					bean.setPump_charge(pump_charge);
					bean.setPlant_id(plant_id);
					
					
					int count=dao.generateConsolidateInvoice(bean);
					
					if(count>0) {
						//get max consolidate invoice id
						int consolidate_invoice_id=dao.getMaxConsolidateInvoiceId();
						for(int i=0;i<idd.length;i++) {
							ConsolidateInvoiceItemBean ibean=new ConsolidateInvoiceItemBean();
							ibean.setConsolidate_invoice_id(consolidate_invoice_id);
							ibean.setId(Integer.parseInt(idd[i]));
							dao.addConsolidateInvoiceItem(ibean);
						}
						session.setAttribute("result", "Consolidate Invoice Generated Successfully");
						response.sendRedirect("gst/ConsolidateInvoiceList.jsp");
					}else {
						session.setAttribute("result", "<span class='text-danger'>Failed!!!</span>");
						response.sendRedirect("gst/ConsolidateInvoiceList.jsp");
					}
				}
			}
			
			
			
			
			else if(action.equals("cancelConsolidateInvoice")) {
				int consolidate_invoice_id=Integer.parseInt(request.getParameter("consolidate_invoice_id"));
				int count=dao.cancelConsolidateInvoice(consolidate_invoice_id);
				
				if(count>0) {
					session.setAttribute("res", "Invoice Id : "+consolidate_invoice_id+" Cancelled Successfully");
					response.sendRedirect("gst/ConsolidateInvoiceList.jsp");
				}
				else {
					session.setAttribute("res", "<span class='text-danger'>Failed!!</span>");
					response.sendRedirect("gst/ConsolidateInvoiceList.jsp");
				}
			}
			
			else if(action.equals("RefreshInvoice")) {
				int id=Integer.parseInt(request.getParameter("id"));
				int count=dao.refreshInvoice(id);
				if(count>0) {
					session.setAttribute("res", "Invoice Refreshed Successfully");
					response.sendRedirect("gst/InvoiceList.jsp");
				}else {
					session.setAttribute("res", "Failed!!");
					response.sendRedirect("gst/InvoiceList.jsp");
				}
			}
			
			
			else if(action.equals("DeleteInvoice")) {
				int invoice_id=Integer.parseInt(request.getParameter("invoice_id"));
				int id=Integer.parseInt(request.getParameter("id"));
				String comment=request.getParameter("comment");
				int count=dao.deleteInvoice(id, invoice_id);
				
				if(count>0) {
					InvoiceModificationBean bean=new InvoiceModificationBean();
					bean.setComment(comment);
					bean.setInvoice_id(invoice_id);
					bean.setModification_type("Delete");
					//get user name
					UserDetailBean been=(UserDetailBean)session.getAttribute("bean");
					bean.setModification_user(been.getUsername());
					dao.insertInvoiceModification(bean);
					session.setAttribute("res", "Invoice Id : "+invoice_id+" Deleted");
					response.sendRedirect("gst/InvoiceList.jsp");
				}else {
					session.setAttribute("res", "<span class='text-danger'>Failed!!</span>");
					response.sendRedirect("gst/InvoiceList.jsp");
				}
			}
			
			else if(action.equals("TallyXml")) {
				//set setting here
				response.setContentType("application/json");
				response.setCharacterEncoding("UTF-8");
				Gson gson=new Gson();
				
				String report_type=request.getParameter("report_type");
				String from_date=request.getParameter("from_date");
				String to_date=request.getParameter("to_date");
				int product_id=(request.getParameter("product_id")==null || request.getParameter("product_id").trim().equals(""))?0:Integer.parseInt(request.getParameter("product_id"));
				int plant_id=(request.getParameter("plant_id")==null || request.getParameter("plant_id").trim().equals(""))?0:Integer.parseInt(request.getParameter("plant_id"));
				int customer_id=(request.getParameter("customer_id")==null || request.getParameter("customer_id").trim().equals("") || request.getParameter("customer_id").trim().equals("undefined"))?0:Integer.parseInt(request.getParameter("customer_id"));
				int site_id=(request.getParameter("site_id")==null || request.getParameter("site_id").trim().equals("")  || request.getParameter("site_id").trim().equals("undefined"))?0:Integer.parseInt(request.getParameter("site_id"));
				String vehicle_no=request.getParameter("vehicle_no");
				
				con=DBUtil.getConnection();
				
				if(report_type.equals("date")) {
					ps=con.prepareStatement("select i.*,c.customer_name,s.site_name,s.site_address,s.tally_ladger,pr.product_name,pr.product_id,p.plant_name,m.mp_name" + 
							" from test_invoice i LEFT JOIN (test_customer c,test_site_detail s,test_purchase_order_item poi,product pr,plant p,test_purchase_order po,marketing_person m)" + 
							" ON i.customer_id=c.customer_id" + 
							" and i.site_id=s.site_id" + 
							" and i.poi_id=poi.poi_id" + 
							" and poi.order_id=poi.order_id" + 
							" and poi.product_id=pr.product_id" + 
							" and i.plant_id=p.plant_id" + 
							" and poi.order_id=po.order_id" + 
							" and po.marketing_person_id=m.mp_id" + 
							" where i.invoice_date between ? and ?" + 
							" and pr.product_id like if(0=?,'%%',?)" + 
							" and i.plant_id like if(0=?,'%%',?)" + 
							" and i.invoice_status='active'" + 
							" order by id asc");
					ps.setString(1, from_date);
					ps.setString(2, to_date);
					ps.setInt(3, product_id);
					ps.setInt(4, product_id);
					ps.setInt(5, plant_id);
					ps.setInt(6, plant_id);
				}else if(report_type=="customer") {
					ps=con.prepareStatement("select i.*,c.customer_name,s.site_name,s.site_address,s.tally_ladger,pr.product_name,pr.product_id,p.plant_name,m.mp_name" + 
							"  from test_invoice i LEFT JOIN (test_customer c,test_site_detail s,test_purchase_order_item poi,product pr,plant p,test_purchase_order po,marketing_person m)" + 
							"  ON i.customer_id=c.customer_id" + 
							"  and i.site_id=s.site_id" + 
							"  and i.poi_id=poi.poi_id" + 
							"  and poi.order_id=poi.order_id" + 
							"  and poi.product_id=pr.product_id" + 
							"  and i.plant_id=p.plant_id" + 
							"  and poi.order_id=po.order_id" + 
							"  and po.marketing_person_id=m.mp_id" + 
							"  where i.customer_id like if(0=?,'%%',?)" + 
							"  and i.site_id like if(0=?,'%%',?)" + 
							"  and pr.product_id like if(0=?,'%%',?)" + 
							"  and i.plant_id like if(0=?,'%%',?)" + 
							"  and i.invoice_status='active'" + 
							"  order by id asc");
					ps.setInt(1, customer_id);
					ps.setInt(2, customer_id);
					ps.setInt(3, site_id);
					ps.setInt(4, site_id);
					ps.setInt(5, product_id);
					ps.setInt(6, product_id);
					ps.setInt(7, plant_id);
					ps.setInt(8, plant_id);
				}else if(report_type=="vehicle") {
					ps=con.prepareStatement("select i.*,c.customer_name,s.site_name,s.site_address,s.tally_ladger,pr.product_name,pr.product_id,p.plant_name,m.mp_name" + 
							" from test_invoice i LEFT JOIN (test_customer c,test_site_detail s,test_purchase_order_item poi,product pr,plant p,test_purchase_order po,marketing_person m)" + 
							" ON i.customer_id=c.customer_id" + 
							" and i.site_id=s.site_id" + 
							" and i.poi_id=poi.poi_id" + 
							" and poi.order_id=poi.order_id" + 
							" and poi.product_id=pr.product_id" + 
							" and i.plant_id=p.plant_id" + 
							" and poi.order_id=po.order_id" + 
							" and po.marketing_person_id=m.mp_id" + 
							" where i.vehicle_no like if(''=?,'%%',?)" + 
							" and pr.product_id like if(0=?,'%%',?)" + 
							" and i.plant_id like if(0=?,'%%',?)" + 
							" and i.invoice_status='active'" + 
							" order by id asc");
					ps.setString(1, vehicle_no);
					ps.setString(2, vehicle_no);
					ps.setInt(3, product_id);
					ps.setInt(4, product_id);
					ps.setInt(5, plant_id);
					ps.setInt(6, plant_id);
				}else if(report_type=="customerdate") {
					ps=con.prepareStatement("select i.*,c.customer_name,s.site_name,s.site_address,s.tally_ladger,pr.product_name,pr.product_id,p.plant_name,m.mp_name" + 
							" from test_invoice i LEFT JOIN (test_customer c,test_site_detail s,test_purchase_order_item poi,product pr,plant p,test_purchase_order po,marketing_person m)" + 
							" ON i.customer_id=c.customer_id" + 
							" and i.site_id=s.site_id" + 
							" and i.poi_id=poi.poi_id" + 
							" and poi.order_id=poi.order_id" + 
							" and poi.product_id=pr.product_id" + 
							" and i.plant_id=p.plant_id" + 
							" and poi.order_id=po.order_id" + 
							" and po.marketing_person_id=m.mp_id" + 
							" where i.customer_id like if(0=?,'%%',?)" + 
							" and i.site_id like if(0=?,'%%',?)" + 
							" and pr.product_id like if(0=?,'%%',?)" + 
							" and i.plant_id like if(0=?,'%%',?)" + 
							" and i.invoice_date between ? and ?" + 
							" and i.invoice_status='active'" + 
							" order by id asc");
					ps.setInt(1, customer_id);
					ps.setInt(2, customer_id);
					ps.setInt(3, site_id);
					ps.setInt(4, site_id);
					ps.setInt(5, product_id);
					ps.setInt(6, product_id);
					ps.setInt(7, plant_id);
					ps.setInt(8, plant_id);
					ps.setString(9, from_date);
					ps.setString(10, to_date);
				}else if(report_type=="vehicledate") {
					ps=con.prepareStatement("select i.*,c.customer_name,s.site_name,s.site_address,s.tally_ladger,pr.product_name,pr.product_id,p.plant_name,m.mp_name" + 
							" from test_invoice i LEFT JOIN (test_customer c,test_site_detail s,test_purchase_order_item poi,product pr,plant p,test_purchase_order po,marketing_person m)" + 
							" ON i.customer_id=c.customer_id" + 
							" and i.site_id=s.site_id" + 
							" and i.poi_id=poi.poi_id" + 
							" and poi.order_id=poi.order_id" + 
							" and poi.product_id=pr.product_id" + 
							" and i.plant_id=p.plant_id" + 
							" and poi.order_id=po.order_id" + 
							" and po.marketing_person_id=m.mp_id" + 
							" where i.vehicle_no like if(''=?,'%%',?)" + 
							" and pr.product_id like if(''=?,'%%',?)" + 
							" and i.plant_id like if(''=?,'%%',?)" + 
							" and i.invoice_date between ? and ?" + 
							" and i.invoice_status='active'" + 
							" order by id asc");
					ps.setString(1, vehicle_no);
					ps.setString(2, vehicle_no);
					ps.setInt(3, product_id);
					ps.setInt(4, product_id);
					ps.setInt(5, plant_id);
					ps.setInt(6, plant_id);
					ps.setString(7, from_date);
					ps.setString(8, to_date);
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
			
			
			else if(action.equals("ChangeDocketNo")) {
				int id=Integer.parseInt(request.getParameter("id"));
				String docket_no=request.getParameter("docket_no");
				int count=dao.changeDocketNo(id, docket_no);
				if(count>0) {
					session.setAttribute("res", "Docket Changed Successfully");
					response.sendRedirect("gst/InvoiceList.jsp");
				}else {
					session.setAttribute("res", "<span class='text-danger'>Failed!!!</span>");
					response.sendRedirect("gst/InvoiceList.jsp");
				}
			}
			else if(action.equals("UpdateTallyLedger")) {
				String[] site_id=request.getParameterValues("site_id");
				String[] tally_ladger=request.getParameterValues("tally_ladger");
				for(int i=0;i<site_id.length;i++) {
					cdao.updateTallyLedger(Integer.parseInt(site_id[i]), tally_ladger[i]);
				}
				response.sendRedirect("gst/InvoiceReport.jsp");
			}
			
			
			else if(action.equals("DownloadBatchSheet")) {
				try {
					int id=Integer.parseInt(request.getParameter("id"));
					/*Batchsheet7HillsT t=new Batchsheet7HillsT();
					t.generateBatchSheet(id);*/
					String filepath = this.getServletContext().getRealPath("/reports/batch_sheet.xlsx");
					String fileName="batch_sheet.xlsx";
					FileInputStream filetodownload=new FileInputStream(filepath);
					//ServletOutputStream out=response.getOutputStream();
					response.setContentType("application/vnd.ms-excel");
					response.setHeader("Content-Disposition","attachment; filename="+fileName);
					response.setContentLength(filetodownload.available());
					int c;
					while((c=filetodownload.read())!=-1) {
						writer.write(c);
					}
					writer.flush();
					//out.close();
					filetodownload.close();
					writer.println("BATCH SHEET GENERATED SUCCESSFULLY");
				}catch(Exception e) {
					e.printStackTrace();
					response.sendRedirect("error.jsp");
				}
			}
			
			
			
			
			else if(action.equals("CheckInvoiceNo")) {
				int invoice_id=(request.getParameter("invoice_id")==null || request.getParameter("invoice_id").trim().equals(""))?0:Integer.parseInt(request.getParameter("invoice_id"));
				int plant_id=Integer.parseInt(request.getParameter("plant_id"));
				//get today date
				
				Calendar cal=Calendar.getInstance();
				int month=cal.get(Calendar.MONTH);
				
				int start_year=(month>=4)?cal.get(Calendar.YEAR):cal.get(Calendar.YEAR)-1;
				int end_year=(month>=4)?cal.get(Calendar.YEAR)+1:cal.get(Calendar.YEAR);
				
				//now check if invoice no is exist or not
				boolean exist=dao.checkExistanceOfInvoice(plant_id, invoice_id, start_year, end_year);
				
				if(exist==true) {
					writer.println("exist");
				}
			}
			
			else if(action.equals("showhide")) {
				String state=request.getParameter("click");
				dao.changeInvoiceState(state);
				response.sendRedirect("OtherSetting.jsp");
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}

}
