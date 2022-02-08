<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
	<title></title>
		<!-- Latest compiled and minified CSS -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">

	<style type="text/css">
		
		.table tr td{
			border:1px solid black;
		}
		
		@media print {
			.no-print, .no-print * {
				display: none !important;
			}
		}
		.nopadding {
		   padding: 0 !important;
		   margin: 0 !important;
		}
		.clearfix {
				  overflow: auto;
		}
		.img2 {
		  float: left;
		}
	</style>
</head>

<sql:query var="po" dataSource="jdbc/rmc">
	select sp.*,p.*,DATE_FORMAT(sp.indent_date,'%d/%m/%Y') as realdate
	from indent sp LEFT JOIN(plant p)
	ON sp.plant_id=p.plant_id 
	where indent_id=?
	<sql:param value="${param.indent_id}"/>
</sql:query>

<c:forEach var="po" items="${po.rows}">
	<c:set value="${po}" var="rs"/>
</c:forEach>
<body>
	<div class="container">
			<div class="row">
				<table class="table table-condensed">
				
				
				<tr>
					<td class="text-center" colspan="6" style="border:1px solid black;">
					<h3><b>PURCHASE INDENT FORM</b></h3>
							<div class="col-xs-2">
								<img src="image/bcplogo.jpg"  width="250" height="100">
							</div>
							<div class="col-xs-8" >
								<h3 style="margin-top:20px;margin-bottom: 0px;"><strong>BHARATH CEMENT PRODUCTS</strong></h3>
							
								    <p>150A, Bommasandra Industrial Area, Bangalore - 560 099</p>
							</div>
					
							<div  class="col-xs-12 text-left">
								<span style="font-size:17px;">Indent Date : </span>${rs.indent_date}<br>
								<span style="font-size:17px;">Name of the Indentor With Designation :</span> ${rs.indentor} ( ${rs.designation} )<br>
								<span style="font-size:17px;">Type: </span>${rs.type}<br>
								<span style="font-size:17px;">Budget Head: </span>${rs.budget_head}<br>
								<span style="font-size:17px;">Financial Year: </span>${rs.start_year}- ${rs.end_year}<br>
 							</div>
						
					</td>
				</tr>
				
				
					<tr class="text-center">
						<td class="col-xs-2">
							S/L No
						</td>
						<td colspan="2">
							Details of Items with all Specification
						</td>
						
						
						<td>
							Quantity Reqd.
						</td>
						
						<td>
							Approx Unit Rate(Rs.)
						</td>
						<td class="text-right">
							Total Cost(Rs.)
						</td>
					</tr>
					<!-- GET ALL ITEMS DETAILS -->
					<sql:query var="poi" dataSource="jdbc/rmc">
						select * from indent_item where indent_id=?
						<sql:param value="${rs.indent_id}"/>
					</sql:query>
					<c:set value="0" var="count"/>
					<c:set value="0" var="total_cost"/>
					
					
					<c:forEach items="${poi.rows}" var="poi">
					<c:set value="${count+1}" var="count"/>
					<c:set value="${total_cost+(poi.quantity*poi.unit_price)}" var="total_cost"/>
					<tr class="text-center">
						<td class="col-xs-2">
							${count}
						</td>
						<td colspan="2">
							<h4>${poi.product_number}</h4>
							${poi.description1}

						</td>
						<td>
							${poi.quantity}
						</td>
						<td>
							<fmt:formatNumber value="${poi.unit_price}" maxFractionDigits="2" minFractionDigits="2" groupingUsed="true"/>
						</td>
						<td class="text-right">
							<fmt:formatNumber value="${poi.quantity*poi.unit_price}" maxFractionDigits="2" minFractionDigits="2" groupingUsed="true"/>
						</td>
					</tr>	
					</c:forEach>
					<tr class="text-center">
						<td colspan="3" class="text-left"><b></b></td>
						<td colspan="2">Total Value(Rs.)</td>
						<td class="text-right"><fmt:formatNumber value="${total_cost}" maxFractionDigits="2" minFractionDigits="2" groupingUsed="true"/></td>
					</tr>
					
					<tr>
						<td colspan="6">
							<input type="hidden" name="net_amt" id="net_amt" value="${total_net}"/>
							<b>Amount In Word : </b><span class="in-word"></span>
						</td>
					</tr>
					<tr>
						<td colspan="6">
							<b>Justification :</b><br>
							${rs.justification} 
						</td>
						
					</tr>
					<tr>
						<td colspan="2"  class="text-center" >
							<h4>Prepared by</h4><br><br>
							${rs.indentor}
						</td>
						<td colspan="2" class="text-center" >
							<h4>Checked by</h4><br><br>
							${rs.checked_by}
						</td>
						<td colspan="3" class="text-center">
							<h4><b>Approved by</b></h4><br><br>
							${rs.approved_by}
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
  
  <script>
  	$(document).ready(function(){
  		var net_amt=$('#net_amt').val();
  		net_amt=parseInt(net_amt);
  		var word=inWords(net_amt);
  		$('.in-word').text(word);
  	});
  </script>
</body>
</html>