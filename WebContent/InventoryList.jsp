
<%@ include file="Session.jsp" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<!DOCTYPE html>
<html>
<head>
        <meta charset="utf-8" />
        <title>Inventory List</title>
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
        	.hidden{
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
                                    <li class="breadcrumb-item"><a href="#">Billing</a></li>
                                    <li class="breadcrumb-item active">Invoice</li>
                                    <li class="breadcrumb-item active">Invoice List</li>
                                </ol>
                            </div>
                            <h4 class="page-title">Invoice List</h4>
                        </div>
                    </div>
                </div>
                <!-- end page title end breadcrumb -->

                <div class="row">
                    <div class="col-sm-4">
                        <a href="AddInventory.jsp" class="btn btn-custom waves-effect waves-light mb-4"  data-overlayColor="#36404a"><i class="mdi mdi-plus"></i> Add Inventory</a>
                    </div><!-- end col -->
                </div>
                <!-- end row -->
				<div class="row filter-row">
					<div class="col-sm-1 col-xs-6">
                        <div class="form-group form-focus">
                            <label class="control-label">Inventory No</label>
                                <input class="form-control" placeholder="Enter Inventory No" id="inventory_id" type="text" name="inventory_id">
                        </div>
                    </div>
                    <div class="col-sm-2 col-xs-6 form-group">
                        <label>From Date : </label>
                        <div>
                            <div class="input-group">
                                <input type="text" name="scheduling_date" class="form-control date-picker from_date" placeholder="yyyy-mm-dd" id="id-date-picker-1" data-date-format="yyyy-mm-dd">
                                <div class="input-group-append">
                                    <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-2 col-xs-6 form-group">
                        <label>To Date : </label>
                        <div>
                            <div class="input-group">
                                <input type="text" name="scheduling_date" class="form-control date-picker to_date" placeholder="yyyy-mm-dd" id="id-date-picker-1" data-date-format="yyyy-mm-dd">
                                <div class="input-group-append">
                                    <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-2 col-xs-6">
                        <div class="form-group form-focus select-focus">
                            <label class="control-label">Supplier : </label>
                            <sql:query var="supplier" dataSource="jdbc/rmc">
                            	select * from supplier where supplier_status='active'
                            </sql:query>
                            <select class="select2 form-control floating" id="supplier_id">
                                <option value="">All Supplier</option>
                                <c:forEach items="${supplier.rows}" var="supplier">
                                	<option value="${supplier.supplier_id}">${supplier.supplier_name}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    
                    <div class="col-sm-2 col-xs-6">
                        <div class="form-group form-focus select-focus">
                            <label class="control-label">Item : </label>
                            <sql:query var="it" dataSource="jdbc/rmc">
                            	select * from inventory_item where item_status='active'
                            </sql:query>
                            <select class="select2 form-control floating" id="inv_item_id">
                                <option value="">All Item</option>
                                <c:forEach items="${it.rows}" var="it">
                                	<option value="${it.inv_item_id}">${it.inventory_name}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    
                    <div class="col-sm-2 col-xs-6">
                        <div class="form-group form-focus select-focus">
                            <label class="control-label">Vehicle No : </label>
                            <sql:query var="vehicle" dataSource="jdbc/rmc">
                            	select * from temp_vehicle
                            </sql:query>
                            <select class="select2 form-control floating" id="vehicle_no">
                                <option value="">All Vehicle</option>
                                <c:forEach items="${vehicle.rows}" var="vehicle">
                                	<option value="${vehicle.vehicle_no}">${vehicle.vehicle_no}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    
                    <div class="col-sm-1 col-xs-6">
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
										<th class="text-center">ME No</th>
										<th class="text-center">Date & Time</th>
										<!-- <th class="text-center">Plant Name</th> -->
										<th class="text-center">Supplier Name</th>
										<th class="text-center">Bill No</th>
										<th class="text-center">Item Name</th>
										<th class="text-center">Vehicle No</th>
										<th class="text-center">Supplier Weight</th>
										<th class="text-center">Empty Weight</th>
										<th class="text-center">Loaded Weight</th>
										<th class="text-center">Net Weight</th>
										<th class="text-center">Gatepass No</th>
										<th class="text-center">Moisture Percentage</th>
										<th class="text-center">Weight After Deduction</th>
										<th class="text-center">Plant</th>
										<th class="text-center">OPTION</th>

									</tr>
                                </thead>
                                <c:set value="${(empty param.inventory_id)?'':param.inventory_id}" var="inventory_id"/>
                                <c:set value="${(empty param.from_date)?'':param.from_date}" var="from_date"/>
                                <c:set value="${(empty param.to_date)?'':param.to_date}" var="to_date"/>
                                <c:set value="${(empty param.supplier_id)?'':param.supplier_id}" var="supplier_id"/>
                                <c:set value="${(empty param.inv_item_id)?'':param.inv_item_id}" var="inv_item_id"/>
                                <c:set value="${(empty param.vehicle_no)?'':param.vehicle_no}" var="vehicle_no"/>
								<sql:query var="inv_itm" dataSource="jdbc/rmc">
									select i.*,DATE_FORMAT(i.date,'%d/%m/%Y') as date,it.inventory_name,p.plant_name,s.supplier_name from supplier s,plant p,inventory_item it,inventory i
									where i.inv_item_id=it.inv_item_id and
									i.plant_id=p.plant_id and
									i.supplier_id=s.supplier_id and 
									i.inventory_id like if(''=?,'%%',?)
									and i.date  between if(''=?,'2014-01-01',?) and if(''=?,'2088-01-01',?)
									and i.supplier_id like if(''=?,'%%',?)
									and i.inv_item_id like if(''=?,'%%',?)
									and i.vehicle_no like if(''=?,'%%',?)
									and i.plant_id like if(''=?,'%%',?)
									order by inventory_id desc
									limit 200;
									<sql:param value="${inventory_id}"/>
									<sql:param value="${inventory_id}"/>
									<sql:param value="${from_date}"/>
									<sql:param value="${from_date}"/>
									<sql:param value="${to_date}"/>
									<sql:param value="${to_date}"/>
									<sql:param value="${supplier_id}"/>
									<sql:param value="${supplier_id}"/>
									<sql:param value="${inv_item_id}"/>
									<sql:param value="${inv_item_id}"/>
									<sql:param value="${vehicle_no}"/>
									<sql:param value="${vehicle_no}"/>
									<sql:param value="${bean.plant_id}"/>
									<sql:param value="${bean.plant_id}"/>
								</sql:query>
                                <tbody>
                                  <c:forEach var="inv" items="${inv_itm.rows}">
                                <%--   <c:set value="${count+1}" var="count"/>
 --%>									<tr class="${(inv.inventory_status=='deactive')?'text-danger':''}">
									
										<td class="text-center" style="width: 3%;">${inv.inventory_id}</td>
										<td class="text-center" style="width: 10%;">
										    <b>Date :</b> ${inv.date}<br>
										    <b>Time :</b> ${inv.time}
										</td>
										<td class="text-center" style="width: 10%;">${inv.supplier_name}</td>
										<td class="text-center" style="width: 5%;">${inv.bill_no}</td>
										<td class="text-center" style="width: 10%;">${inv.inventory_name}</td>
										<td class="text-center" style="width: 10%;">${inv.vehicle_no}</td>
										<td class="text-center" style="width: 10%;"> ${inv.supplier_weight}</td>
										<td class="text-center" style="width: 10%;">${inv.empty_weight}</td>
										<td class="text-center" style="width: 10%;">${inv.loaded_weight}</td>
										<td class="text-center" style="width: 10%;">${inv.net_weight}</td>
										<td class="text-center" style="width: 5%;">${inv.gatepass_no}</td>
										<td class="text-center" style="width: 5%;">${inv.moisture_percent}</td>
										<td class="text-center" style="width: 5%;">${inv.after_weight}</td>
										<td class="text-center" style="width: 10%;">${inv.plant_name}</td>
										
									<td class="text-center">
									<c:if test="${inv.inventory_status=='active'}">
											<div class="btn-group dropdown">
	                                            <a href="javascript: void(0);" class="table-action-btn dropdown-toggle arrow-none btn btn-light btn-sm" data-toggle="dropdown" aria-expanded="false"><i class="mdi mdi-dots-horizontal"></i></a>
	                                            <div class="dropdown-menu dropdown-menu-right">
	                                            	<a class="dropdown-item" href="PrintInventory.jsp?inventory_id=${inv.inventory_id}"><i class="fa fa-print mr-2 text-success font-18 vertical-middle"></i> Print Receipt</a>
	                                            	<a class="dropdown-item" href="AddInventory.jsp?action=update&inventory_id=${inv.inventory_id}"><i class="fa fa-edit mr-2 text-primary font-18 vertical-middle"></i> Edit Inventory</a>
                                                    <a class="dropdown-item" href="#delete-model" data-animation="blur" data-plugin="custommodal" onclick="changeStatus('${inv.inventory_id}','${inv.inventory_name}')" data-overlaySpeed="100" data-overlayColor="#36404a"><i class="mdi mdi-window-close mr-2 text-danger font-18 vertical-middle"></i> Cancel</a>
                                                </div>
	                                        </div>
											</c:if>
										</td>
									</tr>
									</c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                <!-- end row -->
				
                <!-- MODAL FOR INVENTORY CANCELLATION  -->
                
				 <!-- MODAL FOR PLANT DELETE START  -->
				<div id="delete-model" class="modal-demo col-xs-2">
		            <button type="button" class="close" onclick="Custombox.close();">
		                <span>&times;</span><span class="sr-only">Close</span>
		            </button>
		            <h4 class="custom-modal-title" style="color: white;background-color: #915d2a;"><span class="change_status text-uppercase"></span> Inventory  <span class=" text-primary text-uppercase inventory_name"></span></h4>
		            <div class="custom-modal-text">
		                <form class="form-horizontal" action="InventoryController?action=cancelInventory" method="post">
		                	<input type="hidden" name="inventory_id" id="inventory_id_cancel"/>
		                    <div class="form-group account-btn text-center m-t-2">
		                        <div class="col-12">
		                            <button class="btn w-lg btn-rounded btn-custom waves-effect waves-light" type="submit"><span class="change_status text-uppercase"></span> Cancel</button>
		                            <button class="btn w-lg btn-rounded btn-custom btn-danger waves-effect waves-light"  onclick="Custombox.close();" type="button">Back</button>
		                        </div>
		                    </div>
		                </form>
		            </div>
		        </div>
                <!--  PLANT DELETE MODAL END  -->
                <!--  END OF INVOICE CANCEL MODAL  -->
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
			$(document).ready(function(){
				/*TIME PICKER START'S HERE*/
				$('#timepicker1').timepicker({
					minuteStep: 1,
					showSeconds: true,
					showMeridian: false,
					disableFocus: true,
					icons: {
						up: 'fa fa-chevron-up',
						down: 'fa fa-chevron-down'
					}
				}).on('focus', function() {
					$('#timepicker1').timepicker('showWidget');
				}).next().on('click', function(){
					$(this).prev().focus();
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
			function changeStatus(inventory_id,inventory_name){
				$('.inventory_name').text(inventory_name);
				$('#inventory_id_cancel').val(inventory_id);
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
		    	$('#search').on('click',function(){
		    		var inventory_id=$('#inventory_id').val();
		    		var from_date=$('.from_date').val();
		    		var to_date=$('.to_date').val();
		    		var supplier_id=$('#supplier_id').val();
		    		var inv_item_id=$('#inv_item_id').val();
		    		var vehicle_no=$('#vehicle_no').val();
		    		window.location='InventoryList.jsp?inventory_id='+inventory_id+'&from_date='+from_date+"&supplier_id="+supplier_id+"&inv_item_id="+inv_item_id+"&vehicle_no="+vehicle_no+"&to_date="+to_date;
		    	});
		    });
       </script>
		
  
    
   
    </body>
</html>