<!DOCTYPE html>
<%@ include file="Session.jsp" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
        <meta charset="utf-8" />
        <title>Supplier Credit Report</title>
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
<c:catch var='e'>
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
                                    <li class="breadcrumb-item"><a href="#">Make Payment</a></li>
                                    <li class="breadcrumb-item"><a href="#">Supplier Credit Report</a></li>
                                </ol>
                            </div>
                            <h4 class="page-title">Supplier Credit Report</h4>
                        </div>
                    </div>
                </div>
                 <!-- end row -->
                 
                 <c:choose>
                 	<c:when test="${empty param.action}">
                 		<div class="row">
		                	<div class="col-md-12">
		                		<h2 class="text-info text-center">Supplier Credit Report</h2><hr><br><br>
		                	</div>
		                    <div class="col-md-12">
		                       <form action="#" id="myform" method="post">
		                          <div class="row">
		                          	<div class="col-sm-3"></div>
		                          	<div class="col-sm-6">
		                               <div class="col-sm-12">
		                               	 <div  style="display: ${(bean.business_id==0)?'block':'none'}">
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
		                                   <div class="form-group">
		                                       <label>Report type<span class="text-danger">*</span></label>
		                                       <select class="select2" name="type" id="type">
		                                       	   <option value="sup">Supplier Report</option>
		                                           <option value="supday">Day wise Supplier Report</option>
		                                          
		                                       </select>
		                                   </div>
		                                   
		                                    <div class="form-group">
		                                       <label>Supplier<span class="text-danger">*</span></label>
		                                       <select class="select2" name="supplier_id" id="supplier_id" >
		                                       </select>
		                                   </div>
		                               </div>
		                          	</div> 	
		                          </div>
		                           
		                          <div class="text-center m-t-20">
		                               <button type="submit" class="btn btn-primary btn-lg m-r-10 save-button">Generate Report</button>
		                               <a class="btn btn-danger btn-lg" href="SupplierCreditReport.jsp">Clear Report</a>
		                          </div>
		                       </form>
		                    </div>
		                </div>
                 	</c:when>
                 	
                 	<c:when test="${param.report_type=='supday'}">
                 				<div class="tableFixHead">
                 				<table class="table table-bordered table-hover table-dondensed printMe" id="example-2">
                 					<jsp:useBean id="today" class="java.util.Date"/>
                 					<fmt:formatDate var="mydate" value="${today}" pattern="dd-MM-yyyy" />
                 					<tr>
                 						<th colspan="13" class="text-center">Account Payable statement ${mydate}</th>
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
                 					
                 					</tr>
                 					
                 					<sql:query var="ccustomer" dataSource="jdbc/rmc">
                 						select t.supplier_id,t.supplier_name,(t.net+t.enet+t.opening_balance) as net,t.total_tds,t.payment,(IF(t.D120 IS NULL,0,t.D120)+opening_balance) as D120,
										IF(t.D91 IS NULL,0,t.D91)+IF(t.E91 IS NULL,0,t.E91) as D91,
										IF(t.D76 IS NULL,0,t.D76)+IF(t.E76 IS NULL,0,t.E76) as D76,
										IF(t.D61 IS NULL,0,t.D61)+IF(t.E61 IS NULL,0,t.E61) as D61,
										IF(t.D46 IS NULL,0,t.D46)+IF(t.E46 IS NULL,0,t.E46) as D46,
										IF(t.D31 IS NULL,0,t.D31)+IF(t.E31 IS NULL,0,t.E31) as D31,
										IF(t.D16 IS NULL,0,t.D16)+IF(t.E16 IS NULL,0,t.E16) as D16,
										IF(t.D0 IS NULL,0,t.D0)+IF(t.E0 IS NULL,0,t.E0) as D0 FROM 
										(select k.* from (select p.supplier_id,p.supplier_name,(select sum(pv.tds_amount) from purchase_voucher pv where pv.supplier_id=p.supplier_id  and pv.voucher_status='active') as total_tds,if(p.payment is null,0,p.payment) as payment,if(p.net is null,0,p.net) as net,if(p.enet is null,0,p.enet) as enet,p.opening_balance,
										(SELECT sum(pvi.net_amount) from purchase_voucher_item pvi left join purchase_voucher pv on pv.purchase_voucher_id=pvi.purchase_voucher_id where pv.supplier_id=p.supplier_id and datediff(now(), pv.purchase_date) > 120 and pv.voucher_status='active') as 'D120',
										(SELECT sum(pvi.net_amount) from expense_voucher_item pvi left join expense_voucher pv on pv.expense_voucher_id=pvi.expense_voucher_id where pv.supplier_id=p.supplier_id and datediff(now(), pv.bill_date) > 120 and pv.voucher_status='active') as 'E120',
										(SELECT sum(pvi.net_amount) from purchase_voucher_item pvi left join purchase_voucher pv on pv.purchase_voucher_id=pvi.purchase_voucher_id where pv.supplier_id=p.supplier_id and datediff(now(), pv.purchase_date) > 90 and datediff(now(), pv.purchase_date) <= 120 and pv.voucher_status='active') as 'D91',
										(SELECT sum(pvi.net_amount) from expense_voucher_item pvi left join expense_voucher pv on pv.expense_voucher_id=pvi.expense_voucher_id where pv.supplier_id=p.supplier_id and datediff(now(), pv.bill_date) > 90 and datediff(now(), pv.bill_date) <= 120 and pv.voucher_status='active') as 'E91',
										(SELECT sum(pvi.net_amount) from purchase_voucher_item pvi left join purchase_voucher pv on pv.purchase_voucher_id=pvi.purchase_voucher_id where pv.supplier_id=p.supplier_id and datediff(now(), pv.purchase_date) > 75 and datediff(now(), pv.purchase_date) <= 90 and pv.voucher_status='active') as 'D76',
										(SELECT sum(pvi.net_amount) from expense_voucher_item pvi left join expense_voucher pv on pv.expense_voucher_id=pvi.expense_voucher_id where pv.supplier_id=p.supplier_id and datediff(now(), pv.bill_date) > 75 and datediff(now(), pv.bill_date) <= 90 and pv.voucher_status='active') as 'E76',
										(SELECT sum(pvi.net_amount) from purchase_voucher_item pvi left join purchase_voucher pv on pv.purchase_voucher_id=pvi.purchase_voucher_id where pv.supplier_id=p.supplier_id and datediff(now(), pv.purchase_date) > 60 and datediff(now(), pv.purchase_date) <= 75 and pv.voucher_status='active') as 'D61',
										(SELECT sum(pvi.net_amount) from expense_voucher_item pvi left join expense_voucher pv on pv.expense_voucher_id=pvi.expense_voucher_id where pv.supplier_id=p.supplier_id and datediff(now(), pv.bill_date) > 60 and datediff(now(), pv.bill_date) <= 75 and pv.voucher_status='active') as 'E61',
										(SELECT sum(pvi.net_amount) from purchase_voucher_item pvi left join purchase_voucher pv on pv.purchase_voucher_id=pvi.purchase_voucher_id where pv.supplier_id=p.supplier_id and datediff(now(), pv.purchase_date) > 45 and datediff(now(), pv.purchase_date) <= 60 and pv.voucher_status='active') as 'D46',
										(SELECT sum(pvi.net_amount) from expense_voucher_item pvi left join expense_voucher pv on pv.expense_voucher_id=pvi.expense_voucher_id where pv.supplier_id=p.supplier_id and datediff(now(), pv.bill_date) > 45 and datediff(now(), pv.bill_date) <= 60 and pv.voucher_status='active') as 'E46',
										(SELECT sum(pvi.net_amount) from purchase_voucher_item pvi left join purchase_voucher pv on pv.purchase_voucher_id=pvi.purchase_voucher_id where pv.supplier_id=p.supplier_id and datediff(now(), pv.purchase_date) > 30 and datediff(now(), pv.purchase_date) <= 45 and pv.voucher_status='active') as 'D31',
										(SELECT sum(pvi.net_amount) from expense_voucher_item pvi left join expense_voucher pv on pv.expense_voucher_id=pvi.expense_voucher_id where pv.supplier_id=p.supplier_id and datediff(now(), pv.bill_date) > 30 and datediff(now(), pv.bill_date) <= 45 and pv.voucher_status='active') as 'E31',
										(SELECT sum(pvi.net_amount) from purchase_voucher_item pvi left join purchase_voucher pv on pv.purchase_voucher_id=pvi.purchase_voucher_id where pv.supplier_id=p.supplier_id and datediff(now(), pv.purchase_date) > 15 and datediff(now(), pv.purchase_date) <= 30 and pv.voucher_status='active') as 'D16',
										(SELECT sum(pvi.net_amount) from expense_voucher_item pvi left join expense_voucher pv on pv.expense_voucher_id=pvi.expense_voucher_id where pv.supplier_id=p.supplier_id and datediff(now(), pv.bill_date) > 15 and datediff(now(), pv.bill_date) <= 30 and pv.voucher_status='active') as 'E16',
										(SELECT sum(pvi.net_amount) from purchase_voucher_item pvi left join purchase_voucher pv on pv.purchase_voucher_id=pvi.purchase_voucher_id where pv.supplier_id=p.supplier_id and datediff(now(), pv.purchase_date) >= 0 and datediff(now(), pv.purchase_date) <= 15 and pv.voucher_status='active') as 'D0',
										(SELECT sum(pvi.net_amount) from expense_voucher_item pvi left join expense_voucher pv on pv.expense_voucher_id=pvi.expense_voucher_id where pv.supplier_id=p.supplier_id and datediff(now(), pv.bill_date) >= 0 and datediff(now(), pv.bill_date) <= 15 and pv.voucher_status='active') as 'E0'
										from (select c.supplier_id,c.supplier_name,c.opening_balance,
										(select sum(pvi.net_amount) from purchase_voucher pv,purchase_voucher_item pvi where pv.purchase_voucher_id=pvi.purchase_voucher_id and pv.supplier_id=c.supplier_id and pv.voucher_status='active') as net,
										(select sum(evi.net_amount) from expense_voucher ev,expense_voucher_item evi where ev.expense_voucher_id=evi.expense_voucher_id and ev.supplier_id=c.supplier_id and ev.voucher_status='active') as enet,
										(select sum(payment_amount) from make_payment where supplier_id=c.supplier_id) as payment
										from supplier c
										where  c.business_id like if(?=0,'%%',?) and c.supplier_status='active'
										order by c.supplier_name asc) as p) as k) as t
										<sql:param value="${param.business_id}"/>
										<sql:param value="${param.business_id}"/>
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
	                 					<c:if test="${(rs.net-rs.total_tds-rs.payment)>1}">
                 						<tr>
                 							<td>${rs.supplier_name}</td>
                 							<td><fmt:formatNumber value="${rs.net-rs.total_tds}" maxFractionDigits="2" groupingUsed="false"/></td>
                 							<td><fmt:formatNumber value="${rs.payment}" maxFractionDigits="2" groupingUsed="false"/></td>
                 							<td><fmt:formatNumber value="${D0amount}" maxFractionDigits="2" groupingUsed="false"/></td>
                 							<td><fmt:formatNumber value="${D16amount}" maxFractionDigits="2" groupingUsed="false"/></td>
                 							<td><fmt:formatNumber value="${D31amount}" maxFractionDigits="2" groupingUsed="false"/></td>
                 							<td><fmt:formatNumber value="${D46amount}" maxFractionDigits="2" groupingUsed="false"/></td>
                 							<td><fmt:formatNumber value="${D61amount}" maxFractionDigits="2" groupingUsed="false"/></td>
                 							<td><fmt:formatNumber value="${D76amount}" maxFractionDigits="2" groupingUsed="false"/></td>
                 							<td><fmt:formatNumber value="${D91amount}" maxFractionDigits="2" groupingUsed="false"/> </td>
                 							<td><fmt:formatNumber value="${D120amount}" maxFractionDigits="2" groupingUsed="false"/></td>
                 							<td><fmt:formatNumber value="${rs.net-rs.total_tds-rs.payment}" maxFractionDigits="2" groupingUsed="false"/></td>
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
			               				<a href="SupplierCreditReport.jsp" class="btn btn-danger btn-sm" >Click Report</a>
			               		</div>
                 			</c:when>
                 			
                 	<c:otherwise>
                 		<!-- Get customer details here -->
	               		<sql:query var="supplier" dataSource="jdbc/rmc">
	               			select * from supplier where supplier_id=?
	               			<sql:param value="${param.supplier_id}"/>
	               		</sql:query>
	               		<c:forEach var="supplier" items="${supplier.rows}">
	               			<c:set value="${supplier}" var="sup"/>
	               		</c:forEach>
	               		
	               		<div class="row">
	               			<div class="col-sm-12" id="mydiv">
	               				<table class="table table-bordered table-hover table-condensed printMe" id="example-2">
	               					<tr>
	               						<th colspan="12" style="background-color: #0c699b;color: white;" class="text-center">
	               							<h3>${initParam.company_name}</h3>
	               							<p>${initParam.company_address}</p>
	               						</th>
	               					</tr>
	               					<tr>
	               						<th colspan="12" style="background-color: #0c699b;color: white;" class="text-center">
	               							Statement Of Account : Supplier &nbsp;&nbsp;&nbsp;&nbsp; Name :${sup.supplier_name}
	               						</th>
	               					</tr>
	               					<tr>
	               						<th colspan="6" style="background-color: #0c699b;color: white;" class="text-center">
	               							Invoice Details
	               						</th>
	               						<th colspan="3" style="background-color: #0c699b;color: white;" class="text-center">
	               							Payment Details
	               						</th>
	               						<th colspan="3" style="background-color: #0c699b;color: white;" class="text-center">
	               							Age Details
	               						</th>
	               					</tr>
	               					<tr>
	               						<td colspan="6" style="width:50%;">
	               							<table class="table table-bordered table-condensed">
	                							<tr style="background-color: #5b1f59;color: white;">
	                								<th class="text-center">Bill No</th>
	                								<th class="text-center">Voucher Date</th>
	                								<td>
	                									<table class="table">
	                										<tr style="background-color: #5b1f59;color: white;">
				                								<td class="text-center">Item Name</td>
				                								<td class="text-center">Quantity</td>
				                								<td class="text-center">Rate</td>
				                								<td class="text-center">Net Amount</td>
	                										</tr>
	                									</table>
	                								</td>
	                								<th>TDS Amnt.</th>
	                								<th>Total Amount</th>
	                							</tr>
	                							
	                							<sql:query var="opening" dataSource="jdbc/rmc">
	                								select opening_balance from supplier where supplier_id=?
	                								<sql:param value="${param.supplier_id}"/>
	                							</sql:query>
	                							<c:forEach items="${opening.rows}" var="opening">
	                								<c:set value="${opening.opening_balance}" var="opening_bal"/>
	                							</c:forEach>
	                							
	                							<!-- Get Invoice details here -->
	                							<sql:query var="invoice" dataSource="jdbc/rmc">
	                								select t.* from (select p.bill_no,DATE_FORMAT(p.purchase_date,'%d/%m/%Y') as realdate,'Pur' as type,p.purchase_date as dt,
	                								p.purchase_voucher_id,p.tds_amount,DATEDIFF(CURRENT_DATE(), p.purchase_date) as age,
	                								sum(pvi.net_amount) as net_amount from purchase_voucher p,purchase_voucher_item pvi
	                								where p.purchase_voucher_id=pvi.purchase_voucher_id 
	                								and p.supplier_id=?
	                								and p.voucher_status='active'
													group by p.purchase_voucher_id
													
													UNION ALL
													
													select p.bill_no,DATE_FORMAT(p.bill_date,'%d/%m/%Y') as realdate,'Exp' as type,p.bill_date as dt,
	                								p.expense_voucher_id as purchase_voucher_id,p.tds_amount,DATEDIFF(CURRENT_DATE(), p.bill_date) as age,
	                								sum(pvi.net_amount) as net_amount from expense_voucher p,expense_voucher_item pvi
	                								where p.expense_voucher_id=pvi.expense_voucher_id 
	                								and p.supplier_id=?
	                								and p.voucher_status='active' group by p.expense_voucher_id) as t
	                								order by t.dt asc
	                								<sql:param value="${param.supplier_id}"/>
	                								<sql:param value="${param.supplier_id}"/>
	                							</sql:query>
	                							<c:set value="${invoice.rows}" var="inv"/>
	                							<c:set value="0" var="tsum"/>
	                							<c:set value="${opening_bal}" var="nsum"/>
	                								<tr>
	                									<td colspan="4" class="text-right">Opening Balance</td>	
	                									<td><fmt:formatNumber value="${opening_bal}" maxFractionDigits="2" groupingUsed="false"/></td>
	                								</tr>
	                							<c:forEach items="${inv}" var="in">
		                							<tr>
		                								<td style="width:4%;" class="text-center">${in.bill_no}</td>
		                								<td style="width:3%;" class="text-center">${in.realdate}</td>
				                						<c:choose>
				                							<c:when test="${in.type=='Pur'}">
				                								<sql:query var="pvi" dataSource="jdbc/rmc">
					                								select pvi.item_name,pvi.item_quantity,pvi.item_price,round(pvi.net_amount,2) as net_amount from purchase_voucher_item pvi
					                								where pvi.purchase_voucher_id = ?
					                								<sql:param value="${in.purchase_voucher_id}"/>
					                							</sql:query>
				                							</c:when>
				                							<c:otherwise>
				                								<sql:query var="pvi" dataSource="jdbc/rmc">
					                								select pvi.item_name,pvi.item_quantity,pvi.item_price,round(pvi.net_amount,2) as net_amount from expense_voucher_item pvi
					                								where pvi.expense_voucher_id = ?
					                								<sql:param value="${in.purchase_voucher_id}"/>
					                							</sql:query>
				                							</c:otherwise>
				                						</c:choose>
			                							<td style="width:60%;"><table class="table">
			                							<c:forEach items="${pvi.rows}" var="pvi">
			                								<tr>
				                								<td style="width:15%;"  class="text-center">${pvi.item_name}</td>
				                								<c:set value="${pvi.item_quantity+tsum}" var="tsum"/>
				                								<td style="width:5%;" class="text-center">${pvi.item_quantity}</td>
				                								<td style="width:6%;" class="text-center">${pvi.item_price}</td>
				                								<td style="width:6%;" class="text-center">${pvi.net_amount}</td>
				                							</tr>
				                						</c:forEach>
		                					</table>	</td>
		                								<td>${in.tds_amount}</td>
		                								<td>${in.net_amount-in.tds_amount}</td>
		                								<c:set value="${in.net_amount-in.tds_amount+nsum}" var="nsum"/>
		                							</tr>	
		                						</c:forEach>
	                						</table>
	               						</td>
	               						
	               						<!-- get payment details here -->
	               						<sql:query var="payment" dataSource="jdbc/rmc">
	               							select * from make_payment where supplier_id=?
	               							<sql:param value="${param.supplier_id}"/>
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
	               							select sum(payment_amount) as paysum from make_payment where supplier_id=?
	               							<sql:param value="${param.supplier_id}"/>
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
											<tr>
	                									<td>${today}</td>
	                									<td>0</td>
	                									<td><fmt:formatNumber value="${(opening_bal-paysum>0)?opening_bal-paysum:0}" maxFractionDigits="2" groupingUsed="false"/></td>
	                								</tr>
												<c:set value="${(paysum-opening_bal>0)?paysum-opening_bal:0}" var="paysum"/>
																						
	                							<c:forEach items="${inv}" var="in">
	                								<tr>
	                									<td>${today}</td>
	                									<td>${in.age} </td>
	                									<td><fmt:formatNumber value="${(in.net_amount-in.tds_amount-paysum>0)?in.net_amount-in.tds_amount-paysum:0}" maxFractionDigits="2" groupingUsed="false"/></td>
	                								</tr>
	                								<c:set value="${(paysum-in.net_amount-in.tds_amount>0)?paysum-in.net_amount-in.tds_amount:0}" var="paysum"/>
	                							</c:forEach>	
	                						</table>
	               						</td>
	               					</tr>
	               					<tr style="background-color: #30665f;color: white;" >
	               						<td></td>
	               						<td colspan="2" class="text-right">Total Quantity : </td>
	               						<td class="text-left">${tsum}</td>
	               						<td class="text-right">Total Amount : </td>
	               						<td class="text-left"><fmt:formatNumber value="${nsum}" maxFractionDigits="2" groupingUsed="true"/></td>
	               						<td colspan="2" class="text-right">Total Payment : </td>
	               						<td class="text-left"><fmt:formatNumber value="${psum}" maxFractionDigits="2" groupingUsed="true"/></td>
	               						<td class="text-right" colspan="2">Total Outstanding : </td>
	               						<td class="text-left"><fmt:formatNumber maxFractionDigits="2" value="${nsum-psum}" groupingUsed="true" /></td>
	               					</tr>
	               				</table>
	               			</div>
	               			<div class="col-sm-12 text-center">
	               				<button class="btn btn-success btn-sm" onclick="generate_excel();">Excel</button>
	               				<button class="btn btn-warning btn-sm" onclick="print();">Print</button>
	               				<a href="SupplierCreditReport.jsp" class="btn btn-danger btn-sm" >Clear Report</a>
	               			</div>
	               		</div>
                 	</c:otherwise>                 </c:choose>
               	<br><br>
                <!-- end row -->
            </div> <!-- end container -->
        </div>
        
