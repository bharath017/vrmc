<%@ include file="Session.jsp" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<!DOCTYPE html>
<html>
<head>
        <meta charset="utf-8" />
        <title>HRM Setting</title>
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

		<!-- Date picker details -->
		<link rel="stylesheet" href="picker/cs/bootstrap-datepicker3.min.css" />
		<link rel="stylesheet" href="picker/cs/bootstrap-timepicker.min.css" />


        <!-- App css -->
        <link href="assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/icons.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/style.css" rel="stylesheet" type="text/css" />
        <link rel="stylesheet" href="assets/css/select2.min.css" />
        <link rel="stylesheet" href="assets/css/render.css">
		  <!-- Custom box css -->
        <link href="plugins/custombox/css/custombox.min.css" rel="stylesheet">
        <link href="assets/jquery-toast/jquery.toast.min.css" rel="stylesheet" type="text/css" />
		
        <script src="assets/js/modernizr.min.js"></script>

		<style type="text/css">
			.error{
				color:red;
			}
			
			.hidden{
				display: none;
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
                                    <li class="breadcrumb-item"><a href="#">HRM</a></li>
                                    <li class="breadcrumb-item active">Setting</li>
                                    <li class="breadcrumb-item active">HRM Setting</li>
                                </ol>
                            </div>
                            <h4 class="page-title">HRM Setting</h4>
                        </div>
                    </div>
                </div>
                <!-- end page title end breadcrumb -->
                <div class="row">
                	<div class="col-sm-12">
                		<div class="col-xl-12">
							<div class="card-box">
								<h4 class="header-title m-b-30">HRM Setting</h4>
								<ul class="nav nav-pills navtab-bg nav-justified pull-in">
									<li class="nav-item"><a href="#settings1" data-toggle="tab"
										aria-expanded="false" class="nav-link active"><i class="fi-cog"></i>
											<span class="d-none d-sm-inline-block ml-2">Designation</span></a></li>
											
									<li class="nav-item"><a href="#settings2" data-toggle="tab"
										aria-expanded="false" class="nav-link"><i class="fi-cog"></i>
											<span class="d-none d-sm-inline-block ml-2">Department</span></a></li>
								</ul>
								
								<div class="tab-content">
									<div class="tab-pane text-center show active" id="settings1">
										<div class="row">
											<div class="col-sm-3"></div>
											<div class="col-sm-6">
												<div class="row">
													<div class="col-sm-6">
														<input type="hidden" name="designation_id" value="0" id="designation_id"/>
														<input type="text" class="form-control" name="designation_name" id="designation_name"/>
														<label for="designation_name-error" class="error"></label>
													</div>
													<div class="col-sm-2">
														<button class="btn btn-success" id="save-designation">Save Designation</button>&nbsp;&nbsp;&nbsp;
													</div>
													&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
													<div class="col-sm-2">
														<button class="btn btn-danger" id="clear-designation">Clear</button>
													</div>
												</div>
												<br><br>																								
												<table id="designation_list" class="table table-striped table-bordered" cellspacing="0" width="100%">
					                                <thead>
						                                <tr>
															<th class="text-center">ID</th>
					                                        <th class="text-center">Designation</th>
					                                        <th class="text-center">Option</th>
														</tr>
					                                </thead>
					                                <tbody class="text-center">
					                                </tbody>
					                            </table>
											</div>
										</div>
									</div>
									
									<div class="tab-pane" id="settings2">
									    <div class="row">
											<div class="col-sm-3"></div>
											<div class="col-sm-6">
												<div class="row">
													<div class="col-sm-6">
														<input type="hidden" name="department_id" value="0" id="department_id"/>
														<input type="text" class="form-control" name="department_name" id="department_name"/>
														<label for="department_name-error" class="error"></label>
													</div>
													<div class="col-sm-2">
														<button class="btn btn-success" id="save-department">Save Department</button>&nbsp;&nbsp;&nbsp;
													</div>
													&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
													<div class="col-sm-2">
														<button class="btn btn-danger" id="clear-department">Clear</button>
													</div>
												</div>
												<br><br>																								
												<table id="deparments" class="table table-striped table-bordered" cellspacing="0" style="width: 100%;">
					                                <thead>
						                                <tr style="widows: 100%">
															<th class="text-center" style="width: 30%;">ID</th>
					                                        <th class="text-center">Department</th>
					                                        <th class="text-center">Option</th>
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
						</div>
                	</div>
                </div>
             </div>
          </div>
          
          
          <!-- DELETE MODAL FOR FLEET ITEM  -->
				<div id="delete-model" class="modal-demo col-xs-2">
		            <button type="button" class="close" onclick="Custombox.close();">
		                <span>&times;</span><span class="sr-only">Close</span>
		            </button>
		            <h4 class="custom-modal-title" style="color: white;background-color: #915d2a;">Delete Designation: <span id="designation_name-delete"></span></h4>
		            <div class="custom-modal-text">
		                <form class="form-horizontal" action="InventoryController?action=cancelInventory" method="post">
		                	<input type="hidden" name="designation_id-delete" id="designation_id-delete"/>
		                    <div class="form-group account-btn text-center m-t-2">
		                        <div class="col-12">
		                            <button class="btn w-lg btn-rounded btn-custom waves-effect waves-light" type="button" id="designtation-delete-btn"><span class="change_status text-uppercase"></span>DELETE</button>
		                            <button class="btn w-lg btn-rounded btn-custom btn-danger waves-effect waves-light"  onclick="Custombox.close();" type="button">Back</button>
		                        </div>
		                    </div>
		                </form>
		            </div>
		        </div>
        <!--  FLEET DELETE MODAL FINISHED HERE -->
        
        
        <!-- DELETE MODAL FOR DEPARTMENT -->
				<div id="department-delete-modal" class="modal-demo col-xs-2">
		            <button type="button" class="close" onclick="Custombox.close();">
		                <span>&times;</span><span class="sr-only">Close</span>
		            </button>
		            <h4 class="custom-modal-title" style="color: white;background-color: #915d2a;">Delete department : <span id="department_name-delete"></span></h4>
		            <div class="custom-modal-text">
		                <form class="form-horizontal" action="InventoryController?action=cancelInventory" method="post">
		                	<input type="hidden" name="department_id-delete" id="department_id-delete"/>
		                    <div class="form-group account-btn text-center m-t-2">
		                        <div class="col-12">
		                            <button class="btn w-lg btn-rounded btn-custom waves-effect waves-light" type="button" id="department-delete-btn"><span class="change_status text-uppercase"></span>DELETE</button>
		                            <button class="btn w-lg btn-rounded btn-custom btn-danger waves-effect waves-light"  onclick="Custombox.close();" type="button">Back</button>
		                        </div>
		                    </div>
		                </form>
		            </div>
		        </div>
        <!--  DEPARTMENT DELETE MODAL FINISHED HERE -->
        
        
        <!-- DELETE MODAL FOR REPORTING MANAGER -->
				<div id="reportingmanager-delete-modal" class="modal-demo col-xs-2">
		            <button type="button" class="close" onclick="Custombox.close();">
		                <span>&times;</span><span class="sr-only">Close</span>
		            </button>
		            <h4 class="custom-modal-title" style="color: white;background-color: #915d2a;">Delete Reporting Manager : <span id="reportingmanager_name-delete"></span></h4>
		            <div class="custom-modal-text">
		                <form class="form-horizontal" action="InventoryController?action=cancelInventory" method="post">
		                	<input type="hidden" name="e_id-delete" id="e_id-delete"/>
		                    <div class="form-group account-btn text-center m-t-2">
		                        <div class="col-12">
		                            <button class="btn w-lg btn-rounded btn-custom waves-effect waves-light" type="button" id="reportingmanager-delete-btn"><span class="change_status text-uppercase"></span>DELETE</button>
		                            <button class="btn w-lg btn-rounded btn-custom btn-danger waves-effect waves-light"  onclick="Custombox.close();" type="button">Back</button>
		                        </div>
		                    </div>
		                </form>
		            </div>
		        </div>
        <!--  REPORTING MANAGER DELETE MODAL FINISHED HERE -->
                    
        
        
        <!-- PUT FOOTER.JSP HERE -->
        <%@ include file="footer.jsp" %>
        <!-- End Footer -->
        
        
        <input type="hidden" id="session_plant" value="${bean.plant_id}"/>
		<input type="hidden" id="usertype" value="${bean.usertype}">
		<script type="text/javascript">
        	function getSessionData(){
        		var obj={
        			plant_id:$('#session_plant').val(),
        			usertype:$('#usertype').val()
        		}
        		return obj;
        	}
        </script>

        <!-- jQuery  -->
        <script src="assets/js/jquery.min.js"></script>
        <script src="assets/js/popper.min.js"></script>
        <script src="assets/js/bootstrap.min.js"></script>
        <script src="assets/js/waves.js"></script>
        <script src="assets/js/jquery.slimscroll.js"></script>
        <script src="assets/jquery-toast/jquery.toast.min.js"></script>

        <!-- App js -->
        <script src="assets/js/jquery.core.js"></script>
        <script src="assets/js/jquery.app.js"></script>
        <script type="text/javascript" src="validation/jquery.validate.js"></script>
        <script type="text/javascript" src="angular/angular.min.js"></script>
        <script src="js/hrm/HRMSetting.js"></script>
        
        <!-- Required datatable js -->
        <script src="plugins/datatables/jquery.dataTables.min.js"></script>
        <script src="plugins/datatables/dataTables.bootstrap4.min.js"></script>
        
        <!--Select2 js file  -->
        <script src="assets/js/select2.min.js"></script>
        <script src="picker/js/moment.min.js"></script>
        
        <!-- Datepicker details goes here  -->
        <script src="picker/js/bootstrap-datepicker.min.js"></script>
		<script src="assets/js/bootstrap-timepicker.min.js"></script>
        
        <!-- Modal-Effect -->
        <script src="plugins/custombox/js/custombox.min.js"></script>
        <script src="plugins/custombox/js/legacy.min.js"></script>
        
        <!-- Autocomplete -->
        <script src="plugins/autocomplete/jquery.autocomplete.min.js"></script>
    </body>
</html>