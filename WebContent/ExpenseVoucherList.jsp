<%@ include file="Session.jsp" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<!DOCTYPE html>
<html>
<head>
        <meta charset="utf-8" />
        <title>Expense Voucher List</title>
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
        <link href="assets/jquery-toast/jquery.toast.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/jquery-confirm/jquery-confirm.min.css" rel="stylesheet" type="text/css" />
        <style type="text/css">
        	.hidden{
        		display: none;
        	}
        	
        	div.dt-buttons {
			    float: right;
			}
			
			.table .dropdown-menu {
			    position: relative;
			    float: none;
			    width: 160px;
			}
			
			.table>thead>tr>th,.table>tbody>tr>th,.table>tfoot>tr>th,.table>thead>tr>td,.table>tbody>tr>td,.table>tfoot>tr>td{
				padding: 1px;
			}
			
			.warning{
				background-color: #f0b930; 
			}
			.error{
				color:red;
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
                                    <li class="breadcrumb-item"><a href="#">Accounts</a></li>
                                    <li class="breadcrumb-item active">Expense Voucher</li>
                                    <li class="breadcrumb-item active">Expense Voucher List</li>
                                </ol>
                            </div>
                            <h4 class="page-title">Journal Voucher List</h4>
                        </div>
                    </div>
                </div>
                <input type="hidden" id="result" value="${result}"/>
                <c:remove var="result"/>
                <!-- end page title end breadcrumb -->
                <div class="row text-center">
                    <div class="col-xs-6 col-sm-3 text-center" >
                        <div class="card-box widget-flat  text-white" style="background-color: #02c0ce;border-color:#02c0ce;">
                            <i class=" fa fa-money"></i>
                            <h5 class="m-b-10" id="thismonth"></h5>
                            <p class="text-uppercase m-b-5 font-13 font-600">THIS MONTH Expense</p>
                        </div>
                    </div>
                    <div class="col-xs-6 col-sm-3 text-center">
                        <div class="card-box widget-flat text-white" style="background-color: #02c0ce;border-color:#02c0ce;">
                            <i class=" fa fa-money"></i>
                            <h5 class="m-b-10" id="lastmonth"></h5>
                            <p class="text-uppercase m-b-5 font-13 font-600">LAST MONTH Expense</p>
                        </div>
                    </div>
                    <div class="col-xs-6 col-sm-3 text-center">
                        <div class="card-box widget-flat text-white" style="background-color: #02c0ce;border-color:#02c0ce;">
                            <i class=" fa fa-money"></i>
                            <h5 class="m-b-10" id="today"></h5>
                            <p class="text-uppercase m-b-5 font-13 font-600">TODAY BILL</p>
                        </div>
                    </div>
                    
                    
				</div>
				<form id="clear-form">
				<div class="row filter-row">
					<div class="col-sm-2 col-xs-6">
                        <div class="form-group form-focus">
                            <label class="control-label">Bill No</label>
                            	<input type="hidden" value="true" id="is_bill_received"/>
                                <input class="form-control" placeholder="Enter Bill No" id="bill_no" type="text" name="bill_no">
                        </div>
                    </div>
                    <div class="col-sm-2 col-xs-6 form-group">
                        <label>From Date : </label>
                        <div>
                            <div class="input-group">
                                <input type="text" name="from_date" class="form-control date-picker from_date"
                                	   placeholder="dd/mm/yyyy"  data-date-format="dd/mm/yyyy"
                                	   readonly="readonly" style="background-color: white;"/>
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
                                <input type="text" name="to_date" class="form-control date-picker to_date"
                                	   placeholder="dd/mm/yyyy"  data-date-format="dd/mm/yyyy"
                                	   readonly="readonly" style="background-color: white;"/>
                                <div class="input-group-append picker">
                                    <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-2 col-xs-6">
                        <div class="form-group form-focus select-focus">
                            <label class="control-label">Supplier : </label>
                            <sql:query var="supplier" dataSource="jdbc/rmc">
                            	select supplier_id,supplier_name
                            	from supplier 
                            	where supplier_status='active'
                            	and business_id like if(?=0,'%%',?)
                            	<sql:param value="${bean.business_id}"/>
                            	<sql:param value="${bean.business_id}"/>
                            </sql:query>
                            
                            <select class="form-control select2 floating"   id="supplier_id">
                                	<option value="0">All Supplier</option>
                                <c:forEach items="${supplier.rows}" var="supplier">
                                	<option value="${supplier.supplier_id}">${supplier.supplier_name}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <div class="col-sm-1 col-xs-6">
                        <div class="form-group form-focus">
                            <label class="control-label">&nbsp;</label>
                            <a id="search" class="btn btn-success btn-block"> Search </a>
                        </div>
                    </div>
                    
                    <div class="col-sm-1 col-xs-6">
                        <div class="form-group form-focus">
                            <label class="control-label">&nbsp;</label>
                            <a id="clear" class="btn btn-danger btn-block"> Clear </a>
                        </div>
                    </div>
                </div>
                </form>
                <div class="row">
                    <div class="col-12">
                        <div class="card-box table-responsive">
                            <h4 style="color: green;">${res}</h4>
                            <c:remove var="res"/>
                            <table id="example" class="table  table-bordered table-condensed text-center" cellspacing="0" width="100%">
                                <thead>
	                                <tr>
										<th>Voucher No</th>
										<th class="center">
											Vendor Name
										</th>
										<th class="text-center">Bill No</th>
										<th class="text-center">Bill Date</th>
										<th class="text-center">Rate Include<br> Tax?</th>
										<th class="text-center">Plant Name</th>
										<th class="text-center" style="width: 40%;">
											<table class="table tbl" >
												<tr style="background-color: #02c0ce;color:white;">
													<td style="width: 40%;">Product</td>
													<td style="width: 20%;">Quantity</td>
													<td style="width: 20%;">Rate</td>
													<td style="width: 20%;">Net Amount</td>
												</tr>								
											</table>
										</th>
										<th>Bill Amount</th>
										<th class="text-center" style="width: 4%;">OPTION</th>
									</tr>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                <!-- end row -->
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
        <script src="assets/jquery-toast/jquery.toast.min.js"></script>
        <script src="assets/jquery-confirm/jquery-confirm.min.js"></script>
        <script type="text/javascript" src="js/Accounts/ExpenseVoucher/ExpenseVoucherList.js"></script>

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