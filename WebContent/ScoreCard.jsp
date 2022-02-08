<!DOCTYPE html>
<%@page import="com.willka.soft.util.DBUtil"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.GregorianCalendar"%>
<%@page import="java.util.Calendar"%>
<%@page import="com.willka.soft.dao.VehicleDAOImpl"%>
<%@page import="com.willka.soft.bean.UserDetailBean"%>
<%@ include file="Session.jsp" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"  %>  
<html>
<head>
        <meta charset="utf-8" />
        <title>SCORE CARD - ${initParam.company_name}</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
        <meta content="A fully featured admin theme which can be used to build CRM, CMS, etc." name="description" />
        <meta content="Coderthemes" name="author" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />

        <!-- App favicon -->
        <link rel="shortcut icon" href="assets/images/favicon.ico">
		<link rel="stylesheet" href="picker/cs/bootstrap-datepicker3.min.css" />
		<link rel="stylesheet" href="picker/cs/bootstrap-timepicker.min.css" />
        <!-- App css -->
 		 <link rel="shortcut icon" href="assets/images/favicon.ico">
        <link href="assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/icons.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/style.css" rel="stylesheet" type="text/css" />
		  <!-- Custom box css -->
        <link href="plugins/custombox/css/custombox.min.css" rel="stylesheet">
        <link rel="stylesheet" href="assets/css/select2.min.css" />
		<link rel="stylesheet" href="assets/css/render.css">
        <script src="assets/js/modernizr.min.js"></script>
        <style type="text/css">
        	@media print{
        		.no-print{
        			display: none !important;
        		}
        		
/*         		.modal{
    display: block !important; /* I added this to see the modal, you don't need this */
}

/* Important part
.modal-dialog{
    overflow-y: initial !important
}
.modal-body{
    overflow-y: auto;
} */
        	}
        </style>

<script type="text/javascript">
		 function printMe(divName) {
		     var printContents = document.getElementById(divName).innerHTML;
		     var originalContents = document.body.innerHTML;
		     document.body.innerHTML = printContents;
		     window.print();
		     document.body.innerHTML = originalContents;
		}
		</script>


    </head>
