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
        <title>Sales Visit Report - ${initParam.company_name}</title>
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
				.somecolor{
        		   background-color: #7FFFD4;
        		}
			
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
								<li class="breadcrumb-item"><a href="#">Sales Visit Report</a></li>
							</ol>
						</div>


					</div>
				</div>
			</div>


	               <div class="row">
		                    <div class="col-sm-12">
		                    	<form class="" action="SalesVisitReport.jsp?action=update" name="invoice_form"  method="post">
			                        <div class="card-box row col-sm-12">
			                        	<div class="col-sm-12 text-center">
			                        		<h2 style="color: #1f6b75;">Sales Visit Report</h2>
			                        	</div>
			                        	<div class="col-sm-3">
			                        		
			                        	</div>
			                           	<div class="col-sm-6">
			                               	<div class="form-group">
			                                     <label>REPORT TYPE :  <span class="text-danger">*</span> </label>
	       									<select id="type"  name="type" required="required"   class="select2"  data-placeholder="Choose Type">
											<option value="all">ALL </option>
											<option value="one">Marketing Person Wise </option>
											<option value="customer_wise">Customer Wise</option>
											<option value="customdate">Custom Date</option>
											</select>
										</div>
										
										<div class="form-group no-cust">
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
	       									<select id="e_id"  name="e_id" required="required"  class="select2 no-cust"  data-placeholder="Choose Marketing Person">
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
								  <div class="form-group cust">
			                                    <label>Customer <span class="text-danger">*</span></label>
			                                    <sql:query var="customer" dataSource="jdbc/rmc">
			                                    	select * from customer 
			                                    </sql:query>
			                                     <sql:query var="customer1" dataSource="jdbc/rmc">
			                                    	select * from client 
			                                    </sql:query>
												<select id="client_id"  name="client"    class="select2 cust"  data-placeholder="Choose Customer" >
													<option value="">&nbsp;</option>
													<option disabled>Customers</option>
													<c:forEach var="customer" items="${customer.rows}">
													<option value="${customer.customer_name}">${customer.customer_name}</option>
													</c:forEach>
													<option disabled>Clients</option>
													<c:forEach var="customer1" items="${customer1.rows}">
													<option value="${customer1.client_name}">${customer1.client_name}</option>
													</c:forEach>
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
                                              <input type="text" name="to_date"  value="" class="form-control date-picker custom"  placeholder="yyyy-mm-dd" id="id-date-picker-1" data-date-format="yyyy-mm-dd">
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
								<table id="cons_table" class="table table-bordered table-stripped">
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
									   			 <c:forEach var="i" begin="1" end="${count}">
										           	<th>${i}</th>
										          </c:forEach>
										          <th>Total Visits</th>
										         <!--  <th>CLOSING KM/HOUR</th>
										          <th>TOTAL KM</th>
										          <th>TOTAL CONS.</th>
										          <th>RETURNED</th>
										          <th>MILAGE</th> -->
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
								  	 	<tr>
								  	 		<td style="background-color: white;"><%=rs.getString("mp_name")%></td>
								  	 		<%
								  	 			int[] arr=new int[daysInMonth+1];
								  	 			int total_count=0;
									  	 		int u_id=rs.getInt("mp_id");
								  	 			for(int i=1;i<daysInMonth;i++){
								  	 				arr[i]=0;
								  	 			}
								  	 			PreparedStatement ps1=con.prepareStatement("select user_id,count(follow_up_report_id) as count1,day(date) as dt  from follow_up_report where month(date)=? and year(date)=? and user_id=? group by day(date),user_id ");
								  	 			ps1.setInt(1, Integer.parseInt(request.getParameter("month")));
												ps1.setInt(2, Integer.parseInt(request.getParameter("year")));
												ps1.setInt(3, rs.getInt("mp_id"));
												ResultSet rs1=ps1.executeQuery();
												while(rs1.next()){
													arr[rs1.getInt("dt")]=rs1.getInt("count1");
													total_count=total_count+arr[rs1.getInt("dt")];
												}
												
												for(int i=1;i<arr.length;i++){
													%>
									  	 			<td><a class="btn btn-custom waves-effect waves-light hide" id="linkto"  href="#view_modal" data-animation="blur" data-plugin="custommodal" data-overlaySpeed="100" onclick="getInfo(<%=u_id%>,<%=i%>,${param.month}, ${param.year});" data-overlayColor="#36404a"><%=arr[i]%></a></td>
									  	 		<%} %>
								  	 			<td><%=total_count %></td>
								  	 	</tr>
								  	<%} %>
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
							
						<c:if test="${param.type=='one'}">
							<div class="row" id="print_me">
								<div class="col-sm-12 text-center">
								
								<sql:query var="veh" dataSource="jdbc/rmc">
										select * from marketing_person where mp_id=?
										<sql:param value="${param.e_id}"/>
									</sql:query>
									
									<c:forEach var="veh" items="${veh.rows}">
										<c:set value="${veh.mp_name}" var="vehi"/>
									</c:forEach>
								
								
               		  <c:set var = "now" value = "<%= new java.util.Date()%>" />
               		   <c:set var = "month" value = "${param.month}" />
               		   <c:set var = "conver" value = "20-${param.month}-${param.year}" />
               		   <fmt:parseDate value = "${conver}" var = "parsed" pattern = "dd-MM-yyyy" />
							<h4 style="color: red;" class="text-center"><span class="pull-left">Sales Person: ${vehi}</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MONTH : <fmt:formatDate type = "date" dateStyle = "long"  pattern="MMMMMMMMMM"  value="${parsed}" />
			        &nbsp;&nbsp;&nbsp;&nbsp;YEAR : ${param.year}  
			        &nbsp;&nbsp;&nbsp;&nbsp; <span class="pull-right"> DATE:<fmt:formatDate pattern = "dd-MM-yyyy"  value = "${now}" /></span></h4>
			               		</div>								
									
									
									<table class="table table-bordered" id="sales_person_wise">
										<thead>
										<tr hidden class="somecolor">
										<th>Sales Person:${vehi}</th>
										<th> </th>
										<th>MONTH : <fmt:formatDate type = "date" dateStyle = "long"  pattern="MMMMMMMMMM"  value="${parsed}" /></th>
										<th>YEAR : ${param.year} </th>
										<th></th>
										<th> DATE:<fmt:formatDate pattern = "dd-MM-yyyy"  value = "${now}" /></th>
										
										 </tr>
											<tr>
												<th>Date</th>
												<th>Time</th>
												<th>Client Name</th>
												<th>Description</th>
												<th>Comment</th>
												<th>Amount</th>
											</tr>
										</thead>
										<sql:query var="cons" dataSource="jdbc/rmc">
											select f.*,day(f.date) as dt,DATE_FORMAT(date,'%d/%m/%Y') as issued_date from follow_up_report f  where month(f.date)=? and year(f.date)=? and f.user_id=? order by issued_date
											<sql:param value="${param.month}"/>
											<sql:param value="${param.year}"/>
											<sql:param value="${param.e_id}"/>
										</sql:query>
										<tbody>
											<c:set value="0" var="tquantity"/>
											<c:set value="0" var="count"/>
											<c:set value="0" var="tavg"/>
											<c:set value="0" var="totalkm"/>
											<c:forEach items="${cons.rows}" var="cons">
											<c:set value="${count+1}" var="count"/>
											 <c:set value="${amount+cons.amount}" var="amount"/>
											<%--<c:set value="${tavg+cons.mileage}" var="tavg"/>
											<c:set value="${totalkm+(cons.closing_km-cons.opening_km)}" var="totalkm"/> --%>
											<tr>
												<td>${cons.issued_date}</td>
												<td>${cons.time}</td>
												<td>${cons.client}</td>
												<td>${cons.description}</td>
												<td>${cons.comment}</td> 
												<td>${cons.amount}</td> 
											</tr>
											</c:forEach>
										</tbody>
										<tfoot>
											<tr>
													<th colspan="2" class="text-right">TOTAL Visits this Month:</th>
													<th colspan="1" class="text-left">${count}</th>
													<th colspan="2" class="text-right">TOTAL Payment Collected:</th>
													<th colspan="1" class="text-left">${amount}</th>
												</tr>
										</tfoot>
									</table>
									<button type="button" class="btn btn-info no-print" onclick="printDiv('print_me')">PRINT</button>
									<button type="button" onclick="javascript:xport.toCSV('sales_person_wise');" class="btn  btn-primary">EXCEL</button>
							</div>
						</c:if>
						
						<c:if test="${param.type=='customdate'}">
							<div class="row" id="print_me">
								<button type="button" class="btn btn-info no-print" onclick="printDiv('print_me')">PRINT</button>&nbsp;&nbsp;&nbsp;
								 &nbsp;&nbsp;&nbsp;&nbsp;<button type="button" onclick="fnExcelReport();" class="btn  btn-primary">EXCEL</button>
								<div class="col-sm-12 text-center">
               		  <c:set var = "now" value = "<%= new java.util.Date()%>" />
               		   
				<h4 style="color: red;" class="text-center">From Date :   ${param.from_date}
        &nbsp;&nbsp;&nbsp;&nbsp;To date : ${param.to_date}  
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
											<c:set value="${count+1}" var="count"/>
											 <c:set value="${amount+cons.amount}" var="amount"/>
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
												<tr>
													<th colspan="2" class="text-right">TOTAL Visits this Month:</th>
													<th colspan="1" class="text-left">${count}</th>
													<th colspan="2" class="text-right">TOTAL Payment Collected:</th>
													<th colspan="2" class="text-left">${amount}</th>
												</tr>
										</tfoot>
									</table>
									
							</div>
						</c:if>
						<c:if test="${param.type=='customer_wise'}">
							<div class="row" id="print_me">
								<div class="col-sm-12">
								<h3 class="text-center">CUSTOMER WISE DAILY SALES REPORT</h3>
				<%-- 	<div class="col-sm-12 text-center">
               		  <c:set var = "now" value = "<%= new java.util.Date()%>" />
               		   <c:set var = "month" value = "${param.month}" />
               		   <c:set var = "conver" value = "20-${param.month}-${param.year}" />
               		   <fmt:parseDate value = "${conver}" var = "parsed" pattern = "dd-MM-yyyy" />
				<h4 style="color: red;" class="text-center">MONTH : <fmt:formatDate type = "date" dateStyle = "long"  pattern="MMMMMMMMMM"  value="${parsed}" />
        &nbsp;&nbsp;&nbsp;&nbsp;YEAR : ${param.year}  
        &nbsp;&nbsp;&nbsp;&nbsp;  DATE:<fmt:formatDate pattern = "dd-MM-yyyy"  value = "${now}" /></h4>
               		</div> --%>
               		  <c:set var = "now" value = "<%= new java.util.Date()%>" />
               		
               						<h4 style="color: red;"><span style="color: black;">Client Name:</span>&nbsp;&nbsp;
               						 <a id="clintInfo"  href="#view_modal_clint" target="_blank" data-animation="blur" data-plugin="custommodal" data-overlaySpeed="100" onclick="getClintInfo('${param.client}')"> ${param.client}</a>   &nbsp;&nbsp;&nbsp;&nbsp;<span class="pull-right"><span style="color: black;"> DATE:</span><fmt:formatDate pattern = "dd-MM-yyyy"  value = "${now}" /></span></h4>
									<table class="table table-bordered">
										<thead>
											<tr>
												<th>Sales Person</th>
												<th>Date</th>
												<th>Time</th>
												<th>Description</th>
												<th>Comment</th>
												<th>Status</th>
											</tr>
										</thead>
										<sql:query var="cons" dataSource="jdbc/rmc">
											select f.*,m.mp_name from follow_up_report f left join (marketing_person m) on f.user_id=m.mp_id 
											where f.client=?
											<sql:param value="${param.client}"/>
										</sql:query>
										<tbody>
											<c:set value="0" var="count"/>
											<c:forEach items="${cons.rows}" var="cons">
											<c:set value="${count+1}" var="count"/>
											<tr>
												<td>${cons.mp_name}</td>
												<td>${cons.date}</td>
												<td>${cons.time}</td>
												<td>${cons.description}</td>
												<td>${cons.comment}</td> 
												<td>${cons.status}</td>
											</tr>
											</c:forEach>
										</tbody>
										<tfoot>
												<tr>
													<th colspan="3" class="text-right">TOTAL Visits:</th>
													<th colspan="2" class="text-left">${count}</th>
													<th></th>
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


			  <div id="view_modal_clint" class="modal-demo col-xs-2" style="height: 100%; overflow-y: scroll; ">
		            <button type="button" class="close" onclick="Custombox.close();">
		                <span>&times;</span><span class="sr-only">Close</span>
		            </button>
		            <h4 class="custom-modal-title" style="color: white;background-color: #055f77;">Visit List</h4>
		            <div class="custom-modal-text">
		               <table class="table table-bordered" id="table2">
		               		<tbody>
		               			
		               		</tbody>
		               </table>
		             
		               
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
					}
					else if(type=='customer_wise'){
						$('.no-cust').hide();
						$('.no-cust').prop("disabled",true);
					}
						else{
							$('.no-cust').show();
							$('.no-cust').prop("disabled",false);
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
						$('.cust').hide();
						$('.cust').prop('disabled',true);
						$('.no-custom').prop('disabled',true);
						$('.no-custom').prop('required',false);
					}else if(type=='customer_wise'){
						$('.cust').show();
						$('.cust').prop('disabled',false);
						$('.no-custom').hide();
						$('.no-custom').prop('disabled',true);
						$('.no-custom').prop('required',false);
					}else{
						$('.custom').hide();
						$('.custom').prop('disabled',true);
						$('.cust').hide();
						$('.cust').prop('disabled',true);
						$('.no-custom').show();
						$('.no-custom').prop('disabled',false);
						$('.no-custom').prop('required',true);
					}
				});
				
				$('.cust').hide();
				$('.cust').prop('disabled',true);
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
    function getClintInfo(client){	
    	var client=client;
    	console.log(client);
	$.ajax({
		type:'POST',
		url:'SchedulingController?action=ViewClintInfo&client='+client,
		headers:{
			Accept:"application/json;charset=utf-8",
			"Content-Type":"application/json;charset=utf-8"
		},		
		success:function(res){
			$('#table2 tbody').html('');
			$.each(res, function(index, value) {
    		 	$('#table2').append('<tr>'+
    		  '<td  style="background-color: #00bab3;color: black;">Client Name</td><td>'+value.client_name+'</td>'+   		 
        	 '</tr>'+
        	 '<tr>'+
   		 		 '<td  style="background-color: #00bab3;color: black;">Client Phone</td><td>'+value.client_phone+'</td>'+   		 
       	 	'</tr>'+
       	 '<tr>'+
	 		 '<td  style="background-color: #00bab3;color: black;">Customer Address</td><td>'+value.customer_address+'</td>'+   		 
	 	'</tr>'+
	 	'<tr>'+
			 '<td  style="background-color: #00bab3;color: black;">Project Quantity</td><td>'+value.project_quantity+'</td>'+   		 
		'</tr>'+
		'<tr>'+
			 '<td  style="background-color: #00bab3;color: black;">Monthly Requirnment</td><td>'+value.monthly_requirnment+'</td>'+   		 
		'</tr>'+
		'<tr>'+
		 	'<td  style="background-color: #00bab3;color: black;">Current Supplier</td><td>'+value.currnet_supplier+'</td>'+   		 
		'</tr>'+
		'<tr>'+
	 		'<td  style="background-color: #00bab3;color: black;">Stage</td><td>'+value.stage+'</td>'+   		 
		'</tr>'
        	 );
		});
			if(res==''){
				$('#table2 tbody').html('');
				$('#table2').append('<tr>'+
			    		  '<td colspan="5" style="background-color: #FEB8B8;">Existing Customer</td>'+
			    		  'td');
				
			}
	}
		});
    
    }
    
	</script> 
	 

</body>
</html>