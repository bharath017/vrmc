<%@ include file="Session.jsp" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<!DOCTYPE html>
<html>
<head>
        <meta charset="utf-8" />
        <title>Make Payment List</title>
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
        	div.dt-buttons {
			    float: right;
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
                                    <li class="breadcrumb-item"><a href="#">Accouts</a></li>
                                    <li class="breadcrumb-item active">Make Payment</li>
                                    <li class="breadcrumb-item active">Make Payment List</li>
                                </ol>
                            </div>
                            <h4 class="page-title">Make Payment List</h4>
                        </div>
                    </div>
                </div>
                <!-- end page title end breadcrumb -->
                <div class="row">
                <c:if test="${usertype!='operation'}">
                    <div class="col-sm-4">
                        <a href="AddMakePayment.jsp" class="btn btn-custom waves-effect waves-light mb-4"  data-overlayColor="#36404a"><i class="mdi mdi-plus"></i>Add Make Payment</a>
                    </div><!-- end col -->
                </c:if>    
                </div>
                <!-- end row -->
                <form id="clear-form">
				<div class="row filter-row">
					<div class="col-sm-2 col-xs-6 form-group">
                        <label> From Date : </label>
                        <div>
                            <div class="input-group">
                                <input type="text" name="from_date" id="from_date" class="form-control date-picker"
                                		 placeholder="dd/mm/yyyy" id="id-date-picker-1" data-date-format="dd/mm/yyyy"
                                		 readonly="readonly" style="background-color: white;">
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
                                <input type="text" name="to_date" id="to_date" class="form-control date-picker"
                                	   placeholder="dd/mm/yyyy" id="id-date-picker-1"
                                	   data-date-format="dd/mm/yyyy" readonly="readonly" style="background-color: white;">
                                <div class="input-group-append picker">
                                    <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
                                </div>
                            </div>
                        </div>
                    </div>
                    
					<div class="col-sm-2 col-xs-6">
                        <div class="form-group form-focus">
                            <label class="control-label">Payment Id</label>
                                <input class="form-control" placeholder="Enter Payment Id" id="payment_id" type="text" name="payment_id">
                        </div>
                    </div>
                    
                    <div class="col-sm-2 col-xs-6">
                        <div class="form-group form-focus select-focus">
                            <label class="control-label">Supplier : </label>
                            <sql:query var="supplier" dataSource="jdbc/rmc">
                            	select * from supplier where supplier_status='active'
                            </sql:query>
                            <select class="select2 form-control floating" id="supplier_id">
                                <option value="">All Supplier</option>
                                <c:forEach items="${supplier.rows}" var="supplier">
                                	<option value="${supplier.supplier_id}">${supplier.supplier_name}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    
                    <div class="col-sm-1 col-xs-6">
                        <div class="form-group form-focus">
                            <label class="control-label">&nbsp;</label>
                            <a  id="search" class="btn btn-success btn-block"> Search </a>
                        </div>
                    </div>
                    
                    <div class="col-sm-1 col-xs-6">
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
                            <h4 style="color: green;">${res}</h4>
                            <c:remove var="res"/>
                            <table id="example" class="table table-striped table-bordered table-condensed" cellspacing="0" width="100%">
                                <thead>
	                                <tr>
										<th class="center">
											Payment Id
										</th>
										<th class="text-center">Supplier Name</th>
										<th class="text-center">Payment Amount</th>
										<th class="text-center">Payment Date</th>
										<th class="text-center">Payment Time</th>
										<th class="text-center">Payment Mode</th>
										<th class="text-center">Cheque/DD Details</th>
										<th class="text-center">Bank Detail's</th>
										<th class="text-center">Option</th>
									</tr>
                                </thead>
                            </table>
                        </div>
                    </div>
                </div>
                <!-- end row -->
                
                <!-- MODAL FOR PLANT DELETE START  -->
				<div id="dele-model" class="modal-demo col-xs-2">
		            <button type="button" class="close" onclick="Custombox.close();">
		                <span>&times;</span><span class="sr-only">Close</span>
		            </button>
		            <h4 class="custom-modal-title" style="color: white;background-color: #9b3329;">Are you sure want to delete this payment id : <span class="payment_id"></span>?</h4>
		            <div class="custom-modal-text">
		                <form class="form-horizontal"  method="post">
		                	<input type="hidden" name="payment_id" id="payment_id-delete" class="payment_id"/>
		                    <div class="form-group account-btn text-center m-t-2">
		                        <div class="col-12">
		                            <button class="btn w-lg btn-rounded btn-custom waves-effect waves-light" type="button" id="delete-btn"><span class="change_status text-uppercase">Delete Payment</span></button>
		                            <button class="btn w-lg btn-rounded btn-custom btn-danger waves-effect waves-light"  onclick="Custombox.close();" type="button">Exit</button>
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
        <%@ include file="../footer.jsp" %>
        <!-- End Footer -->


        <!-- jQuery  -->
        <script src="../assets/js/jquery.min.js"></script>
        <script src="../assets/js/popper.min.js"></script>
        <script src="../assets/js/bootstrap.min.js"></script>
        <script src="../assets/js/waves.js"></script>
        <script src="../assets/js/jquery.slimscroll.js"></script>
        <script src="../assets/jquery-toast/jquery.toast.min.js"></script>
        <script type="text/javascript" src="js/Accounts/MakePayment/MakePaymentList.js"></script>

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
        <!-- App js -->
        <script src="../assets/js/jquery.core.js"></script>
        <script src="../assets/js/jquery.app.js"></script>
        <!-- Modal-Effect -->
        <script src="../plugins/custombox/js/custombox.min.js"></script>
        <script src="../plugins/custombox/js/legacy.min.js"></script>
    </body>
</html>