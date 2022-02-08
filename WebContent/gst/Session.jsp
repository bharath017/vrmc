<%@page import="com.willka.soft.bean.UserDetailBean"%>
<%
 response.setHeader("Cache-Control","no-cache"); //Forces caches to obtain a new copy of the page from the origin server
 response.setHeader("Cache-Control","no-store"); //Directs caches not to store the page under any circumstance
 response.setDateHeader("Expires", 0); //Causes the proxy cache to see the page as "stale"
 response.setHeader("Pragma","no-cache"); //HTTP 1.0 backward compatibility
  UserDetailBean bean=(UserDetailBean)session.getAttribute("bean");
   String uname=(bean==null)?null:bean.getUsertype();
	String file=request.getServletPath();
	file=file.substring(1);
	System.out.println(uname);
if(uname==null){
	request.setAttribute("errormessage", "Session has ended.  Please login.");
	response.sendRedirect("../login.jsp");
}else if(!uname.equals("gst") && !uname.equals("gstbilling") 
		&& !uname.equals("gstqc") && !uname.equals("gststore") && !uname.equals("sgst")
		&& !uname.equals("gstadmin") && !uname.equals("gstaccount") && !uname.equals("gstmarketing")){
	session.invalidate();
	response.sendRedirect("../login.jsp");
}
%>