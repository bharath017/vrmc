<%@page import="com.willka.soft.util.DBUtil"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@page import="net.sf.jasperreports.engine.JasperRunManager"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.io.File"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

		<%
            Connection conn = null;
            try {
                conn = DBUtil.getConnection();
            } catch (Exception ex) {
                ex.printStackTrace();
            }
           try{
        	   File reportFile=null;
        	   int plant_id=Integer.parseInt(request.getParameter("plant_id"));
        	   if(plant_id==1){
        		   reportFile = new File(application.getRealPath("Print/Inventory/PrintInventory.jasper"));//your report_name.jasper file   
        	   }else if(plant_id==2){
        		   reportFile = new File(application.getRealPath("Print/Inventory/PrintInventoryRMC.jasper"));//your report_name.jasper file
        	   }else{
        		   reportFile = new File(application.getRealPath("Print/Inventory/PrintInventoryPrecast2.jasper"));//your report_name.jasper file
        	   }
        	  
               Map parameters = new HashMap();
        	   int inventory_id=Integer.parseInt(request.getParameter("inventory_id"));
        	   parameters.put("inventory_id", inventory_id);
               byte[] bytes = JasperRunManager.runReportToPdf(reportFile.getPath(), parameters, conn);
               response.setContentType("application/pdf");
               response.setContentLength(bytes.length);
               ServletOutputStream outStream = response.getOutputStream();
               outStream.write(bytes, 0, bytes.length);
               outStream.flush();
               outStream.close();
           }catch(Exception e){
        	   e.printStackTrace();
           }
        %>
        
        
  