<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>CONSOLIDATED INVOICE</title>
<link rel="stylesheet"
	href="js/jquery/bootstrap.min.css">

<!-- jQuery library -->
<script
	src="js/jquery/jquery.min.js"></script>

<!-- Latest compiled JavaScript -->
<script
	src="js/jquery/bootstrap.min.js"></script>
<style type="text/css">
.dispr {
	display: none;
}

@media print {
	.dispr {
		display: block;
	}
	
	table th td{
		border:1px solid black;
	}
}

@media print {
	.no-print, .no-print * {
		display: none !important;
	}
}

.table>thead>tr>th,.table>tbody>tr>th,.table>tfoot>tr>th,.table>thead>tr>td,.table>tbody>tr>td,.table>tfoot>tr>td{
	padding: 2px;	
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




<!-- GET CUSTOMER DATA END'S HERE -->
<sql:query var="invoice" dataSource="jdbc/rmc">
	select c.*,cu.customer_name,cu.customer_gstin,p.plant_name,p.plant_address,p.plant_phones,p.plant_logo,p.plant_email,p.plant_gstin,
	cu.customer_address,cu.customer_phone,cu.customer_panno,
	DATE_FORMAT(c.generate_date,'%d/%m/%Y') as realdate,DATE_FORMAT(c.timestamp,'%h:%m:%s') as generatedtime
	from consolidate_invoice c,customer cu,plant p
	where c.customer_id=cu.customer_id 
	and c.plant_id=p.plant_id
	and c.consolidate_invoice_id= ?
	<sql:param value="${param.id}"/>
</sql:query>

<c:forEach items="${invoice.rows}" var="invoice">
	<c:set value="${invoice}" var="rs"/>
</c:forEach>
<table class="table"  style="width: 100%">
				
				<tr>
					<td colspan="11" align="center" style="border:1px solid black;"><P style="font-size: 2.0em;">CONSOLIDATED TAX INVOICE STATEMENT</P>
					</td>
				</tr>
				<tr>
					<td class="text-center" colspan="3">
						<img src="image/logo/${rs.plant_logo}" class="img img-rounded"
									width="150" height="80">
					</td>
					<td class="text-center" colspan="11">
							<h2><strong>${rs.plant_name}</strong></h2>
							<p>Address : ${rs.plant_address}<br>
							Phone :  ${rs.plant_phones}<br>
							Email : ${rs.plant_email}<br>
							GSTIN: ${rs.plant_gstin}</p>
					</td>
				</tr>
				
				
				<tr>
					<td style="padding-right: 0px;font-size:1.2em;" colspan="6"><b>Customer
							Name:</b><strong>${rs.customer_name}</strong></td>
					<td colspan="5"><b>Customer GSTIN No:</b>${rs.customer_gstin}</td>
				</tr>
				<tr>
					<td class="text-left col-xs-6" colspan="6">
						<h5>
							<b>BILLING ADDRESS:</b>
						</h5>
						<p>
							
							${rs.customer_address}<br>
						</p>
					</td>
					<td class="text-left col-xs-6" colspan="5">
						<b>CUSTOMER PHONE : </b>${rs.customer_phone}<br><br>
						<b>CUSTOMER PAN NO : </b>${rs.customer_panno}
					</td>
				</tr>
				
				<tr>
					<td class="text-left" colspan="6">
						
						
						<b>Generated Date :</b> ${rs.realdate}<br>
						
						<b>Generated Time :</b> ${rs.generatedtime} 
					</td>
					<td colspan="5">
						<p>
							<b>HSN COMODITY : </b>READY MIX CONCRETE
						</p>
						<p>
							<b>HSN CODE : </b> 38245010
						</p>	
					</td>
				</tr>
				
				<tr class="text-center">
					<td>INVOICE</td>
					<td>VEHICLE</td>
					<td>DATE</td>
					<td>GRADE</td>
					<td>QTY</td>
					<td class="col-xs-2">SITE ADDRESS</td>
					<td>RATE</td>
					<td>SUB TOTAL</td>
					<td>TAX AMOUNT</td>
					<td>AMOUNT(INR)</td>
				</tr>
				<sql:query var="item" dataSource="jdbc/rmc">
					select sd.invoice_id,sd.vehicle_no,DATE_FORMAT(sd.invoice_date,'%d/%m/%Y') as invoice_date,
					p.product_name,sdi.item_quantity as quantity,s.site_address,sdi.item_price as rate,sdi.gross_price as gross_amount,sdi.tax_price as tax_amount,
					sdi.net_price as net_amount
					from consolidate_invoice_item si LEFT JOIN(sales_document sd,sales_document_item sdi
							,site_detail s,product p,purchase_order_item poi)
					ON si.id=sd.id
					and sd.id=sdi.id
					and sd.site_id=s.site_id
					and sdi.poi_id=poi.poi_id
					and poi.product_id=p.product_id
					where si.consolidate_invoice_id=?
					<sql:param value="${param.id}"/>
				</sql:query>
				
				<c:set value="0" var="total_net"/>
				<c:set value="0" var="total_quantity"/>
				<c:forEach items="${item.rows}" var="item">
					<tr>
						<td>${item.invoice_id}</td>
						<td>${item.vehicle_no}</td>
						<td>${item.invoice_date}</td>
						<td>${item.product_name}</td>
						<td>${item.quantity}</td>
						<td style="font-size: 10px;">${item.site_address}</td>
						<td>${item.rate}</td>
						<td>${item.gross_amount}</td>
						<td>${item.tax_amount}</td>
						<td>${item.net_amount}</td>
						<c:set value="${total_net+item.net_amount}" var="total_net"/>
						<c:set value="${total_quantity+item.quantity}" var="total_quantity"/>
					</tr>
				</c:forEach>				
				
				
				
				<tr>
					<td colspan="5" rowspan="4">
					</td>
					<td colspan="3" class="text-right">TOTAL (RS.) : </td>
					<td colspan="3"><fmt:formatNumber value="${total_net}" maxFractionDigits="2" groupingUsed="false"/></td>
				</tr>
				<tr>
					
					<td colspan="3" class="text-right">PUMP CHARGE (RS.) : </td>
					<td colspan="3"><fmt:formatNumber value="${rs.pump_charge}" maxFractionDigits="2" groupingUsed="false"/></td>
				</tr>
				<tr>
					<td colspan="3" class="text-right">TOTAL QTY: </td>
					<td colspan="3"><fmt:formatNumber value="${total_quantity}" maxFractionDigits="2" groupingUsed="false"/></td>
				</tr>
				<tr>
					<td colspan="3" class="text-center">NET TOTAL (RS.) : </td>
					<td colspan="3" id="amtt"><fmt:formatNumber value="${total_net}" maxFractionDigits="2" groupingUsed="false"/></td>
				</tr>
				<tr>
					<td colspan="11">
						<b>AMOUNT IN WORDS: <span id="amtword" style="font-size:1.2em;font-weight:bold"></span></b> 
					</td>
				</tr>
				<tr>
					<td colspan="6" class="text-center"><br>
					<br>
					<br>
					<b>Receiver Signatory</b></td>
					<td colspan="5" class="text-center"><br>
					<br>
					<br> <b> Authorized Signatory</b></td>

				</tr>
				<tr>
					<td colspan="11" class="text-center">Registered office :
						Address : No 32, Shettarahalli Village, Kasaba Hobli, Devanahalli Taluk, Bangalore Rural,Karnataka - 562110</td>
				</tr>
			</table>
	
			<div id="" class="no-print" style="text-align: center;">
				<button onclick="window.print()" class="btn btn-primary no-print">PRINT</button>
				&nbsp;&nbsp;&nbsp;
				<button onclick="window.history.back()" class="btn btn-danger">BACK</button>
			</div>
	

			
</div>
</body>
	<script>
		var a = ['','one ','two ','three ','four ', 'five ','six ','seven ','eight ','nine ','ten ','eleven ','twelve ','thirteen ','fourteen ','fifteen ','sixteen ','seventeen ','eighteen ','nineteen '];
		var b = ['', '', 'twenty','thirty','forty','fifty', 'sixty','seventy','eighty','ninety'];
		
		function inWords() {
			var num=$('#amtt').html().trim();
			num=parseInt(num);
		    if ((num = num.toString()).length > 9) return 'overflow';
		    n = ('000000000' + num).substr(-9).match(/^(\d{2})(\d{2})(\d{2})(\d{1})(\d{2})$/);
		    if (!n) return; var str = '';
		    str += (n[1] != 0) ? (a[Number(n[1])] || b[n[1][0]] + ' ' + a[n[1][1]]) + 'crore ' : '';
		    str += (n[2] != 0) ? (a[Number(n[2])] || b[n[2][0]] + ' ' + a[n[2][1]]) + 'lakh ' : '';
		    str += (n[3] != 0) ? (a[Number(n[3])] || b[n[3][0]] + ' ' + a[n[3][1]]) + 'thousand ' : '';
		    str += (n[4] != 0) ? (a[Number(n[4])] || b[n[4][0]] + ' ' + a[n[4][1]]) + 'hundred ' : '';
		    str += (n[5] != 0) ? ((str != '') ? 'and ' : '') + (a[Number(n[5])] || b[n[5][0]] + ' ' + a[n[5][1]]) + 'only ' : '';
		    $('#amtword').html(str);
		}
		
	</script>
	<script type="text/javascript">
		$(document).ready(function(){
			inWords();
		});
	</script>
</html>