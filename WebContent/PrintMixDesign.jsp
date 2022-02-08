<%@ include file="Session.jsp" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<!DOCTYPE html>
<html>
<head>
	<title>Mix Design Print</title>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

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
<!-- Get company details here -->
<sql:query var="comp" dataSource="jdbc/rmc">
	select * from company_detail where company_id=1
</sql:query>
<c:forEach items="${comp.rows}" var="comp">
	<c:set value="${comp}" var="company"/>
</c:forEach>

<sql:query var="mix" dataSource="jdbc/rmc">
	select * from mix_design where design_id=?
	<sql:param value="${param.design_id}"/>
</sql:query>

<c:forEach items="${mix.rows}" var="mix">
	<c:set value="${mix}" var="rs"/>
</c:forEach>
<body>
	<div class="container">
		<div class="row">
			<div class="col-xs-12">
				<table class="table">
					<tr>
						<td style="border-top: 1px solid black;" class="text-center" colspan="6">
							<h3>${company.company_name}</h3>
							<p>Address : ${company.company_address}</p>
							<p>Email : ${company.company_mail}</p>
						</td>
					</tr>
					<tr>
						<td colspan="6" class="text-center">
							<h4 class="text-center"><b>MIX DESIGN OF GRADE : </b>${rs.recipe_name}</h4>
						</td>
					</tr>
					<tr>
						<td colspan="3" class="col-xs-6"><b>Receipe Code : </b>${rs.recipe_code}</td>
						<td colspan="3" class="col-xs-6"><b>Receipe Name : </b>${rs.recipe_name}</td>
					</tr>
					<tr>
						<td>1</td>
						<td colspan="3"><b>${rs.aggregate1_name}</b></td>
						<td colspan="2">${rs.aggregate1_value} Kg</td>
					</tr>
					<tr>
						<td>2</td>
						<td colspan="3"><b>${rs.aggregate2_name}</b></td>
						<td colspan="2">${rs.aggregate2_value} Kg</td>
					</tr>
					<tr>
						<td>3</td>
						<td colspan="3"><b>${rs.aggregate3_name}</b></td>
						<td colspan="2">${rs.aggregate3_value} Kg</td>
					</tr>
					<tr>
						<td>4</td>
						<td colspan="3"><b>${rs.aggregate4_name}</b></td>
						<td colspan="2">${rs.aggregate4_value} Kg</td>
					</tr>
					<tr>
						<td>5</td>
						<td colspan="3"><b>${rs.aggregate5_name}</b></td>
						<td colspan="2">${rs.aggregate5_value} Kg</td>
					</tr>
					<tr>
						<td>6</td>
						<td colspan="3"><b>${rs.aggregate6_name}</b></td>
						<td colspan="2">${rs.aggregate6_value} Kg</td>
					</tr>
					<tr>
						<td>7</td>
						<td colspan="3"><b>${rs.aggregate7_name}</b></td>
						<td colspan="2">${rs.aggregate7_value} Kg</td>
					</tr>
					<tr>
						<td>8</td>
						<td colspan="3"><b>${rs.aggregate8_name}</b></td>
						<td colspan="2">${rs.aggregate8_value} Kg</td>
					</tr>
					<tr>
						<td>9</td>
						<td colspan="3"><b>${rs.aggregate9_name}</b></td>
						<td colspan="2">${rs.aggregate9_value} Kg</td>
					</tr>
					<tr>
						<td>10</td>
						<td colspan="3"><b>${rs.aggregate10_name}</b></td>
						<td colspan="2">${rs.aggregate10_value} Kg</td>
					</tr>
					
					<tr>
						<td colspan="3" class="text-center">
							<h4>CUSTOMER SIGNETORY</h4><br><br>
						</td>
						<td colspan="3" class="text-center">
							<h4>AUTHORISEDE SIGNETORY</h4><br><br>
						</td>
					</tr>
				</table>
			</div>
			<div class="text-center no-print">
				<button class="btn btn-info" onclick="window.print();">Print</button>
				<button class="btn btn-danger" onclick="window.history.back();">Back</button>
			</div>
		</div>
	</div>
</body>
</html>