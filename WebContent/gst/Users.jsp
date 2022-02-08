<%@ include file="Session.jsp" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<!DOCTYPE html>
<html>
<head>
        <meta charset="utf-8" />
        <title>User List</title>
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


        <!-- App css -->
        <link href="../assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="../assets/css/icons.css" rel="stylesheet" type="text/css" />
        <link href="../assets/css2/style.css" rel="stylesheet" type="text/css" />
		  <!-- Custom box css -->
        <link href="../plugins/custombox/css/custombox.min.css" rel="stylesheet">
        <link href="../assets/jquery-toast/jquery.toast.min.css" rel="stylesheet" type="text/css" />
        <!-- jqury confirm -->
        <link href="../assets/jquery-confirm/jquery-confirm.min.css" rel="stylesheet" type="text/css">
        <script src="../assets/js/modernizr.min.js"></script>
        <link rel="stylesheet" href="../assets/css/select2.min.css" />
        <link rel="stylesheet" href="../assets/css/render.css">

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
                                    <li class="breadcrumb-item"><a href="#">other</a></li>
                                    <li class="breadcrumb-item active">Users</li>
                                </ol>
                            </div>
                            <h4 class="page-title">Users</h4>
                        </div>
                    </div>
                </div>
                <!-- end page title end breadcrumb -->
                <div class="row" id="doc">
                	<div class="col-5">
                    	<div class="card-box">
								<h5 class="text-center">Add/Update User Detail's</h5>
								<form id="myform" action="#">
									<div class="row">
										<div class="form-group col-sm-12">
											<label for="name">Name <span class="text-danger">*</span></label>
											<input type="hidden" name="user_id" id="user_id" value="0"/>
											<input type="text" name="user_name" id="user_name" 
													placeholder="Enter user's name" class="form-control"/>
										</div>
										<div class="form-group col-sm-6">
											<label for="name">User Phone <span class="text-danger">*</span></label>
											<input type="text" name="user_phone" id="user_phone" 
													placeholder="Enter Phone number" class="form-control"/>
										</div>
										<div class="form-group col-sm-6">
											<label for="name">User Email </label>
											<input type="email" name="user_email" id="user_email" 
													placeholder="example@gmail.com" class="form-control"/>
										</div>
										<div class="form-group col-sm-12">
											<label for="name">User Address <span class="text-danger">*</span></label>
											<textarea  name="user_address" id="user_address" 
													placeholder="Enter user's Address" class="form-control"></textarea>
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
											<label for="plant">Plant <span class="text-danger">*</span></label>
											<select class="form-control" name="plant_id" id="plant_id">
												<option value="0">All Plant</option>
											</select>
										</div>
										<div class="form-group col-sm-6">
											<label for="name">User Login ID <span class="text-danger">*</span></label>
											<input type="text" name="user_login_id" id="user_login_id" 
													placeholder="Enter Login ID" class="form-control"/>
										</div>
										<div class="form-group col-sm-6">
											<label for="name">User Password </label>
											<input type="text" name="user_password" id="user_password" 
													placeholder="Enter Password" class="form-control"/>
										</div>
										
										<div class="form-group col-sm-12">
											<label for="user_type">User Type <span class="text-danger">*</span></label>
											<select name="user_type" id="user_type" class="form-control">
												<option value="gstadmin">Admin</option>
												<option value="gstbilling">Billing</option>
												<option value="gstqc">QC</option>
												<option value="gstaccount">Accounts</option>
												<option value="gststore">Store</option>
												<option value="gstmarketing">marketing</option>
											</select>
										</div>
										<div class="col-sm-12">
											<button class="btn btn-success" id="submit"  type="submit">Save User</button>
											<button class="btn btn-danger" id="reset" type="reset">Reset</button>
										</div>
									</div>
								</form>
                    	</div>
                    </div>
                    <div class="col-7">
                        <div class="card-box table-responsive">
                        	<input type="hidden" name="type" id="type" value="nonbilling"/>
                            <table id="example" class="table table-striped table-bordered" cellspacing="0" width="100%">
                                <thead>
	                                <tr>
										<th class="text-center">Name</th>
										<th class="text-center">User Phone</th>
                                        <th class="text-center">Login ID</th>
                                        <th class="text-center">UserType</th>
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
        
         <!-- View More Detail's  -->
				<div id="view-model" class="modal-demo col-xs-2">
		            <button type="button" class="close" onclick="Custombox.close();">
		                <span>&times;</span><span class="sr-only">Close</span>
		            </button>
		            <h4 class="custom-modal-title" style="color: black;background-color: #b3e5fc;">VIEW MORE DETAILS FOR <span id="product_name-view"></span></h4>
		            <div class="custom-modal-text">
		                <form class="form-horizontal" action="InventoryController?action=cancelInventory" id="other-form" method="post">
		                	<div class="row text-left">
		                		<div class="col-sm-6">
		                			<div class="form-group">
		                				<label for="cem_type">Cementitious Type <span class="text-danger">*</span></label>
		                				<input type="hidden" id="product_id_component"/>
		                				<input type="text" name="cem_type" id="cem_type" class="form-control"/>
		                			</div>
		                		</div>
		                		<div class="col-sm-6">
		                			<div class="form-group">
		                				<label for="cem_type">Cementitious Quantity <span class="text-danger">*</span></label>
		                				<input type="text" name="cem_quantity" id="cem_quantity" class="form-control"/>
		                			</div>
		                		</div>
		                		<div class="col-sm-6">
		                			<div class="form-group">
		                				<label for="cem_type">Max Aggregate <span class="text-danger">*</span></label>
		                				<input type="text" name="max_aggregate" id="max_aggregate" class="form-control"/>
		                			</div>
		                		</div>
		                		
		                		<div class="col-sm-6">
		                			<div class="form-group">
		                				<label for="cem_type">Max Free W/C Ratio <span class="text-danger">*</span></label>
		                				<input type="text" name="max_wc" id="max_wc" class="form-control"/>
		                			</div>
		                		</div>
		                	</div>
		                	<div class="row">
		                		<table class="table table-bordered comp-table" id="comp-table">
			                		<thead>
			                			<tr>
			                				<th style="width: 5%;">S.No</th>
			                				<th>Item Name</th>
			                				<th>Quantity</th>
			                				<th>Option</th>
			                			</tr>
			                		</thead>	
			                		<tbody>
			                			
			                		</tbody>
			                		<tfoot>
			                			<tr class="text-center">
			                				<th></th>
			                				<th>
			                						<!-- Get all grades here -->
			                						<sql:query var="item" dataSource="jdbc/rmc">
			                							select inv_item_id,inventory_name from inventory_item where item_status='active'
			                						</sql:query>
			                						<select class="form-control" id="inventory_item" name="inventory_item">
			                							<c:forEach items="${item.rows}" var="item">
			                								<option value="${item.inv_item_id}">${item.inventory_name}</option>
			                							</c:forEach>
			                						</select>
			                				</th>
			                				<th>
			                						<input type="text" name="quantity" id="quantity" class="form-control"/>
			                				</th>
			                				<th>
			                					<a id="addComp">
			                						<span class="text-info"><i class="fa fa-plus"></i></span>
			                					</a>
			                				</th>
			                			</tr>
			                		</tfoot>
			                	</table>
		                	</div>
		                    <div class="form-group account-btn text-center m-t-2">
		                        <div class="col-12">
		                            <button class="btn w-lg btn-rounded btn-custom waves-effect waves-light" type="submit"><span class="change_status text-uppercase"></span>UPDATE</button>
		                            <button class="btn w-lg btn-rounded btn-custom btn-danger waves-effect waves-light"  onclick="Custombox.close();" type="button">Back</button>
		                        </div>
		                    </div>
		                </form>
		            </div>
		        </div>
        <!--  View More detail's end here -->
        
        
         <!-- DELETE MODAL FOR FLEET ITEM  -->
				<div id="delete-model" class="modal-demo col-xs-2">
		            <button type="button" class="close" onclick="Custombox.close();">
		                <span>&times;</span><span class="sr-only">Close</span>
		            </button>
		            <h4 class="custom-modal-title" style="color: white;background-color: #915d2a;">Delete Fleet Item : <span id="item_name-delete"></span></h4>
		            <div class="custom-modal-text">
		                <form class="form-horizontal" action="InventoryController?action=cancelInventory" method="post">
		                    <div class="form-group account-btn text-center m-t-2">
		                        <div class="col-12">
		                            <button class="btn w-lg btn-rounded btn-custom waves-effect waves-light" type="button" id="delete-btn"><span class="change_status text-uppercase"></span>DELETE</button>
		                            <button class="btn w-lg btn-rounded btn-custom btn-danger waves-effect waves-light"  onclick="Custombox.close();" type="button">Back</button>
		                        </div>
		                    </div>
		                </form>
		            </div>
		        </div>
        <!--  FLEET DELETE MODAL FINISHED HERE -->
        
        
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
        <script type="text/javascript" src="../angular/angular.min.js"></script>

        <!-- App js -->
        <script src="../assets/js/jquery.core.js"></script>
        <script src="../assets/js/jquery.app.js"></script>
        <script type="text/javascript" src="../validation/jquery.validate.js"></script>
        <script src="js/other/User/Users.js"></script>
        
        <!-- Required datatable js -->
        <script src="../plugins/datatables/jquery.dataTables.min.js"></script>
        <script src="../plugins/datatables/dataTables.bootstrap4.min.js"></script>
        
        <!-- Modal-Effect -->
        <script src="../plugins/custombox/js/custombox.min.js"></script>
        <script src="../plugins/custombox/js/legacy.min.js"></script>
        
        <!-- Autocomplete -->
        <script src="../plugins/autocomplete/jquery.autocomplete.min.js"></script>
        <!-- Jquery confirm -->
        <script type="text/javascript" src="../assets/jquery-confirm/jquery-confirm.min.js"></script>
        <script src="../assets/js/select2.min.js"></script>

    </body>
</html>