<%@ include file="Session.jsp" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<!DOCTYPE html>
<html>
<head>
        <meta charset="utf-8" />
        <title>Supplier's</title>
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
                                    <li class="breadcrumb-item"><a href="#">Inventory</a></li>
                                    <li class="breadcrumb-item active">Supplier's</li>
                                </ol>
                            </div>
                            <h4 class="page-title">Supplier's</h4>
                        </div>
                    </div>
                </div>
                <!-- end page title end breadcrumb -->
                <div class="row" id="doc">
                	<div class="col-5">
                    	<div class="card-box">
								<h5 class="text-center">Add/Update Supplier's Detail's</h5>
								<form id="myform" action="#">
									<div class="row">
										<div class="form-group col-sm-12">
											<label for="name">Name <span class="text-danger">*</span></label>
											<input type="hidden" name="supplier_id" id="supplier_id" value="0"/>
											<input type="text" name="supplier_name" id="supplier_name" 
													placeholder="Enter Supplier Name" class="form-control"/>
										</div>
										<div class="form-group col-sm-6">
											<label for="name">Supplier Phone <span class="text-danger">*</span></label>
											<input type="text" name="supplier_phone" id="supplier_phone" 
													placeholder="Enter Phone number" class="form-control"/>
										</div>
										<div class="form-group col-sm-6">
											<label for="name">Supplier Email </label>
											<input type="email" name="supplier_email" id="supplier_email" 
													placeholder="example@gmail.com" class="form-control"/>
										</div>
										<div class="form-group col-sm-6">
											<label for="name">Supplier GSTIN </label>
											<input type="text" name="supplier_gstin" id="supplier_gstin" 
													placeholder="Enter GSTIN number" class="form-control"/>
										</div>
										<div class="form-group col-sm-6">
											<label for="name">Supplier PAN </label>
											<input type="text" name="supplier_panno" id="supplier_panno" 
													placeholder="Enter PAN NO" class="form-control"/>
										</div>
										<div class="form-group col-sm-12">
											<label for="name">Supplier Address <span class="text-danger">*</span></label>
											<textarea  name="supplier_address" id="supplier_address" 
													placeholder="Enter supplier's Address" class="form-control"></textarea>
										</div>
										<div class="form-group col-sm-6">
											<label for="business-group">Business Group <span class="text-danger">*</span></label>
											<sql:query var="business" dataSource="jdbc/rmc">
												select business_id,group_name
												from business_group
												where business_id like if(?=0,'%%',?)
												<sql:param value="${bean.business_id}"/>
												<sql:param value="${bean.business_id}"/>
											</sql:query>
											<select class="form-control" name="business_id" id="business_id">
												<c:forEach items="${business.rows}" var="business">
													<option value="${business.business_id}">${business.group_name}</option>
												</c:forEach>
											</select>
										</div>
										<div class="form-group col-sm-6">
											<label for="name">Opening Balance <span class="text-danger">*</span></label>
											<input type="text" name="opening_balance" id="opening_balance" 
													placeholder="Enter Opening Balance" class="form-control"/>
										</div>
										
										
										<div class="col-sm-12">
											<button class="btn btn-success" id="submit"  type="submit">Save Suplier</button>
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
										<th class="text-center">Supplier Name</th>
										<th class="text-center">Phone</th>
                                        <th class="text-center">Address</th>
                                        <th class="text-center">GSTIN</th>
                                        <th class="text-center">Business Group</th>
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
        <script src="js/Inward/Supplier/Suppliers.js"></script>
        
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