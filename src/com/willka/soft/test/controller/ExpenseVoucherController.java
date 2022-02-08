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
import com.willka.soft.test.bean.ExpenseVoucherBean;
import com.willka.soft.test.bean.ExpenseVoucherItemBean;
import com.willka.soft.test.dao.ExpenseVoucherDAO;
import com.willka.soft.test.dao.ExpenseVoucherDAOImpl;
import com.willka.soft.util.IndianDateFormater;

/**
 * Servlet implementation class ExpenseVoucherController
 */
@WebServlet("/ExpenseVoucherControllerTest")
public class ExpenseVoucherController extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session=request.getSession();
		ExpenseVoucherDAO dao=new ExpenseVoucherDAOImpl();
		
		try{
			String action=request.getParameter("action");
			PrintWriter writer=response.getWriter();
			if(action.equals("insertExpenseCategory")) {
				String category_type=request.getParameter("category_type");
				String category_name=request.getParameter("category_name");
				String category_description=request.getParameter("category_description");
				
				int count=dao.insertExpenseCategory(category_name,
						category_type, category_description);
				
				writer.println(count);
			}
			
			else if(action.equals("updateExpenseCategory")) {
				int category_id=Integer.parseInt(request.getParameter("category_id"));
				String category_type=request.getParameter("category_type");
				String category_name=request.getParameter("category_name");
				String category_description=request.getParameter("category_description");
				int count=dao.updateExpenseCategory(category_id, category_name,
						category_type, category_description);
				writer.println(count);
			}
			
			else if(action.equals("getExpenseCategoryList")) {
				response.setContentType("application/json");
				response.setCharacterEncoding("utf-8");
				Gson gson=new Gson();
				int start=Integer.parseInt(request.getParameter("start"));
				int length=Integer.parseInt(request.getParameter("length"));
				Map<String,Object> data=new HashMap<>();
				String search=request.getParameter("search[value]");
				int draw=Integer.parseInt(request.getParameter("draw"));
				data.put("data", dao.getExpenseCategoryList(search, start, length));
				data.put("draw", draw);
				int recordCount=dao.countExpenseCategoryList(search);
				data.put("recordsTotal", recordCount);
				data.put("recordsFiltered", recordCount);
				writer.print(gson.toJson(data));
			}
			
			else if(action.equals("getSingleCategory")) {
				response.setContentType("application/json");
				response.setCharacterEncoding("utf-8");
				Gson gson=new Gson();
				int category_id=Integer.parseInt(request.getParameter("category_id"));
				Map<String,Object> data=dao.getSingleCategory(category_id);
				writer.println(gson.toJson(data));
			}
			
			else if(action.equals("deleteCategory")) {
				try {
					int category_id=Integer
							.parseInt(request.getParameter("category_id"));
					int count=dao
							.deleteExpenseCategory(category_id);
					writer.println(count);
				}catch(Exception e) {
					writer.println(-1);
				}
				
			}
			
			
			else if(action.equals("getCategoryList")) {
				response.setContentType("application/json");
				response.setCharacterEncoding("utf-8");
				Gson gson=new Gson();
				String category_type=request.getParameter("category_type");
				List<Map<String,Object>> list=dao.getCategoryListById(category_type);
				writer.println(gson.toJson(list));
			}
			
			
			else if(action.equals("InsertExpenseVoucher")){
				synchronized (this) {
					String bill_no=request.getParameter("bill_no");
					String bill_date=IndianDateFormater.
								converToIndianFormat(request.getParameter("bill_date"));
					int plant_id=Integer.parseInt(request.getParameter("plant_id"));
					double tds_amount=(request.getParameter("tds_amount")==null || request.getParameter("tds_amount").trim().equals(""))?
									0.0:Double.parseDouble(request.getParameter("tds_amount"));
					String remark=request.getParameter("remark");
					int supplier_id=Integer
							.parseInt(request.getParameter("supplier_id"));
					String category_type=request
							.getParameter("category_type");
					boolean rate_include_tax=
							(request.getParameterValues("include_tax")==null)?false:true;
					int count=Integer
								.parseInt(request.getParameter("count"));
					
					ExpenseVoucherBean bean=new ExpenseVoucherBean();
					bean.setBill_date(bill_date);
					bean.setBill_no(bill_no);
					bean.setTds_amount(tds_amount);
					bean.setPlant_id(plant_id);
					bean.setRemark(remark);
					bean.setSupplier_id(supplier_id);
					bean.setCategory_type(category_type);
					bean.setRate_include_tax(rate_include_tax);
					
					
					//now insert expense voucher
					int val=dao.insertExpenseVoucher(bean);
					
					if(val>0){
						//now insert voucher item
						int expense_voucher_id=dao.getMaxExpenseVoucher();
						for(int i=0;i<count;i++){
							ExpenseVoucherItemBean been=new ExpenseVoucherItemBean();
							been.setExpense_voucher_id(expense_voucher_id);
							been.setCategory_id(Integer
										.parseInt(request.getParameter("category_id["+i+"]")));
							been.setItem_name(request.getParameter("item_name["+i+"]"));
							been.setItem_price(Double.parseDouble(request.getParameter("item_price["+i+"]")));
							been.setItem_quantity(Double.parseDouble(request.getParameter("item_quantity["+i+"]")));
							been.setGst_percent(Float.parseFloat(request.getParameter("gst_percent["+i+"]")));
							been.setGross_amount(Double.parseDouble(request.getParameter("gross_amount["+i+"]")));
							been.setTax_amount(Double.parseDouble(request.getParameter("tax_amount["+i+"]")));
							been.setNet_amount(Double.parseDouble(request.getParameter("net_amount["+i+"]")));
							dao.insertExpenseVoucherItem(been);
						}
						session.setAttribute("res", "Inserted Successfully");
						response.sendRedirect("gst/ExpenseVoucherList.jsp");
					}else{
						session.setAttribute("res", "failed!!!");
						response.sendRedirect("gst/ExpenseVoucherList.jsp");
					}
				}
				
			}
			
			else if(action.equals("UpdateExpenseVoucher")){
				synchronized (this) {
					String bill_no=request.getParameter("bill_no");
					String bill_date=IndianDateFormater.
								converToIndianFormat(request.getParameter("bill_date"));
					int plant_id=Integer.parseInt(request.getParameter("plant_id"));
					double tds_amount=(request.getParameter("tds_amount")==null || request.getParameter("tds_amount").trim().equals(""))?
									0.0:Double.parseDouble(request.getParameter("tds_amount"));
					String remark=request.getParameter("remark");
					int supplier_id=Integer
							.parseInt(request.getParameter("supplier_id"));
					String category_type=request
							.getParameter("category_type");
					boolean rate_include_tax=
							(request.getParameterValues("include_tax")==null)?false:true;
					int expense_voucher_id=Integer
							.parseInt(request.getParameter("expense_voucher_id"));
					int count=Integer
								.parseInt(request.getParameter("count"));
					
					
					ExpenseVoucherBean bean=new ExpenseVoucherBean();
					bean.setBill_date(bill_date);
					bean.setBill_no(bill_no);
					bean.setTds_amount(tds_amount);
					bean.setPlant_id(plant_id);
					bean.setRemark(remark);
					bean.setSupplier_id(supplier_id);
					bean.setCategory_type(category_type);
					bean.setRate_include_tax(rate_include_tax);
					bean.setExpense_voucher_id(expense_voucher_id);
					
					
					//now insert expense voucher
					int val=dao.updateExpenseVoucher(bean);
					
					if(val>0){
						//now insert voucher item
						for(int i=0;i<count;i++){
							try {
								ExpenseVoucherItemBean been=new ExpenseVoucherItemBean();
								been.setExpense_voucher_id(expense_voucher_id);
								been.setCategory_id(Integer
											.parseInt(request.getParameter("category_id["+i+"]")));
								been.setItem_name(request
											.getParameter("item_name["+i+"]"));
								been.setItem_price(Double
											.parseDouble(request.getParameter("item_price["+i+"]")));
								been.setItem_quantity(Double
										    .parseDouble(request.getParameter("item_quantity["+i+"]")));
								been.setGst_percent(Float
										    .parseFloat(request.getParameter("gst_percent["+i+"]")));
								been.setGross_amount(Double
										    .parseDouble(request.getParameter("gross_amount["+i+"]")));
								been.setTax_amount(Double
										    .parseDouble(request.getParameter("tax_amount["+i+"]")));
								been.setNet_amount(Double
										    .parseDouble(request.getParameter("net_amount["+i+"]")));
								been.setEvi_id(Integer
										    .parseInt(request.getParameter("evi_id["+i+"]")));
								dao.updateExpenseVoucherItem(been);
							}catch(Exception e) {
								ExpenseVoucherItemBean been=new ExpenseVoucherItemBean();
								been.setExpense_voucher_id(expense_voucher_id);
								been.setCategory_id(Integer
											.parseInt(request.getParameter("category_id["+i+"]")));
								been.setItem_name(request
											.getParameter("item_name["+i+"]"));
								been.setItem_price(Double
											.parseDouble(request.getParameter("item_price["+i+"]")));
								been.setItem_quantity(Double
										    .parseDouble(request.getParameter("item_quantity["+i+"]")));
								been.setGst_percent(Float
										    .parseFloat(request.getParameter("gst_percent["+i+"]")));
								been.setGross_amount(Double
										    .parseDouble(request.getParameter("gross_amount["+i+"]")));
								been.setTax_amount(Double
										    .parseDouble(request.getParameter("tax_amount["+i+"]")));
								been.setNet_amount(Double
										    .parseDouble(request.getParameter("net_amount["+i+"]")));
								dao.insertExpenseVoucherItem(been);
							}
						}
						session.setAttribute("res", "Expense Voucher Updated Successfully");
						response.sendRedirect("gst/ExpenseVoucherList.jsp");
					}else{
						session.setAttribute("res", "Updation Failed!!");
						response.sendRedirect("gst/ExpenseVoucherList.jsp");
					}
				}
				
			}
			
			else if(action.equals("CancelVoucher")){
				int expense_voucher_id=Integer.parseInt(request.getParameter("expense_voucher_id"));
				
				int count=dao.cancelExpenseVoucher(expense_voucher_id);
				
				if(count>0){
					session.setAttribute("res", "Voucher Id : "+expense_voucher_id+ " Cancelled Successfully");
					response.sendRedirect("gst/ExpenseVoucherList.jsp");
				}else{
					session.setAttribute("res", "<span class='text-danger'>Failed!!</span>");
					response.sendRedirect("gst/ExpenseVoucherList.jsp");
				}
			}
			
			
			
			else if(action.equals("getAllExpenseVoucherList")) {
				response.setContentType("application/json");
				response.setCharacterEncoding("utf-8");
				Gson gson=new Gson();
				String from_date=request.getParameter("from_date");
				from_date=(from_date==null || from_date.trim().equals(""))?"":IndianDateFormater.converToIndianFormat(from_date);
				String to_date=request.getParameter("to_date");
				to_date=(to_date==null || to_date.trim().equals(""))?"":IndianDateFormater.converToIndianFormat(to_date);
				int supplier_id=(request.getParameter("supplier_id")==null || request.getParameter("supplier_id").trim().equals(""))?
						0:Integer.parseInt(request.getParameter("supplier_id"));
				String bill_no=request.getParameter("bill_no");
				int start=Integer.parseInt(request.getParameter("start"));
				int length=Integer.parseInt(request.getParameter("length"));
				int business_id=Integer.parseInt(request.getParameter("business_id"));
				Map<String,Object> data=new HashMap<>();
				int draw=Integer.parseInt(request.getParameter("draw"));
				data.put("data",dao.getExpenseVoucherList(bill_no, from_date, to_date, supplier_id,business_id, start, length));
				data.put("draw", draw);
				int recordCount=dao.countExpenseVoucherList(bill_no, from_date, to_date, supplier_id,business_id);
				data.put("recordsTotal", recordCount);
				data.put("recordsFiltered", recordCount);
				writer.print(gson.toJson(data));
			}
			
			else if(action.equals("deleteExpenseVoucher")) {
				int expense_voucher_id=Integer.parseInt(request.getParameter("expense_voucher_id"));
				int count=dao.deleteExpenseVoucher(expense_voucher_id);
				writer.println(count);
			}
			
			else if(action.equals("getDashboard")) {
				response.setContentType("application/json");
				response.setCharacterEncoding("utf-8");
				Gson gson=new Gson();
				Map<String,Object> data=dao.getExpenseVoucherDashboard();
				writer.println(gson.toJson(data));
			}
			
			else if(action.equals("getExpenseCategoryType")) {
				response.setContentType("application/json");
				response.setCharacterEncoding("utf-8");
				Gson gson=new Gson();
				List<String> data=dao.getExpenseCategoryType();
				writer.println(gson.toJson(data));
			}
		}catch(Exception e){
			e.printStackTrace();
		}
	}

}
