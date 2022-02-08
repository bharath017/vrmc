<%@ include file="Session.jsp" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
        <meta charset="utf-8" />
        <title>Sales Order List</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
        <meta content="A fully featured admin theme which can be used to build CRM, CMS, etc." name="description" />
        <meta content="Coderthemes" name="author" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />

        <!-- App favicon -->
        <link rel="shortcut icon" href="assets/images/favicon.ico">

        <!-- DataTables -->
        <link href="plugins/datatables/dataTables.bootstrap4.min.css" rel="stylesheet" type="text/css" />
        <link href="plugins/datatables/buttons.bootstrap4.min.css" rel="stylesheet" type="text/css" />
        <!-- Responsive datatable examples -->
        <link href="plugins/datatables/responsive.bootstrap4.min.css" rel="stylesheet" type="text/css" />

        <!-- Multi Item Selection examples -->
        <link href="plugins/datatables/select.bootstrap4.min.css" rel="stylesheet" type="text/css" />

        <!-- App css -->
        <link href="assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/icons.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/style.css" rel="stylesheet" type="text/css" />
		  <!-- Custom box css -->
        <link href="plugins/custombox/css/custombox.min.css" rel="stylesheet">
        <link rel="stylesheet" href="assets/css/select2.min.css" />
		<link rel="stylesheet" href="assets/css/render.css">
        <script src="assets/js/modernizr.min.js"></script>
        <style type="text/css">
        	.hidden{
        		display: none;
        	}
        </style>
        
    </head>

    <body>

        <!-- Navigation Bar-->
        <!-- PUT HEADER.JSP HERE -->
       <%@ include file="header.jsp" %>
        <!-- End Navigation Bar-->


        <div class="wrapper">
            <div class="container-fluid">

                <!-- Page-Title -->
                <div class="row">
                    <div class="col-sm-12">
                        <div class="page-title-box">
                            <div class="btn-group pull-right">
                                <ol class="breadcrumb hide-phone p-0 m-0">
                                    <li class="breadcrumb-item"><a href="#">Home</a></li>
                                    <li class="breadcrumb-item"><a href="#">Customer &amp; PO</a></li>
                                    <li class="breadcrumb-item active">Sales Order</li>
                                    <li class="breadcrumb-item active">Sales Order List</li>
                                </ol>
                            </div>
                            <h4 class="page-title">Booked and scheduled</h4>
                        </div>
                    </div>
                </div>
                <!-- end page title end breadcrumb -->

               <!--  <div class="row">
                    <div class="col-sm-4">
                        <a href="AddPurchaseOrder.jsp" class="btn btn-custom waves-effect waves-light mb-4"  data-overlayColor="#36404a"><i class="mdi mdi-plus"></i> Add Sales Order</a>
                    </div>end col
                </div> -->
                <!-- end row -->
			
			
			
			
			
			
			
			
			
			       <div class="row">
                	<div class="col-md-12">
                		<h2 class="text-info text-center">Production Report</h2><hr>
                	</div>
                    <div class="col-md-12">
                       <form action="#" id="myform" method="post">
                          <div class="row">
                          	<div class="col-sm-3"></div>
                          	<div class="col-sm-6">
                                <div class="col-sm-12">
                                  <div class="form-group no-custom">
				                             <label>Month :  <span class="text-danger">*</span> </label>
		       									<select id="month"  name="month" required="required"   class="select2 no-custom"  data-placeholder="Choose Month">
												<option value=""></option>
												<option value="1">JAN</option>
												<option value="2">FEB</option>
												<option value="3">MAR</option>
												<option value="4">APR</option>
												<option value="5">MAY</option>
												<option value="6">JUNE</option>
												<option value="7">JULY</option>
												<option value="8">AUG</option>
												<option value="9">SEP</option>
												<option value="10">OCT</option>
												<option value="11">NOV</option>
												<option value="12">DEC</option>
										  </select>
									</div>
                                </div>
                               
                                <div class="col-sm-12 ">
                                  	 <div class="form-group no-custom">
			                             <label>Year :  <span class="text-danger">*</span> </label>
	       								<select id="year"  name="year" required="required"   class="select2 no-custom"  data-placeholder="Choose Year">
											<option value=""></option>
											<option value="2017">2017</option>
											<option value="2018">2018</option>
											<option value="2019">2019</option>
											<option value="2020">2020</option>
											<option value="2021">2021</option>
											<option value="2022">2022</option>
											<option value="2023">2023</option>
											<option value="2024">2024</option>
											<option value="2025">2025</option>
									  </select>
								</div>
                                </div>
                          	</div> 	
                          </div>
                           
                            <div class="text-center m-t-20">
                               <button type="submit" class="btn btn-primary btn-lg m-r-10 save-button">Generate Report</button>
                               <a class="btn btn-danger btn-lg" href="BookedVsScheduled.jsp">Clear Report</a>
                          </div>
                       </form>
                    </div>
                </div>
			



