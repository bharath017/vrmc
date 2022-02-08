<!DOCTYPE html>
<%@page import="com.willka.soft.util.DBUtil"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.GregorianCalendar"%>
<%@page import="java.util.Calendar"%>
<%@page import="com.willka.soft.dao.VehicleDAOImpl"%>
<%@ include file="Session.jsp" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"  %>  
<html>
<head>
        <meta charset="utf-8" />
        <title>CONSUMPTION SHEET - ${initParam.company_name}</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
        <meta content="A fully featured admin theme which can be used to build CRM, CMS, etc." name="description" />
        <meta content="Coderthemes" name="author" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />

        <!-- App favicon -->
        <link rel="shortcut icon" href="assets/images/favicon.ico">
		<link rel="stylesheet" href="picker/cs/bootstrap-datepicker3.min.css" />
		<link rel="stylesheet" href="picker/cs/bootstrap-timepicker.min.css" />
        <!-- App css -->
        <link href="assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/icons.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/style.css" rel="stylesheet" type="text/css" />
        <link rel="stylesheet" href="assets/css/select2.min.css" />
        <link rel="stylesheet" href="assets/css/render.css">
        <script src="assets/js/modernizr.min.js"></script>
        <style type="text/css">
        	@media print{
        		.no-print{
        			display: none !important;
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
								<li class="breadcrumb-item"><a href="#">Vehicle</a></li>
								<li class="breadcrumb-item"><a href="#">Vehicle Diesel</a></li>
								<li class="breadcrumb-item"><a href="#">Consumption Sheet</a></li>
							</ol>
						</div>

						<c:choose>
							<c:when test="${param.action=='update'}">
								<h4 class="page-title">Update Consumption</h4>
							</c:when>
							<c:otherwise>
								<h4 class="page-title">Consumption Sheet</h4>
							</c:otherwise>
						</c:choose>

					</div>
				</div>
			</div>


	               <div class="row">
		                    <div class="col-sm-12">
		                    	<form class="" action="ConsumptionSheet.jsp?action=update" name="invoice_form"  method="post">
			                        <div class="card-box row col-sm-12">
			                        	<div class="col-sm-12 text-center">
			                        		<h2 style="color: #1f6b75;">Consumption Sheet</h2>
			                        	</div>
			                        	<div class="col-sm-3">
			                        		
			                        	</div>
			                           	<div class="col-sm-6">
			                               	<div class="form-group">
			                                     <label>REPORT TYPE :  <span class="text-danger">*</span> </label>
	       									<select id="type"  name="type" required="required"   class="select2"  data-placeholder="Choose Type">
											<option value="all">ALL VEHICLE</option>
											<option value="one">SINGLE VEHICLE</option>
											<option value="few">ALL VEHICLE FEW DETAIL</option>
											<option value="customdate">Custom Date</option>
											</select>
										</div>
										
										<div class="form-group">
			                                <label>Vehicle No :  <span class="text-danger">*</span> </label>
			                                <sql:query var="vehicle" dataSource="jdbc/rmc">
                                             	select * from vehicle
                                              </sql:query>
	       									<select id="vehicle_no"  name="vehicle_no" required="required"  class="select2 no"  data-placeholder="Choose Vehicle">
	       									<option value="all">All Vehicle</option>
											<c:forEach items="${vehicle.rows}" var="vehicle">
												<option value="${vehicle.vehicle_no}">${vehicle.vehicle_no}</option>
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
                                              <input type="text" name="to_date"  value="" class="form-control date-picker custom"  placeholder="yyyy-mm-dd" id="id-date-picker-1" data-date-format="yyyy-mm-dd">
                                              <div class="input-group-append">
                                                  <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
                                              </div>
                                          </div>
                                      </div>
                                </div>
                                <div class="form-group">
                                    <label>Plant <span class="text-danger">*</span></label>
                                    <sql:query var="plant" dataSource="jdbc/rmc">
                                    	select * from plant where plant_id like if(?=0,'%%',?)
                                    	<sql:param value="${bean.plant_id}"/>
                                    	<sql:param value="${bean.plant_id}"/>
                                    </sql:query>
									<select id="plant_id"  name="plant_id"  required="required"  class="select2"  data-placeholder="Choose Plant">
										<c:if test="${bean.plant_id==0}">
											<option value="0">All Plants</option>
										</c:if>
										<c:forEach var="plant" items="${plant.rows}">
										<option value="${plant.plant_id}">${plant.plant_name}</option>
										</c:forEach>
									</select>
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
		                
	<c:catch var="e">

         			 <c:if test="${param.type=='all'}">
						<div class="row table-responsive">
							<div class="col-xs-12">
								<!-- GET ALL DIESEL CONSUMPTION DETAIL HERE -->
								<h4 style="color: red;" class="text-center">MONTH : ${param.month}  &nbsp;&nbsp;YEAR : ${param.year}</h4>
								<table id="cons_table" class="table table-bordered">
									<%
									int iYear = Integer.parseInt(request.getParameter("year"));
									int iMonth = Integer.parseInt(request.getParameter("month"))-1; // 1 (months begin with 0)
									int iDay = 1;
	
									Calendar mycal = new GregorianCalendar(2000, iMonth, 1);
									int daysInMonth= mycal.getActualMaximum(Calendar.DAY_OF_MONTH);   
									pageContext.setAttribute("count", daysInMonth);
									%>
								   <thead>
									   		<tr>
									   			 <th>VEHICLE/DATE</th>
									   			 <c:forEach var="i" begin="1" end="${count}">
										           	<th>${i}</th>
										          </c:forEach>
										          <th>OPENING KM/HOUR</th>
										          <th>CLOSING KM/HOUR</th>
										          <th>TOTAL KM</th>
										          <th>TOTAL CONS.</th>
										          <th>RETURNED</th>
										          <th>MILAGE</th>
										          <th>Plant Name</th>
									   		</tr>
								  </thead>
								  <tbody>
								  	 <%
										Connection con=DBUtil.getConnection();
										PreparedStatement ps=con.prepareStatement("select p.*, (p.closing_km-p.opening_km) as total_km,(p.closing_km-p.opening_km)/totalqunaity as mileage,0 as return_quantity from  (select month(d.issued_date),year(d.issued_date),min(d.opening_km) as opening_km,max(d.closing_km) as closing_km,(select plant_name from plant where plant_id=d.plant_id)as plant_name,sum(d.issued_quantity) as totalqunaity,d.vehicle_no from diesel_consumption d "+
												" where month(d.issued_date)=? and year(d.issued_date)=? and d.plant_id like if (0=?,'%%',?)"+
												" group by d.vehicle_no,month(d.issued_date),year(d.issued_date),plant_name) as p");
										ps.setInt(1, Integer.parseInt(request.getParameter("month")));
										ps.setInt(2, Integer.parseInt(request.getParameter("year")));
										ps.setInt(3, Integer.parseInt(request.getParameter("plant_id")));
										ps.setInt(4, Integer.parseInt(request.getParameter("plant_id")));
										ResultSet rs=ps.executeQuery();
										while(rs.next()){
									%>
								  	 	<tr>
								  	 		<td><%=rs.getString("vehicle_no")%></td>
								  	 		<%
								  	 			double[] arr=new double[daysInMonth+1];
								  	 			for(int i=1;i<daysInMonth;i++){
								  	 				arr[i]=0;
								  	 			}
								  	 			PreparedStatement ps1=con.prepareStatement("select sum(d.issued_quantity)as quan,day(d.issued_date) as dt,d.vehicle_no from diesel_consumption d where month(d.issued_date)=? and year(d.issued_date)=? and d.vehicle_no=?  group by day(d.issued_date),d.vehicle_no");
								  	 			ps1.setInt(1, Integer.parseInt(request.getParameter("month")));
												ps1.setInt(2, Integer.parseInt(request.getParameter("year")));
												ps1.setString(3, rs.getString("vehicle_no"));
												ResultSet rs1=ps1.executeQuery();
												while(rs1.next()){
													arr[rs1.getInt("dt")]=rs1.getDouble("quan");
												}
												
												for(int i=1;i<arr.length;i++){
								  	 		%>
								  	 			<td><%=arr[i]%></td>
								  	 		<%} %>
								  	 		<td><%=rs.getDouble("opening_km") %></td>
								  	 		<td><%=rs.getDouble("closing_km") %></td>
								  	 		<%DecimalFormat format=new DecimalFormat("#.##");%>
								  	 		<td><%=format.format(rs.getDouble("total_km"))%></td>
								  	 		<td><%=rs.getDouble("totalqunaity")%></td>
								  	 		<td><%=format.format(rs.getDouble("return_quantity"))%></td>
								  	 		<td><%=format.format(rs.getDouble("mileage"))%></td>
								  	 		<td><%=rs.getString("plant_name") %></td>
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
								<div class="col-sm-12 text-center"> MONTH : ${param.month} &nbsp;&nbsp;&nbsp; YEAR: ${param.year} &nbsp;&nbsp;&nbsp;VEHICLE NO : ${param.vehicle_no}</div>
								
									<sql:query var="veh" dataSource="jdbc/rmc">
										select * from vehicle where vehicle_no=?
										<sql:param value="${param.vehicle_no}"/>
									</sql:query>
									
									<c:forEach var="veh" items="${veh.rows}">
										<c:set value="${veh}" var="vehi"/>
									</c:forEach>
									
									<table class="table table-bordered">
										<thead>
											<tr>
												<th>Issued Date</th>
												<th>Issued Time</th>
												<th>Issued Quantity</th>
												<th>Opening ${vehi.vehicle_cat}</th>
												<th>Closing ${vehi.vehicle_cat}</th>
												<th>Total ${vehi.vehicle_cat}</th>
												<th>Mileage</th>
												<th>Driver</th>
												<th>Issued Person</th>
												<th>Plant Name</th>
											</tr>
										</thead>
										<sql:query var="cons" dataSource="jdbc/rmc">
											select d.*,DATE_FORMAT(issued_date,'%d/%m/%Y') as issued_date,
											ROUND((closing_km-opening_km)/issued_quantity,2) as mileage,(select plant_name from plant where plant_id=d.plant_id)as plant_name
											from diesel_consumption d where month(issued_date)=? and year(issued_date)=?
											and vehicle_no=? and plant_id like if (0=?,'%%',?)
											<sql:param value="${param.month}"/>
											<sql:param value="${param.year}"/>
											<sql:param value="${param.vehicle_no}"/>
											<sql:param value="${param.plant_id}"/>
											<sql:param value="${param.plant_id}"/>
										</sql:query>
										<tbody>
											<c:set value="0" var="tquantity"/>
											<c:set value="0" var="count"/>
											<c:set value="0" var="tavg"/>
											<c:set value="0" var="totalkm"/>
											<c:forEach items="${cons.rows}" var="cons">
											<c:set value="${tquantity+cons.issued_quantity}" var="tquantity"/>
											<c:set value="${count+1}" var="count"/>
											<c:set value="${tavg+cons.mileage}" var="tavg"/>
											<c:set value="${totalkm+(cons.closing_km-cons.opening_km)}" var="totalkm"/>
											<tr>
												<td>${cons.issued_date}</td>
												<td>${cons.issued_time}</td>
												<td>${cons.issued_quantity}</td>
												<td>${cons.opening_km}</td>
												<td>${cons.closing_km}</td>
												<td>${cons.closing_km-cons.opening_km}</td>
												<td><fmt:formatNumber value="${cons.mileage}" maxFractionDigits="2" minFractionDigits="2" groupingUsed="false"/></td>
												<td>${cons.driver_name}</td>
												<td>${cons.issued_person}</td>
												<td>${cons.plant_name}</td>
											</tr>
											</c:forEach>
										</tbody>
										<tfoot>
											<tr>
												<th class="text-right">Total :</th>
												<th></th>
												<th>${tquantity}</th>
												<th colspan="2" class="text-right">Total KM:</th>
												<th>${totalkm}</th>
												<th>Avg : <fmt:formatNumber value="${totalkm/tquantity}" groupingUsed="false" maxFractionDigits="2"/></th>
												<th colspan="3"></th>
											</tr>
										</tfoot>
									</table>
									<button type="button" class="btn btn-info no-print" onclick="printDiv('print_me')">PRINT</button>
							</div>
						</c:if>
						
						<c:if test="${param.type=='customdate'}">
							<div class="row" id="print_me">
								<button type="button" class="btn btn-info no-print" onclick="printDiv('print_me')">PRINT</button>&nbsp;&nbsp;&nbsp;
								<button type="button" onclick="fnExcelReport();" class="btn  btn-primary">EXCEL</button>
								<div class="col-sm-12 text-center"> From Date : ${param.from_date} &nbsp;&nbsp;&nbsp; To Date: ${param.to_date} &nbsp;&nbsp;&nbsp;VEHICLE NO : ${param.vehicle_no}</div>
									<table class="table table-bordered" id="example-2">
										<thead>
											<tr>
												<td colspan="10" class="text-center">Diesel Report</td>
											</tr>
											<tr>
												<th>Issued Date</th>
												<th>Vehicle No</th>
												<th>Issued Time</th>
												<th>Issued Quantity</th>
												<th>Opening KM</th>
												<th>Closing Km</th>
												<th>Mileage</th>
												<th>Driver</th>
												<th>Issued Person</th>
												<th>Plant Name</th>
											</tr>
										</thead>
										<c:set value="${param.vehicle_no=='all'?'':param.vehicle_no}" var="vehicle_no"/>
										<sql:query var="cons" dataSource="jdbc/rmc">
											select d.*,DATE_FORMAT(issued_date,'%d/%m/%Y') as issued_date,
											ROUND((closing_km-opening_km)/issued_quantity,2) as mileage,(select plant_name from plant where plant_id=d.plant_id)as plant_name
											from diesel_consumption d where issued_date between ? and ?
											and vehicle_no like if(''=?,'%%',?) and plant_id like if (0=?,'%%',?)
											<sql:param value="${param.from_date}"/>
											<sql:param value="${param.to_date}"/>
											<sql:param value="${vehicle_no}"/>
											<sql:param value="${vehicle_no}"/>
											<sql:param value="${param.plant_id}"/>
											<sql:param value="${param.plant_id}"/>
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
												<td>${cons.issued_date}</td>
												<td>${cons.vehicle_no}</td>
												<td>${cons.issued_time}</td>
												<td>${cons.issued_quantity}</td>
												<td>${cons.opening_km}</td>
												<td>${cons.closing_km}</td>
												<td><fmt:formatNumber value="${cons.mileage}" maxFractionDigits="2" minFractionDigits="2" groupingUsed="false"/></td>
												<td>${cons.driver_name}</td>
												<td>${cons.issued_person}</td>
												<td>${cons.plant_name}</td>
											</tr>
											</c:forEach>
										</tbody>
										<tfoot>
											<tr>
												<th class="text-right">Total :</th>
												<th></th>
												<th></th>
												<th>${tquantity}</th>
												<th colspan="2" class="text-right"><!-- Average :  --></th>
												<th><%-- <fmt:formatNumber value="${tavg/count}" groupingUsed="false" maxFractionDigits="2"/> --%></th>
												<th colspan="3"></th>
											</tr>
										</tfoot>
									</table>
									
							</div>
						</c:if>
						<c:if test="${param.type=='few'}">
							<div class="row" id="print_me">
								<div class="col-sm-12">
								<h3 class="text-center">CONSOLIDATE DIESEL CONSUMPTION DETAIL</h3>
								<div class="col-xs-12 text-center"> MONTH : ${param.month} &nbsp;&nbsp;&nbsp; YEAR: ${param.year}</div>
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
												<th>Plant Name</th>
											</tr>
										</thead>
										<sql:query var="cons" dataSource="jdbc/rmc">
											select p.*, (p.closing_km-p.opening_km) as total_km,ROUND((p.closing_km-p.opening_km)/totalqunaity,2) as mileage,
											0 as return_quantity from  (select month(d.issued_date),year(d.issued_date),min(d.opening_km) as opening_km,(select plant_name from plant where plant_id=d.plant_id)as plant_name,
											max(d.closing_km) as closing_km,sum(d.issued_quantity) as totalqunaity,d.vehicle_no from diesel_consumption d
											where month(d.issued_date)=? and year(d.issued_date)=? and d.plant_id like if (0=?,'%%',?)
											group by d.vehicle_no,plant_name,month(d.issued_date),year(d.issued_date)) as p
											<sql:param value="${param.month}"/>
											<sql:param value="${param.year}"/>
											<sql:param value="${param.plant_id}"/>
											<sql:param value="${param.plant_id}"/>
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
												<td>${cons.plant_name}</td>
											</tr>
											</c:forEach>
										</tbody>
										<tfoot>
												<tr>
													<th colspan="5" class="text-right">TOTAL:</th>
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




		</c:catch>
		${e}



		</div>
		
		<a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse">
				<i class="ace-icon fa fa-angle-double-up icon-only bigger-110"></i>
			</a>
		
		
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


</body>
</html>