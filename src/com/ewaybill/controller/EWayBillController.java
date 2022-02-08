package com.ewaybill.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ewaybill.service.EwaybillService;
import com.google.gson.Gson;

/**
 * Servlet implementation class EWayBillController
 */
@WebServlet("/EWayBillController")
public class EWayBillController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		EwaybillService service  = new EwaybillService();
		response.setContentType("application/json");
		response.setCharacterEncoding("utf-8");
		response.setHeader("Access-Control-Allow-Origin", "*");
	    response.setHeader("Access-Control-Allow-Methods", "POST, GET, OPTIONS, DELETE");
	    response.setHeader("Access-Control-Max-Age", "3600");
	    response.setHeader("Access-Control-Allow-Headers", "Content-Type, Origin, Cache-Control, X-Requested-With");
	    response.setHeader("Access-Control-Allow-Credentials", "true");
		Gson gson=new Gson();
		PrintWriter writer=response.getWriter();
		try {
			String action=request.getParameter("action");
			if(action.equals("authenticate")) {
				/*Map<String,Object> authenticateData = service.authenticateEWayBillPortal();
				writer.println(gson.toJson(authenticateData));*/
			}
			
			
			else if(action.equals("getGSTINDetails")) {
				String gstin = request.getParameter("gstin");
				Map<String,Object> gstDetails = service.getGSTINDetails(gstin);
				int errorCode = (int) gstDetails.get("errorCode");
				if(errorCode==238) {
					service.authenticateForGstDetails();
					gstDetails = service.getGSTINDetails(gstin);
				}
				writer.println(gson.toJson(gstDetails));
			}
			
				
			
			else if(action.equals("getZipCodeDistance")) {
				String apiKey = request.getParameter("apiKey");
				String zipCode1 = request.getParameter("zipCode1");
				String zipCode2 = request.getParameter("zipCode2");
				service.getDistanceBetweenTwoZipCode(apiKey, zipCode1, zipCode2);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}

}
