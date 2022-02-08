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
		
	</style>
</head>

<sql:query var="po" dataSource="jdbc/rmc">
	select sp.*,p.*,s.*,DATE_FORMAT(sp.purchase_order_date,'%d/%m/%Y') as realdate
	from supplier_purchase_order sp LEFT JOIN(supplier s,plant p)
	ON sp.plant_id=p.plant_id 
	and sp.supplier_id=s.supplier_id 
	where supplier_purchase_order_id=?
	<sql:param value="${param.supplier_purchase_order_id}"/>
</sql:query>

<c:forEach var="po" items="${po.rows}">
	<c:set value="${po}" var="rs"/>
</c:forEach>
<body>
	<div class="container">
			<div class="row">
				<table class="table table-condensed">
					<tr>
						<td class="col-xs-6 text-left" colspan="3" style="border-top: 1px solid black;">
							<h3><b>PRAGATHI CONCRETES AND CONSTRUCTIONS</b></h3>
							<div class="col-xs-7 nopadding">
								<p>Regd Off: ${rs.plant_address}
							</p>
							<p>
								Ph: ${rs.plant_phones}, (E) ${rs.plant_email}<br>
								CIN: ${rs.plant_cst}<br>
								PAN NO.: ${rs.plant_panno}<br>
								GST No: ${rs.plant_gstin}
							</p>
							</div>
						</td>
						<td class="col-xs-6 text-center align-middle" colspan="3" style="border-top: 1px solid black;">
								<img src="leoformat/LEO.png" class="align-middle" style="margin-top: 10%;">									
						</td>
					</tr>
					<tr>
						<td colspan="6" class="text-center">
							<h4><b>PURCHASE ORDER</b></h4>
						</td>	
					</tr>
					<tr>
						<td colspan="3">To, (Vendor)</td>
						<td colspan="3">PO Date : ${rs.realdate}</td>
					</tr>
					<tr>
						<td colspan="3" rowspan="3">
							<h4><b>${rs.supplier_name}</b></h4>
							<p>${rs.supplier_address}</p>
						</td>
						<td colspan="3">
							PO No : ${rs.supplier_purchase_order_id}
						</td>
					</tr>
					<tr>
						<td colspan="3">Validity Of PO : ${rs.order_validity}</td>
					</tr>
					<tr>
						<td colspan="3">Quotation/Offer No : ${rs.quotation_no}</td>
					</tr>
					<tr>
						<td colspan="3" rowspan="2">
							<h4>Kind Attn : ${rs.receiver_name}</h4>
							<p>Email : ${rs.receiver_email} &nbsp;&nbsp;&nbsp;&nbsp; Phone : ${rs.receiver_phone}</p>
						</td>
						<td colspan="3">
							Vendor GST No : ${rs.supplier_gstin}
						</td>
					</tr>
					<tr>
						<td colspan="3">
							Vendor PAN No : ${rs.supplier_panno}
						</td>
					</tr>
					<tr class="text-center">
						<td class="col-xs-2">
							S/L No
						</td>
						<td colspan="2">
							Perticulars
						</td>
						<td>
							Quantity(MT)
						</td>
						<td>
							Unit Rate(Rs.)
						</td>
						<td class="text-right">
							Amount(Rs.)
						</td>
					</tr>
					<!-- GET ALL ITEMS DETAILS -->
					<sql:query var="poi" dataSource="jdbc/rmc">
						select * from supplier_purchase_order_item where supplier_purchase_order_id=?
						<sql:param value="${rs.supplier_purchase_order_id}"/>
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
						<td colspan="3" class="text-left"><b>Delivery Site</b></td>
						<td colspan="2">Total Value(Rs.)</td>
						<td class="text-right"><fmt:formatNumber value="${total_cost}" maxFractionDigits="2" minFractionDigits="2" groupingUsed="true"/></td>
					</tr>
					<tr>
						<td colspan="3" rowspan="4">
							<h4><b>LEO CONTECH PVT LTD.</b></h4>
							<p>Regd Off: ${rs.plant_address}
							</p>
						</td>
						<td colspan="2">
							<span class="text-uppercase">${rs.gst_type}</span> @ ${rs.gst_percentage}%
						</td>
						<!-- Calculate Gst here -->
						<fmt:formatNumber value="${(total_cost/100)*rs.gst_percentage}" var="total_tax" groupingUsed="false"/>
						
						<td class="text-right">
							<fmt:formatNumber value="${total_tax}" maxFractionDigits="2" minFractionDigits="2" groupingUsed="true"/>
						</td>
					</tr>
					<tr>
						<td colspan="2">CGST ${(rs.gst_type=='gst')?rs.gst_percentage/2:0}%</td>
						<td class="text-right">
							<c:if test="${rs.gst_type=='gst'}">
								<fmt:formatNumber value="${(total_tax)/2}" maxFractionDigits="2" minFractionDigits="2" groupingUsed="true"/>
							</c:if>
						</td>
					</tr>
					<tr>
						<td colspan="2">SGST ${(rs.gst_type=='gst')?rs.gst_percentage/2:0}%</td>
						<td class="text-right">
							<c:if test="${rs.gst_type=='gst'}">
								<fmt:formatNumber value="${(total_tax)/2}" maxFractionDigits="2" minFractionDigits="2" groupingUsed="true"/>
							</c:if>
						</td>
					</tr>
					<tr>
						<td colspan="2">Round Off</td>
						<td class="text-right"></td>
					</tr>
					<tr>
						<td colspan="3">
							<b>Contact Person : </b>Mr. Devendra Reddy<br>
						<b>Phone: </b>99900051224 <b>(E) : </b>devendra.reddy@leoinfra.in
						</td>
						<td colspan="2">
							<b>Total (Rs)</b>
						</td>
						<td class="text-right"><fmt:formatNumber value="${total_cost+total_tax}" maxFractionDigits="2" minFractionDigits="2" groupingUsed="true"/></td>
					</tr>
					<fmt:formatNumber value="${total_cost+total_tax}" var="total_net" groupingUsed="false" maxFractionDigits="2"/>
					<tr>
						<td colspan="6">
							<input type="hidden" name="net_amt" id="net_amt" value="${total_net}"/>
							<b>Amount In Word : </b><span class="in-word"></span>
						</td>
					</tr>
					<tr>
						<td colspan="3">
							<b>Payment Terms :</b><br>
							${rs.payment_term} Days against Supply of Material on Plant
						</td>
						<td colspan="3">
							<b>Delivery Period : Immediate</b><br>
							<b>Mode of Transport : Road</b>
						</td>
					</tr>
					<tr>
						<td colspan="3">
							<b>Other Terms : </b><br>
							${rs.terms}
						</td>
						<td colspan="3" class="text-center">
							<h3><b>For LEO CONTECH PVT LTD.</b></h3><br><br><br><br><br>
							Authorized Signatory
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