<%@ include file="Session.jsp" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<!DOCTYPE html>
<html>
<head>
        <meta charset="utf-8" />
        <title>OutGoing Fleet List</title>
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
		
        <!-- App css -->
        <link href="assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/icons.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/style.css" rel="stylesheet" type="text/css" />
		  <!-- Custom box css -->
        <link href="plugins/custombox/css/custombox.min.css" rel="stylesheet">
        <link rel="stylesheet" href="assets/css/select2.min.css" />
		<link rel="stylesheet" href="assets/css/render.css">
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
                                    <li class="breadcrumb-item"><a href="#">Fleet </a></li>
                                    <li class="breadcrumb-item active">Outgoing Fleet</li>
                                    <li class="breadcrumb-item active">Outgoing Fleet List</li>
                                </ol>
                            </div>
                            <h4 class="page-title">Fleet Outgoing List</h4>
                        </div>
                    </div>
                </div>
                <!-- end page title end breadcrumb -->

                <div class="row">
                    <div class="col-sm-4">
                    <a href="FleetOutgoing.jsp" class="btn btn-custom waves-effect waves-light mb-4"  data-overlayColor="#36404a"><i class="mdi mdi-plus"></i> Add Incoming Item</a>
                    </div><!-- end col -->
                </div>
                <!-- end row -->
				<div class="row filter-row">
				
				 <div class="col-sm-2 col-xs-6 form-group">
                        <label>OutGoing Date : </label>
                        <div>
                            <div class="input-group">
                                <input type="text" name="incoming_date" id="outgoing_date" class="form-control date-picker " placeholder="yyyy-mm-dd" id="id-date-picker-1" data-date-format="yyyy-mm-dd">
                                <div class="input-group-append">
                                    <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
                                </div>
                            </div>
                        </div>
                    </div>
				
                    <div class="col-sm-2 col-xs-6">
                        <div class="form-group form-focus">
                            <label class="control-label">Bill No</label>
                                <input class="form-control" placeholder="Enter Bill No" id="bill_no" type="text" name="bill_no">
                        </div>
                    </div>
                    <div class="col-sm-2 col-xs-6">
                        <div class="form-group form-focus select-focus">
                            <label class="control-label">Returnable</label>
                            <select class="form-control select2 floating"   id="returnable">
                                <option value="">All Type</option>
                                <option value="yes">YES</option>
                                <option value="no">No</option>
                            </select>
                        </div>
                    </div>
                     
                    <div class="col-sm-3 col-xs-6">
                        <div class="form-group form-focus">
                            <label class="control-label">&nbsp;</label>
                            <a href="#" id="search" class="btn btn-success btn-block"> Search </a>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-12">
                        <div class="card-box table-responsive">
                            <h4>${res}</h4>
                            <c:remove var="res"/>
                            <table id="example" class="table table-striped table-bordered table-condensed" cellspacing="0" width="100%">
                                <thead>
	                                <tr>
									    <th class="text-center">OutGoing No</th>
                                        <th class="text-center">Issued Date</th>
                                        <th class="text-center">Issued Time</th>
                                        <th class="text-center">Received Person</th>
                                        <th class="text-center">Returnable ?</th>
                                        <th class="text-center">OutGoing Comment</th>
                                        <th class="text-center">Plant</th>
                                        <th class="text-right">Action</th>
        								</tr>
                                </thead>
                                
                                <c:set value="${(empty param.outgoing_date)?'':param.outgoing_date}" var="outgoing_date"/>
                                <c:set value="${(empty param.bill_no)?'':param.bill_no}" var="bill_no"/>
                                <c:set value="${(empty param.returnable)?'':param.returnable}" var="returnable"/>
                              
								<sql:query var="fleet" dataSource="jdbc/rmc">
                                	select f.*,(select plant_name from plant where plant_id=f.plant_id) as plant_name from fleet_outgoing f where
                                	 issued_date like if(''=?,'%%',?)
                                	 and fleet_outgoing_id like if(''=?,'%%',?)
                                	 and returnable like if(''=?,'%%',?)
                                	 and f.plant_id like if(?=0,'%%',?)
                                	 order by fleet_outgoing_id asc limit 100
                                	<sql:param value="${outgoing_date}"/>
                                	<sql:param value="${outgoing_date}"/>
                                	<sql:param value="${bill_no}"/>
                                	<sql:param value="${bill_no}"/>
                                	<sql:param value="${returnable}"/>
                                	<sql:param value="${returnable}"/>
                                	<sql:param value="${bean.plant_id}"/>
                                	<sql:param value="${bean.plant_id}"/>
                                </sql:query>
                                
                                <tbody>
                                <c:forEach items="${fleet.rows}" var="fleet">
									<tr class="text-center">
										 <td><a href="#">${fleet.fleet_outgoing_id}</a></td>
	                                        <td>${fleet.issued_date}</td>
	                                        <td>${fleet.issued_time}</td>
	                                        <td>${fleet.received_person}</td>
	                                        <td>${fleet.returnable}</td>
	                                        <td>${fleet.outgoing_comment}</td>
	                                        <td>${(empty fleet.plant_name)?'Office':fleet.plant_name}</td>  
	                                        <td class="text-center">
											 <div class="btn-group dropdown">
	                                            <a href="javascript: void(0);" class="table-action-btn dropdown-toggle arrow-none btn btn-light btn-sm" data-toggle="dropdown" aria-expanded="false"><i class="mdi mdi-dots-horizontal"></i></a>
	                                            <div class="dropdown-menu dropdown-menu-right">
	                                            	<a class="dropdown-item" href="FleetRecept.jsp?fleet_outgoing_id=${fleet.fleet_outgoing_id}"><i class="fa fa-print mr-2 text-primary font-18 vertical-middle"></i> Print Recept</a>
	                                            	<a class="dropdown-item" href="FleetOutgoing.jsp?action=update&fleet_outgoing_id=${fleet.fleet_outgoing_id}"><i class="fa fa-edit mr-2 text-primary font-18 vertical-middle"></i> Edit Outgoing</a>
                                                    <a class="dropdown-item" href="#delete-model" data-animation="blur" data-plugin="custommodal" onclick="changeStatus('${fleet.fleet_outgoing_id}','${(fleet.fleet_stauts=='active')?'deactive':'active'}')" data-overlaySpeed="100" data-overlayColor="#36404a"><i class="mdi mdi-window-close mr-2 text-danger font-18 vertical-middle"></i> ${(fleet.fleet_stauts=='active')?'Activate Fleet':'Deactivate Fleet'}</a>
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



 				<div id="delete-model" class="modal-demo col-xs-2" role="dialog">
	            <div class="modal-dialog">
	                <div class="modal-content modal-md">
	                    <div class="modal-header" style="background-color: #c44646;color: white;">
	                        <h4 class="modal-title">Cancel this Fleed id : <span class="fleet_id"></span></h4>
	                    </div>
	                    <div class="modal-body card-box">
	                       <form action="FleetController?action=CancelIncomingFleet" method="post">
	                       		<p>Are you sure want to Cancel this?</p>
	                       		<input type="hidden" id="fleet_id" class="fleet_id" name="fleet_id">
		                        <div class="m-t-20 text-left">
		                            <a href="#" class="btn btn-default" data-dismiss="modal">Close</a>
		                            <button type="submit" class="btn btn-danger">Cancel PO</button>
		                        </div>
	                       </form>
	                    </div>
	                </div>
	            </div>
	        </div>
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


	    <script type="text/javascript" src="assets/js/bootstrap.min.js"></script>
	    <script type="text/javascript" src="assets/js/jquery.slimscroll.js"></script>
	    <script type="text/javascript" src="assets/js/moment.min.js"></script>
	    <script type="text/javascript" src="assets/js/bootstrap-datetimepicker.min.js"></script>
    	<script src="assets/js/modernizr.min.js"></script>


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
		    		
		    		$( ".datepicker3" ).datetimepicker({
		   			   format: 'YYYY-MM-DD'
		   			});
		    	});
		    </script>
		     <script type="text/javascript">
			    $(document).ready(function(){
			    	$('#search').on('click',function(){
			    		var outgoing_date=$('#outgoing_date').val();
			    		var bill_no=$('#bill_no').val();
			    		var returnable=$('#returnable').val();
			    		window.location='FleetOutgoingList.jsp?outgoing_date='+outgoing_date+'&bill_no='+bill_no+'&returnable='+returnable;
			    	});
			    });
		    </script>
		    <script>
		    $(document).ready(function() {
		    	$('.mytable').DataTable({
		    		"aaSorting": []
		    	});
		    } );
		</script>
		<script type="text/javascript">
			function changeStatus(fleet_id){
				$('.fleet_id').text(fleet_id);
				$('.fleet_id').val(fleet_id);
			}
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
    </body>
</html>