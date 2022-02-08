<%@ include file="Session.jsp" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<!DOCTYPE html>
<html>
<head>
        <meta charset="utf-8" />
        <title>Material Consumption</title>
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
        <link href="../assets/jquery-toast/jquery.toast.min.css" rel="stylesheet" type="text/css" />
        <!-- jqury confirm -->
        <link href="../assets/jquery-confirm/jquery-confirm.min.css" rel="stylesheet" type="text/css">
        <script src="../assets/js/modernizr.min.js"></script>
        <link rel="stylesheet" href="../assets/css2/select2.min.css" />
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
                                    <li class="breadcrumb-item"><a href="#">Inventory</a></li>
                                    <li class="breadcrumb-item active">Add Material Consumption</li>
                                </ol>
                            </div>
                            <h4 class="page-title">Material Consumption</h4>
                        </div>
                    </div>
                </div>
                <!-- end page title end breadcrumb -->
                <div class="row" id="doc">
                	<div class="col-5">
                    	<div class="card-box">
								<h5 class="text-center">Add/Update Material Consumption</h5>
								<form id="myform" action="#">
									<div class="row">
										<div class="form-group col-sm-6">
											<label for="name">Plant Name <span class="text-danger">*</span></label>
											<sql:query var="plant" dataSource="jdbc/rmc">
												select plant_id,plant_name
												from plant
												where business_id like if(?=0,'%%',?)
												and plant_id like if(?=0,'%%',?)
												<sql:param value="${bean.business_id}"/> 
												<sql:param value="${bean.business_id}"/>											
												<sql:param value="${bean.plant_id}"/>
												<sql:param value="${bean.plant_id}"/>
											</sql:query>
											<select class="form-control" name="plant_id" id="plant_id">
												<c:forEach items="${plant.rows}" var="plant">
													<option value="${plant.plant_id}">${plant.plant_name}</option>
												</c:forEach>
											</select>
										</div>
										<div class="form-group col-sm-6">
											<label for="name">Material Name <span class="text-danger">*</span></label>
											<sql:query var="inv" dataSource="jdbc/rmc">
												select inv_item_id,inventory_name
												from inventory_item 
											</sql:query>
											<select class="form-control" name="inv_item_id" id="inv_item_id">
												<c:forEach items="${inv.rows}" var="inv">
													<option value="${inv.inv_item_id}">${inv.inventory_name}</option>
												</c:forEach>
											</select>
										</div>
										<div class="form-group col-sm-6">
					                        <label>Consumption Date <span class="text-custom">*</span> </label>
					                        <div>
					                            <div class="input-group">
					                                <input type="text" name="consumption_date" id="consumption_date" class="form-control date-picker" 
					                                		readonly="readonly" placeholder="dd/mm/yyyy" id="id-date-picker-1" data-date-format="dd/mm/yyyy" style="background-color: white;">
					                                <div class="input-group-append picker">
					                                    <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
					                                </div>
					                            </div>
					                            <label id="consumption_date-error" class="error" for="consumption_date" style="display: none;"></label>
					                        </div>
					                    </div>
										<div class="form-group col-sm-6">
											<label for="name">Consumption Quantity</label>
											<input type="text" name="consumption_quantity" id="consumption_quantity" 
													placeholder="Enter Consumption Quantity" class="form-control"/>
										</div>
										<div class="form-group col-sm-6">
											<label for="name">Added By <span class="text-danger">*</span></label>
											<input type="text" name="added_by" id="added_by" 
													 class="form-control"/>
										</div>
										<div class="form-group col-sm-12">
											<label for="name">Comment </label>
											<textarea  name="comment" id="comment" 
													placeholder="Enter Comment..." class="form-control"></textarea>
										</div>
										<div class="col-sm-12">
											<button class="btn btn-success" id="submit"  type="submit">Save Consumption</button>
											<button class="btn btn-danger" id="reset" type="reset">Reset</button>
										</div>
									</div>
								</form>
                    	</div>
                    </div>
                    <div class="col-7">
                        <div class="card-box table-responsive">
                        	<input type="hidden" name="type" id="type" value="billing"/>
                        	<form id="clear-form">
							<div class="row filter-row">
								<div class="col-sm-2 col-xs-6 form-group">
			                        <label> From Date <span class="text-custom">*</span> </label>
			                        <div>
			                            <div class="input-group">
			                                <input type="text" name="from_date" id="from_date" class="form-control date-picker" 
			                                		readonly="readonly" placeholder="dd/mm/yyyy" id="id-date-picker-1" data-date-format="dd/mm/yyyy" style="background-color: white;">
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
			                                <input type="text" name="to_date" id="to_date" class="form-control date-picker" readonly="readonly"
			                                		 placeholder="dd/mm/yyyy" id="id-date-picker-1" data-date-format="dd/mm/yyyy" style="background-color: white;">
			                                <div class="input-group-append picker">
			                                    <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
			                                </div>
			                            </div>
			                        </div>
			                    </div>
			                    
			                    <div class="col-sm-2 col-xs-6">
			                        <div class="form-group form-focus select-focus">
			                            <label class="control-label">Inventory Item <span class="text-custom">*</span> </label>
			                            <sql:query var="inv" dataSource="jdbc/rmc">
			                            	select inv_item_id,inventory_name
			                            	from inventory_item
			                            </sql:query>
			                            <select class="form-control floating" id="inv_item_id_view">
			                                <option value="0">All Item</option>
			                                <c:forEach items="${inv.rows}" var="inv">
			                                	<option value="${inv.inv_item_id}">${inv.inventory_name}</option>
			                                </c:forEach>
			                            </select>
			                        </div>
			                    </div>
			                    
			                     <div class="col-sm-2 col-xs-6">
			                        <div class="form-group form-focus select-focus">
			                        	<sql:query var="plant" dataSource="jdbc/rmc">
			                        		select plant_id,plant_name
			                        		from plant
			                        		where plant_id like if(0=?,'%%',?)
			                        		<sql:param value="${bean.plant_id}"/>
			                        		<sql:param value="${bean.plant_id}"/>
			                        	</sql:query>
			                            <label class="control-label">Plant <span class="text-custom">*</span> </label>
			                            <select class="form-control floating" id="plant_id_view" name="plant_id">
			                               <c:forEach items="${plant.rows}" var="plant">
			                               		<option value="${plant.plant_id}">${plant.plant_name}</option>
			                               </c:forEach>
			                            </select>
			                        </div>
			                    </div>
			                    
			                    <div class="col-sm-2 col-xs-6">
			                        <div class="form-group form-focus">
			                            <label class="control-label">&nbsp;</label>
			                            <a  id="search" class="btn btn-success btn-block"> Search </a>
			                        </div>
			                    </div>
			                    
			                    <div class="col-sm-2 col-xs-6">
			                        <div class="form-group form-focus">
			                            <label class="control-label">&nbsp;</label>
			                            <a  id="clear" class="btn btn-danger btn-block"> Clear </a>
			                        </div>
			                    </div>
			                </div>
			                </form>
                            <table id="example" class="table table-striped table-bordered" cellspacing="0" width="100%">
                                <thead>
	                                <tr>
										<th class="text-center">Material Name</th>
										<th class="text-center">Consumption Quantity</th>
                                        <th class="text-center">Date</th>
                                        <th class="text-center">Plant</th>
                                        <th class="text-center">Comment</th>
                                        <th class="text-center">Added By</th>
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
        <script src="../picker/js/bootstrap-datepicker.min.js"></script>
		<script src="../assets/js/bootstrap-timepicker.min.js"></script>
		<script src="../picker/js/moment.min.js"></script>
		<script type="text/javascript" src="../js/Pickers/dateTimeValidator.js"></script>
        <script src="../js/Inward/Inventory/inventoryoutgoing/AddInventoryOutgoing.js"></script>
        
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