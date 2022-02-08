<%@ include file="Session.jsp" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<!DOCTYPE html>
<html>
<head>
        <meta charset="utf-8" />
        <title>Batching List</title>
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
       <jsp:include page="header.jsp"/>
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
                                    <li class="breadcrumb-item"><a href="#">QC Department</a></li>
                                    <li class="breadcrumb-item active">Batching List</li>
                                    <li class="breadcrumb-item active">Plant1 List</li>
                                </ol>
                            </div>
                            <h4 class="page-title">Batching List</h4>
                        </div>
                    </div>
                </div>
                <!-- end page title end breadcrumb -->
				<div class="row filter-row">
					<div class="col-sm-2 col-xs-6">
                        <div class="form-group form-focus">
                            <label class="control-label">Batch No</label>
                            <input class="form-control" placeholder="Enter Batch  No" id="batch_no" type="text" name="batch_no">
                        </div>
                    </div>
                    <div class="col-sm-2 col-xs-6 form-group">
                        <label>Batch Date : </label>
                        <div>
                            <div class="input-group">
                                <input type="text" name="scheduling_date" class="form-control date-picker invoice_date" placeholder="yyyy-mm-dd" id="id-date-picker-1" data-date-format="yyyy-mm-dd">
                                <div class="input-group-append">
                                    <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
                                </div>
                            </div>
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
                             <c:set value="${(empty param.date)?'':param.date}" var="date"/>
                             <c:set value="${(empty param.batch_no)?'':param.batch_no}" var="batch_no"/>
                                <c:catch var="e">
                             		<sql:query var="batch" dataSource="jdbc/rmc">
                               			select b.*,DATE_FORMAT(date(batch_date),'%d/%m/%Y') as batch_date from batch_detail b
                               			where date(batch_date) like if(''=?,'%%',?)
                               			and b.Batch_No like if(''=?,'%%',?)
                               			order by Batch_No DESC
                               			limit 100
                               			<sql:param value="${date}"/>
                               			<sql:param value="${date}"/>
                               			<sql:param value="${batch_no}"/>
                               			<sql:param value="${batch_no}"/>
                               		</sql:query>
                                </c:catch>
                            <table id="example" class="table table-striped table-bordered table-condensed" cellspacing="0" width="100%">
                                <thead>
	                                <tr>
										<th class="center">
											Batch No
										</th>
										<th class="text-center">Date</th>
										<th class="text-center">Site</th>
										<th class="text-center">Customer</th>
										<th class="text-center">Grade</th>
										<th class="text-center">Quantity</th>
										<th class="text-center">Vehicle</th>
										<th class="text-center">Start Time</th>
										<th class="text-center">End Time</th>
										<th class="text-center">OPTION</th>
									</tr>
                                </thead>
                                <tbody>
                                <c:forEach var="batch" items="${batch.rows}">
									<tr>
										<td class="text-center">${batch.Batch_No}</td>
										<td class="text-center">${batch.batch_date}</td>
										<td class="text-center">${batch.site}</td>
										<td class="text-center">${batch.cust_id}</td>
										<td class="text-center">${batch.recipe_name}</td>
										<td class="text-center">${batch.Production_Qty}</td>
										<td class="text-center">${batch.Truck_Id}</td>
										<td class="text-center">${batch.batch_start_time_txt}</td>
										<td class="text-center">${batch.batch_end_time_txt}</td>
										<td class="text-center">
											 <div class="btn-group dropdown">
	                                            <a href="javascript: void(0);" class="table-action-btn dropdown-toggle arrow-none btn btn-light btn-sm" data-toggle="dropdown" aria-expanded="false"><i class="mdi mdi-dots-horizontal"></i></a>
	                                            <div class="dropdown-menu dropdown-menu-right">
	                                            	<a class="dropdown-item" href="SchwingStetterBatchView.jsp?Batch_No=${batch.Batch_No}"><i class="fa fa-print mr-2 text-muted font-18 vertical-middle"></i>Print Batch Sheet</a>
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
            </div> <!-- end container -->
        </div>
        <!-- end wrapper -->


        <!-- Footer -->
        <!-- PUT FOOTER.JSP HERE -->
        <jsp:include page="footer.jsp"/>
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
			function cancelInvoice(id,invoice_id){
				$('#invoice_id_cancel').val(invoice_id);
				$('.invoice_id_cancel').html(invoice_id);
				$('#id_cancel').val(id);
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
	    		var invoice_date=$('.invoice_date').val();
	    		var batch_no=$('#batch_no').val();
	    		var plant_id=get('plant_id');
	    		window.location='SchweingStetterData.jsp?plant_id='+plant_id+'&date='+invoice_date+'&batch_no='+batch_no;
	    	});
	    });
	    
	    function get(name){
	    	   if(name=(new RegExp('[?&]'+encodeURIComponent(name)+'=([^&]*)')).exec(location.search))
	    	      return decodeURIComponent(name[1]);
	    }
    </script>
    <script type="text/javascript">
    	function updateVehicle(id,invoice_id,vehicle_no,driver_name,pump){
			$('#select2-vch-container').html(vehicle_no);
			$('#vch').val(vehicle_no);
			$('#pump').val(pump);
			$('#select2-pump-container').html(pump);
			$('#select2-driver_name-container').html(driver_name);
			$('#driver_name').val(driver_name);
			$('#inv_id').val(id);
			$('#vehicle_invoice_id').val(invoice_id);
    	}
    </script>
    <script type="text/javascript">
    	function updateDateTime(id,invoice_id,date,time){
    		$('#date_id').val(id);
    		$('.invoice_id').val(invoice_id);
    		$('.invoice_date').val(date);
    		$('.invoice_time').val();
    	}
    </script>
    
    <script type="text/javascript">
    	function changeDocketNo(id,invoice_id){
    		$('#id_docket').val(id);
    		$('#invoice_id_docket').val(invoice_id);
    		$('.invoice_id_docket').text(invoice_id);
    	}
    	
    </script>
    </body>
</html>