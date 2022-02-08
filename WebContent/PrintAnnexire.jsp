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


.vll{
	border-right: 1px solid white;
	border-bottom: 1px solid white;
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
		<div class="row">
			<div class="col-xs-12">
				<div class="col-sm-12 printme table-responsive" id="printme">
           			<!-- Get all kind of query here -->
					<sql:query var="invoice" dataSource="jdbc/rmc">
						select DATE_FORMAT(i.invoice_date,'%d/%m/%Y') as invoice_date,
						i.invoice_id,i.vehicle_no,p.product_name,i.quantity,i.net_amount
						from invoice i LEFT JOIN(purchase_order_item poi,product p)
						ON i.poi_id=poi.poi_id
						and poi.product_id=p.product_id 
						where i.customer_id=? 
						and i.invoice_date between STR_TO_DATE(?, '%d/%m/%Y') and STR_TO_DATE(?, '%d/%m/%Y')
						<sql:param value="${param.customer_id}"/>
						<sql:param value="${param.from_date}"/>
						<sql:param value="${param.to_date}"/>
					</sql:query>
           			<table class="table" id="example-2">
           				<tr class="text-center">
           					<td colspan="6" style="border-top: 1px solid black;">ANNEXIRE</td>
           				</tr>
           				<sql:query var="customer_name" dataSource="jdbc/rmc">
           					select customer_name from customer where customer_id=?
           					<sql:param value="${param.customer_id}"/>
           				</sql:query>
           				<c:forEach items="${customer_name.rows}" var="customer_name">
           					<c:set value="${customer_name.customer_name}" var="customer_name1"/>
           				</c:forEach>
           				<tr class="text-center">
           					<td colspan="6"><b>Name of the Customer : ${customer_name1}</b></td>
           				</tr>
           				<tr class="text-center">
           					<td>Date</td>
           					<td>Invoice No</td>
           					<td>Vehicle</td>
           					<td>Grade</td>
           					<td>Quantity</td>
           					<td>Amount</td>
           				</tr>
           				<c:set value="0" var="total_quant"/>
           				<c:set value="0" var="total_net"/>
           				<c:forEach items="${invoice.rows}" var="invoice">
           					<tr class="text-center" style="border-bottom: 1px solid black !important;">
           						<td class="vll">${invoice.invoice_date}</td>
           						<td class="vll">GST/<fmt:formatNumber value="${invoice.invoice_id}" groupingUsed="false" minIntegerDigits="5"/></td>
           						<td class="vll">${invoice.vehicle_no}</td>
           						<td class="vll">${invoice.product_name}</td>
           						<td class="vll">${invoice.quantity}</td>
           						<td class="vll" style="border-right: 1px solid black;">${invoice.net_amount}</td>
           					</tr>
           					<c:set value="${total_quant+invoice.quantity}" var="total_quant"/>
           					<c:set value="${total_net+invoice.net_amount}" var="total_net"/>
           				</c:forEach>
           					<tr>
           						<td colspan="6"></td>
           					</tr>
           					
           					<tr>
           						<td colspan="4" class="text-right">Total</td>
           						<td class="text-center">${total_quant}</td>
           						<td class="text-center">${total_net}</td>
           					</tr>
           		</table>
           		<div class="text-center no-print">
           			<button class="btn btn-success" onclick="window.print();">Print</button>
           			<button class="btn btn-danger" onclick=" window.history.back();">Back</button>
           		</div>
			</div>
		</div>		
	</div>
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