<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
	<title>Payment Receipt</title>
	<!-- Latest compiled and minified CSS -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<style type="text/css">
		
		.table tr td{
			border: 1px solid black;
		}
		
		@media print{
			.no-print{
				display: none;
			}
		}
	</style>

</head>
<!-- get company details here-->
<sql:query var="comp" dataSource="jdbc/rmc">
	select * from company_detail where company_id=1
</sql:query>
<c:forEach items="${comp.rows}" var="comp">
	<c:set value="${comp}" var="company"/>
</c:forEach>


<c:catch var="e">
	<!-- Get payment details for view payment receipt -->
	<sql:query var="payment" dataSource="jdbc/rmc">
		select c.*,DATE_FORMAT(c.payment_date,'%d/%m/%Y') as realdate from test_customer_payment c where payment_id=?
		<sql:param value="${param.payment_id}"/>
	</sql:query>
	
	<c:forEach items="${payment.rows}" var="payment">
		<c:set value="${payment}" var="pay"/>
	</c:forEach>
</c:catch>

<body>
	<div class="container">
		<div class="row">
			<div class="col-xs-12">
				<table class="table">
					<tr>
						<td colspan="8" style="border-top: 1px solid black;" class="text-center">Payment Receipt</td>
					</tr>
					<tr class="text-center">
						<td colspan="8">
							<h3>${company.company_name}</h3>
							<P>${company.company_address}</P>
							<p class="text-left">Cash Voucher No: ${pay.payment_id}</p>
						</td>
					</tr>
					<tr>
						<td colspan="4"><b>Amount : </b><span id="pay_amount">${pay.payment_amount}</span> /-</td>
						<td colspan="4" class="text-right"><b>Date : </b>${pay.realdate}</td>
					</tr>
					<tr>
						<td colspan="8" class="text-center"><h4 class="text-center">Method of Payment</h4></td>
					</tr>
					<tr>
						<td colspan="8"><b>Payment Mode : </b>${pay.payment_mode}</td>
					</tr>
					<tr>
						<td colspan="8">To : ${company.company_name}</td>
					</tr>
					<tr>
						<td colspan="8">The Sum Of : <span id="in-word" class="text-uppercase"></span>RUPEES ONLY</td>
					</tr>
					<tr>
						<td colspan="8">
							<h4 class="text-right"><br><br>Authorized Signetory</h4>
						</td>
					</tr>
				</table>
			</div>
			<div id="" class="no-print" style="text-align: center;">
				<button onclick="window.print()" class="btn btn-primary no-print">PRINT</button>
				&nbsp;&nbsp;&nbsp;
				<button onclick="window.history.back()" class="btn btn-danger">BACK</button>
			</div>
		</div>
	</div>
	<!-- jQuery library -->
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
  
  <script type="text/javascript">
  		$(document).ready(function(){
  			var pay_amount=$('#pay_amount').text();
  			pay_amount=(pay_amount==null || pay_amount==undefined)?0:parseInt(pay_amount);
  			var word=inWords(pay_amount);
  			$('#in-word').text(word);
  		});
  </script>
</body>
</html>