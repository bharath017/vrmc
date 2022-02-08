package com.willka.soft.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;

import com.google.gson.Gson;
import com.willka.soft.bean.FollowUpReportBean;
import com.willka.soft.bean.SchedulingBean;
import com.willka.soft.bean.SchedulingItemBean;
import com.willka.soft.dao.SchedulingDAOImpl;
import com.willka.soft.util.DBUtil;
import com.willka.soft.util.IndianDateFormater;

/**
 * Servlet implementation class SchedulingController
 */
@WebServlet("/SchedulingController")
public class SchedulingController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private Connection con=null;
    private PreparedStatement ps=null;
    private ResultSet rs=null;
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession sessoin=request.getSession();
		response.setContentType("text/html");
		PrintWriter writer=response.getWriter();
		SchedulingDAOImpl dao=new SchedulingDAOImpl();
		
		try {
			String action=request.getParameter("action");
			
			if(action.equals("InsertScheduling")) {
				synchronized (this) {
					int scheduling_id=Integer.parseInt(request.getParameter("scheduling_id"));
					if(scheduling_id==0) {
						//insert it
						int customer_id=Integer.parseInt(request.getParameter("customer_id"));
						int site_id=Integer.parseInt(request.getParameter("site_id"));
						String scheduling_date=request.getParameter("scheduling_date");
						String start_time=request.getParameter("start_time");
						String end_time=request.getParameter("end_time");
						String pump1=request.getParameter("pump1");
						String pump2=request.getParameter("pump2");
						String product_id[]=request.getParameterValues("product_id");
						int plant_id=Integer.parseInt(request.getParameter("plant_id"));
						String production_quantity[]=request.getParameterValues("production_quantity");
						String scheduling_item_id[]=request.getParameterValues("scheduling_item_id");
		
						
						SchedulingBean bean=new SchedulingBean();
						bean.setCustomer_id(customer_id);
						bean.setSite_id(site_id);
						bean.setScheduling_date(scheduling_date);
						bean.setStart_time(start_time);
						bean.setEnd_time(end_time);
						bean.setPump1(pump1);
						bean.setPump2(pump2);
						bean.setPlant_id(plant_id);
						bean.setScheduling_id(scheduling_id);
						
						
						int count=dao.insertScheduling(bean);
						
						if(count>0) {
							//get max details
							 scheduling_id=dao.getMaxSchedulingId();
							for(int i=0;i<product_id.length;i++) {
								SchedulingItemBean been=new SchedulingItemBean();
								been.setProduct_id(Integer.parseInt(product_id[i]));
								been.setProduction_quantity((production_quantity[i]==null || production_quantity[i].trim().equals(""))?0.0:Double.parseDouble(production_quantity[i]));
								been.setScheduling_id(scheduling_id);
								dao.insertSchedulingItem(been);
							}
							
							sessoin.setAttribute("res", "Scheduled Successfully");
							response.sendRedirect("SchedulingList.jsp");
						}else {
							sessoin.setAttribute("res", "<span class='text-danger'>Failed!!</span>");
							response.sendRedirect("SchedulingList.jsp");
						}
					}else {
						//update it
						int customer_id=Integer.parseInt(request.getParameter("customer_id"));
						int site_id=Integer.parseInt(request.getParameter("site_id"));
						int plant_id=Integer.parseInt(request.getParameter("plant_id"));
						String scheduling_date=request.getParameter("scheduling_date");
						String start_time=request.getParameter("start_time");
						String end_time=request.getParameter("end_time");
						String pump1=request.getParameter("pump1");
						String pump2=request.getParameter("pump2");
						String product_id[]=request.getParameterValues("product_id");
						String production_quantity[]=request.getParameterValues("production_quantity");
						String scheduling_item_id[]=request.getParameterValues("scheduling_item_id");
						
						SchedulingBean bean=new SchedulingBean();
						bean.setCustomer_id(customer_id);
						bean.setSite_id(site_id);
						bean.setScheduling_date(scheduling_date);
						bean.setStart_time(start_time);
						bean.setEnd_time(end_time);
						bean.setPump1(pump1);
						bean.setPump2(pump2);
						bean.setPlant_id(plant_id);
						bean.setScheduling_id(scheduling_id);
						int count=dao.updateScheduling(bean);
						
						if(count>0) {
							//get max details
							for(int i=0;i<scheduling_item_id.length;i++) {
								if(Integer.parseInt(scheduling_item_id[i])==0) {
									SchedulingItemBean been=new SchedulingItemBean();
									been.setScheduling_item_id(Integer.parseInt(scheduling_item_id[i]));
									been.setProduct_id(Integer.parseInt(product_id[i]));
									been.setProduction_quantity((production_quantity[i]==null || production_quantity[i].trim().equals(""))?0.0:Double.parseDouble(production_quantity[i]));
									been.setScheduling_id(scheduling_id);
									been.setScheduling_id(scheduling_id);
									dao.insertSchedulingItem(been);
								}else {
									SchedulingItemBean been=new SchedulingItemBean();
									been.setScheduling_item_id(Integer.parseInt(scheduling_item_id[i]));
									been.setProduct_id(Integer.parseInt(product_id[i]));
									been.setProduction_quantity((production_quantity[i]==null || production_quantity[i].trim().equals(""))?0.0:Double.parseDouble(production_quantity[i]));
									been.setScheduling_id(scheduling_id);
									dao.updateSchedulingItem(been);
								}
							}
							sessoin.setAttribute("res", "Scheduled Successfully");
							response.sendRedirect("SchedulingList.jsp");
						}else {
							sessoin.setAttribute("res", "<span class='text-danger'>Failed!!</span>");
							response.sendRedirect("SchedulingList.jsp");
						}
					}
				}
			}
			
			
			else if(action.equals("getDetails")) {
				response.setContentType("application/json");
				response.setCharacterEncoding("UTF-8");
				Gson gson=new Gson();
				ArrayList<SchedulingItemBean> sc_list=new ArrayList<>();
				HashMap<String, Object> myVal=new HashMap<>();
				int site_id=Integer.parseInt(request.getParameter("site_id"));
				String date=request.getParameter("date");
				int plant_id=Integer.parseInt(request.getParameter("plant_id"));
				con=DBUtil.getConnection();
				
				
				//first check availability of scheduling
				SchedulingBean bean=dao.getSchedulingDetails(site_id, date,plant_id);
				if(bean==null) {
					//now product details
					ps=con.prepareStatement("select g1.poi_id,(select sum(quantity) from invoice where poi_id=g1.poi_id) as tquantity, "
							+ "g1.rate,g2.product_id,g2.max_date,g1.product_name,g1.quantity from( select t.product_id,max(t.po_date) as max_date from (select p.poi_id,p.quantity,p.rate,pro.product_name,po.po_date,p.product_id from purchase_order_item  p,purchase_order" + 
							" po,product pro where p.order_id=po.order_id and p.product_id=pro.product_id and po.site_id=? and po.plant_id in(?,0)" + 
							" and po.status='active') as t  group by t.product_id) as g2" + 
							" join (select p.poi_id,p.quantity,p.rate,pro.product_name,po.po_date,p.product_id" + 
							" from purchase_order_item p,purchase_order po,product pro where p.order_id=po.order_id" + 
							" and p.product_id=pro.product_id and po.site_id=? and po.plant_id in(?,0)" + 
							" and po.status='active') as g1 on g1.po_date=g2.max_date and g1.product_id=g2.product_id");
					ps.setInt(1, site_id);
				    ps.setInt(2, plant_id);
				    ps.setInt(3, site_id);
				    ps.setInt(4, plant_id);
				    rs=ps.executeQuery();
				    while(rs.next()) {
				    	SchedulingItemBean been=new SchedulingItemBean();
				    	been.setProduct_id(rs.getInt("product_id"));
				    	been.setProduction_quantity(0.0);
				    	been.setProduct_name(rs.getString("product_name"));
				    	been.setPo_quantity(rs.getDouble("quantity"));
				    	been.setTquantity(rs.getDouble("tquantity"));
				    	sc_list.add(been);
				    }
				    myVal.put("sc", new SchedulingBean());
				    myVal.put("si", sc_list);
				    writer.println(gson.toJson(myVal));
				}else {
					ArrayList<SchedulingItemBean> bc_item=dao.getSchedulingItems(bean.getScheduling_id());
					ps=con.prepareStatement("select g1.poi_id,(select sum(quantity) from invoice where poi_id=g1.poi_id) as tquantity, "
							+ "g1.rate,g2.product_id,g2.max_date,g1.product_name,g1.quantity from( select t.product_id,max(t.po_date) as max_date from (select p.poi_id,p.quantity,p.rate,pro.product_name,po.po_date,p.product_id from purchase_order_item  p,purchase_order" + 
							" po,product pro where p.order_id=po.order_id and p.product_id=pro.product_id and po.site_id=? and po.plant_id in(?,0)" + 
							" and po.status='active') as t  group by t.product_id) as g2" + 
							" join (select p.poi_id,p.quantity,p.rate,pro.product_name,po.po_date,p.product_id" + 
							" from purchase_order_item p,purchase_order po,product pro where p.order_id=po.order_id" + 
							" and p.product_id=pro.product_id and po.site_id=? and po.plant_id in(?,0)" + 
							" and po.status='active') as g1 on g1.po_date=g2.max_date and g1.product_id=g2.product_id");
					ps.setInt(1, site_id);
				    ps.setInt(2, plant_id);
				    ps.setInt(3, site_id);
				    ps.setInt(4, plant_id);
				    rs=ps.executeQuery();
				    while(rs.next()) {
				    	SchedulingItemBean been=new SchedulingItemBean();
				    	been.setProduct_id(rs.getInt("product_id"));
				    	been.setProduction_quantity(0.0);
				    	been.setProduct_name(rs.getString("product_name"));
				    	been.setPo_quantity(rs.getDouble("quantity"));
				    	been.setTquantity(rs.getDouble("tquantity"));
				    	for(SchedulingItemBean b:bc_item) {
				    		if(b.getProduct_id()==rs.getInt("product_id")) {
				    			been.setScheduling_item_id(b.getScheduling_item_id());
				    			been.setProduction_quantity(b.getProduction_quantity());
				    		}
				    	}
				    	sc_list.add(been);
				    }
				    
				    
					myVal.put("sc", bean);
					myVal.put("si", sc_list);
					writer.println(gson.toJson(myVal));
				}
				
			}
			
			else if(action.equals("DeleteScheduling")) {
				int scheduling_id=Integer.parseInt(request.getParameter("scheduling_id"));
				int count=dao.deleteScheduling(scheduling_id);
				writer.println(count);
			}
			
			else if(action.equals("ViewDetails")) {
				response.setContentType("application/json");
				response.setCharacterEncoding("UTF-8");
				int customer_id=Integer.parseInt(request.getParameter("customer_id"));
				String date=request.getParameter("date");
				int site_id=Integer.parseInt(request.getParameter("site_id"));
				JSONArray array=new JSONArray();
				con=DBUtil.getConnection();
				ps=con.prepareStatement("select i.invoice_id,p.product_name,i.vehicle_no,i.quantity from invoice i LEFT JOIN (purchase_order_item poi,product p) ON "
						+ "i.poi_id=poi.poi_id and poi.product_id=p.product_id where i.customer_id=? and i.site_id=? and i.invoice_date=?");
				ps.setInt(1, customer_id);
				ps.setInt(2, site_id);
				ps.setString(3, date);
				rs=ps.executeQuery();
				while(rs.next()) {
					JSONObject object=new JSONObject();
					object.put("invoice_id", rs.getInt("invoice_id"));
					object.put("product_name", rs.getString("product_name"));
					object.put("vehicle_no", rs.getString("vehicle_no"));
					object.put("quantity", rs.getDouble("quantity"));
					array.put(object);
				}
				
				writer.print(array);
			}
			
			
			else if(action.equals("getSchedulingList")) {
				response.setContentType("application/json");
				response.setCharacterEncoding("utf-8");
				Gson gson=new Gson();
				String from_date=request.getParameter("from_date");
				from_date=(from_date==null || from_date.trim().equals(""))?
						"":IndianDateFormater.converToIndianFormat(from_date);
				String to_date=request.getParameter("to_date");
				to_date=(to_date==null || to_date.trim().equals(""))?
						"":IndianDateFormater.converToIndianFormat(to_date);
				int customer_id=(request.getParameter("customer_id")==null || request.getParameter("customer_id").trim().equals(""))?
						0:Integer.parseInt(request.getParameter("customer_id"));
				int site_id=(request.getParameter("site_id")==null || request.getParameter("site_id").trim().equals(""))?
						0:Integer.parseInt(request.getParameter("site_id"));
				int start=Integer.parseInt(request.getParameter("start"));
				int length=Integer.parseInt(request.getParameter("length"));
				Map<String,Object> data=new HashMap<>();
				int draw=Integer.parseInt(request.getParameter("draw"));
				data.put("data",dao.getSchedulingList(from_date, to_date, customer_id, site_id, start, length));
				data.put("draw", draw);
				int recordCount=dao.countSchedulingList(from_date, to_date, customer_id, site_id);
				data.put("recordsTotal", recordCount);
				data.put("recordsFiltered", recordCount);
				writer.print(gson.toJson(data));
			}
			
			
			else if(action.equals("changeStatus")) {
				String schStatus=request.getParameter("schStatus");
				int scheduling_id=Integer.parseInt(request.getParameter("scheduling_id"));
				int count=dao.changeSchedulingStatus(scheduling_id, schStatus);
				writer.println(count);
			}
		
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}

}
