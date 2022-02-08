<!DOCTYPE html>
<%@ include file="Session.jsp" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
        <meta charset="utf-8" />
        <title>Sales Document Bulk Report</title>
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
        
         <link href="plugins/custombox/css/custombox.min.css" rel="stylesheet">
        
        <style type="text/css">
        	.change{
        		background-color:#469399;
        		color: white;
        	}
        	
        	.nochange{
        		background-color: #d7dfe0;
        		
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
                                    <li class="breadcrumb-item"><a href="#">Sales Document</a></li>
                                    <li class="breadcrumb-item"><a href="#">Sales Document Bulk Report</a></li>
                                </ol>
                            </div>
                            <h4 class="page-title">Sales Document Bulk Report</h4>
                        </div>
                    </div>
                </div>
                 <!-- end row -->
                <div class="row">
                    <div class="col-md-12">
                       <form action="#" id="myform" method="post">
                          <div class="row">
                          	<div class="col-sm-4"></div>
                          	<div class="col-sm-4">
                          		<div class="col-sm-12">
                                   <div class="form-group">
                                       <label>Report Type<span class="text-danger">*</span></label>
                                       <select class="form-control" name="report_type" id="report_type" required="required">
                                           <option value="date" ${(param.report_type=='date')?'selected':''}>Date Wise</option>
                                           <option value="customer" ${(param.report_type=='customer')?'selected':''}>Customer Wise</option>
                                           <option value="customerdate" ${(param.report_type=='customerdate')?'selected':''}>Customer With Date Wise</option>
                                           <option value="vehicledate" ${(param.report_type=='vehicledate')?'selected':''}>Vehicle With Date Wise</option>
                                           <option value="marketing" ${(param.report_type=='marketing')?'selected':''}>Marketing Person Wise</option>
                                       </select>
                                   </div>
                               </div>
                               
                                <div class="col-sm-12 no-cus no-veh cus-dat veh-dat date mar">
                                  <div class="form-group">
                                      <label>From Date<span class="text-danger">*</span></label>
                                      <div class="input-group">
                                          <input type="text" name="from_date" value="${param.from_date}" 
                                          		 class="form-control date-picker no-cus no-veh cus-dat veh-dat date from_date mar"
                                          		 required="required" placeholder="dd/mm/yyyy" id="id-date-picker-1" data-date-format="dd/mm/yyyy"
                                          		 readonly="readonly" style="background-color: white;"/>
                                           <div class="input-group-append picker">
                                               <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
                                           </div>
                                      </div>
                                  </div>
                                </div>
                                
                                <div class="col-sm-12 no-cus no-veh cus-dat veh-dat veh-dat date mar">
                                  <div class="form-group">
                                      <label>To Date<span class="text-danger">*</span></label>
                                      <div class="input-group">
                                          <input type="text" name="to_date" value="${param.to_date}"
                                          	     class="form-control date-picker no-cus no-veh cus-dat veh-dat date to_date mar"
                                          	     required="required" placeholder="dd/mm/yyyy" id="id-date-picker-1" data-date-format="dd/mm/yyyy"
                                          	     readonly="readonly" style="background-color: white;"/>
                                           <div class="input-group-append picker">
                                               <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
                                           </div>
                                      </div>
                                  </div>
                                </div>
                                
                                <div class="col-sm-12 no-date no-cus no-veh no-cus-dat cus-dat no-veh-dat mar">
                                   <div class="form-group">
                                       <label>Marketing Person : </label>
                                       <sql:query var="mp" dataSource="jdbc/rmc">
                                       	select mp_id,mp_name
                                        from marketing_person
                                        where mp_status='active'
                                       </sql:query>
                                       <select class="select2 no-date no-cus no-veh no-cus-dat cus-dat no-veh-dat mar" name="mp_id" id="mp_id" required="required">
                                           <option value="" selected="selected">All Marketing Person</option>
                                           <c:forEach items="${mp.rows}" var="mp">
                                           <option value="${mp.mp_id}"
                                           			 ${(param.mp_id==mp.mp_id)?'selected':''}>${mp.mp_name}</option>
                                           </c:forEach>
                                       </select>
                                   </div>
                               </div>
                               
                               <div class="col-sm-12 no-date cus no-veh cus-dat no-veh-dat no-mar">
                                   <div class="form-group">
                                       <label>Customer <span class="text-danger">*</span></label>
                                       <sql:query var="customer" dataSource="jdbc/rmc">
                                       	select customer_id,customer_name
                                        from customer
                                        where customer_status='active'
                                        and business_id like if(?=0,'%%',?)
                                        order by customer_name asc
                                        <sql:param value="${bean.business_id}"/>
                                        <sql:param value="${bean.business_id}"/>
                                       </sql:query>
                                       <select class="select2 no-date cus no-veh cus-dat no-veh-dat no-mar" name="customer_id" id="customer_id" required="required">
                                           <option value="0" selected="selected">All Customer</option>
                                           <c:forEach items="${customer.rows}" var="customer">
                                           <option value="${customer.customer_id}" 
                                           			${(param.customer_id==customer.customer_id)?'selected':''}>${customer.customer_name}</option>
                                           </c:forEach>
                                       </select>
                                   </div>
                               </div>
                               
                               <div class="col-sm-12 no-date cus no-veh cus-dat no-veh-dat no-mar">
                                   <div class="form-group">
                                       <label>Site : </label>
                                       <select class="form-control no-date cus no-veh cus-dat no-veh-dat no-mar" name="site_id" id="site_id">
                                           <option value="">All Site</option>
                                       </select>
                                   </div>
                               </div>
                               
                                <div class="col-sm-12 no-date cus no-veh cus-dat no-veh-dat no-mar">
                                   <div class="form-group">
                                       <label>Block  : </label>
                                       <select class="form-control no-date cus no-veh cus-dat no-veh-dat no-mar" name="block_name" id="block_name">
                                           <option value="">All Block</option>
                                       </select>
                                   </div>
                               </div>
                               
                               <div class="col-sm-12 no-date no-cus veh no-cus-dat veh-dat no-mar">
                                   <div class="form-group">
                                       <label>Vehicle No <span class="text-danger">*</span></label>
                                       <sql:query var="vehicle" dataSource="jdbc/rmc">
                                       	select * from vehicle
                                       </sql:query>
                                       <select class="select2 no-date no-cus veh no-cus-dat veh-dat no-mar" name="vehicle_no" id="vehicle_no" required="required">
                                           <option value="0" selected="selected" >All Vehicle</option>
                                           <c:forEach items="${vehicle.rows}" var="vehicle">
                                           <option value="${vehicle.vehicle_no}"
                                           		   ${(vehicle.vehicle_no==param.vehicle_no)?'selected':''}>
                                           		   		${vehicle.vehicle_no}</option>
                                           </c:forEach>
                                       </select>
                                   </div>
                               </div>
                               
                               <div class="col-sm-12" style="display: none;">
                                   <div class="form-group">
                                       <label>Items : </label>
                                        <sql:query var="item" dataSource="jdbc/rmc">
                                       	select product_id,product_name
                                        from product
                                        where business_id like if(0=?,'%%',?)
                                        <sql:param value="${param.business_id}"/>
                                        <sql:param value="${param.business_id}"/>
                                       </sql:query>
                                       <select class="select2" name="product_id" id="product_id">
                                           <option selected="selected"  value="">All Item</option>
                                           <c:forEach items="${item.rows}" var="item">
                                           <option value="${item.product_id}"
                                           		   ${(item.product_id==param.product_id)?'selected':''}>${item.product_name}</option>
                                           </c:forEach>
                                       </select>
                                   </div>
                               </div>
                               
                               <div class="col-sm-12">
                                   <div class="form-group">
                                       <label>Plant :</label>
                                       <sql:query var="plant" dataSource="jdbc/rmc">
                                       	select plant_id,plant_name
                                        from plant
                                        where plant_id like if(?=0,'%%',?)
                                        and business_id like if(?=0,'%%',?)
                                       	<sql:param value="${bean.plant_id}"/>
                                       	<sql:param value="${bean.plant_id}"/>
                                       	<sql:param value="${bean.business_id}"/>
                                       	<sql:param value="${bean.business_id}"/>
                                       </sql:query>
                                       <select class="form-control" name="plant_id" id="plant_id">
                                           <c:if test="${bean.plant_id==0}">
                                           	<option value="" selected="selected">All Plant</option>
                                           </c:if>
                                           <c:forEach items="${plant.rows}" var="plant">
                                           <option value="${plant.plant_id}"
                                           		   ${(param.plant_id==plant.plant_id)?'selected':''}>${plant.plant_name}</option>
                                           </c:forEach>
                                       </select>
                                   </div>
                                </div>
                               
                          	</div> 	
                          </div>
                           
                          <div class="text-center m-t-20">
                               <button type="submit" class="btn btn-primary btn-lg m-r-10 save-button">Generate Report</button>
                               <a class="btn btn-danger btn-lg" href="SalesDocumentReportBulk.jsp">Clear Report</a>
                          </div>
                       </form>
                    </div>
                </div>
                
                <c:if test="${param.action=='generateReport'}">
                <form action="SalesDocumentController?action=generatecons" method="post" class="form" id="myfrm" style="margin: 0 !important;padding: 0 !important;">
               	 <input type="hidden" value="${param.customer_id}" name="customer_id"/>
               	 <input type="hidden" value="${param.site_id}" name="site_id"/>
               	 <input type="hidden" value="${param.from_date}" name="from_date"/>
               	 <input type="hidden" value="${param.to_date}" name="to_date"/>
               	 <input type="hidden" name="plant_id" id="plnt_id"/>
               	 <input type="hidden" name="reference_no" id="ref_no"/>
               	 <input type="hidden" name="generate_date" id="gen_date"/>
               	<div class="row" style="margin-top: 25px;">
               		<div class="col-sm-12">
               			<a  class="btn btn-warning btn-sm" id="downloadExcel">Excel</a>
               			<button type="button" class="btn btn-danger btn-sm" onclick="print();">Print</button>
               			<button type="button" class="btn btn-success btn-sm" id="tally">TALLY XML</button>
						<a  class="btn btn-warning btn-sm" id="downloadInJson">JSON</a>
               			<c:if test="${param.report_type=='customer' || param.report_type=='customerdate'}">
               				<a  id="sales_document" class="btn btn-info btn-sm pull-right"  style="display: none;" href="#amount-click" data-animation="blur" data-plugin="custommodal"  data-overlaySpeed="100" data-overlayColor="#36404a">Generate Sales Document</a>
               				<a  id="consoldate_invoice" class="btn btn-info btn-sm pull-right"  style="display: none;" href="#amount-click" data-animation="blur" data-plugin="custommodal"  data-overlaySpeed="100" data-overlayColor="#36404a">Generate Consolidate Invoice</a>
               			</c:if>
               		</div>
               		<div class="col-sm-12 printme table-responsive" id="printme">
               			<!-- Get all kind of query here -->
               				<c:set value="${(empty param.plant_id || param.plant_id=='null')?'':param.plant_id}" var="plant_id"/>
               				<c:set value="${(empty param.product_id || param.product_id=='null')?'':param.product_id}" var="product_id"/>
               				<c:choose>
               					<c:when test="${param.report_type=='date'}">
               						<sql:query var="inv" dataSource="jdbc/rmc">
               							select c.customer_name,s.site_name,s.site_address,c.customer_phone,c.customer_email,c.customer_address,c.customer_gstin,
               							(select count(sditem_id) from sales_document_item where id=i.id) as count,
               							p.product_name,i.invoice_id,i.id,DATE_FORMAT(i.invoice_date,'%d/%m/%Y') as invoice_date,invoice_time,
               							i.vehicle_no,si.item_quantity,si.item_price,si.gross_price,si.net_price,si.tax_price,p.product_name,pl.plant_name
               							from  sales_document_item si LEFT JOIN(sales_document i,customer c,site_detail s,purchase_order po,purchase_order_item poi,product p,plant pl)
               							ON si.id=i.id
               							and i.customer_id=c.customer_id
               							and i.site_id=s.site_id
               							and si.poi_id=poi.poi_id
               							and poi.product_id=p.product_id
               							and poi.order_id=po.order_id
               							and i.plant_id=pl.plant_id
               							where  i.invoice_date between STR_TO_DATE(?, '%d/%m/%Y') and STR_TO_DATE(?, '%d/%m/%Y')
               							and p.product_id like if(''=?,'%%',?)
               							and i.plant_id like if(''=?,'%%',?)
               							and c.business_id like if(0=?,'%%',?)
               							order by i.id asc
               							<sql:param value="${param.from_date}"/>
               							<sql:param value="${param.to_date}"/>
               							<sql:param value="${product_id}"/>
               							<sql:param value="${product_id}"/>
               							<sql:param value="${plant_id}"/>
               							<sql:param value="${plant_id}"/>
               							<sql:param value="${bean.business_id}"/>
               							<sql:param value="${bean.business_id}"/>
               						</sql:query>
               					</c:when>
               					<c:when test="${param.report_type=='customer'}">
               						<sql:query var="inv" dataSource="jdbc/rmc">
               							select c.customer_name,s.site_name,s.site_address,c.customer_phone,c.customer_email,c.customer_address,c.customer_gstin,
               							(select count(sditem_id) from sales_document_item where id=i.id) as count,
               							p.product_name,i.invoice_id,i.id,DATE_FORMAT(i.invoice_date,'%d/%m/%Y') as invoice_date,invoice_time,
               							i.vehicle_no,si.item_quantity,si.item_price,si.gross_price,si.net_price,si.tax_price,p.product_name,pl.plant_name
               							from  sales_document_item si LEFT JOIN(sales_document i,customer c,site_detail s,purchase_order po,purchase_order_item poi,product p,plant pl)
               							ON si.id=i.id
               							and i.customer_id=c.customer_id
               							and i.site_id=s.site_id
               							and si.poi_id=poi.poi_id
               							and poi.product_id=p.product_id
               							and poi.order_id=po.order_id
               							and i.plant_id=pl.plant_id
               							where i.customer_id like if(0=?,'%%',?)
               							and i.site_id like if(0=?,'%%',?)
               							and p.product_id like if(''=?,'%%',?)
               							and i.plant_id like if(''=?,'%%',?)
               							and c.business_id like if(0=?,'%%',?)
               							order by i.id asc
               							<sql:param value="${param.customer_id}"/>
               							<sql:param value="${param.customer_id}"/>
               							<sql:param value="${param.site_id}"/>
               							<sql:param value="${param.site_id}"/>
               							<sql:param value="${product_id}"/>
               							<sql:param value="${product_id}"/>
               							<sql:param value="${plant_id}"/>
               							<sql:param value="${plant_id}"/>
               							<sql:param value="${bean.business_id}"/>
               							<sql:param value="${bean.business_id}"/>
               						</sql:query>
               					</c:when>
               					
               					<c:when test="${param.report_type=='vehicle'}">
               						<sql:query var="inv" dataSource="jdbc/rmc">
               							select c.customer_name,s.site_name,s.site_address,c.customer_phone,c.customer_email,c.customer_address,c.customer_gstin,
               							(select count(sditem_id) from sales_document_item where id=i.id) as count,
               							p.product_name,i.invoice_id,i.id,DATE_FORMAT(i.invoice_date,'%d/%m/%Y') as invoice_date,invoice_time,
               							i.vehicle_no,si.item_quantity,si.item_price,si.gross_price,si.net_price,si.tax_price,p.product_name,pl.plant_name
               							from  sales_document_item si LEFT JOIN(sales_document i,customer c,site_detail s,purchase_order po,purchase_order_item poi,product p,plant pl)
               							ON si.id=i.id
               							and i.customer_id=c.customer_id
               							and i.site_id=s.site_id
               							and si.poi_id=poi.poi_id
               							and poi.product_id=p.product_id
               							and poi.order_id=po.order_id
               							and i.plant_id=pl.plant_id
               							where  i.vehicle_no like if(''=?,'%%',?)
               							and p.product_id like if(''=?,'%%',?)
               							and i.plant_id like if(''=?,'%%',?)
               							and c.business_id like if(0=?,'%%',?)
               							order by i.id asc
               							<sql:param value="${param.vehicle_no}"/>
               							<sql:param value="${param.vehicle_no}"/>
               							<sql:param value="${product_id}"/>
               							<sql:param value="${product_id}"/>
               							<sql:param value="${plant_id}"/>
               							<sql:param value="${plant_id}"/>
               						</sql:query>
               					</c:when>
               					
               					<c:when test="${param.report_type=='vehicledate'}">
               						<sql:query var="inv" dataSource="jdbc/rmc">
               							select c.customer_name,s.site_name,s.site_address,c.customer_phone,c.customer_email,c.customer_address,c.customer_gstin,
               							(select count(sditem_id) from sales_document_item where id=i.id) as count,
               							p.product_name,i.invoice_id,i.id,DATE_FORMAT(i.invoice_date,'%d/%m/%Y') as invoice_date,invoice_time,
               							i.vehicle_no,si.item_quantity,si.item_price,si.gross_price,si.net_price,si.tax_price,p.product_name,pl.plant_name
               							from  sales_document_item si LEFT JOIN(sales_document i,customer c,site_detail s,purchase_order po,purchase_order_item poi,product p,plant pl)
               							ON si.id=i.id
               							and i.customer_id=c.customer_id
               							and i.site_id=s.site_id
               							and si.poi_id=poi.poi_id
               							and poi.product_id=p.product_id
               							and poi.order_id=po.order_id
               							and i.plant_id=pl.plant_id
               							where i.vehicle_no like if(''=?,'%%',?)
               							and i.invoice_date between STR_TO_DATE(?, '%d/%m/%Y') and STR_TO_DATE(?, '%d/%m/%Y')
               							and p.product_id like if(''=?,'%%',?)
               							and i.plant_id like if(''=?,'%%',?)
               							and c.business_id like if(0=?,'%%',?)
               							order by i.id asc
               							<sql:param value="${param.vehicle_no}"/>
               							<sql:param value="${param.vehicle_no}"/>
               							<sql:param value="${param.from_date}"/>
               							<sql:param value="${param.to_date}"/>
               							<sql:param value="${product_id}"/>
               							<sql:param value="${product_id}"/>
               							<sql:param value="${plant_id}"/>
               							<sql:param value="${plant_id}"/>
               							<sql:param value="${bean.business_id}"/>
               							<sql:param value="${bean.business_id}"/>
               						</sql:query>
               					</c:when>
               				</c:choose>
               			
               				<c:choose>
               					<c:when test="${param.report_type=='customerdate'}">
               						<c:set value="0" var="total_quantity"/>
               						<c:set value="0" var="total_netamount"/> 
               						<c:set value="0" var="total_gross_amount"/>
               						<table class="table table-bordered" id="example-2">
							<thead>
               							<tr style="background-color: #741d7a;color: white;" class="text-center">
			               					<td></td>
			               					<td></td>
			               					<td colspan="7" class="text-center">
			               						<h3>BULK SALES DOCUMENT REPORT</h3>
			               					</td>
			               					<td></td>
			               					<td></td>
			               				</tr>
							
			               				<tr style="background-color: #4b9663;color: white;">
			               					 <td>Date</td>
			               					<td>Invoice Id</td>
			               					<td class="d-none">GSTIN No</td>
			               					<td>Site Name</td>
			               					<td class="d-none">Site Address</td>
			               					<td>Grade</td>
											<td class="d-none">HSN Code</td>
			               					<td>Quantity</td>
			               					<td>Rate</td>
			               					<td>Gross Amount</td>
			               					<td class="d-none">CGST</td>
			               					<td class="d-none">SGST</td>
			               					<td class="d-none">IGST</td>
			               					<td>Net Amount</td>
			               					<td>Plant Name</td>
			               					<td class="d-none">Billing Address</td>
			               					<td class="d-none">Marketing Person</td>
			               					<td class="d-none">Pump/Supply</td>
			               					<td>Vehicle No</td>
			               					<td style="text-align: center;vertical-align: middle !important;"
			               							>Select All<br><input type="checkbox" class="id" id="selectall"/></td>
			               				</tr>
							</thead>
			               					<c:catch var="ee">
			               						<sql:query var="customer" dataSource="jdbc/rmc">
				               						select distinct c.customer_id,c.customer_name,c.customer_gstin
				               						from sales_document i LEFT JOIN(customer c,purchase_order_item poi,sales_document_item si)
				               						ON i.customer_id=c.customer_id 
				               						and si.poi_id=poi.poi_id
				               						and i.id=si.id
				               						where i.customer_id like if(0=?,'%%',?)
													and i.site_id like if(''=?,'%%',?)
													and poi.product_id like if(''=?,'%%',?)
													and i.plant_id like if(''=?,'%%',?)
													and i.invoice_date between STR_TO_DATE(?, '%d/%m/%Y') and STR_TO_DATE(?, '%d/%m/%Y')
			               							<sql:param value="${param.customer_id}"/>
			               							<sql:param value="${param.customer_id}"/>
			               							<sql:param value="${param.site_id}"/>
			               							<sql:param value="${param.site_id}"/>
			               							<sql:param value="${product_id}"/>
			               							<sql:param value="${product_id}"/>
			               							<sql:param value="${plant_id}"/>
			               							<sql:param value="${plant_id}"/>
			               							<sql:param value="${param.from_date}"/>
			               							<sql:param value="${param.to_date}"/>
					               				</sql:query>
			               					</c:catch>
									${ee}
				               				<c:forEach var="customer" items="${customer.rows}">
				               					<c:catch var="er">
				               						<sql:query var="invv" dataSource="jdbc/rmc">
				               							select i.id,i.invoice_id,DATE_FORMAT(i.invoice_date,'%d/%m/%Y') AS invoice_date,i.invoice_time,i.plant_id as plti_id,c.customer_name,
				               							c.customer_gstin,c.customer_address,s.site_address,s.site_name,
				               							(select count(sditem_id) from sales_document_item where id=i.id) as count,
				               							si.item_quantity,si.item_price,si.net_price,p.product_name,si.net_price,si.tax_price,si.gross_price,pl.plant_name,i.vehicle_no
														from sales_document i LEFT JOIN(customer c,site_detail s,product p,purchase_order_item poi,plant pl,sales_document_item si)
														ON i.customer_id=c.customer_id 
														and i.id=si.id
														and i.site_id=s.site_id 
														and si.poi_id=poi.poi_id 
														and poi.product_id=p.product_id
														and i.plant_id=pl.plant_id
														where i.customer_id like if(0=?,'%%',?)
														and i.site_id like if(''=?,'%%',?)
														and poi.product_id like if(''=?,'%%',?)
														and i.plant_id like if(''=?,'%%',?)
														and i.invoice_date between STR_TO_DATE(?, '%d/%m/%Y') and STR_TO_DATE(?, '%d/%m/%Y')
														order by c.customer_name,s.site_address,i.invoice_date,i.invoice_id asc
				               							<sql:param value="${customer.customer_id}"/>
				               							<sql:param value="${customer.customer_id}"/>
				               							<sql:param value="${param.site_id}"/>
				               							<sql:param value="${param.site_id}"/>
				               							<sql:param value="${product_id}"/>
				               							<sql:param value="${product_id}"/>
				               							<sql:param value="${plant_id}"/>
				               							<sql:param value="${plant_id}"/>
				               							<sql:param value="${param.from_date}"/>
				               							<sql:param value="${param.to_date}"/>
				               						</sql:query>
				               					</c:catch>
				               					<thead>
				               					<tr>
				               						<th colspan="11"><h4>${customer.customer_name} ${er}</h4></th>
				               					</tr>
				               					</thead>
				               					<tbody>
				               					<c:set value="" var="date"></c:set>
               									<c:set value="0" var="date_count"></c:set>
               									<c:set value="0" var="count"/>
               									<c:set value="0" var="date_net"></c:set>
               									<c:set value="0" var="date_gross"></c:set>
               									<c:set value="false" var="view"/>
			               						<c:set value="0" var="invID"/>
			               						
               									<c:forEach var="inv" items="${invv.rows}">
               										<c:choose>
					               						<c:when test="${val==0}">
					               							<c:set value="true" var="view"/>
					               							<c:set value="${inv.invoice_id}" var="invID"/>
					               						</c:when>
					               						<c:when test="${val!=0 && invID==inv.invoice_id}">
					               							<c:set value="false" var="view"/>
					               						</c:when>
					               						<c:when test="${val!=0 &&  invID!=inv.invoice_id}">
					               							<c:set value="true" var="view"/>
					               							<c:set value="${inv.invoice_id}" var="invID"/>
					               						</c:when>
					               					</c:choose>
					               					
					               					
               										<c:if test="${count==0}">
               											<c:set value="${inv.invoice_date}" var="date"></c:set>
               										</c:if>
               										
               										<c:choose>
               											<c:when test="${inv.invoice_date==date}">
														
               												<tr>
							               						<c:if test="${view==true}">
							               						<td rowspan="${inv.count}" style="text-align: center;vertical-align: middle !important;">${inv.invoice_date}</td>
								               					<td rowspan="${inv.count}" style="text-align: center;vertical-align: middle !important;"><a href="PrintSalesDocument.jsp?id=${inv.id}" target="_blank">${inv.invoice_id}</a></td>
								               					<td class="d-none" rowspan="${inv.count}" style="text-align: center;vertical-align: middle !important;">${inv.customer_gstin}</td>
								               					<td rowspan="${inv.count}" style="text-align: center;vertical-align: middle !important;">${inv.site_address}</td>
								               					<td class="d-none" rowspan="${inv.count}" style="text-align: center;vertical-align: middle !important;">${inv.site_address}</td>
								               					</c:if>
								               					<td style="background-color: ${(inv.count>1)?'#fcffff':''}">${inv.product_name}</td>
																<td class="d-none" style="background-color: ${(inv.count>1)?'#fcffff':''}">38245010</td>
								               					<td style="background-color: ${(inv.count>1)?'#fcffff':''}">${inv.item_quantity}</td>
								               					<c:choose>
																	<c:when test="${inv.rate_include_tax=='yes'}">
																		<td style="background-color: ${(inv.count>1)?'#fcffff':''}"><fmt:formatNumber value="${(inv.item_price/118)*100}" maxFractionDigits="2" groupingUsed="false"/></td>
																	</c:when>
																	<c:otherwise>
																		<td style="background-color: ${(inv.count>1)?'#fcffff':''}"><fmt:formatNumber value="${inv.item_price}" maxFractionDigits="2" groupingUsed="false"/></td>
																	</c:otherwise>
																</c:choose>
								               					<td style="background-color: ${(inv.count>1)?'#fcffff':''}">${inv.gross_price}</td>
								               					<c:choose>
								               						<c:when test="${inv.gst_category=='GST'}">
								               						<td class="d-none" style="text-align: center;vertical-align: middle !important;"><fmt:formatNumber value="${inv.tax_price/2}" groupingUsed="false" maxFractionDigits="2"/></td>
								               						<td class="d-none" style="text-align: center;vertical-align: middle !important;"><fmt:formatNumber value="${inv.tax_price/2}" groupingUsed="false" maxFractionDigits="2"/></td>
								               						<td class="d-none" style="text-align: center;vertical-align: middle !important;">0</td>
								               						</c:when>
								               						<c:otherwise>
								               						<td class="d-none" style="text-align: center;vertical-align: middle !important;">0</td>
								               						<td class="d-none" style="text-align: center;vertical-align: middle !important;">0</td>
								               						<td class="d-none" style="text-align: center;vertical-align: middle !important;"><fmt:formatNumber value="${inv.tax_price}" groupingUsed="false" maxFractionDigits="2"/></td>
								               						
								               						</c:otherwise>
								               					</c:choose>
								               					<td style="background-color: ${(inv.count>1)?'#fcffff':''}">${inv.net_price}</td>
								               					<c:if test="${view==true}">
								               					<td rowspan="${inv.count}" style="text-align: center;vertical-align: middle !important;">${inv.plant_name}</td>
								               					<td class="d-none"
								               						style="text-align: center;vertical-align: middle !important;" rowspan="${inv.count}">${inv.customer_address}</td>
								               					<td class="d-none" 
								               						style="text-align: center;vertical-align: middle !important;" rowspan="${inv.count}">${inv.mp_name}</td>
								               					<td class="d-none"
								               						style="text-align: center;vertical-align: middle !important;" rowspan="${inv.count}">${inv.pump}</td>
								               					<td rowspan="${inv.count}" 
								               						style="text-align: center;vertical-align: middle !important;">${inv.vehicle_no}</td>
								               					<td rowspan="${inv.count}"
								               					    style="text-align: center;vertical-align: middle !important;"><input type="checkbox" id="id"  class="id idcls" name="idd" value="${inv.id}"/></td>
								               					</c:if>
								               				</tr>
								               				<c:set value="${date_count+inv.item_quantity}" var="date_count"/>
								               				<c:set value="${date_net+inv.net_price}" var="date_net"></c:set>
               												<c:set value="${date_gross+inv.gross_price}" var="date_gross"></c:set>
               												
               												<!-- Calculate total details here -->
               												<c:set value="${total_quantity+inv.item_quantity}" var="total_quantity"/>
						               						<c:set value="${total_netamount+inv.net_price}" var="total_netamount"/> 
						               						<c:set value="${total_gross_amount+inv.gross_price}" var="total_gross_amount"/>
               											</c:when>
               											<c:otherwise>
               												<tr class="text-right">
			               										<td colspan="4"><b> Date Wise( ${date} ) : </b></td>
			               										<td class="text-left"><b>${date_count}</b></td>
			               										<td></td>
			               										<td class="text-left"><b><fmt:formatNumber value="${date_gross}" maxFractionDigits="2" groupingUsed="false"/></b></td>
			               										<td class="text-left"><b>${date_net}</b></td>
			               										<td></td>
			               										<td></td>
			               										<td></td>
			               									</tr>
               												<c:set value="0" var="date_count"/>
               												<c:set value="0" var="date_net"></c:set>
               												<c:set value="0" var="date_gross"></c:set>
               												<c:set value="${inv.invoice_date}" var="date"></c:set>
               												<tr>
               													
							               						<c:if test="${view==true}">
							               						<td rowspan="${inv.count}" style="text-align: center;vertical-align: middle !important;">${inv.invoice_date}</td>
								               					<td rowspan="${inv.count}" style="text-align: center;vertical-align: middle !important;"><a href="PrintSalesDocument.jsp?id=${inv.id}" target="_blank">${inv.invoice_id}</a></td>
								               					<td class="d-none" rowspan="${inv.count}" style="text-align: center;vertical-align: middle !important;">${inv.customer_gstin}</td>
								               					<td rowspan="${inv.count}" style="text-align: center;vertical-align: middle !important;">${inv.site_name}</td>
								               					<td class="d-none" rowspan="${inv.count}" style="text-align: center;vertical-align: middle !important;">${inv.site_address}</td>
								               					</c:if>
								               					<td style="background-color: ${(inv.count>1)?'#fcffff':''}">${inv.product_name}</td>
																<td class="d-none" style="background-color: ${(inv.count>1)?'#fcffff':''}">38245010</td>
								               					<td style="background-color: ${(inv.count>1)?'#fcffff':''}">${inv.item_quantity}</td>
								               					<c:choose>
																	<c:when test="${inv.rate_include_tax=='yes'}">
																		<td style="background-color: ${(inv.count>1)?'#fcffff':''}"><fmt:formatNumber value="${(inv.item_price/118)*100}" maxFractionDigits="2" groupingUsed="false"/></td>
																	</c:when>
																	<c:otherwise>
																		<td style="background-color: ${(inv.count>1)?'#fcffff':''}"><fmt:formatNumber value="${inv.item_price}" maxFractionDigits="2" groupingUsed="false"/></td>
																	</c:otherwise>
																</c:choose>
								               					<td style="background-color: ${(inv.count>1)?'#fcffff':''}">${inv.gross_price}</td>
								               					<c:choose>
								               						<c:when test="${inv.gst_category=='GST'}">
								               						<td class="d-none" style="text-align: center;vertical-align: middle !important;"><fmt:formatNumber value="${inv.tax_price/2}" groupingUsed="false" maxFractionDigits="2"/></td>
								               						<td class="d-none" style="text-align: center;vertical-align: middle !important;"><fmt:formatNumber value="${inv.tax_price/2}" groupingUsed="false" maxFractionDigits="2"/></td>
								               						<td class="d-none" style="text-align: center;vertical-align: middle !important;">0</td>
								               						</c:when>
								               						<c:otherwise>
								               						<td class="d-none" style="text-align: center;vertical-align: middle !important;">0</td>
								               						<td class="d-none" style="text-align: center;vertical-align: middle !important;">0</td>
								               						<td class="d-none" style="text-align: center;vertical-align: middle !important;"><fmt:formatNumber value="${inv.tax_price}" groupingUsed="false" maxFractionDigits="2"/></td>
								               						
								               						</c:otherwise>
								               					</c:choose>
								               					<td style="background-color: ${(inv.count>1)?'#fcffff':''}">${inv.net_price}</td>
								               					<c:if test="${view==true}">
								               					<td rowspan="${inv.count}" style="text-align: center;vertical-align: middle !important;">${inv.plant_name}</td>
								               					<td class="d-none"
								               						style="text-align: center;vertical-align: middle !important;" rowspan="${inv.count}">${inv.customer_address}</td>
								               					<td class="d-none" 
								               						style="text-align: center;vertical-align: middle !important;" rowspan="${inv.count}">${inv.mp_name}</td>
								               					<td class="d-none"
								               						style="text-align: center;vertical-align: middle !important;" rowspan="${inv.count}">${inv.pump}</td>
								               					<td rowspan="${inv.count}" 
								               						style="text-align: center;vertical-align: middle !important;">${inv.vehicle_no}</td>
								               					<td rowspan="${inv.count}"
								               					    style="text-align: center;vertical-align: middle !important;"><input type="checkbox" id="id"  class="id idcls" name="idd" value="${inv.id}"/></td>
								               					</c:if>
								               				</tr>
								               				<c:set value="${data_count+inv.item_quantity}" var="date_count"/>
								               				<c:set value="${date_net+inv.net_price}" var="date_net"></c:set>
               												<c:set value="${date_gross+inv.gross_price}" var="date_gross"></c:set>
               												
               												<!-- Calculate total details here -->
               												<c:set value="${total_quantity+inv.item_quantity}" var="total_quantity"/>
						               						<c:set value="${total_netamount+inv.net_price}" var="total_netamount"/> 
						               						<c:set value="${total_gross_amount+inv.gross_price}" var="total_gross_amount"/>
               											</c:otherwise>
               										</c:choose>
               										<c:set value="${count+1}" var="count"/>
               									</c:forEach>
               									<tr class="text-right">
               										<td colspan="4"><b> Date Wise( ${date} ) : </b></td>
               										<td><b>${date_count}</b></td>
               										<td></td>
               										<td><b><fmt:formatNumber value="${date_gross}" maxFractionDigits="2" groupingUsed="false"/></b></td>
               										<td><b>${date_net}</b></td>
               										<td></td>
               										<td></td>
               									</tr>
				               				</c:forEach>
											<c:set value="${count+1}" var="count"/>	
											<tr class="text-right">
												<td colspan="8"><b>Total Quantity : </b></td>
												<td colspan="3"><b>${total_quantity}</b></td>
											</tr>
											<tr class="text-right">
												<td colspan="8"><b>Total Gross Amount : </b></td>
												<td colspan="3"><b><fmt:formatNumber value="${total_gross_amount}" maxFractionDigits="2" groupingUsed="false"/></b></td>
											</tr>
											<tr class="text-right">
												<td colspan="8"><b>Total Net Amount : </b></td>
												<td colspan="3"><b>${total_netamount}</b></td>
											</tr>	
											</tbody>	               				               				
               						</table>
               					</c:when>
               					<c:otherwise>
               						<table class="table table-bordered" id="example-2">
			               				<thead>
								<tr style="background-color: #741d7a;color: white;" class="text-center">
			               					<td></td>
			               					<td></td>
			               					<td></td>
			               					<td colspan="7" class="text-center">
			               						<h3>INVOICE REPORT</h3>
			               					</td>
			               					<td></td>
			               					<td></td>
			               					<td></td>
			               					<td></td>
			               				</tr>
							
			               				<tr style="background-color: #4b9663;color: white;">
			               					 <td>Date</td>
			               					<td>Invoice Id</td>
			               					<td>Customer</td>
			               					<td class="d-none">GSTIN No</td>
			               					<td>Site Name</td>
			               					<td class="d-none">Site Address</td>
			               					<td>Grade</td>
											<td class="d-none">HSN Code</td>
			               					<td>Quantity</td>
			               					<td>Rate</td>
			               					<td>Gross Amount</td>
			               					<td>Tax Amount</td>
			               					<td class="d-none">CGST</td>
			               					<td class="d-none">SGST</td>
			               					<td class="d-none">IGST</td>
			               					<td>Net Amount</td>
			               					<td>Plant Name</td>
			               					<td class="d-none">Billing Address</td>
			               					<td class="d-none">Marketing Person</td>
			               					<td class="d-none">Pump/Supply</td>
			               					<td>Time</td>
			               					<td>Vehicle No</td>
			               					<td>Select All<br><input type="checkbox" class="id" id="selectall"/></td>
			               					
			               				</tr>
			               				</thead>
			               				<c:set value="0" var="tot_netquant"/>
			               				<c:set value="0" var="tot_gross"/>
			               				<c:set value="0" var="tot_tax"/>
			               				<c:set value="0" var="tot_net"/>
			               				<tbody>
			               				<c:set value="false" var="view"/>
			               				<c:set value="0" var="invID"/>
			               				<c:forEach items="${inv.rows}" var="inv">
			               					<c:choose>
			               						<c:when test="${val==0}">
			               							<c:set value="true" var="view"/>
			               							<c:set value="${inv.invoice_id}" var="invID"/>
			               						</c:when>
			               						<c:when test="${val!=0 && invID==inv.invoice_id}">
			               							<c:set value="false" var="view"/>
			               						</c:when>
			               						<c:when test="${val!=0 &&  invID!=inv.invoice_id}">
			               							<c:set value="true" var="view"/>
			               							<c:set value="${inv.invoice_id}" var="invID"/>
			               						</c:when>
			               					</c:choose>
			               					
			               					<c:set value="${tot_netquant+inv.item_quantity}" var="tot_netquant"/>
				               				<c:set value="${tot_gross+inv.gross_price}" var="tot_gross"/>
				               				<c:set value="${tot_tax+inv.tax_price}" var="tot_tax"/>
				               				<c:set value="${tot_net+inv.net_price}" var="tot_net"/>
				               				
			               					<tr>
			               						<c:if test="${view==true}">
			               						<td rowspan="${inv.count}" style="text-align: center;vertical-align: middle !important;">${inv.invoice_date}</td>
				               					<td rowspan="${inv.count}" style="text-align: center;vertical-align: middle !important;"><a href="PrintSalesDocument.jsp?id=${inv.id}" target="_blank">${inv.invoice_id}</a></td>
				               					<td rowspan="${inv.count}" style="text-align: center;vertical-align: middle !important;">${inv.customer_name}</td>
				               					<td class="d-none" rowspan="${inv.count}" style="text-align: center;vertical-align: middle !important;">${inv.customer_gstin}</td>
				               					<td rowspan="${inv.count}" style="text-align: center;vertical-align: middle !important;">${inv.site_name}</td>
				               					<td class="d-none" rowspan="${inv.count}" style="text-align: center;vertical-align: middle !important;">${inv.site_address}</td>
				               					</c:if>
				               					<td style="background-color: ${(inv.count>1)?'#fcffff':''}">${inv.product_name}</td>
												<td class="d-none" style="background-color: ${(inv.count>1)?'#fcffff':''}">38245010</td>
				               					<td style="background-color: ${(inv.count>1)?'#fcffff':''}">${inv.item_quantity}</td>
				               					<c:choose>
													<c:when test="${inv.rate_include_tax=='yes'}">
														<td style="background-color: ${(inv.count>1)?'#fcffff':''}"><fmt:formatNumber value="${(inv.item_price/118)*100}" maxFractionDigits="2" groupingUsed="false"/></td>
													</c:when>
													<c:otherwise>
														<td style="background-color: ${(inv.count>1)?'#fcffff':''}"><fmt:formatNumber value="${inv.item_price}" maxFractionDigits="2" groupingUsed="false"/></td>
													</c:otherwise>
												</c:choose>
				               					<td style="background-color: ${(inv.count>1)?'#fcffff':''}">${inv.gross_price}</td>
				               					<td style="background-color: ${(inv.count>1)?'#fcffff':''}">${inv.tax_price}</td>
				               					<c:choose>
				               						<c:when test="${inv.gst_category=='GST'}">
				               						<td class="d-none" style="text-align: center;vertical-align: middle !important;"><fmt:formatNumber value="${inv.tax_price/2}" groupingUsed="false" maxFractionDigits="2"/></td>
				               						<td class="d-none" style="text-align: center;vertical-align: middle !important;"><fmt:formatNumber value="${inv.tax_price/2}" groupingUsed="false" maxFractionDigits="2"/></td>
				               						<td class="d-none" style="text-align: center;vertical-align: middle !important;">0</td>
				               						</c:when>
				               						<c:otherwise>
				               						<td class="d-none" style="text-align: center;vertical-align: middle !important;">0</td>
				               						<td class="d-none" style="text-align: center;vertical-align: middle !important;">0</td>
				               						<td class="d-none" style="text-align: center;vertical-align: middle !important;"><fmt:formatNumber value="${inv.tax_price}" groupingUsed="false" maxFractionDigits="2"/></td>
				               						
				               						</c:otherwise>
				               					</c:choose>
				               					<td style="background-color: ${(inv.count>1)?'#fcffff':''}">${inv.net_price}</td>
				               					<c:if test="${view==true}">
				               					<td rowspan="${inv.count}" style="text-align: center;vertical-align: middle !important;">${inv.plant_name}</td>
				               					<td class="d-none"
				               						style="text-align: center;vertical-align: middle !important;" rowspan="${inv.count}">${inv.customer_address}</td>
				               					<td class="d-none" 
				               						style="text-align: center;vertical-align: middle !important;" rowspan="${inv.count}">${inv.mp_name}</td>
				               					<td class="d-none"
				               						style="text-align: center;vertical-align: middle !important;" rowspan="${inv.count}">${inv.pump}</td>
				               					<td style="text-align: center;vertical-align: middle !important;"
				               						rowspan="${inv.count}">${inv.invoice_time}</td>
				               					<td rowspan="${inv.count}" 
				               						style="text-align: center;vertical-align: middle !important;">${inv.vehicle_no}</td>
				               					<td rowspan="${inv.count}"
				               					    style="text-align: center;vertical-align: middle !important;"><input type="checkbox" id="id"  class="id idcls" name="idd" value="${inv.id}"/></td>
				               					</c:if>
				               				</tr>
			               				</c:forEach>
			               				</tbody>
								<tfoot>
			               					<tr style="background-color: #70643b;color: white;">
			               						<td colspan="5" class="text-right">Total : </td>
			               						<td colspan="1" class="text-left">
			               							<fmt:formatNumber value="${tot_netquant}" maxFractionDigits="2" groupingUsed="false"/>
			               						</td>
			               						<td colspan="1" class="text-right"></td>
			               						<td colspan="1" class="text-left">
			               							<fmt:formatNumber value="${tot_gross}" groupingUsed="false" maxFractionDigits="2"/>
			               						</td>
			               						<td colspan="1" class="text-left"><fmt:formatNumber value="${tot_tax}" groupingUsed="false" maxFractionDigits="2"/></td>
			               						<td colspan="1" class="text-left"><fmt:formatNumber value="${tot_net}" groupingUsed="false" maxFractionDigits="2"/></td>
			               						<td></td>
			               						<td></td>
			               						<td></td>
			               						<td></td>
			               					</tr>
								</tfoot>
			               			</table>
               					</c:otherwise>
               				</c:choose>
               			
               			
               		</div>
               	</div>
               	</form>
               </c:if>
              	
                <!-- end row -->
            </div> <!-- end container -->
        </div>
        
        		
         <!-- Modal for tally ladger save  -->
         		<a class="dropdown-item" id="tally-click" style="display: none;" href="#tally_modal" data-animation="blur" data-plugin="custommodal"  data-overlaySpeed="100" data-overlayColor="#36404a"><i class="fa fa-pencil mr-2 text-muted font-18 vertical-middle"></i>Change Docket No</a>
				<div id="tally_modal" class="modal-demo col-xs-2">
		            <button type="button" class="close" onclick="Custombox.close();">
		                <span>&times;</span><span class="sr-only">Close</span>
		            </button>
		            <h4 class="custom-modal-title text-uppercase" style="color: white;background-color: #28afa0;"><b>Update Tally Ledger</b></h4>
		            <div class="custom-modal-text">
		                <form class="form-horizontal" action="SalesDocumentController?action=UpdateTallyLedger" method="post">
		                	<table class="table table-bordered" id="ledger">
		                		<thead>
		                			<tr style="background-color: #c100db;color: white;">
		                				<th>Customer</th>
		                				<th>Site Name</th>
		                				<th>Tally Ledger</th>
		                			</tr>
		                		</thead>
		                		<tbody>
		            				    			
		                		</tbody>
		                		<tfoot>
		                			<tr>
		                				<td colspan="3">
		                					<button class="btn w-lg btn-rounded btn-custom waves-effect waves-light" type="submit">SAVE TALLY LEDGER</button>
		                            		<button class="btn w-lg btn-rounded btn-custom btn-danger waves-effect waves-light"  onclick="Custombox.close();" type="button">CANCEL</button>
		                				</td>
		                			</tr>
		                		</tfoot>
		                	</table>
		                	
		                </form>
		            </div>
		        </div>
        <!-- Modal ends here -->
        
        
        <!-- Modal for Pumpchange and adavance amount save  -->
				<div id="amount-click" class="modal-demo col-xs-2">
		            <button type="button" class="close" onclick="Custombox.close();">
		                <span>&times;</span><span class="sr-only">Close</span>
		            </button>
		            <h4 class="custom-modal-title text-uppercase" style="color: white;background-color: #2b9649;"><b>Generate Consolidate Invoice</b></h4>
		            <div class="custom-modal-text">
						<div class="form-group">
							<label class="pull-left">Plant<span class="text-danger">*</span></label>
							<sql:query var="plant" dataSource="jdbc/rmc">
								select plant_id,plant_name
								from plant
							    where plant_id like if(0=?,'%%',?)
							    and business_id like if(0=?,'%%',?)
								<sql:param value="${bean.plant_id}"/>
								<sql:param value="${bean.plant_id}"/>
								<sql:param value="${bean.business_id}"/>
								<sql:param value="${bean.business_id}"/>
							</sql:query>
							<select id="pl_id" class="form-control">
								<c:forEach items="${plant.rows}" var="plant">
									<option value="${plant.plant_id}">${plant.plant_name}</option>
								</c:forEach>
							</select>							
						</div>
						<div class="form-group">
							<label class="pull-left">Reference No :</label>
							<input type="text"  class="form-control" id="reference_no"/>
						</div>
                        <div class="form-group">
                              <label class="pull-left">Generate Date<span class="text-danger">*</span></label>
                              <div class="input-group">
                                  <input type="text"    class="form-control date-picker generate_date"
                                  	 required="required" placeholder="dd/mm/yyyy"
                                  	 id="id-date-picker-1" data-date-format="dd/mm/yyyy"
                                  	 readonly="readonly" style="background-color: white;"/>
                                  <div class="input-group-append picker">
                                      <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
                                  </div>
                              </div>
                         </div>
						<div class="form-group">
							<button class="btn btn-success" type="button" id="submit-btn">Submit</button>
						</div>
		            </div>
		        </div>
        <!-- Modal ends here -->
        

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
		<script src="js/Pickers/dateTimeValidatorEdit.js"></script>
		
		<!-- Modal-Effect -->
        <script src="plugins/custombox/js/custombox.min.js"></script>
        <script src="plugins/custombox/js/legacy.min.js"></script>
		<script type="text/javascript">
	    $("#myform").submit(function(e){
	        e.preventDefault();
	        var report_type=$('#report_type').val();
	        if(report_type=='date'){
	        	var from_date=$('.from_date').val();
	        	var to_date=$('.to_date').val();
	        	var product_id=$('#product_id').val();
	        	var plant_id=$('#plant_id').val();
	        	window.location="SalesDocumentReportBulk.jsp?action=generateReport&report_type="+report_type+"&from_date="+from_date+"&to_date="+to_date+"&product_id="+product_id+"&plant_id="+plant_id;
	        }else if(report_type=='customer'){
	        	var customer_id=$('#customer_id').val();
	        	var site_id=$('#site_id').val();
	        	var product_id=$('#product_id').val();
	        	var plant_id=$('#plant_id').val();
	        	var block_name=$('#block_name').val();
	        	window.location="SalesDocumentReportBulk.jsp?action=generateReport&report_type="+report_type+"&customer_id="+customer_id+"&site_id="+site_id+"&product_id="+product_id+"&plant_id="+plant_id+"&block_name="+block_name;
	        }else if(report_type=='vehicle'){
	        	var vehicle_no=$('#vehicle_no').val();
	            var product_id=$('#product_id').val();
	            var plant_id=$('#plant_id').val();
	            window.location="SalesDocumentReportBulk.jsp?action=generateReport&report_type="+report_type+"&vehicle_no="+vehicle_no+"&product_id="+product_id+"&plant_id="+plant_id;
	        }else if(report_type=='customerdate'){
	        	var from_date=$('.from_date').val();
	        	var to_date=$('.to_date').val();
	        	var customer_id=$('#customer_id').val();
	        	var site_id=$('#site_id').val();
	        	var product_id=$('#product_id').val();
	        	var plant_id=$('#plant_id').val();
	        	var block_name=$('#block_name').val();
	        	window.location="SalesDocumentReportBulk.jsp?action=generateReport&report_type="+report_type+"&from_date="+from_date+"&to_date="+to_date+"&customer_id="+customer_id+"&site_id="+site_id+"&product_id="+product_id+"&plant_id="+plant_id+"&block_name="+block_name;
	        }else if(report_type=='vehicledate'){
	        	var vehicle_no=$('#vehicle_no').val();
	        	var from_date=$('.from_date').val();
	        	var to_date=$('.to_date').val();
	        	var product_id=$('#product_id').val();
	        	var plant_id=$('#plant_id').val();
	        	window.location="SalesDocumentReportBulk.jsp?action=generateReport&report_type="+report_type+"&from_date="+from_date+"&to_date="+to_date+"&vehicle_no="+vehicle_no+"&product_id="+product_id+"&plant_id="+plant_id+"&block_name="+block_name;
	        }else if(report_type=='marketing'){
	        	var mp_id=$('#mp_id').val();
	        	var from_date=$('.from_date').val();
	        	var to_date=$('.to_date').val();
	        	var product_id=$('#product_id').val();
	        	var plant_id=$('#plant_id').val();
	        	window.location="SalesDocumentReportBulk.jsp?action=generateReport&report_type="+report_type+"&from_date="+from_date+"&to_date="+to_date+"&mp_id="+mp_id;
	        }
			
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
    			}else if(report_type=='customer'){
    				$('.cus').prop('disabled',false);
    				$('.no-cus').prop('disabled',true);
    				$('.cus').show();
    				$('.no-cus').hide();
    			}else if(report_type=='vehicle'){
    				$('.veh').prop('disabled',false);
    				$('.no-veh').prop('disabled',true);
    				$('.veh').show();
    				$('.no-veh').hide();
    			}else if(report_type=='customerdate'){
    				$('.cus-dat').prop('disabled',false);
    				$('.no-cus-dat').prop('disabled',true);
    				$('.cus-dat').show();
    				$('.no-cus-dat').hide();
    			}else if(report_type=='vehicledate'){
    				$('.veh-dat').prop('disabled',false);
    				$('.no-veh-dat').prop('disabled',true);
    				$('.veh-dat').show();
    				$('.no-veh-dat').hide();
    			}else if(report_type=='marketing'){
    				$('.mar').prop('disabled',false);
    				$('no-mar').prop('disabled',true);
    				$('.mar').show();
    				$('.no-mar').hide();
    			}
    			
    			if(report_type=='date'){
    				$('#tally').show();
    			}else{
    				$('#tally').hide();
    			}
    		};
    		
    		//call the method for render of report type here
    		var report=get('report_type');
    		//alert(report);
    		changeType(report);
    		
    		
    	});
    	
    	
    	function get(name){
    		   if(name=(new RegExp('[?&]'+encodeURIComponent(name)+'=([^&]*)')).exec(location.search))
    		      return decodeURIComponent(name[1]);
    		}
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
    	});
    </script>
    
    <script type="text/javascript">
    	$(document).ready(function(){
    		$('#site_id').on('change',function(){
    			var site_id=$('#site_id').val();
    			$.ajax({
    				type:'POST',
    				url:'CustomerController?action=getProjectBlocks&site_id='+site_id,
    				headers:{
    					Accept:"application/json;charset=utf-8",
    					"Content-Type":"application/json;charset=utf-8"
    				},
    				success:function(result){
    					$('#select2-block_name-container').html('Choose Block');
    					$('#block_name').html('');
    	        		$('#block_name').html('<option value="">Choose Block</option>');
    	        		$.each(result, function(index, value) {
    	        			   $('#block_name').append("<option value='"+ value.block_name+ "'>" + value.block_name+ "</option>");
    	        		});
    				}
    			});
    		});
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
	    function GetURLParameter(sParam)
	    {
	        var sPageURL = window.location.search.substring(1);
	        var sURLVariables = sPageURL.split('&');
	        for (var i = 0; i < sURLVariables.length; i++) 
	        {
	            var sParameterName = sURLVariables[i].split('=');
	            if (sParameterName[0] == sParam) 
	            {
	                return sParameterName[1];
	            }
	        }
	    }
    </script>
    <script type="text/javascript">
    	$(document).ready(function(){
    		$('#tally').on("click",function(){
    			var report_type=GetURLParameter('report_type');
    			var customer_id=GetURLParameter('customer_id');
    			var from_date=GetURLParameter('from_date');
    			var to_date=GetURLParameter('to_date');
    			var site_id=GetURLParameter('site_id');
    			var product_id=GetURLParameter('product_id');
    			var plant_id=GetURLParameter('plant_id');
    			var vehicle_no=GetURLParameter('vehicle_no');
    			$.ajax({
    				type:'POST',
    				url:'SalesDocumentController?action=TallyXml&report_type='+report_type+'&customer_id='+customer_id+'&from_date='+from_date+'&to_date='+to_date+'&site_id='+site_id+'&product_id='+product_id+'&plant_id='+plant_id+'&vehicle_no='+vehicle_no,
    				headers:{
    					Accept:"application/json;charset=utf-8",
    				    "Content-Type":"application/json;charset=utf-8"
    				},
    				success:function(res){
    					$('#ledger tbody').html("");
    					var count=0;
    					$.each(res, function(index, value) {
            				count++;
            				var row='<tr>';
            				row+='<td>'+value.name+'<input type="hidden" name="site_id" value="'+index+'"></td><td>'+value.address+'</td><td><input type="text" class="col-xs-12" name="tally_ladger"></td>'
            				row+='</tr>'
            			  $('#ledger tbody').append(row);
    	        		});
    					if(count>0){
    						$('#tally-click').trigger('click');
    					}else{
    						window.location.href='TallySalesXML.jsp?report_type='+report_type+'&customer_id='+customer_id+'&from_date='+from_date+'&to_date='+to_date+'&site_id='+site_id+'&product_id='+product_id+'&plant_id='+plant_id+'&vehicle_no='+vehicle_no;
    					}
    				}
    			})
    		});
    	});
    </script>
    <script type="text/javascript">
    	$(document).ready(function(){
    		$('#selectall').on("change",function(){
    			if($(this).is(":checked")){
    				$('.id').prop("checked",true);
    			}else{
    				$('.id').prop("checked",false);
    			}
    		});
    		
    		
    		/* check if any check box has been clicked */
    		$('.id').on("change",function(){
    			var count=0;
    			$('.idcls:checkbox').each(function(){
    				if($(this).is(':checked')){
    					count=count+1;
    				}
    			});
    			
    			if(count>0){
					$('#consoldate_invoice').show();
					$('#sales_document').show();
				}else{
					$('#consoldate_invoice').hide(); 
					$('#sales_document').hide();
				}
    		});
    		
    	});
    </script>
    
    <script type="text/javascript">
    	$(document).ready(function(){
    		$('#submit-btn').on("click",function(){
    			$('#pump_charge').val(($('#pmp_chrg').val()=='')?0:$('#pmp_chrg').val());
    			$('#advance_amount').val(($('#adv_amt').val()=='')?0:$('#adv_amt').val());
    			$('#plnt_id').val($('#pl_id').val());
    			$('#ref_no').val($('#reference_no').val());
    			if($('.generate_date').val()=='' || $('.generate_date').val()==null){
    				alert('Please select generate date');
    				return false;    				
    			}
    			$('#gen_date').val($('.generate_date').val());
    			$('#myfrm').submit();
    		});
    	});
    </script>
    <script type="text/javascript">
	$(document).ready(function() {

  function exportTableToCSV($table, filename) {

    var $rows = $table.find('tr:has(td)'),

      // Temporary delimiter characters unlikely to be typed by keyboard
      // This is to avoid accidentally splitting the actual contents
      tmpColDelim = String.fromCharCode(11), // vertical tab character
      tmpRowDelim = String.fromCharCode(0), // null character

      // actual delimiter characters for CSV format
      colDelim = '","',
      rowDelim = '"\r\n"',

      // Grab text from table into CSV formatted string
      csv = '"' + $rows.map(function(i, row) {
        var $row = $(row),
          $cols = $row.find('td');

        return $cols.map(function(j, col) {
          var $col = $(col),
            text = $col.text();

          return text.replace(/"/g, '""'); // escape double quotes

        }).get().join(tmpColDelim);

      }).get().join(tmpRowDelim)
      .split(tmpRowDelim).join(rowDelim)
      .split(tmpColDelim).join(colDelim) + '"';

    // Deliberate 'false', see comment below
    if (false && window.navigator.msSaveBlob) {

      var blob = new Blob([decodeURIComponent(csv)], {
        type: 'text/csv;charset=utf8'
      });

      // Crashes in IE 10, IE 11 and Microsoft Edge
      // See MS Edge Issue #10396033
      // Hence, the deliberate 'false'
      // This is here just for completeness
      // Remove the 'false' at your own risk
      window.navigator.msSaveBlob(blob, filename);

    } else if (window.Blob && window.URL) {
      // HTML5 Blob        
      var blob = new Blob([csv], {
        type: 'text/csv;charset=utf-8'
      });
      var csvUrl = URL.createObjectURL(blob);

      $(this)
        .attr({
          'download': filename,
          'href': csvUrl
        });
    } else {
      // Data URI
      var csvData = 'data:application/csv;charset=utf-8,' + encodeURIComponent(csv);

      $(this)
        .attr({
          'download': filename,
          'href': csvData,
          'target': '_blank'
        });
    }
  }

  // This must be a hyperlink
  $("#downloadExcel").on('click', function(event) {
    // CSV
    var args = [$('#example-2'), 'export.csv'];

    exportTableToCSV.apply(this, args);

    // If CSV, don't do event.preventDefault() or return false
    // We actually need this to be a typical hyperlink
  });
});

    </script>
<a id="downloadAnchorElem" style="display:none"></a>
<script type="text/javascript">
	$(document).ready(function(){
		var arr=[];
		$('#downloadInJson').on('click',function(){
			$('#example-2 tbody tr').each(function(){
				var invoice = {
						'invoice_date':$(this).find('td').eq(0).text(),
						'invoice_no':$(this).find('td').eq(1).find('a').text(),
						'customer_name':$(this).find('td').eq(2).text(),
						'GSTIN No.':$(this).find('td').eq(3).text(),
						'site_name':$(this).find('td').eq(4).text(),
						'site_address':$(this).find('td').eq(5).text(),
						'Grade':$(this).find('td').eq(6).text(),
						'HSN Code':$(this).find('td').eq(7).text(),
						'quantity':$(this).find('td').eq(8).text(),
						'rate':$(this).find('td').eq(9).text(),
						'gross_amount':$(this).find('td').eq(10).text(),
						'tax_amount':$(this).find('td').eq(11).text(),
						'cgst':$(this).find('td').eq(12).text(),
						'sgst':$(this).find('td').eq(13).text(),
						'igst':$(this).find('td').eq(14).text(),
						'net_amount':$(this).find('td').eq(15).text(),
						'plant_name':$(this).find('td').eq(16).text(),
						'billing_address':$(this).find('td').eq(17).text(),
						'Marketing Person':$(this).find('td').eq(18).text(),
						'pump':$(this).find('td').eq(19).text(),
						'time':$(this).find('td').eq(20).text(),
						'vehicle_no':$(this).find('td').eq(21).text()
				}
				arr.push(invoice);
			});
			var dataStr = "data:text/json;charset=utf-8," + encodeURIComponent(JSON.stringify(arr));
			var dlAnchorElem = document.getElementById('downloadAnchorElem');
			dlAnchorElem.setAttribute("href",     dataStr     );
			dlAnchorElem.setAttribute("download", "InvoiceReport.json");
			dlAnchorElem.click();
		});
	});
</script>
		
    </body>
</html>