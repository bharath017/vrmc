<!DOCTYPE html>
<%@ include file="Session.jsp" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<html>
    
<!-- Mirrored from coderthemes.com/highdmin/horizontal/form-validation.html by HTTrack Website Copier/3.x [XR&CO'2014], Sun, 18 Mar 2018 15:57:25 GMT -->
<head>
        <meta charset="utf-8" />
        <title>Add  Consumption - ${initParam.company_name}</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
        <meta content="A fully featured admin theme which can be used to build CRM, CMS, etc." name="description" />
        <meta content="Coderthemes" name="author" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />

        <!-- App favicon -->
        <link rel="shortcut icon" href="assets/images/favicon.ico">
		<link rel="stylesheet" href="picker/cs/bootstrap-datepicker3.min.css" />
		<link rel="stylesheet" href="picker/cs/bootstrap-timepicker.min.css" />
		
		
        <!-- DataTables -->
        <link href="plugins/datatables/dataTables.bootstrap4.min.css" rel="stylesheet" type="text/css" />
        <link href="plugins/datatables/buttons.bootstrap4.min.css" rel="stylesheet" type="text/css" />
        <!-- Responsive datatable examples -->
        <link href="plugins/datatables/responsive.bootstrap4.min.css" rel="stylesheet" type="text/css" />

        <!-- Multi Item Selection examples -->
        <link href="plugins/datatables/select.bootstrap4.min.css" rel="stylesheet" type="text/css" />
        <!-- App css -->
        <link href="plugins/custombox/css/custombox.min.css" rel="stylesheet">
        <link href="assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/icons.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/style.css" rel="stylesheet" type="text/css" />
        <link rel="stylesheet" href="assets/css/select2.min.css" />
		<link rel="stylesheet" href="assets/css/render.css">
        <script src="assets/js/modernizr.min.js"></script>
        <style type="text/css">
        	.error{
        		color: red;
        	}
        </style>

    </head>

    <body>

        <!-- Navigation Bar-->
        	<%@ include file="header.jsp" %>
        <!-- End Navigation Bar-->


	<div class="wrapper">
		<div class="container-fluid">
			<div class="row">
				<div class="col-sm-12">
					<div class="page-title-box">
						<div class="btn-group pull-right">
							<ol class="breadcrumb hide-phone p-0 m-0">
								<li class="breadcrumb-item"><a href="#">Home</a></li>
								<li class="breadcrumb-item"><a href="#">Vehicle</a></li>
								<li class="breadcrumb-item"><a href="#">Diesel Consumption</a></li>
										                                       
							</ol>
						</div>
						<c:choose>
							<c:when test="${param.action=='update'}">
								<h4 class="page-title">UPDATE DIESEL CONSUMPTION</h4>
							</c:when>
							<c:otherwise>
								<h4 class="page-title">ADD DIESEL CONSUMPTION</h4>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-sm-12 row">
					<div class="col-sm-8">
							<form action="DieselConsumptionController?action=InsertConsumption" method="post" id="consumption-form">
							<div class="card-box row col-sm-12">
								<div class="form-group col-sm-10">
                                       <label>Issued Date <span class="text-danger"></span> </label>
                                       <div>
                                           <div class="input-group">
                                               <input type="text" name="issued_date"  value="${invento.date}" class="form-control date-picker issued_date"  placeholder="yyyy-mm-dd" id="id-date-picker-1" data-date-format="yyyy-mm-dd">
                                               <div class="input-group-append">
                                                   <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
                                               </div>
                                           </div>
                                       </div>
                                </div>
                                <div class="form-group col-sm-10">
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
								<div class="form-group col-sm-10">
                                    <label>Vehicle No <span class="text-danger">*</span></label>
                                    <sql:query var="vehicle" dataSource="jdbc/rmc">
                                    	select * from vehicle
                                    </sql:query>
									<select id="vehicle_no"  name="vehicle_no"   class="select2"  data-placeholder="Choose Vehicle">
										<option value="">&nbsp;</option>
										<c:forEach var="vehicle" items="${vehicle.rows}">
										<option value="${vehicle.vehicle_no}" ${(vehicle.vehicle_no==vehicle_no)?'selected':''}>${vehicle.vehicle_no}</option>
										</c:forEach>
									</select>
									<label id="vehicle_no-error" class="error" for="vehicle_no"></label>
                                </div>
                                
                                <div class="form-group col-sm-10">
                                    <label>Issued Time <span class="text-danger">*</span> </label>
                                    <div>
                                        <div class="input-group">
                                            <input type="text" name="issued_time"  class="form-control"  placeholder="HH:MM:SS" id="timepicker1" data-date-format="yyyy-mm-dd">
                                            <div class="input-group-append">
                                                <span class="input-group-text"><i class="fa fa-clock-o"></i></span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="form-group col-sm-10">
                                    <label>Issued Quantity<span class="text-danger">*</span> </label>
                                    <div>
                                       <input type="text" class="form-control" 
                                          placeholder="Enter Quantity In Litre"   id="issued_quantity" name="issued_quantity"/>
                                    </div>
	                            </div>
	                            
	                            <div class="form-group col-sm-10">
	                            	<label for="type">Type</label>
	                            	<select class="form-control" name="type">
	                            		<option value="diesel">Diesel</option>
	                            		<option value="oil">Oil</option>
	                            	</select>
	                            </div>
	                            
	                            <div class="form-group col-sm-10">
                                    <label>Opening KM/HOUR<span class="text-danger">*</span> </label>
                                    <div>
                                       <input type="text" class="form-control" 
                                           placeholder="Enter Opening KM/HOUR" id="opening_km" readonly name="opening_km"/>
                                    </div>
	                            </div>
	                            
	                            <div class="form-group col-sm-10">
                                    <label>Closing KM/HOUR<span class="text-danger">*</span> </label>
                                    <div>
                                       <input type="text" class="form-control" 
                                           placeholder="Enter Closing KM/HOUR"  id="closing_km" name="closing_km"/>
                                    </div>
	                            </div>
	                            
	                            <div class="form-group col-sm-10">
                                    <label>Driver : </label>
                                    <sql:query var="driver" dataSource="jdbc/rmc">
                                    	select * from driver
                                    </sql:query>
									<select id="driver_name"  name="driver_name"  class="select2"  data-placeholder="Choose Driver">
										<option value="">&nbsp;</option>
										<c:forEach var="driver" items="${driver.rows}">
										<option value="${driver.driver_name}">${driver.driver_name}</option>
										</c:forEach>
									</select>
                                </div>
                                
                                <div class="form-group col-sm-10">
                                    <label>Issued Person</label>
                                    <div>
                                       <input type="text" class="form-control" 
                                         pattern="[^'&quot;:]*$"   placeholder="Enter Issued Person Name"   id="issued_person" name="issued_person"/>
                                    </div>
	                            </div>
                                
                                 <div class="form-group col-sm-10">
                                 	<sql:query var="diesel" dataSource="jdbc/rmc">
		                        		select diesel_id from general_setting
		                        	</sql:query>
		                        	<c:forEach var="diesel" items="${diesel.rows}">
		                        		<c:set value="${diesel}" var="dies"/>
		                        	</c:forEach>
		                        	
		                        	  <c:if test="${empty dies.diesel_id}">
		                        	  	<h3 class="text-danger">Please setup diesel in general setting</h3>
		                        	  </c:if>
			                          <div>
			                         	 <button  type="submit" class="btn btn-primary" ${(empty dies.diesel_id)?'disabled':''} id="saveBtn">Save Consumption</button>
                                   	  </div>
			                  </div>
							</div>
						</form>
					</div>
					
					<div class="col-sm-4">
						<table class="table table-striped table-bordered table-hover">
							<thead>
								<tr>
									<th colspan="2" class="text-center" style="background-color: #7cbdbf;color: white;width: 30%;">Vehicle With Consumption Detail's</th>
								</tr>
								<tr>
									<th class="col-xs-4" style="background-color: #7cbdbf;color: white;width: 30%;">Vehicle No:
									</th>
									<td id="vehicle_no_view"></td>
								</tr>
								<tr>
									<th style="background-color: #7cbdbf;color: white;" class="col-xs-4">Last Open KM : </th>
									<td id="opening_km_view"></td>
								</tr>
								<tr>
									<th class="col-xs-4" style="background-color: #7cbdbf;color: white;">Last Close KM :</th>
									<td id="closing_km_view"></td>
								</tr>
								<tr>
									<th style="background-color: #7cbdbf;color: white;">Last Mileage : </th>
									<td id="last_milage_view"></td>
								</tr>
								<tr>
									<th style="background-color: #7cbdbf;color: white;">This Mileage : </th>
									<td id="this_milage_view"></td>
								</tr>
							</thead>
						</table>
					</div>
				</div>
			</div>
			
			<div id="delete_diesel" class="modal">
				<div class="modal-dialog">
					<div class="modal-content">
						<form class="form-horizontal" action="DieselConsumptionController?button=delete_consumption_date" name="consumption_delete" id="validation-form" method="post">
							<div id="modal-wizard-container">
								<div class="modal-header" style="background-color: #BA1658;height:10%;">
									<h3 style="color:white;">DELETE THIS DISEL CONSUMPTION :  ${vehicle_no}</h3>
								</div>
								<div class="modal-body step-content">
										<input type="hidden" name="con_date_id" id="uu_con_date_id"/>
								</div>
							</div>
							<div class="modal-footer wizard-actions">

								<button class="btn btn-success btn-sm" id="btn_status" data-last="Finish">
									DELETE
									<i class="icon-on-right"></i>
								</button>

								<button class="btn btn-danger btn-sm pull-left" data-dismiss="modal">
									<i class="fa fa-times"></i>
									Cancel
								</button>
							</div>
						</form>
					</div>
				</div>
			</div><!-- PAGE CONTENT ENDS -->
			
		</div>
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
        <script src="assets/js/select2.min.js"></script>
		<script src="picker/js/bootstrap-datepicker.min.js"></script>
		<script src="assets/js/bootstrap-timepicker.min.js"></script>
		<script src="picker/js/moment.min.js"></script>
		<script type="text/javascript" src="js/AddPurchaseOrder.js"></script>
		<!-- Required datatable js -->
		<script src="plugins/custombox/js/custombox.min.js"></script>
        <script type="text/javascript" src="validation/jquery.validate.js"></script>
		<script type="text/javascript" src="js/dieselconsumption.js"></script>
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
				}).next().on('click', function(){
					$(this).prev().focus();
				});
			});
		</script>
</body>
</html>