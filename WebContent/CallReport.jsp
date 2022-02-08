<!DOCTYPE html>
<%@ include file="Session.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>
<meta charset="utf-8" />
<title>Daily Call Report</title>
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<meta
	content="A fully featured admin theme which can be used to build CRM, CMS, etc."
	name="description" />
<meta content="Coderthemes" name="author" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />

<!-- App favicon -->
<link rel="shortcut icon" href="assets/images/favicon.ico">
<link rel="stylesheet" href="picker/cs/bootstrap-datepicker3.min.css" />
<link rel="stylesheet" href="picker/cs/bootstrap-timepicker.min.css" />
<!-- App css -->
<link href="assets/css/bootstrap.min.css" rel="stylesheet"
	type="text/css" />
<link href="assets/css/icons.css" rel="stylesheet" type="text/css" />
<link href="assets/css/style.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="assets/css/select2.min.css" />
<link rel="stylesheet" href="assets/css/render.css">

<link href="plugins/custombox/css/custombox.min.css" rel="stylesheet">

<style type="text/css">
.change {
	background-color: #469399;
	color: white;
}

.nochange {
	background-color: #d7dfe0;
}

.table>thead>tr>th,.table>tbody>tr>th,.table>tfoot>tr>th,.table>thead>tr>td,.table>tbody>tr>td,.table>tfoot>tr>td{
    padding: 2px;
 }
</style>

<script src="assets/js/modernizr.min.js"></script>

</head>