<!--  GET PLANT INFORMATION HERE-->
		<c:choose>
			<c:when test="${plant_id==0}">
				<sql:query var="plant" dataSource="jdbc/rmc">
					select * from plant
				</sql:query>
			</c:when>
			<c:otherwise>
				<sql:query var="plant" dataSource="jdbc/rmc">
					select * from plant where plant_id=?
					<sql:param value="${plant_id}"/>
				</sql:query>
			</c:otherwise>
		</c:choose>
	<!-- GETTING PLANT INFORMATION END'S HERE -->
    <body>

        <!-- Navigation Bar-->
        	<%@ include file="header.jsp" %>
        <!-- End Navigation Bar-->


	<div class="wrapper">
		<div class="container-fluid">

			<!-- Page-Title -->

			<div class="row">
				<div class="col-sm-12">
					<div class="page-title-box">
						<div class="btn-group pull-right">
							<ol class="breadcrumb hide-phone p-0 m-0">
								<li class="breadcrumb-item"><a href="#">Home</a></li>
								<li class="breadcrumb-item"><a href="#">Sales</a></li>
								<li class="breadcrumb-item"><a href="#">Score Card</a></li>
							</ol>
						</div>

						<c:choose>
							<c:when test="${param.action=='update'}">
								<h4 class="page-title">Score Card</h4>
							</c:when>
							<c:otherwise>
								<h4 class="page-title">Score Card</h4>
							</c:otherwise>
						</c:choose>

					</div>
				</div>
			</div>


	               <div class="row">
		                    <div class="col-sm-12">
		                    	<form class="" action="ScoreCard.jsp?action=update" name="invoice_form"  method="post">
			                        <div class="card-box row col-sm-12">
			                        	<div class="col-sm-12 text-center">
			                        		<h2 style="color: #1f6b75;">Score Card Report</h2>
			                        		 <c:choose>
			                               		 <c:when test="${usertype=='admin'|| usertype=='superadmin' || usertype=='marketing_head'}">
			                        		<div class="pull-right"> <a class="btn btn-custom waves-effect waves-light" href="#view-model5" data-animation="blur" data-plugin="custommodal"  data-overlaySpeed="100" data-overlayColor="#36404a">Set Target</a></div>
			                        			</c:when>
			                        		</c:choose>
			                        	</div>
			                        	<div class="col-sm-3">
			                        		
			                        	</div>
			                           	<div class="col-sm-6">
			                               	<div class="form-group">
			                                     <label>REPORT TYPE :  <span class="text-danger">*</span> </label>
	       									<select id="type"  name="type" required="required"   class="select2"  data-placeholder="Choose Type">
											<option value="all">ALL </option>
											<option value="one">SINGLE Individual </option>
											<!-- <option value="few">ALL  FEW DETAIL</option> -->
											<option value="customdate">Custom Date</option>
											</select>
										</div>
										
										<div class="form-group">
			                                <label>Marketing Person :  <span class="text-danger">*</span> </label>
			                                 <c:set var="user_id" value="${bean.user_id}"/>
			                                <c:choose>
			                               		 <c:when test="${usertype=='admin'|| usertype=='superadmin'}">
			                               		 <c:set var="user_id" value='0'/>
			                               		 </c:when>
			                                </c:choose>
			                              	 <sql:query var="vehicle" dataSource="jdbc/rmc">
                                             	select * from marketing_person where mp_head like if('0'=?,'%%',?) UNION select *from marketing_person where mp_id like if('0'=?,'%%',?)
                                             	<sql:param value="${user_id}"/>
                                             	<sql:param value="${user_id}"/>
                                             	<sql:param value="${user_id}"/>
                                             	<sql:param value="${user_id}"/>
                                              </sql:query>
	       									<select id="e_id"  name="e_id" required="required"  class="select2"  data-placeholder="Choose Marketing Person">
	       									<option value="all">ALL</option>
											<c:forEach items="${vehicle.rows}" var="vehicle">
												<option value="${vehicle.mp_id}">${vehicle.mp_name}</option>
											</c:forEach>
										</select>
										</div>
			                            
			                                
			                           <div class="form-group no-custom">
				                             <label>Month :  <span class="text-danger">*</span> </label>
		       									<select id="month"  name="month" required="required"   class="select2 no-custom"  data-placeholder="Choose Month">
												<option value=""></option>
												<option value="1">JAN</option>
												<option value="2">FEB</option>
												<option value="3">MAR</option>
												<option value="4">APR</option>
												<option value="5">MAY</option>
												<option value="6">JUNE</option>
												<option value="7">JULY</option>
												<option value="8">AUG</option>
												<option value="9">SEP</option>
												<option value="10">OCT</option>
												<option value="11">NOV</option>
												<option value="12">DEC</option>
										  </select>
									</div>
								 	 <div class="form-group no-custom">
			                             <label>Year :  <span class="text-danger">*</span> </label>
	       								<select id="year"  name="year" required="required"   class="select2 no-custom"  data-placeholder="Choose Year">
											<option value=""></option>
											<option value="2017">2017</option>
											<option value="2018">2018</option>
											<option value="2019">2019</option>
											<option value="2020">2020</option>
											<option value="2021">2021</option>
											<option value="2022">2022</option>
											<option value="2023">2023</option>
											<option value="2024">2024</option>
											<option value="2025">2025</option>
									  </select>
								</div>
								<div class="form-group custom">
                                      <label>From Date<span class="text-danger">*</span> </label>
                                      <div>
                                          <div class="input-group">
                                              <input type="text" name="from_date"  value="" class="form-control date-picker custom"  placeholder="yyyy-mm-dd" id="id-date-picker-1" data-date-format="yyyy-mm-dd">
                                              <div class="input-group-append">
                                                  <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
                                              </div>
                                          </div>
                                      </div>
                                </div>
                                <div class="form-group custom">
                                      <label>To Date<span class="text-danger">*</span> </label>
                                      <div>
                                          <div class="input-group">
                                              <input type="text" name="to_date"  value="" class="form-control date-picker custom"  placeholder="yyyy-mm-dd" id="id-date-picker-2" data-date-format="yyyy-mm-dd">
                                              <div class="input-group-append">
                                                  <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
                                              </div>
                                          </div>
                                      </div>
                                </div>
								<div class="form-group">
									<a href="consumption_sheet.jsp" type="reset"
										class="btn btn-prev"> <i class="ace-icon"></i> CLEAR
									</a>

									<button type="submit" id="get_report"
										class="btn btn-success btn-next">
										GENERATE REPORT <i class="ace-icon  icon-on-right"></i>
									</button>
								</div>
							</div>
		                        	</div>
		                        </form>
		                    </div>
		                </div>
		                


         			 <c:if test="${param.type=='all'}">
						<div class="row table-responsive">
							<div class="col-xs-12">
								<!-- GET ALL DIESEL CONSUMPTION DETAIL HERE -->
								<div class="col-sm-12 text-center">
               		 			 <c:set var = "now" value = "<%= new java.util.Date()%>" />
               		 			 <c:set var = "month" value = "${param.month}" />
               		  <!-- formatting selected month and year to date format -->
               		 			 <c:set var = "conver" value = "20-${param.month}-${param.year}" />
               		  <!-- Parsing the obtained string date format -->
               		 			  <fmt:parseDate value = "${conver}" var = "parsed" pattern = "dd-MM-yyyy" />
               		   <!-- value takes only parsed data -->
									<h4 style="color: red;" class="text-center">MONTH : <fmt:formatDate type = "date" dateStyle = "long"  pattern="MMMMMMMMMM"  value="${parsed}" />
					        &nbsp;&nbsp;&nbsp;&nbsp;YEAR : ${param.year}  
					        &nbsp;&nbsp;&nbsp;&nbsp;  DATE:<fmt:formatDate pattern = "dd-MM-yyyy"  value = "${now}" /></h4>
					               		</div>
								<table id="score_card" class="table table-bordered table-stripped">
									<%
									int iYear = Integer.parseInt(request.getParameter("year"));
									int iMonth = Integer.parseInt(request.getParameter("month"))-1; // 1 (months begin with 0)
									int iDay = 1;
	
									Calendar mycal = new GregorianCalendar(2000, iMonth, 1);
									int daysInMonth= mycal.getActualMaximum(Calendar.DAY_OF_MONTH);   
									pageContext.setAttribute("count", daysInMonth);
									%>
								   <thead>
									   		<tr style="background-color: white;">
									   			 <th>Sales Person/DATE</th>
										          
										          <th>No. of Quotations</th>
										          <th>Quotation Quantity</th>
										          <th>No. of Visits</th>
										          <th>New customers</th>
										          <th>New Customer Quantity</th>
										          <th>Collections</th>
										          <th>Target Quantity</th>
										          <th>Quantity Supplied</th>
										          <th>Variance</th>
									   		</tr>
								  </thead>
								  <tbody>
								  	 <%
								  	UserDetailBean been=(UserDetailBean)session.getAttribute("bean");
								  	 int user_id=been.getUser_id();
								  	 String user_type= been.getUsertype();
								  	 	if(user_type.equals("admin") || user_type.equals("superadmin") ){
								  	 		user_id=0;
								  	 	}
										Connection con=DBUtil.getConnection();
								  	PreparedStatement ps=con.prepareStatement("select * from marketing_person where mp_head like if ('0'=?,'%%',?) UNION select * from marketing_person where mp_id like if ('0'=?,'%%',?)");
									ps.setInt(1, user_id);
									ps.setInt(2, user_id);
									ps.setInt(3, user_id);
									ps.setInt(4, user_id);
										ResultSet rs=ps.executeQuery();
										while(rs.next()){
									%>
									
									
									<%
								  	 			int[] arr=new int[daysInMonth+1];
								  	 			PreparedStatement ps1=con.prepareStatement("select p.*,(select sum(qi.quantity)  from customer_quotation_item qi "+
								  	 				" left join customer_quotation q on q.quotation_id=qi.quotation_id  where q.mp_id=? and month(q.quotation_date)=?  "+
								  	 				" and year(q.quotation_date)=?)as quotation_quantity, "+
								  	 				" (select count(customer_id) from customer where mp_id=? and month(timestamp)=? and year(timestamp)=?) as customercount, "+
								  	 				" (select count(q.quotation_id)  from customer_quotation q where q.mp_id=? and month(q.quotation_date)=? and year(q.quotation_date)=?)as quotation_count, "+
								  	 				" (select sum(i.quantity) from invoice i LEFT JOIN (purchase_order_item poi,purchase_order po) ON i.poi_id=poi.poi_id and poi.order_id=po.order_id "+
								  	 				" where po.marketing_person_id=? and month(i.invoice_date)=? and year(i.invoice_date)=? order by i.id asc) as iquantity, "+
								  	 				" (select target_quantity from sales_target where mp_id=? and month(date)=? and year(date)=?) as target_quantity,"+
								  	 				" (select sum(i.quantity) from invoice i LEFT JOIN (purchase_order_item poi,purchase_order po,customer c) "+
								  	 				" ON i.poi_id=poi.poi_id and poi.order_id=po.order_id AND po.marketing_person_id=c.mp_id and c.customer_id=po.customer_id "+
								  	 				" where po.marketing_person_id=? and DATEDIFF(date(i.invoice_date),c.timestamp)<5 and month(i.invoice_date)=? and year(i.invoice_date)=?) as   ncquantity  "+
								  	 				" from (select k.fcount,k.camount from (select count(follow_up_report_id) as fcount, sum(amount) as camount from follow_up_report "+
								  	 				" where user_id=? and month(date)=? and year(date)=?)as k)as p");  
								  	 			ps1.setInt(1, rs.getInt("mp_id"));
								  	 			ps1.setInt(2, Integer.parseInt(request.getParameter("month")));
												ps1.setInt(3, Integer.parseInt(request.getParameter("year")));
												ps1.setInt(4, rs.getInt("mp_id"));
												ps1.setInt(5, Integer.parseInt(request.getParameter("month")));
												ps1.setInt(6, Integer.parseInt(request.getParameter("year")));
												ps1.setInt(7, rs.getInt("mp_id"));
												ps1.setInt(8, Integer.parseInt(request.getParameter("month")));
												ps1.setInt(9, Integer.parseInt(request.getParameter("year")));
												ps1.setInt(10, rs.getInt("mp_id"));
												ps1.setInt(11, Integer.parseInt(request.getParameter("month")));
												ps1.setInt(12, Integer.parseInt(request.getParameter("year")));
												ps1.setInt(13, rs.getInt("mp_id"));
												ps1.setInt(14, Integer.parseInt(request.getParameter("month")));
												ps1.setInt(15, Integer.parseInt(request.getParameter("year")));
												ps1.setInt(16, rs.getInt("mp_id"));
												ps1.setInt(17, Integer.parseInt(request.getParameter("month")));
									 			ps1.setInt(18, Integer.parseInt(request.getParameter("year")));
									 			ps1.setInt(19, rs.getInt("mp_id"));
												ps1.setInt(20, Integer.parseInt(request.getParameter("month")));
									 			ps1.setInt(21, Integer.parseInt(request.getParameter("year")));
												ResultSet rs1=ps1.executeQuery();
												
												while(rs1.next()){
											 	%>
									
								  	 	<tr>
								  	 		<td style="background-color: white;"><%=rs.getString("mp_name")%></td>
								  	 		
								  	 		<td><%=rs1.getInt("quotation_count") %></td>
								  	 		<td><%=rs1.getDouble("quotation_quantity") %></td>
								  	 		<td><%=rs1.getInt("fcount")%></td>
								  	 		<td><%=rs1.getInt("customercount")%></td>
								  	 		<td><%=rs1.getDouble("ncquantity")%></td>
								  	 		<td><%=rs1.getDouble("camount")%></td>
								  	 		<td class="target"><%=rs1.getDouble("target_quantity") %></td>
								  	 		<td class="actual"><%=rs1.getDouble("iquantity")%></td>
								  	 		<td><%= ((rs1.getDouble("iquantity")-rs1.getDouble("target_quantity"))/rs1.getDouble("target_quantity"))*100 %>%</td>
								  	 	</tr>
								  	<%} %>
								 <%} %>
								  </tbody>
								</table>
							</div>
						</div>
								<%-- <fmt:formatNumber type="number" maxFractionDigits="2" value="<%= ((rs1.getDouble("iquantity")-rs1.getDouble("target_quantity"))/rs1.getDouble("target_quantity"))*100 %>" /> --%>	
						<div class="row">
							<div class="col-xs-2"></div>
							<div class="col-xs-8 text-center">
								<a href="consumption_sheet.jsp" type="button" class="btn  btn-default">CLEAR</a>
								<button type="button" onclick="javascript:xport.toCSV('score_card');" class="btn  btn-primary">EXCEL</button>
							</div>
						</div>
						</c:if>	
						<c:if test="${param.type=='one'}">
							<div class="row table-responsive">
							<div class="col-xs-12">
								<!-- GET ALL DIESEL CONSUMPTION DETAIL HERE -->
								<div class="col-sm-12 text-center">
               		 			 <c:set var = "now" value = "<%= new java.util.Date()%>" />
               		 			 <c:set var = "month" value = "${param.month}" />
               		  <!-- formatting selected month and year to date format -->
               		 			 <c:set var = "conver" value = "20-${param.month}-${param.year}" />
               		  <!-- Parsing the obtained string date format -->
               		 			  <fmt:parseDate value = "${conver}" var = "parsed" pattern = "dd-MM-yyyy" />
               		   <!-- value takes only parsed data -->
               		   
           <%     		
           Connection con=DBUtil.getConnection();
           String mp_name="";
           PreparedStatement ps8=con.prepareStatement("select mp_name from marketing_person where mp_id=?");
												ps8.setInt(1, Integer.parseInt(request.getParameter("e_id")));
												ResultSet rs8=ps8.executeQuery();
												while(rs8.next()){
														 mp_name=rs8.getString("mp_name");																										
												}  %>
               		   
					<h4 style="color: red;" class="text-center">Sales Person :    <%= mp_name%>   &nbsp;&nbsp;&nbsp;&nbsp; MONTH : <fmt:formatDate type = "date" dateStyle = "long"  pattern="MMMMMMMMMM"  value="${parsed}" />
					        &nbsp;&nbsp;&nbsp;&nbsp;YEAR : ${param.year}  
					        &nbsp;&nbsp;&nbsp;&nbsp;  DATE:<fmt:formatDate pattern = "dd-MM-yyyy"  value = "${now}" /></h4>
					               		</div>
								<table id="cons_table" class="table table-bordered table-stripped">
									
								   <thead>
									   		<tr style="background-color: white;">
									   			  <th>Dates</th>
										          
										          <th>No. of Visits</th>
										          <th>No. of Quotations</th>
										          <th> Quotation Quantity</th>
										          <th>Quantity Supplied</th>
										          <th>New customers</th>
										          <th>New Customer Quantity</th>
										          
										          <th>Collections</th>
									   		</tr>
								  </thead>
								  <tbody>
								  
								  	 	<%int iYear = Integer.parseInt(request.getParameter("year"));
											int iMonth = Integer.parseInt(request.getParameter("month"))-1; // 1 (months begin with 0)
											int iDay = 1;
											 int u_id=Integer.parseInt(request.getParameter("e_id")); 
											Calendar mycal = new GregorianCalendar(2000, iMonth, 1);
											int daysInMonth= mycal.getActualMaximum(Calendar.DAY_OF_MONTH);   
											pageContext.setAttribute("count", daysInMonth);
								  	 		
											
								  	 		
								  	 		
								  	 		
								  	 			int[] vcount=new int[daysInMonth+1];
								  	 			int[] qcount=new int[daysInMonth+1];
								  	 			double[] qquantity=new double[daysInMonth+1];
								  	 			double[] iquantity=new double[daysInMonth+1];
								  	 			int[] ccount=new int[daysInMonth+1];
								  	 			double[] ncquantity=new double[daysInMonth+1];
								  	 			double[] colamount=new double[daysInMonth+1];
								  	 			int[] arr=new int[daysInMonth+1];
								  	 			for(int i=1;i<daysInMonth;i++){
								  	 				arr[i]=0;
								  	 			}
								  	 			PreparedStatement ps1=con.prepareStatement("select count(follow_up_report_id) as vcount,day(date) as vdate from follow_up_report where user_id=? and month(date)=? and year(date)=? group by day(date)"); 
								  	 			ps1.setInt(1, Integer.parseInt(request.getParameter("e_id")));
								  	 			ps1.setInt(2, Integer.parseInt(request.getParameter("month")));
												ps1.setInt(3, Integer.parseInt(request.getParameter("year")));
												ResultSet rs1=ps1.executeQuery();
												while(rs1.next()){
													vcount[rs1.getInt("vdate")]=rs1.getInt("vcount");
												}
												
												PreparedStatement ps2=con.prepareStatement("select count(quotation_id) as qcount , day(quotation_date)as qdate from "+
														" customer_quotation where mp_id=? and month(quotation_date)=? and year(quotation_date)=? group by quotation_date");
												ps2.setInt(1, Integer.parseInt(request.getParameter("e_id")));
								  	 			ps2.setInt(2, Integer.parseInt(request.getParameter("month")));
												ps2.setInt(3, Integer.parseInt(request.getParameter("year")));
												ResultSet rs2=ps2.executeQuery();
												while(rs2.next()){
													qcount[rs2.getInt("qdate")]=rs2.getInt("qcount");
																										
												}
												
												PreparedStatement ps3=con.prepareStatement("select l.qcount,l.qdate,m.qquantity,m.qidate from (select count(quotation_id) as qcount , day(quotation_date)as qdate from "+
														" customer_quotation where mp_id=? and month(quotation_date)=? and year(quotation_date)=? group by quotation_date) as l, "+
														" (select sum(qi.quantity) as qquantity,day(q.quotation_date) as qidate from customer_quotation_item qi left join "+
												  	 	" customer_quotation q on q.quotation_id=qi.quotation_id where q.mp_id=? and month(q.quotation_date)=? and year(q.quotation_date)=?  group by q.quotation_date)as m");
												ps3.setInt(1, Integer.parseInt(request.getParameter("e_id")));
								  	 			ps3.setInt(2, Integer.parseInt(request.getParameter("month")));
												ps3.setInt(3, Integer.parseInt(request.getParameter("year")));
												ps3.setInt(4, Integer.parseInt(request.getParameter("e_id")));
								  	 			ps3.setInt(5, Integer.parseInt(request.getParameter("month")));
												ps3.setInt(6, Integer.parseInt(request.getParameter("year")));
												ResultSet rs3=ps3.executeQuery();
												while(rs3.next()){
													qcount[rs3.getInt("qdate")]=rs3.getInt("qcount");
													qquantity[rs3.getInt("qidate")]=rs3.getDouble("qquantity");													
												}	
												
												PreparedStatement ps4=con.prepareStatement("select sum(i.quantity)as iquantity,day(i.invoice_date)as idate from invoice i LEFT JOIN "+
										  	 	" (purchase_order_item poi,purchase_order po) ON i.poi_id=poi.poi_id and poi.order_id=po.order_id where po.marketing_person_id=? "+
												" and month(i.invoice_date)=? and year(i.invoice_date)=? group by i.invoice_date");
												ps4.setInt(1, Integer.parseInt(request.getParameter("e_id")));
								  	 			ps4.setInt(2, Integer.parseInt(request.getParameter("month")));
												ps4.setInt(3, Integer.parseInt(request.getParameter("year")));
												ResultSet rs4=ps4.executeQuery();
												while(rs4.next()){
													iquantity[rs4.getInt("idate")]=rs4.getDouble("iquantity");
																										
												}
												
												PreparedStatement ps5=con.prepareStatement("select count(customer_id)as ccount,day(timestamp) as cdate from customer "+
												" where mp_id=? and month(timestamp)=? and year(timestamp)=? group by day(timestamp)");
														ps5.setInt(1, Integer.parseInt(request.getParameter("e_id")));
										  	 			ps5.setInt(2, Integer.parseInt(request.getParameter("month")));
														ps5.setInt(3, Integer.parseInt(request.getParameter("year")));
														ResultSet rs5=ps5.executeQuery();
														while(rs5.next()){
															ccount[rs5.getInt("cdate")]=rs5.getInt("ccount");
														}
														
												PreparedStatement ps6=con.prepareStatement("select sum(i.quantity) as ncquantity ,day(i.invoice_date)as ncdate from invoice i LEFT JOIN (purchase_order_item poi,purchase_order po,customer c) "+
											  	 	    " ON i.poi_id=poi.poi_id and poi.order_id=po.order_id AND po.marketing_person_id=c.mp_id and c.customer_id=po.customer_id "+
											  	 		" where po.marketing_person_id=? and month(i.invoice_date)=? and year(i.invoice_date)=? and DATEDIFF(c.timestamp,i.invoice_date)<30  group by day(i.invoice_date)");
																ps6.setInt(1, Integer.parseInt(request.getParameter("e_id")));
												  	 			ps6.setInt(2, Integer.parseInt(request.getParameter("month")));
																ps6.setInt(3, Integer.parseInt(request.getParameter("year")));
																ResultSet rs6=ps6.executeQuery();
																while(rs6.next()){
																	ncquantity[rs6.getInt("ncdate")]=rs6.getDouble("ncquantity");
																}
												
												PreparedStatement ps7=con.prepareStatement("select sum(amount) as colamount,day(date) as coldate from follow_up_report where  type='collection' and user_id=? and month(date)=? and year(date)=? group by day(date)");
											  	 			ps7.setInt(1, Integer.parseInt(request.getParameter("e_id")));
											  	 			ps7.setInt(2, Integer.parseInt(request.getParameter("month")));
															ps7.setInt(3, Integer.parseInt(request.getParameter("year")));
															ResultSet rs7=ps7.executeQuery();
															while(rs7.next()){
																colamount[rs7.getInt("coldate")]=rs7.getDouble("colamount");
															}				
												
												%>
												
											<%	for(int i=1;i<arr.length;i++){
											%>
										  	 	<tr>
										  	 		<td style="background-color: white;"> <b> <%=i %> </b> </td>
										  	 		<td><a class="btn btn-custom waves-effect waves-light hide" id="linkto"  href="#view_modal" data-animation="blur" data-plugin="custommodal" data-overlaySpeed="100"  onclick="getInfo(<%=u_id%>,<%=i%>,${param.month}, ${param.year});"  data-overlayColor="#36404a"><%=vcount[i] %></a></td>
										  	 		<td><a class="btn btn-custom waves-effect waves-light hide" id="linkto"  href="#view_modal1" data-animation="blur" data-plugin="custommodal" data-overlaySpeed="100"  onclick="getQuotationInfo(<%=u_id%>,<%=i%>,${param.month}, ${param.year});"  data-overlayColor="#36404a"><%=qcount[i] %></a></td>
										  	 		<td><a class="btn btn-custom waves-effect waves-light hide" id="linkto"  href="#view_modal1" data-animation="blur" data-plugin="custommodal" data-overlaySpeed="100"  onclick="getQuotationInfo(<%=u_id%>,<%=i%>,${param.month}, ${param.year});"  data-overlayColor="#36404a"><%=qquantity[i] %></a></td>
										  	 		<td><a class="btn btn-custom waves-effect waves-light hide" id="linkto"  href="#view_modal2" data-animation="blur" data-plugin="custommodal" data-overlaySpeed="100"  onclick="getInvoiceInfo(<%=u_id%>,<%=i%>,${param.month}, ${param.year});"  data-overlayColor="#36404a"><%=iquantity[i] %></a></td>
										  	 		<td><a class="btn btn-custom waves-effect waves-light hide" id="linkto"  href="#view_modal3" data-animation="blur" data-plugin="custommodal" data-overlaySpeed="100"  onclick="getnewcustomerInfo(<%=u_id%>,<%=i%>,${param.month}, ${param.year});"  data-overlayColor="#36404a"><%=ccount[i] %></a></td>
										  	 		<td><%=ncquantity[i] %></td>
										  	 		<td><a class="btn btn-custom waves-effect waves-light hide" id="linkto"  href="#view_modal4" data-animation="blur" data-plugin="custommodal" data-overlaySpeed="100"  onclick="getPaymentInfo(<%=u_id%>,<%=i%>,${param.month}, ${param.year});"  data-overlayColor="#36404a"><%=colamount[i] %></a></td>
								  	 			</tr>
								  	 	<%} %>
								  	 	
								  <%-- 	<%} %> --%>
								  </tbody>
								</table>
							</div>
						</div>
									
						<div class="row">
							<div class="col-xs-2"></div>
							<div class="col-xs-8 text-center">
								<a href="consumption_sheet.jsp" type="button" class="btn  btn-default">CLEAR</a>
								<button type="button" onclick="javascript:xport.toCSV('cons_table');" class="btn  btn-primary">EXCEL</button>
							</div>
						</div>
						</c:if>
						
						<c:if test="${param.type=='customdate'}">
							<div class="row" id="print_me">
								<button type="button" class="btn btn-info no-print" onclick="printDiv('print_me')">PRINT</button>&nbsp;&nbsp;&nbsp;
								<button type="button" onclick="fnExcelReport();" class="btn  btn-primary">EXCEL</button>
								<div class="col-sm-12 text-center">
               		  <c:set var = "now" value = "<%= new java.util.Date()%>" />
				<h4 style="color: red;" class="text-center">From Date :   ${param.from_date} 
        &nbsp;&nbsp;&nbsp;&nbsp;To Date : ${param.to_date}  
        &nbsp;&nbsp;&nbsp;&nbsp;  DATE:<fmt:formatDate pattern = "dd-MM-yyyy"  value = "${now}" /></h4>
               		</div>
									<table class="table table-bordered" id="example-2">
										<thead>
											<tr>
												<td colspan="9" class="text-center">Sales Report</td>
											</tr>
												<tr>
												<th>Sales Person</th>
												<th>Date</th>
												<th>Time</th>
												<th>Client Name</th>
												<th>Description</th>
												<th>Comment</th>
												<th>Amount</th>
											</tr>
										</thead>
										<c:set value="${param.e_id=='all'?'':param.e_id}" var="mp_id"/>
										<sql:query var="cons" dataSource="jdbc/rmc">
											select f.*,m.mp_name from follow_up_report f left join (marketing_person m) on f.user_id=m.mp_id 
											where f.date between ? and ?
											and f.user_id like if(''=?,'%%',?)
											<sql:param value="${param.from_date}"/>
											<sql:param value="${param.to_date}"/>
											<sql:param value="${mp_id}"/>
											<sql:param value="${mp_id}"/>
										</sql:query>
										<tbody>
											<c:set value="0" var="tquantity"/>
											<c:set value="0" var="count"/>
											<c:set value="0" var="tavg"/>
											<c:forEach items="${cons.rows}" var="cons">
											<c:set value="${tquantity+cons.issued_quantity}" var="tquantity"/>
											<c:set value="${count+1}" var="count"/>
											<c:set value="${tavg+cons.mileage}" var="tavg"/>
											<tr>
												<td>${cons.mp_name}</td>
												<td>${cons.date}</td>
												<td>${cons.time}</td>
												<td>${cons.client}</td>
												<td>${cons.description}</td>
												<td>${cons.comment}</td> 
												<td>${cons.amount}</td> 
											</tr>
											</c:forEach>
										</tbody>
										<tfoot>
											<%-- <tr>
												<th class="text-right">Total :</th>
												<th></th>
												<th>${tquantity}</th>
												<th colspan="2" class="text-right"><!-- Average :  --></th>
												<th><fmt:formatNumber value="${tavg/count}" groupingUsed="false" maxFractionDigits="2"/></th>
												<th colspan="2"></th>
											</tr> --%>
										</tfoot>
									</table>
									
							</div>
						</c:if>
						<c:if test="${param.type=='few'}">
							<div class="row" id="print_me">
								<div class="col-sm-12">
								<h3 class="text-center">CONSOLIDATE DIESEL CONSUMPTION DETAIL</h3>
								<div class="col-sm-12 text-center">
               		  <c:set var = "now" value = "<%= new java.util.Date()%>" />
               		   <c:set var = "month" value = "${param.month}" />
               		   <c:set var = "conver" value = "20-${param.month}-${param.year}" />
               		   <fmt:parseDate value = "${conver}" var = "parsed" pattern = "dd-MM-yyyy" />
				<h4 style="color: red;" class="text-center">MONTH : <fmt:formatDate type = "date" dateStyle = "long"  pattern="MMMMMMMMMM"  value="${parsed}" />
        &nbsp;&nbsp;&nbsp;&nbsp;YEAR : ${param.year}  
        &nbsp;&nbsp;&nbsp;&nbsp;  DATE:<fmt:formatDate pattern = "dd-MM-yyyy"  value = "${now}" /></h4>
               		</div>
									<table class="table table-bordered">
										<thead>
											<tr>
												<th>VEHICLE NO</th>
												<th>OPENING KM</th>
												<th>CLOSING KM</th>
												<th>TOTAL KM</th>
												<th>TOTAL CONSUMPTION</th>
												<th>RETURNED QUANTITY</th>
												<th>MILAGE</th>
											</tr>
										</thead>
										<sql:query var="cons" dataSource="jdbc/rmc">
											select p.*, (p.closing_km-p.opening_km) as total_km,ROUND((p.closing_km-p.opening_km)/totalqunaity,2) as mileage,
											0 as return_quantity from  (select month(issued_date),year(issued_date),min(opening_km) as opening_km,
											max(closing_km) as closing_km,sum(issued_quantity) as totalqunaity,vehicle_no from diesel_consumption
											where month(issued_date)=? and year(issued_date)=?
											group by vehicle_no) as p
											<sql:param value="${param.month}"/>
											<sql:param value="${param.year}"/>
										</sql:query>
										<tbody>
											<c:set value="0" var="total_cons"/>
											<c:forEach items="${cons.rows}" var="cons">
											<c:set value="${cons.totalqunaity+total_cons}" var="total_cons"/>
											<tr>
												<td>${cons.vehicle_no}</td>
												<td>${cons.opening_km}</td>
												<td>${cons.closing_km}</td>
												<td>${cons.closing_km-cons.opening_km}</td>
												<td>${cons.totalqunaity}</td>
												<td>${cons.return_quantity}</td>
												<td>${cons.mileage}</td>
											</tr>
											</c:forEach>
										</tbody>
										<tfoot>
												<tr>
													<th colspan="3" class="text-right">TOTAL:</th>
													<th></th>
													<th class="text-left">${total_cons}</th>
												</tr>
										</tfoot>
									</table>
									<div class="no-print">
										<button type="button" class="btn btn-info no-print" onclick="printDiv('print_me')">PRINT</button>
										<button type="button" onclick="javascript:xport.toCSV('cons_table');" class="btn  btn-primary">EXCEL</button>
									</div>
								</div>
							</div>
						</c:if>	








		</div>
		
		<a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse">
				<i class="ace-icon fa fa-angle-double-up icon-only bigger-110"></i>
			</a>
		
		
	</div>
