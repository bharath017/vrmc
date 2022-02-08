<%@ include file="Session.jsp" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<!DOCTYPE html>
<html>
<head>
        <meta charset="utf-8" />
        <title>Expense Category</title>
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
        <link href="assets/jquery-toast/jquery.toast.min.css" rel="stylesheet" type="text/css" />
        <!-- jqury confirm -->
        <link href="assets/jquery-confirm/jquery-confirm.min.css" rel="stylesheet" type="text/css">
        <script src="assets/js/modernizr.min.js"></script>
        <link rel="stylesheet" href="assets/css/select2.min.css" />
        <link rel="stylesheet" href="assets/css/render.css">

		<style type="text/css">
			.error{
				color:red;
			}
			
			.hidden{
				display: none;
			}
			
			.card-box{
				background-color: white;
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

    <body data-ng-app="myApp" data-ng-controller="myCtrl">

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
                                    <li class="breadcrumb-item"><a href="#">Expense Voucher</a></li>
                                    <li class="breadcrumb-item active">Expense Category</li>
                                </ol>
                            </div>
                            <h4 class="page-title">Expense Voucher Category</h4>
                        </div>
                    </div>
                </div>
                <!-- end page title end breadcrumb -->
                <div class="row expense-category">
                	<div class="col-sm-12">
                		<button class="btn btn-info" id="add_category_type_btn" type="button">Add Expense Category Type</button>
                		<br>
                	</div>
                </div>
                <br>
                <div class="row" id="doc">
                	<div class="col-5">
                    	<div class="card-box">
								<h5 class="text-center">Add/Update Expense Voucher Category</h5>
								<form id="myform" action="#">
									<div class="row">
										<div class="form-group col-sm-12">
											<label for="name">Category Type <span class="text-danger">*</span></label>
											<input type="hidden" name="category_id" id="category_id" value="0"/>
											<sql:query var="cat" dataSource="jdbc/rmc">
												select category_type from expense_category_type
											</sql:query>
											<select id="category_type" class="form-control" name="category_type">
												<c:forEach items="${cat.rows}" var="cat">
													<option value="${cat.category_type}">${cat.category_type}</option>
												</c:forEach>
											</select>
										</div>
										<div class="form-group col-sm-6">
											<label for="name">Category Name <span class="text-danger">*</span></label>
											<input type="text" name="category_name" id="category_name" 
													placeholder="Enter Category Name" class="form-control"/>
										</div>
										<div class="form-group col-sm-6">
											<label for="name">Category Description </label>
											<input type="text" name="category_description" id="category_description" 
													placeholder="Enter Category Description" class="form-control"/>
										</div>
										<div class="col-sm-12">
											<button class="btn btn-success" id="submit"  type="submit">Save </button>
											<button class="btn btn-danger" id="reset" type="reset">Reset</button>
										</div>
									</div>
								</form>
                    	</div>
                    </div>
                    <div class="col-7">
                        <div class="card-box table-responsive">
                        	<input type="hidden" name="type" id="type" value="billing"/>
                            <table id="example" class="table table-striped table-bordered" cellspacing="0" width="100%">
                                <thead>
	                                <tr>
										<th class="text-center">Category Name</th>
										<th class="text-center">Description</th>
                                        <th class="text-center">Category Type</th>
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
        <script src="assets/jquery-toast/jquery.toast.min.js"></script>
        <script type="text/javascript" src="angular/angular.min.js"></script>

        <!-- App js -->
        <script src="assets/js/jquery.core.js"></script>
        <script src="assets/js/jquery.app.js"></script>
        <script type="text/javascript" src="validation/jquery.validate.js"></script>
        <script src="js/Accounts/ExpenseVoucher/ExpenseCategory.js"></script>
        
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
        <script src="assets/js/select2.min.js"></script>

    </body>
</html>