<%@page import="com.willka.soft.util.RupeesConverter"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Tax Invoice - ${initParam.company_name}</title>
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
		font-size: 10px;
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
</head>
<body>
	<div class="container">
		<sql:query var="invoice" dataSource="jdbc/rmc">
			  select i.*,pro.product_name,ROUND(i.gross_ammount,2) as gross,ROUND(i.net_ammount,2) as net,ROUND(i.tax_ammount,2) as tax,
			  ROUND(tax_ammount/2,2) as cgst,ROUND(tax_ammount/2,2) as sgst, 
			  (select sum(quantity) from customer_invoice ii 
			  where ii.customer_id=i.customer_id and ii.date=i.date
			  and ii.invoice_id<=i.invoice_id and ii.site_address_id=i.site_address_id and ii.grade_id=i.grade_id) as cum_quantity,
			  c.*,g.grade_id,g.product_id,g.quantity as gquantity,g.rate,po.*,p.plant_address,a.site_address as site_address
			  from customer_invoice i JOIN (plant p, purchase_order po,customer c,po_grade g,site_detail a,product pro)
			  on i.plant_id=p.plant_id
			  and i.customer_id=c.customer_id
			  and i.grade_id=g.grade_id
			  and g.order_id=po.order_id
			  and g.product_id=pro.product_id
			  and i.site_address_id=a.site_id
			  where i.inv_id=?
			 <sql:param value="${param.inv_id}"/>
		</sql:query>
		<c:forEach var="invoice" items="${invoice.rows}">
			<table class="table"  style="width: 100%">
				<tr>
					<td colspan="7" align="center" style="border:1px solid black;"><P style="font-size: 2.0em;"> TAX INVOICE</P>
					</td>
				</tr>
				<tr>
					<td class="text-center" colspan="8">
							<h2><strong>${initParam.company_name}</strong></h2>
							<p>${initParam.company_address}</p>
							<p>Phone : ${initParam.company_phone}</p>
							<p>Email: ${initParam.company_email}</p>
						</td>
				</tr>
				<tr>
					<td style="padding-right: 0px;font-size:1.2em;" colspan="3"><b>Customer
							Name:</b><strong>${invoice.customer_name}</strong></td>
					<td colspan="4"><b>Invoice No: #${invoice.invoice_id}</b></td>
				</tr>
				<tr>
					<td style="padding-right: 0px;" colspan="3"><b>Customer
							PO:</b> ${invoice.po_number}</td>
					
					<fmt:parseDate pattern="yyyy-MM-dd" value="${invoice.date}" var="parsedDate" />
					<fmt:formatDate value="${parsedDate}" var="mydate" pattern="dd-MMM-yyyy" />
					
					
					<td colspan="4"><b>Invoice Date:</b> ${mydate}</td>
				</tr>
				<tr>
					<td colspan="3"><b>Customer GSTIN No:</b>${invoice.customer_gstin}</td>
					<td colspan="4"><b>Invoice Time:</b> ${invoice.time}</td>
				</tr>
				<tr>
					<td class="text-left" colspan="3">
						<h5>
							<b>BILLING ADDRESS:</b>
						</h5>
						<p>${invoice.customer_address}</p>
					</td>
					<td colspan="4"><br>
						<h5>
							<b>SITE ADDRESS:</b>
						</h5>
						<p>${invoice.site_address}</p>
					</td>
				</tr>
				<tr>
					<td colspan="4">
						<p>
							<b>HSN COMODITY : </b>READY MIX CONCRETE
						</p>
							
					</td>
					<td  colspan="3">
						<p>
							<b>HSN CODE : </b> 38245010
						</p>
					</td>
				</tr>
				<tr class="text-center">
					<td>S/L No</td>
					<td>GRADE</td>
					<td>QTY</td>
					<td>BASIC PRICE</td>
					<td colspan="4">TAXABLE AMOUNT</td>
				</tr>

				<tr class="text-center">
					<td>1</td>
					<td>${invoice.product_name}</td>
					<td>${invoice.quantity}</td>
					<c:choose>
						<c:when test="${invoice.rate_include_tax=='yes'}">
							<sql:query var="gst" dataSource="jdbc/rmc">
								select (cgst+sgst) as gst from setting
							</sql:query>
							
							<c:forEach items="${gst.rows}" var="gst">
								<c:set var="gst_val" value="${gst.gst}"/>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<c:set var="gst_val" value="0"/>
						</c:otherwise>
					</c:choose>
					
					<c:set var="cst_per_unit">
						<fmt:formatNumber type="number" minFractionDigits="2"
							maxFractionDigits="2" value="${(invoice.cost_per_unit/(gst_val+100))*100}" />
					</c:set>
					<td>${cst_per_unit}</td>
					<c:set var="net_amount">
						<fmt:formatNumber type="number" minFractionDigits="2"
							maxFractionDigits="2" value="${invoice.net_ammount}" />
					</c:set>
					<c:set var="sub_total">
						<fmt:formatNumber type="number" minFractionDigits="2"
							maxFractionDigits="2" value="${invoice.gross_ammount}" />
					</c:set>
					<td colspan="4">${sub_total}</td>
				</tr>
				<tr>
					<td colspan="7"></td>
				</tr>
				<tr>
					<td colspan="5"></td>
					<th>Sub Total</th>
					<td class="text-right">${sub_total}</td>
				</tr>
				<tr>
					<td colspan="5"></td>
					<th>SGST(${gst_val/2}%)</th>
					<c:set var="sgst">
						<fmt:formatNumber type="number" minFractionDigits="2"
							maxFractionDigits="2" value="${invoice.tax_ammount/2}" />
					</c:set>
					<td class="text-right">${sgst}</td>
				</tr>
				<tr>
					<td colspan="5"></td>
					<th>CGST(${gst_val/2}%)</th>
					<c:set var="cgst">
						<fmt:formatNumber type="number" minFractionDigits="2"
							maxFractionDigits="2" value="${invoice.tax_ammount/2}" />
					</c:set>
					<td class="text-right">${cgst}</td>
				</tr>
				<tr>
					<td colspan="5"></td>
					<th>GRAND TOTAL</th>
					<td class="text-right">${net_amount}</td>
				</tr>
				<tr>
					<c:set value="${invoice.net_ammount}" var="word" />
					<td colspan="7"><b>AMOUNT IN WORDS:</b> <%=RupeesConverter.NumberToWord(
						Integer.toString((int) Double.parseDouble((String) pageContext.getAttribute("word"))))%>
					</td>
				</tr>
				<tr>
					<td colspan="3"><b>Mode of Transport : </b>Road</td>
					<td colspan="4"><b>Booking Station : </b></td>
				</tr>
				<tr>
					<td colspan="3"><b>Name of Transporter: </b>${initParam.transport}</td>
					<td colspan="4"><b>Receiving Station : </b></td>
				</tr>
				<tr>
					<td colspan="3"><b>Vehicle No : </b>${invoice.vehicle_no}</td>
					<td colspan="4"><b>DO/Challan No : </b></td>
				</tr>
				<tr>
					<td colspan="3"><b>Driver : </b> ${invoice.driver}</td>
					<td colspan="4"><b>Pump : </b> ${invoice.pump}</td>
				</tr>
				<tr class="text-center">
					<th colspan="2" class="text-center">Ordered Quantity(M3 )</th>
					<th colspan="2" class="text-center">Quantity with this load(M3 )</th>
					<th colspan="3" class="text-center">Cumulative Quantity(M3 )</th>
				</tr>
				<tr class="text-center">
					<td colspan="2" class="text-center">${invoice.gquantity}</td>
					<td colspan="2" class="text-center">${invoice.quantity}</td>
					<td colspan="3" class="text-center">${invoice.cum_quantity}</td>
				</tr>
				<tr>
					<td colspan="2">This discharge is completed:</td>
					<td colspan="2">Time released from site :</td>
					<td colspan="2">Water added at site:</td>
					<td colspan="1">Admixture added at site:</td>
				</tr>
				<tr>
					<th colspan="7">Terms:-</th>
				</tr>
				<tr>
					<td colspan="7"><br>
						<ol>
							<li>Goods once ordered & manufactured will not be taken back or exchanged or redirected</li>
							<li>Once the concrete reached the specified destination, the utilization responsibility lies on the end user and the material deemed as accepted</li>
							<li>The concrete batched should be utilized within 120 minutes from the time of batching / invoice, utilization beyond 120 minutes without concurrence of the manufacturer is at the risk & cost lies on the end user only.</li>
						</ol>
					</td>
				</tr>
				<tr>
					<td colspan="4" class="text-center"><br>
					<br>
					<br>
					<b>Receiver Signatory</b></td>
					<td colspan="3" class="text-center"><br>
					<br>
					<br> <b> Authorized Signatory</b></td>

				</tr>
				<tr>
					<td colspan="7" class="text-center">Registered office :
						${initParam.company_address}</td>
				</tr>
			</table>
			<div id="" class="no-print" style="text-align: center;">
				<button onclick="window.print()" class="btn btn-primary no-print">PRINT</button>
				&nbsp;&nbsp;&nbsp;
				<button onclick="window.history.back()" class="btn btn-danger">BACK</button>
			</div>
			<div style="page-break-after: always;"></div>
			<!-- PAGE BREAKING IS HERE -->
			
			<div class="dispr">
							<table class="table"  style="width: 100%">
				<tr>
					<td colspan="7" align="center" style="border:1px solid black;"><P style="font-size: 2.0em;"> TAX INVOICE</P>
					</td>
				</tr>
				<tr>
					<td class="text-center" colspan="8">
							<h2><strong>${initParam.company_name}</strong></h2>
							<p>${initParam.company_address}</p>
							<p>Phone : ${initParam.company_phone}</p>
							<p>Email: ${initParam.company_email}</p>
						</td>
				</tr>
				<tr>
					<td style="padding-right: 0px;font-size:1.2em;" colspan="3"><b>Customer
							Name:</b><strong>${invoice.customer_name}</strong></td>
					<td colspan="4"><b>Invoice No: #${invoice.invoice_id}</b></td>
				</tr>
				<tr>
					<td style="padding-right: 0px;" colspan="3"><b>Customer
							PO:</b> ${invoice.po_number}</td>
					
					<fmt:parseDate pattern="yyyy-MM-dd" value="${invoice.date}" var="parsedDate" />
					<fmt:formatDate value="${parsedDate}" var="mydate" pattern="dd-MMM-yyyy" />
					
					
					<td colspan="4"><b>Invoice Date:</b> ${mydate}</td>
				</tr>
				<tr>
					<td colspan="3"><b>Customer GSTIN No:</b>${invoice.customer_gstin}</td>
					<td colspan="4"><b>Invoice Time:</b> ${invoice.time}</td>
				</tr>
				<tr>
					<td class="text-left" colspan="3">
						<h5>
							<b>BILLING ADDRESS:</b>
						</h5>
						<p>${invoice.customer_address}</p>
					</td>
					<td colspan="4"><br>
						<h5>
							<b>SITE ADDRESS:</b>
						</h5>
						<p>${invoice.site_address}</p>
					</td>
				</tr>
				<tr>
					<td colspan="4">
						<p>
							<b>HSN COMODITY : </b>READY MIX CONCRETE
						</p>
							
					</td>
					<td  colspan="3">
						<p>
							<b>HSN CODE : </b> 38245010
						</p>
					</td>
				</tr>
				<tr class="text-center">
					<td>S/L No</td>
					<td>GRADE</td>
					<td>QTY</td>
					<td>BASIC PRICE</td>
					<td colspan="4">TAXABLE AMOUNT</td>
				</tr>

				<tr class="text-center">
					<td>1</td>
					<td>${invoice.product_name}</td>
					<td>${invoice.quantity}</td>
					<c:choose>
						<c:when test="${invoice.rate_include_tax=='yes'}">
							<sql:query var="gst" dataSource="jdbc/rmc">
								select (cgst+sgst) as gst from setting
							</sql:query>
							
							<c:forEach items="${gst.rows}" var="gst">
								<c:set var="gst_val" value="${gst.gst}"/>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<c:set var="gst_val" value="0"/>
						</c:otherwise>
					</c:choose>
					
					<c:set var="cst_per_unit">
						<fmt:formatNumber type="number" minFractionDigits="2"
							maxFractionDigits="2" value="${(invoice.cost_per_unit/(gst_val+100))*100}" />
					</c:set>
					<td>${cst_per_unit}</td>
					<c:set var="net_amount">
						<fmt:formatNumber type="number" minFractionDigits="2"
							maxFractionDigits="2" value="${invoice.net_ammount}" />
					</c:set>
					<c:set var="sub_total">
						<fmt:formatNumber type="number" minFractionDigits="2"
							maxFractionDigits="2" value="${invoice.gross_ammount}" />
					</c:set>
					<td colspan="4">${sub_total}</td>
				</tr>
				<tr>
					<td colspan="7"></td>
				</tr>
				<tr>
					<td colspan="5"></td>
					<th>Sub Total</th>
					<td class="text-right">${sub_total}</td>
				</tr>
				<tr>
					<td colspan="5"></td>
					<th>SGST(${gst_val/2}%)</th>
					<c:set var="sgst">
						<fmt:formatNumber type="number" minFractionDigits="2"
							maxFractionDigits="2" value="${invoice.tax_ammount/2}" />
					</c:set>
					<td class="text-right">${sgst}</td>
				</tr>
				<tr>
					<td colspan="5"></td>
					<th>CGST(${gst_val/2}%)</th>
					<c:set var="cgst">
						<fmt:formatNumber type="number" minFractionDigits="2"
							maxFractionDigits="2" value="${invoice.tax_ammount/2}" />
					</c:set>
					<td class="text-right">${cgst}</td>
				</tr>
				<tr>
					<td colspan="5"></td>
					<th>GRAND TOTAL</th>
					<td class="text-right">${net_amount}</td>
				</tr>
				<tr>
					<c:set value="${invoice.net_ammount}" var="word" />
					<td colspan="7"><b>AMOUNT IN WORDS:</b> <%=RupeesConverter.NumberToWord(
						Integer.toString((int) Double.parseDouble((String) pageContext.getAttribute("word"))))%>
					</td>
				</tr>
				<tr>
					<td colspan="3"><b>Mode of Transport : </b>Road</td>
					<td colspan="4"><b>Booking Station : </b></td>
				</tr>
				<tr>
					<td colspan="3"><b>Name of Transporter: </b>${initParam.transport}</td>
					<td colspan="4"><b>Receiving Station : </b></td>
				</tr>
				<tr>
					<td colspan="3"><b>Vehicle No : </b>${invoice.vehicle_no}</td>
					<td colspan="4"><b>DO/Challan No : </b></td>
				</tr>
				<tr>
					<td colspan="3"><b>Driver : </b> ${invoice.driver}</td>
					<td colspan="4"><b>Pump : </b> ${invoice.pump}</td>
				</tr>
				<tr class="text-center">
					<th colspan="2" class="text-center">Ordered Quantity(M3 )</th>
					<th colspan="2" class="text-center">Quantity with this load(M3 )</th>
					<th colspan="3" class="text-center">Cumulative Quantity(M3 )</th>
				</tr>
				<tr class="text-center">
					<td colspan="2" class="text-center">${invoice.gquantity}</td>
					<td colspan="2" class="text-center">${invoice.quantity}</td>
					<td colspan="3" class="text-center">${invoice.cum_quantity}</td>
				</tr>
				<tr>
					<td colspan="2">This discharge is completed:</td>
					<td colspan="2">Time released from site :</td>
					<td colspan="2">Water added at site:</td>
					<td colspan="1">Admixture added at site:</td>
				</tr>
				<tr>
					<th colspan="7">Terms:-</th>
				</tr>
				<tr>
					<td colspan="7"><br>
						<ol>
							<li>Goods once ordered & manufactured will not be taken back or exchanged or redirected</li>
							<li>Once the concrete reached the specified destination, the utilization responsibility lies on the end user and the material deemed as accepted</li>
							<li>The concrete batched should be utilized within 120 minutes from the time of batching / invoice, utilization beyond 120 minutes without concurrence of the manufacturer is at the risk & cost lies on the end user only.</li>
						</ol>
					</td>
				</tr>
				<tr>
					<td colspan="4" class="text-center"><br>
					<br>
					<br>
					<b>Receiver Signatory</b></td>
					<td colspan="3" class="text-center"><br>
					<br>
					<br> <b> Authorized Signatory</b></td>

				</tr>
				<tr>
					<td colspan="7" class="text-center">Registered office :
						${initParam.company_address}</td>
				</tr>
			</table>
			</div>
			<div style="page-break-after: always;"></div>
			<!-- PAGE BREAKING IS HERE -->
			<div class="dispr">
							<table class="table"  style="width: 100%">
				<tr>
					<td colspan="7" align="center" style="border:1px solid black;"><P style="font-size: 2.0em;"> TAX INVOICE</P>
					</td>
				</tr>
				<tr>
					<td class="text-center" colspan="8">
							<h2><strong>${initParam.company_name}</strong></h2>
							<p>${initParam.company_address}</p>
							<p>Phone : ${initParam.company_phone}</p>
							<p>Email: ${initParam.company_email}</p>
						</td>
				</tr>
				<tr>
					<td style="padding-right: 0px;font-size:1.2em;" colspan="3"><b>Customer
							Name:</b><strong>${invoice.customer_name}</strong></td>
					<td colspan="4"><b>Invoice No: #${invoice.invoice_id}</b></td>
				</tr>
				<tr>
					<td style="padding-right: 0px;" colspan="3"><b>Customer
							PO:</b> ${invoice.po_number}</td>
					
					<fmt:parseDate pattern="yyyy-MM-dd" value="${invoice.date}" var="parsedDate" />
					<fmt:formatDate value="${parsedDate}" var="mydate" pattern="dd-MMM-yyyy" />
					
					
					<td colspan="4"><b>Invoice Date:</b> ${mydate}</td>
				</tr>
				<tr>
					<td colspan="3"><b>Customer GSTIN No:</b>${invoice.customer_gstin}</td>
					<td colspan="4"><b>Invoice Time:</b> ${invoice.time}</td>
				</tr>
				<tr>
					<td class="text-left" colspan="3">
						<h5>
							<b>BILLING ADDRESS:</b>
						</h5>
						<p>${invoice.customer_address}</p>
					</td>
					<td colspan="4"><br>
						<h5>
							<b>SITE ADDRESS:</b>
						</h5>
						<p>${invoice.site_address}</p>
					</td>
				</tr>
				<tr>
					<td colspan="4">
						<p>
							<b>HSN COMODITY : </b>READY MIX CONCRETE
						</p>
							
					</td>
					<td  colspan="3">
						<p>
							<b>HSN CODE : </b> 38245010
						</p>
					</td>
				</tr>
				<tr class="text-center">
					<td>S/L No</td>
					<td>GRADE</td>
					<td>QTY</td>
					<td>BASIC PRICE</td>
					<td colspan="4">TAXABLE AMOUNT</td>
				</tr>

				<tr class="text-center">
					<td>1</td>
					<td>${invoice.product_name}</td>
					<td>${invoice.quantity}</td>
					<c:choose>
						<c:when test="${invoice.rate_include_tax=='yes'}">
							<sql:query var="gst" dataSource="jdbc/rmc">
								select (cgst+sgst) as gst from setting
							</sql:query>
							
							<c:forEach items="${gst.rows}" var="gst">
								<c:set var="gst_val" value="${gst.gst}"/>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<c:set var="gst_val" value="0"/>
						</c:otherwise>
					</c:choose>
					
					<c:set var="cst_per_unit">
						<fmt:formatNumber type="number" minFractionDigits="2"
							maxFractionDigits="2" value="${(invoice.cost_per_unit/(gst_val+100))*100}" />
					</c:set>
					<td>${cst_per_unit}</td>
					<c:set var="net_amount">
						<fmt:formatNumber type="number" minFractionDigits="2"
							maxFractionDigits="2" value="${invoice.net_ammount}" />
					</c:set>
					<c:set var="sub_total">
						<fmt:formatNumber type="number" minFractionDigits="2"
							maxFractionDigits="2" value="${invoice.gross_ammount}" />
					</c:set>
					<td colspan="4">${sub_total}</td>
				</tr>
				<tr>
					<td colspan="7"></td>
				</tr>
				<tr>
					<td colspan="5"></td>
					<th>Sub Total</th>
					<td class="text-right">${sub_total}</td>
				</tr>
				<tr>
					<td colspan="5"></td>
					<th>SGST(${gst_val/2}%)</th>
					<c:set var="sgst">
						<fmt:formatNumber type="number" minFractionDigits="2"
							maxFractionDigits="2" value="${invoice.tax_ammount/2}" />
					</c:set>
					<td class="text-right">${sgst}</td>
				</tr>
				<tr>
					<td colspan="5"></td>
					<th>CGST(${gst_val/2}%)</th>
					<c:set var="cgst">
						<fmt:formatNumber type="number" minFractionDigits="2"
							maxFractionDigits="2" value="${invoice.tax_ammount/2}" />
					</c:set>
					<td class="text-right">${cgst}</td>
				</tr>
				<tr>
					<td colspan="5"></td>
					<th>GRAND TOTAL</th>
					<td class="text-right">${net_amount}</td>
				</tr>
				<tr>
					<c:set value="${invoice.net_ammount}" var="word" />
					<td colspan="7"><b>AMOUNT IN WORDS:</b> <%=RupeesConverter.NumberToWord(
						Integer.toString((int) Double.parseDouble((String) pageContext.getAttribute("word"))))%>
					</td>
				</tr>
				<tr>
					<td colspan="3"><b>Mode of Transport : </b>Road</td>
					<td colspan="4"><b>Booking Station : </b></td>
				</tr>
				<tr>
					<td colspan="3"><b>Name of Transporter: </b>${initParam.transport}</td>
					<td colspan="4"><b>Receiving Station : </b></td>
				</tr>
				<tr>
					<td colspan="3"><b>Vehicle No : </b>${invoice.vehicle_no}</td>
					<td colspan="4"><b>DO/Challan No : </b></td>
				</tr>
				<tr>
					<td colspan="3"><b>Driver : </b> ${invoice.driver}</td>
					<td colspan="4"><b>Pump : </b> ${invoice.pump}</td>
				</tr>
				<tr class="text-center">
					<th colspan="2" class="text-center">Ordered Quantity(M3 )</th>
					<th colspan="2" class="text-center">Quantity with this load(M3 )</th>
					<th colspan="3" class="text-center">Cumulative Quantity(M3 )</th>
				</tr>
				<tr class="text-center">
					<td colspan="2" class="text-center">${invoice.gquantity}</td>
					<td colspan="2" class="text-center">${invoice.quantity}</td>
					<td colspan="3" class="text-center">${invoice.cum_quantity}</td>
				</tr>
				<tr>
					<td colspan="2">This discharge is completed:</td>
					<td colspan="2">Time released from site :</td>
					<td colspan="2">Water added at site:</td>
					<td colspan="1">Admixture added at site:</td>
				</tr>
				<tr>
					<th colspan="7">Terms:-</th>
				</tr>
				<tr>
					<td colspan="7"><br>
						<ol>
							<li>Goods once ordered & manufactured will not be taken back or exchanged or redirected</li>
							<li>Once the concrete reached the specified destination, the utilization responsibility lies on the end user and the material deemed as accepted</li>
							<li>The concrete batched should be utilized within 120 minutes from the time of batching / invoice, utilization beyond 120 minutes without concurrence of the manufacturer is at the risk & cost lies on the end user only.</li>
						</ol>
					</td>
				</tr>
				<tr>
					<td colspan="4" class="text-center"><br>
					<br>
					<br>
					<b>Receiver Signatory</b></td>
					<td colspan="3" class="text-center"><br>
					<br>
					<br> <b> Authorized Signatory</b></td>

				</tr>
				<tr>
					<td colspan="7" class="text-center">Registered office :
						${initParam.company_address}</td>
				</tr>
			</table>
			</div>
		</c:forEach>
	</div>
</body>
</html>