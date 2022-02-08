<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Print Fleet Recept</title>
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
		<sql:query var="fo" dataSource="jdbc/rmc">
				select * from fleet_outgoing where fleet_outgoing_id=?
	<sql:param value="${param.fleet_outgoing_id}"/>
		</sql:query>
		<c:forEach var="fo" items="${fo.rows}">
			<table class="table"  style="width: 100%">
				<tr>
					<td colspan="10" align="center" style="border:1px solid black;"><P style="font-size: 2.0em;">DISPATCH RECEIPT</P>
					</td>
				</tr>
				<tr>
						<td colspan="8" class="col-xs-10">
							<h2 class="text-center">${initParam.company_name}</h2>
							<p class="text-center">${initParam.company_address}</p>
							<p class="text-center">${initParam.company_phone}</p>
						</td>
						<td colspan="2" class="col-xs-2">
							<h4 class="text-center">GATE PASS NO</h4>
							<p class="text-center">7467</p>
						</td>
					</tr>
					
			<tr>
						<td colspan="5" class="col-xs-6" >
							<p style="line-height: 25px;" class="text-right">
								RECEIVED PERSON : ${fo.recived_person}<br>
								RETURNABLE : ${fo.returnable}<br>
							</p>
						</td>
						<td colspan="5" class="col-xs-6">
							<p style="line-height: 25px;" class="text-right">
								 ${fo.issued_date} : DISPATCH DATE  <br>
								 ${fo.issued_time} : DISPATCH TIME<br>
								 ${fo.return_status} : RETURN STATUS <br>
								
							</p>
						</td>
					</tr>
					
		        	<tr>
						<td colspan="2" class="text-center">S/L NO</td>
						<td colspan="4" class="text-center">PRODUCT NAME</td>
						<td colspan="5" class="text-center">QUANTITY</td>
					</tr>
					<!-- GET ALL PO ITEM LIST DETAILS -->
					<sql:query var="foi" dataSource="jdbc/rmc">
						select f.*,i.item_name,foi.fleet_item_id,foi.quantity from fleet_outgoing f,fleet_item i,fleet_outgoing_item foi where foi.fleet_item_id=i.fleet_item_id and f.fleet_outgoing_id=foi.fleet_outgoing_id and f.fleet_outgoing_id=?
						<sql:param value="${param.fleet_outgoing_id}"/>
					</sql:query>
					<c:set value="0" var="count"/>
					<c:forEach items="${foi.rows}" var="foi">
					<c:set value="${count+1}" var="count"/>
					<tr>
						<td colspan="2" class="text-center">${count}</td>
						<td colspan="4" class="text-center">${foi.item_name}</td>
						<td colspan="5" class="text-center">${foi.quantity}</td>
					</tr>
					</c:forEach>
					<tr>
						<td colspan="5" class="text-center">
							<br><br><br>
							RECEIVER SIGNETORY
						</td>
						<td colspan="5" class="text-center">
							<br><br><br>
							AUTHORISED SIGNETORY
						</td>
					</tr>
			</table>
			<div id="" class="no-print" style="text-align: center;">
				<button onclick="window.print()" class="btn btn-success no-print">PRINT</button>
				&nbsp;&nbsp;&nbsp;
				<button onclick="window.history.back()" class="btn btn-danger">BACK</button>
			</div>
			
		</c:forEach>
	</div>
</body>
</html>