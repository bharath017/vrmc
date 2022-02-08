package com.willka.soft.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLIntegrityConstraintViolationException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.willka.soft.bean.GradeComposition;
import com.willka.soft.bean.ProductBean;
import com.willka.soft.dao.ProductDAOImpl;
@WebServlet("/ProductController")
public class ProductController extends HttpServlet{
	private static final long serialVersionUID = 13535L;

	public void doPost(HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException
	{
		response.setContentType("text/html");
		ProductDAOImpl dao=new ProductDAOImpl();
		PrintWriter writer=response.getWriter();
		try{
			String action=request.getParameter("action");
			if(action.equals("GetNameSuggestion")) {
				response.setContentType("application/json");
				response.setCharacterEncoding("utf-8");
				Gson gson=new Gson();
				ArrayList<String> list=dao.getAllProductNamesForSuggestion();
				writer.println(gson.toJson(list));
			}
			
			else if(action.equals("getProductList")) {
				response.setContentType("application/json");
				response.setCharacterEncoding("utf-8");
				Gson gson=new Gson();
				int start=Integer.parseInt(request.getParameter("start"));
				int length=Integer.parseInt(request.getParameter("length"));
				int business_id=Integer.parseInt(request.getParameter("business_id"));
				Map<String,Object> data=new HashMap<>();
				String search=request.getParameter("search[value]");
				int draw=Integer.parseInt(request.getParameter("draw"));
				data.put("data", dao.getAllProductList(search, business_id, start, length));
				data.put("draw", draw);
				int recordCount=dao.countAllProductList(search, business_id);
				data.put("recordsTotal", recordCount);
				data.put("recordsFiltered", recordCount);
				writer.print(gson.toJson(data));
			}
			
			else if(action.equals("addNewProduct")) {
				try {
					String product_name=request.getParameter("product_name");
					String product_detail=request.getParameter("product_details");
					String unit_of_measurement=request.getParameter("unit");
					int business_id=Integer.parseInt(request.getParameter("business_id"));
					String hsn_code=request.getParameter("hsn_code");
					boolean isConversionRequired=request.getParameter("isConversionRequired")!=null?true:false;
					double conversion_value=(isConversionRequired)?Double.parseDouble(request.getParameter("conversion_value")):0;
					ProductBean bean=new ProductBean();
					bean.setProduct_name(product_name);
					bean.setProduct_detail(product_detail);
					bean.setUnit_of_measurement(unit_of_measurement);
					bean.setBusiness_id(business_id);
					bean.setHsn_code(hsn_code);
					bean.setConversionRequired(isConversionRequired);
					bean.setConversion_value(conversion_value);
					int count=dao.insertProduct(bean);
					writer.println(count);
				}catch(Exception e) {
					e.printStackTrace();
					writer.println(-1);
				}
			}
			
			else if(action.equals("getSingleProductDetails")) {
				response.setContentType("application/json");
				response.setCharacterEncoding("utf-8");
				Gson gson=new Gson();
				int product_id=Integer.parseInt(request.getParameter("product_id"));
				HashMap<String, Object> map=dao.getSingleProductDetails(product_id);
				writer.println(gson.toJson(map));
			}
			
			else if(action.equals("updateProduct")) {
				try {
					int product_id=Integer.parseInt(request.getParameter("product_id").trim());
					String product_name=request.getParameter("product_name");
					String product_detail=request.getParameter("product_details");
					String unit_of_measurement=request.getParameter("unit");
					int business_id=Integer.parseInt(request.getParameter("business_id"));
					String hsn_code=request.getParameter("hsn_code");
					boolean isConversionRequired=request.getParameter("isConversionRequired")!=null?true:false;
					double conversion_value=(isConversionRequired)?Double.parseDouble(request.getParameter("conversion_value")):0;
					ProductBean bean=new ProductBean();
					bean.setProduct_name(product_name);
					bean.setProduct_detail(product_detail);
					bean.setUnit_of_measurement(unit_of_measurement);
					bean.setProduct_id(product_id);
					bean.setBusiness_id(business_id);
					bean.setHsn_code(hsn_code);
					bean.setConversionRequired(isConversionRequired);
					bean.setConversion_value(conversion_value);
					int count=dao.updateProduct(bean);
					writer.println(count);
				}catch(Exception e) {
					e.printStackTrace();
					writer.println(-1);
				}
			}
			
			else if(action.equals("ViewProductDetails")) {
				response.setContentType("application/json");
				response.setCharacterEncoding("utf-8");
				Gson gson=new Gson();
				int product_id=Integer.parseInt(request.getParameter("product_id"));
				HashMap<String, Object> details=new HashMap<String, Object>();
				HashMap<String, Object> view=dao.getSingleProductDetails(product_id);
				ArrayList<HashMap<String, Object>> list=dao.getSingleGradecompositionDetails(product_id);
				details.put("detail", view);
				details.put("view", list);
				writer.println(gson.toJson(details));
			}
			
			else if(action.equals("insertComposition")){
				int inv_item_id=Integer.parseInt(request.getParameter("inv_item_id"));
				int product_id=Integer.parseInt(request.getParameter("product_id"));
				double quantity=Double.parseDouble(request.getParameter("quantity"));
				GradeComposition bean=new GradeComposition();
				bean.setProduct_id(product_id);
				bean.setComp_weight(quantity);
				bean.setSp_id(inv_item_id);
				try {
					int count=dao.addComposition(bean);
					writer.println(count);
				}catch(SQLIntegrityConstraintViolationException e) {
					writer.println(-10);
				}
				
			}
			
			else if(action.equals("getCompositionList")) {
				response.setContentType("application/json");
				response.setCharacterEncoding("utf-8");
				Gson gson=new Gson();
				int product_id=Integer.parseInt(request.getParameter("product_id"));
				ArrayList<HashMap<String, Object>> list=dao.getSingleGradecompositionDetails(product_id);
				writer.println(gson.toJson(list));
			}
			
			else if(action.equals("updateOtherDetails")) {
				String cem_type=request.getParameter("cem_type");
				double cem_quantity=Double.parseDouble(request.getParameter("cem_quantity"));
				String max_aggregate=request.getParameter("max_aggregate");
				double max_wc=Double.parseDouble(request.getParameter("max_wc"));
				int product_id=Integer.parseInt(request.getParameter("product_id"));
				
				ProductBean bean=new ProductBean();
				bean.setCem_type(cem_type);
				bean.setCem_quantity(cem_quantity);
				bean.setMax_aggregate(max_aggregate);
				bean.setMax_wc(max_wc);
				bean.setProduct_id(product_id);
				
				int count=dao.updateOtherDetails(bean);
				writer.println(count);
			}
			
			
			else if(action.equals("deleteComp")) {
				int comp_id=Integer.parseInt(request.getParameter("comp_id"));
				int count=dao.removeComposition(comp_id);
				writer.println(count);
			}
			
			else if(action.equals("changeProductStatus")) {
				int product_id=Integer.parseInt(request.getParameter("product_id"));
				String status=request.getParameter("status");
				int count=dao.changeProductStatus(product_id, status);
				writer.println(count);
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
}
