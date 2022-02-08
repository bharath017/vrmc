<!DOCTYPE html>
<%@ include file="Session.jsp" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
        <meta charset="utf-8" />
        <title>Customer Payment Report</title>
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
        
        <style type="text/css">
        	.change{
        		background-color:#469399;
        		color: white;
        	}
        	
        	.nochange{
        		background-color: #d7dfe0;
        		
        	}
        	
        	.table tr th,.table tr td{
        		border:1px solid black;
        	}
        	
        	.table>thead>tr>th,.table>tbody>tr>th,.table>tfoot>tr>th,.table>thead>tr>td,.table>tbody>tr>td,.table>tfoot>tr>td{
        		padding: 2px;
        	}
        	
        	@media print{
        		.no-print{
        			display: none;
        		}
        	}
        </style>

        <script src="assets/js/modernizr.min.js"></script>

    </head>

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
                                    <li class="breadcrumb-item"><a href="#">Accounts</a></li>
                                    <li class="breadcrumb-item"><a href="#">Customer Payment</a></li>
                                    <li class="breadcrumb-item"><a href="#">Payment Report</a></li>
                                </ol>
                            </div>
                            <h4 class="page-title">Payment Received Report</h4>
                        </div>
                    </div>
                </div>
                 <!-- end row -->
                <div class="row">
                	<div class="col-md-12 no-print">
                		<h2 class="text-info text-center">Payment Received Report</h2><hr><br><br>
                	</div>
                    <div class="col-md-12 no-print">
                       <form action="#" id="myform" method="post">
                          <div class="row">
                          	<div class="col-sm-4"></div>
                          	<div class="col-sm-4">
                          		<div class="col-sm-12" style="display: ${(bean.business_id==0)?'block':'none'}">
                                   <div class="form-group">
                                       <label>Business Group <span class="text-danger">*</span></label>
                                       <sql:query var="group" dataSource="jdbc/rmc">
                                       		select business_id,group_name
                                       		from business_group 
                                       		where business_id like if(0=?,'%%',?)
                                       		<sql:param value="${bean.business_id}"/>
                                       		<sql:param value="${bean.business_id}"/>
                                       </sql:query>
                                       <select class="select2" name="business_id" id="business_id" required="required">
                                       		<c:if test="${bean.business_id==0}">
                                       			<option value="0" ${(param.business_id==0)?'selected':''}>All Group</option>
                                       		</c:if>
                                       		<c:forEach items="${group.rows}" var="group">
                                       			<option value="${group.business_id}" ${(param.business_id==group.business_id)?'selected':''}>${group.group_name}</option>
                                       		</c:forEach>
                                       </select>
                                   </div>
                               </div>
                          		<div class="col-sm-12">
                                   <div class="form-group">
                                       <label>Report Type<span class="text-danger">*</span></label>
                                       <select class="select2" name="report_type" onchange="changeType()" id="report_type" required="required">
                                           <option value="date" ${param.report_type=='date'?'selected':''}>Date Wise</option>
                                           <option value="customer" ${param.report_type=='customer'?'selected':''}>Customer Wise</option>
                                           <option value="customerdate" ${param.report_type=='customerdate'?'selected':''}>Customer With Date Wise</option>
                                       </select>
                                   </div>
                               </div>
                               
                                <div class="col-sm-12 no-cus no-veh cus-dat veh-dat date no-mp mp-dat">
                                  <div class="form-group">
                                     <label>From Date<span class="text-danger">*</span></label>
				      				 <div class="input-group">
                                                <input type="text" name="from_date"  value="${param.from_date}" class="form-control date-picker no-cus no-veh cus-dat veh-dat date no-mp from_date mar mp-dat"
                                                	   required="required" placeholder="dd/mm/yyyy"
                                                	   id="id-date-picker-1" data-date-format="dd/mm/yyyy"
                                                	   readonly="readonly" style="background-color: white;">
                                                <div class="input-group-append" id="get-from_date">
                                                    <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
                                                </div>
                                      </div>

                                  </div>
                                </div>
                                
                                <div class="col-sm-12 no-cus no-veh cus-dat veh-dat veh-dat date no-mp mp-dat">
                                  <div class="form-group">
                                      <label>To Date<span class="text-danger">*</span></label>
				      				  <div class="input-group">
                                         <input type="text" name="to_date"  value="${param.to_date}" class="form-control date-picker no-cus no-veh cus-dat veh-dat veh-dat date no-mp to-date mp-dat"
                                         	   required="required" placeholder="dd/mm/yyyy"
                                         	   id="id-date-picker-2" data-date-format="dd/mm/yyyy"
                                         	   readonly="readonly" style="background-color: white;"/>
                                         <div class="input-group-append" id="get-to_date">
                                             <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
                                         </div>
                                      </div>
                                  </div>
                                </div>
                               
                               <div class="col-sm-12 no-date cus no-veh cus-dat no-veh-dat no-mp no-mp-dat">
                                   <div class="form-group">
                                       <label>Customer <span class="text-danger">*</span></label>
                                       <sql:query var="customer" dataSource="jdbc/rmc">
                                          select customer_id,customer_name 
                                          from customer
                                          where customer_status='active'
                                          and plant_id like if(?=0,'%%',?)
                                          <sql:param value="${bean.plant_id}"/>
                                          <sql:param value="${bean.plant_id}"/>
                                       </sql:query>
                                       <select class="select2 no-date cus no-veh cus-dat no-veh-dat" name="customer_id" id="customer_id">
                                          <c:forEach items="${customer.rows}" var="customer">
                                          	<option value="${customer.customer_id}">${customer.customer_name}</option>
                                          </c:forEach>
                                       </select>
                                   </div>
                               </div>
                               
                               <div class="col-sm-12">
                                   <div class="form-group">
                                       <label>Bank / Cash<span class="text-danger">*</span></label>
                                       <sql:query var="bank" dataSource="jdbc/rmc">
                                       		select bank_detail_id,bank_name,g.group_name
                                       		from bank_detail b,business_group g
                                       		where b.business_id=g.business_id
                                       	    and  b.business_id like if(?=0,'%%',?)
                                       		<sql:param value="${bean.business_id}"/>
                                       		<sql:param value="${bean.business_id}"/>
                                       </sql:query>
                                       <select class="form-control" name="bank_detail_id"  id="bank_detail_id" required="required">
                                       			<option value="0">All Bank & Cash</option>
                                       		<c:forEach items="${bank.rows}" var="bank">
                                       			<option value="${bank.bank_detail_id}">${bank.bank_name} - (${bank.group_name})</option>
                                       		</c:forEach>
                                       </select>
                                   </div>
                               </div>
                               
                               <div class="col-sm-12">
                                   <div class="form-group">
                                       <label>Plant :</label>
                                       <sql:query var="plant" dataSource="jdbc/rmc">
                                       	select * from plant
                                        where plant_id like if(?=0,'%%',?)
                                        and business_id like if(?=0,'%%',?)
                                       	<sql:param value="${bean.plant_id}"/>
                                       	<sql:param value="${bean.plant_id}"/>
                                       	<sql:param value="${bean.business_id}"/>
                                       	<sql:param value="${bean.business_id}"/>
                                       </sql:query>
                                       <select class="form-control" name="plant_id" id="plant_id">
                                           <c:if test="${bean.plant_id==0}">
                                           	<option value="0" selected="selected">All Plant</option>
                                           </c:if>
                                           <c:forEach items="${plant.rows}" var="plant">
                                           <option value="${plant.plant_id}">${plant.plant_name}</option>
                                           </c:forEach>
                                       </select>
                                   </div>
                                </div>
                               
                          	</div> 	
                          </div>
                           
                          <div class="text-center m-t-20">
                               <button type="submit" class="btn btn-primary btn-lg m-r-10 save-button">Generate Report</button>
                               <a class="btn btn-danger btn-lg" href="InvoiceReport.jsp">Clear Report</a>
                          </div>
                       </form>
                    </div>
                </div>
                
                <c:if test="${param.action=='generateReport'}">
               	<div class="row" style="margin-top: 25px;">
               		<div class="col-sm-12 no-print">
               			<button class="btn btn-warning btn-sm" onclick="generate_excel();">Excel</button>
               			<button class="btn btn-danger btn-sm" onclick="print();">Print</button>
               		</div>
               		<div class="col-sm-12 printme table-responsive" id="printme">
               			<!-- Get all kind of query here -->
               				<c:choose>
               					<c:when test="${param.report_type=='date'}">
               						<sql:query var="payment" dataSource="jdbc/rmc">
               							select p.*,DATE_FORMAT(p.payment_date,'%d/%m/%Y') as payment_date,
               							c.customer_name,b.bank_name
               							from customer_payment p LEFT JOIN (customer c,bank_detail b)
               							ON p.customer_id=c.customer_id
               							and p.bank_detail_id=b.bank_detail_id
               							where p.payment_date between STR_TO_DATE(?, '%d/%m/%Y') and STR_TO_DATE(?, '%d/%m/%Y')
               							and p.payment_amount>0
               							and c.business_id like if(?=0,'%%',?)
               							and p.bank_detail_id like if(?=0,'%%',?)
               							and p.payment_mode !='WAIVE_OFF'
               							and c.plant_id like if(?=0,'%%',?)
               							order by payment_id asc
               							<sql:param value="${param.from_date}"/>
               							<sql:param value="${param.to_date}"/>
               							<sql:param value="${param.business_id}"/>
               							<sql:param value="${param.business_id}"/>
               							<sql:param value="${param.bank_detail_id}"/>
               							<sql:param value="${param.bank_detail_id}"/>
               							<sql:param value="${param.plant_id}"/>
               							<sql:param value="${param.plant_id}"/>
               						</sql:query>
               					</c:when>
               			</c:choose>
               			
               			
               			
               			
               			
               			
               			<!-- Check which type is coming -->
               			<c:choose>
               				<c:when test="${param.report_type=='date'}">
               					<table class="table" id="example-2">
		               				<tr style="background-color: #91e9eb;color: black;" class="text-center">
		               					<td colspan="10" class="text-center">
		               						<h3>Payment Received Report</h3>
		               						From Date : ${param.from_date}
		               						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;To Date : ${param.to_date}
		               					</td>
		               				</tr>
		               				<tr style="background-color: #9debb6;color: black;">
		               					<th>Payment Id</th>
		               					<th>Customer Name</th>
		               					<th>Payment Date</th>
		               					<th>Payment Time</th>
		               					<th>Payment Amount</th>
		               					<th>Payment Mode</th>
		               					<th>Cheque/DD No </th>
		               					<th>Cheque/DD Validity</th>
		               					<th>BANK</th>
		               				</tr>
		               				
		               				<c:set value="0" var="net_amount"/>
		               				<c:forEach items="${payment.rows}" var="payment">
			               				<c:set value="${payment.payment_amount+net_amount}" var="net_amount"/>
		               					<tr>
			               					<td>${payment.payment_id}</td>
			               					<td>${payment.customer_name}</td>
			               					<td>${payment.payment_date}</td>
			               					<td>${payment.payment_time}</td>
			               					<td>${payment.payment_amount}</td>
			               					<td>${payment.payment_mode}</td>
			               					<td>${payment.check_dd_no}</td>
			               					<td>${payment.check_dd_validity}</td>
			               					<td>${payment.bank_name}</td>
			               				</tr>
		               				</c:forEach>
		               					<tr style="background-color: #e3d39a;color: black;font-weight: bold;">
											<td colspan="4" class="text-right">Total Net Amount : </td>
											<td colspan="5" class="text-left"><fmt:formatNumber value="${net_amount}" maxFractionDigits="2" groupingUsed="true" minFractionDigits="2"/></td>
		               					</tr>
		               			</table>
               				</c:when>
               				
               				<c:when test="${param.report_type=='customer'}">
               					<sql:query var="customer" dataSource="jdbc/rmc">
               							select distinct p.customer_id,c.customer_name
               							from customer_payment p LEFT JOIN (customer c)
               							ON p.customer_id=c.customer_id
               							where p.customer_id like if(0=?,'%%',?)
               							and p.payment_amount>0
               							and c.business_id like if(?=0,'%%',?)
               							and p.bank_detail_id like if(?=0,'%%',?)
               							and p.payment_mode !='WAIVE_OFF'
               							and c.plant_id like if(?=0,'%%',?)
               							<sql:param value="${param.customer_id}"/>
               							<sql:param value="${param.customer_id}"/>
               							<sql:param value="${param.business_id}"/>
               							<sql:param value="${param.business_id}"/>
               							<sql:param value="${param.bank_detail_id}"/>
               							<sql:param value="${param.bank_detail_id}"/>
               							<sql:param value="${param.plant_id}"/>
               							<sql:param value="${param.plant_id}"/>
               					</sql:query>
               					<table class="table" id="example-2">
		               				<tr style="background-color: #91e9eb;color: black;" class="text-center">
		               					<td colspan="9" class="text-center">
		               						<h3>Payment Received Report</h3>
		               					</td>
		               				</tr>
		               				<tr style="background-color: #9debb6;color: black;">
		               					<th>Payment Id</th>
		               					<th>Payment Date</th>
		               					<th>Payment Time</th>
		               					<th>Payment Amount</th>
		               					<th>Payment Mode</th>
		               					<th>Cheque/DD No </th>
		               					<th>Cheque/DD Validity</th>
		               					<th>Bank</th>
		               				</tr>
		               				
		               				<c:set value="0" var="net_amount"/>
		               				<c:forEach items="${customer.rows}" var="customer">
										<tr>
											<td colspan="8"><h5>${customer.customer_name}</h5></td>
										</tr>
										<sql:query var="payment" dataSource="jdbc/rmc">
	               							select p.*,DATE_FORMAT(p.payment_date,'%d/%m/%Y') as payment_date,b.bank_name
	               							from customer_payment p,bank_detail b
	               							where p.bank_detail_id=b.bank_detail_id
	               						    and  p.customer_id=?
	               							and p.payment_amount>0
	               							and p.bank_detail_id like if(?=0,'%%',?)
	               							and p.payment_mode !='WAIVE_OFF'
	               							order by p.payment_date asc
	               							<sql:param value="${customer.customer_id}"/>
	               							<sql:param value="${param.bank_detail_id}"/>
               								<sql:param value="${param.bank_detail_id}"/>
	               						</sql:query>
	               						<c:set var="csum" value="0"/>
	               						<c:forEach items="${payment.rows}" var="payment">
	               							<c:set value="${csum+payment.payment_amount}" var="csum"/>
		               						<tr>
				               					<td>${payment.payment_id}</td>
				               					<td>${payment.payment_date}</td>
				               					<td>${payment.payment_time}</td>
				               					<td>${payment.payment_amount}</td>
				               					<td>${payment.payment_mode}</td>
				               					<td>${payment.check_dd_no}</td>
				               					<td>${payment.check_dd_validity}</td>
				               					<td>${payment.bank_name}</td>
			               					</tr>
			               				</c:forEach>
			               					<tr>
			               						<td colspan="3" class="text-right" style="font-weight:  bold;">Total : </td>
			               						<td style="font-weight: bold;"><fmt:formatNumber value="${csum}" maxFractionDigits="2" groupingUsed="true" minFractionDigits="2"/></td>
			               						<td colspan="4"></td>
			               					</tr>
			               					<c:set value="${csum+net_amount}" var="net_amount"/>
		               				</c:forEach>
	               						<tr style="background-color: #e3d39a;color: black;font-weight: bold;">
											<td colspan="3" class="text-right">Total Net Amount : </td>
											<td class="text-left"><fmt:formatNumber value="${net_amount}" maxFractionDigits="2" groupingUsed="true" minFractionDigits="2"/></td>
											<td colspan="4"></td>
		               					</tr>
		               			</table>
               				</c:when>
               				
               				<c:when test="${param.report_type=='customerdate'}">
               					<sql:query var="customer" dataSource="jdbc/rmc">
               							select distinct p.customer_id,c.customer_name
               							from customer_payment p LEFT JOIN (customer c)
               							ON p.customer_id=c.customer_id
               							where p.customer_id like if(0=?,'%%',?)
               							and  p.payment_date between STR_TO_DATE(?, '%d/%m/%Y') and STR_TO_DATE(?, '%d/%m/%Y')
               							and c.business_id like if(?=0,'%%',?)
               							and p.bank_detail_id like if(?=0,'%%',?)
               							and p.payment_mode !='WAIVE_OFF'
               							and p.payment_amount>0
               							and c.plant_id like if(?=0,'%%',?)
               							<sql:param value="${param.customer_id}"/>
               							<sql:param value="${param.customer_id}"/>
               							<sql:param value="${param.from_date}"/>
               							<sql:param value="${param.to_date}"/>
               							<sql:param value="${param.business_id}"/>
               							<sql:param value="${param.business_id}"/>
               							<sql:param value="${param.bank_detail_id}"/>
               							<sql:param value="${param.bank_detail_id}"/>
               							<sql:param value="${param.plant_id}"/>
               							<sql:param value="${param.plant_id}"/>
               					</sql:query>
               					<table class="table" id="example-2">
		               				<tr style="background-color: #91e9eb;color: black;" class="text-center">
		               					<td colspan="9" class="text-center">
		               						<h3>Payment Received Report</h3>
		               					</td>
		               				</tr>
		               				<tr style="background-color: #9debb6;color: black;">
		               					<th>Payment Id</th>
		               					<th>Payment Date</th>
		               					<th>Payment Time</th>
		               					<th>Payment Amount</th>
		               					<th>Payment Mode</th>
		               					<th>Cheque/DD No </th>
		               					<th>Cheque/DD Validity</th>
		               					<th>Marketing Person</th>
		               					<th>Bank</th>
		               				</tr>
		               				
		               				<c:set value="0" var="net_amount"/>
		               				<c:forEach items="${customer.rows}" var="customer">
										<tr>
											<td colspan="8"><h5>${customer.customer_name}</h5></td>
										</tr>
										<sql:query var="payment" dataSource="jdbc/rmc">
	               							select p.*,DATE_FORMAT(p.payment_date,'%d/%m/%Y') as payment_date,b.bank_name
	               							from customer_payment p,bank_detail b
	               							where p.bank_detail_id=b.bank_detail_id and  p.customer_id=?
	               							and p.payment_date between STR_TO_DATE(?, '%d/%m/%Y') and STR_TO_DATE(?, '%d/%m/%Y')
	               							and p.payment_amount>0
	               							and p.payment_mode !='WAIVE_OFF'
	               							order by p.payment_date asc
	               							<sql:param value="${customer.customer_id}"/>
	               							<sql:param value="${param.from_date}"/>
	               							<sql:param value="${param.to_date}"/>
	               						</sql:query>
	               						<c:set var="csum" value="0"/>
	               						<c:forEach items="${payment.rows}" var="payment">
	               							<c:set value="${csum+payment.payment_amount}" var="csum"/>
		               						<tr>
				               					<td>${payment.payment_id}</td>
				               					<td>${payment.payment_date}</td>
				               					<td>${payment.payment_time}</td>
				               					<td>${payment.payment_amount}</td>
				               					<td>${payment.payment_mode}</td>
				               					<td>${payment.check_dd_no}</td>
				               					<td>${payment.check_dd_validity}</td>
				               					<td>${payment.bank_name}</td>
			               					</tr>
			               				</c:forEach>
			               					<tr>
			               						<td colspan="3" class="text-right" style="font-weight:  bold;">Total : </td>
			               						<td style="font-weight: bold;"><fmt:formatNumber value="${csum}" maxFractionDigits="2" groupingUsed="true" minFractionDigits="2"/></td>
			               						<td colspan="4"></td>
			               					</tr>
			               					<c:set value="${csum+net_amount}" var="net_amount"/>
		               				</c:forEach>
	               						<tr style="background-color: #e3d39a;color: black;font-weight: bold;">
											<td colspan="3" class="text-right">Total Net Amount : </td>
											<td class="text-left"><fmt:formatNumber value="${net_amount}" maxFractionDigits="2" groupingUsed="true" minFractionDigits="2"/></td>
											<td colspan="4"></td>
		               					</tr>
		               			</table>
               				</c:when>
               			</c:choose>
               			
               		</div>
               	</div>
               </c:if>
                <!-- end row -->
            </div> <!-- end container -->
        </div>
        
        <!-- Footer -->
       <%@ include file="footer.jsp" %>
        <!-- End Footer -->
        <!-- jQuery  -->
        <script src="assets/js/jquery.min.js"></script>
        <script src="assets/js/popper.min.js"></script>
        <script src="assets/js/bootstrap.min.js"></script>
        <script src="assets/js/waves.js"></script>
        <script src="assets/js/jquery.slimscroll.js"></script>

        <!-- App js -->
        <script src="assets/js/jquery.core.js"></script>
        <script src="assets/js/jquery.app.js"></script>
        <script src="assets/js/select2.min.js"></script>
		<script src="picker/js/bootstrap-datepicker.min.js"></script>
		<script src="picker/js/moment.min.js"></script>
		<script src="assets/js/bootstrap-timepicker.min.js"></script>
		<script src="picker/js/bootstrap-datetimepicker.min.js"></script>
		<script src="assets/js/ace.min.js"></script>
		<script type="text/javascript">
			$(document).ready(function(){
				 $('.select2').css('width','100%').select2({allowClear:true})
					.on('change', function(){
					}); 
		         
		         
		         $('.date-picker').datepicker({
						autoclose: true,
						todayHighlight: true,
						"orientation":"bottom left"
				 });
					//show datepicker when clicking on the icon
					
		         
		         $("#id-date-picker-1").datepicker();
					$('#id-date-picker-1').datepicker({
					        "autoclose": true,
					        "orientation":"bottom left"
				});
					
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
				}).next().on('click', function(){
					$(this).prev().focus();
				});
				
				$('#get-from_date').on('click',function(){
	  				 $('#id-date-picker-1').datepicker('show');
	  			});
					
				$('#get-to_date').on('click',function(){
 				  $('#id-date-picker-2').datepicker('show');
 				});
			});
		</script>
		<script type="text/javascript">
	    $("form").submit(function(e){
	        e.preventDefault();
	        var report_type=$('#report_type').val();
	        var business_id=$('#business_id').val();
	        var bank_detail_id=$('#bank_detail_id').val();
	        var plant_id=$('#plant_id').val();
	        if(report_type=='date'){
	        	var from_date=$('input[name="from_date"]').val();
	        	var to_date=$('input[name="to_date"]').val();
	        	window.location="CustomerPaymentReport.jsp?action=generateReport&business_id="+business_id+"&bank_detail_id="+bank_detail_id+"&report_type="+report_type+"&from_date="+from_date+"&to_date="+to_date+"&plant_id="+plant_id;
	        }else if(report_type=='customer'){
	        	var customer_id=$('#customer_id').val();
	        	var site_id=$('#site_id').val();
	        	var product_id=$('#product_id').val();
	        	var plant_id=$('#plant_id').val();
	        	window.location="CustomerPaymentReport.jsp?action=generateReport&business_id="+business_id+"&bank_detail_id="+bank_detail_id+"&report_type="+report_type+"&customer_id="+customer_id+"&site_id="+site_id+"&product_id="+product_id+"&plant_id="+plant_id;
	        }
	        else if(report_type=='customerdate'){
	        	var customer_id=$('#customer_id').val();
	        	var site_id=$('#site_id').val();
	        	var product_id=$('#product_id').val();
	        	var plant_id=$('#plant_id').val();
	        	var from_date=$('input[name="from_date"]').val();
	        	var to_date=$('input[name="to_date"]').val();
	        	window.location="CustomerPaymentReport.jsp?action=generateReport&business_id="+business_id+"&report_type="+report_type+"&bank_detail_id="+bank_detail_id+"&customer_id="+customer_id+"&from_date="+from_date+"&to_date="+to_date+"&plant_id="+plant_id;
	        }
	    });
    </script>
    
   <!--  <script type="text/javascript">
    	$(document).ready(function(){
    		changeType();
    		
    		
    		var getCustomerListByBusinessGroup=function(business_id){
    			$.ajax({
    				type:'post',
    				url:'CustomerController?action=getCustomerListByGroupWise&business_id='+business_id,
    				headers:{
    					Accept:"application/json;charset=utf-8",
    					"Content-Type":"application/json;charset=utf-8"
    				},
    				success:function(res){
    					$('#customer_id').empty();
    					$('#customer_id').append('<option value="0" selected >All Customer</option>');
    					$('#select2-customer_id-container').text('All Customer');
    					$.each(res,function(i,v){
    						$('#customer_id').append('<option value="'+v.customer_id+'">'+v.customer_name+'</option>');
    					});
    					
    				}
    			});
    		}
    		
    		
    		var business_id=$('#business_id').val();
    		getCustomerListByBusinessGroup(business_id);
    		
    		$('#business_id').on('change',function(){
    			var business_id=$('#business_id').val();
    			getCustomerListByBusinessGroup(business_id);
    		});
    	});
    </script> -->
    
    <script type="text/javascript">
    	function changeType(){
    		var report_type=$('#report_type').val();
			if(report_type=='date'){
				$('.no-date').hide();
				$('.no-date').prop('disabled',true);
				$('.date').show();
				$('.date').prop('disabled',false);
			}else if(report_type=='customer'){
				$('.cus').prop('disabled',false);
				$('.no-cus').prop('disabled',true);
				$('.cus').show();
				$('.no-cus').hide();
			}else if(report_type=='customerdate'){
				$('.cus-dat').prop('disabled',false);
				$('.no-cus-dat').prop('disabled',true);
				$('.cus-dat').show();
				$('.no-cus-dat').hide();
			}else if(report_type=='vehicledate'){
				$('.veh-dat').prop('disabled',false);
				$('no-veh-dat').prop('disabled',true);
				$('.veh-dat').show();
				$('.no-veh-dat').hide();
			}
    	}
    </script>
    <script type="text/javascript">
	    function generate_excel() {
	      var table= document.getElementById("example-2");
	      var html = table.outerHTML;
	      window.open('data:application/vnd.ms-excel;base64,' + base64_encode(html));
	    }
	    function base64_encode (data) {
	      // http://kevin.vanzonneveld.net
	      // +   original by: Tyler Akins (http://rumkin.com)
	      // +   improved by: Bayron Guevara
	      // +   improved by: Thunder.m
	      // +   improved by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
	      // +   bugfixed by: Pellentesque Malesuada
	      // +   improved by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
	      // +   improved by: Rafal Kukawski (http://kukawski.pl)
	      // *     example 1: base64_encode('Kevin van Zonneveld');
	      // *     returns 1: 'S2V2aW4gdmFuIFpvbm5ldmVsZA=='
	      // mozilla has this native
	      // - but breaks in 2.0.0.12!
	      //if (typeof this.window['btoa'] == 'function') {
	      //    return btoa(data);
	      //}
	      var b64 = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
	      var o1, o2, o3, h1, h2, h3, h4, bits, i = 0,
	        ac = 0,
	        enc = "",
	        tmp_arr = [];
	
	      if (!data) {
	        return data;
	      }
	
	      do { // pack three octets into four hexets
	        o1 = data.charCodeAt(i++);
	        o2 = data.charCodeAt(i++);
	        o3 = data.charCodeAt(i++);
	
	        bits = o1 << 16 | o2 << 8 | o3;
	
	        h1 = bits >> 18 & 0x3f;
	        h2 = bits >> 12 & 0x3f;
	        h3 = bits >> 6 & 0x3f;
	        h4 = bits & 0x3f;
	
	        // use hexets to index into b64, and append result to encoded string
	        tmp_arr[ac++] = b64.charAt(h1) + b64.charAt(h2) + b64.charAt(h3) + b64.charAt(h4);
	      } while (i < data.length);
	
	      enc = tmp_arr.join('');
	
	      var r = data.length % 3;
	
	      return (r ? enc.slice(0, r - 3) : enc) + '==='.slice(r || 3);
	
	    }
    </script>
    </body>
</html>