// 
// Decompiled by Procyon v0.5.36
// 

package com.willka.soft.test.controller;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.Enumeration;
import java.util.HashMap;
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
import com.willka.soft.bean.BankDetailBean;
import com.willka.soft.bean.BankTransactionBean;
import com.willka.soft.bean.UserDetailBean;
import com.willka.soft.test.bean.CustomerPaymentBean;
import com.willka.soft.test.bean.MakePaymentBean;
import com.willka.soft.test.bean.PettyCashBean;
import com.willka.soft.test.dao.BankDetailDAO;
import com.willka.soft.test.dao.BankDetailDAOImpl;
import com.willka.soft.test.dao.MakePaymentDAOImpl;
import com.willka.soft.test.dao.PaymentDAOImpl;
import com.willka.soft.test.dao.PettyCashDAOImpl;
import com.willka.soft.util.DocumentUtil;
import com.willka.soft.util.IndianDateFormater;

import javazoom.upload.MultipartFormDataRequest;
import javazoom.upload.UploadBean;
import javazoom.upload.UploadFile;

@WebServlet({ "/BankDetailControllerTest" })
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
        PettyCashDAOImpl pedao=new PettyCashDAOImpl();
        try {
            final String action = request.getParameter("action");
            
            if(action.equals("insertTransactionDetail")) {
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
                	int category_id=Integer
                			.parseInt(request.getParameter("category_id"));
                	CustomerPaymentBean bean=new CustomerPaymentBean();
                	bean.setCustomer_id(customer_id);
                	bean.setPayment_date(IndianDateFormater.
                				converToIndianFormat(transaction_date));
                	bean.setPayment_time(transaction_time);
                	bean.setBank_detail_id(bank_id);
                	bean.setCheck_dd_number(check_dd_no);
                	bean.setCheck_dd_validity(check_dd_validity);
                	bean.setPayment_amount(transaction_amount);
                	bean.setNeft_no(neft_no);
                	bean.setPayment_category(payment_type);
                	bean.setSite_id(0);
                	bean.setCategory_id(category_id);
                	int count=pdao.insertPayment(bean);
                	if(count>0) {
                		 session.setAttribute("result", "Added to customer payment");
                         response.sendRedirect("gst/BankTransactionList.jsp");
                	}else {
                		 session.setAttribute("result", "Added to customer payment");
                         response.sendRedirect("gst/BankTransactionList.jsp");
                	}
                }else if(transaction_type.equals("suppay")) {
                	int category_id=Integer.parseInt(request.getParameter("category_id"));
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
                	bean.setPayment_mode("CASH");
                	bean.setCategory_id(category_id);
                	int count=mdao.insertMakePayment(bean);
                	if(count>0){
                        session.setAttribute("result", "Added to supplier payment");
                        response.sendRedirect("gst/BankTransactionList.jsp");
                    }
                    else {
                        session.setAttribute("result", "Failed!!");
                        response.sendRedirect("gst/BankTransactionList.jsp");
                    }
                }else {
                	int category_id=Integer.parseInt(request.getParameter("category_id"));
                	PettyCashBean bean=new PettyCashBean();
    				bean.setPlant_id(0);
    				bean.setDate(IndianDateFormater
    						.converToIndianFormat(transaction_date));
    				bean.setAmount(transaction_amount);
    				bean.setReceived_by(0);
    				bean.setAdded_by(0);
    				bean.setPurpose(remarks);
    				bean.setBank_id(bank_id);
    				bean.setReceiver(receiver);
    				bean.setCategory_id(category_id);
    				int count=pedao.insertPettyCash(bean);
    				if(count>0){
                        session.setAttribute("result", "Added to supplier payment");
                        response.sendRedirect("gst/BankTransactionList.jsp");
                    }
                    else {
                        session.setAttribute("result", "Failed!!");
                        response.sendRedirect("gst/BankTransactionList.jsp");
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
                bean3.setTransaction_date(IndianDateFormater.converToIndianFormat(transaction_date));
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
                             session.setAttribute("result", "Added to customer payment");
                             response.sendRedirect("BankTransactionList.jsp");
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
                            session.setAttribute("result", "Added to supplier payment");
                            response.sendRedirect("BankTransactionList.jsp");
                	}
                }else {
                         session.setAttribute("result", "Transaction Details Updated Successfully");
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
            
            
            else if(action.equals("deleteTransaction")) {
            	int id=Integer.parseInt(request.getParameter("id"));
            	String type=request.getParameter("type");
            	int count=0;
            	if(type.equals("cuspay")) {
            		 count=pdao.deletePaymentDetails(id);
            	}else if(type.equals("suppay")) {
            		 count=mdao.deleteMakePayment(id);
            	}else {
            		 count=pedao.deletePettyCash(id);
            	}
            	
            	writer.println(count);
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
                    response.sendRedirect("gst/AddBankDetail.jsp");
                }
                else {
                    session.setAttribute("result", (Object)"Unsuccessfully");
                    response.sendRedirect("gst/AddBankDetail.jsp");
                }
            }
            
            else if(action.equals("upload_file")){
            	int id=Integer.parseInt(request.getParameter("id"));
            	String type=request.getParameter("type");
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
					long name=System.currentTimeMillis();
					String extension=f.getFileName().substring(f.getFileName().lastIndexOf("."),f.getFileName().length());
					f.setFileName("t"+type+name+extension);
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
				int count=dao.insertFileUploadData(id, "t"+type, file_name);
				writer.println(file_name);
			}
            
            else if(action.equals("getDocuments")) {
            	response.setContentType("application/json");
            	response.setCharacterEncoding("utf-8");
            	Gson gson=new Gson();
            	int id=Integer.parseInt(request.getParameter("id"));
            	String type=request.getParameter("type");
            	List<Map<String,Object>> list=dao.getDocumentList(id, "t"+type);
            	writer.println(gson.toJson(list));
            }
            
            else if(action.equals("deleteFile")) {
            	int id=Integer.parseInt(request.getParameter("id"));
            	String fileName=request.getParameter("name");
            	Properties prop=new Properties();
				ClassLoader classLoader = Thread.currentThread().getContextClassLoader();
				InputStream input = classLoader.getResourceAsStream("com/willka/soft/util/Util.properties");
				prop.load(input);
				String path=prop.getProperty("mypath");
				String name = path+"/"+fileName;
				System.out.println(name);
				DocumentUtil.deleteFiles(name);
				int count=dao.deleteDocumentFileName(id);
				writer.println(count);
            }
            

        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }
}
