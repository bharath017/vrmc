<!DOCTYPE html>
<%@ include file="Session.jsp" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.Date" %>
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
       	.hide{
       		display: none;
       	}
        	
        	.tableFixHead {
		  overflow-y: auto;
		  height: 450px;
		}
		
		.tableFixHead table {
		  border-collapse: collapse;
		  width: 100%;
		}
		
		.tableFixHead th,
		.tableFixHead td {
		  padding: 8px 16px;
		}
		
		.tableFixHead th {
		  position: sticky;
		  top: 0;
		  background: #eee;
		}
		
		.tbl th{
			border:1px solid black;
		}
		
		.tbl td{
			border:1px solid black;
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
		                                       <select class="form-control" name="report_type" id="report_type" required="required">
		                                           <option value="cus">Customer Wise</option>
		                                           <option value="cusdate">Customer with Date Wise</option>
		                                           <option value="cusgbmd">Customer(Group By Multiple Days)</option>
		                                           <option value="cmw">Customer With Marketing Wise (Group By Multiple Days)</option>
		                                       </select>
		                                   </div>
		                               </div>
		                               <div class="col-sm-12 mar">
		                                   <div class="form-group">
		                                       <label>Plant <span class="text-danger">*</span></label>
		                                       <sql:query var="plant" dataSource="jdbc/rmc">
		                                       		select plant_id,plant_name
		                                       		from plant
		                                       </sql:query>
		                                       <select class="select2 mar" name="plant_id" id="plant_id" >
		                                       			<option value="0">All Plant</option>
		                                       		<c:forEach items="${plant.rows}" var="plant">
		                                       			<option value="${plant.plant_id}">${plant.plant_name}</option>
		                                       		</c:forEach>
		                                       </select>
		                                   </div>
		                               </div>
		                               
		                                <div class="col-sm-12 mar">
		                                   <div class="form-group">
		                                       <label>Marketing Person <span class="text-danger">*</span></label>
		                                       <sql:query var="mp" dataSource="jdbc/rmc">
		                                       		select mp_id,mp_name
		                                       		from marketing_person
		                                       		where mp_status='active'
		                                       </sql:query>
		                                       <select class="select2 mar" name="mp_id" id="mp_id" data-placeholder="Select Marketing Person">
		                                       			<option value="0">Select Marketing Person</option>
		                                       		<c:forEach items="${mp.rows}" var="mp">
		                                       			<option value="${mp.mp_id}">${mp.mp_name}</option>
		                                       		</c:forEach>
		                                       </select>
		                                   </div>
		                               </div>
		                               
		                               <div class="col-sm-12 cus">
		                                   <div class="form-group">
		                                       <label>Customer <span class="text-danger">*</span></label>
		                                       <select class="select2 cus" name="customer_id" id="customer_id" >
		                                       </select>
		                                   </div>
		                               </div>
		                               
		                               <div class="col-sm-12 cus-date">
		                                  <div class="form-group">
		                                      <label>From Date<span class="text-danger">*</span></label>
		                                      <div class="input-group">
		                                          <input type="text" name="from_date" value="${param.from_date}" 
		                                          		 class="form-control date-picker from_date cus-date" required="required"
		                                          		 placeholder="dd/mm/yyyy" id="id-date-picker-1" data-date-format="dd/mm/yyyy"
		                                          		 readonly="readonly" style="background-color: white;"/>
		                                          <div class="input-group-append picker">
		                                               <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
		                                          </div>
		                                      </div>
		                                  </div>
		                                </div>
		                                
		                                <div class="col-sm-12 cus-date">
		                                  <div class="form-group">
		                                      <label>To Date<span class="text-danger">*</span></label>
		                                      <div class="input-group">
		                                          <input type="text" name="to_date" value="${param.to_date}" 
		                                          		 class="form-control date-picker to_date cus-date" required="required"
		                                          		 placeholder="dd/mm/yyyy" id="id-date-picker-1" data-date-format="dd/mm/yyyy"
		                                          		 readonly="readonly" style="background-color: white;"/>
		                                          <div class="input-group-append picker">
	                                              	 <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
	                                              </div>
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
			               			select * from customer where customer_id=?
			               			<sql:param value="${param.customer_id}"/>
			               		</sql:query>
			               		<c:forEach var="customer" items="${customer.rows}">
			               			<c:set value="${customer}" var="cus"/>
			               		</c:forEach>
			               		
			               		<div class="row">
			               			<div class="col-sm-12" id="mydiv">
			               				<table class="table table-bordered table-hover table-condensed table-responsive" id="example-2">
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
			                								<th>Type</th>
			                							</tr>
			                							
			                							<!-- Get Invoice details here -->
			                							<sql:query var="invoice" dataSource="jdbc/rmc">
			                								select t.* from (SELECT s.invoice_id as invoice_id,DATE_FORMAT(s.invoice_date,'%d/%m/%Y') as invoice_date,s.invoice_date as dt,c.customer_name,p.product_name,si.item_quantity as quantity,si.item_price as rate,si.net_price as net_amount,'Sales Document' as type,DATEDIFF(CURRENT_DATE(), s.invoice_date) as age,'' as plant_id FROM sales_document s  left join (`sales_document_item` si,customer c,product p,purchase_order_item poi) on s.id=si.id and c.customer_id=s.customer_id and p.product_id=poi.product_id and si.poi_id=poi.poi_id where c.customer_id=? and s.invoice_status='active'
			                								UNION
			                								SELECT '' as invoice_id,'' as invoice_date,'' as dt,'' as customer_name,'' as product_name,'' as quantity,'' as rate,c.opening_balance as net_amount,'Opening Balance' as type,'' as age,'' as plant_id from customer c where customer_id=?
															UNION 
															select i.invoice_id,DATE_FORMAT(i.invoice_date,'%d/%m/%Y') as invoice_date,i.invoice_date as dt,c.customer_name,p.product_name,i.quantity,i.rate,i.net_amount,'Invoice' as type,DATEDIFF(CURRENT_DATE(), i.invoice_date) as age,i.plant_id from invoice i,purchase_order_item poi,product p,customer c where i.poi_id=poi.poi_id and poi.product_id=p.product_id and i.customer_id=c.customer_id and i.invoice_status='active' and i.customer_id=?
															UNION
															select db.id as invoice_id,DATE_FORMAT(i.invoice_date,'%d/%m/%Y') as invoice_date,i.invoice_date as dt,c.customer_name,p.product_name,db.quantity,db.approved_rate as rate,(-1*db.net_amount),'Credit Note' as type,DATEDIFF(CURRENT_DATE(), i.invoice_date) as age,'' as plant_id from debit_credit_note db,invoice i,purchase_order_item poi,product p,customer c where  db.invoice_id=i.id and i.poi_id=poi.poi_id and poi.product_id=p.product_id and i.customer_id=c.customer_id  and i.invoice_status='active' and i.customer_id=?
															) as t
															order by t.dt,t.invoice_id asc
			                								<sql:param value="${param.customer_id}"/>
			                								<sql:param value="${param.customer_id}"/>
			                								<sql:param value="${param.customer_id}"/>
			                								<sql:param value="${param.customer_id}"/>
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
				                								<td style="width:5%;" class="text-center"> ${in.type}</td>
				                								<c:set value="${in.net_amount+nsum}" var="nsum"/>
				                							</tr>	
				                						</c:forEach>
			                						</table>
			               						</td>
			               						
			               						<!-- get payment details here -->
			               						<sql:query var="payment" dataSource="jdbc/rmc">
			               							select * from customer_payment where customer_id=?
			               							<sql:param value="${param.customer_id}"/>
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
				                								<td style="width: 8%;"><fmt:formatNumber value="${payment.payment_amount}" maxFractionDigits="2" groupingUsed="false"/></td>
				                							</tr>
			                							</c:forEach>
			                						</table>
			               						</td>
			               						
			               						<!-- Now sum total payment according to perticular customer -->
			               						<sql:query var="sumnet" dataSource="jdbc/rmc">
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
			               						</td>
			               					</tr>
			               					<tr style="background-color: #30665f;color: white;" >
			               						<td></td>
			               						<td colspan="3" class="text-right">Total : </td>
			               						<td class="text-right"><fmt:formatNumber value="${tsum}" maxFractionDigits="2" groupingUsed="false"/></td>
			               						<td class="text-right"><fmt:formatNumber value="${nsum}" maxFractionDigits="2" groupingUsed="false"/></td>
			               						<td colspan="2" class="text-right">Total Payment : </td>
			               						<td class="text-left"><fmt:formatNumber value="${psum}" maxFractionDigits="2" groupingUsed="false"/></td>
			               						<td class="text-right" colspan="2">Total Outstanding : </td>
			               						<td class="text-left"><fmt:formatNumber value="${nsum-psum}" maxFractionDigits="2" groupingUsed="false"/></td>
			               					</tr>
			               				</table>
			               			</div>
			               			<div class="col-sm-12 text-center">
			               				<button class="btn btn-success btn-sm" onclick="generate_excel();">Excel</button>
			               				<button class="btn btn-warning btn-sm" onclick="printData();">Print</button>
			               				<a href="CreditReport.jsp" class="btn btn-danger btn-sm" >Click Report</a>
			               				<a href="AddPayment.jsp" class="btn btn-custom btn-sm" >Add Payment</a>
			               			</div>
			               		</div>
                 			</c:when>
                 	<c:when test="${param.report_type=='cusgbmd'}">
                 			<jsp:useBean id="today" class="java.util.Date"/>
                 			<fmt:formatDate var="todaydate" value="${today}" pattern="yyyy-MM-dd" />
							<c:set var="today" value="<%=new Date()%>"/>
							<c:set var="yesterday" value="<%=new Date(new Date().getTime() + 60*60*24*1000)%>"/>
							<fmt:formatDate value="${yesterday}" var="yest" pattern="yyyy-MM-dd"/>
                 			 <div class="input-group col-sm-4">
                                 <input type="text" name="invoice_date" class="form-control date-picker invoice_date" value="${(empty param.date)?(yest):(param.date)}"  placeholder="yyyy-mm-dd" id="id-date-picker-2" data-date-format="yyyy-mm-dd">
                                 <div class="input-group-append picker">
                                     <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
                                 </div>
                                 <button class="btn btn-success btn-sm hide"  id="generate_report" onclick="generateReport();">Generate Report</button>
                             </div>
                             <button class="btn btn-success btn-sm hide"  id="generate_report" onclick="generateReport();">Generate Report</button>
                             	<div class="tableFixHead">
                 				<table class="table table-bordered table-hover table-dondensed printme table-responsive" id="example-2">
                 					
                 					<fmt:parseDate value="${param.date}" var="param_date"  pattern="yyyy-MM-dd" />  
                 					<fmt:formatDate var="mydate" value="${(empty param_date)?(today):(param_date)}" pattern="dd/MM/yyyy" />
                 					<c:set var="date" value="${(empty param.date)?(todaydate):(param.date)}"/>
                 					
                 					<sql:query var="group" dataSource="jdbc/rmc">
                 						select group_name from business_group where business_id=?
                 						<sql:param value="${param.business_id}"/>
                 					</sql:query>
                 					<c:forEach items="${ group.rows}" var="group">
                 						<c:set value="${group.group_name}" var="business_group"/>
                 					</c:forEach>
                 					<tr>
                 						<th colspan="15" class="text-center">Account Receivable statement  &nbsp;&nbsp; <b style="color:blue">${mydate}</b>  &nbsp;&nbsp;&nbsp;&nbsp;Business Group : <b style="color:blue">${(empty business_group)?'All Group':business_group}</b></th>
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
								<th>Unbilled Amount</th>
								<th>Phone</th>
                 						<th>Marketing Person</th>
                 						<th>Last Invoice Generated Date	</th>
                 					</tr>
                 					<c:catch var='e'>
                 					<sql:query var="ccustomer" dataSource="jdbc/rmc">
                 						select t.customer_id,t.customer_name,t.customer_phone,DATE_FORMAT(t.last_dispatch_date,'%d/%m/%Y') as last_dispatch_date,DATE_FORMAT((select max(invoice_date) from sales_document where customer_id=t.customer_id),'%d/%m/%Y') as last_dispatch,t.net,t.dtnet,t.stnet,t.payment,t.credit_note,(IF(t.D120 IS NULL,0,t.D120)+IF(t.S120 IS NULL,0,t.S120)+t.opening_balance) as D120,
										(IF(t.D91 IS NULL,0,t.D91)+IF(t.S91 IS NULL,0,t.S91)) as D91,
										(IF(t.D76 IS NULL,0,t.D76)+IF(t.S76 IS NULL,0,t.S76)) as D76,
										(IF(t.D61 IS NULL,0,t.D61)+IF(t.S61 IS NULL,0,t.S61)) as D61,
										(IF(t.D46 IS NULL,0,t.D46)+IF(t.S46 IS NULL,0,t.S46)) as D46,
										(IF(t.D31 IS NULL,0,t.D31)+IF(t.S31 IS NULL,0,t.S31)) as D31,
										(IF(t.D16 IS NULL,0,t.D16)+IF(t.S16 IS NULL,0,t.S16)) as D16,
										(IF(t.D0 IS NULL,0,t.D0)+IF(t.S0 IS NULL,0,t.S0)) as D0,t.mp_name FROM 
										(select k.* from (select p.customer_id,p.customer_name,p.customer_phone,p.last_dispatch_date,p.opening_balance,(if(p.net is null ,0,p.net)+if(p.snet is null,0,p.snet)+p.opening_balance) as net,if(p.stnet is null,0,p.stnet) as stnet,if(p.dtnet is null,0,p.dtnet) as dtnet,if(p.payment is null,0,p.payment) as payment,p.credit_note,
										(select sum(net_amount) from invoice where datediff(?, invoice_date) > 120 and customer_id=p.customer_id and invoice_status='active') as 'D120',
										(select sum(net_price) from sales_document_item sd,sales_document s where sd.id=s.id and  datediff(?, s.invoice_date) > 120 and customer_id=p.customer_id and invoice_status='active') as 'S120',
										(select sum(net_amount) from invoice where datediff(?, invoice_date) > 90 and datediff(?, invoice_date) <= 120 and customer_id=p.customer_id and invoice_status='active' ) as 'D91',
										(select sum(net_price) from sales_document_item sdi,sales_document sd where sdi.id=sd.id and  datediff(?, invoice_date) > 90 and datediff(?, invoice_date) <= 120 and customer_id=p.customer_id and invoice_status='active' ) as 'S91',
										(select sum(net_amount) from invoice where datediff(?, invoice_date) > 75 and datediff(?, invoice_date) <= 90 and customer_id=p.customer_id and invoice_status='active'  ) as 'D76',
										(select sum(net_price) from sales_document_item sdi,sales_document sd where sdi.id=sd.id and  datediff(?, invoice_date) > 75 and datediff(?, invoice_date) <= 90 and customer_id=p.customer_id and invoice_status='active'  ) as 'S76',
										(select sum(net_amount) from invoice where datediff(?, invoice_date) > 60 and datediff(?, invoice_date) <= 75 and customer_id=p.customer_id and invoice_status='active' ) as 'D61',
										(select sum(net_price) from sales_document_item sdi,sales_document sd where sdi.id=sd.id and  datediff(?, invoice_date) > 60 and datediff(?, invoice_date) <= 75 and customer_id=p.customer_id and invoice_status='active' ) as 'S61',
										(select sum(net_amount) from invoice where datediff(?, invoice_date) > 45 and datediff(?, invoice_date) <= 60 and customer_id=p.customer_id and invoice_status='active') as 'D46',
										(select sum(net_price) from sales_document_item sdi,sales_document sd where sdi.id=sd.id and  datediff(?, invoice_date) > 45 and datediff(?, invoice_date) <= 60 and customer_id=p.customer_id and invoice_status='active') as 'S46',
										(select sum(net_amount) from invoice where datediff(?, invoice_date) > 30 and datediff(?, invoice_date) <= 45 and customer_id=p.customer_id and invoice_status='active') as 'D31',
										(select sum(net_price) from sales_document_item sdi,sales_document sd where sdi.id=sd.id and  datediff(?, invoice_date) > 30 and datediff(?, invoice_date) <= 45 and customer_id=p.customer_id and invoice_status='active') as 'S31',
										(select sum(net_amount) from invoice where datediff(?, invoice_date) > 15 and datediff(?, invoice_date) <= 30 and customer_id=p.customer_id and invoice_status='active') as 'D16',
										(select sum(net_price) from sales_document_item sdi,sales_document sd where sdi.id=sd.id and  datediff(?, invoice_date) > 15 and datediff(?, invoice_date) <= 30 and customer_id=p.customer_id and invoice_status='active') as 'S16',
										(select sum(net_amount) from invoice where datediff(?, invoice_date) > 0 and datediff(?, invoice_date) <= 15 and customer_id=p.customer_id and invoice_status='active') as 'D0',
										(select sum(net_price) from sales_document_item sdi,sales_document sd where sdi.id=sd.id and  datediff(?, invoice_date) > 0 and datediff(?, invoice_date) <= 15 and customer_id=p.customer_id and invoice_status='active') as 'S0',
										(select m.mp_name from marketing_person m where m.mp_id=p.mp_id) as mp_name
										from (select c.customer_id,c.customer_name,c.customer_phone,c.opening_balance,c.mp_id,c.last_dispatch_date,
										(select sum(net_amount) from invoice  where invoice_status='active' and invoice_date <=? and customer_id=c.customer_id)  as net,
										(select sum(net_amount) from dc  where invoice_status='active' and invoice_date <=? and customer_id=c.customer_id)  as dtnet,
										(select sum(sdi.net_price) from sales_document sd,sales_document_item sdi where sd.id=sdi.id and sd.invoice_status='active' and sd.invoice_date<=? and sd.customer_id=c.customer_id) as snet,
										(select (sum(sdi.gross_price)+sum(sdi.tax_price)) from sales_document sd,sales_document_item sdi where sd.id=sdi.id and sd.invoice_status='active' and sd.invoice_date<=? and sd.customer_id=c.customer_id) as stnet,
										(select sum(payment_amount) from customer_payment where customer_id=c.customer_id) as payment,
										(select sum(db.net_amount) from debit_credit_note db,invoice i where db.invoice_id=i.id and i.customer_id=c.customer_id and db.date < ?) as credit_note
										from customer c
										where c.customer_status='active' and business_id like if(?=0,'%%',?)
										group by c.customer_id,c.customer_name order by c.customer_name asc) as p) as k   ) as t
										<c:forEach begin="1" end="33">
											<sql:param value="${yest}"/>
										</c:forEach>
										<sql:param value="${param.business_id}"/>
										<sql:param value="${param.business_id}"/>
                 					</sql:query>
                 					</c:catch>
                 					
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
                 					
                 					
									<c:set value="0" var="net_left"/>
									<c:set value="0" var="net_total"/>
									<c:set value="0" var="net_paid"/>
									<c:set value="0" var="day15"/>
									<c:set value="0" var="day30"/>
									<c:set value="0" var="day54"/>
									<c:set value="0" var="day60"/>
									<c:set value="0" var="day75"/>
									<c:set value="0" var="day90"/>
									<c:set value="0" var="day120"/>
									<c:set value="0" var="day120above"/>
									
									
                 					<c:forEach items="${ccustomer.rows}" var="rs">
                 						<c:set value="${((rs.D120-rs.payment-rs.credit_note)>0)?(rs.D120-rs.payment-rs.credit_note):0}" var="D120amount"/>
                 						<c:set value="${((rs.D120-rs.payment-rs.credit_note)>0)?0:-(rs.D120-rs.payment-rs.credit_note)}" var="D120payment"/>
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
	                 					<fmt:formatNumber value="${(rs.net-rs.payment-rs.credit_note)}" var="roundoffff" maxFractionDigits="2" groupingUsed="false"/>
	                 					 <fmt:parseNumber var="roundoffffffff" type="number" value="${roundoffff}" />
	                 					<c:if test="${roundoffffffff>0}">
                 						<tr>
                 							<td>${rs.customer_name}</td>
                 							<td><fmt:formatNumber value="${rs.net-rs.credit_note}" maxFractionDigits="2" groupingUsed="true"/></td>
                 							<td><fmt:formatNumber value="${rs.payment}" maxFractionDigits="2" groupingUsed="true"/></td>
                 							<td><fmt:formatNumber value="${D0amount}" maxFractionDigits="2" groupingUsed="true"/></td>
                 							<td><fmt:formatNumber value="${D16amount}" maxFractionDigits="2" groupingUsed="true"/></td>
                 							<td><fmt:formatNumber value="${D31amount}" maxFractionDigits="2" groupingUsed="true"/></td>
                 							<td><fmt:formatNumber value="${D46amount}" maxFractionDigits="2" groupingUsed="true"/></td>
                 							<td><fmt:formatNumber value="${D61amount}" maxFractionDigits="2" groupingUsed="true"/></td>
                 							<td><fmt:formatNumber value="${D76amount}" maxFractionDigits="2" groupingUsed="true"/></td>
                 							<td><fmt:formatNumber value="${D91amount}" maxFractionDigits="2" groupingUsed="true"/> </td>
                 							<td><fmt:formatNumber value="${D120amount}" maxFractionDigits="2" groupingUsed="true"/></td>
                 							<td><fmt:formatNumber value="${rs.net-rs.payment-rs.credit_note}" maxFractionDigits="2" groupingUsed="true"/></td>
									<td>${rs.stnet-rs.dtnet}<td>
									<td>${rs.customer_phone}</td>
                 							<td>${rs.mp_name}</td>
									<td>${(empty rs.last_dispatch)?rs.last_dispatch_date:rs.last_dispatch}</td>
											<c:set value="${(rs.net-rs.payment-rs.credit_note)+net_left}" var="net_left"/>
											<c:set value="${(rs.net-rs.credit_note)+net_total}" var="net_total"/>
											<c:set value="${rs.payment+net_paid}" var="net_paid"/>
											<c:set value="${D0amount+day15}" var="day15"/>
											<c:set value="${D16amount+day30}" var="day30"/>
											<c:set value="${D31amount+day54}" var="day54"/>
											<c:set value="${D46amount+day60}" var="day60"/>
											<c:set value="${D61amount+day75}" var="day75"/>
											<c:set value="${D76amount+day90}" var="day90"/>
											<c:set value="${D91amount+day120}" var="day120"/>
											<c:set value="${D120amount+day120above}" var="day120above"/>
                 						</tr>
                 						</c:if>
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
								<tfoot>
									<tr style="background-color:pink;">
										<td></td>
										<td><fmt:formatNumber value="${net_total}" maxFractionDigits="2" groupingUsed="true"/></td>
										<td><fmt:formatNumber value="${net_paid}" maxFractionDigits="2" groupingUsed="true"/></td>
										<td><fmt:formatNumber value="${day15}" maxFractionDigits="2" groupingUsed="true"/></td>
										<td><fmt:formatNumber value="${day30}" maxFractionDigits="2" groupingUsed="true"/></td>
										<td><fmt:formatNumber value="${day54}" maxFractionDigits="2" groupingUsed="true"/></td>
										<td><fmt:formatNumber value="${day60}" maxFractionDigits="2" groupingUsed="true"/></td>
										<td><fmt:formatNumber value="${day75}" maxFractionDigits="2" groupingUsed="true"/></td>
										<td><fmt:formatNumber value="${day90}" maxFractionDigits="2" groupingUsed="true"/></td>
										<td><fmt:formatNumber value="${day120}" maxFractionDigits="2" groupingUsed="true"/></td>
										<td><fmt:formatNumber value="${day120above}" maxFractionDigits="2" groupingUsed="true"/></td>
										<td><fmt:formatNumber value="${net_left}" maxFractionDigits="2" groupingUsed="true"/></td>
										<td></td>
									</tr>
								</tfoot>

                 				</table>
                 				</div>
                 				<div class="col-sm-12 text-center">
                 						
			               				<button class="btn btn-success btn-sm" onclick="generate_excel();">Excel</button>
			               				<button class="btn btn-warning btn-sm" onclick="printData();">Print</button>
			               				<a href="CreditReport.jsp" class="btn btn-danger btn-sm" >Click Report</a>
			               				<a href="AddPayment.jsp" class="btn btn-custom btn-sm" >Add Payment</a>
			               		</div>
                 			</c:when>
                 			
                 			<c:when test="${param.report_type=='cmw'}">
					<jsp:useBean id="tod" class="java.util.Date"/>
                 			<fmt:formatDate var="todaydate" value="${tod}" pattern="yyyy-MM-dd" />
							<c:set var="today" value="<%=new Date()%>"/>
							<c:set var="yesterday" value="<%=new Date(new Date().getTime() + 60*60*24*1000)%>"/>
							<fmt:formatDate value="${yesterday}" var="yest" pattern="yyyy-MM-dd"/>
                 			 <div class="input-group col-sm-4">
                                 <input type="text" name="invoice_date" class="form-control date-picker invoice_date" value="${(empty param.date)?(yest):(param.date)}"  placeholder="yyyy-mm-dd" id="id-date-picker-2" data-date-format="yyyy-mm-dd">
                                 <div class="input-group-append picker">
                                     <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
                                 </div>
                                 <button class="btn btn-success btn-sm hide"  id="generate_report" onclick="generateReport();">Generate Report</button>
                             </div>
                             <button class="btn btn-success btn-sm hide"  id="generate_report" onclick="generateReport();">Generate Report</button>
                             	<div class="tableFixHead">
                 				<table class="table table-bordered table-hover table-dondensed printme table-responsive" id="example-2">
                 					
                 					<fmt:parseDate value="${param.date}" var="param_date"  pattern="yyyy-MM-dd" />  
                 					<fmt:formatDate var="mydate" value="${(empty param_date)?(today):(param_date)}" pattern="dd/MM/yyyy" />
                 					<c:set var="date" value="${(empty param.date)?(todaydate):(param.date)}"/>
                 					
                 					<sql:query var="group" dataSource="jdbc/rmc">
                 						select group_name from business_group where business_id=?
                 						<sql:param value="${param.business_id}"/>
                 					</sql:query>
                 					<c:forEach items="${ group.rows}" var="group">
                 						<c:set value="${group.group_name}" var="business_group"/>
                 					</c:forEach>
                 					<tr>
                 						<th colspan="14" class="text-center">Account Receivable statement  &nbsp;&nbsp; <b style="color:blue">${mydate}</b>  &nbsp;&nbsp;&nbsp;&nbsp;Business Group : <b style="color:blue">${(empty business_group)?'All Group':business_group}</b></th>
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
                 						<th>Last Invoice Generated Date	</th>
                 					</tr>
                 					<c:catch var='e'>
                 					<sql:query var="ccustomer" dataSource="jdbc/rmc">
                 						select t.customer_id,t.customer_name,DATE_FORMAT(t.last_dispatch_date,'%d/%m/%Y') as last_dispatch_date,DATE_FORMAT((select max(invoice_date) from sales_document where customer_id=t.customer_id),'%d/%m/%Y') as last_dispatch,t.net,t.payment,t.credit_note,(IF(t.D120 IS NULL,0,t.D120)+IF(t.S120 IS NULL,0,t.S120)+t.opening_balance) as D120,
										(IF(t.D91 IS NULL,0,t.D91)+IF(t.S91 IS NULL,0,t.S91)) as D91,
										(IF(t.D76 IS NULL,0,t.D76)+IF(t.S76 IS NULL,0,t.S76)) as D76,
										(IF(t.D61 IS NULL,0,t.D61)+IF(t.S61 IS NULL,0,t.S61)) as D61,
										(IF(t.D46 IS NULL,0,t.D46)+IF(t.S46 IS NULL,0,t.S46)) as D46,
										(IF(t.D31 IS NULL,0,t.D31)+IF(t.S31 IS NULL,0,t.S31)) as D31,
										(IF(t.D16 IS NULL,0,t.D16)+IF(t.S16 IS NULL,0,t.S16)) as D16,
										(IF(t.D0 IS NULL,0,t.D0)+IF(t.S0 IS NULL,0,t.S0)) as D0,t.mp_name FROM 
										(select k.* from (select p.customer_id,p.customer_name,p.last_dispatch_date,p.opening_balance,(if(p.net is null ,0,p.net)+if(p.snet is null,0,p.snet)+p.opening_balance) as net,if(p.payment is null,0,p.payment) as payment,p.credit_note,
										(select sum(net_amount) from invoice where datediff(?, invoice_date) > 120 and customer_id=p.customer_id and invoice_status='active') as 'D120',
										(select sum(net_price) from sales_document_item sd,sales_document s where sd.id=s.id and  datediff(?, s.invoice_date) > 120 and customer_id=p.customer_id and invoice_status='active') as 'S120',
										(select sum(net_amount) from invoice where datediff(?, invoice_date) > 90 and datediff(?, invoice_date) <= 120 and customer_id=p.customer_id and invoice_status='active' ) as 'D91',
										(select sum(net_price) from sales_document_item sdi,sales_document sd where sdi.id=sd.id and  datediff(?, invoice_date) > 90 and datediff(?, invoice_date) <= 120 and customer_id=p.customer_id and invoice_status='active' ) as 'S91',
										(select sum(net_amount) from invoice where datediff(?, invoice_date) > 75 and datediff(?, invoice_date) <= 90 and customer_id=p.customer_id and invoice_status='active'  ) as 'D76',
										(select sum(net_price) from sales_document_item sdi,sales_document sd where sdi.id=sd.id and  datediff(?, invoice_date) > 75 and datediff(?, invoice_date) <= 90 and customer_id=p.customer_id and invoice_status='active'  ) as 'S76',
										(select sum(net_amount) from invoice where datediff(?, invoice_date) > 60 and datediff(?, invoice_date) <= 75 and customer_id=p.customer_id and invoice_status='active' ) as 'D61',
										(select sum(net_price) from sales_document_item sdi,sales_document sd where sdi.id=sd.id and  datediff(?, invoice_date) > 60 and datediff(?, invoice_date) <= 75 and customer_id=p.customer_id and invoice_status='active' ) as 'S61',
										(select sum(net_amount) from invoice where datediff(?, invoice_date) > 45 and datediff(?, invoice_date) <= 60 and customer_id=p.customer_id and invoice_status='active') as 'D46',
										(select sum(net_price) from sales_document_item sdi,sales_document sd where sdi.id=sd.id and  datediff(?, invoice_date) > 45 and datediff(?, invoice_date) <= 60 and customer_id=p.customer_id and invoice_status='active') as 'S46',
										(select sum(net_amount) from invoice where datediff(?, invoice_date) > 30 and datediff(?, invoice_date) <= 45 and customer_id=p.customer_id and invoice_status='active') as 'D31',
										(select sum(net_price) from sales_document_item sdi,sales_document sd where sdi.id=sd.id and  datediff(?, invoice_date) > 30 and datediff(?, invoice_date) <= 45 and customer_id=p.customer_id and invoice_status='active') as 'S31',
										(select sum(net_amount) from invoice where datediff(?, invoice_date) > 15 and datediff(?, invoice_date) <= 30 and customer_id=p.customer_id and invoice_status='active') as 'D16',
										(select sum(net_price) from sales_document_item sdi,sales_document sd where sdi.id=sd.id and  datediff(?, invoice_date) > 15 and datediff(?, invoice_date) <= 30 and customer_id=p.customer_id and invoice_status='active') as 'S16',
										(select sum(net_amount) from invoice where datediff(?, invoice_date) > 0 and datediff(?, invoice_date) <= 15 and customer_id=p.customer_id and invoice_status='active') as 'D0',
										(select sum(net_price) from sales_document_item sdi,sales_document sd where sdi.id=sd.id and  datediff(?, invoice_date) > 0 and datediff(?, invoice_date) <= 15 and customer_id=p.customer_id and invoice_status='active') as 'S0',
										(select m.mp_name from marketing_person m where m.mp_id=p.mp_id) as mp_name
										from (select c.customer_id,c.customer_name,c.opening_balance,c.mp_id,c.last_dispatch_date,
										(select sum(net_amount) from invoice  where invoice_status='active' and invoice_date <=? and customer_id=c.customer_id)  as net,
										(select sum(sdi.net_price) from sales_document sd,sales_document_item sdi where sd.id=sdi.id and sd.invoice_status='active' and sd.invoice_date<=? and sd.customer_id=c.customer_id) as snet,
										(select sum(payment_amount) from customer_payment where customer_id=c.customer_id) as payment,
										(select sum(db.net_amount) from debit_credit_note db,invoice i where db.invoice_id=i.id and i.customer_id=c.customer_id and db.date < ?) as credit_note
										from customer c
										where c.customer_status='active' and business_id like if(?=0,'%%',?) and plant_id like if(?=0,'%%',?) and mp_id like if(?=0,'%%',?) and customer_id like if(?=0,'%%',?)
										group by c.customer_id,c.customer_name order by c.customer_name asc) as p) as k   ) as t
										<c:forEach begin="1" end="33">
											<sql:param value="${yest}"/>
										</c:forEach>
										<sql:param value="${param.business_id}"/>
										<sql:param value="${param.business_id}"/>
										<sql:param value="${param.plant_id}"/>
										<sql:param value="${param.plant_id}"/>
										<sql:param value="${param.mp_id}"/>
										<sql:param value="${param.mp_id}"/>
										<sql:param value="${param.customer_id}"/>
										<sql:param value="${param.customer_id}"/>
                 					</sql:query>
                 					</c:catch>
                 					
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
                 					
                 					
									<c:set value="0" var="net_left"/>
									<c:set value="0" var="net_total"/>
									<c:set value="0" var="net_paid"/>
									<c:set value="0" var="day15"/>
									<c:set value="0" var="day30"/>
									<c:set value="0" var="day54"/>
									<c:set value="0" var="day60"/>
									<c:set value="0" var="day75"/>
									<c:set value="0" var="day90"/>
									<c:set value="0" var="day120"/>
									<c:set value="0" var="day120above"/>
									
									
                 					<c:forEach items="${ccustomer.rows}" var="rs">
                 						<c:set value="${((rs.D120-rs.payment-rs.credit_note)>0)?(rs.D120-rs.payment-rs.credit_note):0}" var="D120amount"/>
                 						<c:set value="${((rs.D120-rs.payment-rs.credit_note)>0)?0:-(rs.D120-rs.payment-rs.credit_note)}" var="D120payment"/>
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
	                 					<fmt:formatNumber value="${(rs.net-rs.payment-rs.credit_note)}" var="roundoffff" maxFractionDigits="2" groupingUsed="false"/>
	                 					 <fmt:parseNumber var="roundoffffffff" type="number" value="${roundoffff}" />
	                 					<c:if test="${roundoffffffff!=0}">
                 						<tr>
                 							<td>${rs.customer_name}</td>
                 							<td><fmt:formatNumber value="${rs.net-rs.credit_note}" maxFractionDigits="2" groupingUsed="true"/></td>
                 							<td><fmt:formatNumber value="${rs.payment}" maxFractionDigits="2" groupingUsed="true"/></td>
                 							<td><fmt:formatNumber value="${D0amount}" maxFractionDigits="2" groupingUsed="true"/></td>
                 							<td><fmt:formatNumber value="${D16amount}" maxFractionDigits="2" groupingUsed="true"/></td>
                 							<td><fmt:formatNumber value="${D31amount}" maxFractionDigits="2" groupingUsed="true"/></td>
                 							<td><fmt:formatNumber value="${D46amount}" maxFractionDigits="2" groupingUsed="true"/></td>
                 							<td><fmt:formatNumber value="${D61amount}" maxFractionDigits="2" groupingUsed="true"/></td>
                 							<td><fmt:formatNumber value="${D76amount}" maxFractionDigits="2" groupingUsed="true"/></td>
                 							<td><fmt:formatNumber value="${D91amount}" maxFractionDigits="2" groupingUsed="true"/> </td>
                 							<td><fmt:formatNumber value="${D120amount}" maxFractionDigits="2" groupingUsed="true"/></td>
                 							<td><fmt:formatNumber value="${rs.net-rs.payment-rs.credit_note}" maxFractionDigits="2" groupingUsed="true"/></td>
                 							<td>${rs.mp_name}</td>
									<td>${(empty rs.last_dispatch)?rs.last_dispatch_date:rs.last_dispatch}</td>

											<c:set value="${(rs.net-rs.payment-rs.credit_note)+net_left}" var="net_left"/>
											<c:set value="${(rs.net-rs.credit_note)+net_total}" var="net_total"/>
											<c:set value="${rs.payment+net_paid}" var="net_paid"/>
											<c:set value="${D0amount+day15}" var="day15"/>
											<c:set value="${D16amount+day30}" var="day30"/>
											<c:set value="${D31amount+day54}" var="day54"/>
											<c:set value="${D46amount+day60}" var="day60"/>
											<c:set value="${D61amount+day75}" var="day75"/>
											<c:set value="${D76amount+day90}" var="day90"/>
											<c:set value="${D91amount+day120}" var="day120"/>
											<c:set value="${D120amount+day120above}" var="day120above"/>
                 						</tr>
                 						</c:if>
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
								<tfoot>
									<tr style="background-color:pink;">
										<td></td>
										<td><fmt:formatNumber value="${net_total}" maxFractionDigits="2" groupingUsed="true"/></td>
										<td><fmt:formatNumber value="${net_paid}" maxFractionDigits="2" groupingUsed="true"/></td>
										<td><fmt:formatNumber value="${day15}" maxFractionDigits="2" groupingUsed="true"/></td>
										<td><fmt:formatNumber value="${day30}" maxFractionDigits="2" groupingUsed="true"/></td>
										<td><fmt:formatNumber value="${day54}" maxFractionDigits="2" groupingUsed="true"/></td>
										<td><fmt:formatNumber value="${day60}" maxFractionDigits="2" groupingUsed="true"/></td>
										<td><fmt:formatNumber value="${day75}" maxFractionDigits="2" groupingUsed="true"/></td>
										<td><fmt:formatNumber value="${day90}" maxFractionDigits="2" groupingUsed="true"/></td>
										<td><fmt:formatNumber value="${day120}" maxFractionDigits="2" groupingUsed="true"/></td>
										<td><fmt:formatNumber value="${day120above}" maxFractionDigits="2" groupingUsed="true"/></td>
										<td><fmt:formatNumber value="${net_left}" maxFractionDigits="2" groupingUsed="true"/></td>
										<td></td>
									</tr>
								</tfoot>

                 				</table>
                 				</div>
                 				<div class="col-sm-12 text-center">
                 						
			               				<button class="btn btn-success btn-sm" onclick="generate_excel();">Excel</button>
			               				<button class="btn btn-warning btn-sm" onclick="printData();">Print</button>
			               				<a href="CreditReport.jsp" class="btn btn-danger btn-sm" >Click Report</a>
			               				<a href="AddPayment.jsp" class="btn btn-custom btn-sm" >Add Payment</a>
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
			                								<th class="text-center">Invoice Type</th>
			                							</tr>
			                							
			                							<!-- Get Invoice details here -->
			                							<sql:query var="invoice" dataSource="jdbc/rmc">
			                								SELECT '' as invoice_id,'' as invoice_date,'' as customer_name,'' as product_name,'' as quantity,'' as rate,c.opening_balance as net_amount,'Opening Balance' as type,'' as age,'' as plant_id from customer c where customer_id=?
															UNION 
			                								SELECT s.id as invoice_id,DATE_FORMAT(s.invoice_date,'%d/%m/%Y') as invoice_date,c.customer_name,p.product_name,si.item_quantity as quantity,si.item_price as rate,si.net_price as net_amount,'Sales Document' as type,DATEDIFF(CURRENT_DATE(), s.invoice_date) as age,'' as plant_id FROM sales_document s  left join (`sales_document_item` si,customer c,product p,purchase_order_item poi) on s.id=si.id and c.customer_id=s.customer_id and p.product_id=poi.product_id and si.poi_id=poi.poi_id where c.customer_id=? and s.invoice_date between STR_TO_DATE(?, '%d/%m/%Y') and STR_TO_DATE(?, '%d/%m/%Y') and s.invoice_status='active'
			                								UNION
															select i.invoice_id,DATE_FORMAT(i.invoice_date,'%d/%m/%Y') as invoice_date,c.customer_name,p.product_name,i.quantity,i.rate,i.net_amount,'Invoice' as type,DATEDIFF(CURRENT_DATE(), i.invoice_date) as age,i.plant_id from invoice i,purchase_order_item poi,product p,customer c where i.poi_id=poi.poi_id and poi.product_id=p.product_id and i.customer_id=c.customer_id and i.invoice_status='active' and i.customer_id=? and i.invoice_date between STR_TO_DATE(?, '%d/%m/%Y') and STR_TO_DATE(?, '%d/%m/%Y')
															UNION
															select db.id as invoice_id,DATE_FORMAT(i.invoice_date,'%d/%m/%Y') as invoice_date,c.customer_name,p.product_name,db.quantity,db.approved_rate as rate,(-1*db.net_amount),'Credit Note' as type,DATEDIFF(CURRENT_DATE(), i.invoice_date) as age,'' as plant_id from debit_credit_note db,invoice i,purchase_order_item poi,product p,customer c where  db.invoice_id=i.id and i.poi_id=poi.poi_id and poi.product_id=p.product_id and i.customer_id=c.customer_id  and i.invoice_status='active' and i.customer_id=?
															order by invoice_date asc
			                								<sql:param value="${param.customer_id}"/>
			                								<sql:param value="${param.customer_id}"/>
			                								<sql:param value="${param.from_date}"/>
			                								<sql:param value="${param.to_date}"/>
			                								<sql:param value="${param.customer_id}"/>
			                								<sql:param value="${param.from_date}"/>
			                								<sql:param value="${param.to_date}"/>
			                								<sql:param value="${param.customer_id}"/>
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
				                								<td style="width:5%;" class="text-center">${in.type}</td>
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
			               						<td colspan="2" class="text-right">Total : </td>
			               						<td class="text-right">${tsum}</td>
			               						<td class="text-right">${nsum}</td>
			               						<td class="text-right"></td>
			               						<td colspan="2" class="text-right">Total Payment : </td>
			               						<td class="text-left">${psum}</td>
			               						<td class="text-right" colspan="2">Total Outstanding : </td>
			               						<td class="text-left">${nsum-psum}</td>
			               					</tr>
			               				</table>
			               				
			               			</div>
			               			<div class="col-sm-12 text-center">
			               				<button class="btn btn-success btn-sm hide" onclick="generate_excel();">Generate Report</button>
			               				<button class="btn btn-success btn-sm" onclick="generate_excel();">Excel</button>
			               				<button class="btn btn-warning btn-sm" onclick="printData();">Print</button>
			               				<a href="CreditReport.jsp" class="btn btn-danger btn-sm" >Clear Report</a>
			               				<a href="AddPayment.jsp" class="btn btn-custom btn-sm" >Add Payment</a>
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
		<script type="text/javascript" src="js/CreditReport.js"></script>
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
				}).next().on(ace.click_event, function(){
					$(this).prev().focus();
				});
			});
		</script>
   
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
					$('.mar').hide();
					$('.mar').prop('disabled',true);
				}
				else if(report_type=='cusgbmd'){
					$('.cus-date').hide();
					$('.cus-date').prop('disabled',true);
					$('.mar').hide();
					$('.mar').prop('disabled',true);
				}else if(report_type=='cmw'){
					$('.cus-date').hide();
					$('.cus-date').prop('disabled',true);
					$('.mar').show();
					$('.mar').prop('disabled',false);
				}
				else{
					$('.cus-date').show();
					$('.cus-date').prop('disabled',false);
					$('.mar').hide();
					$('.mar').prop('disabled',true);
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
	        var business_id=$('#business_id').val(); 
	        if(report_type=='cus'){
	        	var customer_id=$('#customer_id').val();
	        	window.location="CreditReport.jsp?action=generateReport&report_type="+report_type+"&customer_id="+customer_id;
	        }else if(report_type=='cmw'){
	        	var from_date=$('.from_date').val();
	        	var to_date=$('.to_date').val();
	        	var customer_id=$('#customer_id').val();
	        	var mp_id=$('#mp_id').val();
	        	var plant_id=$('#plant_id').val();
	        	window.location="CreditReport.jsp?action=generateReport&business_id="+business_id+"&report_type="+report_type+"&from_date="+from_date+"&to_date="+to_date+"&customer_id="+customer_id+'&plant_id='+plant_id+'&mp_id='+mp_id;
	        } else{
	        	var from_date=$('.from_date').val();
	        	var to_date=$('.to_date').val();
	        	var customer_id=$('#customer_id').val();
	        	window.location="CreditReport.jsp?action=generateReport&business_id="+business_id+"&report_type="+report_type+"&from_date="+from_date+"&to_date="+to_date+"&customer_id="+customer_id;
	        }
	    });
    </script>
    <script type="text/javascript">
    	$(document).ready(function(){
    		$('#mp_id').on('change',function(){
    			var mp_id=$('#mp_id').val();
    			fetch('PaymentController?action=getCustomerByMarketingPerson&mp_id='+mp_id,{
    				method:'post',
    				headers:{
    					"Content-Type":"application/json;charset=utf-8"
    				}
    			}).then(response => response.json())
                  .then(text => {
                		$('#customer_id').empty();
    					$('#customer_id').append('<option value="0" selected >All Customer</option>');
    					$('#select2-customer_id-container').text('All Customer');
    					$.each(text,function(i,v){
    						$('#customer_id').append('<option value="'+v.customer_id+'">'+v.customer_name+'</option>');
    					});
                  });
    		});
    	});
    </script>
    <script type="text/javascript">
	    function print() {
	        var frame = document.getElementsByClassName('result').item(0);
	        var data = frame.innerHTML;
	        var win = window.open('', '', 'height=900,width=500');
	        win.document.write('<style>@page{size:portrait ;}@media print{*{font-size:12px;}  body {zoom: 1.0} table, td, th {border: 1px solid black;} table {width: 100%;border-collapse: collapse;}}</style><html><head><title></title>');
	        win.document.write('</head><body >');
	        win.document.write(data);
	        win.document.write('</body></html>');
	        win.print();
	        win.close();
	        return true;
	    }
    </script>

    
		
    </body>
</html>