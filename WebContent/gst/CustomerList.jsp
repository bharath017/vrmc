<%@ include file="Session.jsp" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<!DOCTYPE html>
<html>
<head>
        <meta charset="utf-8" />
        <title>Customer List - ${initParam.company_name}</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
        <meta content="A fully featured admin theme which can be used to build CRM, CMS, etc." name="description" />
        <meta content="Coderthemes" name="author" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />

        <!-- App favicon -->
        <link rel="shortcut icon" href="../assets/images/favicon.ico">

        <!-- DataTables -->
        <link href="../plugins/datatables/dataTables.bootstrap4.min.css" rel="stylesheet" type="text/css" />
        <link href="../plugins/datatables/buttons.bootstrap4.min.css" rel="stylesheet" type="text/css" />
        

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
        	div.dt-buttons {
			    float: right;
			}
			
			.table .dropdown-menu {
			    position: relative;
			    float: none;
			    width: 160px;
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
                                    <li class="breadcrumb-item"><a href="#">Customer</a></li>
                                    <li class="breadcrumb-item active">Customer List</li>
                                </ol>
                            </div>
                            <h4 class="page-title">Customer List </h4>
                        </div>
                    </div>
                </div>
                <!-- end page title end breadcrumb -->

                <div class="row">
                <c:if test="${usertype!='operation'}">
                    <div class="col-sm-4">
                        <a href="AddCustomer.jsp" class="btn btn-custom waves-effect waves-light mb-4"  data-overlayColor="#36404a"><i class="mdi mdi-plus"></i>Add Customer</a>
                    </div><!-- end col -->
                 </c:if>   
                </div>
                
                
                <!-- end row -->

				<form id="clear-form">
						<div class="row filter-row">
							<div class="col-sm-2 col-xs-6">
		                        <div class="form-group form-focus">
		                            <label class="control-label">Customer Name : </label>
		                                <input class="form-control" placeholder="Type name here..." id="customer_name" type="text" name="customer_name">
		                        </div>
		                     </div>
		                     
		                     <div class="col-sm-2 col-xs-6">
		                        <div class="form-group form-focus">
		                            <label class="control-label">Customer Phone : </label>
		                                <input class="form-control" placeholder="Type phone no here..." id="customer_phone" type="text" name="customer_phone">
		                        </div>
		                     </div>
							
							 <div class="col-sm-2 col-xs-6">
		                        <div class="form-group form-focus">
		                            <label class="control-label">Status : </label>
		                            <div>
		                            	<label class="radio-inline">
									      <input type="radio" name="status" value="active" checked>Active
									    </label>
									    &nbsp;&nbsp;&nbsp;
									    <label class="radio-inline">
									      <input type="radio" value="inactive" name="status">Deactivated
									    </label>
		                            </div>   
		                        </div>
		                     </div>
														
		                    <div class="col-sm-2 col-xs-6">
		                        <div class="form-group form-focus select-focus">
		                            <label class="control-label">Alphabetic Wise : </label>
		                            <select class="select2 form-control floating" id="alp">
		                                <option value="">All Customer</option>
		                                <option value="a">A</option>
		                                <option value="b">B</option>
		                                <option value="c">C</option>
		                                <option value="d">D</option>
		                                <option value="e">E</option>
		                                <option value="f">F</option>
		                                <option value="g">G</option>
		                                <option value="h">H</option>
		                                <option value="i">I</option>
		                                <option value="j">J</option>
		                                <option value="k">K</option>
		                                <option value="l">L</option>
		                                <option value="m">M</option>
		                                <option value="n">N</option>
		                                <option value="o">O</option>
		                                <option value="p">P</option>
		                                <option value="q">Q</option>
		                                <option value="r">R</option>
		                                <option value="s">S</option>
		                                <option value="t">T</option>
		                                <option value="u">U</option>
		                                <option value="v">V</option>
		                                <option value="w">W</option>
		                                <option value="x">X</option>
		                                <option value="y">Y</option>
		                                <option value="z">Z</option>
		                            </select>
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
                	<h4 class="text-success">${res}</h4>
                	<c:remove var="res"/>
                    <div class="col-12">
                        <div class="card-box table-responsive">
                            <table id="example" class="table table-striped table-bordered table-condensed" cellspacing="0" width="100%">
                                <thead>
	                                <tr>
										<th class="center" style="width: 15%;">
											Customer Name
										</th>
										<th class="text-center" width="25%">Address</th>
										<th class="text-center">Phone</th>
										<th class="text-center">GSTIN No</th>
										<th class="text-center">Opening Balance</th>
										<th class="text-center">Last Dispatch Date</th>
										<th class="text-center">Sales Person</th>
										<th class="text-center" style="width:2%;">Option</th>
									</tr>
                                </thead>
                            </table>
                        </div>
                    </div>
                </div>
                <!-- end row -->
	 		<!-- MODAL FOR  DELETE START  -->
			<div id="delete-model" class="modal-demo col-xs-2">
	            <button type="button" class="close" onclick="Custombox.close();">
	                <span>&times;</span><span class="sr-only">Close</span>
	            </button>
	            <h4 class="custom-modal-title" style="color: white;background-color: #491136;"><span class="show_status text-uppercase"></span> Customer  <span class="customer_name"></span> </h4>
	            <div class="custom-modal-text">
	                <form class="form-horizontal"  method="post">
	                	<input type="hidden" id="customer_id-delete" name="customer_id">
	                	<input type="hidden" name="customer_status" id="customer_status-delete"/>
	                    <div class="form-group account-btn text-center m-t-2">
	                        <div class="col-12">
	                            <button class="btn w-lg btn-rounded btn-custom waves-effect waves-light" type="button" id="delete-btn">Change</button>
	                            <button class="btn w-lg btn-rounded btn-custom btn-danger waves-effect waves-light"  onclick="Custombox.close();" type="button">CANCEL</button>
	                        </div>
	                    </div>
	                </form>
	            </div>
	        </div>
           <!--  DELETE MODAL END  -->
                        
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
        <script type="text/javascript" src="js/Customer/CustomerList.js"></script>

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
        <script src="../assets/js/select2.min.js"></script>
    </body>
</html>