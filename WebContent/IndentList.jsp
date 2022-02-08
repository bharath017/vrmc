<%@ include file="Session.jsp" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<!DOCTYPE html>
<html>
<head>
        <meta charset="utf-8" />
        <title>Indent List</title>
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
        <style type="text/css">
        	.hide{
        		display: none;
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
                                    <li class="breadcrumb-item"><a href="#">Inventory</a></li>
                                    <li class="breadcrumb-item active">Indent</li>
                                    <li class="breadcrumb-item active">Indent List</li>
                                </ol>
                            </div>
                            <h4 class="page-title">Indent List</h4>
                        </div>
                    </div>
                </div>
                <!-- end page title end breadcrumb -->

                <div class="row">
                    <div class="col-sm-4">
                        <a href="RaiseIndent.jsp" class="btn btn-custom waves-effect waves-light mb-4"  data-overlayColor="#36404a"><i class="mdi mdi-plus"></i> Raise Indent</a>
                    </div><!-- end col -->
                </div>
                <!-- end row -->
                
				<div class="row filter-row">
                    <div class="col-sm-3 col-xs-6">
                        <div class="form-group form-focus">
                            <label class="control-label">Indent Number</label>
                                <input class="form-control" placeholder="Enter PO Number" id="po_number" type="text" name="po_number">
                        </div>
                    </div>
                <%--     <div class="col-sm-3 col-xs-6">
                        <div class="form-group form-focus select-focus">
                            <label class="control-label">Choose Supplier</label>
                            <sql:query var="customer" dataSource="jdbc/rmc">
                            	select * from supplier where supplier_status='active'
                            </sql:query>
                            <select class="select2 form-control floating" id="supplier_id">
                                <option value="">All Supplier</option>
                                <c:forEach items="${customer.rows}" var="customer">
                                	<option value="${customer.supplier_id}">${customer.supplier_name}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div> --%>
                    <div class="col-sm-3 col-xs-6 form-group">
                        <label>Indent Date : </label>
                        <div>
                            <div class="input-group">
                                <input type="text" name="scheduling_date" class="form-control date-picker inventory_date" placeholder="yyyy-mm-dd" id="id-date-picker-1" data-date-format="yyyy-mm-dd">
                                <div class="input-group-append">
                                    <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-sm-3 col-xs-6">
                        <div class="form-group form-focus">
                            <label class="control-label">&nbsp;</label>
                            <a href="#" id="search" class="btn btn-success btn-block"> Search </a>
                        </div>
                    </div>
                </div>
                
                
                <div class="row">
                    <div class="col-12">
                        <div class="card-box table-responsive">
                            <h4 style="color: green;">${res}</h4>
                            <c:remove var="res"/>
                            <table id="example" class="table table-striped table-bordered table-condensed" cellspacing="0" width="100%">
                                <thead>
	                                <tr>
										<th class="center">
											Indent Id
										</th>
										<th class="text-center">Indent Date</th>
										<th class="text-center">Required Date</th>
										<th class="text-center">Indentor</th>
										<th class="text-center">Designation</th>
										<th class="text-center">Indent Time</th>
										<th class="text-center" style="width: 25%;">
											Grade Details
											<table class="table table-condensed table-bordered table-white">
												<tr>
													<th>Product Name</th>
													<th>Description</th>
													<th>Quantity</th>
													<th>Price</th>
													
												</tr>
											</table>
										</th>
										
                                <c:set value="${(empty param.indent_date)?'':param.indent_date}" var="indent_date"/>
                                 <c:set value="${(empty param.indent_id)?'':param.indent_id}" var="indent_id"/>
										<th>Status</th>
										<th>Justification</th>
										<th class="text-center">OPTION${supplier_purchase_order_id}${supplier_id}${inventory_date}</th>
									</tr>
                                </thead>
                                
                                <c:set value="${(empty param.status)?'':param.status}" var="status"/>
								<sql:query var="po" dataSource="jdbc/rmc">
									select * from indent 
									where indent_date like if(''=?,'%%',?)
									and indent_id like if (''=?,'%%',?)
									order by indent_id desc
									limit 200;
									<sql:param value="${indent_date}"/>
									<sql:param value="${indent_date}"/>
									<sql:param value="${indent_id}"/>
									<sql:param value="${indent_id}"/>
									
								</sql:query>
								
                                <tbody>
                                <c:forEach var="po" items="${po.rows}">
									<tr class="${(po.status=='cancelled')?'text-danger':''}"    style="${(po.status=='approved')?'':'background-color:#f0b930'}">
										<td class="text-center">${po.indent_id}</td>
										<td class="text-center">${po.indent_date}</td>
										<td class="text-center">
											${po.required_date}
										</td>
										<td class="text-center">
											${po.indentor}
										</td>
										<td class="text-center">
											${po.designation}
										</td>
										
										<td class="text-center">
											${po.indent_time}
										</td>
										<td class="text-center">
											<sql:query var="poi" dataSource="jdbc/rmc">
												select * from indent_item where indent_id=?
												
												<sql:param value="${po.indent_id}"/>												
											</sql:query>
											<table class="table table-light table-bordered">
												<c:forEach var="poi" items="${poi.rows}">
													<tr>
														<td>${poi.indent_item_id}</td>
														<td>${poi.product_number}</td>
														<td>${poi.quantity}</td>
														<td>${poi.unit_price}</td>
													</tr>
												</c:forEach>
											</table>
										</td>
										<td>${po.status}</td>
										<td>${po.justification}</td>
										<td class="text-center">
											 <div class="btn-group dropdown">
	                                            <a href="javascript: void(0);" class="table-action-btn dropdown-toggle arrow-none btn btn-light btn-sm" data-toggle="dropdown" aria-expanded="false"><i class="mdi mdi-dots-horizontal"></i></a>
	                                            <div class="dropdown-menu dropdown-menu-right">
	                                                <a class="dropdown-item"   href="RaiseIndent.jsp?action=update&indent_id=${po.indent_id}"><i class="mdi mdi-pencil mr-2 text-muted font-18 vertical-middle"></i>Edit Indent List</a>
													<a class="dropdown-item ${(usertype!='sadmin' && po.status=='approved' )?'hide':''}" href="#status-model" data-animation="blur" data-plugin="custommodal" onclick="deletequotaion('${po.indent_id}')" data-overlaySpeed="100" data-overlayColor="#36404a"><i class="mdi mdi-check mr-2 text-muted font-18 vertical-middle"></i>Approve</a>
	                                            	<a class="dropdown-item" href="#delete-model" data-animation="blur" data-plugin="custommodal" onclick="deletequot('${po.indent_id}')" data-overlaySpeed="100" data-overlayColor="#36404a"><i class="mdi mdi-window-close mr-2 text-muted font-18 vertical-middle"></i>Delete</a>
	                                          		  <a class="dropdown-item"   href="PrintIndent.jsp?indent_id=${po.indent_id}"><i class="fa fa-print mr-2 text-success font-18 vertical-middle"></i>Print Indent</a>
	                                            </div>
	                                        </div>
										</td>
									</tr>
									</c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                <!-- end row -->


				 <!-- MODAL FOR Supplier Purchase Order Delete Start -->
				<div id="status-model" class="modal-demo col-xs-2">
		            <button type="button" class="close" onclick="Custombox.close();">
		                <span>&times;</span><span class="sr-only">Close</span>
		            </button>
		            <h4 class="custom-modal-title" style="color: white;background-color: #9b3329;">Are you sure want to Approve?</h4>
		            <div class="custom-modal-text">
		                <form class="form-horizontal" action="IndentController?action=statusIndent" method="post">
		                	<input type="hidden" name="indent_id" id="indent_id"/>
		                    <div class="form-group account-btn text-center m-t-2">
		                        <div class="col-12">
		                            <button class="btn w-lg btn-rounded btn-custom waves-effect waves-light" type="submit"><span class="change_status text-uppercase">APPROVE</span></button>
		                            <button class="btn w-lg btn-rounded btn-custom btn-danger waves-effect waves-light"  onclick="Custombox.close();" type="button">CANCEL</button>
		                        </div>
		                    </div>
		                </form>
		            </div>
		        </div>
                <!--  Supplier Purchase Order Delete Model End  -->
                
                	<div id="delete-model" class="modal-demo col-xs-2">
		            <button type="button" class="close" onclick="Custombox.close();">
		                <span>&times;</span><span class="sr-only">Close</span>
		            </button>
		            <h4 class="custom-modal-title" style="color: white;background-color: #9b3329;">Are you sure want to Delete?</h4>
		            <div class="custom-modal-text">
		                <form class="form-horizontal" action="IndentController?action=deleteIndent" method="post">
		                	<input type="hidden" name="indent_id" id="indent_id1"/>
		                    <div class="form-group account-btn text-center m-t-2">
		                        <div class="col-12">
		                            <button class="btn w-lg btn-rounded btn-custom waves-effect waves-light" type="submit"><span class="change_status text-uppercase">DELETE</span></button>
		                            <button class="btn w-lg btn-rounded btn-custom btn-danger waves-effect waves-light"  onclick="Custombox.close();" type="button">CANCEL</button>
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
        <%@ include file="footer.jsp" %>
        <!-- End Footer -->


        <!-- jQuery  -->
        <script src="assets/js/jquery.min.js"></script>
        <script src="assets/js/popper.min.js"></script>
        <script src="assets/js/bootstrap.min.js"></script>
        <script src="assets/js/waves.js"></script>
        <script src="assets/js/jquery.slimscroll.js"></script>

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

        <script type="text/javascript">
            $(document).ready(function() {
					
            	
                // Default Datatable
                $('#datatable').DataTable();

                //Buttons examples
                var table = $('#datatable-buttons').DataTable({
                    lengthChange: false,
                    buttons: ['copy', 'pdf','print']
                });

                // Key Tables

                $('#key-table').DataTable({
                    keys: true
                });
                
                $('#example').dataTable({
                    /* No ordering applied by DataTables during initialisation */
                    "order": []
                });

                // Responsive Datatable
                $('#responsive-datatable').DataTable();

                // Multi Selection Datatable
                $('#selection-datatable').DataTable({
                    select: {
                        style: 'multi'
                    }
                });

                table.buttons().container()
                        .appendTo('#datatable-buttons_wrapper .col-md-6:eq(0)');
            } );

        </script>
        
        <!-- Modal-Effect -->
        <script src="plugins/custombox/js/custombox.min.js"></script>
        <script src="plugins/custombox/js/legacy.min.js"></script>

		<script type="text/javascript">
			function deletequotaion(indent_id){
				$('#indent_id').val(indent_id);
				console.log(indent_id);
			}
        </script>
        
        <script type="text/javascript">
			function deletequot(indent_id){
				$('#indent_id1').val(indent_id);
				console.log(indent_id);
			}
        </script>
        
		<script type="text/javascript">
			$(document).ready(function(){
				 $('.select2').css('width','100%').select2({allowClear:true})
					.on('change', function(){
					}); 
			});
		</script>
		
		<script type="text/javascript">
			$(document).ready(function(){
				$('#customer_id').on('change',function(){
					var customer_id=$('#customer_id').val();
					$.ajax({
						type:'POST',
						url:'CustomerController?action=getCustomerSiteDetails&customer_id='+customer_id,
						headers:{
							Accept:"application/json;charset=utf-8",
							"Content-Type":"application/json;charset=utf-8"
						},
						success:function(result){
							$('#select2-site_id-container').html('All Site');
							$('#site_id').html('');
			        		$('#site_id').html('<option value="">All Site</option>');
			        		$.each(result, function(index, value) {
			        			   $('#site_id').append("<option value='"+ value.site_id+ "'>" + value.site_name + "</option>");
			        		});
			        		
						}
					});
				});
			});
		</script>
		<script type="text/javascript">
	    $(document).ready(function(){
	    	$('#search').on('click',function(){
	    		var po_number=$('#po_number').val();
	    		var inventory_date=$('.inventory_date').val();
	    		window.location='IndentList.jsp?inventory_date='+inventory_date+"&indent_id="+po_number;
	    	});
	    });
    </script>
    
    
	<script type="text/javascript">
        $(document).ready(function() {
            
            $('.date-picker').datepicker({
   				autoclose: true,
   				todayHighlight: true
   		 	});
   			//show datepicker when clicking on the icon
          });
        </script>


    </body>
</html>