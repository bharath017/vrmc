package com.willka.soft.controller;

import java.io.FileInputStream;    
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.willka.soft.bean.ConsolidateInvoiceBean;
import com.willka.soft.bean.ConsolidateInvoiceItemBean;
import com.willka.soft.bean.DCBean;
import com.willka.soft.bean.DCModificationBean;
import com.willka.soft.bean.InvoiceSMSBean;
import com.willka.soft.bean.UserDetailBean;
import com.willka.soft.dao.CustomerDAO;
import com.willka.soft.dao.CustomerDaoImpl;
import com.willka.soft.dao.DCDAO;
import com.willka.soft.dao.DCDAOImpl;
import com.willka.soft.dao.SMSDAOImpl;
import com.willka.soft.util.Batchsheet_VRMC;
import com.willka.soft.util.DBUtil;
import com.willka.soft.util.FletcherBatchSheet;
import com.willka.soft.util.ShreeConcreteBatchsheet;

/**
 * Servlet implementation class InvoiceController
 */
@WebServlet("/DCController")
public class DCController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private Connection con=null;
    private PreparedStatement ps=null;
    private ResultSet rs=null;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request,response);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session=request.getSession();
		
//		InvoiceDAO dao=new InvoiceDAOImpl();
		DCDAO dao=new DCDAOImpl();
		
		CustomerDAO cdao=new CustomerDaoImpl();
		//SMSDAOImpl sdao=new SMSDAOImpl();
		PrintWriter writer=response.getWriter();
		ServletContext context=request.getServletContext();
		try {
			String action=request.getParameter("action");
			
			if(action.equals("InsertInvoice")) {
				synchronized (request) {
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
					String km_reading=request.getParameter("km_reading");
					String km_reading2=request.getParameter("km_reading2");
					double loaded_quantity=(request.getParameter("loaded_quantity")==null || request.getParameter("loaded_quantity").trim().equals(""))?0.0:Double.parseDouble(request.getParameter("loaded_quantity"));
					int loaded_product_id=(request.getParameter("loaded_product_id")==null || request.getParameter("loaded_product_id").trim().equals(""))?0:Integer.parseInt(request.getParameter("loaded_product_id"));
					String project_block=request.getParameter("project_block");
					
					
					
					DCBean bean=new DCBean();
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
					bean.setKm_reading(km_reading);
					bean.setProject_block(project_block);
					bean.setLoaded_quantity(loaded_quantity);
					bean.setLoaded_product_id(loaded_product_id);
					bean.setKm_reading2(km_reading2);
					
					int count=dao.insertInvoice(bean);
					
					//send sms here
					
					/*
					 * try { int id=dao.getMaxOfId(); String sms=context.getInitParameter("sms");
					 * if(sms.equals("true")) { InvoiceSMSBean
					 * sbean=sdao.getSingleInvoiceDetails(id); sdao.sendSMSForEveryInvoice(sbean); }
					 * }catch(Exception e) { e.printStackTrace(); }
					 */
					
					if(count>0) {
						session.setAttribute("res", "Invoice Id "+count+" generated succesfully");
						response.sendRedirect("DCList.jsp");
					}else {
						session.setAttribute("res", "<span class='text-danger'>Failed!!</span>");
						response.sendRedirect("DCList.jsp");
					}
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
//					InvoiceModificationBean bean=new InvoiceModificationBean();
					DCModificationBean bean=new DCModificationBean();
					bean.setComment(comment);
					bean.setInvoice_id(invoice_id);
					bean.setModification_type("update");
					
					//get user name
					UserDetailBean been=(UserDetailBean)session.getAttribute("bean");
					bean.setModification_user(been.getUsername());
					dao.insertInvoiceModification(bean);
					session.setAttribute("res", "Updated Successfully");
					response.sendRedirect("DCList.jsp");
				}else {
					session.setAttribute("res", "<span class='text-danger'>Failed</span>");
					response.sendRedirect("DCList.jsp");
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
//					InvoiceModificationBean bean=new InvoiceModificationBean();
					DCModificationBean bean=new DCModificationBean();
					bean.setComment(comment);
					bean.setInvoice_id(invoice_id);
					bean.setModification_type("update");
					//get user name
					UserDetailBean been=(UserDetailBean)session.getAttribute("bean");
					bean.setModification_user(been.getUsername());
					dao.insertInvoiceModification(bean);
					session.setAttribute("res", "Updated Successfully");
					response.sendRedirect("DCList.jsp");
				}else {
					session.setAttribute("res", "<span class='text-danger'>Failed</span>");
					response.sendRedirect("DCList.jsp");
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
				String project_block=request.getParameter("project_block");
//				double km_reading=(request.getParameter("km_reading")==null || request.getParameter("km_reading").trim().equals(""))?0.0:Double.parseDouble(request.getParameter("km_reading"));
				String km_reading=request.getParameter("km_reading");
				String km_reading2=request.getParameter("km_reading2");
				double loaded_quantity=(request.getParameter("loaded_quantity")==null || request.getParameter("loaded_quantity").trim().equals(""))?0.0:Double.parseDouble(request.getParameter("loaded_quantity"));
				int loaded_product_id=(request.getParameter("loaded_product_id")==null || request.getParameter("loaded_product_id").trim().equals(""))?0:Integer.parseInt(request.getParameter("loaded_product_id"));
			//	InvoiceBean bean=new InvoiceBean();
				DCBean bean=new DCBean();
				
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
				bean.setProject_block(project_block);
				bean.setKm_reading(km_reading);
				bean.setLoaded_quantity(loaded_quantity);
				bean.setKm_reading2(km_reading2);
				bean.setLoaded_product_id(loaded_product_id);
				int count=dao.updateFullInvoice(bean);
				
				if(count>0) {
//					InvoiceModificationBean been=new InvoiceModificationBean();
					DCModificationBean been=new DCModificationBean();
					been.setComment(comment);
					been.setInvoice_id(invoice_id);
					been.setModification_type("update");
					//get user name
					UserDetailBean bein=(UserDetailBean)session.getAttribute("bean");
					been.setModification_user(bein.getUsername());
					dao.insertInvoiceModification(been);
					session.setAttribute("res", "Invoice Id "+invoice_id+" Updated succesfully");
					response.sendRedirect("DCList.jsp");
				}else {
					session.setAttribute("res", "<span class='text-danger'>Failed!!</span>");
					response.sendRedirect("DCList.jsp");
				}
			}
			
			
			else if(action.equals("CancelInvoice")) {
				int invoice_id=Integer.parseInt(request.getParameter("invoice_id"));
				int id=Integer.parseInt(request.getParameter("id"));
				String comment=request.getParameter("comment");
				int count=dao.cancelInvoice(id);
				
				if(count>0) {
//					InvoiceModificationBean bean=new InvoiceModificationBean();
					DCModificationBean bean= new DCModificationBean();
					bean.setComment(comment);
					bean.setInvoice_id(invoice_id);
					bean.setModification_type("cancel");
					//get user name
					UserDetailBean been=(UserDetailBean)session.getAttribute("bean");
					bean.setModification_user(been.getUsername());
					dao.insertInvoiceModification(bean);
					session.setAttribute("res", "Invoice Id : "+invoice_id+" Cancelled");
					response.sendRedirect("DCList.jsp");
				}else {
					session.setAttribute("res", "<span class='text-danger'>Failed!!</span>");
					response.sendRedirect("DCList.jsp");
				}
			}
			
			else if(action.equals("generatecons")) {
				synchronized (this) {
					int customer_id=Integer.parseInt(request.getParameter("customer_id"));
					double advance_amount=Double.parseDouble(request.getParameter("advance_amount"));
					double pump_charge=Double.parseDouble(request.getParameter("pump_charge"));
					int plant_id=Integer.parseInt(request.getParameter("plant_id"));
					String[] idd=request.getParameterValues("idd");
					String generate_date=request.getParameter("generate_date");
					
					ConsolidateInvoiceBean bean=new ConsolidateInvoiceBean();
					bean.setCustomer_id(customer_id);
					bean.setAdvance_amount(advance_amount);
					bean.setPump_charge(pump_charge);
					bean.setPlant_id(plant_id);
					bean.setGenerate_date(generate_date);
					
					Calendar calendar=Calendar.getInstance();
					//System.out.println(calendar);
					
					int month=calendar.get(Calendar.MONTH);
					int year=calendar.get(Calendar.YEAR);
					
					int start_year=(month>=3)?year:year-1;
					int end_year=(month>=3)?year+1:year;
					//System.out.println(start_year);
					//System.out.println(end_year);
					
					int cons_id=dao.maxConsId(start_year, end_year)+1;
					
					bean.setCons_id(cons_id);
					bean.setStart_year(start_year);
					bean.setEnd_year(end_year);
					
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
						response.sendRedirect("ConsolidateInvoiceList.jsp");
					}else {
						session.setAttribute("result", "<span class='text-danger'>Failed!!!</span>");
						response.sendRedirect("ConsolidateInvoiceList.jsp");
					}
				}
			}
			
			else if(action.equals("cancelConsolidateInvoice")) {
				int consolidate_invoice_id=Integer.parseInt(request.getParameter("consolidate_invoice_id"));
				int count=dao.cancelConsolidateInvoice(consolidate_invoice_id);
				
				if(count>0) {
					session.setAttribute("res", "Invoice Id : "+consolidate_invoice_id+" Deleted Successfully");
					response.sendRedirect("ConsolidateInvoiceList.jsp");
				}
				else {
					session.setAttribute("res", "<span class='text-danger'>Failed!!</span>");
					response.sendRedirect("ConsolidateInvoiceList.jsp");
				}
			}
			
			else if(action.equals("RefreshDC")) {
				int id=Integer.parseInt(request.getParameter("id"));
				int count=dao.refreshDC(id);
				if(count>0) {
					session.setAttribute("res", "DC Refreshed Successfully");
					response.sendRedirect("DCList.jsp");
				}else {
					session.setAttribute("res", "Failed!!");
					response.sendRedirect("DCList.jsp");
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
							" from invoice i LEFT JOIN (customer c,site_detail s,purchase_order_item poi,product pr,plant p,purchase_order po,marketing_person m)" + 
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
							"  from invoice i LEFT JOIN (customer c,site_detail s,purchase_order_item poi,product pr,plant p,purchase_order po,marketing_person m)" + 
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
							" from invoice i LEFT JOIN (customer c,site_detail s,purchase_order_item poi,product pr,plant p,purchase_order po,marketing_person m)" + 
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
							" from invoice i LEFT JOIN (customer c,site_detail s,purchase_order_item poi,product pr,plant p,purchase_order po,marketing_person m)" + 
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
							" from invoice i LEFT JOIN (customer c,site_detail s,purchase_order_item poi,product pr,plant p,purchase_order po,marketing_person m)" + 
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
					response.sendRedirect("DCList.jsp");
				}else {
					session.setAttribute("res", "<span class='text-danger'>Failed!!!</span>");
					response.sendRedirect("DCList.jsp");
				}
			}
			else if(action.equals("UpdateTallyLedger")) {
				String[] site_id=request.getParameterValues("site_id");
				String[] tally_ladger=request.getParameterValues("tally_ladger");
				for(int i=0;i<site_id.length;i++) {
					cdao.updateTallyLedger(Integer.parseInt(site_id[i]), tally_ladger[i]);
				}
				response.sendRedirect("InvoiceReport.jsp");
			}
			
			
			
			else if(action.equals("DownloadBatchSheet")) {
				try {
					int id=Integer.parseInt(request.getParameter("id"));
					//int plant_id=Integer.parseInt(request.getParameter("plant_id"));
					
					Batchsheet_VRMC batch=new Batchsheet_VRMC();
//					ShreeConcreteBatchsheet batch=new ShreeConcreteBatchsheet();
					batch.generateBatchSheet(id);
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
			
			else if(action.equals("DownloadBatchSheet3")) {
				//System.out.println("hello world");
				try {
					int id=Integer.parseInt(request.getParameter("id"));
					//int plant_id=Integer.parseInt(request.getParameter("plant_id"));
					
//					SchewingStetterVersion1 batch=new SchewingStetterVersion1();
//					SCPJavaCode batch=new SCPJavaCode();
					FletcherBatchSheet batch=new FletcherBatchSheet();
					batch.generateBatchSheet(id);
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
			
			else if(action.equals("DownloadBatchSheet2")) {
				//System.out.println("hello world");
				try {
					int id=Integer.parseInt(request.getParameter("id"));
					//int plant_id=Integer.parseInt(request.getParameter("plant_id"));
					
//					BatchSheetBest batch=new BatchSheetBest();
					FletcherBatchSheet batch=new FletcherBatchSheet();
					batch.generateBatchSheet(id);
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
			 
			
			
			else if(action.equals("getInvoiceNo")) {
				int plant_id=Integer.parseInt(request.getParameter("plant_id"));
				Calendar c=Calendar.getInstance();
				int month=c.get(Calendar.MONTH);
				int start_year=(month>=3)?c.get(Calendar.YEAR):c.get(Calendar.YEAR)-1;
				int end_year=(month>=3)?c.get(Calendar.YEAR)+1:c.get(Calendar.YEAR);
				int invoice_no=dao.getInvoiceNo(plant_id, start_year, end_year);
				writer.println(invoice_no);
			}
			
			
			else if(action.equals("DeleteInvoice")) {
				int invoice_id=Integer.parseInt(request.getParameter("invoice_id"));
				int id=Integer.parseInt(request.getParameter("id"));
				String comment=request.getParameter("comment");
				int count=dao.deleteInvoice(id, invoice_id);
				
				if(count>0) {
//					InvoiceModificationBean bean=new InvoiceModificationBean();
					DCModificationBean bean=new DCModificationBean();
					bean.setComment(comment);
					bean.setInvoice_id(invoice_id);
					bean.setModification_type("Delete");
					//get user name
					UserDetailBean been=(UserDetailBean)session.getAttribute("bean");
					bean.setModification_user(been.getUsername());
					dao.insertInvoiceModification(bean);
					session.setAttribute("res", "Invoice Id : "+invoice_id+" Deleted");
					response.sendRedirect("DCList.jsp");
				}else {
					session.setAttribute("res", "<span class='text-danger'>Failed!!</span>");
					response.sendRedirect("DCList.jsp");
				}
			}
			
			else if(action.equals("DateWiseReport")) {
				response.setContentType("application/json");
				response.setCharacterEncoding("UTF-8");
				Gson gson=new Gson();
				String from_date=request.getParameter("from_date");
				String to_date=request.getParameter("to_date");
				int product_id=Integer.parseInt(request.getParameter("product_id"));
				int plant_id=Integer.parseInt(request.getParameter("plant_id"));
				HashMap<String, Object> map=dao.getDatewiseReport(from_date, to_date, product_id, plant_id);
				writer.println(gson.toJson(map));
			}
			
			else if(action.equals("customerWiseReport")) {
				
				response.setContentType("application/json");
				response.setCharacterEncoding("UTF-8");
				Gson gson=new Gson();
				int customer_id=Integer.parseInt(request.getParameter("customer_id"));
				int site_id=Integer.parseInt(request.getParameter("site_id"));
				int product_id=Integer.parseInt(request.getParameter("product_id"));
				int plant_id=Integer.parseInt(request.getParameter("plant_id"));
				HashMap<String, Object> map=dao.getCustomerWiseReport(customer_id, site_id, product_id, plant_id);
				writer.println(gson.toJson(map));
				
			}
			
			else if(action.equals("customerWithDateWiseReport")) {
				response.setContentType("application/json");
				response.setCharacterEncoding("UTF-8");
				Gson gson=new Gson();
				int customer_id=Integer.parseInt(request.getParameter("customer_id"));
				int site_id=Integer.parseInt(request.getParameter("site_id"));
				int product_id=Integer.parseInt(request.getParameter("product_id"));
				int plant_id=Integer.parseInt(request.getParameter("plant_id"));
				String from_date=request.getParameter("from_date");
				String to_date=request.getParameter("to_date");
				HashMap<String, Object> map=dao.getCustomerWithDateWiseReport(from_date, to_date, customer_id, site_id, product_id, plant_id);
				writer.println(gson.toJson(map));
			}
			
			else if(action.equals("marketingPersonWiseReport")) {
				response.setContentType("application/json");
				response.setCharacterEncoding("UTF-8");
				Gson gson=new Gson();
				String from_date=request.getParameter("from_date");
				String to_date=request.getParameter("to_date");
				int mp_id=Integer.parseInt(request.getParameter("mp_id"));
				int product_id=Integer.parseInt(request.getParameter("product_id"));
				int plant_id=Integer.parseInt(request.getParameter("plant_id"));
				HashMap<String, Object> map=dao.getMarketingPersonWiseReport(from_date, to_date, mp_id, product_id, plant_id);
				writer.println(gson.toJson(map));
				
				
			}
			
			else if(action.equals("vehicleWithDateWiseReport")) {
				response.setContentType("application/json");
				response.setCharacterEncoding("UTF-8");
				Gson gson=new Gson();
				String from_date=request.getParameter("from_date");
				String to_date=request.getParameter("to_date");
				int mp_id=Integer.parseInt(request.getParameter("mp_id"));
				int product_id=Integer.parseInt(request.getParameter("product_id"));
				int plant_id=Integer.parseInt(request.getParameter("plant_id"));
				String vehicle_no=request.getParameter("vehicle_no");
				HashMap<String, Object> map=dao.getVehicleWithDateWiseReport(from_date, to_date, vehicle_no, product_id, plant_id);
				writer.println(gson.toJson(map));
				
			}
			else if(action.equals("getPendingDC")) {
				response.setContentType("application/json");
				response.setCharacterEncoding("UTF-8");
				Gson gson=new Gson();
				int customer_id=Integer.parseInt(request.getParameter("customer_id"));
				int site_id=Integer.parseInt(request.getParameter("site_id"));
				int plant_id=Integer.parseInt(request.getParameter("plant_id"));
				List<Map<String,Object>> map=dao.getPendingDC(customer_id, site_id, plant_id);
				writer.println(gson.toJson(map));
				
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}

}
