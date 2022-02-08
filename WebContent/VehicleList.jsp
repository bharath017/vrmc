<%@ include file="Session.jsp" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<!DOCTYPE html>
<html>
<head>
        <meta charset="utf-8" />
        <title>Vehicle List - ${initParam.company_name}</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
        <meta content="A fully featured admin theme which can be used to build CRM, CMS, etc." name="description" />
        <meta content="Coderthemes" name="author" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />

        <!-- App favicon -->
        <link rel="shortcut icon" href="assets/images/favicon.ico">

        <!-- DataTables -->
        <link href="plugins/datatables/dataTables.bootstrap4.min.css" rel="stylesheet" type="text/css"/>
        <link href="plugins/datatables/responsive.bootstrap4.min.css" rel="stylesheet" type="text/css"/>

        <!-- App css -->
        <link href="assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/icons.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/style.css" rel="stylesheet" type="text/css" />

		  <!-- Custom box css -->
        <link href="plugins/custombox/css/custombox.min.css" rel="stylesheet">
		
        <script src="assets/js/modernizr.min.js"></script>

    </head>

    <body>

        <!-- Navigation Bar-->
        	<!-- put header.jsp here -->
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
                                    <li class="breadcrumb-item"><a href="#">Vehicle</a></li>
                                    <li class="breadcrumb-item"><a href="#">Vehicle</a></li>
                                    <li class="breadcrumb-item active">VehicleList</li>
                                </ol>
                            </div>
                            <h4 class="page-title">Vehicle List</h4>
                        </div>
                    </div>
                </div>
                <!-- end page title end breadcrumb -->
                 <!-- end page title end breadcrumb -->
                 <div class="row">
                    <div class="col-sm-4">
                        <a href="AddVehicle.jsp" class="btn btn-custom waves-effect waves-light mb-4"  data-overlayColor="#36404a"><i class="mdi mdi-plus"></i>New Vehicle</a>
                    </div><!-- end col -->
                </div>
                <!-- end row -->

                <div class="row">
                	<h4 class="text-success">${result}</h4>
                	<%session.removeAttribute("result"); %>
                    <div class="col-12">
                        <div class="card-box">
                            <h4 class="header-title">Vehicle List</h4>
                            <table class="table table-hover m-0 tickets-list table-actions-bar dt-responsive nowrap" cellspacing="0" width="100%" id="datatable">
                                <thead>
                                <tr>
                                    <th>
                                        Vehicle No
                                    </th>
                                    <th>Vehicle Name</th>
                                    <th>Insurance No</th>
                                    <th>Insurance Valid</th>
                                    <th>Meter Reading</th>
                                    <th>Vehicle Type</th>
                                    <th>FC Date</th>
                                    <th>Tax Date</th>
                                    <th class="hidden-sm">Action</th>
                                </tr>
                                </thead>
								<sql:query var="vehicle" dataSource="jdbc/rmc">
									select * from vehicle
								</sql:query>
                                <tbody>
                                <c:forEach items="${vehicle.rows}" var="vehicle">
                                <tr>
                                    <td><b>${vehicle.vehicle_no}</b></td>
                                    <td>
                                            <b>${vehicle.vehicle_name}</b>
                                    </td>

                                    <td>
                                        ${vehicle.insurance_no}
                                    </td>

                                    <td>
                                        ${vehicle.insurance_valid_till}
                                    </td>

                                    <td>
                                      ${vehicle.meter_reading}
                                    </td>

                                    <td>
                                        ${vehicle.vehicle_type}
                                    </td>

                                    <td>
                                        ${vehicle.fc_date}
                                    </td>

                                    <td>
                                       	${vehicle.tax_date}
                                    </td>

                                    <td>
                                        <div class="btn-group dropdown">
                                            <a href="javascript: void(0);" class="table-action-btn dropdown-toggle arrow-none btn btn-light btn-sm" data-toggle="dropdown" aria-expanded="false"><i class="mdi mdi-dots-horizontal"></i></a>
                                            <div class="dropdown-menu dropdown-menu-right">
                                                <a class="dropdown-item" href="AddVehicle.jsp?action=update&vehicle_no=${vehicle.vehicle_no}"><i class="mdi mdi-pencil mr-2 text-muted font-18 vertical-middle"></i>Edit Vehicle</a>
                                                <a class="dropdown-item" href="#delete-model" data-animation="blur" data-plugin="custommodal" onclick="deleteVehicle('${vehicle.vehicle_no}');" data-overlaySpeed="100" data-overlayColor="#36404a"><i class="mdi mdi-delete mr-2 text-muted font-18 vertical-middle"></i>Remove</a>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div><!-- end col -->
                </div>
                <!-- end row -->

            </div> <!-- end container -->
        </div>
        <!-- end wrapper -->
		
		
		 <!-- MODAL FOR  DELETE START  -->
			<div id="delete-model" class="modal-demo col-xs-2">
	            <button type="button" class="close" onclick="Custombox.close();">
	                <span>&times;</span><span class="sr-only">Close</span>
	            </button>
	            <h4 class="custom-modal-title" style="color: white;background-color: #491136;">Delete Vehicle No : <span class="vehicle_no"></span> </h4>
	            <div class="custom-modal-text">
	                <form class="form-horizontal" action="VehicleController?button=delete" method="post">
	                	<input type="hidden" name="vehicle_no" id="vehicle_no" class="vehicle_no"/>
	                    <div class="form-group account-btn text-center m-t-2">
	                        <div class="col-12">
	                            <button class="btn w-lg btn-rounded btn-custom waves-effect waves-light" type="submit">DELETE</button>
	                            <button class="btn w-lg btn-rounded btn-custom btn-danger waves-effect waves-light"  onclick="Custombox.close();" type="button">CANCEL</button>
	                        </div>
	                    </div>
	                </form>
	            </div>
	        </div>
           <!--  DELETE MODAL END  -->

        <!-- Footer -->
       	<!-- put footer.jsp here -->
       	<%@ include file="footer.jsp" %>
        <!-- End Footer -->


        <!-- jQuery  -->
        <script src="assets/js/jquery.min.js"></script>
        <script src="assets/js/popper.min.js"></script>
        <script src="assets/js/bootstrap.min.js"></script>
        <script src="assets/js/waves.js"></script>
        <script src="assets/js/jquery.slimscroll.js"></script>

        <script src="plugins/datatables/jquery.dataTables.min.js"></script>
        <script src="plugins/datatables/dataTables.bootstrap4.min.js"></script>
        <script src="plugins/datatables/dataTables.responsive.min.js"></script>
        <script src="plugins/custombox/js/custombox.min.js"></script>
        <script src="plugins/custombox/js/legacy.min.js"></script>
        <script type="text/javascript">
			function deleteVehicle(vehicle_no){
				$('.vehicle_no').text(vehicle_no);
				$('.vehicle_no').val(vehicle_no);
			}
		</script>

        <!-- App js -->
        <script src="assets/js/jquery.core.js"></script>
        <script src="assets/js/jquery.app.js"></script>
        <script type="text/javascript">
            $(document).ready(function () {
                $('#datatable').dataTable();
            });
        </script>


    </body>
</html>