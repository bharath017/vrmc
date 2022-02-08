<%@ include file="Session.jsp" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<!DOCTYPE html>
<html>
<head>
        <meta charset="utf-8" />
        <title>Inventory Closing Stock Stock</title>
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
        <link href="assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/icons.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/style.css" rel="stylesheet" type="text/css" />
		<!-- Custom box css -->
        <link href="plugins/custombox/css/custombox.min.css" rel="stylesheet">
        <link href="assets/jquery-toast/jquery.toast.min.css" rel="stylesheet" type="text/css" />
        <!-- jqury confirm -->
        <link href="assets/jquery-confirm/jquery-confirm.min.css" rel="stylesheet" type="text/css">
		
        <script src="assets/js/modernizr.min.js"></script>

		<style type="text/css">
			.error{
				color:red;
			}
			
			.hidden{
				display: none;
			}
			
			
			
			.table{
				background-color: white;
			}
			
			.comp-table>thead>tr>th,.comp-table>tbody>tr>th,.comp-table>tfoot>tr>th,
			.comp-table>thead>tr>td,.comp-table>tbody>tr>td,.comp-table>tfoot>tr>td{
				padding: 1px;
			}
			
			.redClass{
				color:red;
			} 
			
		</style>
    </head>

    <body id="stock-body">

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
                                    <li class="breadcrumb-item"><a href="#">Inventory</a></li>
                                    <li class="breadcrumb-item active">Closing Stock</li>
                                </ol>
                            </div>
                            <h4 class="page-title">Closing Stock</h4>
                        </div>
                    </div>
                </div>
                <!-- end page title end breadcrumb -->
                <div class="row">
                    <div class="col-12">
                    	<button type="button" class="btn btn-custom" id="stock-entry" style="margin-bottom: 10px;">Add Closing Stock</button>
                        <div class="card-box table-responsive">
                            <table id="example" class="table table-striped table-bordered" cellspacing="0" width="100%">
                                <thead>
	                                <tr>
										<th class="text-center" style="width: 5%;">S/L No</th>
                                        <th class="text-center">Item Name</th>
                                        <th class="text-center">Effective Date</th>
                                        <th class="text-center">Quantity</th>
                                        <th class="text-center">Plant Name</th>
                                        <th class="text-right">Action</th>
									</tr>
                                </thead>
                                <tbody class="text-center">
                                	
                                </tbody>
                            </table>
                        </div>
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
        <!-- App js -->
        <script src="assets/js/jquery.core.js"></script>
        <script src="assets/js/jquery.app.js"></script>
       <script src="assets/js/select2.min.js"></script>
		<script src="picker/js/bootstrap-datepicker.min.js"></script>
		<script src="picker/js/moment.min.js"></script>
		<script src="assets/js/bootstrap-timepicker.min.js"></script>
		<script src="picker/js/bootstrap-datetimepicker.min.js"></script>
        <script src="assets/jquery-toast/jquery.toast.min.js"></script>
        <script type="text/javascript" src="validation/jquery.validate.js"></script>
        <script src="js/Inward/Inventory/Stock/InventoryStock.js"></script>
        
        <!-- Required datatable js -->
        <script src="plugins/datatables/jquery.dataTables.min.js"></script>
        <script src="plugins/datatables/dataTables.bootstrap4.min.js"></script>
        
        <!-- Modal-Effect -->
        <script src="plugins/custombox/js/custombox.min.js"></script>
        <script src="plugins/custombox/js/legacy.min.js"></script>
        
        <!-- Autocomplete -->
        <script src="plugins/autocomplete/jquery.autocomplete.min.js"></script>
        <!-- Jquery confirm -->
        <script type="text/javascript" src="assets/jquery-confirm/jquery-confirm.min.js"></script>
        
        <c:choose>
			<c:when test="${empty param.action}">
				<script type="text/javascript" src="js/Pickers/dateTimeValidator.js"></script>
			</c:when>
			<c:otherwise>
				<script type="text/javascript" src="js/Pickers/dateTimeValidatorEdit.js"></script>
			</c:otherwise>
		</c:choose>

    </body>
</html>