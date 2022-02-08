package com.willka.soft.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.willka.soft.bean.InventoryOutgoingBean;
import com.willka.soft.bean.InventoryOutgoingItem;
import com.willka.soft.bean.StockBean;
import com.willka.soft.service.StockService;
import com.willka.soft.util.IndianDateFormater;
@WebServlet("/StockController")
public class StockController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter writer=response.getWriter();
		StockService service=new StockService();
		HttpSession session=request.getSession();
		try {
			String action=request.getParameter("action");
			if(action.equals("saveInventoryStock")) {
				int plant_id=Integer.parseInt(request.getParameter("plant_id"));
				String date=IndianDateFormater
						.converToIndianFormat(request.getParameter("date"));
				double quantity=Double.
							parseDouble(request.getParameter("quantity"));
				int inv_item_id=Integer.
						parseInt(request.getParameter("inv_item_id"));
				
				StockBean bean=new StockBean();
				bean.setInv_item_id(inv_item_id);
				bean.setPlant_id(plant_id);
				bean.setQuantity(quantity);
				bean.setDate(date);
				
				boolean isAdded=service.addStockService(bean);
				writer.println(isAdded?1:-1);
			}
			
			else if(action.equals("updateInventoryStock")) {
				int plant_id=Integer.parseInt(request.getParameter("plant_id"));
				String date=IndianDateFormater
						.converToIndianFormat(request.getParameter("date"));
				double quantity=Double.
							parseDouble(request.getParameter("quantity"));
				int inv_item_id=Integer.
						parseInt(request.getParameter("inv_item_id"));
				int stock_id=Integer.parseInt(request.getParameter("stock_id"));
				
				StockBean bean=new StockBean();
				bean.setInv_item_id(inv_item_id);
				bean.setPlant_id(plant_id);
				bean.setQuantity(quantity);
				bean.setDate(date);
				bean.setStock_id(stock_id);
				boolean isUpdated=service.updateclosingStock(bean);
				writer.println(isUpdated?1:-1);
				
			}
			
			else if(action.equals("deleteInventoryStock")) {
				int stock_id=Integer.parseInt(request.getParameter("stock_id"));
				boolean count=service.deleteClosingStock(stock_id);
				writer.println(count?1:-1);
			}
			
			else if(action.equals("getOpeningStockEntryDetails")) {
				response.setContentType("application/json");
				response.setCharacterEncoding("utf-8");
				Gson gson=new Gson();
				List<Map<String,Object>> list=service.getStockList();
				writer.println(gson.toJson(list));
			}
			
			else if(action.equals("getSingleOpeningStockDetails")) {
				response.setContentType("application/json");
				response.setCharacterEncoding("utf-8");
				Gson gson=new Gson();
				int stock_id=Integer
						.parseInt(request.getParameter("stock_id"));
				StockBean bean=service.getSingleStockDataForUpdate(stock_id);
				writer.println(gson.toJson(bean));
			}
			
			else if(action.equals("getItemDetails")) {
				response.setContentType("application/json");
				response.setCharacterEncoding("utf-8");
				Gson gson=new Gson();
				int product_id=Integer.parseInt(request.getParameter("product_id"));
				List<Map<String,Object>> list=service.getGradeCompositionList(product_id);
				writer.println(gson.toJson(list));
			}
			
			else if(action.equals("addProductionStock")) {
				int plant_id=Integer.parseInt(request.getParameter("plant_id"));
				int product_id=Integer.parseInt(request.getParameter("product_id"));
				String date=request.getParameter("date");
				double quantity=Double.parseDouble(request.getParameter("quantity"));
				String comment=request.getParameter("comment");
				String added_by=request.getParameter("added_by");
				double production_cost=Double.
						parseDouble(request.getParameter("production_cost"));
				int count=Integer.
							parseInt(request.getParameter("count"));
				
				
				InventoryOutgoingBean bean=new InventoryOutgoingBean();
				bean.setPlant_id(plant_id);
				bean.setProduct_id(product_id);
				bean.setDate(date);
				bean.setQuantity(quantity);
				bean.setAdded_by(added_by);
				bean.setComment(comment);
				bean.setProduction_cost(production_cost);
				
				List<InventoryOutgoingItem> list=new ArrayList<InventoryOutgoingItem>();
				for(int i=0;i<count;i++) {
					InventoryOutgoingItem ibean=new InventoryOutgoingItem();
					ibean.setInv_item_id(Integer.
									parseInt(request.getParameter("inv_item_id["+i+"]")));
					ibean.setQuantity(Double.
								parseDouble(request.getParameter("quantity["+i+"]")));
					list.add(ibean);
				}
				
				boolean added=service.addProductionStock(bean, list);
				session.setAttribute("result", added);
				response.sendRedirect("ProductionList.jsp");
			}
			
			
			else if(action.equals("updateProductionStock")) {
				int invout_id=Integer.parseInt(request.getParameter("invout_id"));
				int plant_id=Integer.parseInt(request.getParameter("plant_id"));
				int product_id=Integer.parseInt(request.getParameter("product_id"));
				String date=request.getParameter("date");
				double quantity=Double.parseDouble(request.getParameter("quantity"));
				String comment=request.getParameter("comment");
				String added_by=request.getParameter("added_by");
				double production_cost=Double.
						parseDouble(request.getParameter("production_cost"));
				int count=Integer.
							parseInt(request.getParameter("count"));
				
				
				InventoryOutgoingBean bean=new InventoryOutgoingBean();
				bean.setPlant_id(plant_id);
				bean.setProduct_id(product_id);
				bean.setDate(date);
				bean.setQuantity(quantity);
				bean.setAdded_by(added_by);
				bean.setComment(comment);
				bean.setProduction_cost(production_cost);
				bean.setInvout_id(invout_id);
				
				List<InventoryOutgoingItem> list=new ArrayList<InventoryOutgoingItem>();
				for(int i=0;i<count;i++) {
					try {
						InventoryOutgoingItem ibean=new InventoryOutgoingItem();
						ibean.setInv_item_id(Integer.
										parseInt(request.getParameter("inv_item_id["+i+"]")));
						ibean.setQuantity(Double.
									parseDouble(request.getParameter("quantity["+i+"]")));
						ibean.setInvout_item_id(Integer.parseInt(request.getParameter("invout_item_id["+i+"]")));
						list.add(ibean);
					}catch(Exception e) {
						e.printStackTrace();
						InventoryOutgoingItem ibean=new InventoryOutgoingItem();
						ibean.setInv_item_id(Integer.
										parseInt(request.getParameter("inv_item_id["+i+"]")));
						ibean.setQuantity(Double.
									parseDouble(request.getParameter("quantity["+i+"]")));
						ibean.setInvout_item_id(0);
						list.add(ibean);
					}
				}
				
				boolean added=service.updateProductionStock(bean);
				boolean itemUpdated=service.updateInventoryOutgoingItem(list, invout_id);
				session.setAttribute("updateResult", added);
				response.sendRedirect("ProductionList.jsp");
			}
			
			else if(action.equals("getProductionList")) {
				response.setContentType("application/json");
				response.setCharacterEncoding("utf-8");
				Gson gson=new Gson();
				String from_date=request.getParameter("from_date");
				String to_date=request.getParameter("to_date");
				int product_id=(request.getParameter("product_id")==null || request.getParameter("product_id").trim().equals(""))?
						0:Integer.parseInt(request.getParameter("product_id"));
				int plant_id=Integer.parseInt(request.getParameter("plant_id"));
				int start=Integer.parseInt(request.getParameter("start"));
				int length=Integer.parseInt(request.getParameter("length"));
				int draw=Integer.parseInt(request.getParameter("draw"));
				Map<String,Object> data=service.getProductionList(product_id, from_date,
							to_date, plant_id, start, length, draw);
				writer.print(gson.toJson(data));
			}
			
			
			else if(action.equals("deleteProductionDetails")) {
				int invout_id=Integer.parseInt(request.getParameter("invout_id"));
				boolean result=service.deleteProductionDetails(invout_id);
				writer.println(result);
			}
			
			
			
			else if(action.equals("insertInventoryOutgoing")) {
				int plant_id=Integer
						.parseInt(request.getParameter("plant_id"));
				int inv_item_id=Integer
						.parseInt(request.getParameter("inv_item_id"));
				String consumption_date=request.getParameter("consumption_date");
				double consumption_quantity=Double
						.parseDouble(request.getParameter("consumption_quantity"));
				String added_by=request.getParameter("added_by");
				String comment=request.getParameter("comment");
				
				
				InventoryOutgoingBean bean=new InventoryOutgoingBean();
				bean.setPlant_id(plant_id);
				bean.setDate(consumption_date);
				bean.setAdded_by(added_by);
				bean.setComment(comment);
				bean.setType("consumption");
				
				
				List<InventoryOutgoingItem> list=new ArrayList<>();
				InventoryOutgoingItem item=new InventoryOutgoingItem();
				item.setInv_item_id(inv_item_id);
				item.setQuantity(consumption_quantity);
				list.add(item);
				boolean added=service.addProductionStock(bean, list);
				writer.println(added?1:-1);
			}
			
			else if(action.equals("getInventoryOutgoingList")) {
				response.setContentType("application/json");
				response.setCharacterEncoding("utf-8");
				Gson gson=new Gson();
				String from_date=request.getParameter("from_date");
				String to_date=request.getParameter("to_date");
				int inv_item_id=(request.getParameter("inv_item_id")==null || request.getParameter("inv_item_id").trim().equals(""))?
						0:Integer.parseInt(request.getParameter("inv_item_id"));
				int plant_id=Integer.parseInt(request.getParameter("plant_id"));
				int start=Integer.parseInt(request.getParameter("start"));
				int length=Integer.parseInt(request.getParameter("length"));
				int draw=Integer.parseInt(request.getParameter("draw"));
				Map<String,Object> data=service.getInventoryOutgoingList(inv_item_id,
											from_date, to_date, plant_id, start, length, draw);
				writer.print(gson.toJson(data));
			}
			
			else if(action.equals("getSingleInventoryOutgoingForUpdate")) {
				response.setContentType("application/json");
				response.setCharacterEncoding("utf-8");
				Gson gson=new Gson();
				int invout_id=Integer
						.parseInt(request.getParameter("invout_id"));
				
			}
			
			
			else if(action.equals("getConvertedQuantityDetails")) {
				Gson gson=new Gson();
				int product_id=Integer.parseInt(request.getParameter("product_id"));
				Map<String,Object> data=service.getConversionDetails(product_id);
				writer.println(gson.toJson(data));
			}
			
			//report part
			else if(action.equals("getDateWiseReport")) {
				response.setContentType("application/json");
				response.setCharacterEncoding("utf-8");
				Gson gson=new Gson();
				int product_id=Integer
						.parseInt(request.getParameter("product_id"));
				int plant_id=Integer
						.parseInt(request.getParameter("plant_id"));
				String from_date=IndianDateFormater
						.converToIndianFormat(request.getParameter("from_date"));
				String to_date=IndianDateFormater
						.converToIndianFormat(request.getParameter("to_date"));
				List<Map<String,Object>> list=service.getDateWiseReportList(from_date, to_date, product_id, plant_id);
				writer.println(gson.toJson(list));
			}
			
			else if(action.equals("getStockReport")) {
				response.setContentType("application/json");
				response.setCharacterEncoding("utf-8");
				Gson gson=new Gson();
				int product_id=Integer
						.parseInt(request.getParameter("product_id"));
				int plant_id=Integer
						.parseInt(request.getParameter("plant_id"));
				String from_date=IndianDateFormater
						.converToIndianFormat(request.getParameter("from_date"));
				String to_date=IndianDateFormater
						.converToIndianFormat(request.getParameter("to_date"));
				
				List<Map<String,Object>> data=service.getStockReport(from_date, to_date, product_id, plant_id);
				writer.println(gson.toJson(data));
			}
			
			
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}

}
