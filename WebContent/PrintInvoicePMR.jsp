<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
	<title>PMR INVOICE PRINT</title>
	<!-- Latest compiled and minified CSS -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">

	<style type="text/css">
		.table tr td{
			border: 1px solid black;
		}

		table{
			font-size: 9.5px;
		}
		
		.disp{
			display: none;
		}
		
		@media print{
			.disp{
				display: block;
			}
			
			.no-print{
				display: none;
			}
		}
		
		
	</style>
</head>

<!-- Get company details here -->
<sql:query var="comp" dataSource="jdbc/rmc">
	select * from company_detail where company_id=1
</sql:query>
<c:forEach items="${comp.rows}" var="comp">
	<c:set value="${comp}" var="company"/>
</c:forEach>

<sql:query var="inv" dataSource="jdbc/rmc">
	  select i.*,p.product_name,ROUND(i.gross_amount,2) as gross,ROUND(i.net_amount,2) as net,ROUND(i.tax_amount,2) as tax,
	  ROUND(tax_amount/2,2) as cgst,ROUND(tax_amount/2,2) as sgst, 
	  (select sum(quantity) from invoice ii 
	  where ii.customer_id=i.customer_id and ii.invoice_date=i.invoice_date
	  and ii.invoice_id<=i.invoice_id and ii.site_id=i.site_id and ii.poi_id=i.poi_id) as cum_quantity,
	  c.*,poi.poi_id,poi.product_id,poi.quantity as gquantity,po.*,pl.plant_address,s.site_address as site_address
	  from invoice i JOIN (plant pl, purchase_order po,customer c,purchase_order_item poi,site_detail s,product p)
	  on i.plant_id=pl.plant_id
	  and i.customer_id=c.customer_id
	  and i.poi_id=poi.poi_id
	  and poi.order_id=po.order_id
	  and poi.product_id=p.product_id
	  and i.site_id=s.site_id
	  where i.id=?
	 <sql:param value="${param.id}"/>
</sql:query>
<c:forEach var="inv" items="${inv.rows}">
	<c:set value="${inv}" var="invoice"/>