</c:catch>
                 			${e}
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
		<script type="text/javascript">
	    $("form").submit(function(e){
	        e.preventDefault();
	        var report_type=$('#type').val();
	       	var supplier_id=$('#supplier_id').val();
	       	var business_id=$('#business_id').val();
	       	window.location="SupplierCreditReport.jsp?action=generateReport&report_type="+report_type+"&supplier_id="+supplier_id+"&business_id="+business_id;
	    });
    </script>
    
    <script type="text/javascript">
    	$(document).ready(function(){
    		$('.no-date').prop('disabled',true);
    		$('.no-date').hide();
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
    		
    		
    		var getSupplierListByBusinessGroup=function(business_id){
    			if(business_id!=undefined && !isNaN(business_id)){
    				$.ajax({
        				type:'post',
        				url:'SupplierController?action=getSupplierListByBusinessGroup&business_id='+business_id,
        				headers:{
        					Accept:"application/json;charset=utf-8",
        					"Content-Type":"application/json;charset=utf-8"
        				},
        				success:function(res){
        					$('#supplier_id').empty();
        					$('#supplier_id').append('<option value="0" selected >All Supplier</option>');
        					$('#select2-supplier_id-container').text('All Supplier');
        					$.each(res,function(i,v){
        						$('#supplier_id').append('<option value="'+v.supplier_id+'">'+v.supplier_name+'</option>');
        					});
        					
        				}
        			});
    			}
    		}
    		
    		
    		var business_id=$('#business_id').val();
    		getSupplierListByBusinessGroup(business_id);
    		
    		$('#business_id').on('change',function(){
    			var business_id=$('#business_id').val();
    			getSupplierListByBusinessGroup(business_id);
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
        var frame = document.getElementsByClassName('printMe').item(0);
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
    
		
    </body>
</html>