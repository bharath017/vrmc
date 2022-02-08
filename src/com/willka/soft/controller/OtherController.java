package com.willka.soft.controller;

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
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.willka.soft.dao.InvoiceDAO;
import com.willka.soft.dao.InvoiceDAOImpl;
import com.willka.soft.util.DBUtil;

/**
 * Servlet implementation class OtherController
 */
@WebServlet("/OtherController")
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
				
				//check here
				
				/*SmsSenderDAOImpl dao=new SmsSenderDAOImpl();
				dao.getWithBillDetails();*/
				
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
							" from invoice i LEFT JOIN(customer c,product p,purchase_order_item poi,plant pl)" + 
							" ON i.poi_id=poi.poi_id" + 
							" and poi.product_id=p.product_id" + 
							" and i.customer_id=c.customer_id" + 
							" and i.plant_id=pl.plant_id" + 
							" where i.invoice_date=? and i.invoice_status='active'" + 
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
							" from invoice i LEFT JOIN(customer c,product p,purchase_order_item poi,plant pl)" + 
							" ON i.poi_id=poi.poi_id" + 
							" and poi.product_id=p.product_id" + 
							" and i.customer_id=c.customer_id" + 
							" and i.plant_id=pl.plant_id" + 
							" where i.invoice_date=CURDATE()-interval 1 day and i.invoice_status='active'" + 
							" group by c.customer_name,p.product_name,plant_name");
					
					rs=ps.executeQuery();
					break;
				}
				
				case "tw":{
					ps=con.prepareStatement("select sum(i.quantity) as quantsum,count(id) as totalinvoice,sum(net_amount) as totalamount," + 
							" p.product_name,c.customer_name,pl.plant_name" + 
							" from invoice i LEFT JOIN(customer c,product p,purchase_order_item poi,plant pl)" + 
							" ON i.poi_id=poi.poi_id" + 
							" and poi.product_id=p.product_id" + 
							" and i.customer_id=c.customer_id" + 
							" and i.plant_id=pl.plant_id" + 
							" where i.invoice_date between  date(subdate(now(), INTERVAL weekday(now()) DAY)) and  adddate(now(), INTERVAL 6-weekday(now()) DAY) and i.invoice_status='active'" + 
							" group by c.customer_name,p.product_name,plant_name");
					rs=ps.executeQuery();
					break;
				}
				
				case "lw":{
					ps=con.prepareStatement("select sum(i.quantity) as quantsum,count(id) as totalinvoice,sum(net_amount) as totalamount," + 
							" p.product_name,c.customer_name,pl.plant_name" + 
							" from invoice i LEFT JOIN(customer c,product p,purchase_order_item poi,plant pl)" + 
							" ON i.poi_id=poi.poi_id" + 
							" and poi.product_id=p.product_id" + 
							" and i.customer_id=c.customer_id" + 
							" and i.plant_id=pl.plant_id" + 
							" where i.invoice_date between  (curdate() - INTERVAL((WEEKDAY(curdate()))+7) DAY) and  (curdate() - INTERVAL((WEEKDAY(curdate()))+1) DAY) and i.invoice_status='active'" + 
							" group by c.customer_name,p.product_name,plant_name");
					System.out.println(ps.toString());
					rs=ps.executeQuery();
					break;
				}
				case "tm":{
					ps=con.prepareStatement("select sum(i.quantity) as quantsum,count(id) as totalinvoice,sum(net_amount) as totalamount," + 
							" p.product_name,c.customer_name,pl.plant_name" + 
							" from invoice i LEFT JOIN(customer c,product p,purchase_order_item poi,plant pl)" + 
							" ON i.poi_id=poi.poi_id" + 
							" and poi.product_id=p.product_id" + 
							" and i.customer_id=c.customer_id" + 
							" and i.plant_id=pl.plant_id" + 
							" where i.invoice_date between  DATE_SUB( LAST_DAY( DATE_ADD(NOW(), INTERVAL 0 MONTH) ), INTERVAL DAY( LAST_DAY( DATE_ADD(NOW(), INTERVAL 0 MONTH) ) )-1 DAY )  and  LAST_DAY( DATE_ADD(NOW(), INTERVAL 0 MONTH) ) and i.invoice_status='active'" + 
							" group by c.customer_name,p.product_name,plant_name");
					rs=ps.executeQuery();
					break;
				}
				
				case "lm":{
					ps=con.prepareStatement("select sum(i.quantity) as quantsum,count(id) as totalinvoice,sum(net_amount) as totalamount," + 
							" p.product_name,c.customer_name,pl.plant_name" + 
							" from invoice i LEFT JOIN(customer c,product p,purchase_order_item poi,plant pl)" + 
							" ON i.poi_id=poi.poi_id" + 
							" and poi.product_id=p.product_id" + 
							" and i.customer_id=c.customer_id" + 
							" and i.plant_id=pl.plant_id" + 
							" where i.invoice_date between  DATE_SUB( LAST_DAY( DATE_ADD(NOW(), INTERVAL -1 MONTH) ), INTERVAL DAY( LAST_DAY( DATE_ADD(NOW(), INTERVAL -1 MONTH) ) )-1 DAY ) and  LAST_DAY( DATE_ADD(NOW(), INTERVAL -1 MONTH) ) and i.invoice_status='active'" + 
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
				}
				else
					writer.println(gson.toJson(array));
			}
			
			else if(action.equals("getInvoiceNo")) {
				InvoiceDAO dao=new InvoiceDAOImpl();
				int plant_id=Integer.parseInt(request.getParameter("plant_id"));
				Calendar c=Calendar.getInstance();
				int month=c.get(Calendar.MONTH);
				int start_year=(month>=3)?c.get(Calendar.YEAR):c.get(Calendar.YEAR)-1;
				int end_year=(month>=3)?c.get(Calendar.YEAR)+1:c.get(Calendar.YEAR);
				int invoice_no=dao.getInvoiceNo(plant_id, start_year, end_year);
				writer.println(invoice_no);
			}

			else if(action.equals("getStockReport")) {
				response.setContentType("application/json");
				response.setCharacterEncoding("utf-8");
				Gson gson=new Gson();
				String sql="select sum((p.credit-p.debit)) as stock,"+
						" pl.plant_name,p.plant_id,it.inventory_name,it.stock_unit"+
						" from("+
						 	" select sum(net_weight) as credit, 0 as debit ,plant_id,inv_item_id"+
							" from inventory"+
							" group by plant_id,inv_item_id"+
							" UNION ALL"+ 
							" select 0 as credit,sum(ii.quantity) as debit,plant_id,ii.inv_item_id"+
							" from inventory_outgoing i,inventory_outgoing_item ii "+
							" where i.invout_id=ii.invout_id "+
							" group by plant_id,inv_item_id"+
						" ) as p,plant pl,inventory_item it"+
						" where p.plant_id=pl.plant_id"+
						" and p.inv_item_id=it.inv_item_id"+
						" group by pl.plant_name,p.plant_id,it.inventory_name,p.inv_item_id,it.stock_unit"+
						" order by p.plant_id,p.inv_item_id asc";
				con=DBUtil.getConnection();
				ps=con.prepareStatement(sql,ResultSet.TYPE_SCROLL_INSENSITIVE);
				rs=ps.executeQuery();
				List<Map<String,Object>> dataList=new ArrayList<>();
				
				//get all the plant
				Map<Integer,String> data=new HashMap<>();
				while(rs.next()) {
					data.put(rs.getInt("plant_id"), rs.getString("plant_name"));
				}
				rs.beforeFirst();
				for(Map.Entry<Integer, String> entry:data.entrySet()) {
					Map<String,Object> mainData=new HashMap<>();
					mainData.put("plant_name", entry.getValue());
					mainData.put("plant_id", entry.getKey());
					List<Map<String,Object>> stockList=new ArrayList<>();
					while(rs.next()) {
						Map<String,Object> stock=new HashMap<>();
						if(rs.getInt("plant_id")==entry.getKey()) {
							stock.put("item_name", rs.getString("inventory_name"));
							stock.put("item_value", rs.getDouble("stock"));
							stock.put("stock_unit", rs.getString("stock_unit"));
							stockList.add(stock);
						}
					}
					mainData.put("stockList", stockList);
					dataList.add(mainData);
					rs.beforeFirst();
				}
				writer.println(gson.toJson(dataList));
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
	}

}
