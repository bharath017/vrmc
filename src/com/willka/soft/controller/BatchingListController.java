package com.willka.soft.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.willka.soft.dao.BatchingDAOImpl;

/**
 * Servlet implementation class BatchingListController
 */
@WebServlet("/BatchingListController")
public class BatchingListController extends HttpServlet {
	BatchingDAOImpl dao=new BatchingDAOImpl();
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			
			PrintWriter writer=response.getWriter();
		
		try {
			String action=request.getParameter("action");
			if(action.equals("GetCustomerList")) {
				response.setContentType("application/json");
				response.setCharacterEncoding("utf-8");
				Gson gson=new Gson();
				ArrayList<String> list=dao.getAllCustomerList();
				writer.println(gson.toJson(list));
			}
			
			else if(action.equals("GET_BATCH_LIST")) {
				response.setContentType("application/json");
				response.setCharacterEncoding("UTF-8");
				Gson gson=new Gson();
				int start=Integer.parseInt(request.getParameter("start"));
				int length=Integer.parseInt(request.getParameter("length"));
				String from_date=request.getParameter("from_date");
				String to_date=request.getParameter("to_date");
				String customer_name=request.getParameter("customer_name");
				Map<String,Object> data=new HashMap<>();
				int draw=Integer.parseInt(request.getParameter("draw"));
				data.put("data",dao.getBatchingList(from_date, to_date, customer_name, start, length));
				data.put("draw", draw);
				int recordCount=dao.countTotalBatchingCount(from_date, to_date, customer_name);
				data.put("recordsTotal", recordCount);
				data.put("recordsFiltered", recordCount);
				writer.print(gson.toJson(data));
			}
			
			else if(action.equals("getTodayStock")) {
				response.setContentType("application/json");
				response.setCharacterEncoding("utf-8");
				Gson gson=new Gson();
				HashMap<String, Object> map=dao.getTotalQuantityOfStockToday();
				writer.println(gson.toJson(map));
			}
			
			else if(action.equals("GetBatchSheet")) {
				response.setContentType("application/json");
				response.setCharacterEncoding("utf-8");
				Gson gson=new Gson();
				int BatchID=Integer.parseInt(request.getParameter("BatchID"));
				HashMap<String, Object> map=new HashMap<String, Object>();
				HashMap<String, Object> batchdetails=dao.getSingleTripDetails(BatchID);
				ArrayList<HashMap<String, Object>> batchlist=dao.getSingleBatchListDetails(BatchID);
				map.put("batch", batchdetails);
				map.put("list", batchlist);
				writer.println(gson.toJson(map));
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
	}

}