<body>

	<!-- Navigation Bar-->
	<%@ include file="header.jsp"%>
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
								<li class="breadcrumb-item"><a href="#">Billing</a></li>
								<li class="breadcrumb-item"><a href="#">Reports</a></li>
								<li class="breadcrumb-item"><a href="#">Call Report</a></li>
							</ol>
						</div>
						<h4 class="page-title">Invoice Report</h4>
					</div>
				</div>
			</div>
			<!-- end row -->
			<div class="row">
				<div class="col-md-12">
					<h2 class="text-info text-center">Generate Call Report</h2>
					<hr>
					<br>
					<br>
				</div>
				<div class="col-md-12">
					<form action="#" id="myform" method="post">
						<div class="row">
							<div class="col-sm-4"></div>
							<div class="col-sm-4">
								<div class="col-sm-12">
									<div class="form-group">
										<label>Report Type<span class="text-danger">*</span></label> <select
											class="select2" name="report_type" id="report_type"
											required="required">
											<option value="date"
												${(param.report_type=='date')?'selected':''}>Date
												Wise</option>
										</select>
									</div>
								</div>

								<div class="col-sm-12 no-cus no-veh cus-dat veh-dat date mar">
									<div class="form-group">
										<label>From Date<span class="text-danger">*</span></label>
										<div class="input-group">
											<input type="text" name="from_date"
												value="${param.from_date}"
												class="form-control date-picker no-cus no-veh cus-dat veh-dat date from_date mar"
												required="required" placeholder="dd/mm/yyyy"
												id="id-date-picker-1" data-date-format="dd/mm/yyyy"
												readonly="readonly" style="background-color: white;"/>
												<div class="input-group-append picker">
	                                               <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
	                                            </div>
										</div>
									</div>
								</div>

								<div
									class="col-sm-12 no-cus no-veh cus-dat veh-dat veh-dat date mar">
									<div class="form-group">
										<label>To Date<span class="text-danger">*</span></label>
										<div class="input-group">
											<input type="text" name="to_date" value="${param.to_date}"
												class="form-control date-picker no-cus no-veh cus-dat veh-dat date to_date mar"
												required="required" placeholder="dd/mm/yyyy"
												id="id-date-picker-1" data-date-format="dd/mm/yyyy"
												readonly="readonly" style="background-color: white;"/>
												<div class="input-group-append picker">
	                                               <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
	                                            </div>
										</div>
									</div>
								</div>


								<div class="col-sm-12">
									<div class="form-group">
										<label>Plant :</label>
										<sql:query var="plant" dataSource="jdbc/rmc">
                                       	select * from plant where plant_id like if(?=0,'%%',?)
                                       	<sql:param
												value="${bean.plant_id}" />
											<sql:param value="${bean.plant_id}" />
										</sql:query>
										<select class="select2" name="plant_id" id="plant_id">
											<c:if test="${bean.plant_id==0}">
												<option value="" selected="selected">All Plant</option>
											</c:if>
											<c:forEach items="${plant.rows}" var="plant">
												<option value="${plant.plant_id}"
													${(plant.plant_id==param.plant_id)?'selected':''}>${plant.plant_name}</option>
											</c:forEach>
										</select>
									</div>
								</div>

							</div>
						</div>

						<div class="text-center m-t-20">
							<button type="submit"
								class="btn btn-primary btn-lg m-r-10 save-button">Generate
								Report</button>
							<a class="btn btn-danger btn-lg" href="InvoiceReport.jsp">Clear
								Report</a>
						</div>
					</form>
				</div>
			</div>

			<c:if test="${param.action=='generateReport'}">
				<form action="InvoiceController?action=generatecons" method="post"
					class="form" id="myfrm"
					style="margin: 0 !important; padding: 0 !important;">
					<input type="hidden" value="${param.customer_id}"
						name="customer_id" /> <input type="hidden"
						value="${param.site_id}" name="site_id" /> <input type="hidden"
						value="${param.from_date}" name="from_date" /> <input
						type="hidden" value="${param.to_date}" name="to_date" /> <input
						type="hidden" name="pump_charge" id="pump_charge" /> <input
						type="hidden" name="advance_amount" id="advance_amount" /> <input
						type="hidden" name="plant_id" id="plnt_id" /> <input type="hidden"
						name="reference_no" id="ref_no" /> <input type="hidden"
						name="generate_date" id="gen_date" />
					<div class="row" style="margin-top: 25px;">
						<div class="col-sm-12">
							<button type="button" class="btn btn-warning btn-sm"
								onclick="fnExcelReport();">Excel</button>
							<button type="button" class="btn btn-danger btn-sm"
								onclick="print();">Print</button>
							<button type="button" class="btn btn-success btn-sm" id="tally">TALLY
								XML</button>
							<c:if
								test="${param.report_type=='date' || param.report_type=='customerdate'}">
								<a id="sales_document" class="btn btn-info btn-sm pull-right"
									style="display: none;" href="#amount-click"
									data-animation="blur" data-plugin="custommodal"
									data-overlaySpeed="100" data-overlayColor="#36404a">Generate
									Sales Document</a>
								<a id="consoldate_invoice"
									class="btn btn-info btn-sm pull-right" style="display: none;"
									href="#amount-click" data-animation="blur"
									data-plugin="custommodal" data-overlaySpeed="100"
									data-overlayColor="#36404a">Generate Consolidate Invoice</a>
							</c:if>
						</div>
						<div class="col-sm-12 printme table-responsive" id="printme">
							<!-- Get all kind of query here -->
							<c:if
								test="${param.report_type=='date' || param.report_type=='customerdate'}">
								<c:set
									value="${(empty param.plant_id || param.plant_id=='null')?'':param.plant_id}"
									var="plant_id" />
								<c:catch var="e">
									<sql:query var="inv" dataSource="jdbc/rmc">
               							select DISTINCT c.customer_name,c.customer_phone,
               							DATE_FORMAT(i.invoice_date,'%d/%m/%Y') as invoice_date,pr.product_name,
               							m.mp_name,sum(i.quantity) as tquantity
               						   	from invoice i LEFT JOIN (customer c,site_detail s,purchase_order_item poi,
               						   		product pr,plant p,purchase_order po,marketing_person m)
               							ON i.customer_id=c.customer_id
               							and i.site_id=s.site_id
               							and i.poi_id=poi.poi_id
               							and poi.order_id=poi.order_id
               							and poi.product_id=pr.product_id
               							and i.plant_id=p.plant_id
               							and poi.order_id=po.order_id
               							and po.marketing_person_id=m.mp_id
               							where i.invoice_date between STR_TO_DATE(?, '%d/%m/%Y') and STR_TO_DATE(?, '%d/%m/%Y')
               							and i.plant_id like if(''=?,'%%',?)
               							and c.business_id like if(0=?,'%%',?)
               							group by c.customer_name,c.customer_phone,i.invoice_date,pr.product_name,m.mp_name
               							<sql:param value="${param.from_date}" />
										<sql:param value="${param.to_date}" />
										<sql:param value="${plant_id}" />
										<sql:param value="${plant_id}" />
										<sql:param value="${bean.business_id}"/>
										<sql:param value="${bean.business_id}"/>
									</sql:query>
								</c:catch>
							</c:if>

							<table class="table table-bordered" id="example-2">
								<tr style="background-color: #741d7a; color: white;"
									class="text-center">

									<td colspan="9" class="text-center">
										<h3>CALL REPORT</h3>
									</td>

								</tr>
								<tr style="background-color: #4b9663; color: white;">
									<th>Sl. No.</th>
									<th>Date</th>
									<th>Customer Name</th>
									<th>Sales Person</th>
									<th>Customer Phone</th>
									<th>Grade</th>
									<th>Total Quantity</th>
									<th>Contact By</th>
									<th>Remark</th>
								</tr>

								<c:set value="0" var="count" />
								<c:forEach items="${inv.rows}" var="inv">
									<c:set value="${count+1}" var="count" />
									<tr>
										<td>${count}</td>
										<td>${inv.invoice_date}</td>
										<td>${inv.customer_name}</td>
										<td>${inv.mp_name}</td>
										<td>${inv.customer_phone}</td>
										<td>${inv.product_name}</td>
										<td>${inv.tquantity}</td>
										<td></td>
										<td></td>
									</tr>
								</c:forEach>
							</table>

						</div>
					</div>
				</form>
			</c:if>

			<!-- end row -->
		</div>
		<!-- end container -->
	</div>


	<!-- Modal for tally ladger save  -->
	<a class="dropdown-item" id="tally-click" style="display: none;"
		href="#tally_modal" data-animation="blur" data-plugin="custommodal"
		data-overlaySpeed="100" data-overlayColor="#36404a"><i
		class="fa fa-pencil mr-2 text-muted font-18 vertical-middle"></i>Change
		Docket No</a>
	<div id="tally_modal" class="modal-demo col-xs-2">
		<button type="button" class="close" onclick="Custombox.close();">
			<span>&times;</span><span class="sr-only">Close</span>
		</button>
		<h4 class="custom-modal-title text-uppercase"
			style="color: white; background-color: #28afa0;">
			<b>Update Tally Ledger</b>
		</h4>
		<div class="custom-modal-text">
			<form class="form-horizontal"
				action="InvoiceController?action=UpdateTallyLedger" method="post">
				<table class="table table-bordered" id="ledger">
					<thead>
						<tr style="background-color: #c100db; color: white;">
							<th>Customer</th>
							<th>Site Name</th>
							<th>Tally Ledger</th>
						</tr>
					</thead>
					<tbody>

					</tbody>
					<tfoot>
						<tr>
							<td colspan="3">
								<button
									class="btn w-lg btn-rounded btn-custom waves-effect waves-light"
									type="submit">SAVE TALLY LEDGER</button>
								<button
									class="btn w-lg btn-rounded btn-custom btn-danger waves-effect waves-light"
									onclick="Custombox.close();" type="button">CANCEL</button>
							</td>
						</tr>
					</tfoot>
				</table>

			</form>
		</div>
	</div>
	<!-- Modal ends here -->



	<!-- Footer -->
	<%@ include file="footer.jsp"%>
	<!-- End Footer -->


	<!-- jQuery  -->
	<script src="assets/js/jquery.min.js"></script>
	<script src="assets/js/popper.min.js"></script>
	<script src="assets/js/bootstrap.min.js"></script>
	<script src="assets/js/waves.js"></script>
	<script src="assets/js/jquery.slimscroll.js"></script>

	<!-- App js -->
	<script src="assets/js/jquery.core.js"></script>
	<script src="assets/js/jquery.app.js"></script>
	<script src="assets/js/select2.min.js"></script>
	<script src="picker/js/bootstrap-datepicker.min.js"></script>
	<script src="picker/js/moment.min.js"></script>
	<script src="assets/js/bootstrap-timepicker.min.js"></script>
	<script src="picker/js/bootstrap-datetimepicker.min.js"></script>
	<script src="assets/js/ace.min.js"></script>

	<!-- Modal-Effect -->
	<script src="plugins/custombox/js/custombox.min.js"></script>
	<script src="plugins/custombox/js/legacy.min.js"></script>
	<script type="text/javascript">
			$(document).ready(function(){
				 $('.select2').css('width','100%').select2({allowClear:true})
					.on('change', function(){
					}); 
		         
		         
		         $('.date-picker').datepicker({
						autoclose: true,
						todayHighlight: true
				 });
					//show datepicker when clicking on the icon
					
		         
		           // $("#id-date-picker-1").datepicker("setDate", new Date());
					$('#id-date-picker-1').datepicker({
					        "autoclose": true
					});
					
				/*TIME PICKER START'S HERE*/
				$('#timepicker1').timepicker({
					minuteStep: 1,
					showSeconds: true,
					showMeridian: false,
					disableFocus: true,
					icons: {
						up: 'fa fa-chevron-up',
						down: 'fa fa-chevron-down'
					}
				}).on('focus', function() {
					$('#timepicker1').timepicker('showWidget');
				}).next().on(ace.click_event, function(){
					$(this).prev().focus();
				});
			});
		</script>
	<script type="text/javascript">
	    $("#myform").submit(function(e){
	        e.preventDefault();
	        var report_type=$('#report_type').val();
	        if(report_type=='date'){
	        	var from_date=$('.from_date').val();
	        	var to_date=$('.to_date').val();
	        	var product_id=$('#product_id').val();
	        	var plant_id=$('#plant_id').val();
	        	window.location="CallReport.jsp?action=generateReport&report_type="+report_type+"&from_date="+from_date+"&to_date="+to_date+"&product_id="+product_id+"&plant_id="+plant_id;
	        }
			
	    });
    </script>

	<script type="text/javascript">
    	$(document).ready(function(){
    		$('.no-date').prop('disabled',true);
    		$('.no-date').hide();
    	});
    </script>

	<script type="text/javascript">
    	$(document).ready(function(){
    		$('#report_type').on('change',function(){
    			var report_type=$('#report_type').val();
    			changeType(report_type)
    		});
    		
    		var changeType=function(report_type){
    			if(report_type=='date'){
    				$('.no-date').hide();
    				$('.no-date').prop('disabled',true);
    				$('.date').show();
    				$('.date').prop('disabled',false);
    			}else if(report_type=='customer'){
    				$('.cus').prop('disabled',false);
    				$('.no-cus').prop('disabled',true);
    				$('.cus').show();
    				$('.no-cus').hide();
    			}else if(report_type=='vehicle'){
    				$('.veh').prop('disabled',false);
    				$('.no-veh').prop('disabled',true);
    				$('.veh').show();
    				$('.no-veh').hide();
    			}else if(report_type=='customerdate'){
    				$('.cus-dat').prop('disabled',false);
    				$('.no-cus-dat').prop('disabled',true);
    				$('.cus-dat').show();
    				$('.no-cus-dat').hide();
    			}else if(report_type=='vehicledate'){
    				$('.veh-dat').prop('disabled',false);
    				$('.no-veh-dat').prop('disabled',true);
    				$('.veh-dat').show();
    				$('.no-veh-dat').hide();
    			}else if(report_type=='marketing'){
    				$('.mar').prop('disabled',false);
    				$('no-mar').prop('disabled',true);
    				$('.mar').show();
    				$('.no-mar').hide();
    			}
    		};
    		
    		//call the method for render of report type here
    		var report=get('report_type');
    		//alert(report);
    		changeType(report);
    		
    		
    	});
    	
    	
    	function get(name){
    		   if(name=(new RegExp('[?&]'+encodeURIComponent(name)+'=([^&]*)')).exec(location.search))
    		      return decodeURIComponent(name[1]);
    		}
    </script>
	<script type="text/javascript">
    	$(document).ready(function(){
    		$('#customer_id').on('change',function(){
    			var customer_id=$('#customer_id').val();
    			$.ajax({
    				type:'POST',
    				url:'CustomerController?action=getCustomerSiteDetails&customer_id='+customer_id,
    				headers:{
    					Accept:"application/json;charset=utf-8",
    					"Content-Type":"application/json;charset=utf-8"
    				},
    				success:function(result){
    					$('#select2-site_id-container').html('Choose Site Address');
    					$('#site_id').html('');
    	        		$('#site_id').html('<option value="">Choose Site Address.</option>');
    	        		$.each(result, function(index, value) {
    	        			   $('#site_id').append("<option value='"+ value.site_id+ "'>" + value.site_name + "</option>");
    	        		});
    				}
    			});
    		});
    	});
    </script>

	<script type="text/javascript">
    	$(document).ready(function(){
    		$('#site_id').on('change',function(){
    			var site_id=$('#site_id').val();
    			$.ajax({
    				type:'POST',
    				url:'CustomerController?action=getProjectBlocks&site_id='+site_id,
    				headers:{
    					Accept:"application/json;charset=utf-8",
    					"Content-Type":"application/json;charset=utf-8"
    				},
    				success:function(result){
    					$('#select2-block_name-container').html('Choose Block');
    					$('#block_name').html('');
    	        		$('#block_name').html('<option value="">Choose Block</option>');
    	        		$.each(result, function(index, value) {
    	        			   $('#block_name').append("<option value='"+ value.block_name+ "'>" + value.block_name+ "</option>");
    	        		});
    				}
    			});
    		});
    	});
    </script>
	<script type="text/javascript">
    function fnExcelReport()
    {
        var tab_text="<table border='2px'><tr style='color:white;background-color:#4abc3e;'>";
        var textRange; var j=1;
        tab = document.getElementById('example-2'); // id of table

        for(j = 1 ; j < tab.rows.length ; j++) 
        {     
            tab_text=tab_text+tab.rows[j].innerHTML+"</tr>";
            //tab_text=tab_text+"</tr>";
        }

        tab_text=tab_text+"</table>";
        tab_text= tab_text.replace(/<A[^>]*>|<\/A>/g, "");//remove if u want links in your table
        tab_text= tab_text.replace(/<img[^>]*>/gi,""); // remove if u want images in your table
        tab_text= tab_text.replace(/<input[^>]*>|<\/input>/gi, ""); // reomves input params

        var ua = window.navigator.userAgent;
        var msie = ua.indexOf("MSIE "); 

        if (msie > 0 || !!navigator.userAgent.match(/Trident.*rv\:11\./))      // If Internet Explorer
        {
            txtArea1.document.open("txt/html","replace");
            txtArea1.document.write(tab_text);
            txtArea1.document.close();
            txtArea1.focus(); 
            sa=txtArea1.document.execCommand("SaveAs",true,"Say Thanks to Sumit.xls");
        }  
        else                 //other browser not tested on IE 11
            sa = window.open('data:application/vnd.ms-excel,' + encodeURIComponent(tab_text));  

        return (sa);
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
	<script type="text/javascript">
	    function GetURLParameter(sParam)
	    {
	        var sPageURL = window.location.search.substring(1);
	        var sURLVariables = sPageURL.split('&');
	        for (var i = 0; i < sURLVariables.length; i++) 
	        {
	            var sParameterName = sURLVariables[i].split('=');
	            if (sParameterName[0] == sParam) 
	            {
	                return sParameterName[1];
	            }
	        }
	    }
    </script>
	<script type="text/javascript">
    	$(document).ready(function(){
    		$('#tally').on("click",function(){
    			var report_type=GetURLParameter('report_type');
    			var customer_id=GetURLParameter('customer_id');
    			var from_date=GetURLParameter('from_date');
    			var to_date=GetURLParameter('to_date');
    			var site_id=GetURLParameter('site_id');
    			var product_id=GetURLParameter('product_id');
    			var plant_id=GetURLParameter('plant_id');
    			var vehicle_no=GetURLParameter('vehicle_no');
    			$.ajax({
    				type:'POST',
    				url:'InvoiceController?action=TallyXml&report_type='+report_type+'&customer_id='+customer_id+'&from_date='+from_date+'&to_date='+to_date+'&site_id='+site_id+'&product_id='+product_id+'&plant_id='+plant_id+'&vehicle_no='+vehicle_no,
    				headers:{
    					Accept:"application/json;charset=utf-8",
    				    "Content-Type":"application/json;charset=utf-8"
    				},
    				success:function(res){
    					$('#ledger tbody').html("");
    					var count=0;
    					$.each(res, function(index, value) {
            				count++;
            				var row='<tr>';
            				row+='<td>'+value.name+'<input type="hidden" name="site_id" value="'+index+'"></td><td>'+value.address+'</td><td><input type="text" class="col-xs-12" name="tally_ladger"></td>'
            				row+='</tr>'
            			  $('#ledger tbody').append(row);
    	        		});
    					if(count>0){
    						$('#tally-click').trigger('click');
    					}else{
    						window.location.href='TallyXML.jsp?report_type='+report_type+'&customer_id='+customer_id+'&from_date='+from_date+'&to_date='+to_date+'&site_id='+site_id+'&product_id='+product_id+'&plant_id='+plant_id+'&vehicle_no='+vehicle_no;
    					}
    				}
    			})
    		});
    	});
    </script>
	<script type="text/javascript">
    	$(document).ready(function(){
    		$('#selectall').on("change",function(){
    			if($(this).is(":checked")){
    				$('.id').prop("checked",true);
    			}else{
    				$('.id').prop("checked",false);
    			}
    		});
    		
    		
    		/* check if any check box has been clicked */
    		$('.id').on("change",function(){
    			var count=0;
    			$('.idcls:checkbox').each(function(){
    				if($(this).is(':checked')){
    					count=count+1;
    				}
    			});
    			
    			if(count>0){
					$('#consoldate_invoice').show();
					$('#sales_document').show();
				}else{
					$('#consoldate_invoice').hide(); 
					$('#sales_document').hide();
				}
    		});
    		
    	});
    </script>

	<script type="text/javascript">
    	$(document).ready(function(){
    		$('#submit-btn').on("click",function(){
    			$('#pump_charge').val(($('#pmp_chrg').val()=='')?0:$('#pmp_chrg').val());
    			$('#advance_amount').val(($('#adv_amt').val()=='')?0:$('#adv_amt').val());
    			$('#plnt_id').val($('#pl_id').val());
    			$('#ref_no').val($('#reference_no').val());
    			$('#gen_date').val($('.generate_date').val());
    			$('#myfrm').submit();
    		});
    	});
    </script>

</body>
</html>