<c:catch var="e">
                 <c:if test="${param.action=='generateReport'}">
               	<div class="row" style="margin-top: 25px;">
               		<div class="col-sm-12">
               			<button class="btn btn-warning btn-sm" onclick="generate_excel();">Excel</button>
               			<button class="btn btn-danger btn-sm" onclick="print();">Print</button>
               		</div>
               		<div class="col-sm-12 text-center">
               		  <c:set var = "now" value = "<%= new java.util.Date()%>" />
               		  <c:set var = "month" value = "${param.month}" />
               		  <!-- formatting selected month and year to date format -->
               		  <c:set var = "conver" value = "20-${param.month}-${param.year}" />
               		  <!-- Parsing the obtained string date format -->
               		   <fmt:parseDate value = "${conver}" var = "parsed" pattern = "dd-MM-yyyy" />
               		   <!-- value takes only parsed data -->
				<h4 style="color: red;" class="text-center">MONTH : <fmt:formatDate type = "date" dateStyle = "long"  pattern="MMMMMMMMMM"  value="${parsed}" />
        &nbsp;&nbsp;&nbsp;&nbsp;YEAR : ${param.year}  
        &nbsp;&nbsp;&nbsp;&nbsp;  DATE:<fmt:formatDate pattern = "dd-MM-yyyy"  value = "${now}" /></h4>
               		</div>
               		<div class="col-sm-12 printme table-responsive" id="printme">
               			<!-- Get all kind of query here -->
               			<sql:query var="po" dataSource="jdbc/rmc">
								select w.* from(select c.customer_name,s.site_name,p.project_quantity,
				                (select plant_name from plant where plant_id=p.plant_id) as plant_name,p.plant_id,p.site_id,c.customer_id,m.mp_name,
				                (select sum(i.quantity)from invoice i where day(i.invoice_date) between 1 and 10 and month(invoice_date)=? and year(invoice_date)=? and p.customer_id=i.customer_id and p.site_id=i.site_id  and p.plant_id=i.plant_id group by i.plant_id)as  week1_supplied,
				                (select sum(i.quantity)from invoice i where day(i.invoice_date) between 11 and 17 and month(invoice_date)=? and year(invoice_date)=? and p.customer_id=i.customer_id and p.site_id=i.site_id  and p.plant_id=i.plant_id group by i.plant_id)as  week2_supplied,
				                (select sum(i.quantity)from invoice i where day(i.invoice_date) between 18 and 25 and month(invoice_date)=? and year(invoice_date)=?  and p.customer_id=i.customer_id and p.site_id=i.site_id  and p.plant_id=i.plant_id group by i.plant_id)as  week3_supplied,
				                (select sum(i.quantity)from invoice i where day(i.invoice_date) between 26 and 31 and month(invoice_date)=? and year(invoice_date)=? and p.customer_id=i.customer_id and p.site_id=i.site_id and p.plant_id=i.plant_id group by i.plant_id)as  week4_supplied,
                				fi.week1_forecast,fi.week2_forecast,fi.week3_forecast,fi.week4_forecast,fi.monthly_forecast,fi.average_c1
				                from forecast_item fi LEFT JOIN (customer c,site_detail s,marketing_person m,forecast p) ON fi.forecast_id=p.forecast_id and p.customer_id=c.customer_id and p.site_id=s.site_id and p.mp_id=m.mp_id where month(fi.forecast_date)=? and year(fi.forecast_date)=?
				                 group by p.forecast_id order by p.plant_id desc) as w
				               <c:forEach var="i" begin="1" end="5">  
								<sql:param value="${param.month}"/>
               					<sql:param value="${param.year}"/>
               					</c:forEach>
								</sql:query>
               			<table class="table table-bordered" id="example-2">
               				<tr style="background-color: #741d7a;color: white;" class="text-center">
               					<%-- <td colspan="10" class="text-center">
               						<h4>Production Report</h4>
               						<fmt:parseDate value="${param.from_date}" pattern="yyyy-MM-dd" var="from_date"/>
               						<fmt:parseDate value="${param.to_date}" pattern="yyyy-MM-dd" var="to_date"/>
               						From Date : <fmt:formatDate value="${from_date}" pattern="dd/MM/yyyy"/>
               						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;To Date : <fmt:formatDate value="${to_date}" pattern="dd/MM/yyyy"/>
               					</td> --%>
               				</tr>
               				<thead>
               				<tr style="background-color: #4b9663;color: white;">
               					<th class="text-center">Plant</th>
									<th class="text-center">
										Customer
									</th>
									<th class="text-center">Sales group</th>
									<th class="text-center">Site Name</th>
									<th class="text-center">Project Quantity</th>
									<th class="text-center">Forecast Quantity</th>
									<th class="text-center">Expected Average C1</th>
									<th  class="text-center">Week 1(1-10)
									<table class="table table-bordered text-center" style="color:black">
										<tr class="table-center">
											<td>Week 1 Forecast</td>
											<td>Quantity Supplied</td>
										</tr>
									</table>
									</th>
									
									<th  class="text-center">Week 2(11-17)
									<table class="table table-bordered text-center" style="color:black">
										<tr class="table-center">
											<td>Week 2 Forecast</td>
											<td>Quantity Supplied</td>
										</tr>
									</table>
									</th>
									<th  class="text-center">Week 3(18-25)
									<table class="table table-bordered text-center" style="color:black">
										<tr class="table-center">
											<td>Week 3 Forecast</td>
											<td>Quantity Supplied</td>
										</tr>
									</table>
									</th>
									<th  class="text-center">Week 4(25-31)
									<table class="table table-bordered text-center" style="color:black">
										<tr class="table-center">
											<td>Week 4 Forecast</td>
											<td>Quantity Supplied</td>
										</tr>
									</table>
									</th>
									<th class="text-center">MTD Quantity</th>
               				</tr>
               				</thead>
               				 <tbody>
                                <c:set var="total_quantity" value='0'/>
                                <c:set var="total_quantity1" value='0'/>
                                 <c:set var="average_c1" value='0'/>
                                 <c:set var="total_mtq" value='0'/>
                                 <c:set var="week1_total" value='0'/>
                               <c:set var="week2_total" value='0'/>
                               <c:set var="week3_total" value='0'/>
                               <c:set var="week4_total" value='0'/>
                               <c:set var="week1_total_sup" value='0'/>
                               <c:set var="week2_total_sup" value='0'/>
                               <c:set var="week3_total_sup" value='0'/>
                               <c:set var="week4_total_sup" value='0'/>
                               <c:set var="count" value="0"/>
                                <c:forEach var="po" items="${po.rows}">
                                <c:set var="count" value='${count+1}'/>
                               <c:set var="week1_supplied" value='${(empty po.week1_supplied)?0:po.week1_supplied}'/>
                               <c:set var="week2_supplied" value='${(empty po.week2_supplied)?0:po.week2_supplied}'/>
                               <c:set var="week3_supplied" value='${(empty po.week3_supplied)?0:po.week3_supplied}'/>
                               <c:set var="week4_supplied" value='${(empty po.week4_supplied)?0:po.week4_supplied}'/>
                               <c:set var="week1_forecast" value='${(empty po.week1_forecast)?0:po.week1_forecast}'/>
                               <c:set var="week2_forecast" value='${(empty po.week2_forecast)?0:po.week2_forecast}'/>
                               <c:set var="week3_forecast" value='${(empty po.week3_forecast)?0:po.week3_forecast}'/>
                               <c:set var="week4_forecast" value='${(empty po.week4_forecast)?0:po.week4_forecast}'/>
                               
                               
                               <c:set var="total_quantity1" value='${week1_supplied+week2_supplied+week3_supplied+week4_supplied}'/>
                                 <c:set var="total_mtq" value='${total_mtq+total_quantity1}'/>
                                 	<c:set var="week1_total" value='${week1_total+week1_forecast}'/>
                                 	<c:set var="week2_total" value='${week2_total+week2_forecast}'/>
                                 	<c:set var="week3_total" value='${week3_total+week3_forecast}'/>
                                 	<c:set var="week4_total" value='${week4_total+week4_forecast}'/>
                                 	<c:set var="week1_total_sup" value='${week1_total_sup+week1_supplied}'/>
                                 	<c:set var="week2_total_sup" value='${week2_total_sup+week2_supplied}'/>
                                 	<c:set var="week3_total_sup" value='${week3_total_sup+week3_supplied}'/>
                                 	<c:set var="week4_total_sup" value='${week4_total_sup+week4_supplied}'/>
									<tr>
									<td class="text-center">
											${(empty po.plant_name)?'All Plant':po.plant_name}
										</td>
										<td class="text-center">${po.customer_name}</td>
										<td class="text-center">${po.mp_name}</td>
										<td class="text-center">${po.site_name}</td>
										<td class="text-center">${po.project_quantity}</td>
										<td class="text-center">
											  <c:set var="total_quantity" value="${po.monthly_forecast+total_quantity}"/>
											  <c:set var="average_c1" value="${po.average_c1+average_c1}"/>
											${po.monthly_forecast}
										</td>
										<td>${po.average_c1}</td>
										<td>
										<table class="table table-striped table-bordered text-center">
										<tr class="table-center">
											<td>${week1_forecast}</td>
											<td>${week1_supplied}</td>
										</tr>
									</table>
										</td>
										<td>
										<table class="table table-striped table-bordered text-center">
										<tr class="table-center">
											<td>${week2_forecast}</td>
											<td>${week2_supplied}</td>
										</tr>
									</table>
										</td>
										<td>
										<table class="table table-striped table-bordered text-center">
										<tr class="table-center">
											<td>${week3_forecast}</td>
											<td>${week3_supplied}</td>
										</tr>
									</table>
										</td>
										<td width="10%">
										<table class="table table-striped table-bordered text-center">
										<tr class="table-center">
											<td>${week4_forecast}</td>
											<td>${week4_supplied}</td>
										</tr>
									</table>
										</td>
										<td>${total_quantity1}</td>
									</tr>
									</c:forEach>
                                </tbody>
               					 <tfoot>
                                <tr style="background-color: grey">
                                <td colspan='5' class="text-right">Total Forecast Quantity :</td>
                                <td class="text-center">${total_quantity}</td>
                                <td>${average_c1/count}</td>
                                 <td><table class="table table-striped table-bordered text-center">
										<tr class="table-center">
											<td>${week1_total}</td>
											<td>${week1_total_sup}</td>
										</tr>
									</table></td>
                                 <td><table class="table table-striped table-bordered text-center">
										<tr class="table-center">
											<td>${week2_total}</td>
											<td>${week2_total_sup}</td>
										</tr>
									</table></td>
                                 <td><table class="table table-striped table-bordered text-center">
										<tr class="table-center">
											<td>${week3_total}</td>
											<td>${week3_total_sup}</td>
										</tr>
									</table></td>
                                 <td><table class="table table-striped table-bordered text-center">
										<tr class="table-center">
											<td>${week4_total}</td>
											<td>${week4_total_sup}</td>
										</tr>
									</table></td>
                                 <td class="text-center">${total_mtq}</td>
                                </tr>
                                </tfoot>
               			</table>
               		</div>
               	</div>
               </c:if>
              

            </div> <!-- end container -->
        </div>
        <!-- end wrapper -->
