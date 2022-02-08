<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">

<style>
		.b1{
			background-color: #c5eada;
		}
		
		.b2{
			background-color: #b8b8e0;
		}
</style>
</head>
<body>
	<div class="container">
		<div class="row">
			<div class="col-sm-12">
				<br>
				<sql:query var="batch" dataSource="jdbc/rmc">
					select t.*, DATE_FORMAT(t.batch_date,'%d/%m/%Y') as batch_date from batch_detail t where Batch_No=?
					<sql:param value="${param.Batch_No}"/>
				</sql:query>
				<c:forEach items="${batch.rows}" var="batch">
					<c:set value="${batch}" var="bat"/>
				</c:forEach>
				<table class="table table-bordered table-hover">
					<tr>
						<th class="text-center" colspan="9">
							BATCH REPORT OF BATCH NO - ${param.Batch_No}
						</th>
					</tr>
					<tr>
						<td><b>Batch No : </b></td>
						<td colspan="2">${bat.Batch_No}</td>
						<td><b>Customer : </b></td>
						<td colspan="2">${bat.cust_id}</td>
						<td><b>Grade : </b></td>
						<td colspan="2">${bat.cust_id}</td>
					</tr>
					<tr>
						<td><b>Batch Date : </b></td>
						<td colspan="2">${bat.batch_date}</td>
						<td><b>Start Time : </b></td>
						<td colspan="2">${bat.batch_start_time_txt}</td>
						<td><b>End Time : </b></td>
						<td colspan="2">${bat.batch_end_time_txt}</td>
					</tr>
					<tr>
						<td><b>Site :</b> </td>
						<td colspan="2">${bat.site}</td>
						<td><b>Vehicle No :</b> </td>
						<td colspan="2">${bat.Truck_Id}</td>
						<td><b>Quantity :</b> </td>
						<td colspan="2">${bat.Production_Qty}</td>
					</tr>
					<tr>
						<th class="text-center">SET/BATCH</th>
						<th class="text-center">SAND1</th>
						<th class="text-center">SAND2</th>
						<th class="text-center">20MM</th>
						<th class="text-center">12MM</th>
						<th class="text-center">CEMENT</th>
						<th class="text-center">GGBS</th>
						<th class="text-center">WATER</th>
						<th class="text-center">ADMIX</th>
					</tr>	
					
					<sql:query var="set" dataSource="jdbc/rmc">
						select DISTINCT Prod1_Agg_Stwt,Prod2_Agg_Stwt,Prod3_Agg_Stwt,Prod4_Agg_Stwt,
						Prod7_Cem_Stwt,Prod8_Cem_Stwt,Prod12_Wtr_Stwt,Prod15_Adm_Stwt
						from batch_transaction
						where Batch_No=?
						<sql:param value="${param.Batch_No}"/>
					</sql:query>
					<sql:query var="transaction" dataSource="jdbc/rmc">
						select Prod1_Agg_Stwt,Prod1_Agg_Atwt,Prod2_Agg_Stwt,Prod2_Agg_Atwt,Prod3_Agg_Stwt,Prod3_Agg_Atwt,Prod4_Agg_Stwt,Prod4_Agg_Atwt,
						Prod7_Cem_Stwt,Prod7_Cem_Atwt,Prod8_Cem_Stwt,Prod8_Cem_Atwt,Prod12_Wtr_Stwt,Prod12_Wtr_Atwt,Prod15_Adm_Stwt,Prod15_Adm_Atwt
						from batch_transaction
						where Batch_No=?
						<sql:param value="${param.Batch_No}"/>
					</sql:query>
					<c:forEach items="${set.rows}" var="set">
						<c:set value="${set}" var="st"/>
					</c:forEach>
						<tr>
							<td class="text-center"><b>SET</b></td>
							<td class="text-center">${st.Prod1_Agg_Stwt}</td>
							<td class="text-center">${st.Prod2_Agg_Stwt}</td>
							<td class="text-center">${st.Prod3_Agg_Stwt}</td>
							<td class="text-center">${st.Prod4_Agg_Stwt}</td>
							<td class="text-center">${st.Prod7_Cem_Stwt}</td>
							<td class="text-center">${st.Prod8_Cem_Stwt}</td>
							<td class="text-center">${st.Prod12_Wtr_Stwt}</td>
							<td class="text-center">${st.Prod15_Adm_Stwt}</td>
						</tr>
					<c:set value="0" var="count"/>
					<c:set value="0" var="sum1"/>
					<c:set value="0" var="sum2"/>
					<c:set value="0" var="sum3"/>
					<c:set value="0" var="sum4"/>
					<c:set value="0" var="sum5"/>
					<c:set value="0" var="sum6"/>
					<c:set value="0" var="sum7"/>
					<c:set value="0" var="sum8"/>
					<c:forEach items="${transaction.rows}" var="transaction">
						<c:set var="count" value="${count+1}"/>
						<tr>
							<td class="text-center"><b>${count}</b></td>
							<td class="text-center">${transaction.Prod1_Agg_Atwt}</td>
							<td class="text-center">${transaction.Prod2_Agg_Atwt}</td>
							<td class="text-center">${transaction.Prod3_Agg_Atwt}</td>
							<td class="text-center">${transaction.Prod4_Agg_Atwt}</td>
							<td class="text-center">${transaction.Prod7_Cem_Atwt}</td>
							<td class="text-center">${transaction.Prod8_Cem_Atwt}</td>
							<td class="text-center">${transaction.Prod12_Wtr_Atwt}</td>
							<td class="text-center">${transaction.Prod15_Adm_Atwt}</td>
						</tr>
						<c:set value="${sum1+transaction.Prod1_Agg_Stwt}" var="sum1"/>
						<c:set value="${sum2+transaction.Prod2_Agg_Stwt}" var="sum2"/>
						<c:set value="${sum3+transaction.Prod3_Agg_Stwt}" var="sum3"/>
						<c:set value="${sum4+transaction.Prod4_Agg_Stwt}" var="sum4"/>
						<c:set value="${sum5+transaction.Prod7_Cem_Stwt}" var="sum5"/>
						<c:set value="${sum6+transaction.Prod8_Cem_Stwt}" var="sum6"/>
						<c:set value="${sum7+transaction.Prod12_Wtr_Stwt}" var="sum7"/>
						<c:set value="${sum8+transaction.Prod15_Adm_Stwt}" var="sum8"/>
					</c:forEach>
						<tr>
							<td colspan="9"></td>
						</tr>
						<tr>
							<td colspan="9"></td>
						</tr>
						<tr>
							<th class="text-center b1">TOTAL SET</th>
							<th class="text-center b1">${st.Prod1_Agg_Stwt*bat.Production_Qty}</th>
							<th class="text-center b1">${st.Prod2_Agg_Stwt*bat.Production_Qty}</th>
							<th class="text-center b1">${st.Prod3_Agg_Stwt*bat.Production_Qty}</th>
							<th class="text-center b1">${st.Prod4_Agg_Stwt*bat.Production_Qty}</th>
							<th class="text-center b1">${st.Prod7_Cem_Stwt*bat.Production_Qty}</th>
							<th class="text-center b1">${st.Prod8_Cem_Stwt*bat.Production_Qty}</th>
							<th class="text-center b1">${st.Prod12_Wtr_Stwt*bat.Production_Qty}</th>
							<th class="text-center b1">${st.Prod15_Adm_Stwt*bat.Production_Qty}</th>
						</tr>
						<tr>
							<th class="text-center b2">TOTAL BATCHED</th>	
							<th class="text-center b2">${sum1}</th>
							<th class="text-center b2">${sum2}</th>
							<th class="text-center b2">${sum3}</th>
							<th class="text-center b2">${sum4}</th>
							<th class="text-center b2">${sum5}</th>
							<th class="text-center b2">${sum6}</th>
							<th class="text-center b2">${sum7}</th>
							<th class="text-center b2"><fmt:formatNumber value="${sum8}" maxFractionDigits="2"/></th>
						</tr>				
				</table>
			</div>	
		</div>		
	</div>
<!-- jQuery library -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<!-- Latest compiled JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
</body>
</html>