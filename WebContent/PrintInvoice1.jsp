<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
	<title></title>
		<!-- Latest compiled and minified CSS -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	

	<style type="text/css">
		
		.table tr td{
			border:1px solid black;
			font-size:12px !important;
		}
		
		@media print {
			.no-print, .no-print * {
				display: none !important;
			}
			
			.print-me{
				display: block !important;
			}
		}
		.nopadding {
		   padding: 0 !important;
		   margin: 0 !important;
		}

		.table>thead>tr>th,.table>tbody>tr>th,.table>tfoot>tr>th,.table>thead>tr>td,.table>tbody>tr>td,.table>tfoot>tr>td{
			padding:1.7px;
		}
		
	</style>
	<style type="text/css">
 .main{ top: 100%; left: 100%;}
</style>
<sql:query var="comp" dataSource="jdbc/rmc">
	select * from company_detail where company_id=1
</sql:query>
<c:forEach items="${comp.rows}" var="comp">
	<c:set value="${comp}" var="company"/>
</c:forEach>
		 
</head>

<body>
	<div class="container">
	<sql:query var="dc" dataSource="jdbc/rmc">
			 select i.*,round(i.gst_percent/2,2) as txx,DATE_FORMAT(i.invoice_date,'%d/%m/%Y') as invoice_date,c.customer_name,c.customer_address,s.site_name,s.site_address,p.plant_address
									from invoice i LEFT JOIN (customer c,site_detail s,plant p)
									ON i.customer_id=c.customer_id
									and i.site_id=s.site_id
									and i.plant_id=p.plant_id
									where i.id=?
									
			 <sql:param value="${param.id}"/>
		</sql:query>
			<c:forEach var="dc" items="${dc.rows}">
			<div class="row">
				
				<table class="table table-condensed">
				<thead>	
					<tr>
						<td colspan="2" style="border-left: 1px solid white;border-right: 1px solid white;">
							<img src="image/renuka.jpg" alt="user" width="80" height="100" class="rounded-circle pull-left">
						</td>
						<td colspan="5" style="border-left: 1px solid white;border-right: 1px solid white;">
							
						
							<h2 class="text-center"><b>SHREE RENUKA BUILDCON</b></h2>
							<h4 class="text-center">Wholesale Dealers in cement & steel</h4>
							<h4 class="text-center"><b>DELIVERY CHALLAN CUM TAX-INVOICE ORIGINAL</b></h4>
						</td>
						<td colspan="2" style="border-left: 1px solid white;border-right: 1px solid white;">
							<img src="image/renukaenterprises.PNG" alt="user" width="80" height="100" class="rounded-circle pull-right"><br>
							<h4>ORIGINAL</h4>
						</td>
					</tr>	
					<tr>
						<td class="text-center"  colspan="4" rowspan="1"style="border:1px solid black;"><h5><b>Registered Office</b></h5></td>
						<td class="text-center"  colspan="2" rowspan="1" style="border:1px solid black;"><h5><b>Customer Ref</b></h5></td>
						<td class="text-center"  colspan="5" rowspan="1" style="border:1px solid black;"><h5><b>Invoice Information</b></h5></td>						
					</tr>
					<tr>
						<td colspan="4" rowspan="4">					 												
									<p >
										${dc.plant_address}<br>
										Mobile Number:${company.company_phone}<br>	
										Accounts:7022612202<br>								    
										Email: ${company.company_mail}<br>
										<b>GSTIN: ${company.gstin_number}</b><br>
										PAN NO: ${company.pan_number}										
									</p>	
								
						 	
						</td>
						<td  colspan="2" rowspan="4">
							<sql:query var="contact" dataSource="jdbc/rmc">
								select * from customer_contact_person where contact_id=?
								<sql:param value="${dc.contact_id}"/>
							</sql:query>
							<c:forEach items="${contact.rows}" var="contact">
								<c:set value="${contact}" var="con"/>
							</c:forEach>
							<div>								
								<p>								
									PO:${dc.po_number}<br>	
									PO Date:${dc.po_date}<br>								    
									Ordered By: ${con.contact_name}<br>
									Mobile No : ${con.phone}<br>
									Marketing By : 	${dc.sales_person}								
								</p>
							</div>
						</td>
						<td   colspan="4" rowspan="4">
							<div>					
								<p>								
									Invocie No:${dc.invoice_id}<br>								    
									Date:${dc.invoice_date}<br>
									<b>E-Way Bill No: ${dc.eway_bill}</b><br>
									Dispatch Depo: ${dc.dispatch_name}<br>
									Vehicle No: ${dc.vehicle_no}<br>
									Transport name: ${dc.tansport_name}<br>
									Driver Name : ${dc.driver_name}
								</p>		
							</div>						
						</td>						
					</tr>
					
					</thead>
				
					<tbody>
					
						<tr>
						<td class="text-center" colspan="5" style="border:1px solid black;"><h5><b>Customer Billing Address</b></h5></td>
						<td class="text-center" colspan="7" style="border:1px solid black;"><h5><b>Customer Shipping Address</b></h5></td>
												
					</tr>
					<tr>
						<td colspan="5"><p><b>${dc.customer_name}</b></p>
						 <p>${dc.customer_address}</p></td>
						<td colspan="6"><p><b>${dc.site_name}</b></p>
						${dc.site_address}</td>
												
					</tr>
					 <sql:query var="inv" dataSource="jdbc/rmc">
                      	select f.*,(select fleet_sub_item_name from fleet_sub_item where fleet_sub_item_id=f.fleet_sub_item_id) as fleet_sub_item_name
                      	,fi.item_name,fi.hsn_code,fi.description from invoice_item f left join fleet_item fi
                      	 on f.fleet_item_id=fi.fleet_item_id
                      	 where id=?
                      	<sql:param value="${dc.id}"/>
                      </sql:query>
					<tr class="text-center">					
						<td style="width:5%;">
							<b>S/L No</b>
						</td>
						<td colspan="2" style="width:20%;">
							<b>Description of Goods</b>
						</td>
						<td style="width:10%;"> <b>Grade</b></td>
						<td>
							<b>HSN CODE</b>
						</td>
						
						<td style="6%;">
							<b>QTY</b>
						</td>
						<td style="width:15%;">
							<b>RATE</b>
						</td>
						<td style="width:15%;">
							<b>Taxable Amount</b>
						</td>
						
						
					</tr>
					
					<c:set value="0" var="count"/>
					<c:set value="" var="code"/>
					<c:set value="0" var="total_gross"/>
					<c:set value="0" var="total_tax"/>
					<c:set value="0" var="total_net"/>
					<c:forEach items="${inv.rows}" var="fit">
					<c:set value="${count+1}" var="count"/>
					<c:set value="${total_gross+fit.quantity*fit.rate}" var="total_gross"/>
					<c:set value="${total_tax+(fit.quantity*fit.rate)*(dc.gst_percent/100)}" var="total_tax"/>
					<tr>
					<td>${count}</td>
					<td colspan="2">${fit.item_name}</td>
					<td>${fit.fleet_sub_item_name}</td>
					<td>${fit.hsn_code}</td>
					<td><fmt:formatNumber value="${fit.quantity}"  minFractionDigits="2" groupingUsed="false"/> <br></td>
					<td>${fit.rate}</td>
					<td>${fit.quantity*fit.rate}</td>
				
					</tr>
					</c:forEach>
				
				<tr>
					<td colspan="5" rowspan="6" style="padding-top:10px;">
						Amount In Words:<br>						
						<input type="hidden" id="get_percent_word_total" value="<fmt:formatNumber value="${total_gross+total_tax}" maxFractionDigits="2" groupingUsed="false"/>" >
						<p>Grand Total Rupees:  <span class="in-word"></span> Only</p>
					</td>
					<td colspan="2" rowspan="1">Sub Total</td>
					<td colspan="2" rowspan="1" >${total_gross}</td>	
				</tr>
				<tr>
					<td colspan="2" rowspan="1">CGST @ ${(dc.gst_type=='GST')?dc.txx:0} %</td>
					<td colspan="2" rowspan="1">
						<c:choose>
							<c:when test="${dc.gst_type=='GST'}">
								<fmt:formatNumber value="${total_tax/2}" maxFractionDigits="2" minFractionDigits="2" groupingUsed="false"/>
							</c:when>
							<c:otherwise>
								0
							</c:otherwise>
						</c:choose>
						
					</td>
				</tr>
				<tr>
					<td colspan="2" rowspan="1">SGST @ ${(dc.gst_type=='GST')?dc.txx:0} %</td>
					<td colspan="2" rowspan="1">
						<c:choose>
							<c:when test="${dc.gst_type=='GST'}">
								<fmt:formatNumber value="${total_tax/2}" maxFractionDigits="2" minFractionDigits="2" groupingUsed="false"/>
							</c:when>
							<c:otherwise>
								0
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
				<tr>
					<td colspan="2" rowspan="1">IGST @ ${(dc.gst_type=='GST')?0:dc.tax_percent} %</td>
					<td colspan="2" rowspan="1">
						<c:choose>
							<c:when test="${dc.gst_type=='GST'}">
								0
							</c:when>
							<c:otherwise>
								<fmt:formatNumber value="${total_tax}" maxFractionDigits="2" minFractionDigits="2" groupingUsed="false"/>
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
				<tr>
					<td colspan="2" rowspan="1">Round Off</td>
					<td colspan="2" rowspan="1">${fit.adjustment}</td>
				</tr>
				<tr>
					<td colspan="2" rowspan="1">Grand Total</td>
					<td colspan="2" rowspan="1">
						<fmt:formatNumber value="${total_gross+total_tax+fit.adjustment}" maxFractionDigits="2" groupingUsed="true"/>
					</td>
				</tr>
				<tr>
					<td colspan="12" style="padding-top:10px;">
					<b>TERMS &amp; CONDITION :</b>
						<ol>
							<li>Goods once sold will not be taken back or exchanged.</li>
							<li>Seller is not responsible for any loss or damage of goods in transit.</li>
							<li>Intrest @ 24% p.a is applicable for delayed payment of the invoice.</li>
							<li>Dispute,if any will be subject to seller court jurisdiction.</li>
							<li>We declare that this invoice shows the actual price of the goods described and that all particulars are true and correct.</li>							
							<li>Received the above materials in good condition: YES/NO</li>
						</ol>
						
						<ol>
							<b>BANK DETAILS</b>							
							<li>BANK: Axis Bank Limited, A/C:915030047879919, Branch :Corporate Banking Branch, BANGALORE, IFSC: UTIB0001541.</li>
						
						</ol>
					</td>
					
				</tr>
				
				<tr>
						<td colspan="4">
						<p><h6>Certificate that the goods on which the GST tax has been changed have not exempted under the GST TAx Act or the rules made there under and the amount charged on Account of GST Tax on these goods are not more than that what is payable under the provisions of the relevant Act or the rules made there under</h6></p><br>
						<h5 class="text-center"><b>E.&O.E.</b></h5>						
						</td>
						<td colspan="2">
						<h5 class="text-center"><br><br><br><b>For Authorised Signatory</b></h5>		
						</td>
						<td colspan="4">
						<h5 class="text-center"><br><br><br><br><b><br><br>&nbsp;&nbsp;&nbsp;&nbsp;Customer Signature with Seal</b></h5>
						</td>
				</tr>				
													
					</tbody>				
				</table>
				<p class="text-center">This is a computer generated invoice doesn't required any seal & signature</p>
				
			</div>
			<div id="" class="no-print" style="text-align: center;">
				<button onclick="window.print()" class="btn btn-primary no-print">PRINT</button>
			</div>
			<div style="page-break-after: always;"></div>
			<div class="row print-me" style="display: none;">
				
						<table class="table table-condensed">
						<thead>
							<tr>
								<td colspan="2" style="border-left: 1px solid white;border-right: 1px solid white;">
									<img src="image/renuka.jpg" alt="user" width="80" height="100" class="rounded-circle pull-left">
								</td>
								<td colspan="5" style="border-left: 1px solid white;border-right: 1px solid white;">
									
								
									<h2 class="text-center"><b>SHREE RENUKA ENTERPRISES</b></h2>
									<h4 class="text-center">Wholesale Dealers in cement & steel</h4>
									<h4 class="text-center"><b>DELIVERY CHALLAN CUM TAX-INVOICE ORIGINAL</b></h4>
								</td>
								<td colspan="2" style="border-left: 1px solid white;border-right: 1px solid white;">
									<img src="image/renukaenterprises.PNG" alt="user" width="80" height="100" class="rounded-circle pull-right"><br>
									<h4>DUPLICATE</h4>
								</td>
							</tr>		
							<tr>
								<td class="text-center"  colspan="4" rowspan="1"style="border:1px solid black;"><h5><b>Registered Office</b></h5></td>
								<td class="text-center"  colspan="2" rowspan="1" style="border:1px solid black;"><h5><b>Customer Ref</b></h5></td>
								<td class="text-center"  colspan="5" rowspan="1" style="border:1px solid black;"><h5><b>Invoice Information</b></h5></td>						
							</tr>
							<tr>
								<td colspan="4" rowspan="4">					 												
											<p >
												${dc.plant_address}<br>
												Mobile Number:${company.company_phone}<br>	
												Accounts:7022612202<br>								    
												Email: ${company.company_mail}<br>
												<b>GSTIN: ${company.gstin_number}</b><br>
												PAN NO: ${company.pan_number}										
											</p>	
										
								 	
								</td>
								<td  colspan="2" rowspan="4">
									<sql:query var="contact" dataSource="jdbc/rmc">
										select * from customer_contact_person where contact_id=?
										<sql:param value="${dc.contact_id}"/>
									</sql:query>
									<c:forEach items="${contact.rows}" var="contact">
										<c:set value="${contact}" var="con"/>
									</c:forEach>
									<div>								
										<p>								
											PO:${dc.po_number}<br>	
											PO Date:${dc.po_date}<br>								    
											Ordered By: ${con.contact_name}<br>
											Mobile No : ${con.phone}<br>
											Marketing By : 	${dc.sales_person}								
										</p>
									</div>
								</td>
								<td   colspan="4" rowspan="4">
									<div>					
										<p>								
											Invocie No:${dc.invoice_id}<br>								    
											Date:${dc.invoice_date}<br>
											<b>E-Way Bill No: ${dc.eway_bill}</b><br>
											Dispatch Depo: ${dc.dispatch_name}<br>
											Vehicle No: ${dc.vehicle_no}<br>
											Transport name: ${dc.tansport_name}<br>
											Driver Name : ${dc.driver_name}
										</p>		
									</div>						
								</td>						
							</tr>
							
							</thead>
						
							<tbody>
							
								<tr>
								<td class="text-center" colspan="5" style="border:1px solid black;"><h5><b>Customer Billing Address</b></h5></td>
								<td class="text-center" colspan="7" style="border:1px solid black;"><h5><b>Customer Shipping Address</b></h5></td>
														
							</tr>
							<tr>
								<td colspan="5"><p><b>${dc.customer_name}</b></p>
								 <p>${dc.customer_address}</p></td>
								<td colspan="6"><p><b>${dc.site_name}</b></p>
								${dc.site_address}</td>
														
							</tr>
							 <sql:query var="inv" dataSource="jdbc/rmc">
		                      	select f.*,(select fleet_sub_item_name from fleet_sub_item where fleet_sub_item_id=f.fleet_sub_item_id) as fleet_sub_item_name
		                      	,fi.item_name,fi.hsn_code,fi.description from invoice_item f left join fleet_item fi
		                      	 on f.fleet_item_id=fi.fleet_item_id
		                      	 where id=?
		                      	<sql:param value="${dc.id}"/>
		                      </sql:query>
							<tr class="text-center">					
								<td style="width:5%;">
									<b>S/L No</b>
								</td>
								<td colspan="2" style="width:20%;">
									<b>Description of Goods</b>
								</td>
								<td style="width:10%;"> <b>Grade</b></td>
								<td>
									<b>HSN CODE</b>
								</td>
								
								<td style="6%;">
									<b>QTY</b>
								</td>
								<td style="width:15%;">
									<b>RATE</b>
								</td>
								<td style="width:15%;">
									<b>Taxable Amount</b>
								</td>
								
								
							</tr>
							
							<c:set value="0" var="count"/>
							<c:set value="" var="code"/>
							<c:set value="0" var="total_gross"/>
							<c:set value="0" var="total_tax"/>
							<c:set value="0" var="total_net"/>
							<c:forEach items="${inv.rows}" var="fit">
							<c:set value="${count+1}" var="count"/>
							<c:set value="${total_gross+fit.quantity*fit.rate}" var="total_gross"/>
							<c:set value="${total_tax+(fit.quantity*fit.rate)*(dc.gst_percent/100)}" var="total_tax"/>
							<tr>
							<td>${count}</td>
							<td colspan="2">${fit.item_name}</td>
							<td>${fit.fleet_sub_item_name}</td>
							<td>${fit.hsn_code}</td>
							<td><fmt:formatNumber value="${fit.quantity}"  minFractionDigits="2" groupingUsed="false"/> <br></td>
							<td>${fit.rate}</td>
							<td>${fit.quantity*fit.rate}</td>
						
							</tr>
							</c:forEach>
						
						<tr>
							<td colspan="5" rowspan="6" style="padding-top:10px;">
								Amount In Words:<br>						
								<input type="hidden" id="get_percent_word_total" value="<fmt:formatNumber value="${total_gross+total_tax}" maxFractionDigits="2" groupingUsed="false"/>" >
								<p>Grand Total Rupees:  <span class="in-word"></span> Only</p>
							</td>
							<td colspan="2" rowspan="1">Sub Total</td>
							<td colspan="2" rowspan="1" >${total_gross}</td>	
						</tr>
						<tr>
							<td colspan="2" rowspan="1">CGST @ ${(dc.gst_type=='GST')?dc.txx:0} %</td>
							<td colspan="2" rowspan="1">
								<c:choose>
									<c:when test="${dc.gst_type=='GST'}">
										<fmt:formatNumber value="${total_tax/2}" maxFractionDigits="2" minFractionDigits="2" groupingUsed="false"/>
									</c:when>
									<c:otherwise>
										0
									</c:otherwise>
								</c:choose>
								
							</td>
						</tr>
						<tr>
							<td colspan="2" rowspan="1">SGST @ ${(dc.gst_type=='GST')?dc.txx:0} %</td>
							<td colspan="2" rowspan="1">
								<c:choose>
									<c:when test="${dc.gst_type=='GST'}">
										<fmt:formatNumber value="${total_tax/2}" maxFractionDigits="2" minFractionDigits="2" groupingUsed="false"/>
									</c:when>
									<c:otherwise>
										0
									</c:otherwise>
								</c:choose>
							</td>
						</tr>
						<tr>
							<td colspan="2" rowspan="1">IGST @ ${(dc.gst_type=='GST')?0:dc.tax_percent} %</td>
							<td colspan="2" rowspan="1">
								<c:choose>
									<c:when test="${dc.gst_type=='GST'}">
										0
									</c:when>
									<c:otherwise>
										<fmt:formatNumber value="${total_tax}" maxFractionDigits="2" minFractionDigits="2" groupingUsed="false"/>
									</c:otherwise>
								</c:choose>
							</td>
						</tr>
						<tr>
							<td colspan="2" rowspan="1">Round Off</td>
							<td colspan="2" rowspan="1">${fit.adjustment}</td>
						</tr>
						<tr>
							<td colspan="2" rowspan="1">Grand Total</td>
							<td colspan="2" rowspan="1">
								<fmt:formatNumber value="${total_gross+total_tax+fit.adjustment}" maxFractionDigits="2" groupingUsed="true"/>
							</td>
						</tr>
						<tr>
							<td colspan="12" style="padding-top:10px;">
							<b>TERMS &amp; CONDITION :</b>
								<ol>
									<li>Goods once sold will not be taken back or exchanged.</li>
									<li>Seller is not responsible for any loss or damage of goods in transit.</li>
									<li>Intrest @ 24% p.a is applicable for delayed payment of the invoice.</li>
									<li>Dispute,if any will be subject to seller court jurisdiction.</li>
									<li>We declare that this invoice shows the actual price of the goods described and that all particulars are true and correct.</li>							
									<li>Received the above materials in good condition: YES/NO</li>
								</ol>
								
								<ol>
									<b>BANK DETAILS</b>							
									<li>BANK: Axis Bank Limited, A/C:915030047879919, Branch :Corporate Banking Branch, BANGALORE, IFSC: UTIB0001541.</li>
								
								</ol>
							</td>
							
						</tr>
						
						<tr>
								<td colspan="4">
								<p><h6>Certificate that the goods on which the GST tax has been changed have not exempted under the GST TAx Act or the rules made there under and the amount charged on Account of GST Tax on these goods are not more than that what is payable under the provisions of the relevant Act or the rules made there under</h6></p><br>
								<h5 class="text-center"><b>E.&O.E.</b></h5>						
								</td>
								<td colspan="2">
								<h5 class="text-center"><br><br><br><b>For Authorised Signatory</b></h5>		
								</td>
								<td colspan="4">
								<h5 class="text-center"><br><br><br><br><b><br><br>&nbsp;&nbsp;&nbsp;&nbsp;Customer Signature with Seal</b></h5>
								</td>
						</tr>				
					</tbody>				
				</table>
				<p class="text-center">This is a computer generated invoice doesn't required any seal & signature</p>
				
			</div>
			
			<div style="page-break-after: always;"></div>
			<div class="row print-me" style="display: none;">
						<table class="table table-condensed">
						<thead>	
							<tr>
								<td colspan="2" style="border-left: 1px solid white;border-right: 1px solid white;">
									<img src="image/renuka.jpg" alt="user" width="80" height="100" class="rounded-circle pull-left">
								</td>
								<td colspan="5" style="border-left: 1px solid white;border-right: 1px solid white;">
									
								
									<h2 class="text-center"><b>SHREE RENUKA ENTERPRISES</b></h2>
									<h4 class="text-center">Wholesale Dealers in cement & steel</h4>
									<h4 class="text-center"><b>DELIVERY CHALLAN CUM TAX-INVOICE ORIGINAL</b></h4>
								</td>
								<td colspan="2" style="border-left: 1px solid white;border-right: 1px solid white;">
									<img src="image/renukaenterprises.PNG" alt="user" width="80" height="100" class="rounded-circle pull-right"><br>
									<h4>TRIPLICATE</h4>
								</td>
							</tr>	
							<tr>
								<td class="text-center"  colspan="4" rowspan="1"style="border:1px solid black;"><h5><b>Registered Office</b></h5></td>
								<td class="text-center"  colspan="2" rowspan="1" style="border:1px solid black;"><h5><b>Customer Ref</b></h5></td>
								<td class="text-center"  colspan="5" rowspan="1" style="border:1px solid black;"><h5><b>Invoice Information</b></h5></td>						
							</tr>
							<tr>
								<td colspan="4" rowspan="4">					 												
											<p >
												${dc.plant_address}<br>
												Mobile Number:${company.company_phone}<br>	
												Accounts:7022612202<br>								    
												Email: ${company.company_mail}<br>
												<b>GSTIN: ${company.gstin_number}</b><br>
												PAN NO: ${company.pan_number}										
											</p>	
										
								 	
								</td>
								<td  colspan="2" rowspan="4">
									<sql:query var="contact" dataSource="jdbc/rmc">
										select * from customer_contact_person where contact_id=?
										<sql:param value="${dc.contact_id}"/>
									</sql:query>
									<c:forEach items="${contact.rows}" var="contact">
										<c:set value="${contact}" var="con"/>
									</c:forEach>
									<div>								
										<p>								
											PO:${dc.po_number}<br>	
											PO Date:${dc.po_date}<br>								    
											Ordered By: ${con.contact_name}<br>
											Mobile No : ${con.phone}<br>
											Marketing By : 	${dc.sales_person}								
										</p>
									</div>
								</td>
								<td   colspan="4" rowspan="4">
									<div>					
										<p>								
											Invocie No:${dc.invoice_id}<br>								    
											Date:${dc.invoice_date}<br>
											<b>E-Way Bill No: ${dc.eway_bill}</b><br>
											Dispatch Depo: ${dc.dispatch_name}<br>
											Vehicle No: ${dc.vehicle_no}<br>
											Transport name: ${dc.tansport_name}<br>
											Driver Name : ${dc.driver_name}
										</p>		
									</div>						
								</td>						
							</tr>
							
							</thead>
						
							<tbody>
							
								<tr>
								<td class="text-center" colspan="5" style="border:1px solid black;"><h5><b>Customer Billing Address</b></h5></td>
								<td class="text-center" colspan="7" style="border:1px solid black;"><h5><b>Customer Shipping Address</b></h5></td>
														
							</tr>
							<tr>
								<td colspan="5"><p><b>${dc.customer_name}</b></p>
								 <p>${dc.customer_address}</p></td>
								<td colspan="6"><p><b>${dc.site_name}</b></p>
								${dc.site_address}</td>
														
							</tr>
							 <sql:query var="inv" dataSource="jdbc/rmc">
		                      	select f.*,(select fleet_sub_item_name from fleet_sub_item where fleet_sub_item_id=f.fleet_sub_item_id) as fleet_sub_item_name
		                      	,fi.item_name,fi.hsn_code,fi.description from invoice_item f left join fleet_item fi
		                      	 on f.fleet_item_id=fi.fleet_item_id
		                      	 where id=?
		                      	<sql:param value="${dc.id}"/>
		                      </sql:query>
							<tr class="text-center">					
								<td style="width:5%;">
									<b>S/L No</b>
								</td>
								<td colspan="2" style="width:20%;">
									<b>Description of Goods</b>
								</td>
								<td style="width:10%;"> <b>Grade</b></td>
								<td>
									<b>HSN CODE</b>
								</td>
								
								<td style="6%;">
									<b>QTY</b>
								</td>
								<td style="width:15%;">
									<b>RATE</b>
								</td>
								<td style="width:15%;">
									<b>Taxable Amount</b>
								</td>
								
								
							</tr>
							
							<c:set value="0" var="count"/>
							<c:set value="" var="code"/>
							<c:set value="0" var="total_gross"/>
							<c:set value="0" var="total_tax"/>
							<c:set value="0" var="total_net"/>
							<c:forEach items="${inv.rows}" var="fit">
							<c:set value="${count+1}" var="count"/>
							<c:set value="${total_gross+fit.quantity*fit.rate}" var="total_gross"/>
							<c:set value="${total_tax+(fit.quantity*fit.rate)*(dc.gst_percent/100)}" var="total_tax"/>
							<tr>
							<td>${count}</td>
							<td colspan="2">${fit.item_name}</td>
							<td>${fit.fleet_sub_item_name}</td>
							<td>${fit.hsn_code}</td>
							<td><fmt:formatNumber value="${fit.quantity}"  minFractionDigits="2" groupingUsed="false"/> <br></td>
							<td>${fit.rate}</td>
							<td>${fit.quantity*fit.rate}</td>
						
							</tr>
							</c:forEach>
						
						<tr>
							<td colspan="5" rowspan="6" style="padding-top:10px;">
								Amount In Words:<br>						
								<input type="hidden" id="get_percent_word_total" value="<fmt:formatNumber value="${total_gross+total_tax}" maxFractionDigits="2" groupingUsed="false"/>" >
								<p>Grand Total Rupees:  <span class="in-word"></span> Only</p>
							</td>
							<td colspan="2" rowspan="1">Sub Total</td>
							<td colspan="2" rowspan="1" >${total_gross}</td>	
						</tr>
						<tr>
							<td colspan="2" rowspan="1">CGST @ ${(dc.gst_type=='GST')?dc.txx:0} %</td>
							<td colspan="2" rowspan="1">
								<c:choose>
									<c:when test="${dc.gst_type=='GST'}">
										<fmt:formatNumber value="${total_tax/2}" maxFractionDigits="2" minFractionDigits="2" groupingUsed="false"/>
									</c:when>
									<c:otherwise>
										0
									</c:otherwise>
								</c:choose>
								
							</td>
						</tr>
						<tr>
							<td colspan="2" rowspan="1">SGST @ ${(dc.gst_type=='GST')?dc.txx:0} %</td>
							<td colspan="2" rowspan="1">
								<c:choose>
									<c:when test="${dc.gst_type=='GST'}">
										<fmt:formatNumber value="${total_tax/2}" maxFractionDigits="2" minFractionDigits="2" groupingUsed="false"/>
									</c:when>
									<c:otherwise>
										0
									</c:otherwise>
								</c:choose>
							</td>
						</tr>
						<tr>
							<td colspan="2" rowspan="1">IGST @ ${(dc.gst_type=='GST')?0:dc.tax_percent} %</td>
							<td colspan="2" rowspan="1">
								<c:choose>
									<c:when test="${dc.gst_type=='GST'}">
										0
									</c:when>
									<c:otherwise>
										<fmt:formatNumber value="${total_tax}" maxFractionDigits="2" minFractionDigits="2" groupingUsed="false"/>
									</c:otherwise>
								</c:choose>
							</td>
						</tr>
						<tr>
							<td colspan="2" rowspan="1">Round Off</td>
							<td colspan="2" rowspan="1">${fit.adjustment}</td>
						</tr>
						<tr>
							<td colspan="2" rowspan="1">Grand Total</td>
							<td colspan="2" rowspan="1">
								<fmt:formatNumber value="${total_gross+total_tax+fit.adjustment}" maxFractionDigits="2" groupingUsed="true"/>
							</td>
						</tr>
						<tr>
							<td colspan="12" style="padding-top:10px;">
							<b>TERMS &amp; CONDITION :</b>
								<ol>
									<li>Goods once sold will not be taken back or exchanged.</li>
									<li>Seller is not responsible for any loss or damage of goods in transit.</li>
									<li>Intrest @ 24% p.a is applicable for delayed payment of the invoice.</li>
									<li>Dispute,if any will be subject to seller court jurisdiction.</li>
									<li>We declare that this invoice shows the actual price of the goods described and that all particulars are true and correct.</li>							
									<li>Received the above materials in good condition: YES/NO</li>
								</ol>
								
								<ol>
									<b>BANK DETAILS</b>							
									<li>BANK: Axis Bank Limited, A/C:915030047879919, Branch :Corporate Banking Branch, BANGALORE, IFSC: UTIB0001541.</li>
								
								</ol>
							</td>
							
						</tr>
						
						<tr>
								<td colspan="4">
								<p><h6>Certificate that the goods on which the GST tax has been changed have not exempted under the GST TAx Act or the rules made there under and the amount charged on Account of GST Tax on these goods are not more than that what is payable under the provisions of the relevant Act or the rules made there under</h6></p><br>
								<h5 class="text-center"><b>E.&O.E.</b></h5>						
								</td>
								<td colspan="2">
								<h5 class="text-center"><br><br><br><b>For Authorised Signatory</b></h5>		
								</td>
								<td colspan="4">
								<h5 class="text-center"><br><br><br><br><b><br><br>&nbsp;&nbsp;&nbsp;&nbsp;Customer Signature with Seal</b></h5>
								</td>
						</tr>				
					</tbody>				
				</table>
				<p class="text-center">This is a computer generated invoice doesn't required any seal & signature</p>
				
			</div>
			</c:forEach>
	</div>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

	<!-- Latest compiled JavaScript -->
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	
	<script lang="javascript">
		var a = ['','one ','two ','three ','four ', 'five ','six ','seven ','eight ','nine ','ten ','eleven ','twelve ','thirteen ','fourteen ','fifteen ','sixteen ','seventeen ','eighteen ','nineteen '];
		var b = ['', '', 'twenty','thirty','forty','fifty', 'sixty','seventy','eighty','ninety'];

		function inWords(num) {
		    if ((num = num.toString()).length > 9) return 'overflow';
		    n = ('000000000' + num).substr(-9).match(/^(\d{2})(\d{2})(\d{2})(\d{1})(\d{2})$/);
		    if (!n) return; var str = '';
		    str += (n[1] != 0) ? (a[Number(n[1])] || b[n[1][0]] + ' ' + a[n[1][1]]) + 'crore ' : '';
		    str += (n[2] != 0) ? (a[Number(n[2])] || b[n[2][0]] + ' ' + a[n[2][1]]) + 'lakh ' : '';
		    str += (n[3] != 0) ? (a[Number(n[3])] || b[n[3][0]] + ' ' + a[n[3][1]]) + 'thousand ' : '';
		    str += (n[4] != 0) ? (a[Number(n[4])] || b[n[4][0]] + ' ' + a[n[4][1]]) + 'hundred ' : '';
		    str += (n[5] != 0) ? ((str != '') ? 'and ' : '') + (a[Number(n[5])] || b[n[5][0]] + ' ' + a[n[5][1]]) + 'only ' : '';
		    return str;
		}
  </script>
  
  <script>
  	$(document).ready(function(){
  		var net_amt=$('#get_percent_word').val();
  		net_amt=parseInt(net_amt);
  		var word=inWords(net_amt);
  		$('.in-word').text(word);
  	});
  </script>
  
  <script>
  	$(document).ready(function(){
  		var net_amt=$('#get_percent_word_total').val();
  		net_amt=parseInt(net_amt);
  		var word=inWords(net_amt);
  		$('.in-word').text(word);
  	});
  </script>
  
  <script>
  	$(document).ready(function(){
  		var net_amt=$('#net_amt').val();
  		net_amt=parseInt(net_amt);
  		var word=inWords(net_amt);
  		$('.in-word').text(word);
  	});
  </script>
  
  <script type="text/javascript">
		function calculateNetAmmount(e){
			var gst_percent=document.getElementById("gst_percent").value;
			var item_price= $(e).closest("tr").find('input.item_price').val();
			var discount_amount= $(e).closest("th").find('input.discount_amount').val();
			item_price=(isNaN(item_price) || item_price==undefined || item_price.trim()=="")?'0.0':parseFloat(item_price);
			gst_percent=(isNaN(gst_percent) || gst_percent==undefined || gst_percent.trim()=="")?'0.0':parseFloat(gst_percent);
			discount_amount=(isNaN(discount_amount) || discount_amount==undefined || discount_amount.trim()=="")?'0.0':parseFloat(discount_amount);
			var quantity= $(e).closest("tr").find('input.item_quantity').val();
			quantity=(isNaN(quantity) || quantity==undefined || quantity.trim()=="")?'0.0':parseFloat(quantity);
			var total_price=parseFloat(quantity)*parseFloat(item_price);
			total_price=isNaN(total_price)?'0.0':total_price;
			var total_gst=(total_price/100)*gst_percent;
			total_gst=isNaN(total_gst)?'0.0':total_gst;
			total_net=total_price+total_gst;
		    $(e).closest("tr").find('input.gross_amount').val(total_price);
		    $(e).closest("tr").find('input.tax_amount').val(total_gst);
		    $(e).closest("tr").find('input.net_amount').val(total_net);
		    
		    //declare all sum variable
		    var net_sum=0;
		    var gross_sum=0;
		    var gst_sum=0;
		    
		    /* now get all value using id loop */
		    
		   var quantity_all=document.getElementsByName('quantity');
		   var unit_cost_all=document.getElementsByName('rate');
		   for(var i=0;i<quantity_all.length;i++){
			  /* get all single single value data */
			  var gst_val=gst_percent;
			  var quantity_val=quantity_all[i].value;
			  var unit_cost_val=unit_cost_all[i].value;
			  
			  /* now check the single data are empty or not then change to proper value */
			  gst_val=(gst_val==undefined || gst_val=='' || gst_val=='')?0.0:parseFloat(gst_val);
			  quantity_val=(quantity_val==undefined || quantity_val.trim()=='' || quantity_val=='')?0.0:parseFloat(quantity_val);
			  unit_cost_val=(unit_cost_val==undefined || unit_cost_val.trim()=='' || unit_cost_val=='')?0.0:parseFloat(unit_cost_val);
			  
			  /* now declare variable for gst calculation,gross calculation and cost calculation */
			  
			  var gst_cal=0;
			  var gross_cal=0;
			  var net_cal=0;
			  
			  //now calculate all details
			  gross_cal=quantity_val*unit_cost_val;
			  gst_cal=(gross_cal/100)*gst_val;
			  net_cal=gross_cal+gst_cal;
			  
			  /* NOW ADD ALL NET CALCULATION HERE */
			
			  net_sum=net_sum+net_cal;
			  gross_sum=gross_sum+gross_cal;
			  gst_sum=gst_sum+gst_cal;
			 
		   }
	
		   net_sum=net_sum-parseFloat(discount_amount); 
		   $('#total_val').html(gross_sum.toFixed(2));
		   $('#total_gst').html(gst_sum.toFixed(2));
		   $('#total_grand').html(net_sum.toFixed(2)); 
		
		}
      </script>
      
       <script>
  	$(document).ready(function(){
  		var net_amt=$('#gst_percent_word').val();
  		net_amt=parseInt(net_amt);
  		var word=inWords(net_amt);
  		$('.in-word').text(word);
  	});
  </script>
</body>
</html>