<!-- modal modal-dialog modal-body -->
		        <div id="view_modal" class="modal-demo col-xs-2" style="height: 100%; overflow-y: scroll; ">
		            <button type="button" class="close" onclick="Custombox.close();">
		                <span>&times;</span><span class="sr-only">Close</span>
		            </button>
		            <h4 class="custom-modal-title" style="color: white;background-color: #23aa08;">Visit List</h4>
		            <div class="custom-modal-text">
		               <table class="table table-bordered" id="table1">
		               		<thead>
		               			<tr style="background-color: #00bab3;color: white;">
		               				<th>Date</th>
									<th>Time</th>
									<th>Client Name</th>
									<th>Description</th>
									<th>Comment</th>
									<th>Amount</th>
		               			</tr>
		               		</thead>
		               		<tbody>
		               			
		               		</tbody>
		               </table>
		             
		               
		            </div>
		        </div>
		         <div id="view_modal4" class="modal-demo col-xs-2" style="height: 100%; overflow-y: scroll; ">
		            <button type="button" class="close" onclick="Custombox.close();">
		                <span>&times;</span><span class="sr-only">Close</span>
		            </button>
		            <h4 class="custom-modal-title" style="color: white;background-color: #23aa08;">Visit List</h4>
		            <div class="custom-modal-text">
		               <table class="table table-bordered" id="table5">
		               		<thead>
		               			<tr style="background-color: #00bab3;color: white;">
		               				<th>Date</th>
									<th>Time</th>
									<th>Client Name</th>
									<th>Description</th>
									<th>Comment</th>
									<th>Amount</th>
		               			</tr>
		               		</thead>
		               		<tbody>
		               			
		               		</tbody>
		               </table>
		             
		               
		            </div>
		        </div>
		        
		        
		           <div id="view_modal1" class="modal-demo col-xs-2" style="height: 100%; overflow-y: scroll; ">
		            <button type="button" class="close" onclick="Custombox.close();">
		                <span>&times;</span><span class="sr-only">Close</span>
		            </button>
		            <h4 class="custom-modal-title" style="color: white;background-color: #23aa08;">Visit List</h4>
		            <div class="custom-modal-text">
		               <table class="table table-bordered" id="table11">
		               		<thead>
		               			<tr style="background-color: #00bab3;color: white;">
		               				<th>Date</th>
									<th>Customer Name</th>
									<th>Customer Address</th>
									<th>Grade</th>
									<th>Quotation Quantity</th>
									<th>Rate</th>
		               			</tr>
		               		</thead>
		               		<tbody>
		               			
		               		</tbody>
		               </table>
		             
		               
		            </div>
		        </div>
		        
		        
		        
		         <div id="view_modal2" class="modal-demo col-xs-2" style="height: 100%; overflow-y: scroll; ">
		            <button type="button" class="close" onclick="Custombox.close();">
		                <span>&times;</span><span class="sr-only">Close</span>
		            </button>
		            <h4 class="custom-modal-title" style="color: white;background-color: #23aa08;">Quotation List</h4>
		            <div class="custom-modal-text">
		               <table class="table table-bordered" id="table12">
		               		<thead>
		               			<tr style="background-color: #00bab3;color: white;">
		               				<th>Invoice No</th>
		               				<th>Date</th>
									<th>Customer Name</th>
									<th>Customer Address</th>
									<th>Grade</th>
									<th>Quantity</th>
									<th>Net Amount</th>
		               			</tr>
		               		</thead>
		               		<tbody>
		               			
		               		</tbody>
		               </table>
		             
		               
		            </div>
		        </div>
		           <div id="view_modal3" class="modal-demo col-xs-2" style="height: 100%; overflow-y: scroll; ">
		            <button type="button" class="close" onclick="Custombox.close();">
		                <span>&times;</span><span class="sr-only">Close</span>
		            </button>
		            <h4 class="custom-modal-title" style="color: white;background-color: #23aa08;">Visit List</h4>
		            <div class="custom-modal-text">
		               <table class="table table-bordered" id="table13">
		               		<thead>
		               			<tr style="background-color: #00bab3;color: white;">
									<th>Customer Name</th>
									<th>Customer Address</th>
									<th>Customer Phone</th>
		               			</tr>
		               		</thead>
		               		<tbody>
		               			
		               		</tbody>
		               </table>
		             
		               
		            </div>
		        </div>
		        
		        
		        	<div id="view-model5" class="modal-demo col-xs-2">
		            <button type="button" class="close" onclick="Custombox.close();">
		                <span>&times;</span><span class="sr-only">Close</span>
		            </button>
		            <h4 class="custom-modal-title" style="color: white;background-color: #88c615;">Set Target for Sales Person</h4>
		            <div class="col-sm-12 text-center">
		            <br>
                  		<div class="pull-right"> <a class="btn btn-custom waves-effect waves-light" href="#view-model6"   data-animation="blur" data-plugin="custommodal"  data-overlaySpeed="100" data-overlayColor="#36404a">Target List</a></div>
                  	</div>
		            <div class="custom-modal-text">
		                 <form class="form-horizontal" action="ForecastController?action=InsertSalesTarget" method="post">
		                 	
		                	<div class="form-group col-sm-12">
                                      <label> Date<span class="text-danger">*</span> </label>
                                      <div>
                                          <div class="input-group">
                                              <input type="text" name="date"  value="" class="form-control date-picker"  placeholder="yyyy-mm-dd" id="id-date-picker-3" data-date-format="yyyy-mm-dd">
                                              <div class="input-group-append">
                                                  <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
                                              </div>
                                          </div>
                                      </div>
                                </div>
		                	
		                		<div class="col-sm-12 form-group">
			                                <label>Marketing Person :  <span class="text-danger">*</span> </label>
			                                <sql:query var="vehicle" dataSource="jdbc/rmc">
                                             	select * from marketing_person
                                              </sql:query>
                                              <div class="input-group">
	       									<select  name="mp_id" required="required"  class="form-control"  data-placeholder="Choose Marketing Person">
	       									<option value="0"></option>
											<c:forEach items="${vehicle.rows}" var="vehicle">
												<option value="${vehicle.mp_id}">${vehicle.mp_name}</option>
											</c:forEach>
										</select>
										</div>
										</div>
		                	
		                		
		                	<div class="col-sm-12 form-group">
		                		<lable>Target Quantity</lable>
		                		<div class="input-group">
		                			 <input type="number" step="0.01" class="form-control" required name="target_quantity" />
		                		</div>
		                	</div>
		                    <div class="form-group account-btn text-center m-t-2">
		                        <div class="col-12">
		                            <button class="btn w-lg btn-rounded btn-custom waves-effect waves-light" type="submit">Submit Target</button>
		                            <button class="btn w-lg btn-rounded btn-custom btn-danger waves-effect waves-light"  onclick="Custombox.close();" type="button">Exit</button>
		                        </div>
		                    </div>
		                </form>
		            </div>
		        </div>
		        
		        
		        
		        
		        <div id="view-model6" class="modal-demo col-xs-2" style="height: 100%; overflow-y: scroll; ">
		            <button type="button" class="close" onclick="Custombox.close();">
		                <span>&times;</span><span class="sr-only">Close</span>
		            </button>
		            <h4 class="custom-modal-title" style="color: white;background-color: #88c615;">Target List</h4>
		            <div class="col-sm-12 text-center">
			        </div>
		            <div class="custom-modal-text">
		                 <div class="card-box table-responsive">
                            <table id="datatable-buttons" class="table table-striped table-bordered" cellspacing="0" width="100%">
                                <thead>
	                                <tr>
										<th class="center">
											Sl. No
										</th>
										<th class="center">Sales Person</th>
										<th class="center">Date</th>
										<th class="center">Quantity</th>
										<th class="center">Options</th>
									</tr>
                                </thead>
								<sql:query var="driver" dataSource="jdbc/rmc">
									select s.*,m.mp_name from sales_target s left join marketing_person m on m.mp_id=s.mp_id
								</sql:query>
                                <tbody>
                                <c:set value="0" var="count"/>
                                <c:forEach var="driver" items="${driver.rows}">
                                	<c:set value="${count+1}" var="count"/>
									<tr>
										<td class="center" style="width: 10%;">${count}</td>
										<td class="center" style="width: 25%;">
											${driver.mp_name}
										</td>
										<td class="center" style="width: 15%">
											${driver.date}
										</td>
										<td style="word-break:break-word;">
											${driver.target_quantity}
										</td>
										<td>
											<div class="hidden-sm hidden-xs action-buttons">
												<a class="btn btn-icon waves-effect waves-light btn-purple" href="#view-model7" data-animation="blur" data-plugin="custommodal" onclick="deleteDriver('${driver.target_id}')" data-overlaySpeed="100" data-overlayColor="#36404a"><i class="fa fa-edit"></i></a>
												&nbsp;&nbsp;
												<a class="btn btn-icon waves-effect waves-light btn-danger"  href="#delete-model" onclick="deleteDriver('${driver.target_id}','${driver.mp_name}')" data-animation="blur" data-plugin="custommodal"
                               						data-overlaySpeed="100" data-overlayColor="#36404a">
													<i class="ace-icon fa fa-trash-o bigger-130"></i>
												</a>
											</div>
										</td>
									</tr>
									</c:forEach>
                                </tbody>
                            </table>
                        </div>
		            </div>
		        </div>
		        
		        
		        	<div id="view-model7" class="modal-demo col-xs-2">
		            <button type="button" class="close" onclick="Custombox.close();">
		                <span>&times;</span><span class="sr-only">Close</span>
		            </button>
		            <h4 class="custom-modal-title" style="color: white;background-color: #88c615;">Set Target for Sales Person</h4>
		            <div class="col-sm-12 text-center">
		            <br>
                  		<div class="pull-right"> <a class="btn btn-custom waves-effect waves-light" href="#view-model6"   data-animation="blur" data-plugin="custommodal"  data-overlaySpeed="100" data-overlayColor="#36404a">Target List</a></div>
                  	</div>
		            <div class="custom-modal-text">
		                 <form class="form-horizontal" action="ForecastController?action=updateSalesTarget" method="post">
		                 	
		                	<div class="form-group col-sm-12">
                                      <label> Date<span class="text-danger">*</span> </label>
                                      <div>
                                          <div class="input-group">
                                              <input type="text" name="date"  value="" class="form-control date-picker"  placeholder="yyyy-mm-dd" id="id-date-picker-3" data-date-format="yyyy-mm-dd">
                                              <div class="input-group-append">
                                                  <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
                                              </div>
                                          </div>
                                      </div>
                                </div>
		                	
		                		<div class="col-sm-12 form-group">
			                                <label>Marketing Person :  <span class="text-danger">*</span> </label>
			                                <sql:query var="vehicle" dataSource="jdbc/rmc">
                                             	select * from marketing_person
                                              </sql:query>
                                              <div class="input-group">
	       									<select  name="mp_id" required="required"  class="form-control"  data-placeholder="Choose Marketing Person">
	       									<option value="0"></option>
											<c:forEach items="${vehicle.rows}" var="vehicle">
												<option value="${vehicle.mp_id}">${vehicle.mp_name}</option>
											</c:forEach>
										</select>
										</div>
										</div>
		                	
		                		
		                	<div class="col-sm-12 form-group">
		                		<lable>Target Quantity</lable>
		                		<div class="input-group">
		                			 <input type="number" step="0.01" class="form-control" required name="target_quantity" />
		                		</div>
		                	</div>
		                    <div class="form-group account-btn text-center m-t-2">
		                        <div class="col-12">
		                            <button class="btn w-lg btn-rounded btn-custom waves-effect waves-light" type="submit">Submit Forecast</button>
		                            <button class="btn w-lg btn-rounded btn-custom btn-danger waves-effect waves-light"  onclick="Custombox.close();" type="button">Exit</button>
		                        </div>
		                    </div>
		                </form>
		            </div>
		        </div>
		        
		        <div id="delete-model" class="modal-demo col-xs-2">
		            <button type="button" class="close" onclick="Custombox.close();">
		                <span>&times;</span><span class="sr-only">Close</span>
		            </button>
		            <h4 class="custom-modal-title" style="color: white;background-color: #491136;">Delete Target for: <span class="mp_name"></span> </h4>
		            <div class="custom-modal-text">
		                <form class="form-horizontal" method="post" action="ForecastController?action=deleteTarget">
		                	<input type="hidden" name="target_id" id="target_id"/>
		                    <div class="form-group account-btn text-center m-t-2">
		                        <div class="col-12">
		                            <button class="btn w-lg btn-rounded btn-custom waves-effect waves-light" type="submit">DELETE</button>
		                            <button class="btn w-lg btn-rounded btn-custom btn-danger waves-effect waves-light"  onclick="Custombox.close();" type="button">CANCEL</button>
		                        </div>
		                    </div>
		                </form>
		            </div>
		        </div>


