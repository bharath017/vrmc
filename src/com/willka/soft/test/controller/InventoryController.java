package com.willka.soft.test.controller;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.Enumeration;
import java.util.Hashtable;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.willka.soft.bean.UserDetailBean;
import com.willka.soft.test.bean.Inventory;
import com.willka.soft.test.bean.InventoryModificationBean;
import com.willka.soft.test.bean.InventoryStockBean;
import com.willka.soft.test.dao.InventoryDAO;
import com.willka.soft.test.dao.InventoryDAOImpl;

import javazoom.upload.MultipartFormDataRequest;
import javazoom.upload.UploadBean;
import javazoom.upload.UploadFile;


/**
 * Servlet implementation class InventoryController
 */
@WebServlet("/InventoryControllerTest")
public class InventoryController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session=request.getSession();
		InventoryDAO dao=new InventoryDAOImpl();
		PrintWriter writer=response.getWriter();
		try {
			String action=request.getParameter("action");
			if(action.equals("InsertInventoryItem")) {
				String inventory_name=request.getParameter("inventory_name");
				String stock_unit=request.getParameter("unit");
				int count=dao.insertInventoryItem(inventory_name,stock_unit);
				if(count>0) {
					session.setAttribute("res", "Inventory Item Inserted");
					response.sendRedirect("inventory_item.jsp");
				}else {
					session.setAttribute("res", "<span class='text-danger'>Failed!!</span>");
					response.sendRedirect("inventory_item.jsp");
				}
			}
			
			else if(action.equals("UpdateItem")) {
				int inv_item_id=Integer.parseInt(request.getParameter("inv_item_id"));
				String inventory_name=request.getParameter("inventory_name");
				String stock_unit=request.getParameter("unit");
				int count=dao.updateInventoryItem(inventory_name,inv_item_id, stock_unit);
				if(count>0) {
					session.setAttribute("res", "Updated Successfully");
					response.sendRedirect("inventory_item.jsp");
				}else {
					session.setAttribute("res", "<span class='text-danger'>Failed!!<span>");
					response.sendRedirect("inventory_item.jsp");
				}
				
			}
			
			else if(action.equals("DeleteInventoryItem")) {
				try {
					int inv_item_id=Integer.parseInt(request.getParameter("inv_item_id"));
					int count=dao.deleteInventoryItem(inv_item_id);
					if(count>0) {
						session.setAttribute("res", "Deleted Successfully");
						response.sendRedirect("inventory_item.jsp");
					}else {
						session.setAttribute("res", "<span class='text-danger'>Failed!!<span>");
						response.sendRedirect("inventory_item.jsp");
					}
				}catch(Exception e) {
					int inv_item_id=Integer.parseInt(request.getParameter("inv_item_id"));
					int count=dao.deleteInventoryItem(inv_item_id);
					if(count>0) {
						session.setAttribute("res", "Deleted Successfully");
						response.sendRedirect("inventory_item.jsp");
					}else {
						session.setAttribute("res", "<span class='text-danger'>Cann't delete Item already in use!!<span>");
						response.sendRedirect("inventory_item.jsp");
					}
				}
			}
			
			else if(action.equals("getItemList")) {
				response.setContentType("application/json");
				response.setCharacterEncoding("utf-8");
				Gson gson=new Gson();
				Map<Integer,String> data=dao.getInventoryItemList();
				writer.println(gson.toJson(data));
			}
			
			
			else if(action.equals("updateStock")) {
				int stock_id=Integer.parseInt(request.getParameter("stock_id"));
				double stock_quantity=Double.parseDouble(request.getParameter("stock_quantity"));
				int count=dao.changeStockQuantity(stock_id, stock_quantity);
				if(count>0) {
					session.setAttribute("res", "Stock Changed");
					response.sendRedirect("InventoryItemList.jsp");
				}else {
					session.setAttribute("res", "<span class='text-danger'>Failed!!<span>");
					response.sendRedirect("InventoryItemList.jsp");
				}
			}
			
			
			else if(action.equals("getUnit")) {
				int inv_item_id=Integer.parseInt(request.getParameter("inv_item_id"));
				String item=dao.getItemUnitName(inv_item_id);
				writer.print(item);
			}
			
			
			else if(action.equals("InsertInventory")) {
				synchronized (request) {
					HttpSession ses=request.getSession();
					int inv_item_id=Integer.parseInt(request.getParameter("inv_item_id"));
					double empty_weight=Double.parseDouble(request.getParameter("empty_weight"));
					double loaded_weight=Double.parseDouble(request.getParameter("loaded_weight"));
					double net_weight=Double.parseDouble(request.getParameter("net_weight"));
					double supplier_weight=Double.parseDouble(request.getParameter("supplier_weight"));
					int supplier_id=Integer.parseInt(request.getParameter("supplier_id"));
					String vehicle_no=request.getParameter("vehicle_no");
					String  bill_no=request.getParameter("bill_no");
					String date=request.getParameter("inventory_date");
					String time=request.getParameter("inventory_time");
					float moisture_percent=(request.getParameter("moisture_percent")==null || request.getParameter("moisture_percent").trim().equals(""))?0:Float.parseFloat(request.getParameter("moisture_percent"));
					double after_weight=(request.getParameter("after_weight")==null || request.getParameter("after_weight").trim().equals(""))?0.0:Double.parseDouble(request.getParameter("after_weight"));
					int plant_id=Integer.parseInt(request.getParameter("plant_id"));
					String gatepass_no=request.getParameter("gatepass_no");
					String unit=request.getParameter("unit");
					String royalty_no=request.getParameter("royalty_no");
					int pl_delivery_address_id=(request.getParameter("pl_delivery_address_id")==null || request.getParameter("pl_delivery_address_id").trim().equals(""))
							?0:Integer.parseInt(request.getParameter("pl_delivery_address_id"));
					String inventory_document=request.getParameter("inventory_document");
					
					Inventory bean=new Inventory();
					
					bean.setInv_item_id(inv_item_id);
					bean.setSupplier_id(supplier_id);
					bean.setEmpty_weight(empty_weight);
					bean.setLoaded_weight(loaded_weight);
					bean.setNet_weight(net_weight);
					bean.setVehicle_no(vehicle_no);
					bean.setBill_no(bill_no);
					bean.setDate(date);
					bean.setTime(time);
					bean.setSupplier_weight(supplier_weight);
					bean.setAfter_weight(after_weight);
					bean.setMoisture_percent(moisture_percent);
					bean.setPlant_id(plant_id);
					bean.setGatepass_no(gatepass_no);
					bean.setUnit(unit);
					bean.setRoyalty_no(royalty_no);
					bean.setPl_delivery_address_id(pl_delivery_address_id);
					bean.setInventory_document(inventory_document);
					int count=dao.insertInventory(bean);
//					int count=dao.insertInve
					if(count>0) {
						ses.setAttribute("res","Inventory : "+inv_item_id+" INSERTION IS SUCCESSFUL");
						response.sendRedirect("gst/InventoryList.jsp");
					}
					else{
						ses.setAttribute("res","Inventory : "+inv_item_id+" INSERTION IS UNSUCCESSFUL");
						response.sendRedirect("gst/InventoryList.jsp");
					}
				}
				
		}
			else if(action.equals("UpdateInventory")) {
				
				HttpSession ses=request.getSession();
				synchronized (request) {
					int inventory_id=Integer.parseInt(request.getParameter("inventory_id"));
					int inv_item_id=Integer.parseInt(request.getParameter("inv_item_id"));
					double empty_weight=Double.parseDouble(request.getParameter("empty_weight"));
					double loaded_weight=Double.parseDouble(request.getParameter("loaded_weight"));
					double net_weight=Double.parseDouble(request.getParameter("net_weight"));
					double supplier_weight=Double.parseDouble(request.getParameter("supplier_weight"));
					int supplier_id=Integer.parseInt(request.getParameter("supplier_id"));
					String vehicle_no=request.getParameter("vehicle_no");
					String  bill_no=request.getParameter("bill_no");
					String date=request.getParameter("inventory_date");
					String time=request.getParameter("inventory_time");
					float moisture_percent=(request.getParameter("moisture_percent")==null || request.getParameter("moisture_percent").trim().equals(""))?0:Float.parseFloat(request.getParameter("moisture_percent"));
					double after_weight=(request.getParameter("after_weight")==null || request.getParameter("after_weight").trim().equals(""))?0.0:Double.parseDouble(request.getParameter("after_weight"));
					int plant_id=Integer.parseInt(request.getParameter("plant_id"));
					String modification_comment=request.getParameter("modification_comment");
					String gatepass_no=request.getParameter("gatepass_no");
					String unit=request.getParameter("unit");
					String royalty_no=request.getParameter("royalty_no");
					int pl_delivery_address_id=(request.getParameter("pl_delivery_address_id")==null || request.getParameter("pl_delivery_address_id").trim().equals(""))
							?0:Integer.parseInt(request.getParameter("pl_delivery_address_id"));
					
					Inventory bean=new Inventory();
					
					bean.setInventory_id(inventory_id);
					bean.setInv_item_id(inv_item_id);
					bean.setSupplier_id(supplier_id);
					bean.setEmpty_weight(empty_weight);
					bean.setLoaded_weight(loaded_weight);
					bean.setNet_weight(net_weight);
					bean.setVehicle_no(vehicle_no);
					bean.setBill_no(bill_no);
					bean.setDate(date);
					bean.setTime(time);
					bean.setAfter_weight(after_weight);
					bean.setMoisture_percent(moisture_percent);
					bean.setSupplier_weight(supplier_weight);
					bean.setPlant_id(plant_id);
					bean.setGatepass_no(gatepass_no);
					bean.setUnit(unit);
					bean.setRoyalty_no(royalty_no);
					bean.setPl_delivery_address_id(pl_delivery_address_id);
					
					Inventory ibeen=dao.getSingleInventoryDetails(inventory_id);
					int count=dao.updateInventory(bean);
					if(count>0) {
						//now update inventory details
						InventoryModificationBean modbean=new InventoryModificationBean();
						modbean.setInventory_id(inventory_id);
						modbean.setModification_comment(modification_comment);
						modbean.setOld_net_weight(ibeen.getNet_weight());
						modbean.setNew_net_weight(net_weight);
						modbean.setOld_supplier_weight(supplier_weight);
						modbean.setNew_supplier_weight(ibeen.getSupplier_weight());
						
						UserDetailBean been=(UserDetailBean)session.getAttribute("bean");
						modbean.setModification_user(been.getUsername());
						dao.insertInventoryModification(modbean);
						
						ses.setAttribute("res","Inventory : "+inventory_id+" UPDATION IS SUCCESSFUL");
						response.sendRedirect("gst/InventoryList.jsp");
					}
					else{
						ses.setAttribute("res","Inventory : "+inventory_id+" UPDATION IS UNSUCCESSFUL");
						response.sendRedirect("gst/InventoryList.jsp");
				  }
				}
		}
			
			else if(action.equals("delete")){
				int inventory_id=Integer.parseInt(request.getParameter("inventory_id"));
				Inventory ibeen=dao.getSingleInventoryDetails(inventory_id);
				InventoryStockBean stock=dao.getStockDetails(ibeen.getInv_item_id(), ibeen.getPlant_id());
				int count=dao.deleteInventory(inventory_id);
				if(count>0) {
					stock.setStock_quantity(stock.getStock_quantity()-ibeen.getNet_weight());
					dao.updateInventoryStock(stock);
					session.setAttribute("result", "Inventory Id : "+inventory_id+" Deleted Successfully");
					response.sendRedirect("InventoryList.jsp");
				}else {
					session.setAttribute("result", "Deletion Failed!!");
					response.sendRedirect("InventoryList.jsp");
				}
			}
			

			else if(action.equals("cancel")){
				//get HttpSession object
				HttpSession ses=request.getSession();
				
					int inv_item_id=Integer.parseInt(request.getParameter("inv_item_id"));
					
					int count=dao.CancelInventoryItem(inv_item_id);
					if(count>0){
						ses.setAttribute("result","Item ID : "+inv_item_id+" CANCEL IS SUCCESSFUL");
						response.sendRedirect("InventoryItemList.jsp");
					}
					else{
						ses.setAttribute("result","Item ID : "+inv_item_id+" CANCEL IS UNSUCCESSFUL");
						response.sendRedirect("InventoryItemList.jsp");
					}
			}
			
			
			else if(action.equals("changeItemStatus")) {
				HttpSession ses=request.getSession();
				
				int inv_item_id=Integer.parseInt(request.getParameter("inv_item_id"));
				String status=request.getParameter("item_status");
				
				int count=dao.changeInventoryItemStatus(inv_item_id, status);
				if(count>0) {
					ses.setAttribute("res", "Item Status Changed");
					response.sendRedirect("InventoryItemList.jsp");
				}else {
					ses.setAttribute("res", "<span class='text-danger'>Failed!!</span>");
					response.sendRedirect("InventoryItemList.jsp");
				}
			}
			
			else if(action.equals("cancelInventory")){
				//get HttpSession object
				HttpSession ses=request.getSession();
					int inventory_id=Integer.parseInt(request.getParameter("inventory_id"));
					Inventory inventory=dao.getSingleInventoryDetails(inventory_id);
					int count=dao.cancelInventory(inventory_id);
					if(count>0){
					/*	//reduce the detils
						InventoryStockBean stock=dao.getStockDetails(inventory.getInv_item_id(), inventory.getPlant_id());
						stock.setStock_quantity(stock.getStock_quantity()-inventory.getNet_weight());
						dao.updateInventoryStock(stock);*/
						ses.setAttribute("res","Inventory ID : "+inventory_id+" CANCEL IS SUCCESSFUL");
						response.sendRedirect("gst/InventoryList.jsp");
					}
					else{
						ses.setAttribute("res","Inventory ID : "+inventory_id+" CANCEL IS UNSUCCESSFUL");
						response.sendRedirect("gst/InventoryList.jsp");
					}
			}
			
			
			
			else if(action.equals("InsertInventoryVehicle")) {
				try {
					String vehicle_no=request.getParameter("vehicle_no");
					int count=dao.insertInventoryVehicle(vehicle_no);
					if(count>0) {
						session.setAttribute("res", "Vehicle Inserted Successfully");
						response.sendRedirect("gst/AddInventory.jsp");
					}else {
						session.setAttribute("res", "<span class='text-danger'>Failed!!!</span>");
						response.sendRedirect("AddInventory.jsp");
					}
				}catch(Exception e) {
					session.setAttribute("res", "<span class='text-danger'>Vehicle Exist!! Please Search</span>");
					response.sendRedirect("gst/AddInventory.jsp");
				}
			}
			
			else if(action.equals("UpdateLoadedWeight")) {
				String vehicle_no=request.getParameter("vehicle_no");
				double loaded_weight=Double.parseDouble(request.getParameter("loaded_weight"));
				
				int count=dao.updateLoadedWeight(vehicle_no, loaded_weight);
				
				if(count>0) {
					session.setAttribute("res", "Loaded Weight Updated Successfully");
					response.sendRedirect("gst/AddInventory.jsp");
				}else {
					session.setAttribute("res", "<span class='text-danger'>Failed!!!</span>");
					response.sendRedirect("gst/AddInventory.jsp");
				}
			}
			 
			else if(action.equals("GetLoadedWeight")) {
				String vehicle_no=request.getParameter("vehicle_no");
				double loaded_weight=dao.getLoadedWeight(vehicle_no);
				writer.print(loaded_weight);
			}
			
			
			
			else if (action.equals("GetInventoryReport")) {
				response.setContentType("application/json");
				response.setCharacterEncoding("utf-8");
				Gson gson=new Gson();
				String from_date=request.getParameter("from_date");
				String to_date=request.getParameter("to_date");
				int supplier_id=Integer
						.parseInt(request.getParameter("supplier_id"));
				int inv_item_id=Integer
						.parseInt(request.getParameter("inv_item_id"));
				int plant_id=Integer
						.parseInt(request.getParameter("plant_id"));
				int business_id=Integer
						.parseInt(request.getParameter("business_id"));
				List<Map<String,Object>> list=dao.getDatewiseReport(from_date, to_date, supplier_id, inv_item_id, plant_id,  business_id);
				writer.println(gson.toJson(list));
			}
			
			
			else if (action.equals("getSupplierWithDateWiseReport")) {
				response.setContentType("application/json");
				response.setCharacterEncoding("utf-8");
				Gson gson=new Gson();
				String from_date=request.getParameter("from_date");
				String to_date=request.getParameter("to_date");
				int supplier_id=Integer
						.parseInt(request.getParameter("supplier_id"));
				int inv_item_id=Integer
						.parseInt(request.getParameter("inv_item_id"));
				int plant_id=Integer
						.parseInt(request.getParameter("plant_id"));
				int business_id=Integer
						.parseInt(request.getParameter("business_id"));
				List<Map<String,Object>> list=dao.supplierwithDatewiseReport(from_date, to_date, supplier_id, inv_item_id, plant_id,  business_id);
				writer.println(gson.toJson(list));
			}
			
			
			else if(action.equals("getStockReport")) {
				response.setContentType("application/json");
				response.setCharacterEncoding("utf-8");
				Gson gson=new Gson();
				int inv_item_id=Integer.parseInt(request.getParameter("inv_item_id"));
				int plant_id=Integer.parseInt(request.getParameter("plant_id"));
				String from_date=(request.getParameter("from_date"));
				String to_date=(request.getParameter("to_date"));				
				List<Map<String,Object>> data=dao.getStockReport(from_date, to_date, inv_item_id, plant_id);
				writer.println(gson.toJson(data));
			}
			
			
			else if(action.equals("getDateWithItemGroupBy")) {
				response.setContentType("application/json");
				response.setCharacterEncoding("utf-8");
				Gson gson=new Gson();
				int inv_item_id=Integer.parseInt(request.getParameter("inv_item_id"));
				int plant_id=Integer.parseInt(request.getParameter("plant_id"));
				String from_date=request.getParameter("from_date");
				String to_date=request.getParameter("to_date");
				List<Map<String,Object>> data=dao.getDateWithItemGroupWiseReport(from_date, to_date, inv_item_id, plant_id);
				writer.println(gson.toJson(data));
			}
			
			else if(action.equals("getGroupBySupplierName")) {
				response.setContentType("application/json");
				response.setCharacterEncoding("utf-8");
				Gson gson=new Gson();
				int inv_item_id=Integer.parseInt(request.getParameter("inv_item_id"));
				int plant_id=Integer.parseInt(request.getParameter("plant_id"));
				int supplier_id=Integer
						.parseInt(request.getParameter("supplier_id"));
				List<Map<String,Object>> data=dao.getSupplierWithItemWiseReport(inv_item_id, supplier_id, plant_id);
				writer.println(gson.toJson(data));
			}
			
			else if(action.equals("getSupplierWithDateWiseGroupBy")) {
				response.setContentType("application/json");
				response.setCharacterEncoding("utf-8");
				Gson gson=new Gson();
				int inv_item_id=Integer.parseInt(request.getParameter("inv_item_id"));
				int plant_id=Integer.parseInt(request.getParameter("plant_id"));
				String from_date=request.getParameter("from_date");
				String to_date=request.getParameter("to_date");
				int supplier_id=Integer.
						parseInt(request.getParameter("supplier_id"));
				List<Map<String,Object>> data=dao.getSupplierWithDateWiseItemReport(from_date, to_date, inv_item_id, supplier_id, plant_id);
				writer.println(gson.toJson(data));
			}
			
			
			else if(action.equals("uploadInventoryDocument")) {
				String user_id=request.getParameter("user_id");
				//System.out.println("coming here");
				Properties prop=new Properties();
				ClassLoader classLoader = Thread.currentThread().getContextClassLoader();
				InputStream input = classLoader.getResourceAsStream("com/willka/soft/util/Util.properties");
				prop.load(input);
				String path=prop.getProperty("inventoryPath");
				//System.out.println(path);
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
					long currentTimeMillies=System.currentTimeMillis();
					UploadFile f=(UploadFile)e.nextElement();
					String extension=f.getFileName().substring(f.getFileName().lastIndexOf("."),f.getFileName().length());
					f.setFileName("INV_GST_"+currentTimeMillies+extension);
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
				writer.println(file_name);
			}
			
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
	}

}
