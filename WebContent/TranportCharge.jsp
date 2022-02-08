<!DOCTYPE html>
<%@ include file="Session.jsp" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<html>
<head>
        <meta charset="utf-8" />
        <title>Add Transport Charge</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
        <meta content="A fully featured admin theme which can be used to build CRM, CMS, etc." name="description" />
        <meta content="Coderthemes" name="author" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />

        <!-- App favicon -->
        <link rel="shortcut icon" href="assets/images/favicon.ico">
		<link rel="stylesheet" href="picker/cs/bootstrap-datepicker3.min.css" />
		<link rel="stylesheet" href="picker/cs/bootstrap-timepicker.min.css" />
        <!-- App css -->
        <link href="assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/icons.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/style.css" rel="stylesheet" type="text/css" />
        <link rel="stylesheet" href="assets/css/select2.min.css" />
        <link rel="stylesheet" href="assets/css/render.css">
        <link rel="stylesheet" href="datetime/css/bootstrap-datetimepicker.css" />
		<link rel="stylesheet" href="datetime/css/bootstrap-datetimepicker-standalone.css" />
		<link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css" rel="stylesheet">
		<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.9/angular.min.js"></script>
        
        <style type="text/css">
        	.change{
        		background-color:#469399;
        		color: white;
        	}
        	
        	.nochange{
        		background-color: #d7dfe0;
        		
        	}
        </style>

        <script src="assets/js/modernizr.min.js"></script>

    </head>

    <body ng-app="">

        <!-- Navigation Bar-->
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
                                    <li class="breadcrumb-item"><a href="#">Billing</a></li>
                                    <li class="breadcrumb-item"><a href="#">Transport Charge</a></li>
                                    <li class="breadcrumb-item"><a href="#">Add Transport Charge</a></li>
                                </ol>
                            </div>
                            <h4 class="page-title">Add Transport Charge</h4>
                        </div>
                    </div>
                </div>
                <!-- end page title end breadcrumb -->
                 <div class="row">
                    <div class="col-sm-4">
                        <a href="TranportChargeList.jsp" class="btn btn-custom waves-effect waves-light mb-4"  data-overlayColor="#36404a"><i class="mdi mdi-plus"></i>Transport Charge List</a>
                    </div><!-- end col -->
                </div>
                <!-- end row -->
               
              	<div class="row">
                    <div class="col-sm-12">
                    	<form class="" id="myform" action="InvoiceController?action=InsertInvoice" onsubmit="savebtn.disabled=true;return true;" method="post">
	                        <div class="card-box row col-sm-12">
	                           	<div class="col-sm-6">
	                           		<div class="form-group">
	                                    <label>Invoice No<span class="text-danger">*</span> </label>
	                                    <div>
	                                       <input type="text" class="form-control" 
	                                          readonly="readonly"   required="required"   id="invoice_no" name="invoice_no"/>
	                                    </div>
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
	                                    	select * from customer where customer_status='active' order by customer_name asc 
	                                    </sql:query>
										<select id="customer"  name="customer_id" required="required"   class="select2"  data-placeholder="Choose Customer">
											<option value="">&nbsp;</option>
											<c:forEach var="customer" items="${customer.rows}">
											<option value="${customer.customer_id}">${customer.customer_name}</option>
											</c:forEach>
										</select>
	                                </div>
	                                
	                                 <div class="form-group">
	                                 	<label>Start Time<span class="text-danger"></span> </label>
						                <div class='input-group date'>
						                    <input type='text' class="form-control"  id='datetimepicker1' name="start_time"/>
						                    <div class="input-group-append">
	                                            <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
	                                        </div>
						                </div>
						            </div>
						            
						            <div class="form-group">
	                                 	<label>End Time<span class="text-danger"></span> </label>
						                <div class='input-group date'>
						                    <input type='text' class="form-control"  id='datetimepicker2' name="end_time"/>
						                    <div class="input-group-append">
	                                            <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
	                                        </div>
						                </div>
						            </div>
						            
	                                 <div class="form-group">
	                                    <label>Opening KM<span class="text-danger">*</span> </label>
	                                    <div>
	                                       <input type="number" class="form-control" 
	                                         pattern="[^'&quot;:]*$" step="0.01" name="opening_km" data-ng-model="opening_km"  required="required" id="opening_km"/>
	                                    </div>
	                                </div>
	                                
	                                <div class="form-group">
	                                    <label>Closing KM<span class="text-danger">*</span> </label>
	                                    <div>
	                                       <input type="number" class="form-control" 
	                                         pattern="[^'&quot;:]*$" step="0.01" name="closing_km" data-ng-model="closing_km"  required="required" id="closing_km"/>
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
	                                    <label>Price<span class="text-danger">*</span> </label>
	                                    <div>
	                                       <input type="number" class="form-control" 
	                                         pattern="[^'&quot;:]*$" step="0.01" name="price"  required="required" id="price"/>
	                                    </div>
	                                </div>
	                                
	                                <div class="form-group">
	                                    <label>Price Category<span class="text-danger">*</span></label>
										<select id="vehicle_no"  name="price_cat" required="required"  class="select2"  data-placeholder="Choose Price Category">
											<option value="hour">Hour</option>
											<option value="day">Day</option>
										</select>
	                                </div>
	                                
	                                <div class="form-group">
	                                    <label>Diesel Quantity<span class="text-danger">*</span> </label>
	                                    <div>
	                                       <input type="number" class="form-control" 
	                                         pattern="[^'&quot;:]*$" step="0.01" name="diesel_quantity"  required="required" id="diesel_quantity"/>
	                                    </div>
	                                </div>
	                                
	                                <div class="form-group">
	                                    <label>Diesel Price<span class="text-danger">*</span> </label>
	                                    <div>
	                                       <input type="number" class="form-control" 
	                                         pattern="[^'&quot;:]*$" step="0.01" name="diesel_price"  required="required" id="diesel_price"/>
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
	                                			<td class="change" style="width: 16.66%">Opening KM : </td>
	                                			<td class="nochange" style="width: 16.66%">{{ opening_km }}</td>
	                                			<td class="change" style="width: 16.66%">Closing KM : </td>
	                                			<td class="nochange" style="width: 16.66%" >{{ closing_km }}</td>
	                                			<td class="change" style="width: 16.66%">Total KM : </td>
	                                			<td class="nochange" style="width: 16.66%">{{closing_km-opening_km}}</td>
	                                		</tr>
	                                		
	                                		<tr>
	                                			<td class="change" style="width: 16.66%">Start Time : </td>
	                                			<td class="nochange" style="width: 16.66%" id="start_time_view"></td>
	                                			<td class="change" style="width: 16.66%">End Time : </td>
	                                			<td class="nochange" style="width: 16.66%" id="end_time_view"></td>
	                                			<td class="change" style="width: 16.66%">Total Time : </td>
	                                			<td class="nochange" style="width: 16.66%"></td>
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
	                                        <button type="submit" id="savebtn" name="savebtn" class="btn btn-custom waves-effect waves-light">
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
       <%@ include file="footer.jsp" %>
        <!-- End Footer -->


        <!-- jQuery  -->
        <script src="assets/js/jquery.min.js"></script>
        <script src="assets/js/popper.min.js"></script>
        <script src="assets/js/bootstrap.min.js"></script>
        <script src="assets/js/waves.js"></script>
        <script src="assets/js/jquery.slimscroll.js"></script>

        <!-- Parsley js -->
        <script type="text/javascript" src="plugins/parsleyjs/parsley.min.js"></script>

        <!-- App js -->
        <script src="assets/js/jquery.core.js"></script>
        <script src="assets/js/jquery.app.js"></script>
        <script src="assets/js/select2.min.js"></script>
		<script src="picker/js/bootstrap-datepicker.min.js"></script>
		<script src="picker/js/moment.min.js"></script>
		<script src="assets/js/bootstrap-timepicker.min.js"></script>
		<script src="picker/js/bootstrap-datetimepicker.min.js"></script>
		<script type="text/javascript" src="js/AddPurchaseOrder.js"></script>
		<script type="text/javascript" src="js/transport_charge.js"></script>
		<script src="datetime/js/bootstrap-datetimepicker.min.js"></script>
		<script src="assets/js/ace.min.js"></script>
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
				
				$('#datetimepicker1').datetimepicker({format: 'YYYY-MM-DD hh:mm:ss'});
				$('#datetimepicker2').datetimepicker({format: 'YYYY-MM-DD hh:mm:ss'});
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
    </body>
</html>