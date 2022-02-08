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
		font-size: 12px;
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
			<!-- Get sales document details -->
			<sql:query var="sales" dataSource="jdbc/rmc">
				select s.*,c.customer_name,c.customer_address,c.customer_gstin,c.business_id,st.site_address,
				pl.plant_name,pl.plant_address,pl.plant_phones,pl.plant_email,pl.plant_gstin,
				DATE_FORMAT(s.invoice_date,'%d/%m/%Y') as invoice_date
				from sales_document s ,customer c, site_detail st,plant pl
				where s.customer_id=c.customer_id
				and s.site_id=st.site_id
				and s.plant_id=pl.plant_id
				and s.id=?
				<sql:param value="${param.id}"/>
			</sql:query>
			<c:forEach items="${sales.rows}" var="sales">
				<c:set value="${sales}" var="rs"/>
			</c:forEach>
			<table class="table table-condensed"  style="width: 100%">
				<tr>
					<td colspan="8" align="center" style="border:1px solid black;">
						<div class="col-xs-2"></div>
						<div class="col-xs-8 text-center" style="font-size: 1.2em;font-weight: bold;">
							DELIVERY CHALLAN
						</div>
						<div class="col-xs-2 text-right">(ORIGINAL)</div>
					</td>
				</tr>
				<tr>
					<td class="text-center" colspan="8">
							<div class="col-xs-2">
								<c:choose>
									<c:when test="${rs.business_id==1}">
										<img src="image/logo/smlpashphalt.PNG" width="120" height="80" class="pull-left">										
									</c:when>
									<c:when test="${rs.business_id==2}">
										<img src="image/logo/smlpashphalt.jpg" width="120" height="80" class="pull-left">										
									</c:when>
									<c:when test="${rs.business_id==3}">
										<img src="image/logo/smlpprecast.PNG" width="120" height="80" class="pull-left">										
									</c:when>
								</c:choose>
							</div>
							<div class="col-xs-8">
								<h3 style="margin-top:0px;margin-bottom: 0px;"><strong>${rs.plant_name}</strong></h3>
								<p style="font-size: 1.2em;margin-bottom: 0px;">Plant Address : ${rs.plant_address}<br>
								     Registered Office : Ground Floor No - 1265, HIG B-Sector, Yelahanka New Town, Bengaluru Urban, Karnataka - 560064<br>
								     ${rs.plant_phones}<br>
								     Email: ${rs.plant_email}<br>
								<b>GSTIN: ${rs.plant_gstin}</b></p>
							</div>
					</td>
				</tr>
				<tr>
					<td style="padding-right: 0px;font-size:1.2em;" colspan="4" rowspan="3" class="col-xs-6"><b>Customer
							Name &amp; Address<br></b><strong>${rs.customer_name}</strong>
						   <p>${rs.customer_address}</p>
					</td>
					<td colspan="4" class="col-xs-6" style="padding-top: 10px;padding-bottom: 10px;"><b>DC No: <fmt:formatNumber value="${rs.invoice_id}" minIntegerDigits="2" groupingUsed="false" maxFractionDigits="0"/></b></td>
				</tr>
				<tr>
					<td colspan="4" class="col-xs-6" style="padding-top: 10px;padding-bottom: 10px;"><b>DC Date &amp; Time:</b> ${rs.invoice_date}  ${rs.invoice_time}</td>
				</tr>
				<tr>
					<td style="padding-top: 10px;padding-bottom: 10px;" colspan="4"><b>Customer
							PO:</b> ${rs.po_number}</td>
				</tr>
				<tr>
					<td colspan="4" rowspan="3">
							<b>Site Name &amp; Address:</b>
						    <p>${rs.site_address}</p>
					</td>
					<td colspan="4" style="padding-top: 10px;padding-bottom: 10px;"><b>Customer GSTIN No:</b>${rs.customer_gstin}</td>
				</tr>
				<tr>
					<td colspan="4" style="padding-top: 10px;padding-bottom: 10px;">
							<b>HSN COMODITY : </b>
					</td>
				</tr>
				<tr>
					<td  colspan="4" style="padding-top: 10px;padding-bottom: 10px;">
							<b>HSN CODE : </b>
					</td>
				</tr>
				<tr class="text-center" style="font-weight: bold;">
					<td>S/L No</td>
					<td colspan="2">MATERIAL</td>
					<td colspan="1">QUANTITY</td>
					<td colspan="1">MEASURING UNIT</td>
					<td colspan="1">RATE</td>
					<td colspan="2">AMOUNT</td>
				</tr>
				
				<!-- Get sales document item details -->
				
				
				<c:set value="0" var="count"/>
				<c:set value="0" var="total_gross"/>
				<c:set value="0" var="total_tax"/>
				<c:set value="0" var="total_net"/>
				<c:set value="GST" var="tax_type"/>
				<c:set value="0" var="tax_percent"/>
				<sql:query var="sdi" dataSource="jdbc/rmc">
					select s.id,s.item_quantity,s.item_price,p.product_name,p.unit_of_measurement,
					s.gross_price,s.tax_price,s.net_price,po.rate_include_tax,g.gst_percent,g.gst_category
					from sales_document_item s LEFT JOIN(purchase_order_item poi,product p,purchase_order po,gst_percent g)
					ON s.poi_id=poi.poi_id
					and poi.product_id=p.product_id
					and poi.order_id=po.order_id
					and po.gst_id=g.gst_id
					where s.id=?
					<sql:param value="${param.id}"/>
				</sql:query>
				
				<c:forEach items="${sdi.rows}" var="sdi">
				<c:set value="${count+1}" var="count"/>
				<c:set value="${total_gross+sdi.gross_price}" var="total_gross"/>
				<c:set value="${total_tax+sdi.tax_price}" var="total_tax"/>
				<c:set value="${total_net+sdi.net_price}" var="total_net"/>
				<c:set value="${sdi.gst_category}" var="tax_type"/>
				<c:set value="${sdi.gst_percent}" var="tax_percent"/>
				<tr class="text-center">
					<td>${count}</td>
					<td colspan="2">${sdi.product_name}</td>
					<td colspan="1">${sdi.item_quantity}</td>
					<td colspan="1">${sdi.unit_of_measurement}</td>
					<td>
						<fmt:formatNumber value="${(sdi.rate_include_tax=='yes')?(sdi.item_price/(100+sdi.gst_percent))*100:sdi.item_price}" maxFractionDigits="2" groupingUsed="false"/>
					</td>
					<td colspan="2" class="text-right"><fmt:formatNumber value="${sdi.gross_price}" groupingUsed="false" maxFractionDigits="2" minFractionDigits="2"/></td>
				</tr>
				</c:forEach>
				
				<tr>
					<td colspan="4"></td>
					<th colspan="2" class="text-right">Net Amount (Exclude GST)</th>
					<td class="text-right" colspan="2" style="font-weight: bold;;"><fmt:formatNumber value="${total_gross}"
								 maxFractionDigits="2" minFractionDigits="2" groupingUsed="false" type="currency"  pattern="#,##,##,##,###.00"/></td>
				</tr>
				
				
				
				<tr>
					<c:set value="${invoice.net_ammount}" var="word" />
					<td colspan="8"><b>AMOUNT IN WORDS: RUPEES <span class="in-word text-uppercase"></span> ONLY</b> 
					<input type="hidden" name="net_amt" id="net_amt" value="${total_gross}"/>
					</td>
				</tr>
				<tr>
					<td colspan="4"><b>Mode of Transport : </b>BY ROAD</td>
					<td colspan="4"><b>Vehicle No : </b>${rs.vehicle_no}</td>
				</tr>
				<tr>
					<td colspan="4" style="padding-top:10px;">
						<b>Note : --</b>
						<ol>
							<li>Extra 18% tax will be charged on the net amount.</li>
						</ol>
					</td>
					<td colspan="4" style="padding-top:10px;">
						<c:choose>
							<c:when test="${rs.business_id==1}">
							</c:when>
							<c:when test="${rs.business_id==2}">
							</c:when>
							<c:when test="${rs.business_id==3}">
								<b>A/C NAME : SMLP PRECAST PAVERS AND PRODUCTS</b><br>
								<b>A/C NO : 9092000100052901</b><br>
								<b>IFSC CODE : KARB0000909</b><br>
								<b>BANK : KARNATAKA BANK</b><br>
								<b>BRANCH : YELAHANKA NEW TOWN</b><br>										
							</c:when>
						</c:choose>
					</td>
				</tr>
				<tr>
					<td colspan="4" class="text-center">
					<p class="text-left">Receiver Name : </p><br>
					<p class="text-left">Receiver Mob No : </p>
					<h4 class="text-center" style="margin-bottom: 0px;margin-left: 100px;"><b>Receiver Signatory</b></h4></td>
					<td colspan="4" class="text-center">
					<p class="text-center" style="font-size: 16px;"><b></b></p><br><br>
					<p class="text-left">&nbsp;</p>
					<h4 class="text-center" style="margin-bottom: 0px;"><b>Authorized Signatory</b></h4></td>
				</tr>
				<tr>
					<td colspan="8" class="text-center">This is computer generated invoice</td>
				</tr>
			</table>
			<div id="" class="no-print" style="text-align: center;">
				<button onclick="window.print()" class="btn btn-primary no-print">PRINT</button>
				&nbsp;&nbsp;&nbsp;
				<button onclick="window.history.back()" class="btn btn-danger">BACK</button>
			</div>
			
			<div style="page-break-after: always;"></div>
			<table class="table table-condensed dispr"  style="width: 100%">
				<tr>
					<td colspan="8" align="center" style="border:1px solid black;">
						<div class="col-xs-2"></div>
						<div class="col-xs-8 text-center" style="font-size: 1.2em;font-weight: bold;">
							DELIVERY CHALLAN
						</div>
						<div class="col-xs-2 text-right">(DUPLICATE)</div>
					</td>
				</tr>
				<tr>
					<td class="text-center" colspan="8">
							<div class="col-xs-2">
								<c:choose>
									<c:when test="${rs.business_id==1}">
										<img src="image/logo/smlpashphalt.PNG" width="120" height="80" class="pull-left">										
									</c:when>
									<c:when test="${rs.business_id==2}">
										<img src="image/logo/smlpashphalt.jpg" width="120" height="80" class="pull-left">										
									</c:when>
									<c:when test="${rs.business_id==3}">
										<img src="image/logo/smlpprecast.PNG" width="120" height="80" class="pull-left">										
									</c:when>
								</c:choose>
							</div>
							<div class="col-xs-8">
								<h3 style="margin-top:0px;margin-bottom: 0px;"><strong>${rs.plant_name}</strong></h3>
								<p style="font-size: 1.2em;margin-bottom: 0px;">Plant Address : ${rs.plant_address}<br>
								     Registered Office : Ground Floor No - 1265, HIG B-Sector, Yelahanka New Town, Bengaluru Urban, Karnataka - 560064<br>
								     ${rs.plant_phones}<br>
								     Email: ${rs.plant_email}<br>
								<b>GSTIN: ${rs.plant_gstin}</b></p>
							</div>
					</td>
				</tr>
				<tr>
					<td style="padding-right: 0px;font-size:1.2em;" colspan="4" rowspan="3" class="col-xs-6"><b>Customer
							Name &amp; Address<br></b><strong>${rs.customer_name}</strong>
						   <p>${rs.customer_address}</p>
					</td>
					<td colspan="4" class="col-xs-6" style="padding-top: 10px;padding-bottom: 10px;"><b>DC No:  <fmt:formatNumber value="${rs.invoice_id}" minIntegerDigits="2" groupingUsed="false" maxFractionDigits="0"/></b></td>
				</tr>
				<tr>
					<td colspan="4" class="col-xs-6" style="padding-top: 10px;padding-bottom: 10px;"><b>DC Date &amp; Time:</b> ${rs.invoice_date}  ${rs.invoice_time}</td>
				</tr>
				<tr>
					<td style="padding-top: 10px;padding-bottom: 10px;" colspan="4"><b>Customer
							PO:</b> ${rs.po_number}</td>
				</tr>
				<tr>
					<td colspan="4" rowspan="3">
							<b>Site Name &amp; Address:</b>
						    <p>${rs.site_address}</p>
					</td>
					<td colspan="4" style="padding-top: 10px;padding-bottom: 10px;"><b>Customer GSTIN No:</b>${rs.customer_gstin}</td>
				</tr>
				<tr>
					<td colspan="4" style="padding-top: 10px;padding-bottom: 10px;">
							<b>HSN COMODITY : </b>
					</td>
				</tr>
				<tr>
					<td  colspan="4" style="padding-top: 10px;padding-bottom: 10px;">
							<b>HSN CODE : </b>
					</td>
				</tr>
				<tr class="text-center" style="font-weight: bold;">
					<td>S/L No</td>
					<td colspan="2">MATERIAL</td>
					<td colspan="1">QUANTITY</td>
					<td colspan="1">MEASURING UNIT</td>
					<td colspan="1">RATE</td>
					<td colspan="2">AMOUNT</td>
				</tr>
				
				<!-- Get sales document item details -->
				
				
				<c:set value="0" var="count"/>
				<c:set value="0" var="total_gross"/>
				<c:set value="0" var="total_tax"/>
				<c:set value="0" var="total_net"/>
				<c:set value="GST" var="tax_type"/>
				<c:set value="0" var="tax_percent"/>
				<sql:query var="sdi" dataSource="jdbc/rmc">
					select s.id,s.item_quantity,s.item_price,p.product_name,p.unit_of_measurement,
					s.gross_price,s.tax_price,s.net_price,po.rate_include_tax,g.gst_percent,g.gst_category
					from sales_document_item s LEFT JOIN(purchase_order_item poi,product p,purchase_order po,gst_percent g)
					ON s.poi_id=poi.poi_id
					and poi.product_id=p.product_id
					and poi.order_id=po.order_id
					and po.gst_id=g.gst_id
					where s.id=?
					<sql:param value="${param.id}"/>
				</sql:query>
				
				<c:forEach items="${sdi.rows}" var="sdi">
				<c:set value="${count+1}" var="count"/>
				<c:set value="${total_gross+sdi.gross_price}" var="total_gross"/>
				<c:set value="${total_tax+sdi.tax_price}" var="total_tax"/>
				<c:set value="${total_net+sdi.net_price}" var="total_net"/>
				<c:set value="${sdi.gst_category}" var="tax_type"/>
				<c:set value="${sdi.gst_percent}" var="tax_percent"/>
				<tr class="text-center">
					<td>${count}</td>
					<td colspan="2">${sdi.product_name}</td>
					<td colspan="1">${sdi.item_quantity}</td>
					<td colspan="1">${sdi.unit_of_measurement}</td>
					<td>
						<fmt:formatNumber value="${(sdi.rate_include_tax=='yes')?(sdi.item_price/(100+sdi.gst_percent))*100:sdi.item_price}" maxFractionDigits="2" groupingUsed="false"/>
					</td>
					<td colspan="2" class="text-right"><fmt:formatNumber value="${sdi.gross_price}" groupingUsed="false" maxFractionDigits="2" minFractionDigits="2"/></td>
				</tr>
				</c:forEach>
				
				<tr>
					<td colspan="4"></td>
					<th colspan="2" class="text-right">Net Amount (Exclude GST)</th>
					<td class="text-right" colspan="2" style="font-weight: bold;;"><fmt:formatNumber value="${total_gross}" maxFractionDigits="2" minFractionDigits="2" groupingUsed="false"/></td>
				</tr>
				
				
				
				<tr>
					<c:set value="${invoice.net_ammount}" var="word" />
					<td colspan="8"><b>AMOUNT IN WORDS: RUPEES <span class="in-word text-uppercase"></span> ONLY</b> 
					<input type="hidden" name="net_amt" id="net_amt" value="${total_gross}"/>
					</td>
				</tr>
				<tr>
					<td colspan="4"><b>Mode of Transport : </b>BY ROAD</td>
					<td colspan="4"><b>Vehicle No : </b>${rs.vehicle_no}</td>
				</tr>
				<tr>
					<td colspan="4" style="padding-top:10px;">
						<b>Note : --</b>
						<ol>
							<li>Extra 18% tax will be charged on the net amount.</li>
						</ol>
					</td>
					<td colspan="4" style="padding-top:10px;">
						<c:choose>
							<c:when test="${rs.business_id==1}">
							</c:when>
							<c:when test="${rs.business_id==2}">
							</c:when>
							<c:when test="${rs.business_id==3}">
								<b>A/C NAME : SMLP PRECAST PAVERS AND PRODUCTS</b><br>
								<b>A/C NO : 9092000100052901</b><br>
								<b>IFSC CODE : KARB0000909</b><br>
								<b>BANK : KARNATAKA BANK</b><br>
								<b>BRANCH : YELAHANKA NEW TOWN</b><br>										
							</c:when>
						</c:choose>
					</td>
				</tr>
				<tr>
					<td colspan="4" class="text-center">
					<p class="text-left">Receiver Name : </p><br>
					<p class="text-left">Receiver Mob No : </p>
					<h4 class="text-center" style="margin-bottom: 0px;margin-left: 100px;"><b>Receiver Signatory</b></h4></td>
					<td colspan="4" class="text-center">
					<p class="text-center" style="font-size: 16px;"><b></b></p><br><br>
					<p class="text-left">&nbsp;</p>
					<h4 class="text-center" style="margin-bottom: 0px;"><b>Authorized Signatory</b></h4></td>
				</tr>
				<tr>
					<td colspan="8" class="text-center">This is computer generated invoice</td>
				</tr>
			</table>
	</div>
</body>

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
  		var net_amt=$('#net_amt').val();
  		net_amt=parseInt(net_amt);
  		var word=inWords(net_amt);
  		$('.in-word').text(word);
  	});
  </script>
</html>