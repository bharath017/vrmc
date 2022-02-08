<%@ include file="Session.jsp" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<!DOCTYPE html>
<html>
<head>
        <meta charset="utf-8" />
        <title>Scheduling List</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
        <meta content="A fully featured admin theme which can be used to build CRM, CMS, etc." name="description" />
        <meta content="Coderthemes" name="author" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />

        <!-- App favicon -->
        <link rel="shortcut icon" href="../assets/images/favicon.ico">

        <!-- DataTables -->
        <link href="../plugins/datatables/dataTables.bootstrap4.min.css" rel="stylesheet" type="text/css" />
        <link href="../plugins/datatables/buttons.bootstrap4.min.css" rel="stylesheet" type="text/css" />
        <!-- Responsive datatable examples -->
        <link href="../plugins/datatables/responsive.bootstrap4.min.css" rel="stylesheet" type="text/css" />

        <!-- Multi Item Selection examples -->
        <link href="../plugins/datatables/select.bootstrap4.min.css" rel="stylesheet" type="text/css" />
		
		<link rel="stylesheet" href="../picker/cs/bootstrap-datepicker3.min.css" />
		<link rel="stylesheet" href="../picker/cs/bootstrap-timepicker.min.css" />
		
        <!-- App css -->
        <link href="../assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="../assets/css/icons.css" rel="stylesheet" type="text/css" />
        <link href="../assets/css2/style.css" rel="stylesheet" type="text/css" />
		  <!-- Custom box css -->
        <link href="../plugins/custombox/css/custombox.min.css" rel="stylesheet">
        <link rel="stylesheet" href="../assets/css/select2.min.css" />
		<link rel="stylesheet" href="../assets/css/render.css">
        <script src="../assets/js/modernizr.min.js"></script>
        <link href="../assets/jquery-toast/jquery.toast.min.css" rel="stylesheet" type="text/css" />
        <style type="text/css">
        	.hidden{
        		display: none;
        	}
        	
        	.tbll>thead>tr>th,.tbll>tbody>tr>th,.tbll>tfoot>tr>th,.tbll>thead>tr>td,.tbll>tbody>tr>td,.tbll>tfoot>tr>td{
	        	padding: 2px;	
	        }
	        
	        .tbl>thead>tr>th,.tbl>tbody>tr>th,.tbl>tfoot>tr>th,.tbl>thead>tr>td,.tbl>tbody>tr>td,.tbl>tfoot>tr>td{
	        	padding: 2px;	
	        }
        </style>
        
    </head>

    <body>

        <!-- Navigation Bar-->
        <!-- PUT HEADER.JSP HERE -->
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
                                    <li class="breadcrumb-item"><a href="#">Customer &amp; PO</a></li>
                                    <li class="breadcrumb-item active">Scheduling</li>
                                    <li class="breadcrumb-item active">Scheduling List</li>
                                </ol>
                            </div>
                            <h4 class="page-title">Scheduling List</h4>
                        </div>
                    </div>
                </div>
                <!-- end page title end breadcrumb -->
                <div class="row">
                	 <div class="col-xs-6 col-sm-3">
                          <div class="card-box widget-flat border-custom bg-custom text-white">
                              <i class=" fa fa-money"></i>
                              <h3 class="m-b-10" id="today">0</h3>
                              <p class="text-uppercase m-b-5 font-13 font-600">TODAY SCHEDULED QUANTITY</p>
                          </div>
                      </div>
                      <div class="col-xs-6 col-sm-3">
                          <div class="card-box bg-primary widget-flat border-primary text-white">
                              <i class="fi-archive"></i>
                              <h3 class="m-b-10" id="tomorrow">0</h3>
                              <p class="text-uppercase m-b-5 font-13 font-600">TOMORROW SCHEDULE QUANTITY</p>
                          </div>
                      </div>
                      
                      <!-- Get total customer payment details -->
                      
                      <div class="col-xs-6 col-sm-3">
                          <div class="card-box widget-flat border-success bg-success text-white">
                              <i class="fi-help"></i>
                              <h3 class="m-b-10" id="months">0</h3>
                              <p class="text-uppercase m-b-5 font-13 font-600">MONTHLY QUANTITY SCHEDULED</p>
                          </div>
                      </div>
                      
                      
                      <div class="col-xs-6 col-sm-3">
                          <div class="card-box  widget-flat border-danger text-white" style="background-color: #dd6413;">
                              <i class="fi-delete"></i>
                              <h3 class="m-b-10" id="monthi">0</h3>
                              <p class="text-uppercase m-b-5 font-13 font-600">MONTHLY PRODUCTION </p>
                          </div>
                      </div>
                </div>
                <!-- end row -->
                <form id="search-form">
				<div class="row filter-row">
                    <div class="col-sm-2 col-xs-6 form-group">
                        <label>Scheduling Date <span class="text-danger">*</span> </label>
                        <div>
                            <div class="input-group">
                                <input type="text" name="scheduling_date" class="form-control date-picker scheduling_date" placeholder="yyyy-mm-dd" id="id-date-picker-1" data-date-format="yyyy-mm-dd">
                                <div class="input-group-append picker">
                                    <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-2 col-xs-6">
                        <div class="form-group form-focus select-focus">
                            <label class="control-label">Choose Customer</label>
                            <sql:query var="customer" dataSource="jdbc/rmc">
                            	select customer_id,customer_name from test_customer where customer_status='active'
                            </sql:query>
                            <select class="select2 form-control floating" id="customer_id">
                                <option value="0">All Customer</option>
                                <c:forEach items="${customer.rows}" var="customer">
                                	<option value="${customer.customer_id}">${customer.customer_name}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    
                    <div class="col-sm-2 col-xs-6">
                        <div class="form-group form-focus select-focus">
                            <label class="control-label">Site</label>
                            <select class="form-control select2 floating"   id="site_id">
                                <option value="0">All Site</option>
                            </select>
                        </div>
                    </div>
                    
                    <div class="col-sm-1 col-xs-6">
                        <div class="form-group form-focus">
                            <label class="control-label">&nbsp;</label>
                            <a href="#" id="search" class="btn btn-success btn-block"> Search </a>
                        </div>
                    </div>
                    <div class="col-sm-1 col-xs-6">
                        <div class="form-group form-focus">
                            <label class="control-label">&nbsp;</label>
                            <a href="#" id="clear" class="btn btn-danger btn-block"> Clear </a>
                        </div>
                    </div>
                    <div class="col-sm-1 col-xs-6">
                        <div class="form-group form-focus">
                            <label class="control-label">&nbsp;</label>
                             <a href="AddScheduling.jsp" class="btn btn-custom waves-effect waves-light mb-4"  data-overlayColor="#36404a"><i class="mdi mdi-plus"></i> Add Scheduling</a>
                        </div>
                    </div>
                </div>
                </form>
                <div class="row">
                    <div class="col-12">
                        <div class="card-box table-responsive">
                        	<table id="example" class="table table-striped table-bordered table-condensed text-center tbl" cellspacing="0" width="100%">
                                <thead>
	                                <tr>
	                                	<th class="text-center">Schedule Date</th>
										<th class="center">
											Customer
										</th>
										<th class="text-center">Site Name</th>
										<th class="text-center">Start Time</th>
										<th class="text-center">End Time</th>
										<th class="text-center">Plant</th>
										<th class="text-center">Pump</th>
										<th class="text-center" style="width: 18%;">
											<table class="table table-condensed table-bordered table-white">
												<tr>
													<th>Grade</th>
													<th>Quantity</th>
												</tr>
											</table>
										</th>
										<th class="text-center">OPTION</th>
									</tr>
                                </thead>
                            </table>
                        </div>
                    </div>
                </div>
                <!-- end row -->


				 <!-- MODAL FOR PLANT DELETE START  -->
				<div id="delete-model" class="modal-demo col-xs-2">
		            <button type="button" class="close" onclick="Custombox.close();">
		                <span>&times;</span><span class="sr-only">Close</span>
		            </button>
		            <h4 class="custom-modal-title" style="color: white;background-color: #b70b22;">Are you sure want to delete this scheduling ?</h4>
		            <div class="custom-modal-text">
		                <form class="form-horizontal" action="../SchedulingControllerTest?action=DeleteScheduling" method="post">
		                	<input type="hidden" name="scheduling_id" id="scheduling_id_delete"/>
		                    <div class="form-group account-btn text-center m-t-2">
		                        <div class="col-12">
		                            <button class="btn w-lg btn-rounded btn-custom waves-effect waves-light" type="button" id="delete-button"><span class="change_status text-uppercase">Delete Scheduling</span></button>
		                            <button class="btn w-lg btn-rounded btn-custom btn-danger waves-effect waves-light"  onclick="Custombox.close();" type="button">Exit</button>
		                        </div>
		                    </div>
		                </form>
		            </div>
		        </div>
                <!--  PLANT DELETE MODAL END  -->
                
                
                 <!-- MODAL FOR VIEW INVOICE START  -->
				<div id="view-invoice-modal" class="modal-demo col-xs-2">
		            <button type="button" class="close" onclick="Custombox.close();">
		                <span>&times;</span><span class="sr-only">Close</span>
		            </button>
		            <h4 class="custom-modal-title bg-custom" style="color: white;">SCHEDULED INVOICE LIST</h4>
		            <div class="custom-modal-text">
		               <table class="table table-bordered tbll" id="invoice-list">
		               		<thead>
		               			<tr>
		               				<th>Invoice Id</th>
		               				<th>Grade</th>
		               				<th>Quantity</th>
		               				<th>Rate</th>
		               				<th>Net Amount</th>
		               			</tr>
		               		</thead>
		               		<tbody>
		               			
		               		</tbody>
		               		<tfoot class="text-right">
		               			<tr>
		               				<th colspan="4" class="text-right">Total Invoice Quantity :</th>
		               				<th id="tquantity" class="text-left"></th>
		               			</tr>
		               			<tr>
		               				<th colspan="4" class="text-right">Total Scheduled Quantity :</th>
		               				<th class="text-left" id="tschedule"></th>
		               			</tr>
		               			<tr>
		               				<th colspan="4" class="text-right">Quantity Left :</th>
		               				<th class="text-left" id="leftquant"></th>
		               			</tr>
		               		</tfoot>
		               </table>
		            </div>
		        </div>
                <!--  VIEW INVOICE MODAL END  -->
               
                 <!-- MODAL FOR VIEW INVOICE START  -->
				<div id="view-schedule-modal" class="modal-demo col-xs-2">
		            <button type="button" class="close" onclick="Custombox.close();">
		                <span>&times;</span><span class="sr-only">Close</span>
		            </button>
		            <h4 class="custom-modal-title bg-custom" style="color: white;">SCHEDULED INVOICE LIST</h4>
		            <div class="custom-modal-text">
		               <table class="table table-bordered tbll" id="invoice-list">
		               		<thead>
		               			<tr>
		               				<th>CUSTOMER</th>
		               				<th>SITE</th>
		               				<th>PUMP</th>
		               				<th>TIME</th>
		               				<th>QUANTITY DETAILS</th>
		               			</tr>
		               		</thead>
		               		<tbody>
		               			
		               		</tbody>
		               		<tfoot class="text-right">
		               			<tr>
		               				<th colspan="4" class="text-right">Total Invoice Quantity :</th>
		               				<th id="tquantity" class="text-left"></th>
		               			</tr>
		               			<tr>
		               				<th colspan="4" class="text-right">Total Scheduled Quantity :</th>
		               				<th class="text-left" id="tschedule"></th>
		               			</tr>
		               			<tr>
		               				<th colspan="4" class="text-right">Quantity Left :</th>
		               				<th class="text-left" id="leftquant"></th>
		               			</tr>
		               		</tfoot>
		               </table>
		            </div>
		        </div>
                <!--  VIEW INVOICE MODAL END  -->
                
                
                
                

            </div> <!-- end container -->
        </div>
        <!-- end wrapper -->


        <!-- Footer -->
        <!-- PUT FOOTER.JSP HERE -->
        <%@ include file="../footer.jsp" %>
        <!-- End Footer -->


        <!-- jQuery  -->
        <script src="../assets/js/jquery.min.js"></script>
        <script src="../assets/js/popper.min.js"></script>
        <script src="../assets/js/bootstrap.min.js"></script>
        <script src="../assets/js/waves.js"></script>
        <script src="../assets/js/jquery.slimscroll.js"></script>
        <script type="text/javascript" src="js/Scheduling/SchedulingList.js"></script>
         <script src="../assets/jquery-toast/jquery.toast.min.js"></script>

        <!-- Required datatable js -->
        <script src="../plugins/datatables/jquery.dataTables.min.js"></script>
        <script src="../plugins/datatables/dataTables.bootstrap4.min.js"></script>
        <!-- Buttons examples -->
        <script src="../plugins/datatables/dataTables.buttons.min.js"></script>
        <script src="../plugins/datatables/buttons.bootstrap4.min.js"></script>
        <script src="../plugins/datatables/pdfmake.min.js"></script>
        <script src="../plugins/datatables/vfs_fonts.js"></script>
        <script src="../plugins/datatables/buttons.html5.min.js"></script>
        <script src="../plugins/datatables/buttons.print.min.js"></script>
        <script src="../assets/js/select2.min.js"></script>
		<script src="../picker/js/bootstrap-datepicker.min.js"></script>
		<script src="../assets/js/bootstrap-timepicker.min.js"></script>
		<script src="../picker/js/moment.min.js"></script>
        <!-- Key Tables -->
        <script src="../plugins/datatables/dataTables.keyTable.min.js"></script>
        <!-- Responsive examples -->
        <script src="../plugins/datatables/dataTables.responsive.min.js"></script>
        <script src="../plugins/datatables/responsive.bootstrap4.min.js"></script>

        <!-- Selection table -->
        <script src="../plugins/datatables/dataTables.select.min.js"></script>
        <!-- App js -->
        <script src="../assets/js/jquery.core.js"></script>
        <script src="../assets/js/jquery.app.js"></script>
        <!-- Modal-Effect -->
        <script src="../plugins/custombox/js/custombox.min.js"></script>
        <script src="../plugins/custombox/js/legacy.min.js"></script>
    </body>
</html>