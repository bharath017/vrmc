<!DOCTYPE html>
<%@page import="com.willka.soft.dao.DriverDAOImpl"%>
<%@ include file="Session.jsp" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<html>
<head>
        <meta charset="utf-8" />
        <title>Add Customer - ${initParam.company_name}</title>
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
                                    <li class="breadcrumb-item"><a href="#">Vehicle</a></li>
                                    <li class="breadcrumb-item"><a href="#">New Vehicle</a></li>
                                </ol>
                            </div>
                            <c:choose>
                            	<c:when test="${param.action=='update'}">
                            		<h4 class="page-title">Update Vehicle</h4>
                            	</c:when>
                            	<c:otherwise>
                            		<h4 class="page-title">New Vehicle</h4>
                            	</c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
                <!-- end page title end breadcrumb -->
                 <div class="row">
                    <div class="col-sm-4">
                        <a href="VehicleList.jsp" class="btn btn-custom waves-effect waves-light mb-4"  data-overlayColor="#36404a"><i class="mdi mdi-plus"></i> Vehicle List</a>
                    </div><!-- end col -->
                </div>
                <!-- end row -->
                
                
                <c:choose>
                	<c:when test="${param.action=='update'}">
                		<sql:query var="vehicle" dataSource="jdbc/rmc">
                			select * from vehicle where vehicle_no=?
                			<sql:param value="${param.vehicle_no}"/>
                		</sql:query>
                		<c:forEach var="vehicle" items="${vehicle.rows}">
                		<div class="row">
		                    <div class="col-sm-12">
		                    	<form class="" action="VehicleController?button=update" method="post">
			                        <div class="card-box row col-sm-12">
			                        	<div class="row col-sm-12">
			                        		<div class="col-sm-3"></div>
			                        		<div class="col-sm-6">
			                        			<h3 class="text-success text-center"><ins>Update Vehicle ${param.vehicle_no}</ins></h3>
			                        		</div>
			                        	</div>
			                           	<div class="col-sm-6">
			                               	<div class="form-group">
			                                    <label>Vehicle No<span class="text-danger">*</span> </label>
			                                    <input type="text" class="form-control" required
			                                          pattern="[^'&quot;:]*$" placeholder="Enter Vehicle No." readonly="readonly" value="${vehicle.vehicle_no}" id="vehicle_no" name="vehicle_no"/>
			                                </div>
			                                
			                                <div class="form-group">
			                                    <label>Vehicle Name<span class="text-danger">*</span> </label>
			                                    <input type="text" class="form-control" required
			                                         pattern="[^'&quot;:]*$" value="${vehicle.vehicle_name}"  placeholder="EX : Transit Mixer"  id="vehicle_name" name="vehicle_name"/>
			                                </div>
			                                
			                                <div class="form-group">
                                                <label>Insurance Validity : </label>
                                                <div>
                                                    <div class="input-group">
                                                        <input type="text" name="insurance_valid_till" value="${vehicle.insurance_valid_till}" class="form-control date-picker" placeholder="mm/dd/yyyy" id="id-date-picker-1" data-date-format="yyyy-mm-dd">
                                                        <div class="input-group-append">
                                                            <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
			                                
			                                <div class="form-group">
			                                    <label>Insurance No : </label>
												<input type="text" class="form-control" 
			                                          pattern="[^'&quot;:]*$" placeholder="Enter Vehicle Insurance No.." value="${vehicle.insurance_no}" id="insurance_no" name="insurance_no"/>
			                                </div>
			                                
			                                <div class="form-group">
			                                    <label>Meter Reading : </label>
												<input type="number" step="0.01" class="form-control" 
			                                          pattern="[^'&quot;:]*$" value="${vehicle.meter_reading}" placeholder="Enter Meter Reading" id="meter_reading" name="meter_reading"/>
			                                </div>
			
			                               </div>
			                               <div class="col-sm-6">
			                                <div class="form-group">
			                                    <label>Vehicle Type : </label>
												<select id="vehicle_type"  name="vehicle_type"   class="select2"  data-placeholder="Select Vehicle Type">
													<option value="own" ${(vehicle.vehicle_type=='own')?'selected':''}>Own Vehicle</option>
													<option value="rental">Rental Vehicle</option>
												</select>
			                                 </div>
			                                 
			                                 <div class="form-group">
			                                    <label>Vehicle Category : </label>
												<select id="vehicle_cat"  name="vehicle_cat"   class="select2"  data-placeholder="Select Vehicle Type">
													<option value="km" ${(vehicle.vehicle_cat=='km')?'selected':''}>KM Basis</option>
													<option value="hour" ${(vehicle.vehicle_cat=='hour')?'selected':''}>Hourly Basis</option>									
												</select>
			                                 </div>
			                                 
			                                 <div class="form-group">
			                                    <label>Vehicle Driver : </label>
			                                    <%pageContext.setAttribute("driver", new DriverDAOImpl().getAllDriverList());%>
												<select id="cust_status"  name="cust_status"   class="select2"  data-placeholder="Choose Driver.">
													<c:forEach var="driver" items="${driver}">
														<option value="${driver.driver_name}" ${(driver.driver_name==vehicle.driver_name)?'selected':''}>${driver.driver_name}</option>
													</c:forEach>
												</select>
			                                 </div>
			                                
			                                <div class="form-group">
                                                <label>FC Date : </label>
                                                <div>
                                                    <div class="input-group">
                                                        <input type="text" name="fc_date" value="${vehicle.fc_date}"  class="form-control date-picker" placeholder="yyyy-mm-dd" id="id-date-picker-1" data-date-format="yyyy-mm-dd">
                                                        <div class="input-group-append">
                                                            <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
			                                
			                               <div class="form-group">
                                                <label>Tax Date : </label>
                                                <div>
                                                    <div class="input-group">
                                                        <input type="text" name="tax_date" value="${vehicle.tax_date}"  class="form-control date-picker" placeholder="yyyy-mm-dd" id="id-date-picker-1" data-date-format="yyyy-mm-dd">
                                                        <div class="input-group-append">
                                                            <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group">
			                                    <label>Vehicle Weight : </label>
												<input type="number" step="0.01" class="form-control" 
			                                          pattern="[^'&quot;:]*$" placeholder="Enter Vehicle Weight.." value="${vehicle.vehicle_weight}" id="vehicle_weight" name="vehicle_weight"/>
			                                </div>
			                                <div class="form-group">
			                                	&nbsp;&nbsp;&nbsp;<br><br>
			                                </div>
			                                <div class="form-group">
			                                    <div>
			                                        <button type="submit" class="btn btn-custom waves-effect waves-light">
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
		                </c:forEach>
                	</c:when>
                	<c:otherwise>
                		<div class="row">
		                    <div class="col-sm-12">
		                    	<form class="" action="VehicleController?button=insert" method="post">
			                        <div class="card-box row col-sm-12">
			                        	<div class="row col-sm-12">
			                        		<div class="col-sm-3"></div>
			                        		<div class="col-sm-6">
			                        			<h3 class="text-success text-center"><ins>New Vehicle</ins></h3>
			                        		</div>
			                        	</div>
			                           	<div class="col-sm-6">
			                               	<div class="form-group">
			                                    <label>Vehicle No<span class="text-danger">*</span> </label>
			                                    <input type="text" class="form-control" required
			                                          pattern="[^'&quot;:]*$" placeholder="Enter Vehicle No." id="vehicle_no" name="vehicle_no"/>
			                                </div>
			                                
			                                <div class="form-group">
			                                    <label>Vehicle Name<span class="text-danger">*</span> </label>
			                                    <input type="text" class="form-control" required
			                                         pattern="[^'&quot;:]*$"  placeholder="EX : Transit Mixer"  id="vehicle_name" name="vehicle_name"/>
			                                </div>
			                                
			                                <div class="form-group">
                                                <label>Insurance Validity : </label>
                                                <div>
                                                    <div class="input-group">
                                                        <input type="text" name="insurance_valid_till"  class="form-control date-picker" placeholder="mm/dd/yyyy" id="id-date-picker-1" data-date-format="yyyy-mm-dd">
                                                        <div class="input-group-append">
                                                            <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
			                                
			                                <div class="form-group">
			                                    <label>Insurance No : </label>
												<input type="text" class="form-control" 
			                                          pattern="[^'&quot;:]*$" placeholder="Enter Vehicle Insurance No.." id="insurance_no" name="insurance_no"/>
			                                </div>
			                                
			                                <div class="form-group">
			                                    <label>Meter Reading : </label>
												<input type="number" step="0.01" class="form-control" 
			                                          pattern="[^'&quot;:]*$" placeholder="Enter Meter Reading" id="meter_reading" name="meter_reading"/>
			                                </div>
			
			                               </div>
			                               <div class="col-sm-6">
			                                <div class="form-group">
			                                    <label>Vehicle Type : </label>
												<select id="vehicle_type"  name="vehicle_type"   class="select2"  data-placeholder="Select Vehicle Type">
													<option value="own">Own Vehicle</option>
													<option value="rental">Rental Vehicle</option>
												</select>
			                                 </div>
			                                 
			                                 <div class="form-group">
			                                    <label>Vehicle Category : </label>
												<select id="vehicle_cat"  name="vehicle_cat"   class="select2"  data-placeholder="Select Vehicle Type">
													<option value="km">KM Basis</option>
													<option value="hour">Hourly Basis</option>									
												</select>
			                                 </div>
			                                 
			                                 <div class="form-group">
			                                    <label>Vehicle Driver : </label>
			                                    <%pageContext.setAttribute("driver", new DriverDAOImpl().getAllDriverList());%>
												<select id="cust_status"  name="cust_status"   class="select2"  data-placeholder="Choose Driver.">
													<c:forEach var="driver" items="${driver}">
														<option value="${driver.driver_name}">${driver.driver_name}</option>
													</c:forEach>
												</select>
			                                 </div>
			                                
			                                <div class="form-group">
                                                <label>FC Date : </label>
                                                <div>
                                                    <div class="input-group">
                                                        <input type="text" name="fc_date"  class="form-control date-picker" placeholder="yyyy-mm-dd" id="id-date-picker-1" data-date-format="yyyy-mm-dd">
                                                        <div class="input-group-append">
                                                            <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
			                                
			                               <div class="form-group">
                                                <label>Tax Date : </label>
                                                <div>
                                                    <div class="input-group">
                                                        <input type="text" name="tax_date"  class="form-control date-picker" placeholder="yyyy-mm-dd" id="id-date-picker-1" data-date-format="yyyy-mm-dd">
                                                        <div class="input-group-append">
                                                            <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group">
			                                    <label>Vehicle Weight : </label>
												<input type="number" step="0.01" class="form-control" 
			                                          pattern="[^'&quot;:]*$" placeholder="Enter Vehicle Weight.." id="vehicle_weight" name="vehicle_weight"/>
			                                </div>
			                                <div class="form-group">
			                                	&nbsp;&nbsp;&nbsp;<br><br>
			                                </div>
			                                <div class="form-group">
			                                    <div>
			                                        <button type="submit" class="btn btn-custom waves-effect waves-light">
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
                	</c:otherwise>
                </c:choose>
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
		<script src="picker/js/bootstrap-datetimepicker.min.js"></script>
		
        <script type="text/javascript">
            $(document).ready(function() {
                $('form').parsley();
                
                $('.select2').css('width','100%').select2({allowClear:true})
				.on('change', function(){
				}); 
                
                
                $('.date-picker').datepicker({
					autoclose: true,
					todayHighlight: true
				})
				//show datepicker when clicking on the icon
				
                
                $("#id-date-picker-1").datepicker("setDate", new Date());
				$('#id-date-picker-1').datepicker({
				        "setDate": new Date(),
				        "autoclose": true
				});
			
            });
        </script>
        
        <script type="text/javascript">
		 $(document).ready(function () {
			
		    function addRow(){
		    	
		        var html = '<tr class="item-row">'+
								'<td>'+
									'${itm_name}'+
								'</td>'+
								 '<td>'+
								      '<input type="text" name="item_price" class="item_price form-control reqired" size="12" onkeyup="calculate(this);">'+
							     '</td>'+
								'<td>'+
									'<input type="text" name="quantity" size="14" class="quantity form-control reqired" onkeyup="calculate(this);">'+
								'</td>'+
								'<td>'+
									'<input type="text" name="amount" size="16" class="amount form-control reqired" readonly>'+
								'</td>'+
								'<td>'+
								    '<input type="date" name="lead_time" class="form-control reqired">'+
							    '</td>'+
								'<td><a href="#" class="removebutton"><i class="fa fa-trash fa-2x text-danger"></i></a></td>'+
							'</tr>'
					        $(html).appendTo($("#Table1"))
					    };
					    $("#clicked").on("click", ".BtnPlus", addRow);
					});
			</script>
			
			<script type="text/javascript">
					 $(document).on('click', '.removebutton', function () { // <-- changes
					     $(this).closest('tr').remove();
					     return false;
					 });
			</script>
			
			<script type="text/javascript">
				$(document).ready(function(){
					$('.no-po').prop('disabled',true);
					
					/* check po is selected or not */
					
					$( ".po-check" ).click(function() {
				        if(this.checked){
				            $('.no-po').prop("disabled",false);
				            $(".req").prop('required',true);
				        }else{
				        	$('.no-po').prop("disabled",true);
				        	 $(".req").prop('required',false);
				        }
				    });
					
					/* calculation process goes here */
				});
			</script>

			<script>
			
				function calculate(e){
					 var quantity = $(e).closest('tr').find('.quantity').val();
					  quantity=(quantity=='' || quantity==undefined)?0:quantity;
				     var item_price = $(e).closest('tr').find('.item_price').val();
				      item_price=(item_price=='' || item_price==undefined)?0:item_price;
				     var amount = (quantity * item_price);
				     amount = Math.round(amount);
				     $(e).closest('.item-row').find('.amount').val(amount);
				}
			</script>
 		
    </body>
</html>