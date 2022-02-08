<%@ include file="Session.jsp" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<!DOCTYPE html>
<html>
<head>
        <meta charset="utf-8" />
        <title>Sales Order List</title>
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
        <link href="../assets/jquery-confirm/jquery-confirm.min.css" rel="stylesheet" type="text/css" />
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
                                    <li class="breadcrumb-item"><a href="#">Customer & PO</a></li>
                                    <li class="breadcrumb-item active">Sales Order</li>
                                    <li class="breadcrumb-item active">Sales Order List</li>
                                </ol>
                            </div>
                            <h4 class="page-title">Sales Order List</h4>
                        </div>
                    </div>
                </div>
                <input type="hidden" id="result" value="${result}"/>
                <c:remove var="result"/>
                <!-- end page title end breadcrumb -->
				<form id="clear-form">
				<div class="row filter-row">
					<div class="col-sm-2 col-xs-6">
                        <div class="form-group form-focus">
                            <label class="control-label">Po Number <span class="text-custom">*</span></label>
                                <input class="form-control" placeholder="Enter PO Number" id="po_number" type="text" name="po_number">
                        </div>
                    </div>
                    
                    <div class="col-sm-2 col-xs-6 form-group">
                        <label>From Date <span class="text-custom">*</span> </label>
                        <div>
                            <div class="input-group">
                                <input type="text" name="from_date" class="form-control date-picker from_date"
                                		 placeholder="dd/mm/yyyy"  data-date-format="dd/mm/yyyy" readonly="readonly" style="background-color: white;">
                                <div class="input-group-append picker">
                                    <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-sm-2 col-xs-6 form-group">
                        <label>To Date <span class="text-custom">*</span> </label>
                        <div>
                            <div class="input-group">
                                <input type="text" name="to_date" class="form-control date-picker to_date"
                                	 placeholder="dd/mm/yyyy"  data-date-format="dd/mm/yyyy" readonly="readonly" style="background-color: white;">
                                <div class="input-group-append picker">
                                    <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-2 col-xs-6">
                        <div class="form-group form-focus select-focus">
                            <label class="control-label">Customer <span class="text-custom">*</span> </label>
                            <sql:query var="customer" dataSource="jdbc/rmc">
                            	select customer_id,customer_name
                            	from test_customer
                            	where customer_status='active'
                            	and business_id like if(?=0,'%%',?)
                            	and plant_id like if(?=0,'%%',?)
								<sql:param value="${bean.business_id}"/>
								<sql:param value="${bean.business_id}"/>
								<sql:param value="${bean.plant_id}"/>
								<sql:param value="${bean.plant_id}"/>
                            </sql:query>
                            <select class="form-control select2 floating"   id="customer_id">
                                <option value="0">All Customer</option>
                                <c:forEach items="${customer.rows}" var="customer">
                                	<option value="${customer.customer_id}">${customer.customer_name}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    
                    <div class="col-sm-2 col-xs-6">
                        <div class="form-group form-focus select-focus">
                            <label class="control-label">Site <span class="text-custom">*</span> </label>
                            <select class="form-control floating"   id="site_id">
                                <option value="0">All Site</option>
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
	                                <tr style="color: white;background-color:#ce9401; ">
										<th>PO Number</th>
										<th class="center">
											PO Date
										</th>
										<th class="text-center">Customer</th>
										<th class="text-center">Site Address</th>
										<th class="text-center">Tax Include?</th>
										<th class="text-center">GST Percent</th>
										<th class="text-center">GST Category</th>
										<th class="text-center">Sales Person</th>
										<th class="text-center">Plant</th>
										<th class="text-center" style="width: 20%;">
											<table class="table tbl" >
												<tr style="color: white;background-color:#ce9401;">
													<td style="border:1px solid white;">Grade</td>
													<td style="border:1px solid white;">Quantity</td>
													<td style="border:1px solid white;">Rate</td>
												</tr>								
											</table>
										</th>
										<th class="text-center">OPTION</th>
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
        <%@ include file="../footer.jsp" %>
        <!-- End Footer -->


        <!-- jQuery  -->
        <script src="../assets/js/jquery.min.js"></script>
        <script src="../assets/js/popper.min.js"></script>
        <script src="../assets/js/bootstrap.min.js"></script>
        <script src="../assets/js/waves.js"></script>
        <script src="../assets/js/jquery.slimscroll.js"></script>
        <script src="../assets/jquery-toast/jquery.toast.min.js"></script>
        <script src="../assets/jquery-confirm/jquery-confirm.min.js"></script>
        <script type="text/javascript" src="js/PurchaseOrder/PurchaseOrderList.js"></script>
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
        <script type="text/javascript" src="../validation/jquery.validate.js"></script>
    </body>
</html>