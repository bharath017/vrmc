// 
// Decompiled by Procyon v0.5.36
// 

package com.willka.soft.controller;

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
import com.willka.soft.bean.BankDetailBean;
import com.willka.soft.bean.BankTransactionBean;
import com.willka.soft.bean.CustomerPaymentBean;
import com.willka.soft.bean.MakePaymentBean;
import com.willka.soft.bean.UserDetailBean;
import com.willka.soft.dao.BankDetailDAO;
import com.willka.soft.dao.BankDetailDAOImpl;
import com.willka.soft.dao.MakePaymentDAOImpl;
import com.willka.soft.dao.PaymentDAOImpl;
import com.willka.soft.util.IndianDateFormater;

@WebServlet({ "/BankDetailController" })
public class BankDetailController extends HttpServlet
{
    private static final long serialVersionUID = 4641L;
    
    protected void doPost(final HttpServletRequest request, final HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        final HttpSession session = request.getSession();
        final PrintWriter writer = response.getWriter();
        final BankDetailDAO dao = (BankDetailDAO)new BankDetailDAOImpl();
        PaymentDAOImpl pdao=new PaymentDAOImpl();
        MakePaymentDAOImpl mdao=new MakePaymentDAOImpl();
        try {
            final String action = request.getParameter("action");
            if (action.equals("insertBankDetail")) {
                final String bank_name = request.getParameter("bank_name");
                final String account_no = request.getParameter("account_no");
                final String branch_name = request.getParameter("branch_name");
                final double amount = (request.getParameter("amount") == null || request.getParameter("amount").trim().equals("")) ? 0.0 : Double.parseDouble(request.getParameter("amount"));
                final String ifsc_code = request.getParameter("ifsc_code");
                int business_id=Integer.parseInt(request.getParameter("business_id"));
                String group=request.getParameter("group");
                final BankDetailBean bean = new BankDetailBean();
                bean.setBank_name(bank_name);
                bean.setAccount_no(account_no);
                bean.setBranch_name(branch_name);
                bean.setAmount(amount);
                bean.setIfsc_code(ifsc_code);
                bean.setBusiness_id(business_id);
                bean.setGroup(group);
                final int count = dao.insertBankDetails(bean);
                if (count > 0) {
                    session.setAttribute("result", (Object)"Bank Details Saved Successfully");
                    response.sendRedirect("AddBankDetails.jsp");
                }
                else {
                    session.setAttribute("result", (Object)"Unsuccessfully");
                    response.sendRedirect("AddBankDetails.jsp");
                }
            }
            
            else if (action.equals("updateBankDetail")) {
                final String bank_name = request.getParameter("bank_name");
                final String account_no = request.getParameter("account_no");
                final String branch_name = request.getParameter("branch_name");
                final double amount = (request.getParameter("amount") == null || request.getParameter("amount").trim().equals("")) ? 0.0 : Double.parseDouble(request.getParameter("amount"));
                final String ifsc_code = request.getParameter("ifsc_code");
                final int bank_detail_id = (request.getParameter("bank_detail_id") == null || request.getParameter("bank_detail_id").trim().equals("")) ? 0 : Integer.parseInt(request.getParameter("bank_detail_id"));
                int business_id=Integer.parseInt(request.getParameter("business_id"));
                String group=request.getParameter("group");
                
                final BankDetailBean bean2 = new BankDetailBean();
                bean2.setBank_name(bank_name);
                bean2.setAccount_no(account_no);
                bean2.setBranch_name(branch_name);
                bean2.setAmount(amount);
                bean2.setIfsc_code(ifsc_code);
                bean2.setBusiness_id(business_id);
                bean2.setBank_detail_id(bank_detail_id);
                bean2.setGroup(group);
                final int count2 = dao.updateBankDetails(bean2);
                if (count2 > 0) {
                    session.setAttribute("result", (Object)"Bank Details Updated Successfully");
                    response.sendRedirect("AddBankDetails.jsp");
                }
                else {
                    session.setAttribute("result", (Object)"Unsuccessfully");
                    response.sendRedirect("AddBankDetails.jsp");
                }
            }
            else if (action.equals("DeleteBankDetail")) {
                final int bank_detail_id2 = Integer.parseInt(request.getParameter("bank_detail_id"));
                final int count3 = dao.deleteBankDetails(bank_detail_id2);
                if (count3 > 0) {
                    session.setAttribute("result", (Object)"Bank Details Deleted Successfully");
                    response.sendRedirect("AddBankDetails.jsp");
                }
                else {
                    session.setAttribute("result", (Object)"Unsuccessfully");
                    response.sendRedirect("AddBankDetails.jsp");
                }
            }
            if (action.equals("insertTransactionDetail")) {
                final double transaction_amount = Double.parseDouble(request.getParameter("transaction_amount"));
                final String transaction_date = request.getParameter("transaction_date");
                final String transaction_time = request.getParameter("transaction_time");
                final String transaction_type = request.getParameter("transaction_type");
                final String remarks = request.getParameter("remarks");
                final int bank_id = Integer.parseInt(request.getParameter("bank_id"));
                int business_id=Integer.parseInt(request.getParameter("business_id"));
                String receiver=request.getParameter("receiver");
                String payment_type=request.getParameter("payment_mode");
                String check_dd_no=request.getParameter("check_dd_no");
				String check_dd_validity=request.getParameter("check_dd_validity");
				String neft_no=request.getParameter("neft_no");
                
                if(transaction_type.equals("cuspay")) {
                	int customer_id=Integer.
                				parseInt(request.getParameter("customer_id"));
                	CustomerPaymentBean bean=new CustomerPaymentBean();
                	bean.setCustomer_id(customer_id);
                	bean.setPayment_date(IndianDateFormater.
                				converToIndianFormat(transaction_date));
                	bean.setPayment_time(transaction_time);
                	bean.setBank_detail_id(bank_id);
                	bean.setCheck_dd_number(check_dd_no);
                	bean.setCheck_dd_validity(check_dd_validity);
                	bean.setPayment_amount(transaction_amount);
                	bean.setPayment_category(payment_type);
                	bean.setNeft_no(neft_no);
                	bean.setSite_id(0);
                	int count=pdao.insertPayment(bean);
                	if(count>0) {
                		 session.setAttribute("result", "Added to customer payment");
                         response.sendRedirect("BankTransactionList.jsp");
                	}else {
                		 session.setAttribute("result", "Added to customer payment");
                         response.sendRedirect("BankTransactionList.jsp");
                	}
                }else if(transaction_type.equals("suppay")) {
                	int supplier_id=Integer.parseInt(request.getParameter("supplier_id"));
                	MakePaymentBean bean=new MakePaymentBean();
                	bean.setBank_detail_id(bank_id);
                	bean.setPayment_amount(transaction_amount);
                	bean.setCheck_dd_no(check_dd_no);
                	bean.setCheck_dd_validity(check_dd_validity);
                	bean.setPayment_date(IndianDateFormater.
                			converToIndianFormat(transaction_date));
                	bean.setPayment_time(transaction_time);
                	bean.setSupplier_id(supplier_id);
                	bean.setPayment_mode(payment_type);
                	int count=mdao.insertMakePayment(bean);
                	if(count>0){
                        session.setAttribute("result", "Added to supplier payment");
                        response.sendRedirect("BankTransactionList.jsp");
                    }
                    else {
                        session.setAttribute("result", "Failed!!");
                        response.sendRedirect("BankTransactionList.jsp");
                     }
                }else {
                	 final BankTransactionBean bean3 = new BankTransactionBean();
                     bean3.setTransaction_amount(transaction_amount);
                     bean3.setTransaction_date(IndianDateFormater
                    		 	.converToIndianFormat(transaction_date));
                     bean3.setTransaction_time(transaction_time);
                     bean3.setTransaction_type(transaction_type);
                     bean3.setBank_id(bank_id);
                     bean3.setRemarks(remarks);
                     bean3.setReceiver(receiver);
                     bean3.setBusiness_id(business_id);
                     final UserDetailBean bein = (UserDetailBean)session.getAttribute("bean");
                     final int added_by = bein.getUser_id();
                     bean3.setAdded_by(added_by);
                     final int count4 = dao.insertTransactionDetail(bean3);
                     if (count4 > 0) {
                         session.setAttribute("result", (Object)"Transaction Details Added Successfully");
                         response.sendRedirect("BankTransactionList.jsp");
                     }
                     else {
                         session.setAttribute("result", (Object)"Unsuccessfully");
                         response.sendRedirect("BankTransactionList.jsp");
                     }
                }
            }
            if (action.equals("updateTransactionDetail")) {
                final double transaction_amount = Double.parseDouble(request.getParameter("transaction_amount"));
                final String transaction_date =IndianDateFormater.
                				converToIndianFormat(request.getParameter("transaction_date"));
                final String transaction_time = request.getParameter("transaction_time");
                final String transaction_type2 = request.getParameter("transaction_type");
                final int transaction_id = Integer.parseInt(request.getParameter("transaction_id"));
                final int bank_id = Integer.parseInt(request.getParameter("bank_id"));
                String remarks=request.getParameter("remarks");
                int business_id=Integer.parseInt(request.getParameter("business_id"));
                int customer_id=(request.getParameter("customer_id")==null || request.getParameter("customer_id").trim().equals(""))?
                					0:Integer.parseInt(request.getParameter("customer_id"));
                int supplier_id=(request.getParameter("supplier_id")==null || request.getParameter("supplier_id").trim().equals(""))?
                					0:Integer.parseInt(request.getParameter("supplier_id"));
                
                final BankTransactionBean bean3 = new BankTransactionBean();
                bean3.setTransaction_amount(transaction_amount);
                bean3.setTransaction_date(transaction_date);
                bean3.setTransaction_time(transaction_time);
                final UserDetailBean bein = (UserDetailBean)session.getAttribute("bean");
                final int added_by = bein.getUser_id();
                bean3.setAdded_by(added_by);
                bean3.setTransaction_type(transaction_type2);
                bean3.setTransaction_id(transaction_id);
                bean3.setRemarks(remarks);
                bean3.setBusiness_id(business_id);
                bean3.setBank_id(bank_id);
                
                if(transaction_type2.trim().equals("cuspay")) {
                	//add to customer payment
                	CustomerPaymentBean bean=new CustomerPaymentBean();
                	bean.setBank_detail_id(bank_id);
                	bean.setCustomer_id(customer_id);
                	bean.setCheck_dd_number(null);
                	bean.setCheck_dd_validity(null);
                	bean.setPayment_date(transaction_date);
                	bean.setPayment_time(transaction_time);
                	bean.setSite_id(0);
                	bean.setPayment_amount(transaction_amount);
                	bean.setPayment_category("CASH");
                	int count=pdao.insertPayment(bean);
                	if(count>0) {
                		int count2=dao.deleteTransactionDetail(transaction_id);
                		 if (count2 > 0) {
                             session.setAttribute("result", "Added to customer payment");
                             response.sendRedirect("BankTransactionList.jsp");
                         }
                         else {
                             session.setAttribute("result", "failed!!");
                             response.sendRedirect("BankTransactionList.jsp");
                         }
                	}
                }else if(transaction_type2.equals("suppay")) {
                	MakePaymentBean bean=new MakePaymentBean();
                	bean.setBank_detail_id(bank_id);
                	bean.setPayment_amount(transaction_amount);
                	bean.setCheck_dd_no(null);
                	bean.setCheck_dd_validity(null);
                	bean.setPayment_date(transaction_date);
                	bean.setPayment_time(transaction_time);
                	bean.setSupplier_id(supplier_id);
                	bean.setPayment_mode("CASH");
                	int count=mdao.insertMakePayment(bean);
                	if(count>0) {
                	  int count2=dao.deleteTransactionDetail(transaction_id);
               		 if (count2 > 0) {
                            session.setAttribute("result", "Added to supplier payment");
                            response.sendRedirect("BankTransactionList.jsp");
                        }
                        else {
                            session.setAttribute("result", "Failed!!");
                            response.sendRedirect("BankTransactionList.jsp");
                        }
                	}
                }else {
                	final int count2 = dao.updateTransactionDetail(bean3);
                	 if (count2 > 0) {
                         session.setAttribute("result", "Transaction Details Updated Successfully");
                         response.sendRedirect("BankTransactionList.jsp");
                     }
                     else {
                         session.setAttribute("result", "Unsuccessfully");
                         response.sendRedirect("BankTransactionList.jsp");
                     }
                }
                
            }
            
            if (action.equals("deleteTransaction")) {
               int id=Integer.parseInt(request.getParameter("id"));
               String type=request.getParameter("type");
               int count=0;
               if(type.equals("cuspay")) {
            	   count=pdao.deletePaymentDetails(id);
               }else if(type.equals("suppay")) {
            	   count=mdao.deleteMakePayment(id);
               }else {
            	   count=dao.deleteTransactionDetail(id);
               }
               writer.println(count);
            }
            
            if (action.equals("cancelTransactionDetail")) {
                final int transaction_id2 = Integer.parseInt(request.getParameter("transaction_id"));
                final BankTransactionBean bean4 = new BankTransactionBean();
                bean4.setTransaction_id(transaction_id2);
                final int count5 = dao.cancelTransactionDetail(transaction_id2);
                if (count5 > 0) {
                    session.setAttribute("result", (Object)"Transaction Details Canceled Successfully");
                    response.sendRedirect("BankTransactionList.jsp");
                }
                else {
                    session.setAttribute("result", (Object)"Unsuccessfully");
                    response.sendRedirect("BankTransactionList.jsp");
                }
            }
            
            
            else if (action.equals("GetBankTransactionList")) {
            	response.setContentType("application/json");
				response.setCharacterEncoding("utf-8");
				Gson gson=new Gson();
				String from_date=request.getParameter("from_date");
				String to_date=request.getParameter("to_date");
				/*
				//convert date
				from_date=(from_date==null || from_date.trim().equals(""))?"":IndianDateFormater.converToIndianFormat(from_date);
				to_date=(to_date==null || to_date.trim().equals(""))?"":IndianDateFormater.converToIndianFormat(to_date);
				*/
				int bank_id=(request.getParameter("bank_id")==null || request.getParameter("bank_id").trim().equals(""))?
						0:Integer.parseInt(request.getParameter("bank_id"));
				int business_id=Integer.parseInt(request.getParameter("business_id"));
				int start=Integer.parseInt(request.getParameter("start"));
				int length=Integer.parseInt(request.getParameter("length"));
				Map<String,Object> data=new HashMap<>();
				int draw=Integer.parseInt(request.getParameter("draw"));
				data.put("data",dao.getBankTransactionList(from_date, to_date, bank_id,business_id , start, length));
				data.put("draw", draw);
				int recordCount=dao.countBankTransactionList(from_date, to_date, bank_id, business_id);
				data.put("recordsTotal", recordCount);
				data.put("recordsFiltered", recordCount);
				writer.print(gson.toJson(data));
            }
            
            
            else if(action.equals("getBankDetailByBankGroup")) {
            	response.setContentType("application/json");
            	response.setCharacterEncoding("utf-8");
            	Gson gson=new Gson();
            	int business_id=Integer.parseInt(request.getParameter("business_id"));
            	String group_name=request.getParameter("group_name");
            	List<Map<String,Object>> list=dao.getBankListByPaymentType(group_name, business_id);
            	writer.println(gson.toJson(list));
            }
            
            else if(action.equals("getBankListByBusinessGroup")) {
            	response.setContentType("application/json");
            	response.setCharacterEncoding("utf-8");
            	Gson gson=new Gson();
            	int business_id=Integer.parseInt(request.getParameter("business_id"));
            	List<Map<String,Object>> list=dao.getBanksByBusinessGroup(business_id);
            	writer.println(gson.toJson(list));
            }
            
            else if(action.equals("getTransactionReport")) {
            	response.setContentType("application/json");
            	response.setCharacterEncoding("utf-8");
            	Gson gson=new Gson();
            	int bank_detail_id=Integer.parseInt(request.getParameter("bank_detail_id"));
            	int business_id=Integer.parseInt(request.getParameter("business_id"));
            	String from_date=request.getParameter("from_date");
            	String to_date=request.getParameter("to_date");
            	Map<String,Object> data=dao.processTransactionReport(from_date, to_date, bank_detail_id, business_id);
            	writer.println(gson.toJson(data));
            }
            
            
        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }
}
