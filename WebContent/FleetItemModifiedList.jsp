<%@ include file="Session.jsp" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<!DOCTYPE html>
<html>
<head>
        <meta charset="utf-8" />
        <title>Fleet Item List</title>
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
                                    <li class="breadcrumb-item"><a href="#">Fleet</a></li>
                                    <li class="breadcrumb-item active">Fleet Item</li>
                                    <li class="breadcrumb-item active">Modified Fleet Item List</li>
                                </ol>
                            </div>
                            <h4 class="page-title">Recent Fleet Item Stock Quantity Modified List</h4>
                        </div>
                    </div>
                </div>
                <!-- end page title end breadcrumb -->
    
                <div class="row">
                    <div class="col-sm-4">
                        <a href="FleetItemList.jsp" class="btn btn-custom waves-effect waves-light mb-4"  data-overlayColor="#36404a"><i class="mdi mdi-grid"></i> Fleet Item List</a>
                    </div><!-- end col -->
                </div>
               <div class="row filter-row">
					
                    <div class="col-sm-2 col-xs-6 form-group">
                        <label>Inventory Date : </label>
                        <div>
                            <div class="input-group">
                                <input type="text" name="scheduling_date" class="form-control date-picker fleet_date" placeholder="yyyy-mm-dd" id="id-date-picker-1" data-date-format="yyyy-mm-dd">
                                <div class="input-group-append">
                                    <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-2 col-xs-6">
                        <div class="form-group form-focus select-focus">
                            <label class="control-label">Item : </label>
                            <sql:query var="item" dataSource="jdbc/rmc">
                            	select * from fleet_item where item_status='active'
                            </sql:query>
                              <select class="select2 form-control floating" id="fleet_item_id">
                                <option value="">All Item</option>
                                <c:forEach items="${item.rows}" var="item">
                                	<option value="${item.fleet_item_id}">${item.item_name}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    
                 <div class="col-sm-2 col-xs-6">
                        <div class="form-group form-focus">
                            <label class="control-label">&nbsp;</label>
                            <a href="#" id="search" class="btn btn-success btn-block"> Search </a>
                        </div>
                    </div>
                </div>
                
                  <div class="row">
                    <div class="col-12">
                        <div class="card-box table-responsive">
                            <table id="example" class="table table-striped table-bordered table-condensed" cellspacing="0" width="100%">
                                <thead>
	                                <tr>
										<th class="text-center">Item Name</th>
                                        <th class="text-center">Old Stock</th>
                                        <th class="text-center">New Stock</th>
                                        <th class="text-center">Comment</th>
                                        <th class="text-center">User</th>
                                        <th class="text-center">Modified Date &amp; Time</th>
										
									</tr>
                                </thead>
                                 <c:set value="${(empty param.fleet_item_id)?'':param.fleet_item_id}" var="fleet_item_id"/>
								<sql:query var="item" dataSource="jdbc/rmc">
                                	select f.*,i.item_name from fleet_item_modification f LEFT JOIN fleet_item i on f.fleet_item_id=i.fleet_item_id where f.fleet_item_id like if(''=?,'%%',?) limit 150
                                	<sql:param value="${fleet_item_id}"/>
                                	<sql:param value="${fleet_item_id}"/> 
                                </sql:query>
                                <tbody>
                               <c:forEach items="${item.rows}" var="item">
									<tr>
										    <td class="text-center">${item.item_name}</td>
	                                        <td class="text-center">${item.old_stock_quantity}</td>
	                                        <td class="text-center">${item.new_stock_quantity}</td>
	                                        <td class="text-center">${item.modification_comment}</td>
	                                        <td class="text-center">${item.modified_user}</td>
	                                        <td class="text-center">${item.modification_timestamp}</td>
										</tr>
									</c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                <!-- end row -->
                
            </div> <!-- end container -->
        </div>
        <!-- end wrapper -->
                
    <%-- <div class="main-wrapper">
        <!-- Put header panel here -->
        
        <%@ include file="header.jsp" %>
        
        <!-- Put left side panel here -->
        
       
        <div class="page-wrapper">
            <div class="content container-fluid">
                <div class="row">
                    <div class="col-xs-4">
                        <h4 class="page-title">Recent Item Stock Quantity Modified List</h4>
                    </div>
                </div>
                <div class="row filter-row">
                    <div class="col-sm-3 col-xs-6">
                        <div class="form-group form-focus select-focus">
                            <label class="control-label">Choose Item</label>
                            <sql:query var="item" dataSource="jdbc/crusher">
                            	select * from fleet_item where item_status='active'
                            </sql:query>
                            <select class="select2 floating" id="fleet_item_id">
                                <option value="">All Item</option>
                                <c:forEach items="${item.rows}" var="item">
                                	<option value="${item.fleet_item_id}">${item.item_name}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    
                    <div class="col-sm-3 col-xs-6">
                        <a href="#" id="search" class="btn btn-success btn-block"> Search </a>
                    </div>
                </div>
                
                <div class="row">
                	<h4 class="text-success">${res}</h4>
                	<c:remove var="res"/>
                    <div class="col-md-12">
                        <div class="table-responsive">
                            <table class="table table-striped custom-table table-bordered mytable m-b-0">
                                <thead>
                                    <tr>
                                        <th class="text-center">Item Name</th>
                                        <th class="text-center">Old Stock</th>
                                        <th class="col-sm-2 text-center">New Stock</th>
                                        <th class="text-center">Comment</th>
                                        <th class="col-sm-2 text-center">User</th>
                                        <th class="col-sm-2 text-center">Modified Date &amp; Time</th>
                                    </tr>
                                </thead>
                                
                                <!-- Get po details here -->
                                <c:set value="${(empty param.fleet_item_id)?'':param.fleet_item_id}" var="fleet_item_id"/>
                                <sql:query var="item" dataSource="jdbc/crusher">
                                	select f.*,i.item_name from fleet_item_modification f LEFT JOIN fleet_item i on f.fleet_item_id=i.fleet_item_id where f.fleet_item_id like if(''=?,'%%',?) limit 150
                                	<sql:param value="${fleet_item_id}"/>
                                	<sql:param value="${fleet_item_id}"/> 
                                </sql:query>
                                
                                <tbody>
                                    <c:forEach items="${item.rows}" var="item">
                                    	<tr>
	                                        <td class="text-center">${item.item_name}</td>
	                                        <td class="text-center">${item.old_stock_quantity}</td>
	                                        <td class="text-center">${item.new_stock_quantity}</td>
	                                        <td class="text-center">${item.modification_comment}</td>
	                                        <td class="text-center">${item.modified_user}</td>
	                                        <td class="text-center">${item.modification_timestamp}</td>
	                                    </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
                               <!-- Put Message Panel Here -->
          
            <!-- Cancel PO Modal -->
        </div>
    </div> --%>
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
				}).next().on(ace.click_event, function(){
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
			function deleteScheduling(scheduling_id){
				$('#scheduling_id').val(scheduling_id);
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
		    		var modified_date=$('.fleet_date').val();
		    		var fleet_item_id=$('#fleet_item_id').val();
		    		var user_name=$('#user_name').val();
		    		window.location="FleetItemModifiedList.jsp?fleet_date="+fleet_date+"&fleet_item_id="+fleet_item_id;
		    	});
		    });
	     </script>
</body>
</html>