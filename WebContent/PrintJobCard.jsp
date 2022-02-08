<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Print Job Card</title>
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
		<sql:query var="jobcard" dataSource="jdbc/rmc">
			select * from job_card where id=?
			 <sql:param value="${param.id}"/>
		</sql:query>
		<c:forEach var="jobcard" items="${jobcard.rows}">
			<table class="table table-condensed"  style="width: 100%">
			
				<tr>
					<td class="text-center" colspan="8" style="border:1px solid black;">
							<div class="col-xs-2">
								<img src="image/jpcc.PNG" width="120" height="80" class="pull-left">
							</div>
							<div class="col-xs-8">
								<h3 style="margin-top:0px;margin-bottom: 0px;"><strong>${company.company_name}</strong></h3>
<%-- 								<p style="font-size: 1.2em;margin-bottom: 0px;">${invoice.plant_address}<br> --%>
								     ${company.company_phone}<br>
								     Email: ${company.company_mail}<br><br>
								<b>JOB CARD-OFFICE COPY</b></p>
							</div>
					</td>
				</tr>			
			
				<tr>
					<td colspan="4">Vehicle Details</td>
					<th colspan="2">${jobcard.vehicle_details}</th>
					<th  class="text-right" colspan="2">TM</th>
					
				</tr>
				
				<tr>
					<td colspan="4">REG NO</td>
					<td colspan="4">${jobcard.reg_no}</td>
					
				</tr>
				<tr>
					<td colspan="4">KMS</td>
					<td colspan="4">${jobcard.kilo_meters}</td>
					
				</tr>
				<tr>
					<td colspan="4">Hours</td>
					<td colspan="4">${jobcard.hours}</td>
					
				</tr>
				<tr>
					<td colspan="4">Driver Name</td>
					<td colspan="4">${jobcard.driver_name}</td>
					
				</tr>
				<tr>
					<td colspan="8"></td>					
				</tr>
				<tr>
					<td colspan="4">Arrival Of Vehicle</td>
					<th colspan="2">${jobcard.arrival_time}</th>
					<th  class="text-right" colspan="2"></th>					
				</tr>
				<tr>
					<td colspan="4">Job Started</td>
					<td colspan="4">${jobcard.jobstarted_time}</td>
					
				</tr>
				<tr>
					<td colspan="4">Job Completed</td>
					<td colspan="4">${jobcard.jobcompleted_time}</td>					
				</tr>
				<tr>
					<td colspan="4">Attended By</td>
					<td colspan="4">${jobcard.attended_by}</td>
					
				</tr> 
				<tr>
				
					<td colspan="8" rowspan="8">Problems
					<ul>
							<p class="text-left"> ${(!empty jobcard.frontengine)?'FRONT ENGINE IOL':''}</p>
							<p class="text-left"> ${(!empty jobcard.backengine)?'BACK ENGINE OIL':''}</p>
							<p class="text-left">${(!empty jobcard.drumgearbox)?'DRUM GEAR BOX OIL':''}</p>
							<p class="text-left"> ${(!empty jobcard.frontgear)?'FRONT GEAR BOX OIL':''}</p>
							<p class="text-left">${(!empty rs.coollent)?'HYDRAULIC OIL':''}</p>
							<p class="text-left">${(!empty jobcard.coollent)?'COOLLENT OIL OIL':''}</p>
							<p class="text-left">${(!empty jobcard.clutchoil)?'CLUTCH OIL BREAK OIL':''}</p>
							<p class="text-left">${(!empty jobcard.steering)?'STEERING OIL':''}</p>
							<p class="text-left">${(!empty jobcard.housing)?'HOUSING OIL':''}</p>
							<p class="text-left">${(!empty jobcard.breakoil)?'BREAK OIL':''}</p>
							</ul>
					</td>
								
				</tr>
				
				
				
				
				
				
			</table>
			<div id="" class="no-print" style="text-align: center;">
				<button onclick="window.print()" class="btn btn-primary no-print">PRINT</button>
				&nbsp;&nbsp;&nbsp;
				<button onclick="window.history.back()" class="btn btn-danger">BACK</button>
			</div>
			
			
		
		
		</c:forEach>
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
  
  