<!DOCTYPE html>
<%@ include file="Session.jsp" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
        <meta charset="utf-8" />
        <title>Credit Report</title>
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
                                    <li class="breadcrumb-item"><a href="#">Credit Report</a></li>
                                </ol>
                            </div>
                            <h4 class="page-title">Customer Credit Report</h4>
                        </div>
                    </div>
                </div>
                 <!-- end row -->
                 
                 <c:choose>
                 	<c:when test="${empty param.action}">
                 		<div class="row">
		                	<div class="col-md-12">
		                		<h2 class="text-info text-center">Credit Report</h2><hr><br><br>
		                	</div>
		                    <div class="col-md-12">
		                       <form action="#" id="myform" method="post">
		                          <div class="row">
		                          	<div class="col-sm-3"></div>
		                          	<div class="col-sm-6">
		                          	   <div class="col-sm-12">
		                                   <div class="form-group">
		                                       <label>Report Type<span class="text-danger">*</span></label>
		                                       <select class="form-control" name="report_type" id="report_type" required="required">
		                                           <option value="cus">Customer Wise</option>
		                                           <option value="cusdate">Customer with Date Wise</option>
		                                           <option value="cusgbmd">Customer(Group By Multiple Days)</option>
		                                       </select>
		                                   </div>
		                               </div>
		                               <div class="col-sm-12 cus">
		                                   <div class="form-group">
		                                       <label>Customer <span class="text-danger">*</span></label>
		                                       <sql:query var="customer" dataSource="jdbc/rmc">
		                                       	select * from marketing_person where mp_status='active' order by mp_name asc
		                                       </sql:query>
		                                       <select class="select2 cus" name="customer_id" id="customer_id" required="required">
		                                           <option value="0" selected="selected" disabled="disabled">Please Select</option>
		                                           <c:forEach items="${customer.rows}" var="customer">
		                                           <option value="${customer.mp_id}">${customer.mp_name}</option>
		                                           </c:forEach>
		                                       </select>
		                                   </div>
		                               </div>
		                               
		                               <div class="col-sm-12 cus-date">
		                                  <div class="form-group">
		                                      <label>From Date<span class="text-danger">*</span></label>
		                                      <div class="cal-icon">
		                                          <input type="text" name="from_date" value="${param.from_date}" class="form-control date-picker from_date cus-date" required="required" placeholder="yyyy-mm-dd" id="id-date-picker-1" data-date-format="yyyy-mm-dd">
		                                      </div>
		                                  </div>
		                                </div>
		                                
		                                <div class="col-sm-12 cus-date">
		                                  <div class="form-group">
		                                      <label>To Date<span class="text-danger">*</span></label>
		                                      <div class="cal-icon">
		                                          <input type="text" name="to_date" value="${param.to_date}"  class="form-control date-picker to_date cus-date" required="required" placeholder="yyyy-mm-dd" id="id-date-picker-1" data-date-format="yyyy-mm-dd">
		                                      </div>
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
                 	</c:when>
                 	<c:otherwise>
                 		<c:choose>
                 			<c:when test="${param.report_type=='cus'}">
                 				<!-- Get customer details here -->
			               		<sql:query var="customer" dataSource="jdbc/rmc">
			               			select * from marketing_person where mp_id=?
			               			<sql:param value="${param.customer_id}"/>
			               		</sql:query>
			               		<c:forEach var="customer" items="${customer.rows}">
			               			<c:set value="${customer}" var="cus"/>
			               		</c:forEach>
			               		
			               		<div class="row">
			               			<div class="col-sm-12" id="mydiv">
			               				<table class="table table-bordered table-hover table-condensed" id="example-2">
			               					<tr>
			               						<th colspan="12" style="background-color: #215b1f;color: white;" class="text-center">
			               							<h3>${initParam.company_name}</h3>
			               							<p>${initParam.company_address}</p>
			               						</th>
			               					</tr>
			               					<tr>
			               						<th colspan="12" style="background-color: #215b1f;color: white;" class="text-center">
			               							Statement Of Account : Customer &nbsp;&nbsp;&nbsp;&nbsp; Name : ${cus.mp_name}
			               						</th>
			               					</tr>
			               					<tr>
			               						<th colspan="6" style="background-color: #215b1f;color: white;" class="text-center">
			               							Invoice Details
			               						</th>
			               						<th colspan="3" style="background-color: #215b1f;color: white;" class="text-center">
			               							Payment Details
			               						</th>
			               						<th colspan="3" style="background-color: #215b1f;color: white;" class="text-center">
			               							Age Details
			               						</th>
			               					</tr>
			               					<tr>
			               						<td colspan="6" style="width:50%;">
			               							<table class="table table-bordered table-condensed">
			                							<tr style="background-color: #5b1f59;color: white;">
			                							<!-- 	<th class="text-center">Invoice No</th>
			                								<th class="text-center">Invoice Date</th>
			                								<th class="text-center">Item Name</th> -->
			                								<th class="text-center">Quantity</th>
			                								<!-- <th class="text-center">Rate</th>
			                								<th class="text-center">Net Amount</th> -->
			                							</tr>
			                							
			                							<!-- Get Invoice details here -->
			                							<sql:query var="invoice" dataSource="jdbc/rmc">
														select sum(i.quantity) as quantity,DATE_FORMAT(i.invoice_date,'%d/%m/%Y') as invoice_date,c.customer_name,s.site_name,s.site_address,pr.product_name,pr.product_id,p.plant_name,m.mp_name,c.customer_address,c.customer_gstin
				               						    from invoice i LEFT JOIN (customer c,site_detail s,purchase_order_item poi,product pr,plant p,purchase_order po,marketing_person m)
				               							ON i.customer_id=c.customer_id
				               							and i.site_id=s.site_id
				               							and i.poi_id=poi.poi_id
				               							and poi.order_id=poi.order_id
				               							and poi.product_id=pr.product_id
				               							and i.plant_id=p.plant_id
				               							and poi.order_id=po.order_id
				               							and po.marketing_person_id=m.mp_id
				               							where po.marketing_person_id=?
				               							and i.invoice_status='active'
				               							order by id asc
			                						<sql:param value="${param.customer_id}"/>
			                							</sql:query>
			                							<c:set value="${invoice.rows}" var="inv"/>
			                							<c:set value="0" var="tsum"/>
			                							<c:set value="0" var="nsum"/>
			                							<c:forEach items="${inv}" var="in">
				                							<tr>
				                								<%-- <td style="width:4%;" class="text-center">${in.invoice_id}</td>
				                								<td style="width:3%;" class="text-center">${in.invoice_date}</td>
				                								<td style="width:4%;" class="text-center">${in.product_name}</td>
				                								<c:set value="${in.quantity+tsum}" var="tsum"/> --%>
				                								<td style="width:5%;" class="text-center">${in.quantity}</td>
				                								<%-- <td style="width:6%;" class="text-center">${in.rate}</td>
				                								<td style="width:5%;" class="text-center">${in.net_amount}</td> --%>
				                								<c:set value="${in.net_amount+nsum}" var="nsum"/>
				                							</tr>	
				                						</c:forEach>
			                						</table>
			               						</td>
			               						
			               					<!-- get payment details here -->
			               						<sql:query var="payment" dataSource="jdbc/rmc">
			               							select sum(qi.quantity) as quantity from customer_quotation_item qi left join customer_quotation q on(qi.quotation_id=q.quotation_id) where mp_id=?
			               							<sql:param value="${param.customer_id}"/>
			               						</sql:query>
			               						<td colspan="3" style="width:25%;">
			               							<table class="table table-bordered table-condensed">
			                							<tr style="background-color: #5b1f59;color: white;">
			                								<th>Quantity</th>
			                							</tr>
			                							<c:forEach var="payment" items="${payment.rows}">
				                							<tr>
				                								<td style="width: 8%;">${payment.quantity}</td>
				                							</tr>
			                							</c:forEach>
			                						</table>
			               						</td>
			               						
			               						<!-- Now sum total payment according to perticular customer -->
			               			<%-- 			<sql:query var="sumnet" dataSource="jdbc/rmc">
			               							select sum(payment_amount) as paysum from customer_payment where customer_id=?
			               							<sql:param value="${param.customer_id}"/>
			               						</sql:query>
			               						<c:set var="paysum" value="0"/>
			               						<c:forEach items="${sumnet.rows}" var="sumnet">
			               							<c:set value="${sumnet.paysum}" var="paysum"/>
			               							<c:set value="${sumnet.paysum}" var="psum"/>
			               						</c:forEach>
			               						<td colspan="3" class="col-sm-3">
			               							<table class="table table-bordered table-condensed">
			                							<tr style="background-color: #5b1f59;color: white;">
			                								<th>Today Date</th>
			                								<th>Age</th>
			                								<th>Outstanding</th>
			                							</tr>
			                							
			                							
			                							<!-- Get Today Date -->
			                							
			                							<jsp:useBean id="now" class="java.util.Date" />
														<fmt:formatDate var="today" value="${now}" pattern="yyyy-MM-dd" />
			                							<c:forEach items="${inv}" var="in">
			                								<tr>
			                									<td>${today}</td>
			                									<td>${in.age} </td>
			                									<td>${(in.net_amount-paysum>0)?in.net_amount-paysum:0}</td>
			                								</tr>
			                								<c:set value="${(paysum-in.net_amount>0)?paysum-in.net_amount:0}" var="paysum"/>
			                							</c:forEach>	
			                						</table>
			               						</td>  --%>
			               					</tr>
			               					<tr style="background-color: #30665f;color: white;" >
			               						<td></td>
			               						<td colspan="3" class="text-right">Total : </td>
			               						<td class="text-right">${tsum}</td>
			               						<td class="text-right">${nsum}</td>
			               						<td colspan="2" class="text-right">Total Payment : </td>
			               						<td class="text-left">${psum}</td>
			               						<td class="text-right" colspan="2">Total Outstanding : </td>
			               						<td class="text-left">${nsum-psum}</td>
			               					</tr>
			               				</table>
			               			</div>
			               			<div class="col-sm-12 text-center">
			               				<button class="btn btn-success btn-sm" onclick="generate_excel();">Excel</button>
			               				<button class="btn btn-warning btn-sm" onclick="printData();">Print</button>
			               				<a href="CreditReport.jsp" class="btn btn-danger btn-sm" >Click Report</a>
			               			</div>
			               		</div>
                 			</c:when>
                 			<c:when test="${param.report_type=='cusgbmd'}">
                 				<table class="table table-bordered table-hover table-dondensed printme" id="example-2">
                 					<jsp:useBean id="today" class="java.util.Date"/>
                 					<fmt:formatDate var="mydate" value="${today}" pattern="dd/mm/yyyy" />
                 					<tr>
                 						<th colspan="13" class="text-center">Account Receivable statement ${mydate}</th>
                 					</tr>
                 					<tr>
                 						<th>NAME OF THE CUSTOMER</th>
                 						<th>Total Net Amount</th>
                 						<th>Total Paid Amount</th>
                 						<th>0-15 DAYS</th>
                 						<th>16-30 DAYS</th>
                 						<th>31-45 DAYS</th>
                 						<th>46-60 DAYS</th>
                 						<th>61-75 DAYS</th>
                 						<th>76-90 DAYS</th>
                 						<th>91-120 DAYS</th>
                 						<th>Above 120 DAYS</th>
                 						<th>Total Pending Amount</th>
                 						<th>Marketing Person</th>
                 					</tr>
                 					
                 					<sql:query var="ccustomer" dataSource="jdbc/rmc">
                 						select t.customer_id,t.customer_name,t.net,t.payment,IF(t.D120 IS NULL,0,t.D120) as D120,
										IF(t.D91 IS NULL,0,t.D91) as D91,
										IF(t.D76 IS NULL,0,t.D76) as D76,
										IF(t.D61 IS NULL,0,t.D61) as D61,
										IF(t.D46 IS NULL,0,t.D46) as D46,
										IF(t.D31 IS NULL,0,t.D31) as D31,
										IF(t.D16 IS NULL,0,t.D16) as D16,
										IF(t.D0 IS NULL,0,t.D0) as D0,t.mp_name FROM 
										(select k.* from (select p.customer_id,p.customer_name,p.net,if(p.payment is null,0,p.payment) as payment,
										(select sum(net_amount) from invoice where datediff(now(), invoice_date) > 120 and customer_id=p.customer_id) as 'D120',
										(select sum(net_amount) from invoice where datediff(now(), invoice_date) > 90 and datediff(now(), invoice_date) <= 120 and customer_id=p.customer_id) as 'D91',
										(select sum(net_amount) from invoice where datediff(now(), invoice_date) > 75 and datediff(now(), invoice_date) <= 90 and customer_id=p.customer_id) as 'D76',
										(select sum(net_amount) from invoice where datediff(now(), invoice_date) > 60 and datediff(now(), invoice_date) <= 75 and customer_id=p.customer_id) as 'D61',
										(select sum(net_amount) from invoice where datediff(now(), invoice_date) > 45 and datediff(now(), invoice_date) <= 60 and customer_id=p.customer_id) as 'D46',
										(select sum(net_amount) from invoice where datediff(now(), invoice_date) > 30 and datediff(now(), invoice_date) <= 45 and customer_id=p.customer_id) as 'D31',
										(select sum(net_amount) from invoice where datediff(now(), invoice_date) > 15 and datediff(now(), invoice_date) <= 30 and customer_id=p.customer_id) as 'D16',
										(select sum(net_amount) from invoice where datediff(now(), invoice_date) > 0 and datediff(now(), invoice_date) <= 15 and customer_id=p.customer_id) as 'D0',
										(select m.mp_name from marketing_person m,purchase_order po where po.marketing_person_id=m.mp_id and po.customer_id=p.customer_id limit 1) as mp_name
										from (select c.customer_id,c.customer_name,sum(i.net_amount) as net,
										(select sum(payment_amount) from customer_payment where customer_id=c.customer_id) as payment
										from customer c,invoice i
										where i.customer_id=c.customer_id
										group by c.customer_id,c.customer_name) as p) as k where k.net-k.payment > 0) as t
                 					</sql:query>
                 					
                 					<c:set value="0" var="D120payment"/>
                 					<c:set value="0" var="D91payment"/>
                 					<c:set value="0" var="D76payment"/>
                 					<c:set value="0" var="D61payment"/>
                 					<c:set value="0" var="D46payment"/>
                 					<c:set value="0" var="D31payment"/>
                 					<c:set value="0" var="D16payment"/>
                 					<c:set value="0" var="D0payment"/>
                 					<c:set value="0" var="D120amount"/>
                 					<c:set value="0" var="D91amount"/>
                 					<c:set value="0" var="D76amount"/>
                 					<c:set value="0" var="D61amount"/>
                 					<c:set value="0" var="D46amount"/>
                 					<c:set value="0" var="D31amount"/>
                 					<c:set value="0" var="D16amount"/>
                 					<c:set value="0" var="D0amount"/>
                 					<c:forEach items="${ccustomer.rows}" var="rs">
                 						<c:set value="${((rs.D120-rs.payment)>0)?(rs.D120-rs.payment):0}" var="D120amount"/>
                 						<c:set value="${((rs.D120-rs.payment)>0)?0:-(rs.D120-rs.payment)}" var="D120payment"/>
	                 					<c:set value="${((rs.D91-D120payment)>0)?(rs.D91-D120payment):0}" var="D91amount"/>
	                 					<c:set value="${((rs.D91-D120payment)>0)?0:-(rs.D91-D120payment)}" var="D91payment"/>
	                 					<c:set value="${((rs.D76-D91payment)>0)?(rs.D76-D91payment):0}" var="D76amount"/>
	                 					<c:set value="${((rs.D76-D91payment)>0)?0:-(rs.D76-D91payment)}" var="D76payment"/>
	                 					<c:set value="${((rs.D61-D76payment)>0)?(rs.D61-D76payment):0}" var="D61amount"/>
	                 					<c:set value="${((rs.D61-D76payment)>0)?0:-(rs.D61-D76payment)}" var="D61payment"/>
	                 					<c:set value="${((rs.D46-D61payment)>0)?(rs.D46-D61payment):0}" var="D46amount"/>
	                 					<c:set value="${((rs.D46-D61payment)>0)?0:-(rs.D46-D61payment)}" var="D46payment"/>
	                 					<c:set value="${((rs.D31-D46payment)>0)?(rs.D31-D46payment):0}" var="D31amount"/>
	                 					<c:set value="${((rs.D31-D46payment)>0)?0:-(rs.D31-D46payment)}" var="D31payment"/>
	                 					<c:set value="${((rs.D16-D31payment)>0)?(rs.D16-D31payment):0}" var="D16amount"/>
	                 					<c:set value="${((rs.D16-D31payment)>0)?0:-(rs.D16-D31payment)}" var="D16payment"/>
	                 					<c:set value="${((rs.D0-D16payment)>0)?(rs.D0-D16payment):0}" var="D0amount"/>
	                 					<c:set value="${((rs.D0-D16payment)>0)?0:-(rs.D0-D16payment)}" var="D0payment"/>
	                 					<!--<c:set value="0" var="D0payment"/>-->
                 						<tr>
                 							<td>${rs.customer_name}</td>
                 							<td>${rs.net}</td>
                 							<td>${rs.payment}</td>
                 							<td>${D0amount}</td>
                 							<td>${D16amount}</td>
                 							<td>${D31amount}</td>
                 							<td>${D46amount}</td>
                 							<td>${D61amount}</td>
                 							<td>${D76amount}</td>
                 							<td>${D91amount} </td>
                 							<td>${D120amount}</td>
                 							<td>${D0amount+D16amount+D31amount+D46amount+D61amount+D76amount+D91amount+D120amount}</td>
                 							<td>${rs.mp_name}</td>
                 						</tr>
                 					<c:set value="0" var="D120payment"/>
                 					<c:set value="0" var="D91payment"/>
                 					<c:set value="0" var="D76payment"/>
                 					<c:set value="0" var="D61payment"/>
                 					<c:set value="0" var="D46payment"/>
                 					<c:set value="0" var="D31payment"/>
                 					<c:set value="0" var="D16payment"/>
                 					<c:set value="0" var="D0payment"/>
                 					<c:set value="0" var="D120amount"/>
                 					<c:set value="0" var="D91amount"/>
                 					<c:set value="0" var="D76amount"/>
                 					<c:set value="0" var="D61amount"/>
                 					<c:set value="0" var="D46amount"/>
                 					<c:set value="0" var="D31amount"/>
                 					<c:set value="0" var="D16amount"/>
                 					<c:set value="0" var="D0amount"/>
                 					</c:forEach>
                 				</table>
                 				<div class="col-sm-12 text-center">
			               				<button class="btn btn-success btn-sm" onclick="generate_excel();">Excel</button>
			               				<button class="btn btn-warning btn-sm" onclick="printData();">Print</button>
			               				<a href="CreditReport.jsp" class="btn btn-danger btn-sm" >Click Report</a>
			               		</div>
                 			</c:when>
                 			<c:otherwise>
                 				<!-- Get customer details here -->
			               		<sql:query var="customer" dataSource="jdbc/rmc">
			               			select * from customer where customer_id=?
			               			<sql:param value="${param.customer_id}"/>
			               		</sql:query>
			               		<c:forEach var="customer" items="${customer.rows}">
			               			<c:set value="${customer}" var="cus"/>
			               		</c:forEach>
			               		
			               		<div class="row">
			               			<div class="col-sm-12" id="mydiv">
			               				<table class="table table-bordered table-hover table-condensed" id="example-2">
			               					<tr>
			               						<th colspan="12" style="background-color: #215b1f;color: white;" class="text-center">
			               							<h3>${initParam.company_name}</h3>
			               							<p>${initParam.company_address}</p>
			               						</th>
			               					</tr>
			               					<tr>
			               						<th colspan="12" style="background-color: #215b1f;color: white;" class="text-center">
			               							Statement Of Account : Customer &nbsp;&nbsp;&nbsp;&nbsp; Name : ${cus.customer_name}
			               						</th>
			               					</tr>
			               					<tr>
			               						<th colspan="6" style="background-color: #215b1f;color: white;" class="text-center">
			               							Invoice Details
			               						</th>
			               						<th colspan="3" style="background-color: #215b1f;color: white;" class="text-center">
			               							Payment Details
			               						</th>
			               						<th colspan="3" style="background-color: #215b1f;color: white;" class="text-center">
			               							Age Details
			               						</th>
			               					</tr>
			               					<tr>
			               						<td colspan="6" style="width:50%;">
			               							<table class="table table-bordered table-condensed">
			                							<tr style="background-color: #5b1f59;color: white;">
			                								<th class="text-center">Invoice No</th>
			                								<th class="text-center">Invoice Date</th>
			                								<th class="text-center">Item Name</th>
			                								<th class="text-center">Quantity</th>
			                								<th class="text-center">Rate</th>
			                								<th class="text-center">Net Amount</th>
			                							</tr>
			                							
			                							<!-- Get Invoice details here -->
			                							<sql:query var="invoice" dataSource="jdbc/rmc">
			                								select i.*,p.product_name,DATEDIFF(CURRENT_DATE(), i.invoice_date) as age from invoice i,purchase_order_item poi,product p  where i.poi_id=poi.poi_id and poi.product_id=p.product_id and  customer_id=? and i.invoice_date between ? and ? and  i.invoice_status='active'
			                								<sql:param value="${param.customer_id}"/>
			                								<sql:param value="${param.from_date}"/>
			                								<sql:param value="${param.to_date}"/>
			                							</sql:query>
			                							<c:set value="${invoice.rows}" var="inv"/>
			                							<c:set value="0" var="tsum"/>
			                							<c:set value="0" var="nsum"/>
			                							<c:forEach items="${inv}" var="in">
				                							<tr>
				                								<td style="width:4%;" class="text-center">${in.invoice_id}</td>
				                								<td style="width:3%;" class="text-center">${in.invoice_date}</td>
				                								<td style="width:4%;" class="text-center">${in.product_name}</td>
				                								<c:set value="${in.quantity+tsum}" var="tsum"/>
				                								<td style="width:5%;" class="text-center">${in.quantity}</td>
				                								<td style="width:6%;" class="text-center">${in.rate}</td>
				                								<td style="width:5%;" class="text-center">${in.net_amount}</td>
				                								<c:set value="${in.net_amount+nsum}" var="nsum"/>
				                							</tr>	
				                						</c:forEach>
			                						</table>
			               						</td>
			               						
			               						<!-- get payment details here -->
			               						<sql:query var="payment" dataSource="jdbc/rmc">
			               							select * from customer_payment where customer_id=? and payment_date between ? and ?
			               							<sql:param value="${param.customer_id}"/>
			               							<sql:param value="${param.from_date}"/>
			               							<sql:param value="${param.to_date}"/>
			               						</sql:query>
			               						<td colspan="3" style="width:25%;">
			               							<table class="table table-bordered table-condensed">
			                							<tr style="background-color: #5b1f59;color: white;">
			                								<th>Payment Type</th>
			                								<th>Payment Date</th>
			                								<th>Amount</th>
			                							</tr>
			                							<c:forEach var="payment" items="${payment.rows}">
				                							<tr>
				                								<td style="width: 8%;">${payment.payment_mode}</td>
				                								<td style="width: 8%;">${payment.payment_date}</td>
				                								<td style="width: 8%;">${payment.payment_amount}</td>
				                							</tr>
			                							</c:forEach>
			                						</table>
			               						</td>
			               						
			               						<!-- Now sum total payment according to perticular customer -->
			               						<sql:query var="sumnet" dataSource="jdbc/rmc">
			               							select sum(payment_amount) as paysum from customer_payment where customer_id=? and payment_date between ? and ?
			               							<sql:param value="${param.customer_id}"/>
			               							<sql:param value="${param.from_date}"/>
			               							<sql:param value="${param.to_date}"/>
			               						</sql:query>
			               						<c:set var="paysum" value="0"/>
			               						<c:forEach items="${sumnet.rows}" var="sumnet">
			               							<c:set value="${sumnet.paysum}" var="paysum"/>
			               							<c:set value="${sumnet.paysum}" var="psum"/>
			               						</c:forEach>
			               						<td colspan="3" class="col-sm-3">
			               							<table class="table table-bordered table-condensed">
			                							<tr style="background-color: #5b1f59;color: white;">
			                								<th>Today Date</th>
			                								<th>Age</th>
			                								<th>Outstanding</th>
			                							</tr>
			                							
			                							
			                							<!-- Get Today Date -->
			                							
			                							<jsp:useBean id="noww" class="java.util.Date" /> 
														<fmt:formatDate var="today" value="${noww}" pattern="yyyy-MM-dd" />
			                							<c:forEach items="${inv}" var="in">
			                								<tr>
			                									<td>${today}</td>
			                									<td>${in.age} </td>
			                									<td>${(in.net_amount-paysum>0)?in.net_amount-paysum:0}</td>
			                								</tr>
			                								<c:set value="${(paysum-in.net_amount>0)?paysum-in.net_amount:0}" var="paysum"/>
			                							</c:forEach>	
			                						</table>
			               						</td>
			               					</tr>
			               					<tr style="background-color: #30665f;color: white;" >
			               						<td></td>
			               						<td colspan="3" class="text-right">Total : </td>
			               						<td class="text-right">${tsum}</td>
			               						<td class="text-right">${nsum}</td>
			               						<td colspan="2" class="text-right">Total Payment : </td>
			               						<td class="text-left">${psum}</td>
			               						<td class="text-right" colspan="2">Total Outstanding : </td>
			               						<td class="text-left">${nsum-psum}</td>
			               					</tr>
			               				</table>
			               			</div>
			               			<div class="col-sm-12 text-center">
			               				<button class="btn btn-success btn-sm" onclick="generate_excel();">Excel</button>
			               				<button class="btn btn-warning btn-sm" onclick="printData();">Print</button>
			               				<a href="CreditReport.jsp" class="btn btn-danger btn-sm" >Click Report</a>
			               			</div>
			               		</div>
                 			</c:otherwise>
                 		</c:choose>
                 	</c:otherwise>
                 </c:choose>
               	<br><br>
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
						todayHighlight: true
				 });
					//show datepicker when clicking on the icon
					
		         
		         $("#id-date-picker-1").datepicker("setDate", new Date());
					$('#id-date-picker-1').datepicker({
					        "setDate": new Date(),
					        "autoclose": true
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
				}).next().on(ace.click_event, function(){
					$(this).prev().focus();
				});
			});
		</script>
		<!-- <script type="text/javascript">
		    $("form").submit(function(e){
		        e.preventDefault();
		        var report_type=$('#report_type').val();
		       	var customer_id=$('#customer_id').val();
		       	window.location="CreditReport.jsp?action=generateReport&customer_id="+customer_id;
		    });
    	</script>
    
	    <script type="text/javascript">
	    	$(document).ready(function(){
	    		$('.no-date').prop('disabled',true);
	    		$('.no-date').hide();
	    	});
	    </script> -->
	    
	    
	    
    
   
    <script type="text/javascript">
    	$(document).ready(function(){
    		$('#customer_id').on('change',function(){
    			var customer_id=$('#customer_id').val();
    			$.ajax({
    				type:'POST',
    				url:'CustomerController?action=getCustomerSiteDetails&customer_id='+customer_id,
    				headers:{
    					Accept:"application/json;charset=utf-8",
    					"Content-Type":"application/json;charset=utf-8"
    				},
    				success:function(result){
    					$('#select2-site_id-container').html('Choose Site Address');
    					$('#site_id').html('');
    	        		$('#site_id').html('<option value="">Choose Site Address.</option>');
    	        		$.each(result, function(index, value) {
    	        			   $('#site_id').append("<option value='"+ value.site_id+ "'>" + value.site_name + "</option>");
    	        		});
    	        		
    				}
    			});
    		});
    	});
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
    <script type="text/javascript">
    function print() {
        var frame = document.getElementsByClassName('printme').item(0);
        var data = frame.innerHTML;
        var win = window.open('', '', 'height=500,width=900');
        win.document.write('<style>@page{size:landscape;}@media print{*{font-size:12px;}}</style><html><head><title></title>');
        win.document.write('</head><body >');
        win.document.write(data);
        win.document.write('</body></html>');
        win.print();
        win.close();
        return true;
    }
    </script>
    
    <script type="text/javascript">
	    $(document).ready(function(){
			$('#report_type').on('change',function(){
				var report_type=$('#report_type').val();
				changeType(report_type)
			});
			
			var changeType=function(report_type){
				if(report_type=='cus'){
					$('.cus-date').hide();
					$('.cus-date').prop('disabled',true);
				}
				else if(report_type=='cusgbmd'){
					$('.cus-date').hide();
					$('.cus-date').prop('disabled',true);
				}
				else{
					$('.cus-date').show();
					$('.cus-date').prop('disabled',false);
				}
			};
			//call the method for render of report type here
			var report=$('#report_type').val();
			//alert(report);
			changeType(report);
		});
    </script>
    <script type="text/javascript">
	    $("#myform").submit(function(e){
	        e.preventDefault();
	        var report_type=$('#report_type').val();
	        if(report_type=='cus'){
	        	var customer_id=$('#customer_id').val();
	        	window.location="TotalSalesReport.jsp?action=generateReport&report_type="+report_type+"&customer_id="+customer_id;
	        }else{
	        	var from_date=$('.from_date').val();
	        	var to_date=$('.to_date').val();
	        	var customer_id=$('#customer_id').val();
	        	window.location="TotalSalesReport.jsp?action=generateReport&report_type="+report_type+"&from_date="+from_date+"&to_date="+to_date+"&customer_id="+customer_id;
	        }
	    });
    </script>
    
		
    </body>
</html>