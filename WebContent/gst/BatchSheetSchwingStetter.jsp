<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
	<title>SCHEWING STETTER BATCH SHEET</title>
	<!-- Latest compiled and minified CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <style type="text/css">	
    	 @page {
	    size: A4;
	    margin-left: 10px;
	    margin-top: 15px;

	   }


	   .no-border td, .no-border th {
		    border: none !important;
		}

		hr{
	   		border:1px solid  black !important;
	   		margin-top: -20px;
	   		margin-left: 10px;
	   	}
		.borderless>thead>tr>th,.borderless>tbody>tr>th,.borderless>tfoot>tr>th,.borderless>thead>tr>td,.borderless>tbody>tr>td,.borderless>tfoot>tr>td{
			padding: 2px !important;
		}
		.table3>thead>tr>th,.table3>tbody>tr>th,.table3>tfoot>tr>th,.table3>thead>tr>td,.table3>tbody>tr>td,.table3>tfoot>tr>td{
			padding: 0px !important;
		}

		body{
			font-size: 11px;
		}
		
		@media print{
			.no-print{
				display: none;
			}
		}

    </style>

</head>
<!-- Generate Batch Sheet Here -->
<c:catch var="ctch">
 	 <sql:update dataSource="jdbc/rmc" var="ex">
 			call testbatchsheetsave(?,@a);
 			<sql:param value="${param.id}"/>
 	 </sql:update>
 </c:catch>
 <sql:query var="available" dataSource="jdbc/rmc">
 	 select * from test_batchingsheet where id=?
 	 <sql:param value="${param.id}"/>
 </sql:query>
 
 <c:set value="false" var="availability"/>
 <c:forEach items="${available.rows}" var="available">
 	  <c:set value="true" var="availability"/>
 </c:forEach>
 

