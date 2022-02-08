<!DOCTYPE html>
<%@ include file="Session.jsp" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<html>
<head>
        <meta charset="utf-8" />
        <title>Add Invoice</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
        <meta content="A fully featured admin theme which can be used to build CRM, CMS, etc." name="description" />
        <meta content="Coderthemes" name="author" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />

        <!-- App favicon -->
        <link rel="shortcut icon" href="../assets/images/favicon.ico">
		<link rel="stylesheet" href="../picker/cs/bootstrap-datepicker3.min.css" />
		<link rel="stylesheet" href="../picker/cs/bootstrap-timepicker.min.css" />
        <!-- App css -->
        <link href="../assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="../assets/css/icons.css" rel="stylesheet" type="text/css" />
        <link href="../assets/css2/style.css" rel="stylesheet" type="text/css" />
        <link rel="stylesheet" href="../assets/css/select2.min.css" />
        <link rel="stylesheet" href="../assets/css/render.css">
        
        <style type="text/css">
        	.change{
        		background-color:#bf7705;
        		color: white;
        	}
        	
        	.nochange{
        		background-color: #d7dfe0;
        		
        	}
        </style>

        <script src="../assets/js/modernizr.min.js"></script>

    </head>

    <body>

        <!-- Navigation Bar-->
        	<%@ include file="../header.jsp" %>
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
                                    <li class="breadcrumb-item"><a href="#">Invoice</a></li>
                                    <li class="breadcrumb-item"><a href="#">Add Invoice</a></li>
                                </ol>
                            </div>
                            <h4 class="page-title">Add Invoice</h4>
                        </div>
                    </div>
                </div>
                <!-- end page title end breadcrumb -->
                 <div class="row">
                    <div class="col-sm-4">
                        <a href="InvoiceList.jsp" class="btn btn-custom waves-effect waves-light mb-4"  data-overlayColor="#36404a"><i class="mdi mdi-plus"></i>Invoice List</a>
                    </div><!-- end col -->
                </div>
                <!-- end row -->
               
              	<div class="row">
                    <div class="col-sm-12">
                    	<form class="" id="myform" action="../InvoiceControllerTest?action=InsertInvoice" method="post">
	                        <div class="card-box row col-sm-12">
	                        	
	                           	<div class="col-sm-6">
	                           		 <div class="form-group">
	                                    <label>Invoice Id : </label>
	                                    <div>
	                                       <input type="text" class="form-control" 
	                                         pattern="[^'&quot;:]*$"     id="invoice_id" name="invoice_id"/>
	                                    </div>
	                                    <span style="color: red;" id="invoice_error"></span>
	                                </div>
	                           		<div class="form-group">
	                                    <label>Plant <span class="text-danger">*</span></label>
	                                    <sql:query var="plant" dataSource="jdbc/rmc">
	                                    	select * from plant where plant_id like if(?=0,'%%',?)
	                                    	<sql:param value="${bean.plant_id}"/>
	                                    	<sql:param value="${bean.plant_id}"/>
	                                    </sql:query>
										<select id="plant_id"  name="plant_id" required="required"   class="select2"  data-placeholder="Choose Plant">
											<c:forEach var="plant" items="${plant.rows}">
											<option value="${plant.plant_id}">${plant.plant_name}</option>
											</c:forEach>
										</select>
	                                </div>
	                                
	                           	   <div class="form-group">
	                                    <label>Customer <span class="text-danger">*</span></label>
	                                    <sql:query var="customer" dataSource="jdbc/rmc">
	                                    	select * from test_customer order by customer_name asc
	                                    </sql:query>
										<select id="customer"  name="customer_id" required="required"   class="select2"  data-placeholder="Choose Customer">
											<option value="">&nbsp;</option>
											<c:forEach var="customer" items="${customer.rows}">
											<option value="${customer.customer_id}">${customer.customer_name}</option>
											</c:forEach>
										</select>
	                                </div>
	                                
	                                <div class="form-group">
	                                    <label>Site Name<span class="text-danger">*</span></label>
										<select id="site_id"  name="site_id" required="required"   class="select2"  data-placeholder="Choose Site">
											
										</select>
	                                </div>
	                                
	                                <div class="form-group">
	                                    <label>Grade<span class="text-danger">*</span></label>
										<select id="poi_id"  name="poi_id" required="required"  class="select2"  data-placeholder="Choose Grade">
											
										</select>
	                                </div>
	                                
	                                <div class="form-group">
	                                    <label>Quantity<span class="text-danger">*</span> </label>
	                                    <div>
	                                       <input type="number" class="form-control" 
	                                         pattern="[^'&quot;:]*$" step="0.01"  required="required" onkeyup="calculateNetAmmount();"   id="quantity" name="quantity"/>
	                                    </div>
	                                </div>
	                                
	                            </div>
	                            <div class="col-sm-6">
	                              <div class="form-group">
                                        <label>Invoice Date <span class="text-danger"></span> </label>
                                        <div>
                                            <div class="input-group">
                                                <input type="text" name="invoice_date" class="form-control date-picker invoice_date" required="required" placeholder="yyyy-mm-dd" id="id-date-picker-1" data-date-format="yyyy-mm-dd">
                                                <div class="input-group-append">
                                                    <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
                                                </div>
                                            </div>
                                        </div>
                                   </div>
	                                
	                                <div class="form-group">
	                                    <label>Invoice Time <span class="text-danger">*</span> </label>
	                                    <div>
	                                        <div class="input-group">
	                                            <input type="text" name="invoice_time" class="form-control" required="required" placeholder="HH:MM:SS" id="timepicker1" data-date-format="yyyy-mm-dd">
	                                            <div class="input-group-append">
	                                                <span class="input-group-text"><i class="fa fa-clock-o"></i></span>
	                                            </div>
	                                        </div>
	                                    </div>
	                                </div>
	                                
	                                <div class="form-group">
	                                    <label>Vehicle No <span class="text-danger">*</span></label>
	                                    <sql:query var="vehicle" dataSource="jdbc/rmc">
	                                    	select * from vehicle
	                                    </sql:query>
										<select id="vehicle_no"  name="vehicle_no" required="required"  class="select2"  data-placeholder="Choose Vehicle">
											<option value="">&nbsp;</option>
											<c:forEach var="vehicle" items="${vehicle.rows}">
											<option value="${vehicle.vehicle_no}">${vehicle.vehicle_no}</option>
											</c:forEach>
										</select>
	                                </div>
	                                
	                                <div class="form-group">
	                                    <label>Driver Name <span class="text-danger">*</span></label>
	                                    <sql:query var="driver" dataSource="jdbc/rmc">
	                                    	select * from driver
	                                    </sql:query>
										<select id="driver_name"  name="driver_name"   class="select2"  data-placeholder="Choose Driver">
											<option value="">&nbsp;</option>
											<c:forEach var="driver" items="${driver.rows}">
											<option value="${driver.driver_name}">${driver.driver_name}</option>
											</c:forEach>
										</select>
	                                </div>
	                                
	                                <div class="form-group">
	                                    <label>Pump <span class="text-danger">*</span></label>
	                                    <sql:query var="pump" dataSource="jdbc/rmc">
	                                    	select * from pump where type='pump'
	                                    </sql:query>
										<select id="pump"  name="pump"   class="select2"  data-placeholder="Choose Pump">
											<option value="">&nbsp;</option>
											<c:forEach var="pump" items="${pump.rows}">
											<option value="${pump.pump_name}">${pump.pump_name}</option>
											</c:forEach>
										</select>
	                                </div>
	                                
	                                <div class="form-group">
	                                    <label>KM Reading<span class="text-danger">*</span> </label>
	                                    <div>
	                                       <input type="number" class="form-control" 
	                                         pattern="[^'&quot;:]*$" step="0.01"  required="required"   id="km_reading" name="km_reading"/>
	                                    </div>
	                                </div>
	                             </div>
								  <!-- write all hidden data here -->
		                          	<input type="hidden" name="rate" id="rate">
		                          	<input type="hidden" name="gross_price" id="gross_price">
		                          	<input type="hidden" name="net_price" id="net_price">
		                          	<input type="hidden" name="tax_price" id="tax_price">
		                          	<input type="hidden" name="tax_percent" id="tax_percent">
		                          	<input type="hidden" name="rate_include" id="rate_include">
		                          	<input type="hidden" name="tax_group" id="tax_group">
		                          <!-- All hidden data ends here -->	
		                           
	                             <div class="col-sm-12 table-responsive" id="clicked">
                                	<table class="table table-bordered" id="Table1">
                                		<thead>
                                			<tr id="show-error">
                                				
                                			</tr>
                                		</thead>
                                		<tbody>
                                			<tr>
	                                			<td class="change">Customer Name : </td>
	                                			<td class="nochange" colspan="2" id="show_customer"></td>
	                                			<td class="change">Customer Address : </td>
	                                			<td class="nochange" colspan="2" id="show_customer_address"></td>
	                                		</tr>
	                                		<tr>
	                                			<td class="change">Site Name : </td>
	                                			<td class="nochange" colspan="2" id="show_site_name"></td>
	                                			<td class="change">Site Address : </td>
	                                			<td class="nochange" colspan="2" id="show_site_address"></td>
	                                		</tr>
	                                		<tr>
	                                			<td class="change" style="width: 16.66%">Grade : </td>
	                                			<td class="nochange" style="width: 16.66%" id="show_grade"></td>
	                                			<td class="change" style="width: 16.66%">Rate : </td>
	                                			<td class="nochange" style="width: 16.66%" id="show_rate"></td>
	                                			<td class="change" style="width: 16.66%">Quantity : </td>
	                                			<td class="nochange" style="width: 16.66%" id="show_quantity"></td>
	                                		</tr>
	                                		<tr>
	                                			<td class="change" style="width: 16.66%">Gross Price : </td>
	                                			<td class="nochange" style="width: 16.66%" id="gross_view"></td>
	                                			<td class="change" style="width: 16.66%">Tax Price : </td>
	                                			<td class="nochange" style="width: 16.66%" id="tax_view"></td>
	                                			<td class="change" style="width: 16.66%">Net Price : </td>
	                                			<td class="nochange" style="width: 16.66%" id="net_view"></td>
	                                		</tr>
	                                		<tr>
	                                			<td class="change" style="width: 16.66%">CSGT <span id="show_cgst"></span>%: </td>
	                                			<td class="nochange" style="width: 16.66%" id="view_cgst"></td>
	                                			<td class="change" style="width: 16.66%">SGST <span id="show_sgst"></span>%: </td>
	                                			<td class="nochange" style="width: 16.66%" id="view_sgst"></td>
	                                			<td class="change" style="width: 16.66%">IGST <span id="show_igst"></span>%: </td>
	                                			<td class="nochange" style="width: 16.66%" id="view_igst"></td>
	                                		</tr>
	                                		<tr>
	                                			<td class="change" colspan="1">IN WORDS</td>
	                                			<td class="nochange" colspan="5" id="in-word"></td>
	                                		</tr>
                                		</tbody>
                                	</table>
                                </div>
                                <div class="col-sm-12 text-center">
                                	<div class="form-group">
	                                    <div>
	                                        <button type="submit" id="savebtn" class="btn btn-custom waves-effect waves-light">
	                                            Submit
	                                        </button>
	                                        <button type="reset" class="btn btn-light waves-effect m-l-5">
	                                            Cancel
	                                        </button>
	                                    </div>
	                                </div>
                                </div>
                        	</div>
                        </form>
                    </div>
                </div>
                <!-- end row -->
            </div> <!-- end container -->
        </div>
        

        <!-- Footer -->
       <%@ include file="../footer.jsp" %>
        <!-- End Footer -->


        <!-- jQuery  -->
        <script src="../assets/js/jquery.min.js"></script>
        <script src="../assets/js/popper.min.js"></script>
        <script src="../assets/js/bootstrap.min.js"></script>
        <script src="../assets/js/waves.js"></script>
        <script src="../assets/js/jquery.slimscroll.js"></script>

        <!-- Parsley js -->
        <script type="text/javascript" src="../plugins/parsleyjs/parsley.min.js"></script>

        <!-- App js -->
        <script src="../assets/js/jquery.core.js"></script>
        <script src="../assets/js/jquery.app.js"></script>
        <script src="../assets/js/select2.min.js"></script>
		<script src="../picker/js/bootstrap-datepicker.min.js"></script>
		<script src="../picker/js/moment.min.js"></script>
		<script src="../assets/js/bootstrap-timepicker.min.js"></script>
		<script src="../picker/js/bootstrap-datetimepicker.min.js"></script>
		<script type="text/javascript" src="../js/AddPurchaseOrder2.js"></script>
		<script src="../assets/js/ace.min.js"></script>
		<script type="text/javascript">
			$(document).ready(function(){
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
			$(document).ready(function(){
				$('#customer').on('change',function(){
					$('.nochange').text('');
					var customer_id=$('#customer').val();
					$.ajax({
						type:'POST',
						url:'../CustomerControllerTest?action=GetCustomerDetails&customer_id='+customer_id,
						headers:{
							Accept:"application/json;charset=utf-8",
							"Content-Type":"application/json;charset=utf-8"
						},
						success:function(result){
							$('#show_customer').text(result.customer_name);
							$('#show_customer_address').text(result.customer_address);
							$.ajax({
								type:'POST',
								url:'../CustomerControllerTest?action=getCustomerSiteDetails&customer_id='+customer_id,
								headers:{
									Accept:"application/json;charset=utf-8",
									"Content-Type":"application/json;charset=utf-8"
								},
								success:function(res){
									$('#select2-site_id-container').html('Choose Site Address');
									$('#site_id').html('');
					        		$('#site_id').html('<option value="">Choose Site Address.</option>');
					        		$.each(res, function(index, value) {
					        			   $('#site_id').append("<option value='"+ value.site_id+ "'>" + value.site_name + "</option>");
					        		});
								}
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
					var plant_id=$('#plant_id').val();
					$.ajax({
						type:'post',
						url:'../CustomerControllerTest?action=GetSiteName&site_id='+site_id,
						headers:{
							Accept:"application/json;charset=utf-8",
							"Content-Type":"application/json;charset=utf-8"
						},
						success:function(result){
							$('#show_site_name').text(result.site_name);
							$('#show_site_address').text(result.site_address);
							$.ajax({
								type:'post',
								url:'../PurchaseOrderControllerTest?action=GetGradeList&site_id='+site_id+'&plant_id='+plant_id,
								headers:{
									Accept:"application/json;charset=utf-8",
									"Content-Type":"application/json;charset=utf-8"
								},
								success:function(res){
									$('#select2-poi_id-container').html('Choose Grade');
									$('#poi_id').html('');
					        		$('#poi_id').html('<option value="">Choose Grade</option>');
					        		$.each(res, function(index, value) {
					        			   $('#poi_id').append("<option value='"+ value.poi_id+ "'>" + value.product_name + "</option>");
					        		});
								}
							});
						}
					})
				});
			});
		</script>
		<script type="text/javascript">
			$(document).ready(function () {
			    function addRow(){
			        var html = '<tr>'+
									'<td>'+
										'${name}'+
									'</td>'+
									'<td>'+
										'<input type="text" class="form-control" pattern="[^\'&quot;:]*$"  required="required" placeholder="Enter Quantity"   name="quantity"/>'+
									'</td>'+
									'<td>'+
										'<input type="text" class="form-control"  pattern="[^\'&quot;:]*$"  required="required" placeholder="Enter Rate"   name="rate"/>'+
									'</td>'+
									'<td>'+
										'<span class="text-danger removebtn"><i class="fa fa-trash"></i></span>'+
									'</td>'+
								'</tr>'
			        $(html).appendTo($("#Table1"))
			        $('.select2').css('width','100%').select2({allowClear:true})
					.on('change', function(){
					}); 
			    };
			    $("#clicked").on("click", ".BtnPlus", addRow);
			});
			 $('#Table1').on('click', '.removebtn', function(){
				    $(this).closest ('tr').remove ();
			});
		</script>
		
		<script type="text/javascript">
		$(document).ready(function(){
		    $("#poi_id").change(function(){
				var poi_id=$('#poi_id').val();
				var date=$('.invoice_date').val();
		    	$.ajax({
		        	type:'POST',
		        	url:'../PurchaseOrderControllerTest?action=GetGradeDetails&poi_id='+poi_id+'&date='+date,
		        	headers:{
		        		Accept:"application/json;charset=utf-8",
		        		"Content-Type":"application/json;charset=utf-8"
		        	},
		        	success:function(result){
		        		//var inventory=jQuery.parseJSON(result);
		                 $('#show_rate').html(result.rate);
		                 $('#show_grade').html(result.product_name);
		                 $('#tax_group').val(result.tax_group);
		                 $('#rate_include').val(result.rate_include);
		                 $('#tax_percent').val(result.gst_percent);
		                 $('#rate').val(result.rate);
		                 var gst_percent=result.gst_percent;
		                 if(result.tax_group=='GST'){
		                	 $('#show_cgst').text(parseFloat(gst_percent/2));
		                	 $('#show_sgst').text(parseFloat(gst_percent/2));
		                	 $('#show_igst').text('0');
		                 }else{
		                	 $('#show_cgst').text('0')
		                	 $('#show_sgst').text('0');
		                	 $('#show_igst').text(gst_percent);
		                 }
		                 calculateNetAmmount();
		        	}
		        });
		    });
		});
		</script>
		<script type="text/javascript">
    	function calculateNetAmmount(){
    		   var basic_rate=$('#rate').val();
		       basic_rate=(basic_rate=='')?0:parseFloat(basic_rate);
		       var quantity=$('#quantity').val();
		       quantity=(quantity=='')?0:parseFloat(quantity);
		       //set quantity
		       $('#show_quantity').text(quantity);
		       var include_tax=$('#rate_include').val();
		       //get gst value
		       var tax_price;
			   var gst=$('#tax_percent').val();
		       gst=(gst=='')?0:parseFloat(gst);
			   var tax=gst+100;
		       if(include_tax=='yes'){
		    	   var net_price=basic_rate*quantity;
				   net_price=net_price.toFixed(2);
				   var gross_price=(net_price/tax)*100;
				   gross_price=gross_price.toFixed(2);
			       tax_price=parseFloat(gross_price/100)*gst;
			       tax_price=tax_price.toFixed(2);
			       
		       }else{
		    	   var net_price=basic_rate*quantity;
				   net_price=net_price.toFixed(2);
				   var gross_price=net_price;
			       var tax_price=0;
		       }
		       
		       //now set gst value according to gst and igst
		       var tax_group=$('#tax_group').val();
		       if(include_tax=='yes' && tax_group=='GST'){
		    	   $('#view_cgst').text((tax_price/2).toFixed(2));
		    	   $('#view_sgst').text((tax_price/2).toFixed(2));
		    	   $('#view_igst').text('0');
		       }else if(include_tax=='yes' && tax_group=='IGST'){
		    	   $('#view_cgst').text('0');
		    	   $('#view_sgst').text('0');
		    	   $('#view_igst').text(tax_price);
		       }else{
		    	   $('#view_cgst').text('0');
		    	   $('#view_sgst').text('0');
		    	   $('#view_igst').text('0');
		       }
		       
		       var word=inWords(parseInt(net_price));
		       $('#in-word').text(word);
		       $('#net_view').text(net_price);
		       $('#gross_view').text(gross_price);
		       $('#tax_view').text(tax_price);
		       $('#gross_price').val(gross_price);
		       $('#net_price').val(net_price);
		       $('#tax_price').val(tax_price);
		     
    	}
    </script>
    <script type="text/javascript">
    $("#myform").bind('ajax:complete', function() {
		$('#savebtn').hide();
  	});
    </script>
    
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
  <script type="text/javascript">
	 function setValue(){
		 var input = document.getElementById('quantity');
		  input.setAttribute('value', input.value);
	 }
  </script>
  
  <script type="text/javascript">
		$(document).ready(function(){
			$('#quantity').on('keyup blur',function(){
				var poi_id=$('#poi_id').val();
		  		var quantity=$('#quantity').val();
		  		$.ajax({
		  			type:'post',
		  			url:'../PurchaseOrderControllerTest?action=checkPOType&poi_id='+poi_id+'&quantity='+quantity,
		  			headers:{
		  				Accept:"application/json;charset=utf-8",
		  				"Content-Type":"application/json;charset=utf-8"
		  			},
		  			success:function(res){
		  				if(res.order_type=='close'){
		  					var quantity=$('#quantity').val();
		  					quantity=(quantity=='' || quantity==undefined)?0.0:parseFloat(quantity);
		  					if(quantity>res.net_quantity){
		  						$('#savebtn').prop("disabled",true);
		  						$('#show-error').html("<td colspan='6' style='background-color:red;color:white;'>Total Po Quantity : "+res.order_quantity+" / Invoice Quantity : "+res.invoice_sum+" / Quantity Left : "+res.net_quantity+" Please Contact Incharge!!</td>");
		  					}else{
		  						$('#savebtn').prop("disabled",false);
		  						$('#show-error').html("")
		  					}
		  				}
		  			}
		  		});
			});
		}); 
  </script>
  
  <script type="text/javascript">
  		$(document).ready(function(){
  			$('#invoice_id').on('keyup blur',function(){
  				var plant_id=$('#plant_id').val();
  				var invoice_id=$('#invoice_id').val();
  				$.ajax({
  					type:'POST',
  					url:'../InvoiceControllerTest?action=CheckInvoiceNo&invoice_id='+invoice_id+'&plant_id='+plant_id,
  					headers:{
  						Accept:"text/html;charset=utf-8",
  						"Content-Type":"text/html;charset=utf-8"
  					},
  					success:function(res){
  						if(res.trim()=='exist'){
  							$('#invoice_error').text("Invoice No already exist!!");
  							$('#savebtn').prop("disabled",true);
  						}else{
  							$('#invoice_error').text("");
  							$('#savebtn').prop("disabled",false);
  						}
  					}
  					
  				})
  			});
  		});
  </script>
    </body>
</html>