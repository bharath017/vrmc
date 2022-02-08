<%@ include file="Session.jsp" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<!DOCTYPE html>
<html>
<head>
        <meta charset="utf-8" />
        <title>Inventory Item</title>
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
        <link rel="stylesheet" href="assets/css/select2.min.css" />
		
        <script src="assets/js/modernizr.min.js"></script>
        
        <style type="text/css">
        	.disabled{
        		  pointer-events: none;
				  cursor: default;
				  text-decoration: none;
				  color:white;
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
                                    <li class="breadcrumb-item active">Inventory Item</li>
                                    <li class="breadcrumb-item active">Inventory Items</li>
                                </ol>
                            </div>
                            <h4 class="page-title">Inventory Items</h4>
                        </div>
                    </div>
                </div>
                <!-- end page title end breadcrumb -->

				
				<sql:query var="items" dataSource="jdbc/rmc">
					select i.*,(select count(*) from inventory where inv_item_id=i.inv_item_id) as count from inventory_item i
				</sql:query>
				<h4 class="text-success">${res}</h4>
				<c:remove var="res"/>
                <div class="row">
                	<div class="col-3"></div>
                    <div class="col-6 text-center">
                    	<a href="AddGrade.jsp" class="btn btn-custom waves-effect waves-light mb-4"  data-toggle="modal" data-target="#add-comp" data-overlayColor="#36404a"><i class="mdi mdi-plus"></i>New Items</a>
                    	<table class="table table-bordered">
                    		<thead>
                    			<tr style="background-color: #1a82cc; color: white;">
                    				<th>S/L No</th>
                    				<th>Item Name</th>
                    				<th>Unit Of Measurement</th>
                    				<th>Item Status</th>
                    				<th>Option</th>
                    			</tr>
                    		</thead>
                    		<tbody>
                    			<c:set value="0" var="count"/>
                    			<c:forEach items="${items.rows}" var="item">
                    				<c:set value="${count+1}" var="count"/>
                    				<tr>
                    					<td>${count}</td>
                    					<td>${item.inventory_name}</td>
                    					<td>${item.stock_unit}</td>
                    					<td>${item.item_status}</td>
										<td>
											<a href="#update-model" class="text-success" onclick="updateInventoryItem('${item.inv_item_id}','${item.inventory_name}');" data-animation="blur" data-plugin="custommodal"  data-overlaySpeed="100" data-overlayColor="#36404a">
												<i class="fa fa-edit"></i>
											</a>
											&nbsp;&nbsp;&nbsp;
											<a href="#delete-model" class="${(item.count>0)?'disabled':'text-danger'}" onclick="deleteInventoryItem('${item.inv_item_id}','${item.inventory_name}');" data-animation="blur" data-plugin="custommodal"  data-overlaySpeed="100" data-overlayColor="#36404a">
												<i class="fa fa-trash"></i>
											</a>
										</td>                    					
                    				</tr>
                    			</c:forEach>
                    		</tbody>
                    	</table>
                    </div>
                </div>
                <!-- end row -->


				 <!-- Delete Inventory Item  -->
				<div id="delete-model" class="modal-demo col-xs-2">
		            <button type="button" class="close" onclick="Custombox.close();">
		                <span>&times;</span><span class="sr-only">Close</span>
		            </button>
		            <h4 class="custom-modal-title" style="color: white;background-color: #491136;">Delete Inventory : <span class="inventory_name_delete"></span> </h4>
		            <div class="custom-modal-text">
		                <form class="form-horizontal" method="post" action="InventoryController?action=DeleteInventoryItem">
		                	<input type="hidden" name="inv_item_id" id="inv_item_id_delete"/>
		                    <div class="form-group account-btn text-center m-t-2">
		                        <div class="col-12">
		                            <button class="btn w-lg btn-rounded btn-custom waves-effect waves-light" type="submit">DELETE</button>
		                            <button class="btn w-lg btn-rounded btn-custom btn-danger waves-effect waves-light"  onclick="Custombox.close();" type="button">CANCEL</button>
		                        </div>
		                    </div>
		                </form>
		            </div>
		        </div>
                <!-- End of delete inventory model  -->
                
                
                <!-- Update inventory Item  -->
				<div id="update-model" class="modal-demo col-xs-2">
		            <button type="button" class="close" onclick="Custombox.close();">
		                <span>&times;</span><span class="sr-only">Close</span>
		            </button>
		            <h4 class="custom-modal-title" style="color: white;background-color: #2272e2;">Update Inventory Item</h4>
		            <div class="custom-modal-text">
		                <form class="form-horizontal" method="post" action="InventoryController?action=UpdateItem">
		                	<div class="col-sm-12">
                                 <div class="form-group m-b-25">
	                                  <div class="col-12 text-left">
	                                      <label for="item-name text-left">Item Name <span class="text-danger">*</span></label>
	                                      <input type="hidden" id="update_inventory_item" name="inv_item_id">
	                                      <input class="form-control" type="text" id="update_inventory_name" name="inventory_name" required="" placeholder="Enter Item Name">
	                                  </div>
                             	 </div>
                             </div>
                             <div class="col-sm-12 text-left">
                                          <div class="form-group m-b-25">
	                                          <div class="col-12">
	                                              <label for="item-name">Stock Unit <span class="text-danger">*</span></label>
	                                              <sql:query var="unit" dataSource="jdbc/rmc">
														select * from unit
												</sql:query>
												<select class="col-xs-12 form-control" required="required" name="unit">
													<c:forEach items="${unit.rows}" begin="0" var="unit">
															<option value="${unit.unit_name}" ${(unit.unit_name==spoi.unit)?'selected':''}>${unit.unit_name}</option>
													</c:forEach>
													</select>
	                                          </div>
	                                      </div>
                                      </div>
		                    <div class="form-group account-btn text-center m-t-2">
		                        <div class="col-12">
		                            <button class="btn w-lg btn-rounded btn-custom waves-effect waves-light" type="submit">Update</button>
		                            <button class="btn w-lg btn-rounded btn-custom btn-danger waves-effect waves-light"  onclick="Custombox.close();" type="button">CANCEL</button>
		                        </div>
		                    </div>
		                </form>
		            </div>
		        </div>
                <!--  End of inventory item update model  -->
             
                <!-- MODAL FOR GRADE DETAILS -->
				<div id="add-comp"  class="modal fade" tabindex="-1" role="dialog" aria-labelledby="" aria-hidden="true" style="display: none;">
                      <div class="modal-dialog" >
                          <div class="modal-content" style="width: 100%;">

                              <div class="modal-body" >
                                  <h2 class="text-uppercase text-center m-b-30 text-success">
                                     Add New Item
                                  </h2>

                                  <form class="form-horizontal" action="InventoryController?action=InsertInventoryItem" method="post">

                                      <div class="col-sm-12">
                                          <div class="form-group m-b-25">
	                                          <div class="col-12">
	                                              <label for="item-name">Item Name <span class="text-danger">*</span></label>
	                                              <input class="form-control" type="text" id="inventory_name" name="inventory_name" required="" placeholder="Enter Item Name">
	                                          </div>
	                                      </div>
                                      </div>
                                      
                                      <div class="col-sm-12">
                                          <div class="form-group m-b-25">
	                                          <div class="col-12">
	                                              <label for="item-name">Stock Unit <span class="text-danger">*</span></label>
	                                              <sql:query var="unit" dataSource="jdbc/rmc">
														select * from unit
												</sql:query>
												<select class="col-xs-12 select2" required="required" name="unit">
													<c:forEach items="${unit.rows}" begin="0" var="unit">
															<option value="${unit.unit_name}" ${(unit.unit_name==spoi.unit)?'selected':''}>${unit.unit_name}</option>
													</c:forEach>
													</select>
	                                          </div>
	                                      </div>
                                      </div>
                                      
                                      <div class="col-sm-12">
                                          <div class="form-group m-b-25">
	                                          <div class="col-12">
	                                               <button type="submit" id="comp_save" class="btn btn-custom waves-effect waves-light">
			                                            Submit
			                                        </button>
			                                        <button type="reset" data-dismiss="modal" aria-hidden="true" class="btn btn-light waves-effect m-l-5">
			                                            Cancel
			                                        </button>
	                                          </div>
	                                      </div>
                                      </div>
                                  </form>
                              </div>
                          </div><!-- /.modal-content -->
                      </div><!-- /.modal-dialog -->
                  </div><!-- /.modal -->
                <!--END FOR GRADE MODAL  -->

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
        <!-- Selection table -->
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
        <script src="assets/js/select2.min.js"></script>
        <script type="text/javascript">
			function deleteInventoryItem(inv_item_id,inventory_name){
				$('.inventory_name_delete').html(inventory_name);
				$('#inv_item_id_delete').val(inv_item_id);
			}
		</script>
		
		<script type="text/javascript">
            $(document).ready(function() {
                $('.select2').css('width','60%').select2({allowClear:true})
				.on('change', function(){
				}); 
            });
            
            
            function updateInventoryItem(inv_item_id,inventory_name){
            	$('#update_inventory_item').val(inv_item_id);
            	$('#update_inventory_name').val(inventory_name);
            }
        </script>
    </body>
</html>