package com.willka.soft.test.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.willka.soft.util.DBUtil;

/**
 * Servlet implementation class OtherController
 */
@WebServlet("/OtherControllerTest")
public class OtherController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter writer=response.getWriter();
		PreparedStatement ps=null;
		Connection con=null;
		ResultSet rs=null;
		
		try {
			String action=request.getParameter("action");
			
			if(action.equals("GetInvoieDetails")){
				
				response.setContentType("application/json");
				response.setCharacterEncoding("utf-8");
				
				String duration=request.getParameter("duration");
				SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd");
				Date dt=new Date();
				Calendar cal=Calendar.getInstance();
				con=DBUtil.getConnection();
				switch (duration) {
				
				case "t":{
					String date=format.format(dt);
					ps=con.prepareStatement("select sum(i.quantity) as quantsum,count(id) as totalinvoice,sum(net_amount) as totalamount," + 
							" p.product_name,c.customer_name,pl.plant_name" + 
							" from test_invoice i LEFT JOIN(test_customer c,product p,test_purchase_order_item poi,plant pl)" + 
							" ON i.poi_id=poi.poi_id" + 
							" and poi.product_id=p.product_id" + 
							" and i.customer_id=c.customer_id" + 
							" and i.plant_id=pl.plant_id" + 
							" where i.invoice_date=? and i.state = 'show' " + 
							" group by c.customer_name,p.product_name,plant_name");
					ps.setString(1,date);
					rs=ps.executeQuery();
					break;
				}
				
				case "y":{
					cal.setTime(dt);
					cal.add(Calendar.DATE,1);
					dt=cal.getTime();
					String date=format.format(dt);
					ps=con.prepareStatement("select sum(i.quantity) as quantsum,count(id) as totalinvoice,sum(net_amount) as totalamount," + 
							" p.product_name,c.customer_name,pl.plant_name" + 
							" from test_invoice i LEFT JOIN(test_customer c,product p,test_purchase_order_item poi,plant pl)" + 
							" ON i.poi_id=poi.poi_id" + 
							" and poi.product_id=p.product_id" + 
							" and i.customer_id=c.customer_id" + 
							" and i.plant_id=pl.plant_id" + 
							" where i.invoice_date=CURDATE()-interval 1 day and i.state = 'show'" + 
							" group by c.customer_name,p.product_name,plant_name");
					
					rs=ps.executeQuery();
					break;
				}
				
				case "tw":{
					ps=con.prepareStatement("select sum(i.quantity) as quantsum,count(id) as totalinvoice,sum(net_amount) as totalamount," + 
							" p.product_name,c.customer_name,pl.plant_name" + 
							" from test_invoice i LEFT JOIN(test_customer c,product p,test_purchase_order_item poi,plant pl)" + 
							" ON i.poi_id=poi.poi_id" + 
							" and poi.product_id=p.product_id" + 
							" and i.customer_id=c.customer_id" + 
							" and i.plant_id=pl.plant_id" + 
							" where i.invoice_date between  date(subdate(now(), INTERVAL weekday(now()) DAY)) and  adddate(now(), INTERVAL 6-weekday(now()) DAY) and i.state = 'show'" + 
							" group by c.customer_name,p.product_name,plant_name");
					rs=ps.executeQuery();
					break;
				}
				
				case "lw":{
					ps=con.prepareStatement("select sum(i.quantity) as quantsum,count(id) as totalinvoice,sum(net_amount) as totalamount," + 
							" p.product_name,c.customer_name,pl.plant_name" + 
							" from test_invoice i LEFT JOIN(test_customer c,product p,test_purchase_order_item poi,plant pl)" + 
							" ON i.poi_id=poi.poi_id" + 
							" and poi.product_id=p.product_id" + 
							" and i.customer_id=c.customer_id" + 
							" and i.plant_id=pl.plant_id" + 
							" where i.invoice_date between  (curdate() - INTERVAL((WEEKDAY(curdate()))+7) DAY) and  (curdate() - INTERVAL((WEEKDAY(curdate()))+1) DAY) and i.show = 'show'" + 
							" group by c.customer_name,p.product_name,plant_name");
					System.out.println(ps.toString());
					rs=ps.executeQuery();
					break;
				}
				case "tm":{
					ps=con.prepareStatement("select sum(i.quantity) as quantsum,count(id) as totalinvoice,sum(net_amount) as totalamount," + 
							" p.product_name,c.customer_name,pl.plant_name" + 
							" from test_invoice i LEFT JOIN(test_customer c,product p,test_purchase_order_item poi,plant pl)" + 
							" ON i.poi_id=poi.poi_id" + 
							" and poi.product_id=p.product_id" + 
							" and i.customer_id=c.customer_id" + 
							" and i.plant_id=pl.plant_id" + 
							" where i.invoice_date between  DATE_SUB( LAST_DAY( DATE_ADD(NOW(), INTERVAL 0 MONTH) ), INTERVAL DAY( LAST_DAY( DATE_ADD(NOW(), INTERVAL 0 MONTH) ) )-1 DAY )  and  LAST_DAY( DATE_ADD(NOW(), INTERVAL 0 MONTH) ) and i.state = 'show'" + 
							" group by c.customer_name,p.product_name,plant_name");
					rs=ps.executeQuery();
					break;
				}
				
				case "lm":{
					ps=con.prepareStatement("select sum(i.quantity) as quantsum,count(id) as totalinvoice,sum(net_amount) as totalamount," + 
							" p.product_name,c.customer_name,pl.plant_name" + 
							" from test_invoice i LEFT JOIN(test_customer c,product p,test_purchase_order_item poi,plant pl)" + 
							" ON i.poi_id=poi.poi_id" + 
							" and poi.product_id=p.product_id" + 
							" and i.customer_id=c.customer_id" + 
							" and i.plant_id=pl.plant_id" + 
							" where i.invoice_date between  DATE_SUB( LAST_DAY( DATE_ADD(NOW(), INTERVAL -1 MONTH) ), INTERVAL DAY( LAST_DAY( DATE_ADD(NOW(), INTERVAL -1 MONTH) ) )-1 DAY ) and  LAST_DAY( DATE_ADD(NOW(), INTERVAL -1 MONTH) ) and i.state = 'show'" + 
							" group by c.customer_name,p.product_name,plant_name");
					rs=ps.executeQuery();
					break;
				}
				
				default:
					
					break;
				}
				
				Gson gson=new Gson();
				ArrayList<HashMap<String, Object>> array=new ArrayList<>();
				int count=0;
				while(rs.next()) {
					count++;
					HashMap<String, Object> object=new HashMap<>();
					object.put("quantsum", rs.getString("quantsum"));
					object.put("totalinvoice", rs.getDouble("totalinvoice"));
					object.put("totalamount", rs.getDouble("totalamount"));
					object.put("product_name", rs.getString("product_name"));
					object.put("customer_name", rs.getString("customer_name"));
					object.put("plant_name", rs.getString("plant_name"));
					array.add(object);
				}
				
				if(count==0) {
					HashMap<String, Object> object=new HashMap<>();
					object.put("result", "noval");
					array.add(object);
					writer.println(gson.toJson(object));
					System.out.println(gson.toJson(object));
				}
				else
					writer.println(gson.toJson(array));
					System.out.println(gson.toJson(array));
				
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
	}

}
