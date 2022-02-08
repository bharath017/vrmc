<!DOCTYPE html>
<%@ include file="Session.jsp" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
        <meta charset="utf-8" />
        <title>Overall Report</title>
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
        	
        	.yelloth{
        		background-color: #e2bb46;
        	}
        	.blueth{
        		background-color: #6d95d6;
        	}
        	.pinktd{
        		background-color: #d66493;
        	}
        	
        	.deepblue{
        		background-color: #6d43e0;
        		color: white;
        	}
        	
        	.table>thead>tr>th,.table>tbody>tr>th,.table>tfoot>tr>th,.table>thead>tr>td,.table>tbody>tr>td,.table>tfoot>tr>td{
        		padding: 2px;
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
                                    <li class="breadcrumb-item"><a href="#">Billing</a></li>
                                    <li class="breadcrumb-item"><a href="#">Report</a></li>
                                    <li class="breadcrumb-item"><a href="#">Production Report</a></li>
                                </ol>
                            </div>
                            <h4 class="page-title">Overall Credit Report</h4>
                        </div>
                    </div>
                </div>
                
                <!-- end row -->
                <div class="row">
                	<div class="col-md-12">
                		<h2 class="text-info text-center">Overall Credit Report : <b>${(empty param.type || param.type=='total')?'Total':param.mp_name}</b></h2><hr>
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
                                       <select class="form-control" name="business_id" id="business_id" required="required">
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
                                           <option value="total" ${(param.report_type=='total')?'selected':''}>Total</option>
                                           <option value="mp" ${(param.report_type=='mp')?'selected':''}>Marketing Person Wise</option>
                                           <%-- <option value="date" ${(param.report_type=='date')?'selected':''}>Date Wise</option> --%>
                                           <%-- <option value="mpdate" ${(param.report_type=='mpdate')?'selected':''}>Marketing Person with date Wise</option> --%>
                                       </select>
                                   </div>
                               </div>
                                <div class="col-sm-12 mp no-date mpdate">
                                   <div class="form-group">
                                       <label>Marketing Person <span class="text-danger">*</span></label>
                                       <sql:query var="mp" dataSource="jdbc/rmc">
                                       		select * from marketing_person
                                       </sql:query>
                                       <select class="select2 mp no-date mpdate" name="mp_id" id="mp_id" required="required">
                                       		<c:forEach items="${mp.rows}" var="mp">
												<option value="${mp.mp_id}">${mp.mp_name}</option>                                       			
                                       		</c:forEach>
                                       </select>
                                   </div>
                               </div>
                               <div class="col-sm-12 no-mp date mpdate">
                                  <div class="form-group">
                                      <label>From Date<span class="text-danger">*</span></label>
                                      <div class="input-group">
                                          <input type="text" name="from_date" value="${param.from_date}" 
                                          		 class="form-control date-picker from_date no-mp date mpdate"
                                          	     required="required" placeholder="dd/mm/yyyy" id="id-date-picker-1"
                                          	     data-date-format="dd/mm/yyyy"
                                          	     readonly="readonly" style="background-color: white;"/>
                                          	<div class="input-group-append picker">
                                               <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
                                            </div>
                                      </div>
                                  </div>
                                </div>
                                
                                <div class="col-sm-12 no-mp date mpdate">
                                  <div class="form-group">
                                      <label>To Date<span class="text-danger">*</span></label>
                                      <div class="input-group">
                                          <input type="text" name="to_date" value="${param.to_date}"
                                          		 class="form-control date-picker to_date no-mp date mpdate"
                                          		 required="required" placeholder="dd/mm/yyyy" id="id-date-picker-1"
                                          		 data-date-format="dd/mm/yyyy"
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
                               <a class="btn btn-danger btn-lg" href="OverallReport.jsp">Clear Report</a>
                          </div>
                       </form>
                	</div>
                	<c:choose>
                	<c:when test="${param.report_type=='total'}">
                    <div class="col-md-12">
                       	<sql:query var="cus" dataSource="jdbc/rmc">
                       		select p.* from (select t.customer_id,t.customer_name,if(t.net_amount is null,0,t.net_amount) as net_amount,if(t.net_sales is null,0,net_sales) as net_sales,
                       		if(t.net_paid is null,0,t.net_paid) as net_paid from (select c.customer_id,c.customer_name,
                       		(select sum(net_amount) from invoice where customer_id=c.customer_id and invoice_status='active') as net_amount,
                       		(select sum(payment_amount) from customer_payment where customer_id=c.customer_id) as net_paid,
                       		(select sum(sdi.net_price) from sales_document sd,sales_document_item sdi where sd.id=sdi.id and sd.customer_id=c.customer_id and sd.invoice_status='active') as net_sales
                       	    from customer c
                       	    where c.business_id like if(?=0,'%%',?)) as t) as p where ((p.net_amount+p.net_sales)-p.net_paid)>100;
                       		<sql:param value="${param.business_id}"/>
                       		<sql:param value="${param.business_id}"/>
                       	</sql:query>
                       	
                       	<table class="table table-bordered table-condensed" id="example-2">
                       		<thead>
                       			<tr class="yelloth">
                       				<th>Date</th>
                       				<th>Party Name</th>	
                       				<th>Grade</th>
                       				<th>Quantity</th>
                       				<th>Rate Per M<sup>3</sup></th>
                       				<th>Total Amount</th>
                       				<th>Received Amount</th>
                       				<th>Pending Amount</th>
                       				<th></th>
                       				<th>Due On</th>
                       				<th>Overdue By Days</th>
                       			</tr>
                       		</thead>
                       		
                       		<tbody>
                       			<c:set value="0" var="overall_sum"/>
                       			<c:forEach items="${cus.rows}" var="cus">
                       				<tr class="blueth">
                       					<th colspan="8">${cus.customer_name}</th>
                       					<th></th>
                       					<th></th>
                       					<th></th>
                       				</tr>
                       				<c:catch var="e">
                       				<sql:query var="payment" dataSource="jdbc/rmc">
                       					select t.* from (
                       					
                       					(select '' as date,'' as reeldate,'' as site_name,'Opening Balance' as product_name,0 as net_quantity,0 as rate,c.opening_balance as total_amount,'' as paid_amount,'' as age,'' as payment_type
                       					from customer c
                       					where customer_id=?)
                       					
                       					UNION ALL 
                       					
                       					(select DATE_FORMAT(i.invoice_date,'%d/%m/%Y') as date,i.invoice_date as reeldate,s.site_address as site_name,p.product_name as product_name,sum(i.quantity) as net_quantity,
                       					i.rate,sum(net_amount) as total_amount,'' as paid_amount,DATEDIFF(CURRENT_DATE(), i.invoice_date) as age,'' as payment_type
										from invoice i LEFT JOIN (site_detail s,product p,purchase_order_item poi)
										ON i.site_id=s.site_id
										and i.poi_id=poi.poi_id
										and poi.product_id=p.product_id
										where i.customer_id=?
										and i.invoice_status='active'
										group by s.site_address,p.product_name,i.rate,i.invoice_date
										
										)
										
										UNION ALL
										
										(select DATE_FORMAT(sd.invoice_date,'%d/%m/%Y') as date,sd.invoice_date as reeldate,s.site_address  as site_name,p.product_name,sum(sdi.item_quantity) as net_quantity,
										sdi.item_price as rate,sum(net_price) as total_amount,'' as paid_amount,DATEDIFF(CURRENT_DATE(), sd.invoice_date) as age,'' as payment_type
										from sales_document_item sdi LEFT JOIN (sales_document sd,site_detail s,purchase_order_item poi,product p)
										ON sdi.id=sd.id
										and sd.site_id=s.site_id
										and sdi.poi_id=poi.poi_id
										and poi.product_id=p.product_id
										where sd.customer_id=?
										and sd.invoice_status='active'
										group by s.site_address,p.product_name,sdi.item_price,sd.invoice_date
										)
										
										UNION ALL
										
										(select DATE_FORMAT(payment_date,'%d/%m/%Y') as date,payment_date as reeldate,'' as site_name,
										'' as product_name,0 as net_quantity,0 as rate,0 as total_amount,payment_amount as paid_amount,'' as age,payment_mode as payment_type
										 from customer_payment where customer_id=?)) as t order by t.reeldate asc
										<sql:param value="${cus.customer_id}"/>
										<sql:param value="${cus.customer_id}"/>
										<sql:param value="${cus.customer_id}"/>
										<sql:param value="${cus.customer_id}"/>
                       				</sql:query>
                       				</c:catch>
                       				${e}
                       				<c:set value="0" var="total_amount_detail"/>
                       				<c:set value="0" var="total_paid_detail"/>
                       				<c:set value="0" var="total_quantity"/>
                       				<c:forEach items="${payment.rows}" var="payment">
                       					<c:set value="${payment.total_amount+total_amount_detail}" var="total_amount_detail"/>
                       					<c:set value="${payment.paid_amount+total_paid_detail}" var="total_paid_detail"/>
                       					<c:set value="${total_quantity+payment.net_quantity}" var="total_quantity"/>
										<tr>
											<td>${payment.date}</td>											
											<td>${(empty payment.site_name)?payment.payment_type:payment.site_name}</td>
											<td>${payment.product_name}</td>
											<td><fmt:formatNumber value="${(payment.net_quantity>0)?payment.net_quantity:''}" maxFractionDigits="2"/></td>
											<td>${(payment.rate>0)?payment.rate:''}</td>
											<td><fmt:formatNumber value="${(payment.total_amount>0 || (payment.total_amount<0))?payment.total_amount:''}" maxFractionDigits="2"/></td>
											<td><fmt:formatNumber value="${payment.paid_amount}" maxFractionDigits="2" groupingUsed="false"/></td>
											<td></td>
											<td></td>
											<td></td>
											<td>${payment.age}</td>
										</tr> 
                       				</c:forEach>
                       					<c:set value="${overall_sum+(total_amount_detail-total_paid_detail)}" var="overall_sum"/>
                       					<tr class="pinktd">
											<td>Total : </td>
											<td></td>
											<td></td>
											<td>${total_quantity}</td>
											<td></td>
											<td><fmt:formatNumber value="${total_amount_detail}" maxFractionDigits="2" groupingUsed="false"/></td>
											<td><fmt:formatNumber value="${total_paid_detail}" maxFractionDigits="2" groupingUsed="false"/></td>
											<td><fmt:formatNumber value="${total_amount_detail-total_paid_detail}" groupingUsed="false" maxFractionDigits="2"/></td>
											<td></td>
											<td></td>
											<td></td>
										</tr>  
                       			</c:forEach>
                       		</tbody>
                       		<tfoot>
                       			<tr class="deepblue">
                       				<th colspan="7">Total Overall Outstanding : </th>
                       				<th><fmt:formatNumber value="${overall_sum}" groupingUsed="false" maxFractionDigits="2"/></th>
                       				<th></th>
                       				<th></th>
                       				<th></th>
                       			</tr>
                       		</tfoot>
                       	</table>
                    </div>
                   </c:when>
                   <c:when test="${param.report_type=='mp'}">
                   	<div class="col-md-12">
                       	<sql:query var="cus" dataSource="jdbc/rmc">
							select q.* from (
								select t.customer_id,t.customer_name,if(t.net_amount is null,0,t.net_amount) as net_amount,
								if(t.net_sales is null,0,t.net_sales) as net_sales,if(t.net_paid is null,0,t.net_paid) as net_paid
									from (
									select c.customer_id,c.customer_name,
									(select sum(i.net_amount) from invoice i where i.customer_id=c.customer_id and i.invoice_status='active') as net_amount,
									(select sum(sdi.net_price) from sales_document sd,sales_document_item sdi where sd.id=sdi.id and sd.customer_id=c.customer_id and sd.invoice_status='active') as net_sales,
									(select sum(payment_amount) from customer_payment p where p.customer_id=c.customer_id) as net_paid
									from customer c
									where c.mp_id=?
									and c.business_id like if(0=?,'%%',?)
								) as t
							) as q where (q.net_amount+q.net_sales)-q.net_paid>0
                       		<sql:param value="${param.mp_id}"/>
                       		<sql:param value="${param.business_id}"/>
                       		<sql:param value="${param.business_id}"/>
                       	</sql:query>
                       	
                       	<table class="table table-bordered table-condensed" id="example-2">
                       		<thead>
                       			<sql:query var="mp" dataSource="jdbc/rmc">
                       				select mp_name
                       				from marketing_person 
                       				where mp_id=?
                       				<sql:param value="${param.mp_id}"/>
                       			</sql:query>
                       			<tr class="yelloth">
                       				<th colspan="11" class="text-center">
                       					<c:forEach items="${mp.rows}" var="mp">
                       						<span style="color:white;"><b>Marketing Overall Report</b><br>Sales Person :  ${mp.mp_name}</span>
                       					</c:forEach>
                       				</th>
                       			</tr>
                       			<tr class="yelloth">
                       				<th>Date</th>
                       				<th>Party Name</th>	
                       				<th>Grade</th>
                       				<th>Quantity</th>
                       				<th>Rate Per M<sup>3</sup></th>
                       				<th>Total Amount</th>
                       				<th>Received Amount</th>
                       				<th>Pending Amount</th>
                       				<th></th>
                       				<th>Due On</th>
                       				<th>Overdue By Days</th>
                       			</tr>
                       		</thead>
                       		
                       		<tbody>
                       			<c:set value="0" var="overall_sum"/>
                       			<c:forEach items="${cus.rows}" var="cus">
                       				<tr class="blueth">
                       					<th colspan="8">${cus.customer_name}</th>
                       					<th></th>
                       					<th></th>
                       					<th></th>
                       				</tr>
                       				<sql:query var="payment" dataSource="jdbc/rmc">
                       					(select DATE_FORMAT(i.invoice_date,'%d/%m/%Y') as date,s.site_address as site_name,p.product_name as product_name,sum(i.quantity) as net_quantity,
                       					i.rate,sum(net_amount) as total_amount,'' as paid_amount,DATEDIFF(CURRENT_DATE(), i.invoice_date) as age,'' as payment_type
										from invoice i LEFT JOIN (site_detail s,product p,purchase_order_item poi,purchase_order po,customer c)
										ON i.site_id=s.site_id 
										and i.poi_id=poi.poi_id
										and poi.order_id=po.order_id
										and poi.product_id=p.product_id
										and i.customer_id=c.customer_id
										where c.mp_id=?
										and i.customer_id=?
										and i.invoice_status='active'
										group by s.site_address,p.product_name,i.rate,i.invoice_date
										order by i.invoice_date asc
										)
										
										UNION ALL
										
										(select DATE_FORMAT(sd.invoice_date,'%d/%m/%Y') as date,s.site_address  as site_name,p.product_name,sum(sdi.item_quantity) as net_quantity,
										sdi.item_price as rate,sum(net_price) as total_amount,'' as paid_amount,DATEDIFF(CURRENT_DATE(), sd.invoice_date) as age,'' as payment_type
										from sales_document_item sdi LEFT JOIN (sales_document sd,site_detail s,purchase_order_item poi,product p,customer c)
										ON sdi.id=sd.id
										and sd.site_id=s.site_id
										and sdi.poi_id=poi.poi_id
										and poi.product_id=p.product_id
										and sd.customer_id=c.customer_id
										where sd.customer_id=?
										and sd.invoice_status='active'
										and c.mp_id=?
										group by s.site_address,p.product_name,sdi.item_price,sd.invoice_date
										order by sd.invoice_date asc)
										
										UNION ALL
										
										(select DATE_FORMAT(payment_date,'%d/%m/%Y') as date,'' as site_name,'' as product_name,0 as net_quantity,0 as rate,0 as total_amount,payment_amount as paid_amount,'' as age,payment_mode as payment_type from customer_payment where customer_id=? order by payment_date asc)
										
										<sql:param value="${param.mp_id}"/>
										<sql:param value="${cus.customer_id}"/>
										<sql:param value="${cus.customer_id}"/>
										<sql:param value="${param.mp_id}"/>
										<sql:param value="${cus.customer_id}"/>
                       				</sql:query>
                       				<c:set value="0" var="total_amount_detail"/>
                       				<c:set value="0" var="total_paid_detail"/>
                       				<c:set value="0" var="total_quantity"/>
                       				<c:forEach items="${payment.rows}" var="payment">
                       					<c:set value="${payment.total_amount+total_amount_detail}" var="total_amount_detail"/>
                       					<c:set value="${payment.paid_amount+total_paid_detail}" var="total_paid_detail"/>
                       					<c:set value="${total_quantity+payment.net_quantity}" var="total_quantity"/>
										<tr>
											<td>${payment.date}</td>											
											<td>${(empty payment.site_name)?payment.payment_type:payment.site_name}</td>
											<td>${payment.product_name}</td>
											<td>${(payment.net_quantity>0)?payment.net_quantity:''}</td>
											<td>${(payment.rate>0)?payment.rate:''}</td>
											<td><fmt:formatNumber value="${(payment.total_amount>0)?payment.total_amount:''}" maxFractionDigits="2" groupingUsed="false"/></td>
											<td><fmt:formatNumber value="${payment.paid_amount}" maxFractionDigits="2" groupingUsed="false"/></td>
											<td></td>
											<td></td>
											<td></td>
											<td>${payment.age}</td>
										</tr> 
                       				</c:forEach>
                       					<c:set value="${overall_sum+(total_amount_detail-total_paid_detail)}" var="overall_sum"/>
                       					<tr class="pinktd">
											<td>Total : </td>
											<td></td>
											<td></td>
											<td><fmt:formatNumber value="${total_quantity}" maxFractionDigits="2" groupingUsed="true"/></td>
											<td></td>
											<td><fmt:formatNumber value="${total_amount_detail}" maxFractionDigits="2" groupingUsed="false"/></td>
											<td><fmt:formatNumber value="${total_paid_detail}" maxFractionDigits="2" groupingUsed="false"/></td>
											<td><fmt:formatNumber value="${total_amount_detail-total_paid_detail}" maxFractionDigits="2" groupingUsed="false"/></td>
											<td></td>
											<td></td>
											<td></td>
										</tr>  
                       			</c:forEach>
                       		</tbody>
                       		<tfoot>
                       			<tr class="deepblue">
                       				<th colspan="7">Total Overall Outstanding : </th>
                       				<th><fmt:formatNumber value="${overall_sum}" maxFractionDigits="2" groupingUsed="false"/></th>
                       				<th></th>
                       				<th></th>
                       				<th></th>
                       			</tr>
                       		</tfoot>
                       	</table>
                    </div>
                   </c:when>
                   
                   <c:when test="${param.report_type=='mpdate'}">
                   	<div class="col-md-12">
                       	<sql:query var="cus" dataSource="jdbc/rmc">
							select q.* from (
								select t.customer_id,t.customer_name,if(t.net_amount is null,0,t.net_amount) as net_amount,
								if(t.net_sales is null,0,t.net_sales) as net_sales,if(t.net_paid is null,0,t.net_paid) as net_paid
									from (
									select c.customer_id,c.customer_name,
									(select sum(i.net_amount) from invoice i where i.customer_id=c.customer_id and i.invoice_status='active') as net_amount,
									(select sum(sdi.net_price) from sales_document sd,sales_document_item sdi where sd.id=sdi.id and sd.customer_id=c.customer_id and sd.invoice_status='active') as net_sales,
									(select sum(payment_amount) from customer_payment p where p.customer_id=c.customer_id) as net_paid
									from customer c
									where c.mp_id=?
									and c.business_id like if(0=?,'%%',?)
								) as t
							) as q where (q.net_amount+q.net_sales)-q.net_paid>0
                       		<sql:param value="${param.mp_id}"/>
                       		<sql:param value="${param.business_id}"/>
                       		<sql:param value="${param.business_id}"/>
                       	</sql:query>
                       	
                       	<table class="table table-bordered table-condensed" id="example-2">
                       		<thead>
                       			<sql:query var="mp" dataSource="jdbc/rmc">
                       				select mp_name
                       				from marketing_person 
                       				where mp_id=?
                       				<sql:param value="${param.mp_id}"/>
                       			</sql:query>
                       			<tr class="yelloth">
                       				<th colspan="11" class="text-center">
                       					<c:forEach items="${mp.rows}" var="mp">
                       						<span style="color:white;"><b>Marketing Date Wise Overall Report</b><br>From Date : ${param.from_date} - To Date : ${param.to_date} &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Sales Person :  ${mp.mp_name}</span>
                       					</c:forEach>
                       				</th>
                       			</tr>
                       			<tr class="yelloth">
                       				<th>Date</th>
                       				<th>Party Name</th>	
                       				<th>Grade</th>
                       				<th>Quantity</th>
                       				<th>Rate Per M<sup>3</sup></th>
                       				<th>Total Amount</th>
                       				<th>Received Amount</th>
                       				<th>Pending Amount</th>
                       				<th></th>
                       				<th>Due On</th>
                       				<th>Overdue By Days</th>
                       			</tr>
                       		</thead>
                       		
                       		<tbody>
                       			<c:set value="0" var="overall_sum"/>
                       			<c:forEach items="${cus.rows}" var="cus">
                       				<tr class="blueth">
                       					<th colspan="8">${cus.customer_name}</th>
                       					<th></th>
                       					<th></th>
                       					<th></th>
                       				</tr>
                       				<sql:query var="payment" dataSource="jdbc/rmc">
                       					(select DATE_FORMAT(i.invoice_date,'%d/%m/%Y') as date,s.site_address as site_name,p.product_name as product_name,sum(i.quantity) as net_quantity,
                       					i.rate,sum(net_amount) as total_amount,'' as paid_amount,DATEDIFF(CURRENT_DATE(), i.invoice_date) as age,'' as payment_type
										from invoice i LEFT JOIN (site_detail s,product p,purchase_order_item poi,purchase_order po,customer c)
										ON i.site_id=s.site_id 
										and i.poi_id=poi.poi_id
										and poi.order_id=po.order_id
										and poi.product_id=p.product_id
										and i.customer_id=c.customer_id
										where c.mp_id=?
										and i.customer_id=?
										and i.invoice_status='active'
										and i.invoice_date between STR_TO_DATE(?, '%d/%m/%Y') and STR_TO_DATE(?, '%d/%m/%Y')
										group by s.site_address,p.product_name,i.rate,i.invoice_date
										order by i.invoice_date asc
										)
										
										UNION ALL
										
										(select DATE_FORMAT(sd.invoice_date,'%d/%m/%Y') as date,s.site_address  as site_name,p.product_name,sum(sdi.item_quantity) as net_quantity,
										sdi.item_price as rate,sum(net_price) as total_amount,'' as paid_amount,DATEDIFF(CURRENT_DATE(), sd.invoice_date) as age,'' as payment_type
										from sales_document_item sdi LEFT JOIN (sales_document sd,site_detail s,purchase_order_item poi,product p,customer c)
										ON sdi.id=sd.id
										and sd.site_id=s.site_id
										and sdi.poi_id=poi.poi_id
										and poi.product_id=p.product_id
										and sd.customer_id=c.customer_id
										where sd.customer_id=?
										and sd.invoice_status='active'
										and c.mp_id=?
										and sd.invoice_date between STR_TO_DATE(?, '%d/%m/%Y') and STR_TO_DATE(?, '%d/%m/%Y')
										group by s.site_address,p.product_name,sdi.item_price,sd.invoice_date
										order by sd.invoice_date asc)
										
										UNION ALL
										
										(select DATE_FORMAT(payment_date,'%d/%m/%Y') as date,'' as site_name,'' as product_name,
										 0 as net_quantity,0 as rate,0 as total_amount,payment_amount as paid_amount,'' as age,
										 payment_mode as payment_type from customer_payment where customer_id=?  and payment_date between STR_TO_DATE(?, '%d/%m/%Y') and STR_TO_DATE(?, '%d/%m/%Y') order by payment_date asc)
										
										<sql:param value="${param.mp_id}"/>
										<sql:param value="${cus.customer_id}"/>
										<sql:param value="${param.from_date}"/>
										<sql:param value="${param.to_date}"/>
										<sql:param value="${cus.customer_id}"/>
										<sql:param value="${param.mp_id}"/>
										<sql:param value="${param.from_date}"/>
										<sql:param value="${param.to_date}"/>
										<sql:param value="${cus.customer_id}"/>
										<sql:param value="${param.from_date}"/>
										<sql:param value="${param.to_date}"/>
                       				</sql:query>
                       				<c:set value="0" var="total_amount_detail"/>
                       				<c:set value="0" var="total_paid_detail"/>
                       				<c:set value="0" var="total_quantity"/>
                       				<c:forEach items="${payment.rows}" var="payment">
                       					<c:set value="${payment.total_amount+total_amount_detail}" var="total_amount_detail"/>
                       					<c:set value="${payment.paid_amount+total_paid_detail}" var="total_paid_detail"/>
                       					<c:set value="${total_quantity+payment.net_quantity}" var="total_quantity"/>
										<tr>
											<td>${payment.date}</td>											
											<td>${(empty payment.site_name)?payment.payment_type:payment.site_name}</td>
											<td>${payment.product_name}</td>
											<td>${(payment.net_quantity>0)?payment.net_quantity:''}</td>
											<td>${(payment.rate>0)?payment.rate:''}</td>
											<td>${(payment.total_amount>0)?payment.total_amount:''}</td>
											<td>${payment.paid_amount}</td>
											<td></td>
											<td></td>
											<td></td>
											<td>${payment.age}</td>
										</tr> 
                       				</c:forEach>
                       					<c:set value="${overall_sum+(total_amount_detail-total_paid_detail)}" var="overall_sum"/>
                       					<tr class="pinktd">
											<td>Total : </td>
											<td></td>
											<td></td>
											<td>${total_quantity}</td>
											<td></td>
											<td>${total_amount_detail}</td>
											<td>${total_paid_detail}</td>
											<td>${total_amount_detail-total_paid_detail}</td>
											<td></td>
											<td></td>
											<td></td>
										</tr>  
                       			</c:forEach>
                       		</tbody>
                       		<tfoot>
                       			<tr class="deepblue">
                       				<th colspan="7">Total Overall Outstanding : </th>
                       				<th>${overall_sum}</th>
                       				<th></th>
                       				<th></th>
                       				<th></th>
                       			</tr>
                       		</tfoot>
                       	</table>
                    </div>
                   </c:when>
                   <c:otherwise>
                   	<div class="col-md-12">
                       	<sql:query var="cus" dataSource="jdbc/rmc">
                       		select p.* from (select t.customer_id,t.customer_name,if(t.net_amount is null,0,t.net_amount) as net_amount,if(t.net_sales is null,0,net_sales) as net_sales,
                       		if(t.net_paid is null,0,t.net_paid) as net_paid from (select c.customer_id,c.customer_name,
                       		(select sum(net_amount) from invoice where customer_id=c.customer_id and invoice_date between STR_TO_DATE(?, '%d/%m/%Y') and STR_TO_DATE(?, '%d/%m/%Y') and invoice_status='active') as net_amount,
                       		(select sum(payment_amount) from customer_payment where customer_id=c.customer_id and payment_date between STR_TO_DATE(?, '%d/%m/%Y') and STR_TO_DATE(?, '%d/%m/%Y')) as net_paid,
                       		(select sum(sdi.net_price) from sales_document sd,sales_document_item sdi where sd.id=sdi.id and sd.customer_id=c.customer_id and sd.invoice_status='active' and sd.invoice_date between STR_TO_DATE(?, '%d/%m/%Y') and STR_TO_DATE(?, '%d/%m/%Y')) as net_sales
                       	    from customer c
                       	    where c.business_id like if(?=0,'%%',?)) as t) as p where ((p.net_amount+p.net_sales)-p.net_paid)>0;
                       	    <sql:param value="${param.from_date}"/>
                       	    <sql:param value="${param.to_date}"/>
                       	    <sql:param value="${param.from_date}"/>
                       	    <sql:param value="${param.to_date}"/>
                       	    <sql:param value="${param.from_date}"/>
                       	    <sql:param value="${param.to_date}"/>
                       	    <sql:param value="${param.business_id}"/>
                       	    <sql:param value="${param.business_id}"/>
                       	</sql:query>
                       	
                       	<table class="table table-bordered table-condensed" id="example-2">
                       		<thead>
                       			<tr class="yelloth">
                       				<th>Date</th>
                       				<th>Party Name</th>	
                       				<th>Grade</th>
                       				<th>Quantity</th>
                       				<th>Rate Per M<sup>3</sup></th>
                       				<th>Total Amount</th>
                       				<th>Received Amount</th>
                       				<th>Pending Amount</th>
                       				<th></th>
                       				<th>Due On</th>
                       				<th>Overdue By Days</th>
                       			</tr>
                       		</thead>
                       		
                       		<tbody>
                       			<c:set value="0" var="overall_sum"/>
                       			<c:forEach items="${cus.rows}" var="cus">
                       				<tr class="blueth">
                       					<th colspan="8">${cus.customer_name}</th>
                       					<th></th>
                       					<th></th>
                       					<th></th>
                       				</tr>
                       				<sql:query var="payment" dataSource="jdbc/rmc">
                       					(select DATE_FORMAT(i.invoice_date,'%d/%m/%Y') as date,s.site_address as site_name,p.product_name as product_name,sum(i.quantity) as net_quantity,
                       					i.rate,sum(net_amount) as total_amount,'' as paid_amount,DATEDIFF(CURRENT_DATE(), i.invoice_date) as age,'' as payment_type
										from invoice i LEFT JOIN (site_detail s,product p,purchase_order_item poi)
										ON i.site_id=s.site_id
										and i.poi_id=poi.poi_id
										and poi.product_id=p.product_id
										where i.customer_id=?
										and i.invoice_status='active'
										and i.invoice_date between STR_TO_DATE(?, '%d/%m/%Y') and STR_TO_DATE(?, '%d/%m/%Y')
										group by s.site_address,p.product_name,i.rate,i.invoice_date
										order by i.invoice_date asc
										)
										
										UNION ALL
										
										(select DATE_FORMAT(sd.invoice_date,'%d/%m/%Y') as date,s.site_address  as site_name,p.product_name,sum(sdi.item_quantity) as net_quantity,
										sdi.item_price as rate,sum(net_price) as total_amount,'' as paid_amount,DATEDIFF(CURRENT_DATE(), sd.invoice_date) as age,'' as payment_type
										from sales_document_item sdi LEFT JOIN (sales_document sd,site_detail s,purchase_order_item poi,product p)
										ON sdi.id=sd.id
										and sd.site_id=s.site_id
										and sdi.poi_id=poi.poi_id
										and poi.product_id=p.product_id
										where sd.customer_id=?
										and sd.invoice_status='active'
										and sd.invoice_date between STR_TO_DATE(?, '%d/%m/%Y') and STR_TO_DATE(?, '%d/%m/%Y')
										group by s.site_address,p.product_name,sdi.item_price,sd.invoice_date
										order by sd.invoice_date asc)
										
										UNION ALL
										
										(select DATE_FORMAT(payment_date,'%d/%m/%Y') as date,'' as site_name,'' as product_name,
										0 as net_quantity,0 as rate,0 as total_amount,payment_amount as paid_amount,'' as age,
										payment_mode as payment_type from customer_payment where customer_id=? and payment_date between STR_TO_DATE(?, '%d/%m/%Y') and STR_TO_DATE(?, '%d/%m/%Y') order by payment_date asc)
										<sql:param value="${cus.customer_id}"/>
										<sql:param value="${cus.from_date}"/>
										<sql:param value="${cus.to_date}"/>
										<sql:param value="${cus.customer_id}"/>
										<sql:param value="${cus.from_date}"/>
										<sql:param value="${cus.to_date}"/>
										<sql:param value="${cus.customer_id}"/>
										<sql:param value="${cus.from_date}"/>
										<sql:param value="${cus.to_date}"/>
                       				</sql:query>
                       				<c:set value="0" var="total_amount_detail"/>
                       				<c:set value="0" var="total_paid_detail"/>
                       				<c:set value="0" var="total_quantity"/>
                       				<c:forEach items="${payment.rows}" var="payment">
                       					<c:set value="${payment.total_amount+total_amount_detail}" var="total_amount_detail"/>
                       					<c:set value="${payment.paid_amount+total_paid_detail}" var="total_paid_detail"/>
                       					<c:set value="${total_quantity+payment.net_quantity}" var="total_quantity"/>
										<tr>
											<td>${payment.date}</td>											
											<td>${(empty payment.site_name)?payment.payment_type:payment.site_name}</td>
											<td>${payment.product_name}</td>
											<td>${(payment.net_quantity>0)?payment.net_quantity:''}</td>
											<td>${(payment.rate>0)?payment.rate:''}</td>
											<td>${(payment.total_amount>0)?payment.total_amount:''}</td>
											<td>${payment.paid_amount}</td>
											<td></td>
											<td></td>
											<td></td>
											<td>${payment.age}</td>
										</tr> 
                       				</c:forEach>
                       					<c:set value="${overall_sum+(total_amount_detail-total_paid_detail)}" var="overall_sum"/>
                       					<tr class="pinktd">
											<td>Total : </td>
											<td></td>
											<td></td>
											<td>${total_quantity}</td>
											<td></td>
											<td>${total_amount_detail}</td>
											<td>${total_paid_detail}</td>
											<td>${total_amount_detail-total_paid_detail}</td>
											<td></td>
											<td></td>
											<td></td>
										</tr>  
                       			</c:forEach>
                       		</tbody>
                       		<tfoot>
                       			<tr class="deepblue">
                       				<th colspan="7">Total Overall Outstanding : </th>
                       				<th>${overall_sum}</th>
                       				<th></th>
                       				<th></th>
                       				<th></th>
                       			</tr>
                       		</tfoot>
                       	</table>
                    </div>
                   </c:otherwise>
                </c:choose>
                </div>
                <div class="row">
                	<div class="col-sm-12 text-center">
                			<button type="button" class="btn btn-warning" onclick="generate_excel();">Download Excel</button>
                	</div>
                </div>
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
    <!-- <script type="text/javascript">
    	$(document).ready(function(){
    		$('#mp_id').select2();
    		$("form").submit(function(e){
    			e.preventDefault();
    			var type=$('#type').val();
    			var mp_id=$('#mp_id').val();
    			var mp_name=$('#mp_id option:selected').text();
    			window.location="OverallReport.jsp?type="+type+"&mp_id="+mp_id+"&mp_name="+mp_name;
    		});
    	});
    </script> -->
    
    <script type="text/javascript">
	    $(document).ready(function(){
	    	$('.date-picker').datepicker({
				autoclose: true,
				todayHighlight: true
		 	});
			//show datepicker when clicking on the icon
			
         
           // $("#id-date-picker-1").datepicker("setDate", new Date());
			$('#id-date-picker-1').datepicker({
			        "autoclose": true,
			        "orientation":"bottom left"
			});
			
			
	    	$('#mp_id').select2();
			$('#report_type').on('change',function(){
				var report_type=$('#report_type').val();
				changeType(report_type)
			});
			
			var changeType=function(report_type){
				if(report_type=='date'){
					$('.no-date').hide();
					$('.no-date').prop('disabled',true);
					$('.date').show();
					$('.date').prop('disabled',false);
				}else if(report_type=='mp'){
					$('.mp').prop('disabled',false);
					$('.no-mp').prop('disabled',true);
					$('.mp').show();
					$('.no-mp').hide();
				}else if(report_type=='mpdate'){
					$('.mpdate').prop('disabled',false);
					$('.no-mpdate').prop('disabled',true);
					$('.mpdate').show();
					$('.no-mpdate').hide();				
				}
				else{
					$('.date').prop('disabled',true);
					$('.date').hide();
					$('.mp').prop('disabled',true);
					$('.mp').hide();
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
	        if(report_type=='date'){
	        	var from_date=$('.from_date').val();
	        	var to_date=$('.to_date').val();
	        	window.location="OverallReport.jsp?report_type="+report_type+"&business_id="+business_id+"&from_date="+from_date+"&to_date="+to_date;
	        }else if(report_type=='mp'){
	        	var mp_id=$('#mp_id').val();
	        	window.location="OverallReport.jsp?report_type="+report_type+"&business_id="+business_id+"&mp_id="+mp_id;
	        }else if(report_type=='mpdate'){
	        	var mp_id=$('#mp_id').val();
	        	var from_date=$('.from_date').val();
	        	var to_date=$('.to_date').val();
	        	window.location="OverallReport.jsp?report_type="+report_type+"&business_id="+business_id+"&mp_id="+mp_id+"&from_date="+from_date+"&to_date="+to_date;
	        }else{
	        	window.location="OverallReport.jsp?report_type="+report_type+"&business_id="+business_id;
	        }
	    });
    </script>
		
    </body>
</html>