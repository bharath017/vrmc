<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Print Purchase Order</title>
<!-- Latest compiled and minified CSS -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">

	<!-- jQuery library -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>

	<!-- Latest compiled JavaScript -->
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
	
	<style type="text/css">
		table tr td,th{
			border:1px solid black;
		}

		.table>thead>tr>th,.table>tbody>tr>th,.table>tfoot>tr>th,.table>thead>tr>td,.table>tbody>tr>td,.table>tfoot>tr>td{
			padding: 2px;
		}

		table{
			font-size: 12px;
		}
	</style>
</head>
<sql:query var="po" dataSource="jdbc/rmc">
	select po.*,s.site_address,DATE_FORMAT(po.po_date,'%d/%m/%Y') as po_date,c.customer_panno,c.customer_gstin,m.mp_name
    from purchase_order po,site_detail s,customer c,marketing_person m
	where po.site_id=s.site_id
	and po.customer_id=c.customer_id
	and po.marketing_person_id=m.mp_id
	and po.order_id=?
	<sql:param value="${param.order_id}"/>
</sql:query>

<c:forEach items="${po.rows}" var="po">
	<c:set value="${po}" var="rs"/>
</c:forEach>

<body>
	<div class="container">
		<div class="row">
			<div class="col-xs-12 text-center">
					<h4><b><span style="border-bottom: 1px solid black;">PURCHASE ORDER</span></b></h4>
			</div>
		</div>
		<div class="row">
			<div class="col-xs-5">
				To<br>
				<b>SMLP CONCRETE PRIVATE LIMITED<br>
				Survey No - 46/1, Gopalpura Village, Marenahalli<br>, Bagluru Post, Bangalore - 562149<br>
				9663101429<br>
				</b>
			</div>
		</div>
		<div class="row">
			<div class="col-xs-12 text-center">
				Kind Attention :
			</div>
		</div>
		<div class="row">
			<div class="col-xs-12">
				Dear Sir,
				<br>
				<br>
				With reference to your offer letter no. ${rs.po_number}   Dated : ${rs.po_date} , We hearby place an order for supply of Ready 
				Mix Concrete for our project as per the details mentioned below.
				<br>
				<br>
				<span style="border-bottom: 1px solid black;">Site Address : </span><br>
				<div class="col-xs-4">
					<b><span style="border-bottom: 1px solid black;">${rs.site_address}</span></b>
				</div>
				<br><br>
				Sales Person : ${rs.mp_name}  Mobile No : -----------------------
				<br><br>
			</div>
		</div>
		
		<div class="row">
			<div class="col-xs-12">
				<table class="table">
					<tr class="text-center">
						<th style="border-top: 1px solid black;">S. No.</th>
						<th style="border-top: 1px solid black;">Grade Of concrete</th>
						<th style="border-top: 1px solid black;">PO Quantity (Cum)</th>
						<th style="border-top: 1px solid black;">Sale Price Per<br>Cum(Rs.)</th>
						<th style="border-top: 1px solid black;">Date & Time of Supply</th>
					</tr>
					
					<sql:query var="poi" dataSource="jdbc/rmc">
						select poi.*,p.product_name from purchase_order_item poi,product p
						where poi.product_id=p.product_id 
						and poi.order_id=?
						<sql:param value="${param.order_id}"/>
					</sql:query>
					
					<c:set value="0" var="count"/>
					<c:forEach items="${poi.rows}" var="poi">
						<c:set value="${count+1}" var="count"/>
						<tr>
							<td>${count}</td>
							<td>${poi.product_name}</td>
							<td>${poi.quantity}</td>
							<td>${poi.rate}</td>
							<td></td>
						</tr>
					</c:forEach>
				</table>
			</div>
		</div>
		<div class="row">
			<div class="col-xs-12">
				We heaeby agree to the terms and conditions and mentioned in your aforesaid offer letter. 
				This purchase order shall be further subject to the following terms and conditions : 
				<ol>
					<li>Goods and Service Tax (GST) and other taxes/duties, as applicable, shall be paid as per the invoice raised to us.</li>
					<li>The above rates are inclusive of charges for transportation and pumping of the concrete the project site.</li>
					<li>Above rates are valid up to ------------</li>
					<li>We encolse herewith advance payment of RS. -------- against this purchase order by way cheque/Demand draft no ------- . Date ------ drawn on ------------- bank --------------</li>
				</ol>
				
				Please sign the duplicate copy of this purchase order in token of your acceptance.
			</div>
		</div>
		<div class="row">
			<div class="col-xs-12 text-right">
				<h5>GST NO : ${rs.customer_gstin}</h5>
				<h5>PAN CARD NO : ${rs.customer_panno}</h5>
				<h5>ADHAR CARD NO : </h5>
			</div>
		</div>
		
		<div class="row">
			<div class="col-xs-12">
				Thanking you,<br>
				Yours faithfully
			</div>
		</div>
	</div>
</body>
</html>