</c:catch>
${e}

        <!-- Footer -->
        <!-- PUT FOOTER.JSP HERE -->
 <!--       <%@ include file="footer.jsp" %>  -->
        <!-- End Footer -->


        <!-- jQuery  -->
        <script src="assets/js/jquery.min.js"></script>
        <script src="assets/js/popper.min.js"></script>
        <script src="assets/js/bootstrap.min.js"></script>
        <script src="assets/js/waves.js"></script>
        <script src="assets/js/jquery.slimscroll.js"></script>

        <!-- Required datatable js -->
        <script src="plugins/datatables/jquery.dataTables.min.js"></script>
        <script src="plugins/datatables/dataTables.bootstrap4.min.js"></script>
        <!-- Buttons examples -->
        <script src="plugins/datatables/dataTables.buttons.min.js"></script>
        <script src="plugins/datatables/buttons.bootstrap4.min.js"></script>
        <script src="plugins/datatables/pdfmake.min.js"></script>
        <script src="plugins/datatables/vfs_fonts.js"></script>
        <script src="plugins/datatables/buttons.html5.min.js"></script>
        <script src="plugins/datatables/buttons.print.min.js"></script>
        <script src="assets/js/select2.min.js"></script>
        <script src="picker/js/moment.min.js"></script>

        <!-- Key Tables -->
        <script src="plugins/datatables/dataTables.keyTable.min.js"></script>

        <!-- Responsive examples -->
        <script src="plugins/datatables/dataTables.responsive.min.js"></script>
        <script src="plugins/datatables/responsive.bootstrap4.min.js"></script>

        <!-- Selection table -->
        <script src="plugins/datatables/dataTables.select.min.js"></script>

        <!-- App js -->
        <script src="assets/js/jquery.core.js"></script>
        <script src="assets/js/jquery.app.js"></script>
	<script>
		function printDiv(divName) {
		     var printContents = document.getElementById(divName).innerHTML;
		     var originalContents = document.body.innerHTML;
		     document.body.innerHTML = printContents;
		     window.print();
		     document.body.innerHTML = originalContents;
		}
		
		</script>
		
		
		
	<script type="text/javascript">
	    $("form").submit(function(e){
	        e.preventDefault();
        	var from_date=$('#month').val();
        	var to_date=$('#year').val();
        	window.location="BookedVsScheduled.jsp?action=generateReport&month="+from_date+"&year="+to_date;
	    });
    </script>
		
		

   
		
		<script type="text/javascript">
			$(document).ready(function(){
				 $('.select2').css('width','100%').select2({allowClear:true})
					.on('change', function(){
					}); 
			});
		</script>


    

    
        <script type="text/javascript">
	    function generate_excel() {
	      var table= document.getElementById("example-2");
	      var html = table.outerHTML;
	      window.open('data:application/vnd.ms-excel;base64,' + base64_encode(html));
	    }
	    function base64_encode (data) {
	      // http://kevin.vanzonneveld.net
	      // +   original by: Tyler Akins (http://rumkin.com)
	      // +   improved by: Bayron Guevara
	      // +   improved by: Thunder.m
	      // +   improved by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
	      // +   bugfixed by: Pellentesque Malesuada
	      // +   improved by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
	      // +   improved by: Rafal Kukawski (http://kukawski.pl)
	      // *     example 1: base64_encode('Kevin van Zonneveld');
	      // *     returns 1: 'S2V2aW4gdmFuIFpvbm5ldmVsZA=='
	      // mozilla has this native
	      // - but breaks in 2.0.0.12!
	      //if (typeof this.window['btoa'] == 'function') {
	      //    return btoa(data);
	      //}
	      var b64 = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
	      var o1, o2, o3, h1, h2, h3, h4, bits, i = 0,
	        ac = 0,
	        enc = "",
	        tmp_arr = [];
	
	      if (!data) {
	        return data;
	      }
	
	      do { // pack three octets into four hexets
	        o1 = data.charCodeAt(i++);
	        o2 = data.charCodeAt(i++);
	        o3 = data.charCodeAt(i++);
	
	        bits = o1 << 16 | o2 << 8 | o3;
	
	        h1 = bits >> 18 & 0x3f;
	        h2 = bits >> 12 & 0x3f;
	        h3 = bits >> 6 & 0x3f;
	        h4 = bits & 0x3f;
	
	        // use hexets to index into b64, and append result to encoded string
	        tmp_arr[ac++] = b64.charAt(h1) + b64.charAt(h2) + b64.charAt(h3) + b64.charAt(h4);
	      } while (i < data.length);
	
	      enc = tmp_arr.join('');
	
	      var r = data.length % 3;
	
	      return (r ? enc.slice(0, r - 3) : enc) + '==='.slice(r || 3);
	
	    }
    </script>
    <script type="text/javascript">
    function print() {
        var frame = document.getElementsByClassName('printme').item(0);
        var data = frame.innerHTML;
        var win = window.open('', '', 'height=500,width=900');
        win.document.write('<style>@page{size:landscape;}@media print{*{font-size:12px;}}</style><html><head><title></title>');
        win.document.write('</head><body >');
        win.document.write(data);
        win.document.write('</body></html>');
        win.print();
        win.close();
        return true;
    }
    </script>


<%-- 	<td class="text-center">
											<sql:query var="poi" dataSource="jdbc/rmc">
												select i.*,sum(i.quantity) as iQuantity,p.product_name from invoice i,purchase_order_item poi,purchase_order po,product p where i.poi_id=poi.poi_id and poi.product_id=p.product_id and poi.order_id=po.order_id and i.plant_id=?
												<sql:param value="${po.plant_id}"/>
											</sql:query>
											<c:forEach var="poi" items="${poi.rows}">
											  <c:set var="total_quantity1" value="${poi.quantity+total_quantity1}"/>
											  ${poi.iQuantity}
											  </c:forEach>
										</td> --%>

    </body>
</html>