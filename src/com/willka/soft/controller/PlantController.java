package com.willka.soft.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
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
import com.willka.soft.bean.PlantBean;
import com.willka.soft.bean.PlantDeliveryAddressBean;
import com.willka.soft.dao.PlantDAOImpl;

@WebServlet("/PlantController")
public class PlantController extends HttpServlet {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void doPost(HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException{
		//general settings
		
		PrintWriter writer=null;
		//general settings
		writer=response.getWriter();
		response.setContentType("text/html");
		String pressed_button=null;
		//create EmployeeDAO object
		PlantDAOImpl dao=new PlantDAOImpl();
		//create SalaryStructureIMpl object
		HttpSession session=request.getSession();
		
		try {
			//first check if request is normal or multipart
			pressed_button=request.getParameter("button");
				if(pressed_button.equals("insert")){
					//get all paramter 
					synchronized (request) {
						String plant_name=request.getParameter("plant_name");
						String plant_address=request.getParameter("plant_address");
						String plant_phone=request.getParameter("plant_phone");
						String plant_email=request.getParameter("plant_email");
						String plant_manager=request.getParameter("plant_manager");
						String plant_gstin=request.getParameter("plant_gstin");
						String plant_domain=request.getParameter("plant_domain");
						String plant_cst=request.getParameter("plant_cst");
						String plant_panno=request.getParameter("plant_panno");
						String plant_transport=request.getParameter("plant_transport");
						String plant_regno=request.getParameter("plant_regno");
						String delivery_address=request.getParameter("delivery_address");
						int business_id=Integer.parseInt(request.getParameter("business_id"));
						
						//create plantbean ojbect
						PlantBean been=new PlantBean();
						been.setPlant_name(plant_name);
						been.setPlant_address(plant_address);
						been.setPlant_panno(plant_panno);
						been.setPlant_phones(plant_phone);
						been.setPlant_email(plant_email);
						been.setPlant_manager(plant_manager);
						been.setPlant_gstin(plant_gstin);
						been.setPlant_cst(plant_cst);
						been.setPlant_domain(plant_domain);
						been.setPlant_transport(plant_transport);
						been.setPlant_regno(plant_regno);
						been.setBilling_address(delivery_address);
						been.setBusiness_id(business_id);
						
						
						
						int count=dao.insertPlant(been);
						if(count>0){
							
							int plant_id=dao.getMaxPlantId();
							PlantDeliveryAddressBean bean=new PlantDeliveryAddressBean();
							bean.setDelivery_address(delivery_address);
							bean.setPlant_id(plant_id);
							dao.insertPlantDeliveryAddress(bean);
							session.setAttribute("result", "PLANT "+plant_name+" INSERTION SUCCESSFUL");
							response.sendRedirect("PlantList.jsp");
						}
						else{
							session.setAttribute("result", "PLANT "+plant_name+" INSERTION UNSUCCESSFUL");
							response.sendRedirect("PlantList.jsp");
						}
					}
					
					
					
				}
				else if(pressed_button.equals("update")){
					
					//get all paramter 
					int plant_id=Integer.parseInt(request.getParameter("plant_id"));
					String plant_name=request.getParameter("plant_name");
					String plant_address=request.getParameter("plant_address");
					String plant_phone=request.getParameter("plant_phone");
					String plant_email=request.getParameter("plant_email");
					String plant_manager=request.getParameter("plant_manager");
					String plant_gstin=request.getParameter("plant_gstin");
					String plant_domain=request.getParameter("plant_domain");
					String plant_cst=request.getParameter("plant_cst");
					String plant_panno=request.getParameter("plant_panno");
					String plant_transport=request.getParameter("plant_transport");
					String plant_regno=request.getParameter("plant_regno");
					String delivery_address=request.getParameter("delivery_address");
					int business_id=Integer.parseInt(request.getParameter("business_id"));
					
					//create plantbean ojbect
					PlantBean been=new PlantBean();
					been.setPlant_id(plant_id);
					been.setPlant_name(plant_name);
					been.setPlant_address(plant_address);
					been.setPlant_panno(plant_panno);
					been.setPlant_phones(plant_phone);
					been.setPlant_email(plant_email);
					been.setPlant_manager(plant_manager);
					been.setPlant_gstin(plant_gstin);
					been.setPlant_cst(plant_cst);
					been.setPlant_domain(plant_domain);
					been.setPlant_transport(plant_transport);
					been.setPlant_regno(plant_regno);
					been.setBilling_address(delivery_address);
					been.setBusiness_id(business_id);
					
					int count=dao.updatePlant(been);
					if(count>0){
						session.setAttribute("result", "PLANT "+plant_name+" UPDATION SUCCESSFUL");
						response.sendRedirect("PlantList.jsp");
					}
					else{
						session.setAttribute("result", "PLANT "+plant_name+" UPDATION UNSUCCESSFUL");
						response.sendRedirect("PlantList.jsp");
					}
					
			}
			
				else if(pressed_button.equals("delete")){
					//get HttpSession object
					HttpSession ses=request.getSession();
					try{
						int plant_id=Integer.parseInt(request.getParameter("plant_id"));
						
						int count=dao.deletePlant(plant_id);
						if(count>0){
							ses.setAttribute("result","PLANT ID : "+plant_id+" DELETION IS SUCCESSFUL");
							response.sendRedirect("plant_list.jsp");
						}
						else{
							ses.setAttribute("result","PLANT ID : "+plant_id+" DELETION IS UNSUCCESSFUL");
							response.sendRedirect("plant_list.jsp");
						}
					}catch(Exception ea){
						ses.setAttribute("result","CANN'T DELETE!! PLANT IS IN USE MODE");
						response.sendRedirect("plant_list.jsp");
					}
				}
			
				
			if(pressed_button.equals("getAllPlant")){
				//get plant detail
				List<PlantBean> plant_list=dao.getAllPlantList();
				//print plantlist detail
				writer.println("<option value='' selected='selected' disabled='disabled'>Choose Plant</option>");
				for(PlantBean plt_bean:plant_list){
				writer.println("<option value='"+plt_bean.getPlant_id()+"'>"+plt_bean.getPlant_name()+"</option>");	
				}
			}
			
			else if(pressed_button.equals("getAllPlantDetail")){
				List<PlantBean> plant_list=dao.getAllPlantList();
				//print plantlist detail
				writer.println("<option value='' selected='selected' disabled='disabled'>Choose Plant</option>");
				for(PlantBean plt_bean:plant_list){
				writer.println("<option value='"+plt_bean.getPlant_id()+"'>"+plt_bean.getPlant_name()+"</option>");	
				}
			}
			else if(pressed_button.equals("getAddress")){
				//get request parameter value
				int plant_id=Integer.parseInt(request.getParameter("plant_id"));
				//get address
				PlantBean been=dao.getplantById(plant_id);
				writer.println(been.getPlant_address());
			}
			
			
			else if(pressed_button.equals("InsertDeliveryAddress")) {
				int plant_id=Integer.parseInt(request.getParameter("plant_id"));
				String delivery_address=request.getParameter("delivery_address");
				
				PlantDeliveryAddressBean bean=new PlantDeliveryAddressBean();
				bean.setPlant_id(plant_id);
				bean.setDelivery_address(delivery_address);
				
				int count=dao.insertPlantDeliveryAddress(bean);
				
				if(count>0) {
					session.setAttribute("result", "Delivery Address Inserted");
					response.sendRedirect("PlantView.jsp?plant_id="+plant_id);
				}else {
					session.setAttribute("result", "<span class='text-danger'>Failed!!!</span>");
					response.sendRedirect("PlantView.jsp?plant_id="+plant_id);
				}
			}
			
			else if(pressed_button.equals("UpdatePlantDeliveryAddress")) {
				int pl_delivery_address_id=Integer.parseInt(request.getParameter("pl_delivery_address_id"));
				String delivery_address=request.getParameter("delivery_address");
				int plant_id=Integer.parseInt(request.getParameter("plant_id"));
				
				PlantDeliveryAddressBean bean=new PlantDeliveryAddressBean();
				
				bean.setDelivery_address(delivery_address);
				bean.setPl_delivery_address_id(pl_delivery_address_id);
				
				int count=dao.updatePlantDeliveryAddress(bean);
				
				if(count>0) {
					session.setAttribute("result", "Delivery Address Updated");
					response.sendRedirect("PlantView.jsp?plant_id="+plant_id);
				}else {
					session.setAttribute("result", "<span class='text-danger'>Failed!!!</span>");
					response.sendRedirect("PlantView.jsp?plant_id="+plant_id);
				}
			}
			
			else if(pressed_button.equals("getDeliveryAddressDetails")) {
				response.setContentType("application/json");
				response.setCharacterEncoding("utf-8");
				Gson gson=new Gson();
				int pl_delivery_address_id=Integer.parseInt(request.getParameter("pl_delivery_address_id"));
				PlantDeliveryAddressBean bean=dao.getPlantDeliveryAddressById(pl_delivery_address_id);
				writer.println(gson.toJson(bean));
			}
			
			else if(pressed_button.equals("changeStatus")) {
				int pl_delivery_address_id=Integer.parseInt(request.getParameter("pl_delivery_address_id"));
				int plant_id=Integer.parseInt(request.getParameter("plant_id"));
				
				int count=dao.changeDeliveryAddressStatus(pl_delivery_address_id);
				
				if(count>0) {
					session.setAttribute("result", "Delivery Address Status Changed");
					response.sendRedirect("PlantView.jsp?plant_id="+plant_id);
				}else {
					session.setAttribute("result", "<span class='text-danger'>Failed!!!</span>");
					response.sendRedirect("PlantView.jsp?plant_id="+plant_id);
				}
			}
			
			else if(pressed_button.equals("getAllAddressById")) {
				response.setContentType("application/json");
				response.setCharacterEncoding("utf-8");
				Gson gson=new Gson();
				int plant_id=Integer.parseInt(request.getParameter("plant_id"));
				ArrayList<PlantDeliveryAddressBean> list=dao.getAllDevlieryAddressById(plant_id);
				writer.println(gson.toJson(list));
			}
			
			else if(pressed_button.equals("getPlantByBusinessId")) {
				response.setContentType("application/json");
				response.setCharacterEncoding("utf-8");
				Gson gson=new Gson();
				int business_id=Integer.parseInt(request.getParameter("business_id"));
				List<Map<String,Object>> list=dao.getPlantDetailsByBusinessId(business_id);
				writer.println(gson.toJson(list));
			}
			
			else if(pressed_button.equals("GetPlantForSelect")) {
				response.setContentType("application/json;charset=utf-8");
				response.setCharacterEncoding("utf-8");
				Gson gson=new Gson();
				
				int plant_id=(request.getParameter("plant_id")==null || request.getParameter("plant_id").trim().equals(""))?
						-1:Integer.parseInt(request.getParameter("plant_id"));
				int business_id=Integer.parseInt(request.getParameter("business_id"));
				HashMap<Integer,String> plants=dao.getPlantListForSelect(plant_id,business_id);
				writer.println(gson.toJson(plants));
			}
			
			
			
		}catch(Exception ea){
			ea.printStackTrace();
			
		}
	}
}