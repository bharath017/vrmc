<!DOCTYPE html>
<%@ include file="Session.jsp" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<html>
<head>
        <meta charset="utf-8" />
        <title>Add DC</title>
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
        
        <style type="text/css">
        	.change{
        		background-color:#469399;
        		color: white;
        	}
        	
        	.nochange{
        		background-color: #d7dfe0;
        	}
        	
        	.error{
        		color:red;
        		font-weight: bold;
        	}
        </style>

        <script src="assets/js/modernizr.min.js"></script>

    </head>

    <body>

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
                                    <li class="breadcrumb-item"><a href="#">DC</a></li>
                                    <li class="breadcrumb-item"><a href="#">Add DC</a></li>
                                </ol>
                            </div>
                            <h4 class="page-title">Add DC</h4>
                        </div>
                    </div>
                </div>
                <!-- end page title end breadcrumb -->
                 <div class="row">
                    <div class="col-sm-4">
                        <a href="DCList.jsp" class="btn btn-custom waves-effect waves-light mb-4"  data-overlayColor="#36404a"><i class="mdi mdi-plus"></i>DC List</a>
                    </div><!-- end col -->
                </div>
                <!-- end row -->
               
              	<div class="row">
                    <div class="col-sm-12">
                    	<form class="" id="myform" action="DCController?action=InsertInvoice"  method="post">
	                        <div class="card-box row col-sm-12">
	                           	<div class="col-sm-6">
	                           		<div class="form-group">
	                                    <label>DC No<span class="text-danger">*</span> </label>
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
	                                    	select * from customer where customer_status='active' 
	                                    	and plant_id like if(?=0,'%%',?)
	                                    	<sql:param value="${bean.plant_id}"/>
	                                    	<sql:param value="${bean.plant_id}"/>
	                                    </sql:query>
										<select id="customer"  name="customer_id" required="required"   class="select2"  data-placeholder="Choose Customer">
											<option value="">&nbsp;</option>
											<c:forEach var="customer" items="${customer.rows}">
											<option value="${customer.customer_id}">${customer.customer_name}</option>
											</c:forEach>
										</select>
										<label id="customer-error" class="error" for="customer" style="display: none;"></label>
	                                </div>
	                                
	                                <div class="form-group">
	                                    <label>Site Name<span class="text-danger">*</span></label>
										<select id="site_id"  name="site_id" required="required"   class="select2"  data-placeholder="Choose Site">
											
										</select>
										<label id="site_id-error" class="error" for="site_id" style="display: none;"></label>
	                                </div>
	                                
	                                <div class="form-group">
	                                    <label>Grade<span class="text-danger">*</span></label>
										<select id="poi_id"  name="poi_id" required="required"  class="select2"  data-placeholder="Choose Site">
										</select>
										<label id="poi_id-error" class="error" for="poi_id" style="display: none;"></label>
	                                </div>
	                                
	                                 
	                                
	                                <div class="form-group">
	                                    <label>DC Quantity<span class="text-danger">*</span> </label>
	                                    <div>
	                                       <input type="text" class="form-control" pattern="[^'&quot;:]*$"   required="required"  id="quantity" name="quantity"/>
	                                    </div>
	                                </div>
	                                <div class="form-group">
	                                    <label>Loaded Grade<span class="text-danger">*</span> </label>
	                                    <div>
	                                       <sql:query var="grade" dataSource="jdbc/rmc">
		                                    	select * from product
		                                    </sql:query>
		                                    
											<select id="product_id" required="required"  name="loaded_product_id"   class="select2"  data-placeholder="Choose Grade">
												<option value="">&nbsp;</option>
												<c:forEach var="grade" items="${grade.rows}">
												<option value="${grade.product_id}" >${grade.product_name}</option>
												</c:forEach>
											</select>
	                                    </div>
	                                </div>
	                                <div class="form-group">
	                                    <label>Loaded Quantity<span class="text-danger">*</span> </label>
	                                    <div>
	                                       <input type="text" class="form-control" pattern="[^'&quot;:]*$" required="required"  id="loaded_quantity" name="loaded_quantity"/>
	                                    </div>
	                                </div>
	                            </div>
	                            <div class="col-sm-6">
	                              <div class="form-group">
                                        <label>DC Date <span class="text-danger"></span> </label>
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
	                                    <label>DC Time <span class="text-danger">*</span> </label>
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
										<label id="vehicle_no-error" class="error" for="vehicle_no" style="display: none;"></label>
	                                </div>
	                                
	                                <div class="form-group">
	                                    <label>Driver Name : </label>
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
	                                    <label>Pump : </label>
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
	                                    <label>Cement Grade : </label>
	                                    <div>
	                                       <input type="text" class="form-control" value="OPC53" name="km_reading"/>
	                                    </div>
	                                </div>
	                                <div class="row">
	                                <div class="col-sm-6 form-group">
	                                    <label>Cement<span class="text-danger"> : </span></label>
	                                    <input type="text" class="form-control" name="project_block"/>
	                                </div>
	                                <!-- Someone used km_reading column to save cement grade and project_block to save cement name. cant change them back as the data already exists in database, hence creating km_reading2.... -bharath -->
	                                 <div class="col-sm-6 form-group">
	                                    <label>KM Reading : </label>
	                                    <div>
	                                       <input type="number" class="form-control" 
	                                          step="0.01"     id="km_reading" name="km_reading2"/>
	                                    </div>
	                                </div>
	                                </div>
									<div class="form-group">
	                                    <label>Net Amount<span class="text-danger">*</span> </label>
	                                    <div>
	                                       <input type="text" class="form-control" 
	                                         pattern="[^'&quot;:]*$"  readonly="readonly" name="grss" required="required" id="grs_ammt"/>
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
	                                			<td class="change" style="width: 16.66%">Balanced Quantity : </td>
	                                			<td class="nochange" style="width: 16.66%" id="balanced_quantity"></td>
	                                			<td class="change" colspan="1">IN WORDS</td>
	                                			<td class="nochange" colspan="3" id="in-word"></td>
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

        <!-- App js -->
        <script src="assets/js/jquery.core.js"></script>
        <script src="assets/js/jquery.app.js"></script>
        <script src="assets/js/select2.min.js"></script>
		<script src="picker/js/bootstrap-datepicker.min.js"></script>
		<script src="picker/js/moment.min.js"></script>
		<script src="assets/js/bootstrap-timepicker.min.js"></script>
		<script src="picker/js/bootstrap-datetimepicker.min.js"></script>
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
		<script type="text/javascript" src="js/add_dc.js"></script>
		<script type="text/javascript" src="js/validation-datetime.js"></script>
		<script type="text/javascript" src="validation/jquery.validate.min.js"></script>
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
			});
		</script>
		
    </body>
</html>