<%@ include file="Session.jsp" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<!DOCTYPE html>
<html>
<head>
        <meta charset="utf-8" />
        <title>Petty Cash List</title>
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
		<link href="../assets/jquery-toast/jquery.toast.min.css" rel="stylesheet" type="text/css" />
        <script src="../assets/js/modernizr.min.js"></script>
        <style type="text/css">
        	.hidden{
        		display: none;
        	}
        	div.dt-buttons {
			    float: right;
			}
			
			.error{
				color: red;
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
                                    <li class="breadcrumb-item active">Petty Cash</li>
                                    <li class="breadcrumb-item active">Petty Cash List</li>
                                </ol>
                            </div>
                            <h4 class="page-title">Petty Cash Transaction Manager</h4>
                        </div>
                    </div>
                </div>
                <!-- end page title end breadcrumb -->
				
				<div class="row text-center">
						<div class="col-xs-6 col-sm-2 text-center">
                             <div class="card-box widget-flat border-custom bg-custom text-white">
                                 <i class=" fa fa-money"></i>
                                 <h3 class="m-b-10" id="petty-cash-amount"></h3>
                                 <p class="text-uppercase m-b-5 font-13 font-600">PETTY CASH AMOUNT</p>
                             </div>
                         </div>
                         <div class="col-xs-6 col-sm-2 text-center" >
                             <div class="card-box widget-flat  text-white" style="background-color: #f0b930;border-color:#f0b930;">
                                 <i class=" fa fa-money"></i>
                                 <h3 class="m-b-10" id="transaction-amount"></h3>
                                 <p class="text-uppercase m-b-5 font-13 font-600">TRANSACTION AMOUNT</p>
                             </div>
                         </div>
                         <div class="col-xs-6 col-sm-2 text-center">
                             <div class="card-box widget-flat text-white" style="background-color: #307df0;border-color:#307df0;">
                                 <i class=" fa fa-money"></i>
                                 <h3 class="m-b-10" id="remaining-amount"></h3>
                                 <p class="text-uppercase m-b-5 font-13 font-600">REMAINING AMOUNT</p>
                             </div>
                         </div>
                         <div class="col-xs-6 col-sm-2 text-center">
                             <div class="card-box widget-flat text-white" style="background-color: #c630f0;border-color:#c630f0;">
                                 <i class=" fa fa-money"></i>
                                 <h3 class="m-b-10" id="pending-petty-cash"></h3>
                                 <p class="text-uppercase m-b-5 font-13 font-600">PENDING PETTY CASH</p>
                             </div>
                         </div>
                         
                         <div class="col-xs-6 col-sm-2 text-center" id="pending-transaction-btn">
                             <div class="card-box widget-flat text-white" style="background-color: #f5652c;border-color:#f5652c;">
                                 <i class=" fa fa-money"></i>
                                 <h3 class="m-b-10" id="pending-transaction"></h3>
                                 <p class="text-uppercase m-b-5 font-13 font-600">PENDING BILL</p>
                                 <input type="hidden" value="" id="pending-transaction-status"/>
                             </div>
                         </div>
                         
                         <div class="col-xs-6 col-sm-2 text-center">
                         	<button class="btn btn-success btn-lg" id="newTransBtn">New Transaction</button><br><br>
                         	<a class="btn btn-info" href="PettyCashReport.jsp">Transaction Report</a><br><br>
                         </div>
				</div>
				
				<div class="row">
					<div class="col-sm-6">
						<form id="clear-form">
							<div class="row filter-row">
								<div class="col-sm-3 col-xs-6 form-group">
			                        <label> From Date : </label>
			                        <div>
			                            <div class="input-group">
			                            	<input type="hidden" id="cash_id" value=""/>
			                            	<input type="hidden" id="plant_id" value="0"/>
			                            	 
			                                <input type="text" name="from_date" id="from_date" class="form-control date-picker "
			                                		 placeholder="dd/mm/yyyy" id="id-date-picker-1"
			                                		 data-date-format="dd/mm/yyyy" readonly="readonly" style="background-color: white;">
			                                <div class="input-group-append picker">
			                                    <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
			                                </div>
			                            </div>
			                        </div>
			                    </div>
			                    
			                    <div class="col-sm-3 col-xs-6 form-group">
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
			                <div class="row">
			                    <div class="col-12">
			                        <div class="card-box table-responsive">
			                            <span class="text-warning pull-right" style="font-weight: bold;">PETTY CASH LIST</span>
			                            <table id="example" class="table table-striped table-bordered table-condensed text-center" cellspacing="0" width="100%">
			                                <thead>
				                                <tr>
													<th class="center">
														 Cash Id
													</th>
													<th class="text-center">Date</th>
													<th class="text-center">Amount</th>
													<th class="text-center">Received Person</th>
													<th class="text-center">Purpose</th>
													<th class="text-center">Plant</th>
													<th class="text-center">Option</th>
												</tr>
			                                </thead>
			                            </table>
			                        </div>
			                    </div>
			                </div>
					</div>
					<div class="col-sm-6">
						<form id="clear1-form">
							<div class="row filter-row">
								<div class="col-sm-3 col-xs-6 form-group">
			                        <label> From Date : </label>
			                        <div>
			                            <div class="input-group">
			                                <input type="text" name="from_date" id="from_date-transaction" 
			                                	   class="form-control date-picker " placeholder="dd/mm/yyyy"
			                                	   id="id-date-picker-1" data-date-format="dd/mm/yyyy" 
			                                	   readonly="readonly" style="background-color: white;"/>
			                                <div class="input-group-append picker">
			                                    <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
			                                </div>
			                            </div>
			                        </div>
			                    </div>
			                    
			                    <div class="col-sm-3 col-xs-6 form-group">
			                        <label>To Date : </label>
			                        <div>
			                            <div class="input-group">
			                                <input type="text" name="to_date" id="to_date-transaction"
			                                	   class="form-control date-picker " placeholder="dd/mm/yyyy"
			                                	   id="id-date-picker-1" data-date-format="dd/mm/yyyy"
			                                	   readonly="readonly" style="background-color: white;"/>
			                                <div class="input-group-append picker">
			                                    <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
			                                </div>
			                            </div>
			                        </div>
			                    </div>
			                    
			                    <div class="col-sm-2 col-xs-6">
			                        <div class="form-group form-focus select-focus">
			                            <label class="control-label">Plant : </label>
			                            <sql:query var="plant" dataSource="jdbc/rmc">
			                            	select plant_id,plant_name from plant where plant_id like if(0=?,'%%',?)
			                            	<sql:param value="${bean.plant_id}"/>
			                            	<sql:param value="${bean.plant_id}"/>
			                            </sql:query>
			                            <select class="select2 form-control floating" id="plnt-id">
			                            	<c:if test="${bean.plant_id==0}">
			                            		<option value="0">All Plant</option>
			                            	</c:if>
			                            	<c:forEach items="${plant.rows}" var="plant">
			                            		<option value="${plant.plant_id}">${plant.plant_name}</option>
			                            	</c:forEach>
			                            </select>
			                        </div>
			                    </div>
			                    
			                    <div class="col-sm-2 col-xs-6">
			                        <div class="form-group form-focus">
			                            <label class="control-label">&nbsp;</label>
			                            <a  id="search_transaction" class="btn btn-success btn-block" > Search </a>
			                        </div>
			                    </div>
			                    
			                    <div class="col-sm-2 col-xs-6">
			                        <div class="form-group form-focus">
			                            <label class="control-label">&nbsp;</label>
			                            <a  id="clear-transaction" class="btn btn-danger btn-block"> Clear </a>
			                        </div>
			                    </div>
			                </div>
			                </form>
			                <div class="row">
			                    <div class="col-12">
			                        <div class="card-box table-responsive">
			                            <span class="text-warning pull-right" style="font-weight: bold;">PETTY CASH  TRANSACTION LIST</span>
			                            <table id="example-2" class="table table-striped table-bordered table-condensed text-center" cellspacing="0" width="100%">
			                                <thead>
				                                <tr>
													<th class="center">
														 Tr. ID
													</th>
													<th class="text-center">Date</th>
													<th class="text-center">Amount</th>
													<th class="text-center">Description</th>
													<th class="text-center">Plant</th>
													<th class="text-center">Bill?</th>
													<th class="text-center">Option</th>
												</tr>
			                                </thead>
			                            </table>
			                        </div>
			                    </div>
			                </div>
					</div>
				</div>
                <!-- end row -->
                
                
                <!-- PETTY CASH APPROVAL STATUS  -->
				<div id="approve-modal" class="modal-demo col-xs-2">
		            <button type="button" class="close" onclick="Custombox.close();">
		                <span>&times;</span><span class="sr-only">Close</span>
		            </button>
		            <h4 class="custom-modal-title" style="color: white;background-color: #3ea39c;">Did you received payment ?</h4>
		            <div class="custom-modal-text">
		                <form class="form-horizontal"  method="post">
		                	<input type="hidden" name="cash_id" id="cash_id-status" class="cash_id"/>
		                    <div class="form-group account-btn text-center m-t-2">
		                        <div class="col-12">
		                            <button class="btn w-lg btn-rounded btn-custom waves-effect waves-light" type="button" id="approve-btn"><span class="change_status text-uppercase">Yes</span></button>
		                            <button class="btn w-lg btn-rounded btn-custom btn-danger waves-effect waves-light"  onclick="Custombox.close();" type="button">No</button>
		                        </div>
		                    </div>
		                </form>
		            </div>
		        </div>
                <!--  END OF PETTY CASH APPROVAL STATUS -->
                
                <!-- MODAL FOR PLANT DELETE START  -->
				<div id="delete-model" class="modal-demo col-xs-2">
		            <button type="button" class="close" onclick="Custombox.close();">
		                <span>&times;</span><span class="sr-only">Close</span>
		            </button>
		            <h4 class="custom-modal-title" style="color: white;background-color: #9b3329;">Are you sure want to delete this Transaction id : <span class="transaction_id-delete"></span>?</h4>
		            <div class="custom-modal-text">
		                <form class="form-horizontal"  method="post">
		                	<input type="hidden" name="transaction_id" id="transaction_id-delete" class="transaction_id-delete"/>
		                    <div class="form-group account-btn text-center m-t-2">
		                        <div class="col-12">
		                            <button class="btn w-lg btn-rounded btn-custom waves-effect waves-light" type="button" id="delete-btn"><span class="change_status text-uppercase">Delete Transaction</span></button>
		                            <button class="btn w-lg btn-rounded btn-custom btn-danger waves-effect waves-light"  onclick="Custombox.close();" type="button">Exit</button>
		                        </div>
		                    </div>
		                </form>
		            </div>
		        </div>
                <!--  PLANT DELETE MODAL END  -->
                
                
                
                <!-- MODAL FOR PLANT DELETE START  -->
				<div id="transaction-model" class="modal-demo col-xs-2">
		            <button type="button" class="close" onclick="Custombox.close();">
		                <span>&times;</span><span class="sr-only">Close</span>
		            </button>
		            <h4 class="custom-modal-title bg-custom">ADD NEW TRANSACTION</h4>
		            <div class="custom-modal-text">
		                <form class="form-horizontal text-left" action="#"  method="post" id="transaction-form">
		                	<div class="form-group">
		                		<label for="plant_id">Plant <span class="text-danger">*</span></label>
		                		<select class="form-control" name="plant_id" id="plant_id-transaction">
		                			
		                		</select>
		                	</div>
		                	<div class="form-group">
		                        <label for="date">Date <span class="text-danger">*</span></label>
		                        <div>
		                            <div class="input-group">
		                                <input type="text" name="date" id="date-transaction"
		                                	 class="form-control date-picker " placeholder="dd/mm/yyyy"
		                                	  id="id-date-picker-1" data-date-format="dd/mm/yyyy" readonly="readonly" style="background-color: white;">
		                                <div class="input-group-append picker">
		                                    <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
		                                </div>
		                            </div>
		                            <label id="date-transaction-error" class="error" for="date-transaction"></label>
		                        </div>
			                 </div>
			                 <div class="form-group">
			                 	<label for="amount">Amount <span class="text-danger">*</span></label>
			                 	<input type="text" class="form-control" placeholder="Enter amount" name="amount" id="amount-transaction">
			                 </div>
			                 <div class="form-group">
                                   <label>Purpose<span class="text-danger">*</span></label>
                                     <select class="form-control"  id="purpose" data-placeholder="Please select purpose" name="purpose">
                                     <option value="" >Please select purpose</option>
                                     <option value="Advance">Advance</option>
                                     <option value="Expenses">Expenses</option>
                                     </select>
                               </div>
			                 <div class="form-group">
			                 	<label for="description">Description <span class="text-danger">*</span></label>
			                 	<textarea class="form-control" name="description" id="description-transaction" placeholder="Enter particular here..."></textarea>
			                 </div>
		                    <div class="form-group account-btn text-center m-t-2">
		                        <div class="col-12">
		                            <button class="btn w-lg btn-rounded btn-custom waves-effect waves-light" type="submit"><span class="change_status text-uppercase">Save</span></button>
		                            <button class="btn w-lg btn-rounded btn-custom btn-danger waves-effect waves-light"  onclick="Custombox.close();" type="button">Exit</button>
		                        </div>
		                    </div>
		                </form>
		            </div>
		        </div>
                <!--  PLANT DELETE MODAL END  -->
                
                
                <!-- PETTY CASH TRANSACTION UPDATE MODAL -->
				<div id="transaction-update-model" class="modal-demo col-xs-2">
		            <button type="button" class="close" onclick="Custombox.close();">
		                <span>&times;</span><span class="sr-only">Close</span>
		            </button>
		            <h4 class="custom-modal-title bg-custom">UPDATE TRANSACTION</h4>
		            <div class="custom-modal-text">
		                <form class="form-horizontal text-left" action="#"  method="post" id="transaction-update-form">
		                	<div class="form-group">
		                		<label for="plant_id">Plant <span class="text-danger">*</span></label>
		                		<input type="hidden" id="transaction_id" name="transaction_id" value="0"/>
		                		<select class="form-control" name="plant_id" id="plant_id-transaction-update">
		                			
		                		</select>
		                	</div>
		                	<div class="form-group">
		                        <label for="date">Date <span class="text-danger">*</span></label>
		                        <div>
		                            <div class="input-group">
		                                <input type="text" name="date" id="date-transaction-update"
		                                	   class="form-control date-picker " placeholder="dd/mm/yyyy" id="id-date-picker-1"
		                                	   data-date-format="dd/mm/yyyy" readonly="readonly" style=" background-color: white;">
		                                <div class="input-group-append picker">
		                                    <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
		                                </div>
		                            </div>
		                            <label id="date-transaction-error" class="error" for="date-transaction"></label>
		                        </div>
			                 </div>
			                 <div class="form-group">
			                 	<label for="amount">Amount <span class="text-danger">*</span></label>
			                 	<input type="text" class="form-control" placeholder="Enter amount" name="amount" id="amount-transaction-update">
			                 </div>
			                <div class="form-group">
                                   <label>Purpose<span class="text-danger">*</span></label>
                                     <select class="form-control"  id="purpose-update" data-placeholder="Please select purpose" name="purpose">
                                     <option value="" >Please select purpose</option>
                                     <option value="Advance">Advance</option>
                                     <option value="Expenses">Expenses</option>
                                     </select>
                               </div>
			                 <div class="form-group">
			                 	<label for="description">Description <span class="text-danger">*</span></label>
			                 	<textarea class="form-control" name="description" id="description-transaction-update" placeholder="Enter particular here..."></textarea>
			                 </div>
		                    <div class="form-group account-btn text-center m-t-2">
		                        <div class="col-12">
		                            <button class="btn w-lg btn-rounded btn-custom waves-effect waves-light" type="submit"><span class="change_status text-uppercase">UPDATE</span></button>
		                            <button class="btn w-lg btn-rounded btn-custom btn-danger waves-effect waves-light"  onclick="Custombox.close();" type="button">Exit</button>
		                        </div>
		                    </div>
		                </form>
		            </div>
		        </div>
                <!-- PETTY CASH TRANSACTION UPDATE MODAL  -->

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
        <script type="text/javascript" src="js/Accounts/PettyCash/PettyCashTransaction.js"></script>

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