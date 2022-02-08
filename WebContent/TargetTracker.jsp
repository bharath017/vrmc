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
                                    <li class="breadcrumb-item"><a href="#">Reports</a></li>
                                    <li class="breadcrumb-item active">Target Tracker</li>
                                </ol>
                            </div>
                            <h4 class="page-title">Target Tracker</h4>
                        </div>
                    </div>
                </div>
                <!-- end page title end breadcrumb -->






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
                               <a class="btn btn-danger btn-lg" href="TargetTracker.jsp">Clear Report</a>
                          </div>
                       </form>
                    </div>
                </div>
                 <c:if test="${param.action=='generateReport'}">
               	<div class="row" style="margin-top: 25px;">
               		<div class="col-sm-12">
               			<button class="btn btn-warning btn-sm" onclick="generate_excel();">Excel</button>
               			<button class="btn btn-danger btn-sm" onclick="print();">Print</button>
               		</div>
               		<div class="col-sm-12 text-center">
               		  <c:set var = "now" value = "<%= new java.util.Date()%>" />
               		   <c:set var = "month" value = "${param.month}" />
               		   <c:set var = "conver" value = "20-${param.month}-${param.year}" />
               		   <fmt:parseDate value = "${conver}" var = "parsed" pattern = "dd-MM-yyyy" />
				<h4 style="color: red;" class="text-center">MONTH : <fmt:formatDate type = "date" dateStyle = "long"  pattern="MMMMMMMMMM"  value="${parsed}" />
        &nbsp;&nbsp;&nbsp;&nbsp;YEAR : ${param.year}  
        &nbsp;&nbsp;&nbsp;&nbsp;  DATE:<fmt:formatDate pattern = "dd-MM-yyyy"  value = "${now}" /></h4>
               		</div>
               		<input type="hidden" id="month1" value="${param.month}"/>
               		<input  type="hidden" id="year1" value="${param.year}"/>
               		<div class="col-sm-12 printme table-responsive" id="printme">
               		<sql:query var="po" dataSource="jdbc/rmc">
									select sum(fi.monthly_forecast) as quantity,(select sum(quantity) from invoice where plant_id=f.plant_id and month(invoice_date)=? and year(invoice_date)=?) as supplied,
									(select plant_name from plant where plant_id=f.plant_id) as plant_name
									 from forecast_item fi left join forecast f on f.forecast_id=fi.forecast_id where  month(fi.forecast_date)=? and year(fi.forecast_date)=? group by f.plant_id
								<sql:param value="${param.month}"/>
               					<sql:param value="${param.year}"/>
               					<sql:param value="${param.month}"/>
               					<sql:param value="${param.year}"/>
						</sql:query>
                            <table class="table table-bordered" id="example-2">
                                <thead>
	                                <tr style="background-color: white;">
	                                <th class="text-center">Plant</th>
										<th class="center">
										Forecast as per BDM
										</th>
										<th class="text-center">Quantity Required Per Day</th>
										<th class="text-center past_days">Past Days</th>
										<th class="text-center remaining_days">Remaining Days</th>
										<th class="text-center">Quantity Supplied</th>
										<th class="text-center">Avg Vol/Day</th>
										<th class="text-center">Expected vol based on Avg vol</th>
										<th class="text-center">Req Vol to Achieve per day</th>
										<th class="text-center">Variance</th>
									</tr>
                                </thead>
                                <tbody>
                                <c:forEach var="po" items="${po.rows}">
									<tr class="${(po.status=='cancelled')?'text-danger':''}">
									<td class="text-center" style="background-color: white;">
											${(empty po.plant_name)?'All Plant':po.plant_name}
										</td>
										<td class="forecast">${po.quantity}</td>
										<td class="monthly_req"></td>
										<td class="past"></td>
										<td class="remaining"></td>
										<td class="text-center supplied_quantity">
											  ${po.supplied}
										</td>
										<td class="average"></td>
										<td class="expected"></td>
										<td class="vol_req"></td>
										<td class="variance">%</td>
									</tr>
									</c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    </c:if>
            </div> <!-- end container -->
        </div>
        <!-- end wrapper -->


        <!-- Footer -->
        <!-- PUT FOOTER.JSP HERE -->
        <%@ include file="footer.jsp" %>
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

    <script type="text/javascript">
	    $(document).ready(function(){
	    	$('.forecast').each(function(){
	    		var fore=$(this).html();
	    		var month=$('#month1').val();
	    		var year=$('#year1').val();
	    		var d= new Date();
	    		var curmonth=d.getMonth()+1;
	    		if(month==curmonth && year==d.getFullYear()){
	    			var ans=new Date(d.getFullYear(), d.getMonth()+1, 0).getDate();
		    		 var monthly=parseFloat(fore/ans).toFixed(2);
		    		 $(this).closest("tr").find('td.monthly_req').text(monthly);
		    		var remaining=ans-d.getDate();
		    		var past_days=d.getDate()-1;
		    		 $(this).closest("tr").find('td.past').text(past_days);
		    		 $(this).closest("tr").find('td.remaining').text(remaining+1);
		    		 var supplied=$(this).closest("tr").find('td.supplied_quantity').html();
		    		supplied=(parseFloat(supplied));
		    		 var average=parseFloat(supplied/(past_days));
		    		 $(this).closest("tr").find('td.average').text(average.toFixed(2));
		    		 $(this).closest("tr").find('td.expected').text((average*(remaining+1)).toFixed(2));
		    		$(this).closest("tr").find('td.vol_req').text(((fore-supplied)/(remaining+1)).toFixed(2));
		    		$(this).closest("tr").find('td.variance').text( ((supplied-(monthly*past_days)).toFixed(2))+'('+((((supplied-(monthly*past_days))/(monthly*past_days))*100).toFixed(2))+'%)');
	    		}else{
	    			var ans=new Date(year, month, 0).getDate();
		    		 var monthly=parseFloat(fore/ans).toFixed(2);
		    		 $(this).closest("tr").find('td.monthly_req').text(monthly);
		    		var remaining=0;
		    		var past_days=ans;
		    		 $(this).closest("tr").find('td.past').text(past_days);
		    		 $(this).closest("tr").find('td.remaining').text(remaining);
		    		 var supplied=$(this).closest("tr").find('td.supplied_quantity').html();
		    		 supplied=(parseFloat(supplied));
		    		 var average=parseFloat(supplied/(past_days));
		    		 console.log(average);
		    		 $(this).closest("tr").find('td.average').text(average.toFixed(2));
		    		 $(this).closest("tr").find('td.expected').text('Closed');
		    		$(this).closest("tr").find('td.vol_req').text('Closed');
		    		$(this).closest("tr").find('td.vol_req').text('Closed');
		    		var variance=parseFloat((supplied-(monthly*past_days))).toFixed(2);
		    		console.log(variance);
		    		$(this).closest("tr").find('td.variance').text(((supplied-(monthly*past_days)).toFixed(2))+'('+((((supplied-(monthly*past_days))/(monthly*past_days))*100).toFixed(2))+'%)');
	    		}
	    		 
	    		
	    		
	    	});
	    });
    </script>

	<script type="text/javascript">
			$(document).ready(function(){
				 $('.select2').css('width','100%').select2({allowClear:true})
					.on('change', function(){
					}); 
				
				 var today = new Date().toISOString().split('T')[0];
				 $('#present_date').text(today);
			});
		</script>

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
        	window.location="TargetTracker.jsp?action=generateReport&month="+from_date+"&year="+to_date;
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

	


    </body>
</html>