<body>
	<div class="container">
	<c:choose>
	   <c:when test="${availability==true}">
	   	<sql:query var="start_time" dataSource="jdbc/rmc">
		  	select addtime(subtime(min(target_time),max(target_time)),min(target_time)) as start_time
		    from (select * from test_batchingsheet where id=? limit 2) as t
		    <sql:param value="${param.id}"/>
	    </sql:query>
		<sql:query var="mix" dataSource="jdbc/rmc">
	 	select p.*,REPLACE(format(p.aggregate1_value*p.p_quantity,0),',','') as p1,REPLACE(format(p.aggregate1_value*p.p_quantity,0),',','') as p1,
	 	REPLACE(format(p.aggregate1_value*p.p_quantity,0),',','') as p1,REPLACE(format(p.aggregate2_value*p.p_quantity,0),',','') as p2,
	 	REPLACE(format(p.aggregate3_value*p.p_quantity,0),',','') as p3,REPLACE(format(p.aggregate4_value*p.p_quantity,0),',','') as p4,
	 	REPLACE(format(p.aggregate5_value*p.p_quantity,0),',','') as p5,REPLACE(format(p.aggregate6_value*p.p_quantity,0),',','') as p6,
	 	REPLACE(format(p.aggregate7_value*p.p_quantity,0),',','') as p7,REPLACE(format(p.aggregate8_value*p.p_quantity,0),',','') as p8,
	 	REPLACE(format(p.aggregate9_value*p.p_quantity,2),',','') as p9,REPLACE(format(p.aggregate10_value*p.p_quantity,1),',','') as p10,
	 	REPLACE(format(p.aggregate11_value*p.p_quantity,0),',','') as p11 from (select t.*,format((t.aggregate1_value*p),0) as g1,format((t.aggregate2_value*p),0) as g2,format((t.aggregate3_value*p),0) as g3,format((t.aggregate4_value*p),0) as g4,
	 	format((t.aggregate5_value*p),0) as g5,format((t.aggregate6_value*p),0) as g6,format((t.aggregate7_value*p),0) as g7,format((t.aggregate8_value*p),0) as g8,
	 	format((t.aggregate9_value*p),2) as g9,format((t.aggregate10_value*p),1) as g10,format((t.aggregate11_value*p),0) as g11	
	 	from  ( select i.id,i.invoice_id,i.site_id as siteid,i.poi_id as po_id,i.vehicle_no,i.driver_name,i.pump,m.*,c.customer_phone,a.site_address as site_address,a.site_name, format((select sum(quantity) from test_invoice ii 
		where ii.customer_id=i.customer_id and ii.invoice_date=i.invoice_date and ii.invoice_id <=i.invoice_id),1) as cum_quantity,
		truncate(i.quantity/ceil(i.quantity),2) as batch_size,p.product_name,g.quantity,pl.plant_name,(i.quantity/ceil(i.quantity)) as p,
		DATE_FORMAT(i.invoice_date, '%d-%m-%Y') as real_date,c.customer_name,i.quantity as p_quantity,g.quantity as order_quantity,i.invoice_time as end_time,i.docket_no,
		CAST(truncate(m.aggregate9_value,2) AS CHAR) as agm,format(ceil(i.quantity),0) as quant,ceil(i.quantity) as qua
		from test_invoice i LEFT JOIN (test_receipe m,test_site_detail  a,test_customer c,test_purchase_order_item g,product p,plant pl,test_purchase_order po)
		ON i.customer_id=c.customer_id
		and i.poi_id=g.poi_id
		and g.order_id=po.order_id
		and po.site_id=m.site_id
		and g.product_id=m.product_id
		and g.product_id=p.product_id
		and i.plant_id=pl.plant_id
		and i.site_id=a.site_id
		where i.id=?) as t) as p
		<sql:param value="${param.id}"/>
	  </sql:query>
	  <c:forEach var="mix" items="${mix.rows}">
  		<c:set value="${mix}" var="rec"/>
      </c:forEach>
		<div class="row">
			<table class="table table-condensed borderless no-border" style="margin-left: 30px;">
				<tr>
					<td colspan="20">
						<div class="col-xs-2">
							<img  src="image/stetter.png" width="100" height="100">
						</div>
						<div class="col-xs-10">
							<h3 style="font-size: 20px;">ROCK READY MIX CONCRETE</h3>
						    <h4 style="font-size: 16px;">MCI 360 Control System Ver 1.0</h4>
						</div>
					</td>
				</tr>
				<tr>
					<td colspan="20"><h4 class="text-center"><b>Docket / Batch Report / Autographic Record</b></h4></td>
				</tr>
				<tr class="hello">
					<td></td>
					<td colspan="4">
						<b>Batch Date</b>
					</td>
					<td colspan="3">
						7/19/2018
					</td>
					<td colspan="3">
						
					</td>
					<td colspan="3">
						
					</td>
					<td colspan="4">
						
					</td>
					<td colspan="2">
						
					</td>
				</tr>
				<tr style="margin-top: 0px !important;padding-top: 0px !important">
					<td></td>
					<td colspan="4">
						<b>Batch Start Time</b>
					</td>
					<td colspan="3">
						<c:forEach items="${start_time.rows}" var="start_time">
						  		${start_time.start_time}
						</c:forEach> 
					</td>
					<td colspan="3">
						
					</td>
					<td colspan="3">
						
					</td>
					<td colspan="4">
						<b>Plant Serial Number</b>
					</td>
					<td colspan="2">
						120
					</td>
				</tr>
				<tr style="margin-top: 0px !important;">
					<td></td>
					<td colspan="4">
						<b>Batch End Time</b>
					</td>
					<td colspan="3">
						${rec.end_time}
					</td>
					<td colspan="3">
						
					</td>
					<td colspan="3">
						
					</td>
					<td colspan="4">
						
					</td>
					<td colspan="2">
						
					</td>
				</tr>
				<tr style="margin-top: 0px !important;">
					<td></td>
					<td colspan="4">
						
					</td>
					<td colspan="3">
						
					</td>
					<td colspan="3">
						<b>Recipe Code</b>
					</td>
					<td colspan="3">
						${rec.recipe_code}
					</td>
					<td colspan="4">
						<b>Ordered Quantity</b>
					</td>
					<td colspan="2">
						
						${rec. order_quantity}M<sup>3</sup>
					</td>
				</tr>
				<tr>
					<td></td>
					<td colspan="4">
						<b>Batcher Name</b>
					</td>
					<td colspan="3">
						ROCK2015
					</td>
					<td colspan="3">
						<b>Recipe Name</b>
					</td>
					<td colspan="3">
						${rec.product_name}
					</td>
					<td colspan="4">
						<b>Adj/Manual Quantity</b>
					</td>
					<td colspan="2">
						0.00 M<sup>3</sup>
					</td>
				</tr>
				<tr>
					<td></td>
					<td colspan="4">
						<b>Batch Number</b>
					</td>
					<td colspan="3">
						${rec.invoice_id}
					</td>
					<td colspan="3">
						<b>Truck Number</b>
					</td>
					<td colspan="3">
						${rec.vehicle_no}
					</td>
					<td colspan="4">
						<b>With this load</b>
					</td>
					<td colspan="2">
						${rec.p_quantity} M<sup>3</sup>
					</td>
				</tr>
				<tr>
					<td></td>
					<td colspan="4">
						<b>Order Number</b>
					</td>
					<td colspan="3">
						7B
					</td>
					<td colspan="3">
						<b>Truck Driver</b>
					</td>
					<td colspan="3">
						${rec.driver_name}
					</td>
					<td colspan="4">
						<b>Mixer Capacity</b>
					</td>
					<td colspan="2">
						1.00 M<sup>3</sup>
					</td>
				</tr>
				<tr>
					<td></td>
					<td colspan="4">
						<b>Customer</b>
					</td>
					<td colspan="9">
						${rec.customer_name}
					</td>
					<td colspan="4">
						<b>Batch Size</b>
					</td>
					<td colspan="2">
						<fmt:formatNumber value="${rec.batch_size}" maxFractionDigits="2" minFractionDigits="2"/> M<sup>3</sup>
					</td>
				</tr>
				<tr>
					<td></td>
					<td colspan="4">
						<b>Site</b>
					</td>
					<td colspan="15">
						${rec.site_address}
					</td>
				</tr>
			</table>
			<hr>
			<table class="table table-condensed no-border table3" style="margin-top: -20px;">
				<tr>
					<td colspan="6" class="text-center"><h4>Aggregates</h4></td>
					<td colspan="5" class="text-center"><h4>Cement</h4></td>
					<td colspan="3" class="text-center"><h4>Water/Ice</h4></td>
					<td colspan="4" class="text-center"><h4>Admixture</h4></td>
					<td colspan="2" class="text-center"><h4>Silica</h4></td>
				</tr>
				<tr class="text-center">
					<td style="width: 5%;"></td>
					<td style="width: 5%;">${rec.aggregate1_name}</td>
				    <td style="width: 5%;">${rec.aggregate2_name}</td>
				    <td style="width: 5%;">${rec.aggregate3_name}</td>
				    <td style="width: 5%;">${rec.aggregate4_name}</td>
				    <td style="width: 5%;">0</td>
				    <td style="width: 5%;">0</td>
				    <td style="width: 5%;">${rec.aggregate5_name}</td>
				    <td style="width: 5%;">${rec.aggregate6_name}</td>
				    <td style="width: 5%;">0</td>
				    <td style="width: 5%;">0</td>
				    <td style="width: 5%;">${rec.aggregate7_name}</td>
				    <td style="width: 5%;">${rec.aggregate8_name}</td>
				    <td style="width: 5%;">0</td>
				    <td style="width: 5%;">0</td>
				    <td style="width: 5%;">${rec.aggregate9_name}</td>
				    <td style="width: 5%;">0</td>
				    <td style="width: 5%;">0</td>
				    <td style="width: 5%;">0</td>
				    <td style="width: 5%;">Silica</td>
				   
				
				</tr>

			</table>
			<hr>
			<table class="table table-condensed no-border" style="margin-top: -20px;">
				<tr><td colspan="20" style="padding-top: -20px !important;"><b>Target and Actual value with moisture correction in % and other correction in Kgs.</b></td></tr>
			</table>
			<sql:query var="gen" dataSource="jdbc/rmc">
			 	 select t.*,CAST(ag9 AS CHAR) as ee from  (select b.*,truncate(b.aggr9,2) ag9 from test_batchingsheet b where id=?) as t
			 	<sql:param value="${param.id}"/>
			</sql:query>
			<table class="table table-condensed no-border text-center" style="margin-top: -20px;">
				<c:forEach items="${gen.rows}" var="gen">
					<tr>
						<td style="width: 5%;">
						</td>
						<td style="width: 5%;">
							${rec.g1}<br>
							${gen.aggr1}<br>
							0.0
						</td>
						<td style="width: 5%;">
							${rec.g2}<br>
							${gen.aggr2}<br>
							0.0
						</td>
						<td style="width: 5%;">
							${rec.g3}<br>
							${gen.aggr3}<br>
							0.0
						</td>
						<td style="width: 5%;">
							${rec.g4}<br>
							${gen.aggr4}<br>
							0.0
						</td>
						<td style="width: 5%;">
							0<br>
							0<br>
							0.0
						</td>
						<td style="width: 5%;">
							0<br>
							0<br>
							0.0
						</td>
						<td style="width: 5%;">
							${rec.g5}<br>
							${gen.aggr5}<br>
							0.0
						</td>
						<td style="width: 5%;">
							${rec.g6}<br>
							${gen.aggr6}<br>
							0
						</td>
						<td style="width: 5%;">
							0<br>
							0<br>
							0
						</td>
						<td style="width: 5%;">
							0<br>
							0<br>
							0
						</td>
						<td style="width: 5%;">
							${rec.g7}<br>
							${gen.aggr7}<br>
							0
						</td>
						<td style="width: 5%;">
							${rec.g8}<br>
							${gen.aggr8}<br>
							0
						</td>
						<td style="width: 5%;">
							0<br>
							0<br>
							0
						</td>
						<td style="width: 5%;">
							0<br>
							0<br>
							
						</td>
						<td style="width: 5%;">
							${rec.g9}<br>
							${gen.aggr9}<br>
							0.00
						</td>
						<td style="width: 5%;">
							0.00<br>
							0.00<br>
							0.00
						</td>
						<td style="width: 5%;">
							0.00<br>
							0.00<br>
							0.00
						</td>
						<td style="width: 5%;">
							0.00<br>
							0.00<br>
							0.00
						</td>
						<td style="width: 5%;">
							0<br>
							0<br>
							0
						</td>
						
					</tr>
				</c:forEach>
			</table>
			<hr>
			<table class="table table-condensed no-border borderless" style="margin-top: -20px;margin-left: 14px;">
				<tr>
					<td colspan="20"><b>Total Set Weight in Kgs.</b></td>
				</tr>
				<tr>
					<td style="width: 5%;"></td>
					<td style="width: 5%;">${rec.p1}</td>
				    <td style="width: 5%;">${rec.p2}</td>
				    <td style="width: 5%;">${rec.p3}</td>
				    <td style="width: 5%;">${rec.p4}</td>
				    <td style="width: 5%;">0</td>
				    <td style="width: 5%;">0</td>
				    <td style="width: 5%;">${rec.p5}</td>
				    <td style="width: 5%;">${rec.p6}</td>
				    <td style="width: 5%;">0</td>
				    <td style="width: 5%;">0</td>
				    <td style="width: 5%;">${rec.p7}</td>
				    <td style="width: 5%;">${rec.p8}</td>
				    <td style="width: 5%;">0</td>
				    <td style="width: 5%;">0</td>
				    <td style="width: 5%;">${rec.p9}</td>
				    <td style="width: 5%;">0.00</td>
				    <td style="width: 5%;">0.00</td>
				    <td style="width: 5%;">0.00</td>
				    <td style="width: 5%;">0</td>
				</tr>
				<tr>
					<td colspan="20"><b>Total Actual in Kgs.</b></td>
				</tr>
				<sql:query var="sum" dataSource="jdbc/rmc">
				  		select sum(aggr1) as s1,sum(aggr2)as s2,sum(aggr3) as s3,sum(aggr4) as s4,sum(aggr5) as s5,sum(aggr6) as s6,sum(aggr7) as s7,sum(aggr8) as s8,format(sum(aggr9),2) as s9,
				  		sum(aggr10) as s10,sum(aggr11) as s11 from test_batchingsheet where id=?;
				  		<sql:param value="${param.id}"/>
				 </sql:query>
				 
				 <c:forEach items="${sum.rows}" var="sum">
				 	<c:set value="${sum}" var="sumbatch"/>
				 </c:forEach>
				<tr>
					<td style="width: 5%;"></td>
					<td style="width: 5%;">${sumbatch.s1}</td>
				    <td style="width: 5%;">${sumbatch.s2}</td>
				    <td style="width: 5%;">${sumbatch.s3}</td>
				    <td style="width: 5%;">${sumbatch.s4}</td>
				    <td style="width: 5%;">0</td>
				    <td style="width: 5%;">0</td>
				    <td style="width: 5%;">${sumbatch.s5}</td>
				    <td style="width: 5%;">${sumbatch.s6}</td>
				    <td style="width: 5%;">0</td>
				    <td style="width: 5%;">0</td>
				    <td style="width: 5%;">${sumbatch.s7}</td>
				    <td style="width: 5%;">${sumbatch.s8}</td>
				    <td style="width: 5%;">0</td>
				    <td style="width: 5%;">0</td>
				    <td style="width: 5%;">${sumbatch.s9}</td>
				    <td style="width: 5%;">0.00</td>
				    <td style="width: 5%;">0.00</td>
				    <td style="width: 5%;">0.00</td>
				    <td style="width: 5%;">0</td>
				</tr>
				<tr>
					<td colspan="20"><b>Difference between Total Set Weight and Total Actual in %</b></td>
				</tr>
				<sql:query var="ress" dataSource="jdbc/rmc">
					select truncate(((${sumbatch.s1}-${rec.p1})/${sumbatch.s1})*100,2) as m1,truncate(((${sumbatch.s2}-${rec.p2})/${sumbatch.s2})*100,2) as m2,truncate(((${sumbatch.s3}-${rec.p3})/${sumbatch.s3})*100,2) as m3,
					truncate(((${sumbatch.s4}-${rec.p4})/${sumbatch.s4})*100,2) as m4,truncate(((${sumbatch.s5}-${rec.p5})/${sumbatch.s5})*100,2) as m5,truncate(((${sumbatch.s6}-${rec.p6})/${sumbatch.s6})*100,2) as m6,
					truncate(((${sumbatch.s7}-${rec.p7})/${sumbatch.s7})*100,2) as m7,truncate(((${sumbatch.s8}-${rec.p8})/${sumbatch.s8})*100,2) as m8,truncate(((${sumbatch.s9}-${rec.p9})/${sumbatch.s9})*100,2) as m9;
				</sql:query>
				
				<c:forEach items="${ress.rows}" var="ress">
					<c:set value="${ress}" var="rs"/>
				</c:forEach>
				<tr>
					<td style="width: 5%;"></td>
					<td style="width: 5%;">${rs.m1}</td>
				    <td style="width: 5%;">${rs.m2}</td>
				    <td style="width: 5%;">${rs.m3}</td>
				    <td style="width: 5%;">${rs.m4}</td>
				    <td style="width: 5%;">0</td>
				    <td style="width: 5%;">0</td>
				    <td style="width: 5%;">${rs.m5}</td>
				    <td style="width: 5%;">${rs.m6}</td>
				    <td style="width: 5%;">0</td>
				    <td style="width: 5%;">0</td>
				    <td style="width: 5%;">${rs.m7}</td>
				    <td style="width: 5%;">${rs.m8}</td>
				    <td style="width: 5%;">0</td>
				    <td style="width: 5%;">0</td>
				    <td style="width: 5%;">${rs.m9}</td>
				    <td style="width: 5%;">0.00</td>
				    <td style="width: 5%;">0.00</td>
				    <td style="width: 5%;">0.00</td>
				    <td style="width: 5%;">0</td>
				</tr>
			</table>
			<div class="no-print text-center">
				<button class="btn btn-success" onclick="window.print();">Print</button>
				<button class="btn btn-danger" onclick="window.history.back();">Go Back</button>
			</div>
		</div>
		</c:when>
		<c:otherwise>
			<table class="table">
				<tr>
					<td class="text-center"><h2>Please add Mix Design</h2></td>
				</tr>
				<tr>
					<td class="text-center"><button class="btn btn-danger" onclick="window.history.back();">BACK</button></td>
				</tr>
			</table>
		</c:otherwise>
	</c:choose>
	</div>

<!-- jQuery library -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<!-- Latest compiled JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>
</html>