<!-- Footer -->
       <%@ include file="footer.jsp" %>
        <!-- End Footer -->


<script type="text/javascript">
			if('ontouchstart' in document.documentElement) document.write("<script src='assets/js/jquery.mobile.custom.min.js'>"+"<"+"/script>");
		</script>
<script src="assets/js/bootstrap.min.js"></script>
        <!-- jQuery  -->
        <script src="assets/js/jquery.min.js"></script>
        <script src="assets/js/popper.min.js"></script>
        <script src="assets/js/bootstrap.min.js"></script>
        <script src="assets/js/waves.js"></script>
        <script src="assets/js/jquery.slimscroll.js"></script>

        <!-- Parsley js -->
        <script type="text/javascript" src="plugins/parsleyjs/parsley.min.js"></script>

        <!-- App js -->
        <script src="assets/js/jquery.core.js"></script>
        <script src="assets/js/jquery.app.js"></script>
        <script src="assets/js/select2.min.js"></script>
		<script src="picker/js/bootstrap-datepicker.min.js"></script>
		<script src="picker/js/moment.min.js"></script>
		<script src="assets/js/bootstrap-timepicker.min.js"></script>
		<script src="picker/js/bootstrap-datetimepicker.min.js"></script>
		<script type="text/javascript" src="js/AddPurchaseOrder.js"></script>
		<script src="assets/js/ace.min.js"></script>
		<script>
		function printDiv(divName) {
		     var printContents = document.getElementById(divName).innerHTML;
		     var originalContents = document.body.innerHTML;
		     document.body.innerHTML = printContents;
		     window.print();
		     document.body.innerHTML = originalContents;
		}
		
		</script>
		
		
			
		<!-- inline scripts related to this page -->
		<script type="text/javascript">
			jQuery(function($) {
			
				$('[data-rel=tooltip]').tooltip();
			
				$('.select2').css('width','66%').select2({allowClear:true})
				.on('change', function(){
				});
				
				$('.select1').css('width','100%').select2({
					allowClear:true,
					dropdownParent:$('#view-model5')
					
				})
				.on('change', function(){
				});
			
			
				var $validation = true;

				$('#validate_me').click(

					function(){
						if(!$('#validation-form').valid()) e.preventDefault();
					}
				); 

				
				//jump to a step
				/**
				var wizard = $('#fuelux-wizard-container').data('fu.wizard')
				wizard.currentStep = 3;
				wizard.setState();
				*/
			
				//determine selected step
				//wizard.selectedItem().step
			})
		</script>
		
		     <script src="plugins/custombox/js/custombox.min.js"></script>
        <script src="plugins/custombox/js/legacy.min.js"></script>
		
		<script type="text/javascript">
			$(document).ready(function(){
				/*TIME PICKER START'S HERE*/
				$('#timepicker1').timepicker({
					minuteStep: 1,
					showSeconds: true,
					showMeridian: false,
					disableFocus: true,
					icons: {
						up: 'fa fa-chevron-up',
						down: 'fa fa-chevron-down'
					}
				}).on('focus', function() {
					$('#timepicker1').timepicker('showWidget');
				}).next().on(ace.click_event, function(){
					$(this).prev().focus();
				});
			});
		</script>
		<script type="text/javascript">
		  var xport = {
		  _fallbacktoCSV: true,  
		  toXLS: function(tableId, filename) {   
		    this._filename = (typeof filename == 'undefined') ? tableId : filename;
		    
		    //var ieVersion = this._getMsieVersion();
		    //Fallback to CSV for IE & Edge
		    if ((this._getMsieVersion() || this._isFirefox()) && this._fallbacktoCSV) {
		      return this.toCSV(tableId);
		    } else if (this._getMsieVersion() || this._isFirefox()) {
		      alert("Not supported browser");
		    }

		    //Other Browser can download xls
		    var htmltable = document.getElementById(tableId);
		    var html = htmltable.outerHTML;

		    this._downloadAnchor("data:application/vnd.ms-excel" + encodeURIComponent(html), 'xls'); 
		  },
		  toCSV: function(tableId, filename) {
		    this._filename = (typeof filename === 'undefined') ? tableId : filename;
		    // Generate our CSV string from out HTML Table
		    var csv = this._tableToCSV(document.getElementById(tableId));
		    // Create a CSV Blob
		    var blob = new Blob([csv], { type: "text/csv" });

		    // Determine which approach to take for the download
		    if (navigator.msSaveOrOpenBlob) {
		      // Works for Internet Explorer and Microsoft Edge
		      navigator.msSaveOrOpenBlob(blob, this._filename + ".csv");
		    } else {      
		      this._downloadAnchor(URL.createObjectURL(blob), 'csv');      
		    }
		  },
		  _getMsieVersion: function() {
		    var ua = window.navigator.userAgent;

		    var msie = ua.indexOf("MSIE ");
		    if (msie > 0) {
		      // IE 10 or older => return version number
		      return parseInt(ua.substring(msie + 5, ua.indexOf(".", msie)), 10);
		    }

		    var trident = ua.indexOf("Trident/");
		    if (trident > 0) {
		      // IE 11 => return version number
		      var rv = ua.indexOf("rv:");
		      return parseInt(ua.substring(rv + 3, ua.indexOf(".", rv)), 10);
		    }

		    var edge = ua.indexOf("Edge/");
		    if (edge > 0) {
		      // Edge (IE 12+) => return version number
		      return parseInt(ua.substring(edge + 5, ua.indexOf(".", edge)), 10);
		    }

		    // other browser
		    return false;
		  },
		  _isFirefox: function(){
		    if (navigator.userAgent.indexOf("Firefox") > 0) {
		      return 1;
		    }
		    
		    return 0;
		  },
		  _downloadAnchor: function(content, ext) {
		      var anchor = document.createElement("a");
		      anchor.style = "display:none !important";
		      anchor.id = "downloadanchor";
		      document.body.appendChild(anchor);

		      // If the [download] attribute is supported, try to use it
		      
		      if ("download" in anchor) {
		        anchor.download = this._filename + "." + ext;
		      }
		      anchor.href = content;
		      anchor.click();
		      anchor.remove();
		  },
		  _tableToCSV: function(table) {
		    // We'll be co-opting `slice` to create arrays
		    var slice = Array.prototype.slice;

		    return slice
		      .call(table.rows)
		      .map(function(row) {
		        return slice
		          .call(row.cells)
		          .map(function(cell) {
		            return '"t"'.replace("t", cell.textContent);
		          })
		          .join(",");
		      })
		      .join("\r\n");
		  }
		};
		</script>
		
		
		
		
		
		
			<script type="text/javascript">
			$(document).ready(function(){
				$('.not').hide();
				$('.not').prop("disabled",true);
			});
			
			$(document).ready(function(){
				$('#type').on('change',function(){
					var type=$('#type').val();
					if(type=='all'){
						$('.not').hide();
						$('.not').prop("disabled",true);
					}
					else if(type=='few'){
						$('.not').hide();
						$('.not').prop("disabled",true);
					}else{
						$('.not').show();
						$('.not').prop("disabled",false);
					}
				});
			});
			
		</script>
		
		<script type="text/javascript">
		/*   $.removeCookie("vehicle_no");
		  $.removeCookie("month");
		  $.removeCookie("year"); */
		</script>
		<script type="text/javascript">
			$(document).ready(function(){
				$('#type').on('change',function(){
					var type=$('#type').val();
					console.log(type);
					if(type=='customdate'){
						$('.custom').show();
						$('.custom').prop('disabled',false);
						$('.no-custom').hide();
						$('.no-custom').prop('disabled',true);
						$('.no-custom').prop('required',false);
					}else{
						$('.custom').hide();
						$('.custom').prop('disabled',true);
						$('.no-custom').show();
						$('.no-custom').prop('disabled',false);
						$('.no-custom').prop('required',true);
					}
				});
				
				$('.custom').hide();
				$('.custom').prop('disabled',true);
				$('.no-custom').show();
				$('.no-custom').prop('disabled',false);
			});
		</script>
		
		<script type="text/javascript">
    function fnExcelReport()
    {
        var tab_text="<table border='2px'><tr style='color:white;background-color:#4abc3e;'>";
        var textRange; var j=1;
        tab = document.getElementById('example-2'); // id of table

        for(j = 1 ; j < tab.rows.length ; j++) 
        {     
            tab_text=tab_text+tab.rows[j].innerHTML+"</tr>";
            //tab_text=tab_text+"</tr>";
        }

        tab_text=tab_text+"</table>";
        tab_text= tab_text.replace(/<A[^>]*>|<\/A>/g, "");//remove if u want links in your table
        tab_text= tab_text.replace(/<img[^>]*>/gi,""); // remove if u want images in your table
        tab_text= tab_text.replace(/<input[^>]*>|<\/input>/gi, ""); // reomves input params

        var ua = window.navigator.userAgent;
        var msie = ua.indexOf("MSIE "); 

        if (msie > 0 || !!navigator.userAgent.match(/Trident.*rv\:11\./))      // If Internet Explorer
        {
            txtArea1.document.open("txt/html","replace");
            txtArea1.document.write(tab_text);
            txtArea1.document.close();
            txtArea1.focus(); 
            sa=txtArea1.document.execCommand("SaveAs",true,"Say Thanks to Sumit.xls");
        }  
        else                 //other browser not tested on IE 11
            sa = window.open('data:application/vnd.ms-excel,' + encodeURIComponent(tab_text));  

        return (sa);
    }
    
    </script>
    
  
	  <script type="text/javascript">
    function getPaymentInfo(u_id,date,month,year){
    	var u_id=u_id;
    	if(month<10){
    		month='0'+month;
    	}
    	if(date<10){
    		date='0'+date;
    	}
    var ddate=year+"-"+month+"-"+date;
	$.ajax({
		type:'POST',
		url:'SchedulingController?action=getFollowUpAmount&user_id='+u_id+'&date='+ddate,
		headers:{
			Accept:"application/json;charset=utf-8",
			"Content-Type":"application/json;charset=utf-8"
		},
		success:function(res){
			$('#table5 tbody').html('');
			$.each(res, function(index, value) {
    		 	$('#table5').append('<tr>'+
    		  '<td>'+value.date+'</td>'+
    		  '<td>'+value.time+'</td>'+
        	 '<td>'+value.client_name+'</td>'+
        	 '<td>'+value.description+'</td>'+
        	 '<td>'+value.comment+'</td>'+
        	 '<td>'+value.amount+'</td>'+
        	 '</tr>');
		});
			if(res==''){
				$('#table5 tbody').html('');
				$('#table5').append('<tr>'+
			    		  '<td colspan="6" style="background-color: #FEB8B8;">No Collections were made this Day</td>'+
			    		  'td');
				
			}
	}
		});
    
    }
    
	</script> 
	<script type="text/javascript">
    function getQuotationInfo(u_id,date,month,year){
    	var u_id=u_id;
    	if(month<10){
    		month='0'+month;
    	}
    	if(date<10){
    		date='0'+date;
    	}
    var ddate=year+"-"+month+"-"+date;
	$.ajax({
		type:'POST',
		url:'CustomerQuotationController?action=getQuotationDetails&user_id='+u_id+'&date='+ddate,
		headers:{
			Accept:"application/json;charset=utf-8",
			"Content-Type":"application/json;charset=utf-8"
		},
		success:function(res){
			$('#table11 tbody').html('');
			$.each(res, function(index, value) {
    		 	$('#table11').append('<tr>'+
    		  '<td>'+value.date+'</td>'+
    		  '<td>'+value.customer_name+'</td>'+
        	 '<td>'+value.site_address+'</td>'+
        	 '<td>'+value.grade+'</td>'+
        	 '<td>'+value.quantity+'</td>'+
        	 '<td>'+value.price+'</td>'+
        	 '</tr>');
		});
			if(res==''){
				$('#table11 tbody').html('');
				$('#table11').append('<tr>'+
			    		  '<td colspan="6" style="background-color: #FEB8B8;">No Quotation was raised this Day</td>'+
			    		  'td');
				
			}
	}
		});
    
    }
    
	</script>
	
	
		<script type="text/javascript">
    function getInvoiceInfo(u_id,date,month,year){
    	var u_id=u_id;
    	if(month<10){
    		month='0'+month;
    	}
    	if(date<10){
    		date='0'+date;
    	}
    var ddate=year+"-"+month+"-"+date;
	$.ajax({
		type:'POST',
		url:'InvoiceController?action=getInvoiceeeDetails&user_id='+u_id+'&date='+ddate,
		headers:{
			Accept:"application/json;charset=utf-8",
			"Content-Type":"application/json;charset=utf-8"
		},
		success:function(res){
			$('#table12 tbody').html('');
			$.each(res, function(index, value) {
    		 	$('#table12').append('<tr>'+
    		 '<td>'+value.invoice_id+'</td>'+
    		 '<td>'+value.date+'</td>'+
    		  '<td>'+value.customer_name+'</td>'+
        	 '<td>'+value.site_address+'</td>'+
        	 '<td>'+value.grade+'</td>'+
        	 '<td>'+value.quantity+'</td>'+
        	 '<td>'+value.price+'</td>'+
        	 '</tr>');
		});
			if(res==''){
				$('#table12 tbody').html('');
				$('#table12').append('<tr>'+
			    		  '<td colspan="7" style="background-color: #FEB8B8;">No Grade was supplied this Day</td>'+
			    		  'td');
				
			}
	}
		});
    
    }
    
	</script>
	   <script type="text/javascript">
    function getnewcustomerInfo(u_id,date,month,year){
    	var u_id=u_id;
    	if(month<10){
    		month='0'+month;
    	}
    	if(date<10){
    		date='0'+date;
    	}
    var ddate=year+"-"+month+"-"+date;
	$.ajax({
		type:'POST',
		url:'CustomerController?action=getNewCustomer&user_id='+u_id+'&date='+ddate,
		headers:{
			Accept:"application/json;charset=utf-8",
			"Content-Type":"application/json;charset=utf-8"
		},
		success:function(res){
			$('#table13 tbody').html('');
			$.each(res, function(index, value) {
    		 	$('#table13').append('<tr>'+
        	 '<td>'+value.customer_name+'</td>'+
        	 '<td>'+value.site_address+'</td>'+
        	 '<td>'+value.phone+'</td>'+
        	 '</tr>');
		});
			if(res==''){
				$('#table13 tbody').html('');
				$('#table13').append('<tr>'+
			    		  '<td colspan="3" style="background-color: #FEB8B8;">No new customer was added this Day</td>'+
			    		  'td');
				
			}
	}
		});
    
    }
    
	</script> 
	
	
	  <script type="text/javascript">
    function getInfo(u_id,date,month,year){
    	var u_id=u_id;
    	if(month<10){
    		month='0'+month;
    	}
    	if(date<10){
    		date='0'+date;
    	}
    var ddate=year+"-"+month+"-"+date;
	$.ajax({
		type:'POST',
		url:'SchedulingController?action=getFollowUp&user_id='+u_id+'&date='+ddate,
		headers:{
			Accept:"application/json;charset=utf-8",
			"Content-Type":"application/json;charset=utf-8"
		},
		success:function(res){
			$('#table1 tbody').html('');
			$.each(res, function(index, value) {
    		 	$('#table1').append('<tr>'+
    		  '<td>'+value.date+'</td>'+
    		  '<td>'+value.time+'</td>'+
        	 '<td>'+value.client_name+'</td>'+
        	 '<td>'+value.description+'</td>'+
        	 '<td>'+value.comment+'</td>'+
        	 '<td>'+value.amount+'</td>'+
        	 '</tr>');
		});
			if(res==''){
				$('#table1 tbody').html('');
				$('#table1').append('<tr>'+
			    		  '<td colspan="6" style="background-color: #FEB8B8;">No Visits were made this Day</td>'+
			    		  'td');
				
			}
	}
		});
    
    }
    
	</script>

 <script type="text/javascript">
			function deleteDriver(target_id,mp_name){
				$('.mp_name').html(mp_name);
				$('#target_id').val(target_id);
			}
		</script>


</body>
</html>