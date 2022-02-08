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
        	   File reportFile = new File(application.getRealPath("PrintCubeTestT.jasper"));//your report_name.jasper file
               Map parameters = new HashMap();
        	   int tst_id=Integer.parseInt(request.getParameter("tst_id"));
        	   parameters.put("tst_id", tst_id);
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
        
        
  