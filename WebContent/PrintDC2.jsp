<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Print Invoice</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">

<!-- jQuery library -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

<!-- Latest compiled JavaScript -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<style type="text/css">
.dispr {
	display: none;
}

@media print {
	.dispr {
		display: block;
		page-break-after: always;
	}
	
	
	
	table th td{
		border:1px solid black;
	}
	
	table{
		font-size: 15px;
	}
}

@media print {
	.no-print, .no-print * {
		display: none !important;
	}
}


</style>

<style type="text/css">
	table tr td,th{
		border:1px solid black;
	}

</style>

<!-- Get company details here -->
<sql:query var="comp" dataSource="jdbc/rmc">
	select * from company_detail where company_id=1
</sql:query>
<c:forEach items="${comp.rows}" var="comp">
	<c:set value="${comp}" var="company"/>
</c:forEach>

</head>
<body>
	<div class="container">
		<sql:query var="invoice" dataSource="jdbc/rmc">
			  select i.*,p.product_name,ROUND(i.gross_amount,2) as gross,ROUND(i.net_amount,2) as net,ROUND(i.tax_amount,2) as tax,
			  ROUND(tax_amount/2,2) as cgst,ROUND(tax_amount/2,2) as sgst, 
			  (select sum(quantity) from dc ii 
			  where ii.customer_id=i.customer_id and ii.invoice_date=i.invoice_date
			  and ii.invoice_id<=i.invoice_id and ii.site_id=i.site_id and ii.poi_id=i.poi_id) as cum_quantity,
			  c.*,poi.poi_id,poi.product_id,poi.quantity as gquantity,po.*,pl.plant_address,s.site_address as site_address
			  from dc i JOIN (plant pl, purchase_order po,customer c,purchase_order_item poi,site_detail s,product p)
			  on i.plant_id=pl.plant_id
			  and i.customer_id=c.customer_id
			  and i.poi_id=poi.poi_id
			  and poi.order_id=po.order_id
			  and poi.product_id=p.product_id
			  and i.site_id=s.site_id
			  where i.id=?
			 <sql:param value="${param.id}"/>
		</sql:query>
		<c:forEach var="invoice" items="${invoice.rows}">
			<table class="table"  style="width: 100%">
				<tr>
					<td colspan="7" align="center" style="border:1px solid black;">
						<div class="col-xs-2"></div>
						<div class="col-xs-8 text-center" style="font-size: 2em;font-weight: bold;">DELIVERY CHALLAN</div>
						<div class="col-xs-2 text-right">(ORIGINAL)</div>
					</td>
				</tr>
				<tr>
					<td class="text-center" colspan="8">
							<h2><strong>${company.company_name}</strong></h2>
							<h3><b>Readymix Division</b></h3>
							<p>${company.company_address}</p>
							<p>Phone No. : ${company.company_phone}  &nbsp;&nbsp; Email: ${company.company_mail}</p>
							<p>GSTIN: ${company.gstin_number}</p>
						</td>
				</tr>
				<tr>
					<td style="padding-right: 0px;font-size:1.2em;" colspan="3" class="col-xs-6"><b>Customer
							Name:</b><strong>${invoice.customer_name}</strong></td>
					<td colspan="4" class="col-xs-6"><b>DC No: ${invoice.invoice_id}</b></td>
				</tr>
				<tr>
					<td colspan="3"><b>Item : </b>${invoice.product_name}</td>
					
					<fmt:parseDate pattern="yyyy-MM-dd" value="${invoice.invoice_date}" var="parsedDate" />
					<fmt:formatDate value="${parsedDate}" var="mydate" pattern="dd-MMM-yyyy" />
					
					
					<td colspan="4"><b>DC Date:</b> ${mydate}</td>
				</tr>
				<tr>
					<td colspan="3"><b>Item Quantity : </b>${invoice.quantity} M<sup>3</sup></td>
					<td colspan="4"><b>DC Time:</b> ${invoice.invoice_time}</td>
				</tr>
				<tr>
					<td class="text-left" colspan="3">
						<h5>
							<b>Billing Address:</b>
						</h5>
						<p>${invoice.customer_address}</p>
					</td>
					<td colspan="4">
						<h5>
							<b>Site Name &amp; Address:</b>
						</h5>
						<p>${invoice.site_address}</p>
					</td>
				</tr>
				<tr>
					<td colspan="3"><b>Mode of Transport : </b>Road</td>
					<td colspan="4"><b>Name of Transporter: </b>${company.transport}</td>
				</tr>
				<tr>
					<td colspan="3"><b>Vehicle No : </b>${invoice.vehicle_no}</td>
					<td colspan="4"><b>Customer Phone : </b>${invoice.customer_phone}</td>
				</tr>
				<tr>
					<td colspan="3"><b>Driver : </b> ${invoice.driver_name}</td>
					<td colspan="4"><b>Pump : </b> ${invoice.pump}</td>
				</tr>
				<tr>
					<td colspan="7" style="padding-top:10px;">
						<b>TERMS &amp; CONDITION : --</b>
						<ol>
							<li>Goods once ordered &amp; manufactured will not be taken back or exchanged or redirected</li>
							<li>Once the concrete reached the specified destination, the utilization responsibility lies on the end user and the material deemed as accepted</li>
							<li>The design mix of the concrete manufactured and supplied in lieu with IS 456 recommendation and the procedure for acceptance of the same as per IS 456</li>
							<li>Any claim/shortfall/wastages due to operations shall not be accepted, if not claimed, on the same day/date of supply with proper note</li>
							
							<li>We shall not be liable for any consequential damages at site of whatsoever nature such as indirect loss, downtime of equipment, idle manpower, delays or any other damages that may be caused for reasons beyond control.</li>
							<li>All payments should be made only through account payee cheques/ draft/rtgs in favour of "${company.company_name}"</li>
							<li>Dispute if any will be subject to the seller's  court jurisdiction</li>
						</ol>
					</td>
				</tr>

				<tr>
					<td colspan="3" class="text-center"><br>
					<br>
					<br>
					<br>
					<br>
					<b>Receiver Signatory</b></td>
					<td colspan="4" class="text-center">
					<b> For ${company.company_name}</b>
					<br>
					<br>
					<br>
					<br> <b> Authorized Signatory</b></td>

				</tr>
				<tr>
					<td colspan="7" class="text-center">Registered office :
						${company.company_address}</td>
				</tr>
			</table>
			<div id="" class="no-print" style="text-align: center;">
				<button onclick="window.print()" class="btn btn-success no-print">PRINT</button>
				&nbsp;&nbsp;&nbsp;
				<button onclick="window.history.back()" class="btn btn-danger">BACK</button>
			</div>
			
			
			<div style="page-break-after: always;"></div>
			<!-- PAGE BREAKING IS HERE -->
			
			<div class="dispr">
			
			<table class="table"  style="width: 100%">
				<tr>
					<td colspan="7" align="center" style="border:1px solid black;">
						<div class="col-xs-2"></div>
						<div class="col-xs-8 text-center" style="font-size: 2em;font-weight: bold;">DELIVERY CHALLAN</div>
						<div class="col-xs-2 text-right">(OFFICE)</div>
					</td>
				</tr>
				<tr>
					<td class="text-center" colspan="8">
							<h2><strong>${company.company_name}</strong></h2>
							<h3><b>Readymix Division</b></h3>
							<p>${company.company_address}</p>
							<p>Phone No. : ${company.company_phone} &nbsp;&nbsp;  Email: ${company.company_mail}</p>
							<p>GSTIN: ${company.gstin_number}</p>
						</td>
				</tr>
				<tr>
					<td style="padding-right: 0px;font-size:1.2em;" colspan="3" class="col-xs-6"><b>Customer
							Name:</b><strong>${invoice.customer_name}</strong></td>
					<td colspan="4" class="col-xs-6"><b>DC No: ${invoice.invoice_id}</b></td>
				</tr>
				<tr>
					<td colspan="3"><b>Item : </b>${invoice.product_name}</td>
					
					<fmt:parseDate pattern="yyyy-MM-dd" value="${invoice.invoice_date}" var="parsedDate" />
					<fmt:formatDate value="${parsedDate}" var="mydate" pattern="dd-MMM-yyyy" />
					
					
					<td colspan="4"><b>DC Date:</b> ${mydate}</td>
				</tr>
				<tr>
					<td colspan="3"><b>Item Quantity : </b>${invoice.quantity} M<sup>3</sup></td>
					<td colspan="4"><b>DC Time:</b> ${invoice.invoice_time}</td>
				</tr>
				<tr>
					<td class="text-left" colspan="3">
						<h5>
							<b>Billing Address:</b>
						</h5>
						<p>${invoice.customer_address}</p>
					</td>
					<td colspan="4">
						<h5>
							<b>Site Name &amp; Address:</b>
						</h5>
						<p>${invoice.site_address}</p>
					</td>
				</tr>
				<tr>
					<td colspan="3"><b>Mode of Transport : </b>Road</td>
					<td colspan="4"><b>Name of Transporter: </b>${company.transport}</td>
				</tr>
				<tr>
					<td colspan="3"><b>Vehicle No : </b>${invoice.vehicle_no}</td>
					<td colspan="4"><b>Customer Phone : </b>${invoice.customer_phone}</td>
				</tr>
				<tr>
					<td colspan="3"><b>Driver : </b> ${invoice.driver_name}</td>
					<td colspan="4"><b>Pump : </b> ${invoice.pump}</td>
				</tr>
				<tr>
					<td colspan="7" style="padding-top:10px;">
						<b>TERMS &amp; CONDITION : --</b>
						<ol>
							<li>Goods once ordered &amp; manufactured will not be taken back or exchanged or redirected</li>
							<li>Once the concrete reached the specified destination, the utilization responsibility lies on the end user and the material deemed as accepted</li>
							<li>The design mix of the concrete manufactured and supplied in lieu with IS 456 recommendation and the procedure for acceptance of the same as per IS 456</li>
							<li>Any claim/shortfall/wastages due to operations shall not be accepted, if not claimed, on the same day/date of supply with proper note</li>
							<li> We will not entertain any claims after 35 days from the date of supply.</li>
							<li>We shall not be liable for any consequential damages at site of whatsoever nature such as indirect loss, downtime of equipment, idle manpower, delays or any other damages that may be caused for reasons beyond control.</li>
							<li>Interest @ 24% p.a. is applicable on outstanding amount, which crosses more than the agreed payment terms.</li>
							<li>All payments should be made only through account payee cheques/ draft/rtgs in favour of "${company.company_name}"</li>
							<li>Dispute if any will be subject to the seller's  court jurisdiction</li>
						</ol>
					</td>
				</tr>

				<tr>
					<td colspan="3" class="text-center"><br>
					<br>
					<br>
					<br>
					<br>
					<b>Receiver Signatory</b></td>
					<td colspan="4" class="text-center">
					<b> For ${company.company_name}</b>
					<br>
					<br>
					<br>
					<br> <b> Authorized Signatory</b></td>

				</tr>
				<tr>
					<td colspan="7" class="text-center">Registered office :
						${company.company_address}</td>
				</tr>
			</table>
			</div>
			
			
			<div style="page-break-after: always;"></div>
			<!-- PAGE BREAKING IS HERE -->
			
			<div class="dispr">
			
		<!--	<table class="table"  style="width: 100%">
				<tr>
					<td colspan="7" align="center" style="border:1px solid black;">
						<div class="col-xs-2"></div>
						<div class="col-xs-8 text-center" style="font-size: 2em;font-weight: bold;">DELIVERY CHALLAN</div>
						<div class="col-xs-2 text-right">(DUPLICATE)</div>
					</td>
				</tr>
				<tr>
					<td class="text-center" colspan="8">
							<h2><strong>${company.company_name}</strong></h2>
							<p>${company.company_address}</p>
							
							<p>Email: ${company.company_mail}</p>
							<p>GSTIN: ${company.gstin_number}</p>
						</td>
				</tr>
				<tr>
					<td style="padding-right: 0px;font-size:1.2em;" colspan="3" class="col-xs-6"><b>Customer
							Name:</b><strong>${invoice.customer_name}</strong></td>
					<td colspan="4" class="col-xs-6"><b>DC No: ${invoice.invoice_id}</b></td>
				</tr>
				<tr>
					<td colspan="3"><b>Item : </b>${invoice.product_name}</td>
					
					<fmt:parseDate pattern="yyyy-MM-dd" value="${invoice.invoice_date}" var="parsedDate" />
					<fmt:formatDate value="${parsedDate}" var="mydate" pattern="dd-MMM-yyyy" />
					
					
					<td colspan="4"><b>DC Date:</b> ${mydate}</td>
				</tr>
				<tr>
					<td colspan="3"><b>Item Quantity : </b>${invoice.quantity} M<sup>3</sup></td>
					<td colspan="4"><b>DC Time:</b> ${invoice.invoice_time}</td>
				</tr>
				<tr>
					<td class="text-left" colspan="3">
						<h5>
							<b>Billing Address:</b>
						</h5>
						<p>${invoice.customer_address}</p>
					</td>
					<td colspan="4">
						<h5>
							<b>Site Name &amp; Address:</b>
						</h5>
						<p>${invoice.site_address}</p>
					</td>
				</tr>
				<tr>
					<td colspan="3"><b>Mode of Transport : </b>Road</td>
					<td colspan="4"><b>Name of Transporter: </b>${company.transport}</td>
				</tr>
				<tr>
					<td colspan="3"><b>Vehicle No : </b>${invoice.vehicle_no}</td>
					<td colspan="4"><b>Customer Phone : </b>${invoice.customer_phone}</td>
				</tr>
				<tr>
					<td colspan="3"><b>Driver : </b> ${invoice.driver_name}</td>
					<td colspan="4"><b>Pump : </b> ${invoice.pump}</td>
				</tr>
				<tr>
					<td colspan="7" style="padding-top:10px;">
						<b>TERMS &amp; CONDITION : --</b>
						<ol>
							<li>Goods once ordered &amp; manufactured will not be taken back or exchanged or redirected</li>
							<li>Once the concrete reached the specified destination, the utilization responsibility lies on the end user and the material deemed as accepted</li>
							<li>The design mix of the concrete manufactured and supplied in lieu with IS 456 recommendation and the procedure for acceptance of the same as per IS 456</li>
							<li>Any claim/shortfall/wastages due to operations shall not be accepted, if not claimed, on the same day/date of supply with proper note</li>
							<li> We will not entertain any claims after 35 days from the date of supply.</li>
							<li>We shall not be liable for any consequential damages at site of whatsoever nature such as indirect loss, downtime of equipment, idle manpower, delays or any other damages that may be caused for reasons beyond control.</li>
							<li>Interest @ 24% p.a. is applicable on outstanding amount, which crosses more than the agreed payment terms.</li>
							<li>All payments should be made only through account payee cheques/ draft/rtgs in favour of "${company.company_name}"</li>
							<li>Dispute if any will be subject to the seller's  court jurisdiction</li>
						</ol>
					</td>
				</tr>

				<tr>
					<td colspan="3" class="text-center"><br>
					<br>
					<br>
					<br>
					<br>
					<b>Receiver Signatory</b></td>
					<td colspan="4" class="text-center"><br>
					<b> For Surya Infra</b>
					<br>
					<br>
					<br>
					<br> <b> Authorized Signatory</b></td>

				</tr>
				<tr>
					<td colspan="7" class="text-center">Registered office :
						${company.company_address}</td>
				</tr>
			</table> -->
			
			
			
			</div>
			
			
		</c:forEach>
	</div>
</body>
</html>