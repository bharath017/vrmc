<%@ include file="Session.jsp" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<!DOCTYPE html>
<html>
<head>
        <meta charset="utf-8" />
        <title>Fleet Item List - ${initParam.company_name}</title>
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
		
        <script src="assets/js/modernizr.min.js"></script>

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
                                    <li class="breadcrumb-item"><a href="#">Fleet Item</a></li>
                                    <li class="breadcrumb-item active">Fleet Item List</li>
                                </ol>
                            </div>
                            <h4 class="page-title">Fleet Item List</h4>
                        </div>
                    </div>
                </div>
                <!-- end page title end breadcrumb -->

                <div class="row">
                    <div class="col-sm-4">
                        <a href="FleetItem.jsp" class="btn btn-custom waves-effect waves-light mb-4"  data-overlayColor="#36404a"><i class="mdi mdi-plus"></i> Add Fleet Item</a>
                    </div><!-- end col -->
                </div>
                <!-- end row -->

                <div class="row">
                    <div class="col-12">
                    
                        <div class="card-box table-responsive">
                            <h4 class="m-t-0 header-title">Fleet Item List</h4>
                            <h4 style="color: green;">${result}</h4>
                            <%session.removeAttribute("result");%>
                            <p></p>
                            <table id="datatable-buttons" class="table table-striped table-bordered" cellspacing="0" width="100%">
                                <thead>
	                                <tr>
										<th class="text-center">Item Name</th>
                                        <th class="text-center">Item Cost</th>
                                        <th class="text-center">Unit of Measurement</th>
                                        <th class="text-center">Stock Quantity</th>
                                        <th class="text-center">Item Status</th>
                                        <th class="text-right">Action</th>
									</tr>
                                </thead>
                                 <c:set value="${(empty param.item_name)?'':param.item_name}" var="item_name"/>
								<sql:query var="inv_itm" dataSource="jdbc/rmc">
									select i.*,u.plant_name from fleet_item i LEFT JOIN plant u ON i.plant_id=u.plant_id where item_name like if(''=?,'%%',concat('%',?,'%'));
									<sql:param value="${item_name}"/>
                                	<sql:param value="${item_name}"/>
								</sql:query>
                                <tbody>
                                <c:set value="0" var="count"/>
                                <c:forEach var="flt" items="${inv_itm.rows}">
                                	<c:set value="${count+1}" var="count"/>
									<tr class="${(flt.item_status=='deactive')?'text-danger':''}">
									
										<td class="text-center" style="width: 10%;">${count}</td>
										<td class="text-center" style="width: 25%;">
											${flt.item_name}
										</td>
										<td class="text-center" style="width: 25%;">
											${flt.item_cost}
										</td>
										<td class="text-center" style="width: 25%;">
											${flt.item_stock_quantity}
										</td>
										<td class="text-center" style="width: 25%;">
											${flt.item_status}
										</td>
										
										<td class="text-center">
											 <div class="btn-group dropdown">
	                                            <a href="javascript: void(0);" class="table-action-btn dropdown-toggle arrow-none btn btn-light btn-sm" data-toggle="dropdown" aria-expanded="false"><i class="mdi mdi-dots-horizontal"></i></a>
	                                            <div class="dropdown-menu dropdown-menu-right">
	                                            	<a class="dropdown-item" href="FleettItem.jsp?action=update&fleet_item_id=${flt.fleet_item_id}"><i class="fa fa-edit mr-2 text-primary font-18 vertical-middle"></i> Edit Item</a>
