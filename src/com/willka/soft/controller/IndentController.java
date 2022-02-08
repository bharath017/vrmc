package com.willka.soft.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Calendar;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.willka.soft.bean.IndentBean;
import com.willka.soft.bean.IndentItemBean;
import com.willka.soft.bean.UserDetailBean;
import com.willka.soft.dao.IndentDAOImpl;

/**
 * Servlet implementation class IndentController
 */
@WebServlet("/IndentController")
public class IndentController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public IndentController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
		protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter writer=response.getWriter();
		
		//Get Session Object
		HttpSession session=request.getSession();
		IndentDAOImpl dao=new IndentDAOImpl();
		
		try {
			
			String pressed_button=request.getParameter("action");
			System.out.println("one");
			if(pressed_button.equals("raiseIndent")) 
			{
				synchronized (this) {
					//Get Request Purchase Order
					String indent_date=request.getParameter("indent_date");
					String required_date=request.getParameter("required_date");
					String budget_head=request.getParameter("budget_head");
					String justification=request.getParameter("justification");
					int plant_id=Integer.parseInt(request.getParameter("plant_id"));
					String type=request.getParameter("type");
					System.out.println("one1");
					String[] product_number=request.getParameterValues("product_number");
					String[] description1=request.getParameterValues("description1");
					String quantity[]=request.getParameterValues("quantity");
					String[] unit_price=request.getParameterValues("unit_price");
					String unit[]=request.getParameterValues("unit");
					//Create Supplier Purchase Order Bean Object
					IndentBean bean=new IndentBean();
					bean.setIndent_date(indent_date);
					bean.setRequired_date(required_date);
					bean.setJustification(justification);
					bean.setBudget_head(budget_head);
					bean.setPlant_id(plant_id);
					bean.setType(type);
					//get start and end year here
					Calendar cal=Calendar.getInstance();
					int year=cal.get(Calendar.YEAR);
					int month=cal.get(Calendar.MONTH);
					
					int start_year=0;
					int end_year=0;
					
					start_year=(month>=4)?year:year-1;
					end_year=(month>4)?year+1:year;
					
					int order_no=dao.getMaxOrderNo(plant_id, start_year, end_year);
					bean.setOrder_no(order_no);
					bean.setStart_year(start_year);
					bean.setEnd_year(end_year);
					UserDetailBean bein=(UserDetailBean)session.getAttribute("bean");
					String user_login_id=(bein.getUsername());
					String indentor=dao.getTheUserName(user_login_id);
					System.out.println(indentor);
					bean.setIndentor(indentor);
					bean.setDesignation(bein.getUsertype());
					//Now Insert GST Value
					int count=dao.insertIndent(bean);
					
					//Get Max Id
					int indent_id=dao.getMaxIndentId();
					int val=0;
					if(count>0) {
						for(int i=0;i<product_number.length;i++)
						{
							val++;
							IndentItemBean been=new IndentItemBean();
							if(product_number[i]!=null && !product_number[i].trim().equals(""))
							{
								been.setProduct_number(product_number[i]);
								been.setDescription1(description1[i]);
								been.setQuantity((quantity[i]==null || quantity[i].trim().equals(""))?0.0:Double.parseDouble(quantity[i]));
								been.setUnit_price((unit_price[i]==null || unit_price[i].trim().equals(""))?0.0:Double.parseDouble(unit_price[i]));
								been.setUnit(unit[i]);
								been.setIndent_id(indent_id);
								dao.insertIndentItem(been);
							}
						}
						
						if(val>0){
							//set session attribute value
							session.setAttribute("result", "INDENT INSERTED SUCCESSFULLY");
							response.sendRedirect("IndentList.jsp");
						}
						else{
							//set session attribute value
							session.setAttribute("result", "<span style='color:red;'>INDENT INSERTION UNSUCCESSFUL<span>");
							response.sendRedirect("IndentList.jsp");
						}
						
					}
					
					else{
						session.setAttribute("result", "<span style='color:red;'>INDENT INSERTION UNSUCCESSFUL<span>");
						response.sendRedirect("IndentList.jsp");
					}
					
				}
			}
			
			
		/*	else if(pressed_button.equals("getProduct"))
			{
				response.setContentType("application/json");
				response.setCharacterEncoding("UTF-8");
				Gson gson=new Gson();
				
				int supplier_purchase_order_id=Integer.parseInt(request.getParameter("supplier_purchase_order_id"));
				ArrayList<IndentItemBean> list=dao.getAllSupplierPurchaseOrderItem(supplier_purchase_order_id);
				writer.println(gson.toJson(list));
			}*/
			
			else if(pressed_button.equals("deleteIndent"))
			{
				int indent_id=Integer.parseInt(request.getParameter("indent_id"));
				int count=dao.deleteIndent(indent_id);
				if(count>0)
				{
					session.setAttribute("result", "Indent ID : "+indent_id+" DELETED SUCCESSFULLY");
					response.sendRedirect("IndentList.jsp");
				}
				else
				{
					session.setAttribute("result", "<span style='color:red;'>INDENT ID : "+indent_id+" DELETION UNSUCCESSFUL<span>");
					response.sendRedirect("IndentList.jsp");
				}
			}
			
			else if(pressed_button.equals("statusIndent"))
			{
				int indent_id=Integer.parseInt(request.getParameter("indent_id"));
				System.out.println(indent_id);
				int count=dao.statusIndent(indent_id);
				UserDetailBean bein=(UserDetailBean)session.getAttribute("bean");
				String user_login_id=(bein.getUsername());
				String approved_by=dao.getTheUserName(user_login_id);
				dao.approvedBy(approved_by, indent_id );
				if(count>0)
				{
					session.setAttribute("result", "INDENT ID : "+indent_id+" APPROVED");
					response.sendRedirect("IndentList.jsp");
				}
				else
				{
					session.setAttribute("result", "<span style='color:red;'>INDENT ID : "+indent_id+" APPROVAL FAILED<span>");
					response.sendRedirect("IndentList.jsp");
				}
			}
			
			
			/*else if(pressed_button.equals("deletesp")){
				int spoi_id=Integer.parseInt(request.getParameter("spoi_id"));
				int count=dao.deleteSupplierPurchaseOrderItem(spoi_id);
				if(count>0){
					writer.println("DELETED SUCCESSFULLY");
				}
			}*/
			
			else if(pressed_button.equals("updateIndent")) {
				String indent_date=request.getParameter("indent_date");
				String required_date=request.getParameter("required_date");
				String budget_head=request.getParameter("budget_head");
				String justification=request.getParameter("justification");
				int plant_id=Integer.parseInt(request.getParameter("plant_id"));
				int indent_id=Integer.parseInt(request.getParameter("indent_id"));
				String type=request.getParameter("type");
				System.out.println("one1");
				String[] indent_item_id=request.getParameterValues("indent_item_id");
				String[] product_number=request.getParameterValues("product_number");
				String[] description1=request.getParameterValues("description1");
				String quantity[]=request.getParameterValues("quantity");
				String[] unit_price=request.getParameterValues("unit_price");
				String unit[]=request.getParameterValues("unit");
				
				
				
				
				
				IndentBean bean=new IndentBean();
				bean.setIndent_date(indent_date);
				bean.setRequired_date(required_date);
				bean.setJustification(justification);
				bean.setBudget_head(budget_head);
				bean.setPlant_id(plant_id);
				bean.setType(type);
				bean.setIndent_id(indent_id);
				//Update Supplier Purchase Order
				
				int count=dao.updateIndent(bean);
				int val=0;
				if(count>0)
				{
					for(int i=0;i<product_number.length;i++)
					{
						val++;
						
						try {
							
							IndentItemBean been=new IndentItemBean();
							been.setIndent_item_id(Integer.parseInt(indent_item_id[i]));
							been.setProduct_number(product_number[i]);
							been.setDescription1(description1[i]);
							been.setQuantity((quantity[i]==null || quantity[i].trim().equals(""))?0.0:Double.parseDouble(quantity[i]));
							been.setUnit_price((unit_price[i]==null || unit_price[i].trim().equals(""))?0.0:Double.parseDouble(unit_price[i]));
							been.setIndent_id(indent_id);
							been.setUnit(unit[i]);
							dao.updateIndentItem(been);
						}
						catch(ArrayIndexOutOfBoundsException e)
						{
							if(product_number[i]!=null && !product_number[i].trim().equals("")) {
								IndentItemBean been=new IndentItemBean();
								been.setProduct_number(product_number[i]);
								been.setDescription1(description1[i]);
								been.setQuantity((quantity[i]==null || quantity[i].trim().equals(""))?0.0:Double.parseDouble(quantity[i]));
								been.setUnit_price((unit_price[i]==null || unit_price[i].trim().equals(""))?0.0:Double.parseDouble(unit_price[i]));
								been.setIndent_id(indent_id);
								been.setUnit(unit[i]);
								dao.insertIndentItem(been);
							}
						}
					}
					
					if(val>0){
						session.setAttribute("res", "INDENT ID : "+indent_id+" UPDATED SUCCESSFULLY");
						response.sendRedirect("IndentList.jsp");
					}else{
						session.setAttribute("res", "<span style='color:red;'>INDENT ID : "+indent_id+" UPDATION  UNSUCCESSFUL<span>");
						response.sendRedirect("IndentList.jsp");
					}
				}
				
			}
			
			
			
			
		}
		catch(Exception e)
		{
			e.printStackTrace();
			session.setAttribute("res", "<span style='color:red;'>INTERNAL ERROR OCCURED!!!<span>");
			response.sendRedirect("IndentList.jsp");
		}
	
	}

}

