<%@ include file="Session.jsp" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<!DOCTYPE html>
<html>
<head>
        <meta charset="utf-8" />
        <title>Driver List - ${initParam.company_name}</title>
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
		
        <script src="assets/js/modernizr.min.js"></script>

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
                                    <li class="breadcrumb-item"><a href="#">Vehicle</a></li>
                                    <li class="breadcrumb-item active">Driver</li>
                                </ol>
                            </div>
                            <h4 class="page-title">Driver List</h4>
                        </div>
                    </div>
                </div>
                <!-- end page title end breadcrumb -->

                <div class="row">
                    <div class="col-sm-4">
                        <a href="AddDriver.jsp" class="btn btn-custom waves-effect waves-light mb-4"  data-overlayColor="#36404a"><i class="mdi mdi-plus"></i> Add Driver</a>
                    </div><!-- end col -->
                </div>
                <!-- end row -->

                <div class="row">
                    <div class="col-12">
                        <div class="card-box table-responsive">
                            <h4 class="m-t-0 header-title">Driver List</h4>
                            <h4 style="color: green;">${result}</h4>
                            <%session.removeAttribute("result");%>
                            <p></p>
                            <table id="datatable-buttons" class="table table-striped table-bordered" cellspacing="0" width="100%">
                                <thead>
	                                <tr>
										<th class="center">
											Sl. No
										</th>
										<th class="center">Name</th>
										<th class="center">Phone</th>
										<th class="center">Licence No</th>
										<th class="center">Licence Validity</th>
										<th class="center">OPTION</th>
									</tr>
                                </thead>
								<sql:query var="driver" dataSource="jdbc/rmc">
									select * from driver
								</sql:query>
                                <tbody>
                                <c:set value="0" var="count"/>
                                <c:forEach var="driver" items="${driver.rows}">
                                	<c:set value="${count+1}" var="count"/>
									<tr>
										<td class="center" style="width: 10%;">${count}</td>
										<td class="center" style="width: 25%;">
											${driver.driver_name}
										</td>
										<td class="center" style="width: 15%">
											${driver.driver_phone}
										</td>
										<td style="word-break:break-word;">
											${driver.licence_no}
										</td>
										<td class="hidden-480">
											${driver.licence_valid_till}
										</td>
										<td>
											<div class="hidden-sm hidden-xs action-buttons">
												<a class="btn btn-icon waves-effect waves-light btn-purple"  href="AddDriver.jsp?action=update&driver_id=${driver.driver_id}">
													<i class="fa fa-edit"></i>
												</a>
												&nbsp;&nbsp;
												<a class="btn btn-icon waves-effect waves-light btn-danger"  href="#delete-model" onclick="deleteDriver('${driver.driver_id}','${driver.driver_name}')" data-animation="blur" data-plugin="custommodal"
                               						data-overlaySpeed="100" data-overlayColor="#36404a">
													<i class="ace-icon fa fa-trash-o bigger-130"></i>
												</a>
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


				 <!-- MODAL FOR PLANT DELETE START  -->
				<div id="delete-model" class="modal-demo col-xs-2">
		            <button type="button" class="close" onclick="Custombox.close();">
		                <span>&times;</span><span class="sr-only">Close</span>
		            </button>
		            <h4 class="custom-modal-title" style="color: white;background-color: #491136;">Delete Driver : <span class="driver_name"></span> </h4>
		            <div class="custom-modal-text">
		                <form class="form-horizontal" method="post" action="DriverController?button=delete">
		                	<input type="hidden" name="driver_id" id="driver_id"/>
		                    <div class="form-group account-btn text-center m-t-2">
		                        <div class="col-12">
		                            <button class="btn w-lg btn-rounded btn-custom waves-effect waves-light" type="submit">DELETE</button>
		                            <button class="btn w-lg btn-rounded btn-custom btn-danger waves-effect waves-light"  onclick="Custombox.close();" type="button">CANCEL</button>
		                        </div>
		                    </div>
		                </form>
		            </div>
		        </div>
                <!--  PLANT DELETE MODAL END  -->

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
        <script src="plugins/datatables/jszip.min.js"></script>
        <script src="plugins/datatables/pdfmake.min.js"></script>
        <script src="plugins/datatables/vfs_fonts.js"></script>
        <script src="plugins/datatables/buttons.html5.min.js"></script>
        <script src="plugins/datatables/buttons.print.min.js"></script>

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
			function deleteDriver(driver_id,driver_name){
				$('.driver_name').html(driver_name);
				$('#driver_id').val(driver_id);
			}
		</script>

    </body>
</html>