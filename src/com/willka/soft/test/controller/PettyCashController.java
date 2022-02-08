package com.willka.soft.test.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.willka.soft.bean.UserDetailBean;
import com.willka.soft.test.bean.PettyCashBean;
import com.willka.soft.test.bean.PettyCashModificationBean;
import com.willka.soft.test.bean.PettyCashTransactionBean;
import com.willka.soft.test.dao.PettyCashDAOImpl;
import com.willka.soft.util.IndianDateFormater;

/**
 * Servlet implementation class PettyCashController
 */
@WebServlet("/PettyCashControllerTest")
public class PettyCashController extends HttpServlet {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 9876982391L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request,response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html");
		PrintWriter writer=response.getWriter();
		HttpSession session=request.getSession();
		PettyCashDAOImpl dao=new PettyCashDAOImpl();
		try {
			String action=request.getParameter("action");
			
			if(action.equals("InsertPettyCash")) {
				//System.out.println(request.getParameter("plant_id"));
				int plant_id=Integer.parseInt(request.getParameter("plant_id"));
				String date=IndianDateFormater.
							converToIndianFormat(request.getParameter("date"));
				double amount=Double.parseDouble(request.getParameter("amount"));
				int received_by=0;
				String purpose=request.getParameter("purpose");
				int added_by=((UserDetailBean)session.getAttribute("bean")).getUser_id();
				int bank_id=Integer.parseInt(request.getParameter("bank_detail_id"));
				int category_id=Integer.parseInt(request.getParameter("category_id"));
				String receiver=request.getParameter("receiver");
				
				
				PettyCashBean bean=new PettyCashBean();
				bean.setPlant_id(plant_id);
				bean.setDate(date);
				bean.setAmount(amount);
				bean.setReceived_by(received_by);
				bean.setAdded_by(added_by);
				bean.setPurpose(purpose);
				bean.setBank_id(bank_id);
				bean.setCategory_id(category_id);
				bean.setReceiver(receiver);
				
				int count=dao.insertPettyCash(bean);
				
				if(count>0) {
					session.setAttribute("result", "Petty Cash Inserted Successfully");
					response.sendRedirect("gst/PettyCashList.jsp");
				}else {
					session.setAttribute("result", "<span style='color:red;'>Insertion Failed</span>");
					response.sendRedirect("gst/PettyCashList.jsp");
				}
			}
			
			else if(action.equals("UpdatePettyCash")) {
				int cash_id=Integer.parseInt(request.getParameter("cash_id"));
				int plant_id=Integer.parseInt(request.getParameter("plant_id"));
				String date=IndianDateFormater.
							converToIndianFormat(request.getParameter("date"));
				double amount=Double.parseDouble(request.getParameter("amount"));
				//int received_by=Integer.parseInt(request.getParameter("received_by"));
				String purpose=request.getParameter("purpose");
				String modified_by=((UserDetailBean)session.getAttribute("bean")).getUsername();
				int bank_id=Integer.parseInt(request.getParameter("bank_detail_id"));
				//int category_id=Integer.parseInt(request.getParameter("category_id"));
				String receiver=request.getParameter("receiver");
				
				PettyCashBean bean=new PettyCashBean();
				bean.setPlant_id(plant_id);
				bean.setDate(date);
				bean.setAmount(amount);
				//bean.setReceived_by(0);
				bean.setPurpose(purpose);
				bean.setCash_id(cash_id);
				bean.setBank_id(bank_id);
				//bean.setCategory_id(category_id);
				bean.setReceiver(receiver);
				
				//update pettycash and get petty cash details
				PettyCashBean pbean=dao.getSinglePettyCashDetails(cash_id);
				int count=dao.updatePettyCash(bean);
				
				if(count>0) {
					//add in modification petty cash details
					PettyCashModificationBean mbean=new PettyCashModificationBean();
					mbean.setAmount(pbean.getAmount());
					mbean.setCash_id(pbean.getCash_id());
					mbean.setDate(pbean.getDate());
					mbean.setNew_amount(amount);
					mbean.setModified_by(modified_by);
					mbean.setPlant_id(pbean.getPlant_id());
					mbean.setModification_type("Update");
					dao.insertPettyCashModification(mbean);
					
					session.setAttribute("result", "Petty Cash updated Successfully");
					response.sendRedirect("gst/PettyCashList.jsp");
				}else {
					session.setAttribute("result", "<span style='color:red;'>Insertion Failed</span>");
					response.sendRedirect("gst/PettyCashList.jsp");
				}
			}
			
			else if(action.equals("DeletePettyCash")) {
				int cash_id=Integer.parseInt(request.getParameter("cash_id"));
				PettyCashBean bean=dao.getSinglePettyCashDetails(cash_id);
				int count=dao.deletePettyCash(cash_id);
				if(count>0) {
					PettyCashModificationBean mbean=new PettyCashModificationBean();
					mbean.setCash_id(bean.getCash_id());
					mbean.setAmount(bean.getAmount());
					mbean.setNew_amount(0);
					String modified_by=((UserDetailBean)session.getAttribute("bean")).getUsername();
					mbean.setModified_by(modified_by);
					mbean.setPlant_id(bean.getPlant_id());
					mbean.setDate(bean.getDate());
					mbean.setModification_type("Delete");
					dao.insertPettyCashModification(mbean);
					writer.println("successful");
				}else {
					writer.println("failed");
				}
			}
			
			else if(action.equals("GetPettyCashList")) {
				response.setContentType("application/json");
				response.setCharacterEncoding("utf-8");
				Gson gson=new Gson();
				
				String from_date=request.getParameter("from_date");
				String to_date=request.getParameter("to_date");
				String cash_id=request.getParameter("cash_id");
				int plant_id=(request.getParameter("plant_id")==null || request.getParameter("plant_id").trim().equals(""))?
						0:Integer.parseInt(request.getParameter("plant_id"));
				int start=Integer.parseInt(request.getParameter("start"));
				int length=Integer.parseInt(request.getParameter("length"));
				Map<String,Object> data=new HashMap<>();
				int draw=Integer.parseInt(request.getParameter("draw"));
				data.put("data",dao.getPettyCashList(from_date, to_date, cash_id, plant_id, start, length));
				data.put("draw", draw);
				int recordCount=dao.countPettyCashList(from_date, to_date, cash_id, plant_id);
				data.put("recordsTotal", recordCount);
				data.put("recordsFiltered", recordCount);
				writer.print(gson.toJson(data));
			}
			
			else if(action.equals("PettyCashModificationList")) {
				response.setContentType("application/json");
				response.setCharacterEncoding("utf-8");
				Gson gson=new Gson();
				
				String cash_id=request.getParameter("search[value]");
				int start=Integer.parseInt(request.getParameter("start"));
				int length=Integer.parseInt(request.getParameter("length"));
				Map<String,Object> data=new HashMap<>();
				int draw=Integer.parseInt(request.getParameter("draw"));
				data.put("data",dao.getPettyCashModificationList(cash_id, start, length));
				data.put("draw", draw);
				int recordCount=dao.countPettyCashModificationList(cash_id);
				data.put("recordsTotal", recordCount);
				data.put("recordsFiltered", recordCount);
				writer.print(gson.toJson(data));
			}
			
			else if(action.equals("InsertPettyCashTransaction")) {
				int plant_id=Integer.parseInt(request.getParameter("plant_id"));
				String date=IndianDateFormater.
							converToIndianFormat(request.getParameter("date"));
				double amount=Double.parseDouble(request.getParameter("amount"));
				String description=request.getParameter("description");
				String purpose=request.getParameter("purpose");
				
				PettyCashTransactionBean bean=new PettyCashTransactionBean();
				bean.setPlant_id(plant_id);
				bean.setAmount(amount);
				bean.setDate(date);
				bean.setDescription(description);
				bean.setPurpose(purpose);
				System.out.println(bean);
				
				int count=dao.insertPettyCashTransaction(bean);
				if(count>0) {
					writer.println(count);
				}
				else
					writer.println(0);
			}
			
			else if(action.equals("UpdatePettyCashTransaction")) {
				int transaction_id=Integer.parseInt(request.getParameter("transaction_id"));
				int plant_id=Integer.parseInt(request.getParameter("plant_id"));
				String date=IndianDateFormater.
						converToIndianFormat(request.getParameter("date"));
				double amount=Double.parseDouble(request.getParameter("amount"));
				String description=request.getParameter("description");
				String purpose=request.getParameter("purpose");
				
				PettyCashTransactionBean bean=new PettyCashTransactionBean();
				bean.setPlant_id(plant_id);
				bean.setAmount(amount);
				bean.setDate(date);
				bean.setDescription(description);
				bean.setPurpose(purpose);
				bean.setTransaction_id(transaction_id);
				
				
				int count=dao.updatePettyCashTransaction(bean);
				if(count>0)
					writer.println(count);
				else
					writer.println(0);
			}
			
			else if(action.equals("DeletePettyCashTransaction")) {
				int transaction_id=Integer.parseInt(request.getParameter("transaction_id"));
				int count=dao.deletePettyCashTransaction(transaction_id);
				writer.println(count);
			}
			
			else if(action.equals("GetPettyCashTransactionList")) {
				response.setContentType("application/json");
				response.setCharacterEncoding("utf-8");
				Gson gson=new Gson();
				
				String from_date=request.getParameter("from_date");
				String to_date=request.getParameter("to_date");
				int plant_id=Integer.parseInt(request.getParameter("plant_id"));
				boolean checked=(request.getParameter("status").trim().equals("checked"))?false:true;
				System.out.println(checked);
				int start=Integer.parseInt(request.getParameter("start"));
				int length=Integer.parseInt(request.getParameter("length"));
				Map<String,Object> data=new HashMap<>();
				int draw=Integer.parseInt(request.getParameter("draw"));
				data.put("data",dao.getPettyCashTransactionList(from_date, to_date, plant_id,checked, start, length));
				data.put("draw", draw);
				int recordCount=dao.countPettyCashTransactionList(from_date, to_date, plant_id,checked);
				data.put("recordsTotal", recordCount);
				data.put("recordsFiltered", recordCount);
				writer.print(gson.toJson(data));
			}
			
			else if(action.equals("GetSinglePettyCashTransaction")) {
				response.setContentType("application/json");
				response.setCharacterEncoding("utf-8");
				Gson gson=new Gson();
				
				long transaction_id=Long.parseLong(request.getParameter("transaction_id"));
				PettyCashTransactionBean bean=dao.getSinglePettyCashTransaction(transaction_id);
				writer.println(gson.toJson(bean));
			}
			
			else if(action.equals("ApprovePettyCash")) {
				long cash_id=Long.parseLong(request.getParameter("cash_id"));
				String approved_by=((UserDetailBean)session.getAttribute("bean")).getUsername();
				int count=dao.approvePettyCash(cash_id, approved_by);
				writer.println(count);
			}
			
			else if(action.equals("GetPettyCashDetails")) {
				response.setContentType("application/json");
				response.setCharacterEncoding("utf-8");
				Gson gson=new Gson();
				int plant_id=Integer.parseInt(request.getParameter("plant_id"));
				HashMap<String, Object> map=dao.getDetailsSumOfPettyCash(plant_id);
				writer.println(gson.toJson(map));
			}
			
			
			else if(action.equals("changeTransactionBillStatus")) {
				response.setContentType("application/json");
				response.setCharacterEncoding("utf-8");
				Gson gson=new Gson();
				boolean status=Boolean.parseBoolean(request.getParameter("status"));
				long transaction_id=Long.parseLong(request.getParameter("transaction_id"));
				int count=dao.changePettyCashTransactionBillStatus(transaction_id, status);
				HashMap<String, Object> map=new HashMap<String, Object>();
				map.put("count", count);
				map.put("status", status);
				writer.println(gson.toJson(map));
			}
			
			
			else if(action.equals("getPettyCashTransactionDateWiseReport")) {
				response.setContentType("application/json");
				response.setCharacterEncoding("utf-8");
				Gson gson=new Gson();
				String from_date=request.getParameter("from_date");
				String to_date=request.getParameter("to_date");
				int category_id=(request.getParameter("category_id")==null 
						|| request.getParameter("category_id").equals("null"))?0:Integer.parseInt(request.getParameter("category_id"));
				String category_type=request.getParameter("category_type").trim().equals("null")
						?"":request.getParameter("category_type");
				List<Map<String,Object>> data=dao.getPettyCashTransactionDateWiseReport(from_date, to_date, category_type, category_id);
				writer.println(gson.toJson(data));
			}
			
			else if(action.equals("getAccountTransactionReport")) {
				response.setContentType("application/json");
				response.setCharacterEncoding("utf-8");
				Gson gson=new Gson();
				String from_date=request.getParameter("from_date");
				String to_date=request.getParameter("to_date");
				int category_id=(request.getParameter("category_id")==null 
						|| request.getParameter("category_id").equals("null"))?0:Integer.parseInt(request.getParameter("category_id"));
				String category_type=request.getParameter("category_type").trim().equals("null")
						?"":request.getParameter("category_type");
				List<Map<String,Object>> list=dao.getAccountTransactionReport(from_date, to_date, category_type, category_id);
				writer.println(gson.toJson(list));
			}
			
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}

	
}
