<!DOCTYPE html>
<%@ include file="Session.jsp" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<html>
    
<!-- Mirrored from coderthemes.com/highdmin/horizontal/form-validation.html by HTTrack Website Copier/3.x [XR&CO'2014], Sun, 18 Mar 2018 15:57:25 GMT -->
<head>
        <meta charset="utf-8" />
        <title>Add Service Details - ${initParam.company_name}</title>
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
								<li class="breadcrumb-item"><a href="#">Vehicle Repair</a></li>
										                                       
							</ol>
						</div>
						
					</div>
				</div>
			</div>
			
			<div class="row">
					 <div class="col-sm-4">
                        <a href="VehicleRepairList.jsp" class="btn btn-custom waves-effect waves-light mb-4"  data-overlayColor="#36404a"><i class="mdi mdi-plus"></i>Vehicle Repair List</a>
                    </div>
             </div>
             
			<div class="row">
				<div class="col-sm-12">
					
							<form action="RepairController?action=InsertRepair" method="post" id="service-form">
							<div class="card-box row col-sm-12">
							<div class="col-sm-6">
							
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
                                    <label>Vehicle No <span class="text-danger">*</span></label>
                                    <sql:query var="vehicle" dataSource="jdbc/rmc">
                                    	select * from vehicle
                                    </sql:query>
									<select id="vehicle_no"  name="vehicle_no"   class="select2"  data-placeholder="Choose Vehicle">
										<option value="">&nbsp;</option>
										<c:forEach var="vehicle" items="${vehicle.rows}">
										<option value="${vehicle.vehicle_no}">${vehicle.vehicle_no}</option>
										</c:forEach>
									</select>
									<label id="vehicle_no-error" class="error" for="vehicle_no"></label>
                                </div>
                                
								<div class="form-group">
                                       <label>Date <span class="text-danger"></span> </label>
                                      
                                           <div class="input-group">
                                               <input type="text" name="repair_date"   class="form-control date-picker repair_date"  placeholder="yyyy-mm-dd" id="id-date-picker-1" data-date-format="yyyy-mm-dd">
                                               <div class="input-group-append">
                                                   <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
                                               </div>
                                           </div>
                                </div>
                              
								
                                
                                <div class="form-group">
                                    <label>Time <span class="text-danger">*</span> </label>
                                    <div>
                                        <div class="input-group">
                                            <input type="text" name="repair_time"  class="form-control"  placeholder="HH:MM:SS" id="timepicker1" data-date-format="yyyy-mm-dd">
                                            <div class="input-group-append">
                                                <span class="input-group-text"><i class="fa fa-clock-o"></i></span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                
                                
                                <div class="form-group">
                                    <label>Vendor<span class="text-danger">*</span> </label>
                                    <div>
                                       <input type="text" class="form-control" 
                                          placeholder="Enter Vendor Name"   id="vendor" name="vendor"/>
                                    </div>
	                            </div>
                                   
                              
                                <div class="form-group">
                                    <label>Received Person <span class="text-danger">*</span> </label>
                                    <div>
                                        <div>
                                       <input type="text" class="form-control" 
                                          placeholder="Enter Received Person's Name"   id="received_person" name="received_person"/>
                                    </div>
                                    </div>
                                </div>
                                
                          </div>
                          
                           <div class="col-sm-6">
                           
                         		 <div class="form-group">
                                    <label>Place<span class="text-danger">*</span> </label>
                                    <div>
                                       <input type="text" class="form-control" 
                                          placeholder="Enter  Place"   id="place" name="place"/>
                                    </div>
	                            </div>
                           
	                            <div class="form-group">
                                    <label>Repair Cost<span class="text-danger">*</span> </label>
                                    <div>
                                       <input type="text" class="form-control" 
                                          placeholder="Enter Repair Cost in Rs"   id="repair_cost" name="repair_cost"/>
                                    </div>
	                            </div>
                               
                            
                            
                                
                                <div class="form-group">
                                    <label>Description <span class="text-danger">*</span> </label>
                                    <div>
                                        <div class="input-group">
                                           <textarea class="form-control" name="description" ></textarea>
                                            
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="form-group">
                                    <label>Remarks <span class="text-danger">*</span> </label>
                                    <div>
                                        <div class="input-group">
                                           <textarea class="form-control" name="remarks" ></textarea>
                                            
                                        </div>
                                    </div>
                                </div>
                             </div>
                             <div class="col-sm-12 text-center">
                               	<div class="form-group">
                                    <div>
                                        <button type="submit"  class="btn btn-custom waves-effect waves-light">
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