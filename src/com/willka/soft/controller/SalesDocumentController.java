package com.willka.soft.controller;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Calendar;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.Map;
import java.util.Properties;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.willka.soft.bean.ConsolidateInvoiceBean;
import com.willka.soft.bean.ConsolidateInvoiceItemBean;
import com.willka.soft.bean.SalesDocumentBean;
import com.willka.soft.bean.SalesDocumentItemBean;
import com.willka.soft.dao.CustomerDaoImpl;
import com.willka.soft.dao.InvoiceDAO;
import com.willka.soft.dao.InvoiceDAOImpl;
import com.willka.soft.dao.SalesDocumentDAO;
import com.willka.soft.dao.SalesDocumentDAOImpl;
import com.willka.soft.util.DBUtil;
import com.willka.soft.util.IndianDateFormater;

import javazoom.upload.MultipartFormDataRequest;
import javazoom.upload.UploadBean;
import javazoom.upload.UploadFile;


/**
 * Servlet implementation class SalesDocumentController
 */
@WebServlet("/SalesDocumentController")
public class SalesDocumentController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private PreparedStatement ps=null;
	private ResultSet rs=null;
	private Connection con=null;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		PrintWriter writer=response.getWriter();
		HttpSession session=request.getSession();
		SalesDocumentDAO dao=new SalesDocumentDAOImpl();
		InvoiceDAO idao=new InvoiceDAOImpl();
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
						int invoice_id=Integer.parseInt(request.getParameter("invoice_no"));
						double tcs_percent=Double.parseDouble(request.getParameter("tcs_percent"));
						double round_off=Double.parseDouble(request.getParameter("round_off"));
						String documents=request.getParameter("documents");
						String [] dc_ids=request.getParameterValues("dc_id");
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
						bean.setTcs_percent(tcs_percent);
						bean.setRound_off(round_off);
						bean.setDocuments(documents);
						
						int cnt=dao.insertSalesDocument(bean);
						int id=dao.getMaxId();
						int vv=0;
						
						if(cnt>0) {
							dao.updateInvoiceNoInDC(dc_ids,id);
							for(int i=0;i<count;i++) {
								SalesDocumentItemBean been=new SalesDocumentItemBean();
								been.setPoi_id(Integer.parseInt(request.getParameter("poi_id["+i+"]")));
								been.setItem_quantity(Double.parseDouble(request.getParameter("quantity["+i+"]"))); 
								been.setItem_price(Double.parseDouble(request.getParameter("rate["+i+"]")));
								been.setGross_price(Double.parseDouble(request.getParameter("gross_amount["+i+"]")));
								been.setTax_price(Double.parseDouble(request.getParameter("tax_amount["+i+"]")));
								been.setNet_price(Double.parseDouble(request.getParameter("net_amount["+i+"]")));
								been.setTcs_price(Double.parseDouble(request.getParameter("tcs_amount["+i+"]")));
								been.setId(id);
								dao.insertSalesDocumentItem(been);
								vv++;
							}
						}
						
						if(vv>0) {
							session.setAttribute("res", "Invoice Id : "+invoice_id+" Added Successfully");
							response.sendRedirect("SalesDocumentList.jsp");
						}else {
							session.setAttribute("res", "<span class='text-danger'>Failed!!</span>");
							response.sendRedirect("SalesDocumentList.jsp");
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
					int business_id=dao.getBusinessIdByPlantId(plant_id);
					Calendar c=Calendar.getInstance();
					int month=c.get(Calendar.MONTH);
					int start_year=(month>=3)?c.get(Calendar.YEAR):c.get(Calendar.YEAR)-1;
					int end_year=(month>=3)?c.get(Calendar.YEAR)+1:c.get(Calendar.YEAR);
					int invoice_no=dao.getLastInvoiceNo(business_id, start_year, end_year,plant_id);
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
						String invoice_no=request.getParameter("invoice_no");
						double tcs_percent=Double.parseDouble(request.getParameter("tcs_percent"));
						double round_off=Double.parseDouble(request.getParameter("round_off"));
						String documents=request.getParameter("documents");
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
						bean.setTcs_percent(tcs_percent);
						bean.setRound_off(round_off);
						bean.setDocuments(documents);
						bean.setInvoice_id(Integer.parseInt(invoice_no));
						
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
									been.setTcs_price(Double.parseDouble(request.getParameter("tcs_amount["+i+"]")));
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
									been.setTcs_price(Double.parseDouble(request.getParameter("tcs_amount["+i+"]")));
									been.setId(id);
									dao.insertSalesDocumentItem(been);
									vv++;
								}
							}
						}
						
						if(vv>0) { 
							session.setAttribute("res", "Invoice Id : "+invoice_no+" updated Successfully");
							response.sendRedirect("SalesDocumentList.jsp");
						}else {
							session.setAttribute("res", "<span class='text-danger'>Failed!!</span>");
							response.sendRedirect("SalesDocumentList.jsp");
						}
						
						
						
					}
				}
				
				
				else if(action.equals("generatecons")) {
					synchronized (this) {
						int customer_id=Integer.parseInt(request.getParameter("customer_id"));
						int plant_id=Integer.parseInt(request.getParameter("plant_id"));
						String[] idd=request.getParameterValues("idd");
						String generate_date=request.getParameter("generate_date");
						generate_date=IndianDateFormater.
									converToIndianFormat(generate_date);
						
						
						ConsolidateInvoiceBean bean=new ConsolidateInvoiceBean();
						bean.setCustomer_id(customer_id);
						bean.setPlant_id(plant_id);
						bean.setGenerate_date(generate_date);
						bean.setType("sales");
						
						Calendar calendar=Calendar.getInstance();
						//System.out.println(calendar);
						
						int month=calendar.get(Calendar.MONTH);
						int year=calendar.get(Calendar.YEAR);
						
						int start_year=(month>=3)?year:year-1;
						int end_year=(month>=3)?year+1:year;
						//System.out.println(start_year);
						//System.out.println(end_year);
						
						int cons_id=idao.maxConsId(start_year, end_year)+1;
						
						bean.setCons_id(cons_id);
						bean.setStart_year(start_year);
						bean.setEnd_year(end_year);
						
						int count=idao.generateConsolidateInvoice(bean);
						
						if(count>0) {
							//get max consolidate invoice id
							int consolidate_invoice_id=idao.getMaxConsolidateInvoiceId();
							for(int i=0;i<idd.length;i++) {
								ConsolidateInvoiceItemBean ibean=new ConsolidateInvoiceItemBean();
								ibean.setConsolidate_invoice_id(consolidate_invoice_id);
								ibean.setId(Integer.parseInt(idd[i]));
								idao.addConsolidateInvoiceItem(ibean);
							}
							session.setAttribute("result", "Consolidate Invoice Generated Successfully");
							response.sendRedirect("SalesConsolidateInvoiceList.jsp");
						}else {
							session.setAttribute("result", "<span class='text-danger'>Failed!!!</span>");
							response.sendRedirect("SalesConsolidateInvoiceList.jsp");
						}
					}
				}
				
				else if(action.equals("getConsolidateINvoiceList")) {
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
					int business_id=Integer.parseInt(request.getParameter("business_id"));
					int plant_id=Integer.parseInt(request.getParameter("plant_id"));
					String cons_id = request.getParameter("cons_id");
					int start = Integer.parseInt(request.getParameter("start"));
					int length = Integer.parseInt(request.getParameter("length"));
					Map<String, Object> data = new HashMap<>();
					int draw = Integer.parseInt(request.getParameter("draw"));
					data.put("data", dao.getSalesConsolidateInvoiceList(cons_id, customer_id, from_date,
								to_date, business_id, plant_id, start, length));
					data.put("draw", draw);
					int recordCount =dao.countSalesConsolidateInvoice(cons_id, customer_id,
							from_date, to_date, plant_id, business_id);
					data.put("recordsTotal", recordCount);
					data.put("recordsFiltered", recordCount);
					writer.print(gson.toJson(data));
				}
				
				else if(action.equals("TallyXml")) {
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
								" from sales_document i LEFT JOIN (customer c,plant p,site_detail s)" + 
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
					response.sendRedirect("SalesDocumentReportBulk.jsp");
				}
				
				else if(action.equals("getNetAmountOfPerticularCustomer")) {
					String invoice_date=request.getParameter("invoice_date");
					int customer_id=Integer.parseInt(request.getParameter("customer_id"));
					Map<String, Integer> financeYear=IndianDateFormater
							.getFinancialYearByMysqlDate(IndianDateFormater.converToIndianFormat(invoice_date));
					writer.println(dao.getTotalNetAmount(customer_id,financeYear.get("start_year"),financeYear.get("end_year")));
				}
				
				else if(action.equals("uploadDocument")){
					/*String user_id=request.getParameter("user_id");*/
					//System.out.println("coming here");
					Properties prop=new Properties();
					ClassLoader classLoader = Thread.currentThread().getContextClassLoader();
					InputStream input = classLoader.getResourceAsStream("com/willka/soft/util/Util.properties");
					prop.load(input);
					String path=prop.getProperty("sales");
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
					long miliSecond=System.currentTimeMillis();
					while(e.hasMoreElements()){
						UploadFile f=(UploadFile)e.nextElement();
						String extension=f.getFileName().substring(f.getFileName().lastIndexOf("."),f.getFileName().length());
						f.setFileName(miliSecond+"."+extension);
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
				else if(action.equals("generateInvoiceFromDC")) {
					int dc_id=Integer.parseInt(request.getParameter("dc_id"));
					System.out.println(dc_id);
					con=DBUtil.getConnection();
					ps=con.prepareStatement("select * from dc where id=?");
					ps.setInt(1, dc_id);
					rs=ps.executeQuery();
					if(rs.next()) {
						int plant_id=rs.getInt("plant_id");
						String date=IndianDateFormater.converToIndianFormatOther(rs.getString("invoice_date"));
						Map<String,Integer> data=IndianDateFormater.getFinancialYearByDate(date);
						int business_id=dao.getBusinessIdByPlantId(plant_id);
						Calendar c=Calendar.getInstance();
						int month=c.get(Calendar.MONTH);
						int start_year=(month>=3)?c.get(Calendar.YEAR):c.get(Calendar.YEAR)-1;
						int end_year=(month>=3)?c.get(Calendar.YEAR)+1:c.get(Calendar.YEAR);
						int invoice_no=dao.getLastInvoiceNo(business_id, start_year, end_year,plant_id);
						//int invoice_id=dao.getLastInvoiceNo(rs.getInt("plant_id"), rs.getString("invoice_date"));
						
						int count=1;
						
						SalesDocumentBean  bean=new SalesDocumentBean();
						bean.setCustomer_id(rs.getInt("customer_id"));
						bean.setPlant_id(rs.getInt("plant_id"));
						bean.setSite_id(rs.getInt("site_id"));
						bean.setInvoice_date(rs.getString("invoice_date"));
						bean.setInvoice_time(rs.getString("invoice_time"));
						bean.setVehicle_no(rs.getString("vehicle_no"));
						bean.setDriver_name(rs.getString("driver_name"));
						bean.setInvoice_id(invoice_no);
						bean.setStart_year(data.get("start_year"));
						bean.setEnd_year(data.get("end_year"));
						
						
						int cnt=dao.insertSalesDocument(bean);
						int id=dao.getMaxId();
						int vv=0;
						
						if(cnt>0) {
							String arr[]= {String.valueOf(dc_id)};
							dao.updateInvoiceNoInDC(arr,id);
							for(int i=0;i<count;i++) {
								SalesDocumentItemBean been=new SalesDocumentItemBean();
								been.setPoi_id(rs.getInt("poi_id"));
								been.setItem_quantity(rs.getDouble("quantity")); 
								been.setItem_price(rs.getDouble("rate"));
								been.setGross_price(rs.getDouble("gross_amount"));
								been.setTax_price(rs.getDouble("tax_amount"));
								been.setTcs_price(rs.getDouble("tcs_amount"));
								been.setNet_price(rs.getDouble("net_amount"));
								been.setId(id);
								dao.insertSalesDocumentItem(been);
								vv++;
							}
						}
						
						if(vv>0) {
							session.setAttribute("res", "Invoice Id : "+invoice_no+" Added Successfully");
							response.sendRedirect("SalesDocumentList.jsp");
						}else {
							session.setAttribute("res", "<span class='text-danger'>Failed!!</span>");
							response.sendRedirect("SalesDocumentList.jsp");
						}
					}
				}
				
				
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}

}