</c:forEach>
<body>
	<div class="container">
		<div class="row">
			<table class="table table-condensed">
				<tr>
					<td colspan="6" class="text-left" style="border-top: 1px solid black;">
						NOT FOR CENVAT CREDIT PURPOSE 
					</td>
					<td colspan="6" class="text-right" style="border-top: 1px solid black;">
						ORIGINAL FOR BUYER
					</td>
				</tr>
				<tr>
					<td colspan="6" class="col-xs-6">
						
					</td>
					<td colspan="6" class="text-center col-xs-6">
						<h4>${company.company_name}</h4>
						(Invoice for removal of Excisable Goods from factory or warehouse, under Rule 4, 11 & 12 BB of Central Excise Rules, 2002 and Rule 3(5) & Rule 12 A of Cenvat Credit Rules 2004)
					</td>
				</tr>
				<tr>
					<td colspan="6">
						PMR Readymix Concrete (India) Pvt Lts<br>						
						${company.company_address}<br>					
						Telephone No: ${company.company_phone} <br>						
						Website: www.pmrreadymix.com<br>						
						Email : customercare@pmrreadymix.com<br>					
					</td>
					<td colspan="6">
						<br>Invoice Number: PMRP/2018-19/<fmt:formatNumber value="${invoice.invoice_id}" groupingUsed="false" minIntegerDigits="5"/><br>				
						Invoice Date: ${invoice.invoice_date}<br>				
						Cusomer P O Number: ${invoice.po_number}<br>				
						Date and Time of Removal: ${invoice.invoice_date} - ${invoice.invoice_time}				
					</td>
				</tr>
				<tr>
					<td colspan="6" class="col-xs-6">
						Range Address :  RANGE-CED7						
						Division Address :  EAST DIVISION-7 NEW 						
						Commissionerate Address : BENGALURU EAST NEW						
					</td>
					<td   class="col-xs-1">
						Pre Authenticated by
						EXEMPTED FROM 
						PREAUTHENTICATION
					</td>
					<td colspan="5" class="col-xs-5" rowspan="2">								
						Excisable Commodity: Ready Mix Concrete<br>			
						Excisable Tariff Heading Number:<br>			
						GSTIN: ${company.gstin_number}<br>			
						CST Number:<br>			
						Customer GSTIN: ${invoice.customer_gstin}<br>			
						E-way Bill No:<br>			
					</td>
				</tr>
				<tr>
					<td colspan="6">
						No & date of Notification :						
						(Under Which rate of Duty paid/Concession Claimed)						
						Notification No.16/2012-Central Excise, dated 17th March 2012						

					</td>
					<td class="col-xs-1">
						
					</td>
				</tr>
				<tr>
					<td colspan="6">
							<b>Name & Address of Customer Billed :</b> <br>						
							${invoice.customer_name}<br>						
							${invoice.customer_address}						
						</td>
						<td colspan="6">
							<b>Delivery Address - Ship To :</b>	<br>			
							${invoice.customer_name}<br>						
							${invoice.site_address}						
						</td>
				</tr>
				<tr class="text-center">
					<td rowspan="2" colspan="2">S/L No.</td>
					<td rowspan="2">Description of Goods RMC</td>
					<td rowspan="2">Qty (M3)</td>
					<td rowspan="2">Rate</td>
					<td rowspan="2">Assessable Value of Goods</td>
					<td colspan="4">
						Amount
					</td>
					<td rowspan="2">Total GST</td>
					<td rowspan="2">Total Amount</td>
				</tr>
				<tr class="text-center">
					<td colspan="2" class="col-xs-2">CGST (9%)</td>
					<td colspan="2" class="col-xs-2">SGST (9%)</td>
				</tr>
				<tr class="text-center">
					 <td>1</td>
					 <td></td>
					 <td>${invoice.product_name}</td>
					 <td>${invoice.quantity}</td>
					 <td>${invoice.rate}</td>
					 <td>${invoice.gross_amount}</td>
					 <c:set var="sgst">
						<fmt:formatNumber type="number" minFractionDigits="2" groupingUsed="false"
							maxFractionDigits="2" value="${invoice.tax_amount/2}" />
					</c:set>
					 <td colspan="2" class="col-xs-2">${sgst}</td>
					 <c:set var="cgst">
						<fmt:formatNumber type="number" groupingUsed="false" minFractionDigits="2"
							maxFractionDigits="2" value="${invoice.tax_amount/2}" />
					</c:set>
					 <td colspan="2" class="col-xs-2">${cgst}</td>
					 <td>${invoice.tax_amount}</td>
					 <td>${invoice.net_amount}</td>
				</tr>
				<tr class="text-center">
					<td colspan="2">Cementition.Type</td>
					<td colspan="2">Max.Agg Size</td>
					<td colspan="2">Admixure Type</td>
					<td colspan="2">Slump</td>
					<td colspan="4">Min.Cementitious Content</td>
				</tr>
				<tr class="text-center">
					<td colspan="2">OPC+SCM+PFA</td>
					<td colspan="2">20MM</td>
					<td colspan="2"></td>
					<td colspan="2">130+/-20MM</td>
					<td colspan="4"></td>
				</tr>
				<tr>
					<td colspan="12">
						Total Invoice Amount in Words : INR sixteen Thousand,two Hundred  only.
					</td>
				</tr>
				<tr>
					<td colspan="9">
						This is to certify that the Particulars given herein is as per Section 4 of Central Excise Act and the amount indicated in the document represents the price actually charged and that there is no additional consideration flowing directly or indirectly.								
					</td>
					<td colspan="3">NOTE : 1M3=2400 Kgs+/-5%</td>
				</tr>
				<tr>
					<td colspan="6">Mode of Transport: Road</td>
					<td colspan="6">Booking Station</td>
				</tr>
				<tr>
					<td colspan="6">Name of Transport : PMR </td>
					<td colspan="6">Receiving Station</td>
				</tr>
				<tr>
					<td colspan="6">Vehicle Regn No : KA 59 0178</td>
					<td colspan="6">D.O/Challan Number</td>
				</tr>
				<tr>
					<td colspan="6">L.R/R.R No. & Dt :Own Transport Road Permit Number :</td>
					<td colspan="6">Batch No: </td>
				</tr>
				<tr>
					<td colspan="4">Order Quantity (Cubic Meter)</td>
					<td colspan="4"> Quantity with this load  (Cubic Meter)</td>
					<td colspan="4">Cummulative  Quantity   (Cubic Meter)</td>
				</tr>
				<tr class="text-center">
					<td colspan="4">${invoice.gquantity}</td>
					<td colspan="4">${invoice.quantity}</td>
					<td colspan="4">${invoice.cum_quantity}</td>
				</tr>
				<tr>
					<td colspan="12">Pouring Location / Structure :</td>
				</tr>
				<tr>
					<td colspan="9">Whether this concrete is pumped by PMR Concrete : Yes/No PUMP-LP</td>
					<td colspan="3">Time of arrival on site :</td>
				</tr>
				<tr>
					<td colspan="3">Time discharge completed : </td>
					<td colspan="3">Time released from site : </td>
					<td colspan="3">Water added at site : </td>
					<td colspan="3">Admixture added at site :</td>
				</tr>
				<tr>
					<td colspan="12">Remarks:</td>
				</tr>
				<tr>
					<td colspan="12">
						Please Note : This concrete delivery is subject to the terms and condition of Sales as shown in our quotation. The time allowed for updating this delivery is 15 minutes. We reserve the right to change for any detention beyond this time as per our quotation.Any unauthorized addition of water and/or any other material to concrete shall absolve us from any liability whatsoever. Any deficiency in methods of placing,compacting,finishing and curing of concrete adopted at site may affect quality of concrete in the finished work,for which we shall not be held liable and responsible.Any disputes that arise on quantity and quality (except comp.srength)of concrete supplied in this load shall be reposted to us writing with in 24 hours from the time of supply.Working in cementitious and wet condition products, so wear appropriate protective safety goggles, waterproof gloves,rubber boots, and clothing sufficient to protect skin from contact with wet product should be worn.For any queries,incidents and complaints towards the supplies,please write to us at pmrrmc@pmrreadymix.com	<br><br>
						I hereby confirm that :
						<li>I/We have accepted delivery of concrete as per the details mentioned above.</li>
						<li>I/We have authorized addition of any water and/or admixture as mentioned above</li>	
					</td>
				</tr>
				<tr>
					<td colspan="6"><h5>Receiver Signature & Seal :<br><br><br><br></h5></td>
					<td colspan="6" class="text-center"><h5>For PMR READYMIX CONCRETE (India) Pvt Ltd</h5><br><h5>Authorized Signatory</h5></td>
				</tr>
			</table>
			
			<div id="" class="no-print" style="text-align: center;">
				<button onclick="window.print()" class="btn btn-primary no-print">PRINT</button>
				&nbsp;&nbsp;&nbsp;
				<button onclick="window.history.back()" class="btn btn-danger">BACK</button>
			</div>
			<div style="page-break-after: always;"></div>
			<!-- PAGE BREAKING IS HERE -->
			<div style="page-break-after: always;"></div>
			<div class="disp">
				<table class="table table-condensed">
					<tr>
						<td colspan="6" class="text-left" style="border-top: 1px solid black;">
							NOT FOR CENVAT CREDIT PURPOSE 
						</td>
						<td colspan="6" class="text-right" style="border-top: 1px solid black;">
							Duplicate For Driver
						</td>
					</tr>
					<tr>
						<td colspan="6" class="col-xs-6">
							
						</td>
						<td colspan="6" class="text-center col-xs-6">
							<h4>${company.company_name}</h4>
							(Invoice for removal of Excisable Goods from factory or warehouse, under Rule 4, 11 & 12 BB of Central Excise Rules, 2002 and Rule 3(5) & Rule 12 A of Cenvat Credit Rules 2004)
						</td>
					</tr>
					<tr>
						<td colspan="6">
							PMR Readymix Concrete (India) Pvt Lts<br>						
							${company.company_address}<br>					
							Telephone No: ${company.company_phone} <br>						
							Website: www.pmrreadymix.com<br>						
							Email : customercare@pmrreadymix.com<br>					
						</td>
						<td colspan="6">
							<br>Invoice Number: PMRP/2018-19/<fmt:formatNumber value="${invoice.invoice_id}" groupingUsed="false" minIntegerDigits="5"/><br>				
							Invoice Date: ${invoice.invoice_date}<br>				
							Cusomer P O Number: ${invoice.po_number}<br>				
							Date and Time of Removal: ${invoice.invoice_date} - ${invoice.invoice_time}				
						</td>
					</tr>
					<tr>
						<td colspan="6" class="col-xs-6">
							Range Address :  RANGE-CED7						
							Division Address :  EAST DIVISION-7 NEW 						
							Commissionerate Address : BENGALURU EAST NEW						
						</td>
						<td   class="col-xs-1">
							Pre Authenticated by
							EXEMPTED FROM 
							PREAUTHENTICATION
						</td>
						<td colspan="5" class="col-xs-5" rowspan="2">								
							Excisable Commodity: Ready Mix Concrete<br>			
							Excisable Tariff Heading Number:<br>			
							GSTIN: ${company.gstin_number}<br>			
							CST Number:<br>			
							Customer GSTIN: ${invoice.customer_gstin}<br>			
							E-way Bill No:<br>			
						</td>
					</tr>
					<tr>
						<td colspan="6">
							No & date of Notification :						
							(Under Which rate of Duty paid/Concession Claimed)						
							Notification No.16/2012-Central Excise, dated 17th March 2012						
	
						</td>
						<td class="col-xs-1">
							
						</td>
					</tr>
					<tr>
						<td colspan="6">
								<b>Name & Address of Customer Billed :</b> <br>						
								${invoice.customer_name}<br>						
								${invoice.customer_address}						
							</td>
							<td colspan="6">
								<b>Delivery Address - Ship To :</b>	<br>			
								${invoice.customer_name}<br>						
								${invoice.site_address}						
							</td>
					</tr>
					<tr class="text-center">
						<td rowspan="2" colspan="2">S/L No.</td>
						<td rowspan="2">Description of Goods RMC</td>
						<td rowspan="2">Qty (M3)</td>
						<td rowspan="2">Rate</td>
						<td rowspan="2">Assessable Value of Goods</td>
						<td colspan="4">
							Amount
						</td>
						<td rowspan="2">Total GST</td>
						<td rowspan="2">Total Amount</td>
					</tr>
					<tr class="text-center">
						<td colspan="2" class="col-xs-2">CGST (9%)</td>
						<td colspan="2" class="col-xs-2">SGST (9%)</td>
					</tr>
					<tr class="text-center">
						 <td>1</td>
						 <td></td>
						 <td>${invoice.product_name}</td>
						 <td>${invoice.quantity}</td>
						 <td>${invoice.rate}</td>
						 <td>${invoice.gross_amount}</td>
						 <c:set var="sgst">
							<fmt:formatNumber type="number" minFractionDigits="2" groupingUsed="false"
								maxFractionDigits="2" value="${invoice.tax_amount/2}" />
						</c:set>
						 <td colspan="2" class="col-xs-2">${sgst}</td>
						 <c:set var="cgst">
							<fmt:formatNumber type="number" groupingUsed="false" minFractionDigits="2"
								maxFractionDigits="2" value="${invoice.tax_amount/2}" />
						</c:set>
						 <td colspan="2" class="col-xs-2">${cgst}</td>
						 <td>${invoice.tax_amount}</td>
						 <td>${invoice.net_amount}</td>
					</tr>
					<tr class="text-center">
						<td colspan="2">Cementition.Type</td>
						<td colspan="2">Max.Agg Size</td>
						<td colspan="2">Admixure Type</td>
						<td colspan="2">Slump</td>
						<td colspan="4">Min.Cementitious Content</td>
					</tr>
					<tr class="text-center">
						<td colspan="2">OPC+SCM+PFA</td>
						<td colspan="2">20MM</td>
						<td colspan="2"></td>
						<td colspan="2">130+/-20MM</td>
						<td colspan="4"></td>
					</tr>
					<tr>
						<td colspan="12">
							Total Invoice Amount in Words : INR sixteen Thousand,two Hundred  only.
						</td>
					</tr>
					<tr>
						<td colspan="9">
							This is to certify that the Particulars given herein is as per Section 4 of Central Excise Act and the amount indicated in the document represents the price actually charged and that there is no additional consideration flowing directly or indirectly.								
						</td>
						<td colspan="3">NOTE : 1M3=2400 Kgs+/-5%</td>
					</tr>
					<tr>
						<td colspan="6">Mode of Transport: Road</td>
						<td colspan="6">Booking Station</td>
					</tr>
					<tr>
						<td colspan="6">Name of Transport : PMR </td>
						<td colspan="6">Receiving Station</td>
					</tr>
					<tr>
						<td colspan="6">Vehicle Regn No : KA 59 0178</td>
						<td colspan="6">D.O/Challan Number</td>
					</tr>
					<tr>
						<td colspan="6">L.R/R.R No. & Dt :Own Transport Road Permit Number :</td>
						<td colspan="6">Batch No: </td>
					</tr>
					<tr>
						<td colspan="4">Order Quantity (Cubic Meter)</td>
						<td colspan="4"> Quantity with this load  (Cubic Meter)</td>
						<td colspan="4">Cummulative  Quantity   (Cubic Meter)</td>
					</tr>
					<tr class="text-center">
						<td colspan="4">${invoice.gquantity}</td>
						<td colspan="4">${invoice.quantity}</td>
						<td colspan="4">${invoice.cum_quantity}</td>
					</tr>
					<tr>
						<td colspan="12">Pouring Location / Structure :</td>
					</tr>
					<tr>
						<td colspan="9">Whether this concrete is pumped by PMR Concrete : Yes/No PUMP-LP</td>
						<td colspan="3">Time of arrival on site :</td>
					</tr>
					<tr>
						<td colspan="3">Time discharge completed : </td>
						<td colspan="3">Time released from site : </td>
						<td colspan="3">Water added at site : </td>
						<td colspan="3">Admixture added at site :</td>
					</tr>
					<tr>
						<td colspan="12">Remarks:</td>
					</tr>
					<tr>
						<td colspan="12">
							Please Note : This concrete delivery is subject to the terms and condition of Sales as shown in our quotation. The time allowed for updating this delivery is 15 minutes. We reserve the right to change for any detention beyond this time as per our quotation.Any unauthorized addition of water and/or any other material to concrete shall absolve us from any liability whatsoever. Any deficiency in methods of placing,compacting,finishing and curing of concrete adopted at site may affect quality of concrete in the finished work,for which we shall not be held liable and responsible.Any disputes that arise on quantity and quality (except comp.srength)of concrete supplied in this load shall be reposted to us writing with in 24 hours from the time of supply.Working in cementitious and wet condition products, so wear appropriate protective safety goggles, waterproof gloves,rubber boots, and clothing sufficient to protect skin from contact with wet product should be worn.For any queries,incidents and complaints towards the supplies,please write to us at pmrrmc@pmrreadymix.com	<br><br>
							I hereby confirm that :
							<li>I/We have accepted delivery of concrete as per the details mentioned above.</li>
							<li>I/We have authorized addition of any water and/or admixture as mentioned above</li>	
						</td>
					</tr>
					<tr>
						<td colspan="6"><h5>Receiver Signature & Seal :<br><br><br><br></h5></td>
						<td colspan="6" class="text-center"><h5>For PMR READYMIX CONCRETE (India) Pvt Ltd</h5><br><h5>Authorized Signatory</h5></td>
					</tr>
				</table>
			</div>
			<div style="page-break-after: always;"></div>
			<div class="disp">
				<table class="table table-condensed">
					<tr>
						<td colspan="6" class="text-left" style="border-top: 1px solid black;">
							NOT FOR CENVAT CREDIT PURPOSE 
						</td>
						<td colspan="6" class="text-right" style="border-top: 1px solid black;">
							ORIGINAL FOR BUYER
						</td>
					</tr>
					<tr>
						<td colspan="6" class="col-xs-6">
							
						</td>
						<td colspan="6" class="text-center col-xs-6">
							<h4>${company.company_name}</h4>
							(Invoice for removal of Excisable Goods from factory or warehouse, under Rule 4, 11 & 12 BB of Central Excise Rules, 2002 and Rule 3(5) & Rule 12 A of Cenvat Credit Rules 2004)
						</td>
					</tr>
					<tr>
						<td colspan="6">
							PMR Readymix Concrete (India) Pvt Lts<br>						
							${company.company_address}<br>					
							Telephone No: ${company.company_phone} <br>						
							Website: www.pmrreadymix.com<br>						
							Email : customercare@pmrreadymix.com<br>					
						</td>
						<td colspan="6">
							<br>Invoice Number: PMRP/2018-19/<fmt:formatNumber value="${invoice.invoice_id}" groupingUsed="false" minIntegerDigits="5"/><br>				
							Invoice Date: ${invoice.invoice_date}<br>				
							Cusomer P O Number: ${invoice.po_number}<br>				
							Date and Time of Removal: ${invoice.invoice_date} - ${invoice.invoice_time}				
						</td>
					</tr>
					<tr>
						<td colspan="6" class="col-xs-6">
							Range Address :  RANGE-CED7						
							Division Address :  EAST DIVISION-7 NEW 						
							Commissionerate Address : BENGALURU EAST NEW						
						</td>
						<td   class="col-xs-1">
							Pre Authenticated by
							EXEMPTED FROM 
							PREAUTHENTICATION
						</td>
						<td colspan="5" class="col-xs-5" rowspan="2">								
							Excisable Commodity: Ready Mix Concrete<br>			
							Excisable Tariff Heading Number:<br>			
							GSTIN: ${company.gstin_number}<br>			
							CST Number:<br>			
							Customer GSTIN: ${invoice.customer_gstin}<br>			
							E-way Bill No:<br>			
						</td>
					</tr>
					<tr>
						<td colspan="6">
							No & date of Notification :						
							(Under Which rate of Duty paid/Concession Claimed)						
							Notification No.16/2012-Central Excise, dated 17th March 2012						
	
						</td>
						<td class="col-xs-1">
							
						</td>
					</tr>
					<tr>
						<td colspan="6">
								<b>Name & Address of Customer Billed :</b> <br>						
								${invoice.customer_name}<br>						
								${invoice.customer_address}						
							</td>
							<td colspan="6">
								<b>Delivery Address - Ship To :</b>	<br>			
								${invoice.customer_name}<br>						
								${invoice.site_address}						
							</td>
					</tr>
					<tr class="text-center">
						<td rowspan="2" colspan="2">S/L No.</td>
						<td rowspan="2">Description of Goods RMC</td>
						<td rowspan="2">Qty (M3)</td>
						<td rowspan="2">Rate</td>
						<td rowspan="2">Assessable Value of Goods</td>
						<td colspan="4">
							Amount
						</td>
						<td rowspan="2">Total GST</td>
						<td rowspan="2">Total Amount</td>
					</tr>
					<tr class="text-center">
						<td colspan="2" class="col-xs-2">CGST (9%)</td>
						<td colspan="2" class="col-xs-2">SGST (9%)</td>
					</tr>
					<tr class="text-center">
						 <td>1</td>
						 <td></td>
						 <td>${invoice.product_name}</td>
						 <td>${invoice.quantity}</td>
						 <td>${invoice.rate}</td>
						 <td>${invoice.gross_amount}</td>
						 <c:set var="sgst">
							<fmt:formatNumber type="number" minFractionDigits="2" groupingUsed="false"
								maxFractionDigits="2" value="${invoice.tax_amount/2}" />
						</c:set>
						 <td colspan="2" class="col-xs-2">${sgst}</td>
						 <c:set var="cgst">
							<fmt:formatNumber type="number" groupingUsed="false" minFractionDigits="2"
								maxFractionDigits="2" value="${invoice.tax_amount/2}" />
						</c:set>
						 <td colspan="2" class="col-xs-2">${cgst}</td>
						 <td>${invoice.tax_amount}</td>
						 <td>${invoice.net_amount}</td>
					</tr>
					<tr class="text-center">
						<td colspan="2">Cementition.Type</td>
						<td colspan="2">Max.Agg Size</td>
						<td colspan="2">Admixure Type</td>
						<td colspan="2">Slump</td>
						<td colspan="4">Min.Cementitious Content</td>
					</tr>
					<tr class="text-center">
						<td colspan="2">OPC+SCM+PFA</td>
						<td colspan="2">20MM</td>
						<td colspan="2"></td>
						<td colspan="2">130+/-20MM</td>
						<td colspan="4"></td>
					</tr>
					<tr>
						<td colspan="12">
							Total Invoice Amount in Words : INR sixteen Thousand,two Hundred  only.
						</td>
					</tr>
					<tr>
						<td colspan="9">
							This is to certify that the Particulars given herein is as per Section 4 of Central Excise Act and the amount indicated in the document represents the price actually charged and that there is no additional consideration flowing directly or indirectly.								
						</td>
						<td colspan="3">NOTE : 1M3=2400 Kgs+/-5%</td>
					</tr>
					<tr>
						<td colspan="6">Mode of Transport: Road</td>
						<td colspan="6">Booking Station</td>
					</tr>
					<tr>
						<td colspan="6">Name of Transport : PMR </td>
						<td colspan="6">Receiving Station</td>
					</tr>
					<tr>
						<td colspan="6">Vehicle Regn No : KA 59 0178</td>
						<td colspan="6">D.O/Challan Number</td>
					</tr>
					<tr>
						<td colspan="6">L.R/R.R No. & Dt :Own Transport Road Permit Number :</td>
						<td colspan="6">Batch No: </td>
					</tr>
					<tr>
						<td colspan="4">Order Quantity (Cubic Meter)</td>
						<td colspan="4"> Quantity with this load  (Cubic Meter)</td>
						<td colspan="4">Cummulative  Quantity   (Cubic Meter)</td>
					</tr>
					<tr class="text-center">
						<td colspan="4">${invoice.gquantity}</td>
						<td colspan="4">${invoice.quantity}</td>
						<td colspan="4">${invoice.cum_quantity}</td>
					</tr>
					<tr>
						<td colspan="12">Pouring Location / Structure :</td>
					</tr>
					<tr>
						<td colspan="9">Whether this concrete is pumped by PMR Concrete : Yes/No PUMP-LP</td>
						<td colspan="3">Time of arrival on site :</td>
					</tr>
					<tr>
						<td colspan="3">Time discharge completed : </td>
						<td colspan="3">Time released from site : </td>
						<td colspan="3">Water added at site : </td>
						<td colspan="3">Admixture added at site :</td>
					</tr>
					<tr>
						<td colspan="12">Remarks:</td>
					</tr>
					<tr>
						<td colspan="12">
							Please Note : This concrete delivery is subject to the terms and condition of Sales as shown in our quotation. The time allowed for updating this delivery is 15 minutes. We reserve the right to change for any detention beyond this time as per our quotation.Any unauthorized addition of water and/or any other material to concrete shall absolve us from any liability whatsoever. Any deficiency in methods of placing,compacting,finishing and curing of concrete adopted at site may affect quality of concrete in the finished work,for which we shall not be held liable and responsible.Any disputes that arise on quantity and quality (except comp.srength)of concrete supplied in this load shall be reposted to us writing with in 24 hours from the time of supply.Working in cementitious and wet condition products, so wear appropriate protective safety goggles, waterproof gloves,rubber boots, and clothing sufficient to protect skin from contact with wet product should be worn.For any queries,incidents and complaints towards the supplies,please write to us at pmrrmc@pmrreadymix.com	<br><br>
							I hereby confirm that :
							<li>I/We have accepted delivery of concrete as per the details mentioned above.</li>
							<li>I/We have authorized addition of any water and/or admixture as mentioned above</li>	
						</td>
					</tr>
					<tr>
						<td colspan="6"><h5>Receiver Signature & Seal :<br><br><br><br></h5></td>
						<td colspan="6" class="text-center"><h5>For PMR READYMIX CONCRETE (India) Pvt Ltd</h5><br><h5>Authorized Signatory</h5></td>
					</tr>
				</table>
			</div>
		</div>
	</div>

	<!-- jQuery library -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

	<!-- Latest compiled JavaScript -->
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	
	
</body>
</html>