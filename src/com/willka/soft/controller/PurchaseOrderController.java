package com.willka.soft.controller;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Arrays;
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

import org.json.JSONArray;
import org.json.JSONObject;

import com.google.gson.Gson;
import com.willka.soft.bean.PurchaseOrderBean;
import com.willka.soft.bean.PurchaseOrderItemBean;
import com.willka.soft.dao.PurchaseOrderDAO;
import com.willka.soft.dao.PurchaseOrderDAOImpl;
import com.willka.soft.util.DBUtil;
import com.willka.soft.util.IndianDateFormater;

import javazoom.upload.MultipartFormDataRequest;
import javazoom.upload.UploadBean;
import javazoom.upload.UploadFile;

/**
 * Servlet implementation class PurchaseOrderController
 */
@WebServlet("/PurchaseOrderController")
public class PurchaseOrderController extends HttpServlet  {
	private static final long serialVersionUID = 1L;
	private Connection con=null;
	private PreparedStatement ps=null;
	private ResultSet rs=null;

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.setContentType("text/html");
		HttpSession session=request.getSession();
		PrintWriter writer=response.getWriter();
		PurchaseOrderDAO dao=new PurchaseOrderDAOImpl();
		try {
			String action=request.getParameter("action");
			
			if (action.equals("insert")) {
				synchronized (this) {
					//get request parameter value
					int customer_id=Integer.parseInt(request.getParameter("customer_id"));
					String po_date=IndianDateFormater.converToIndianFormat(request.getParameter("po_date"));
					String po_valid_till=request.getParameter("po_valid_till");
					po_valid_till=(po_valid_till.equals("") || po_valid_till==null)
							?"":IndianDateFormater.converToIndianFormat(po_valid_till);
					String credit_date=request.getParameter("credit_date");
					int address_id=Integer.parseInt(request.getParameter("site_id"));
					String po_number=request.getParameter("po_number");
					/*String tax_group=request.getParameter("gst_type");*/
					int plant_id=Integer.parseInt(request.getParameter("plant_id"));
					String bill_photo=request.getParameter("bill_photo");
					String rate_include_tax=(request.getParameterValues("rate_include_tax")==null)?"no":"yes";
					int mp_id=Integer.parseInt(request.getParameter("mp_id"));
					float gst_percent=(request.getParameter("gst_percent")==null || request.getParameter("gst_percent").trim().equals(""))?0.0f:Float.parseFloat(request.getParameter("gst_percent"));
					String order_type=request.getParameter("order_type");
					int credit_days=(request.getParameter("credit_days")==null || request.getParameter("credit_days").trim().equals(""))?0:Integer.parseInt(request.getParameter("credit_days"));
					double credit_limit=(request.getParameter("credit_limit")==null || request.getParameter("credit_limit").trim().equals(""))?0.0:Double.parseDouble(request.getParameter("credit_limit"));
					int gst_id=Integer.parseInt(request.getParameter("gst_id"));
					boolean tcs_required=request.getParameter("tcs_required")==null?false:true;
	
					
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
					/*bean.setTax_group(tax_group);*/
					bean.setPlant_id(plant_id);
					bean.setRate_include_tax(rate_include_tax);
					bean.setGst_percent(gst_percent);
					bean.setOrder_type(order_type);
					bean.setMarketing_person_id(mp_id);
					bean.setBill_photo(bill_photo);
					bean.setCredit_days(credit_days);
					bean.setCredit_limit(credit_limit);
					bean.setGst_id(gst_id);
					bean.setTcs_required(tcs_required);
					//insert po
					int count=dao.insertPurchaseOrder(bean);
					int order_id=dao.getHighestOrderId();
					if(count>0){
						//insert po grade
						for(int i=0;i<product_id.length;i++){
							PurchaseOrderItemBean been=new PurchaseOrderItemBean();
							been.setOrder_id(order_id);
							been.setProduct_id(Integer.parseInt(product_id[i]));
							been.setQuantity((quantity[i]==null || quantity[i].trim().equals(""))?0.0:Double.parseDouble(quantity[i]));
							been.setRate((rate[i]==null || rate[i].trim().equals(""))?0.0:Double.parseDouble(rate[i]));
							dao.insertPurchaseOrderItem(been);
						}
						
						session.setAttribute("result", "Po Raised Successfully");
						response.sendRedirect("PurchaseOrderList.jsp");
						
					}else{
						session.setAttribute("result", "<span style='color:red;'>Failed!!</span>");
						response.sendRedirect("PurchaseOrderList.jsp");
					}
				}
				

			}
			
			else if(action.equals("UpdatePurchaseOrder")) {
				//get request parameter value
				int order_id=Integer.parseInt(request.getParameter("order_id"));
				int customer_id=Integer.parseInt(request.getParameter("customer_id"));
				String po_date=IndianDateFormater.converToIndianFormat(request.getParameter("po_date"));
				String po_valid_till=request.getParameter("po_valid_till");
				po_valid_till=(po_valid_till==null || po_valid_till.trim().equals(""))?"":
									IndianDateFormater.converToIndianFormat(po_valid_till);
				String credit_date=request.getParameter("credit_date");
				int address_id=Integer.parseInt(request.getParameter("site_id"));
				int mp_id=Integer.parseInt(request.getParameter("mp_id"));
				String po_number=request.getParameter("po_number");
				/*String tax_group=request.getParameter("gst_type");*/
				int plant_id=Integer.parseInt(request.getParameter("plant_id"));
				String rate_include_tax=(request.getParameterValues("rate_include_tax")==null)?"no":"yes";
				String order_type=request.getParameter("order_type");
				float gst_percent=(request.getParameter("gst_percent")==null || request.getParameter("gst_percent").trim().equals(""))?0.0f:Float.parseFloat(request.getParameter("gst_percent"));
				String bill_photo=request.getParameter("bill_photo");
				int credit_days=(request.getParameter("credit_days")==null || request.getParameter("credit_days").trim().equals(""))?0:Integer.parseInt(request.getParameter("credit_days"));
				double credit_limit=(request.getParameter("credit_limit")==null || request.getParameter("credit_limit").trim().equals(""))?0.0:Double.parseDouble(request.getParameter("credit_limit"));
				int gst_id=Integer.parseInt(request.getParameter("gst_id"));
				boolean tcs_required=request.getParameter("tcs_required")==null?false:true;
				//get grade detail
				String product_id[]=request.getParameterValues("product_id");
				String quantity[]=request.getParameterValues("quantity");
				String rate[]=request.getParameterValues("rate");
				String poi_id[]=request.getParameterValues("poi_id");
				
				
				//first insert po detail
				PurchaseOrderBean bean=new PurchaseOrderBean();
				bean.setCustomer_id(customer_id);
				bean.setPo_date(po_date);
				bean.setPo_valid_till(po_valid_till);
				bean.setCredit_date(credit_date);
				bean.setMarketing_person_id(mp_id);
				bean.setAddress_id(address_id);
				bean.setPo_number(po_number);
				/*bean.setTax_group(tax_group);*/
				bean.setPlant_id(plant_id);
				bean.setRate_include_tax(rate_include_tax);
				bean.setGst_percent(gst_percent);
				bean.setBill_photo(bill_photo);
				bean.setOrder_id(order_id);
				bean.setOrder_type(order_type);
				bean.getBill_photo();
				bean.setCredit_days(credit_days);
				bean.setCredit_limit(credit_limit);
				bean.setGst_id(gst_id);
				bean.setTcs_required(tcs_required);
				
				//insert po
				int count=dao.updatePurchaseOrder(bean);
				if(count>0){
					//insert po grade
					for(int i=0;i<product_id.length;i++){
						try {
							PurchaseOrderItemBean been=new PurchaseOrderItemBean();
							been.setPoi_id(Integer.parseInt(poi_id[i]));
							been.setOrder_id(order_id);
							been.setProduct_id(Integer.parseInt(product_id[i]));
							been.setQuantity((quantity[i]==null || quantity[i].trim().equals(""))?0.0:Double.parseDouble(quantity[i]));
							been.setRate((rate[i]==null || rate[i].trim().equals(""))?0.0:Double.parseDouble(rate[i]));
							dao.updatePurchaseOrderItem(been);
						}catch(Exception e) {
							PurchaseOrderItemBean been=new PurchaseOrderItemBean();
							been.setOrder_id(order_id);
							been.setProduct_id(Integer.parseInt(product_id[i]));
							been.setQuantity((quantity[i]==null || quantity[i].trim().equals(""))?0.0:Double.parseDouble(quantity[i]));
							been.setRate((rate[i]==null || rate[i].trim().equals(""))?0.0:Double.parseDouble(rate[i]));
							dao.insertPurchaseOrderItem(been);
						}
					}
					
					session.setAttribute("res", "Po Updated Successfully");
					response.sendRedirect("PurchaseOrderList.jsp");
					
				}else{
					session.setAttribute("result", "<span style='color:red;'>Failed!!</span>");
					response.sendRedirect("PurchaseOrderList.jsp");
				}
			}
			
			else if(action.equals("cancelOrder")) {
				int order_id=Integer.parseInt(request.getParameter("order_id"));
				int count=dao.cancelPurchaseOrder(order_id);
				writer.print(count);
			}
			
			else if(action.equals("activateOrder")) {
				int order_id=Integer.parseInt(request.getParameter("order_id"));
				int count=dao.activatePurchaseOrder(order_id);
				if(count>0) {
					session.setAttribute("res", "Order Cancelled");
					response.sendRedirect("PurchaseOrderList.jsp");
				}else {
					session.setAttribute("res", "<span class='text-danger'>Failed!!</span>");
					response.sendRedirect("PurchaseOrderList.jsp");
				}
			}
			
			else if(action.equals("GetGradeList")) {
				response.setContentType("application/json");
				response.setCharacterEncoding("utf-8");
				int plant_id=Integer.parseInt(request.getParameter("plant_id"));
				int site_id=Integer.parseInt(request.getParameter("site_id"));
				con=DBUtil.getConnection();
				ps=con.prepareStatement("select g1.poi_id,g1.rate,g2.product_id,g2.max_date,g1.product_name from( select t.product_id,max(t.po_date) as max_date from (select p.poi_id,p.rate,pro.product_name,po.po_date,p.product_id from purchase_order_item  p,purchase_order" + 
						" po,product pro where p.order_id=po.order_id and p.product_id=pro.product_id and po.site_id=? and po.plant_id in(?,0)" + 
						" and po.status='active') as t  group by t.product_id) as g2" + 
						" join (select p.poi_id,p.rate,pro.product_name,po.po_date,p.product_id" + 
						" from purchase_order_item p,purchase_order po,product pro where p.order_id=po.order_id" + 
						" and p.product_id=pro.product_id and po.site_id=? and po.plant_id in(?,0)" + 
						" and po.status='active') as g1 on g1.po_date=g2.max_date and g1.product_id=g2.product_id");
				ps.setInt(1, site_id);
			    ps.setInt(2, plant_id);
			    ps.setInt(3, site_id);
			    ps.setInt(4, plant_id);
			    rs=ps.executeQuery();
			    JSONArray array=new JSONArray();
			    while(rs.next()) {
			    	JSONObject object=new JSONObject();
			    	object.put("poi_id", rs.getInt("poi_id"));
			    	object.put("product_name", rs.getString("product_name"));
			    	object.put("product_id", rs.getInt("product_id"));
			    	object.put("rate", rs.getDouble("rate"));
			    	array.put(object);
			    }
			    writer.print(array);
			}
			
			else if(action.equals("GetGradeDetails")) {
				response.setContentType("application/json");
				response.setCharacterEncoding("utf-8");
				Gson gson=new Gson();
				con=DBUtil.getConnection();
				int poi_id=Integer.parseInt(request.getParameter("poi_id"));
				ps=con.prepareStatement("select poi.*,p.product_name,g.gst_percent,g.gst_category as tax_group,po.rate_include_tax"
						+ " from purchase_order_item poi LEFT JOIN (purchase_order po,product p,gst_percent g)"
						+ " ON poi.product_id=p.product_id and poi.order_id=po.order_id and po.gst_id=g.gst_id"
						+ " where poi.poi_id=?");
				ps.setInt(1, poi_id);
				rs=ps.executeQuery();
				HashMap<String, Object> val=new HashMap<>();
				if(rs.next()) {
					val.put("product_name", rs.getString("product_name"));
					val.put("rate", rs.getString("rate"));
					val.put("gst_percent", rs.getFloat("gst_percent"));
					val.put("tax_group", rs.getString("tax_group"));
					val.put("rate_include", rs.getString("rate_include_tax"));
				}
				writer.println(gson.toJson(val));
				
			}
			
			
			else if(action.equals("GetInvoiceWithPurchaseOrder")) {
				response.setContentType("application/json");
				response.setCharacterEncoding("UTF-8");
				int order_id=Integer.parseInt(request.getParameter("order_id"));
				JSONArray array=new JSONArray();
				con=DBUtil.getConnection();
				ps=con.prepareStatement("select i.*,p.product_name from invoice i,purchase_order_item poi,purchase_order po,product p where i.poi_id=poi.poi_id and poi.product_id=p.product_id and poi.order_id=po.order_id and po.order_id=?");
				ps.setInt(1, order_id);
				rs=ps.executeQuery();
				while(rs.next()) {
					JSONObject object=new JSONObject();
					object.put("invoice_id", rs.getInt("invoice_id"));
					object.put("invoice_date", rs.getString("invoice_date"));
					object.put("invoice_time", rs.getString("invoice_time"));
					object.put("product_name", rs.getString("product_name"));
					object.put("quantity", rs.getDouble("quantity"));
					object.put("net_amount", rs.getDouble("net_amount"));
					object.put("vehicle_no", rs.getString("vehicle_no"));
					array.put(object);
				}
				writer.println(array);
			}

			
			else if(action.equals("checkPOType")) {
				response.setContentType("application/json");
				response.setCharacterEncoding("utf-8");
				Gson gson=new Gson();
				int poi_id=(request.getParameter("poi_id")==null || request.getParameter("poi_id").trim().equals("null"))?0:Integer.parseInt(request.getParameter("poi_id"));
				con=DBUtil.getConnection();
				ps=con.prepareStatement("select po.order_type,poi.quantity as order_quantity, po.po_valid_till,(select sum(payment_amount) from customer_payment where customer_id=po.customer_id) as payment_amount,(select credit_limit from customer where customer_id=po.customer_id) as credit_limit, " + 
						"						 (select sum(quantity)  from invoice where poi_id=poi.poi_id) as invoice_sum, " + 
						"						 (SELECT sum(net_amount) FROM  invoice i1,purchase_order po1,purchase_order_item poi1  where i1.poi_id=poi1.poi_id and poi1.order_id=po1.order_id and  po1.order_id=po.order_id) as invoice_net, " + 
						"						 poi.poi_id " + 
						"						 from purchase_order_item poi LEFT JOIN purchase_order po ON poi.order_id=po.order_id where poi.poi_id=?");
				ps.setInt(1, poi_id);
				rs=ps.executeQuery();
				HashMap<String, Object> result=new HashMap<>();
				if(rs.next()) {
					result.put("order_type",rs.getString("order_type"));
					result.put("invoice_sum", rs.getDouble("invoice_sum"));
					result.put("order_quantity", rs.getDouble("order_quantity"));
					result.put("net_quantity", rs.getDouble("order_quantity")-rs.getDouble("invoice_sum"));
					result.put("credit_limit", rs.getDouble("credit_limit"));
					result.put("invoice_amount", rs.getDouble("invoice_net"));
					result.put("po_validity", rs.getString("po_valid_till"));
					result.put("payment_amount", rs.getDouble("payment_amount"));
				}
				writer.println(gson.toJson(result));
			}
			
			
			else if(action.equals("getPurchaesOrderList")) {
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
				String po_number = request.getParameter("po_number");
				int start = Integer.parseInt(request.getParameter("start"));
				int length = Integer.parseInt(request.getParameter("length"));
				int plant_id=Integer.parseInt(request.getParameter("plant_id"));
				Map<String, Object> data = new HashMap<>();
				int draw = Integer.parseInt(request.getParameter("draw"));
				data.put("data", dao.getAllPurchaseOrderList(customer_id, site_id, from_date,
						to_date, po_number, business_id, plant_id, start, length));
				data.put("draw", draw);
				int recordCount = dao.countAllPurchaseOrderList(customer_id, site_id, from_date,
						to_date, po_number, business_id,plant_id);
				data.put("recordsTotal", recordCount);
				data.put("recordsFiltered", recordCount);
				writer.print(gson.toJson(data));
			}
			
			
			else if(action.equals("getSinglePoDetails")) {
				response.setContentType("application/json");
				response.setCharacterEncoding("utf-8");
				Gson gson=new Gson();
				int order_id=Integer.parseInt(request.getParameter("order_id"));
				Map<String,Object> data=dao.getPurchaseOrderDetails(order_id);
				writer.println(gson.toJson(data));
			}
			
			
		
		else if(action.equals("upload_file")){
			/*String user_id=request.getParameter("user_id");*/
			//System.out.println("coming here");
			Properties prop=new Properties();
			ClassLoader classLoader = Thread.currentThread().getContextClassLoader();
			InputStream input = classLoader.getResourceAsStream("com/willka/soft/util/Util.properties");
			prop.load(input);
			String path=prop.getProperty("mypath");
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
				String extension=f.getFileName().substring(f.getFileName().lastIndexOf("."),f.getFileName().length());
				f.setFileName(f.getFileName());
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
			//now update offer letter details detail's 
			/*int count=dao.updateEmployeeProfilePic(Integer.parseInt(user_id), file_name);*/
			writer.println(file_name);
		}
			
		else if(action.equals("getTcsDetails")) {
			response.setContentType("application/json");
			response.setCharacterEncoding("utf-8");
			Gson gson=new Gson();
			int customer_id=Integer
						.parseInt(request.getParameter("customer_id"));
			String invoice_date=request.getParameter("invoice_date");
			
			int poi_id=Integer.parseInt(request.getParameter("poi_id"));
			Map<String, Integer> financeYear=IndianDateFormater
					.getFinancialYearByMysqlDate(invoice_date);
			
			int tcs_required=0;
			double net_amount=0;
			
			boolean tcs_applcable=dao.getTcsDetailsByPOIId(poi_id);
		    net_amount=dao.getNetAmountBetweenFinancialYear(financeYear.get("start_year"),
					financeYear.get("end_year"), customer_id);
		    if(tcs_applcable)
		    	tcs_required=1;
		    if(net_amount > 5000000)
		    	tcs_required=1;
		    
		    Map<String,Object> tcsData=new HashMap<>();
		    tcsData.put("tcs_required", tcs_required);
		    tcsData.put("net_amount", net_amount);
			writer.println(gson.toJson(tcsData));
		}
			
		else if(action.equals("getTcsDetailsForSalesDocument")) {
			response.setContentType("application/json");
			response.setCharacterEncoding("utf-8");
			Gson gson=new Gson();
			int customer_id=Integer
						.parseInt(request.getParameter("customer_id"));
			String invoice_date=request.getParameter("invoice_date");
			
			int poi_id=Integer.parseInt(request.getParameter("poi_id"));
			Map<String, Integer> financeYear=IndianDateFormater
					.getFinancialYearByMysqlDate(invoice_date);
			
			int tcs_required=0;
			double net_amount=0;
			
			boolean tcs_applcable=dao.getTcsDetailsByPOIId(poi_id);
		    net_amount=dao.getNetAmountBetweenFinancialYear(financeYear.get("start_year"),
					financeYear.get("end_year"), customer_id);
		    if(tcs_applcable)
		    	tcs_required=1;
		    if(net_amount > 5000000)
		    	tcs_required=1;
		    
		    Map<String,Object> tcsData=new HashMap<>();
		    tcsData.put("tcs_required", tcs_required);
		    tcsData.put("net_amount", net_amount);
			writer.println(gson.toJson(tcsData));
		}
		
	   }
		
	
		
		catch (Exception e) {
			e.printStackTrace();
			session.setAttribute("result", "<span style='color:red;'>Error Occured!</span>");
			response.sendRedirect("purchase_order.jsp");
		}

		}

}