<%-- 	                                            <a class="dropdown-item" href="#delete-model" data-animation="blur" data-plugin="custommodal" onclick="deleteItem('${inv.inv_item_id}','${inv.inventory_name}')" data-overlaySpeed="100" data-overlayColor="#36404a"><i class="fa fa-trash-o mr-2 text-danger font-18 vertical-middle"></i> Delete</a>
 --%>	                                           
                                                    <a class="dropdown-item" href="#delete-model1" data-animation="blur" data-plugin="custommodal" onclick="changeStatus('${flt.fleet_item_id}','${flt.item_name}','${(flt.item_status=='active')?'deactive':'active'}')" data-overlaySpeed="100" data-overlayColor="#36404a"><i class="mdi mdi-window-close mr-2 text-danger font-18 vertical-middle"></i> ${(flt.item_status=='active')?'Deactivate Item':'Activate Item'}</a>
                                                    <a class="dropdown-item" href="#delete-model" data-animation="blur" data-plugin="custommodal" onclick="UpdateItemQuantity('${flt.fleet_item_id}','${flt.item_name}','${flt.item_stock_quantity}')" data-overlaySpeed="100" data-overlayColor="#36404a"><i class="mdi mdi-plus mr-2 text-danger font-18 vertical-middle"></i> Update Quantity</a>
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
<!-- 

				 MODAL FOR PLANT DELETE START 
				<div id="delete-model" class="modal-demo col-xs-2">
		            <button type="button" class="close" onclick="Custombox.close();">
		                <span>&times;</span><span class="sr-only">Close</span>
		            </button>
		            <h4 class="custom-modal-title" style="color: white;background-color: #491136;">Cancel Item : <span class="item_name"></span> </h4>
		            <div class="custom-modal-text">
		                <form class="form-horizontal" method="post" action="InventoryController?action=cancel">
		                	<input type="hidden" name="inv_item_id" id="inv_item_id"/>
		                    <div class="form-group account-btn text-center m-t-2">
		                        <div class="col-12">
		                            <button class="btn w-lg btn-rounded btn-custom waves-effect waves-light" type="submit">Cancel</button>
		                            <button class="btn w-lg btn-rounded btn-custom btn-danger waves-effect waves-light"  onclick="Custombox.close();" type="button">BACK</button>
		                        </div>
		                    </div>
		                </form>
		            </div>
		        </div>
                 PLANT DELETE MODAL END 


 -->
 
 
 
 <!-- Update Item Here -------------------  -->
 
  <!-- MODAL FOR PLANT DELETE START  -->
				<div id="delete-model" class="modal-demo col-xs-6">
		            <button type="button" class="close" onclick="Custombox.close();">
		                <span>&times;</span><span class="sr-only">Close</span>
		            </button>
		            <h4 class="custom-modal-title text-uppercase" style="color: white;background-color: #28afa0;"><b>Update Quantity For : <span id="inv_item_name"></span></b><span class=" text-primary text-uppercase inv_item_name"></span></h4>
		            <div class="custom-modal-text">
		                <form class="form-horizontal" action="FleetController?action=UpdateFleetQuanitty" method="post">
		                	
                                        
			                               	<div class="form-group">
			                               	 <input type="hidden" name="fleet_item_id" id="fleet_item_id"> 
			                                   </div>
			                              <div class="form-group">
			                                    <label>Old Stock Quantity <span class="text-danger">*</span> </label>
			                                    <input type="text" class="form-control" required
			                                          pattern="[^'&quot;:]*$" id="old_stock" name="old_stock" readonly="readonly"/>
			                                   </div>
			                                   
			                                     <div class="form-group">
			                                    <label>New Stock <span class="text-danger">*</span> </label>
			                                    <input type="text" class="form-control" required
			                                          pattern="[^'&quot;:]*$" placeholder="Enter New Quantity." id="item_stock_quantity" name="item_stock_quantity" />
			                                   </div>
			                                   
			                                    <div class="form-group">
			                                    <label>Comment <span class="text-danger">*</span> </label>
			                                    <textarea class="form-control" required
			                                       placeholder="Enter Comment To What Purpose Changing.." id="comment" name="comment"></textarea>
			                                   </div>
			                                   
			                                   
		                	
		                    <div class="form-group account-btn text-center m-t-2">
		                        <div class="col-12">
		                            <button class="btn w-lg btn-rounded btn-custom waves-effect waves-light" type="submit"><span class="change_status text-uppercase"></span>SAVE</button>
		                            <button class="btn w-lg btn-rounded btn-custom btn-danger waves-effect waves-light"  onclick="Custombox.close();" type="button">CANCEL</button>
		                        </div>
		                    </div>
		                </form>
		            </div>
		        </div>
                <!--  PLANT DELETE MODAL END  -->
 
 
 
 
 
				 <!-- MODAL FOR PLANT DELETE START  -->
				<div id="delete-model1" class="modal-demo col-xs-2">
		            <button type="button" class="close" onclick="Custombox.close();">
		                <span>&times;</span><span class="sr-only">Close</span>
		            </button>
		            <h4 class="custom-modal-title" style="color: white;background-color: #915d2a;"><span class="change_status text-uppercase"></span> Fleet Item <span class=" text-primary text-uppercase mp_name"></span></h4>
		            <div class="custom-modal-text">
		                <form class="form-horizontal" action="FleetController?action=ChangeFleetItemStatus" method="post">
		                	<input type="hidden" name="fleet_item_id" id="mp_id"/>
		                	<input type="hidden" name="item_status" id="mp_status">
		                    <div class="form-group account-btn text-center m-t-2">
		                        <div class="col-12">
		                            <button class="btn w-lg btn-rounded btn-custom waves-effect waves-light" type="submit"><span class="change_status text-uppercase"></span></button>
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
        <script src="plugins/datatables/jszip.min.js"></script>
        <script src="plugins/datatables/pdfmake.min.js"></script>
        <script src="plugins/datatables/vfs_fonts.js"></script>
        <script src="plugins/datatables/buttons.html5.min.js"></script>
        <script src="plugins/datatables/buttons.print.min.js"></script>

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
			function changeStatus(mp_id,mp_name,status){
				$('.change_status').text(status);
				$('.mp_name').text(mp_name);
				$('#mp_status').val(status);
				$('#mp_id').val(mp_id);
			}
		</script>
		
		<script type="text/javascript">
			function UpdateItemQuantity(item_id,item_name,item_qty){
				$('.item_name').text(item_name);
				$('#old_stock').val(item_qty);
				$('#fleet_item_id').val(item_id);
			}
		</script>

    </body>
</html>