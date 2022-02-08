<%@ include file="Session.jsp" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<!DOCTYPE html>
<html>
<head>
        <meta charset="utf-8" />
        <title>Scada Batching List</title>
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
		
		<link rel="stylesheet" href="picker/cs/bootstrap-datepicker3.min.css" />
		<link rel="stylesheet" href="picker/cs/bootstrap-timepicker.min.css" />
		
        <!-- App css -->
        <link href="assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/icons.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/style.css" rel="stylesheet" type="text/css" />
		  <!-- Custom box css -->
        <link href="plugins/custombox/css/custombox.min.css" rel="stylesheet">
        <link rel="stylesheet" href="assets/css/select2.min.css" />
		<link rel="stylesheet" href="assets/css/render.css">
		<link href="assets/jquery-toast/jquery.toast.min.css" rel="stylesheet" type="text/css" />
        <script src="assets/js/modernizr.min.js"></script>
        <style type="text/css">
        	.hidden{
        		display: none;
        	}
        	div.dt-buttons {
			    float: right;
			}
			
			.error{
				color: red;
			}
			
			.tbl>thead>tr>th,.tbl>tbody>tr>th,.tbl>tfoot>tr>th,.tbl>thead>tr>td,.tbl>tbody>tr>td,.tbl>tfoot>tr>td{
				padding: 2px;
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
                                    <li class="breadcrumb-item"><a href="#">qc</a></li>
                                    <li class="breadcrumb-item active">Batching List</li>
                                </ol>
                            </div>
                            <h4 class="page-title">BATCHING LIST</h4>
                        </div>
                    </div>
                </div>
                <!-- end page title end breadcrumb -->
				
				<div class="row text-center" id="view-cons">
					<div class="col-xs-8 col-sm-1 text-center">
						<div
							class="card-box widget-flat border-custom bg-custom text-white">
							<i class=" fa fa-hourglass-end"></i>
							<h5 class="m-b-10 count">0</h5>
							<p class="text-uppercase m-b-5 font-13 font-600">TBATCH</p>
						</div>
					</div>
					<div class="col-xs-8 col-sm-1 text-center">
						<div
							class="card-box widget-flat border-custom bg-custom text-white">
							<i class=" fa fa-hourglass-end"></i>
							<h5 class="m-b-10 rsand">0</h5>
							<p class="text-uppercase m-b-5 font-13 font-600">RSAND</p>
						</div>
					</div>
					<div class="col-xs-8 col-sm-1 text-center">
						<div
							class="card-box widget-flat border-custom bg-custom text-white">
							<i class=" fa fa-hourglass-end"></i>
							<h5 class="m-b-10 crusher">0</h5>
							<p class="text-uppercase m-b-5 font-13 font-600">CRUSHER</p>
						</div>
					</div>
					<div class="col-xs-8 col-sm-1 text-center">
						<div
							class="card-box widget-flat border-custom bg-custom text-white">
							<i class=" fa fa-hourglass-end"></i>
							<h5 class="m-b-10 20mm">0</h5>
							<p class="text-uppercase m-b-5 font-13 font-600">20MM</p>
						</div>
					</div>
					<div class="col-xs-8 col-sm-1 text-center">
						<div
							class="card-box widget-flat border-custom bg-custom text-white">
							<i class=" fa fa-hourglass-end"></i>
							<h5 class="m-b-10 10mm">0</h5>
							<p class="text-uppercase m-b-5 font-13 font-600">10MM</p>
						</div>
					</div>
					<div class="col-xs-8 col-sm-1 text-center">
						<div
							class="card-box widget-flat border-custom bg-custom text-white">
							<i class=" fa fa-hourglass-end"></i>
							<h5 class="m-b-10 cem1">0</h5>
							<p class="text-uppercase m-b-5 font-13 font-600">CEM1</p>
						</div>
					</div>
					<div class="col-xs-8 col-sm-1 text-center">
						<div
							class="card-box widget-flat border-custom bg-custom text-white">
							<i class=" fa fa-hourglass-end"></i>
							<h5 class="m-b-10 cem2">0</h5>
							<p class="text-uppercase m-b-5 font-13 font-600">CEM2</p>
						</div>
					</div>
					<div class="col-xs-8 col-sm-1 text-center">
						<div
							class="card-box widget-flat border-custom bg-custom text-white">
							<i class=" fa fa-hourglass-end"></i>
							<h5 class="m-b-10 flyash">0</h5>
							<p class="text-uppercase m-b-5 font-13 font-600">FLYASH</p>
						</div>
					</div>
					<div class="col-xs-8 col-sm-1 text-center">
						<div
							class="card-box widget-flat border-custom bg-custom text-white">
							<i class=" fa fa-hourglass-end"></i>
							<h5 class="m-b-10 add1">0</h5>
							<p class="text-uppercase m-b-5 font-13 font-600">ADDITIVE1</p>
						</div>
					</div>
					<div class="col-xs-8 col-sm-1 text-center">
						<div
							class="card-box widget-flat border-custom bg-custom text-white">
							<i class=" fa fa-hourglass-end"></i>
							<h5 class="m-b-10 add2">0</h5>
							<p class="text-uppercase m-b-5 font-13 font-600">ADDITIVE2</p>
						</div>
					</div>
					<div class="col-xs-8 col-sm-1 text-center">
						<div
							class="card-box widget-flat border-custom bg-custom text-white">
							<i class=" fa fa-hourglass-end"></i>
							<h5 class="m-b-10 water">0</h5>
							<p class="text-uppercase m-b-5 font-13 font-600">WATER</p>
						</div>
					</div>
					<div class="col-xs-8 col-sm-1 text-center">
						<div
							class="card-box widget-flat border-custom bg-custom text-white">
							<i class=" fa fa-hourglass-end"></i>
							<h5 class="m-b-10 total">0</h5>
							<p class="text-uppercase m-b-5 font-13 font-600">TOTAL</p>
						</div>
					</div>
			  </div>
				
				<div class="row">
					<div class="col-sm-12">
						<form id="clear-form">
							<div class="row filter-row">
								<div class="col-sm-2 col-xs-6 form-group">
			                        <label> From Date : </label>
			                        <div>
			                            <div class="input-group">
			                            	<input type="hidden" id="cash_id" value=""/>
			                            	<input type="hidden" id="plant_id" value="0"/>
			                            	 
			                                <input type="text" name="from_date" id="from_date" class="form-control date-picker " placeholder="yyyy-mm-dd" id="id-date-picker-1" data-date-format="yyyy-mm-dd">
			                                <div class="input-group-append picker">
			                                    <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
			                                </div>
			                            </div>
			                        </div>
			                    </div>
			                    
			                    <div class="col-sm-2 col-xs-6 form-group">
			                        <label>To Date : </label>
			                        <div>
			                            <div class="input-group">
			                                <input type="text" name="to_date" id="to_date" class="form-control date-picker " placeholder="yyyy-mm-dd" id="id-date-picker-1" data-date-format="yyyy-mm-dd">
			                                <div class="input-group-append picker">
			                                    <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
			                                </div>
			                            </div>
			                        </div>
			                    </div>
			                    
			                    <div class="col-sm-2 col-xs-6">
			                        <div class="form-group form-focus select-focus">
			                            <label class="control-label">Customer : </label>
			                            <select class="select2 form-control floating" id="customer_name">
			                                <option value="">All Customer</option>
			                            </select>
			                        </div>
			                    </div>
			                    
			                    <div class="col-sm-2 col-xs-6">
			                        <div class="form-group form-focus">
			                            <label class="control-label">&nbsp;</label>
			                            <a  id="search" class="btn btn-success btn-block"> Search </a>
			                        </div>
			                    </div>
			                    
			                    <div class="col-sm-2 col-xs-6">
			                        <div class="form-group form-focus">
			                            <label class="control-label">&nbsp;</label>
			                            <a  id="clear" class="btn btn-danger btn-block"> Clear </a>
			                        </div>
			                    </div>
			                </div>
			                </form>
			                <div class="row">
			                    <div class="col-12">
			                        <div class="card-box table-responsive">
			                            <span class="text-warning pull-right" style="font-weight: bold;" data-toggle="modal" data-target="#exampleModalCenter">TOTAL BATCHING LIST</span>
			                            <table id="example" class="table table-striped table-bordered table-condensed text-center" cellspacing="0" width="100%">
			                                <thead>
				                                <tr>
													<th class="center">
														 BATCH ID
													</th>
													<th class="text-center">BATCH NO</th>
													<th class="text-center">NO OF BATCH</th>
													<th class="text-center">CUSTOMER</th>
													<th class="text-center">GRADE</th>
													<th class="text-center">SITE</th>
													<th class="text-center">VEHICLE NO</th>
													<th class="text-center">DATE</th>
													<th class="text-center">TOTAL BATCHED</th>
													<th class="text-center">OPTION</th>
												</tr>
			                                </thead>
			                            </table>
			                        </div>
			                    </div>
			                </div>
					</div>
				</div>
                <!-- end row -->
            </div> <!-- end container -->
        </div>
        <!-- end wrapper -->
        
        <!-- Modal -->
		<div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
		  <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
		    <div class="modal-content">
		      <div class="modal-header">
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		          <span aria-hidden="true">&times;</span>
		        </button>
		      </div>
		      <div class="modal-body">
		       		<table class="table table-bordered tbl" id="batch-tbl">
		       			<thead>
		       				<tr>
			       				<th class="text-center" colspan="12"><h3>TRIP REPORT</h3></th>
			       			</tr>
			       			<tr class="text-center">
			       				<th colspan="6">CUSTOMER DETAIL</th>
			       				<th colspan="6">TRIP DETAIL</th>
			       			</tr>
			       			<tr>
			       				<th colspan="3">CUSTOMER</th>
			       				<th colspan="3" id="customer"></th>
			       				<th colspan="3">TRIP NO</th>
			       				<th colspan="3" id="tripno"></th>
			       			</tr>
			       			<tr>
			       				<th colspan="3">SITE</th>
			       				<th colspan="3" id="site"></th>
			       				<th colspan="3">TRIP DATE</th>
			       				<th colspan="3" id="tripdate"></th>
			       			</tr>
			       			<tr>
			       				<th colspan="3">TRUCK</th>
			       				<th colspan="3" id="truck"></th>
			       				<th colspan="3">SET BATCHES</th>
			       				<th colspan="3" id="setbatches"></th>
			       			</tr>
			       			<tr>
			       				<th colspan="3">RECIPE</th>
			       				<th colspan="3" id="recipe"></th>
			       				<th colspan="3">ACT BATCHES</th>
			       				<th colspan="3" id="actbatches"></th>
			       			</tr>
			       			<tr>
			       				<th>BATCH NO</th>
			       				<td id="agg1"></td>
			       				<td id="agg2"></td>
			       				<td id="agg3"></td>
			       				<td id="agg4"></td>
			       				<td id="agg5"></td>
			       				<td id="agg6"></td>
			       				<td id="agg7"></td>
			       				<td id="agg8"></td>
			       				<td id="agg9"></td>
			       				<td id="agg10"></td>
			       				<td>Total</td>
			       			</tr>
		       			</thead>
		       			<tbody>
		       				
		       			</tbody>
		       			<tfoot>
		       				<tr>
		       					<th>Total</th>
		       					<td id="total1"></td>
		       					<td id="total2"></td>
		       					<td id="total3"></td>
		       					<td id="total4"></td>
		       					<td id="total5"></td>
		       					<td id="total6"></td>
		       					<td id="total7"></td>
		       					<td id="total8"></td>
		       					<td id="total9"></td>
		       					<td id="total10"></td>
		       					<td id="totalmain"></td>
		       				</tr>
		       				<tr>
		       					<th>Total</th>
		       					<td id="set1"></td>
		       					<td id="set2"></td>
		       					<td id="set3"></td>
		       					<td id="set4"></td>
		       					<td id="set5"></td>
		       					<td id="set6"></td>
		       					<td id="set7"></td>
		       					<td id="set8"></td>
		       					<td id="set9"></td>
		       					<td id="set10"></td>
		       					<td id="setmain"></td>
		       				</tr>
		       			</tfoot>
		       		</table>
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
		      </div>
		    </div>
		  </div>
		</div>


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
        <script type="text/javascript" src="js/ScadaBatchingList.js"></script>

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
		<script src="picker/js/bootstrap-datepicker.min.js"></script>
		<script src="assets/js/bootstrap-timepicker.min.js"></script>
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
        
        <!-- Modal-Effect -->
        <script src="plugins/custombox/js/custombox.min.js"></script>
        <script src="plugins/custombox/js/legacy.min.js"></script>
        <script type="text/javascript" src="validation/jquery.validate.js"></script>
    </body>
</html>