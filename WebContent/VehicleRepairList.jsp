<%@ include file="Session.jsp" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<!DOCTYPE html>
<html>
<head>
        <meta charset="utf-8" />
        <title>Vehicle Service List</title>
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
                                    <li class="breadcrumb-item"><a href="#">Transport</a></li>
                                    <li class="breadcrumb-item active">Vehicle Repair</li>
                                    <li class="breadcrumb-item active">Vehicle Repair List</li>
                                </ol>
                            </div>
                            <h4 class="page-title">Recent Vehicle Repair</h4>
                        </div>
                    </div>
                </div>
                <!-- end page title end breadcrumb -->

                <div class="row">
                    <div class="col-sm-4">
                        <a href="AddRepair.jsp" class="btn btn-custom waves-effect waves-light mb-4"  data-overlayColor="#36404a"><i class="mdi mdi-plus"></i> Add Vehicle Repair Details</a>
                    </div><!-- end col -->
                </div>
                <!-- end row -->
				<div class="row filter-row">
					<div class="col-sm-3 col-xs-6">
                        <div class="form-group form-focus">
                            <label class="control-label">Gate Pass number</label>
                                <input class="form-control" placeholder="Enter Gate Pass Number" id="gp_no" type="text" name="gp_no">
                        </div>
                    </div>
                    <div class="col-sm-3 col-xs-6 form-group">
                        <label>Repair Date : </label>
                        <div>
                            <div class="input-group">
                                <input type="text" name="repair_date" class="form-control date-picker date" placeholder="yyyy-mm-dd" id="id-date-picker-1" data-date-format="yyyy-mm-dd">
                                <div class="input-group-append">
                                    <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-3 col-xs-6">
                        <div class="form-group form-focus select-focus">
                            <label class="control-label">Vehicle</label>
                            <sql:query var="vehicle" dataSource="jdbc/rmc">
                            	select * from vehicle
                            </sql:query>
                            <select class="select2 form-control floating" id="vehicle_no">
                                <option value="">All Vehicle</option>
                                <c:forEach items="${vehicle.rows}" var="vehicle">
                                	<option value="${vehicle.vehicle_no}">${vehicle.vehicle_no}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    
                    <div class="col-sm-2 col-xs-6">
                        <div class="form-group form-focus">
                            <label class="control-label">&nbsp;</label>
                            <a href="#" id="search" class="btn btn-success btn-block"> Search </a>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-12">
                        <div class="card-box table-responsive">
                            <h4 style="color: green;">${res}</h4>
                            <c:remove var="res"/>
                            <table id="example" class="table table-striped table-bordered table-condensed" cellspacing="0" width="100%">
                                <thead>
	                                <tr>
										<th class="center">
											Gate Pass No.
										</th>
										<th class="text-center">Vehicle No</th>
										<th class="text-center">Repair Date</th>
										<th class="text-center">Repair Time</th>
										<th class="text-center">Vendor</th>
										<th class="text-center">Place</th>
										<th class="text-center">Repair Cost</th>
										<th class="text-center">Description</th>
										<th class="text-center">Remarks</th>
										<th class="text-center">Plant</th>
										<th class="text-center">OPTION</th>
									</tr>
                                </thead>
                                <c:set value="${(empty param.repair_date)?'':param.repair_date}" var="repair_date"/>
                                <c:set value="${(empty param.vehicle_no)?'':param.vehicle_no}" var="vehicle_no"/>
                                <c:set value="${(empty param.gp_no)?0:param.gp_no}" var="gp_no"/>
								<sql:query var="diesel" dataSource="jdbc/rmc">
									select d.*,p.plant_name,DATE_FORMAT(d.repair_date,'%d/%m/%Y') as repair_date from repair d,plant p
									where d.plant_id=p.plant_id
									and vehicle_no like if(''=?,'%%',?)
									and repair_date like if(''=?,'%%',?)
									and d.plant_id like if(0=?,'%%',?)
									and d.gp_no like if(0=?,'%%',?)
									order by gp_no desc
									limit 100
									<sql:param value="${vehicle_no}"/>
									<sql:param value="${vehicle_no}"/>
									<sql:param value="${repair_date}"/>
									<sql:param value="${repair_date}"/>
									<sql:param value="${bean.plant_id}"/>
									<sql:param value="${bean.plant_id}"/>
									<sql:param value="${gp_no}"/>
									<sql:param value="${gp_no}"/>
								</sql:query>
                                <tbody>
                                <c:forEach var="diesel" items="${diesel.rows}">
									<tr class="">
										<td class="text-center">${diesel.gp_no}</td>
										<td class="text-center">${diesel.vehicle_no}</td>
										<td class="text-center">${diesel.repair_date}</td>
										<td class="text-center">${diesel.repair_time}</td>
										<td class="text-center">${diesel.vendor}</td>
										<td class="text-center">${diesel.place}</td>
										<td class="text-center">${diesel.repair_cost}</td>
										<td class="text-center">${diesel.description}</td>
										<td class="text-center">${diesel.remarks}</td>
										<td class="text-center">${diesel.plant_name}</td>
										<td class="text-center">
											 <div class="btn-group dropdown">
	                                            <a href="javascript: void(0);" class="table-action-btn dropdown-toggle arrow-none btn btn-light btn-sm" data-toggle="dropdown" aria-expanded="false"><i class="mdi mdi-dots-horizontal"></i></a>
	                                            <div class="dropdown-menu dropdown-menu-right">
	                                                <span class="text-center text-success">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Repair ID : ${diesel.gp_no}</span>
	                                                <a class="dropdown-item" href="EditRepair.jsp?gp_no=${diesel.gp_no}"><i class="fa fa-edit mr-2 text-muted font-18 vertical-middle"></i>Edit Repair Details</a>
	                                                <a class="dropdown-item" href="#deleteinvoice-model" data-animation="blur" data-plugin="custommodal" onclick="deleteDiselConsumption('${diesel.gp_no}','${diesel.plant_id}')" data-overlaySpeed="100" data-overlayColor="#36404a"><i class="fa fa-trash mr-2 text-muted font-18 vertical-middle"></i>Delete</a>
	                                            </div>
	                                        </div>
										</td>
									</tr>
									</c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                <!-- end row -->
                
				
				<!-- MODAL FOR INVOICE DELETION  -->
				<div id="deleteinvoice-model" class="modal-demo col-xs-2">
		            <button type="button" class="close" onclick="Custombox.close();">
		                <span>&times;</span><span class="sr-only">Close</span>
		            </button>
		            <h4 class="custom-modal-title" style="color: white;background-color: #491136;">Are you sure want to delete Repair id : <span class="consumption_view"></span> </h4>
		            <div class="custom-modal-text">
		                <form class="form-horizontal" method="post" action="RepairController?action=DeleteRepair">
		                	<input type="hidden" name="gp_no" id="diesel_id_delete"/>
		                	<input type="hidden" name="plant_id" id="plant_id_delete"/>
		                	
		                    <div class="form-group account-btn text-center m-t-2">
		                        <div class="col-12">
		                            <button class="btn w-lg btn-rounded btn-custom waves-effect waves-light" type="submit">DELETE</button>
		                            <button class="btn w-lg btn-rounded btn-custom btn-danger waves-effect waves-light"  onclick="Custombox.close();" type="button">CLOSE</button>
		                        </div>
		                    </div>
		                </form>
		            </div>
		        </div>
                <!--  END OF INVOICE DELETION MODAL  -->
				
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
        $(document).ready(function() {
            $('.date-picker').datepicker({
   				autoclose: true,
   				todayHighlight: true
   		 	});
   			//show datepicker when clicking on the icon
          });
        </script>

        <script type="text/javascript">
            $(document).ready(function() {

                // Default Datatable
                $('#datatable').DataTable();

                //Buttons examples
                var table = $('#datatable-buttons').DataTable({
                    lengthChange: false,
                    buttons: ['copy', 'pdf','print']
                });

                // Key Tables

                $('#key-table').DataTable({
                    keys: true
                });
                
                $('#example').dataTable({
                    /* No ordering applied by DataTables during initialisation */
                    "order": []
                });

                // Responsive Datatable
                $('#responsive-datatable').DataTable();

                // Multi Selection Datatable
                $('#selection-datatable').DataTable({
                    select: {
                        style: 'multi'
                    }
                });
                

                table.buttons().container()
                        .appendTo('#datatable-buttons_wrapper .col-md-6:eq(0)');
            } );

        </script>
        
        <!-- Modal-Effect -->
        <script src="plugins/custombox/js/custombox.min.js"></script>
        <script src="plugins/custombox/js/legacy.min.js"></script>
		<script type="text/javascript">
			$(document).ready(function(){
				 $('.select2').css('width','100%').select2({allowClear:true})
					.on('change', function(){
					}); 
			});
		</script>
		
	    <script type="text/javascript">
	    	function deleteDiselConsumption(gp_no,plant_id){
	    		$('.consumption_view').text(gp_no);
	    		$('#diesel_id_delete').val(gp_no);
	    		$('#plant_id_delete').val(plant_id);
	    	}
	    </script>
	    <script type="text/javascript">
		    $(document).ready(function(){
		    	$('#search').on('click',function(){
		    		var vehicle_no=$('#vehicle_no').val();
					var repair_date=$('input[name="repair_date"]').val();
					var gp_no=$('#gp_no').val();
		    		window.location='VehicleRepairList.jsp?repair_date='+repair_date+'&vehicle_no='+vehicle_no+'&gp_no='+gp_no;
		    	});
		    });
	    </script>
	   
    </body>
</html>