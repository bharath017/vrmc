<%@ include file="Session.jsp" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<!DOCTYPE html>
<html>
<head>
        <meta charset="utf-8" />
        <title>Customer Quotation List</title>
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
                                    <li class="breadcrumb-item"><a href="#">Customer &amp; Quotation</a></li>
                                    <li class="breadcrumb-item active">Customer Quotation</li>
                                    <li class="breadcrumb-item active">Customer Quotation List</li>
                                </ol>
                            </div>
                            <h4 class="page-title">Customer Quotation List</h4>
                        </div>
                    </div>
                </div>
                <!-- end page title end breadcrumb -->

                <div class="row">
                    <div class="col-sm-4">
                        <a href="AddCustomerQuotation.jsp" class="btn btn-custom waves-effect waves-light mb-4"  data-overlayColor="#36404a"><i class="mdi mdi-plus"></i> Add Customer Quotation</a>
                    </div><!-- end col -->
                </div>
                <!-- end row -->
				<div class="row filter-row">
					<div class="col-sm-2 col-xs-6">
                        <div class="form-group form-focus">
                            <label class="control-label">Quotation No</label>
                                <input class="form-control" placeholder="Enter Quotation No" id="quotation_id" type="text" name="quotation_id">
                        </div>
                    </div>
                    <div class="col-sm-2 col-xs-6 form-group">
                        <label>From Date : </label>
                        <div>
                            <div class="input-group">
                                <input type="text" name="from_date" class="form-control date-picker from_date" placeholder="yyyy-mm-dd" id="id-date-picker-1" data-date-format="yyyy-mm-dd">
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
                                <input type="text" name="to_date" class="form-control date-picker to_date" placeholder="yyyy-mm-dd" id="id-date-picker-1" data-date-format="yyyy-mm-dd">
                                <div class="input-group-append">
                                    <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-sm-2 col-xs-6">
                        <div class="form-group form-focus select-focus">
                            <label class="control-label">Customer : </label>
                            <sql:query var="customer" dataSource="jdbc/rmc">
                            	select distinct customer_name from customer_quotation
                            </sql:query>
                            <select class="select2 form-control floating" id="customer_name">
                                <option value="">All Customer</option>
                                <c:forEach items="${customer.rows}" var="customer">
                                	<option value="${customer.customer_name}">${customer.customer_name}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    
                    <div class="col-sm-2 col-xs-6">
                        <div class="form-group form-focus select-focus">
                            <label class="control-label">Marketing Person : </label>
                            <sql:query var="customer" dataSource="jdbc/rmc">
                            	select distinct mp_name from marketing_person
                            </sql:query>
                            <select class="select2 form-control mp_name" id="mp_name">
                                <option value="">All Marketing Person</option>
                                <c:forEach items="${customer.rows}" var="customer">
                                	<option value="${customer.mp_name}">${customer.mp_name}</option>
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
                            <h4 style="color: green;">${res}</h4>
                            <c:remove var="res"/>
                            <table id="example" class="table table-striped table-bordered table-condensed" cellspacing="0" width="100%">
                                <thead>
	                                <tr>
										<th class="center">
											Quotation Id
										</th>
										<th class="text-center">Customer Name</th>
										<th class="text-center">Quotation Date</th>
										<th class="text-center">Site Address</th>
										<th class="text-center">Marketing Person</th>
										<th class="text-center">Customer Phone</th>
										<th class="text-center">Pump Charge</th>
										<th class="text-center">Pump Quantity</th>
										<th class="text-center">status</th>
										<th class="text-center" style="width: 25%;">
											Grade Details
											<table class="table table-condensed table-bordered table-white">
												<tr>
													<th>Grade Id</th>
													<th>Grade Name</th>
													<th>Quantity</th>
													<th>Cost/M<sup>3</sup> (OPC)</th>
			                                		<th>Cost/M<sup>3</sup> (OPC + GGBS)</th>
												</tr>
											</table>
										</th>
										<th class="text-center">OPTION</th>
									</tr>
                                </thead>
                                
                                <c:set value="${(empty param.quotation_id)?'':param.quotation_id}" var="quotation_id"/>
                                <c:set value="${(empty param.customer_name)?'':param.customer_name}" var="customer_name"/>
                                <c:set value="${(empty param.from_date)?'':param.from_date}" var="from_date"/>
                                	<c:set value="${(empty param.to_date)?'':param.to_date}" var="to_date"/>
                                	<c:set value="${bean.user_id}" var="user_id"/>
                                	
                                	<c:if test="${usertype=='superadmin' || usertype=='admin' }">
                                	
                                	<c:set value='0' var="user_id"/>
                                	
                                	</c:if>
                                	
                                	
								<sql:query var="po" dataSource="jdbc/rmc">
									select q.*,m.mp_name from customer_quotation q left join marketing_person m on (m.mp_id=q.mp_id)
									where q.quotation_id like if(''=?,'%%',?)
									and q.customer_name like if(''=?,'%%',?)
									 and q.quotation_date between if(''=?,'2014-01-01',?) and if(''=?,'2088-01-01',?)
									 and q.mp_id like if ('0'=?,'%%', ?)
									order by quotation_id desc
									limit 200;
									<sql:param value="${quotation_id}"/>
									<sql:param value="${quotation_id}"/>
									<sql:param value="${customer_name}"/>
									<sql:param value="${customer_name}"/>
									<sql:param value="${from_date}"/>
		                           	<sql:param value="${from_date}"/>
		                           	<sql:param value="${to_date}"/>
		                           	<sql:param value="${to_date}"/>
		                           	<sql:param value="${user_id}"/>
		                           	<sql:param value="${user_id}"/>
								</sql:query>
								
                                <tbody>
                                <c:forEach var="po" items="${po.rows}">
									<tr class="${(po.status=='pending')?'bg-warning':(po.status=='cancelled')?'bg-danger':''}" >
										<td class="text-center">${po.quotation_id}</td>
										<td class="text-center">${po.customer_name}</td>
										<td class="text-center">
											${po.quotation_date}
										</td>
										<td class="text-center">
											${po.site_address}
										</td>
										<td class="text-center">
											${po.mp_name}
										</td>
										<td class="text-center">
											${po.customer_phone}
										</td>
										
										<td class="text-center">
											${po.pump_charge}
										</td>
										<td class="text-center">
											${po.pump_quantity}
										</td>
										<td class="text-center">
											${po.status}
										</td>
										<td class="text-center">
											<sql:query var="poi" dataSource="jdbc/rmc">
												select * from customer_quotation_item where quotation_id=?
												
												<sql:param value="${po.quotation_id}"/>												
											</sql:query>
											<table class="table table-light table-bordered">
												<c:forEach var="poi" items="${poi.rows}">
													<tr>
														<td>${poi.grade_id}</td>
														<td>${poi.grade_name}</td>
														<td>${poi.quantity}</td>
														<td>${poi.grade_price}</td>
														<td>${poi.ggbs_price}</td>
													</tr>
												</c:forEach>
											</table>
										</td>
										
										<td class="text-center">
											 <div class="btn-group dropdown">
	                                            <a href="javascript: void(0);" class="table-action-btn dropdown-toggle arrow-none btn btn-light btn-sm" data-toggle="dropdown" aria-expanded="false"><i class="mdi mdi-dots-horizontal"></i></a>
	                                            <div class="dropdown-menu dropdown-menu-right">
	                                            	<c:if test="${usertype=='superadmin'}">
	                                            	<a class="dropdown-item" href="#change-satus" data-animation="blur" data-plugin="custommodal" onclick="changeStatus('${po.quotation_id}')" data-overlaySpeed="100" data-overlayColor="#36404a"><i class="fa fa-check mr-2 text-muted font-18 vertical-middle"></i>Change Status</a>
	                                            	</c:if>
	                                            	<c:if test="${po.status=='approved'}">
	                                            	<a class="dropdown-item" href="#mail-model" data-animation="blur" data-plugin="custommodal" onclick="sendMail('${po.quotation_id}')" data-overlaySpeed="100" data-overlayColor="#36404a"><i class="fa fa-envelope-o mr-2 text-muted font-18 vertical-middle"></i>Send Mail</a>
	                                            	</c:if>
	                                           	    <a class="dropdown-item" href="PrintCustomerQuotation.jsp?quotation_id=${po.quotation_id}"><i class="mdi mdi-eye mr-2 text-muted font-18 vertical-middle"></i>Print Customer Quotation</a>
	                                           	    <a class="dropdown-item" href="PrintCustomerQuotationOPC.jsp?quotation_id=${po.quotation_id}"><i class="mdi mdi-eye mr-2 text-muted font-18 vertical-middle"></i>Print Quotation With OPC</a>
	                                           	    <a class="dropdown-item" href="PrintCustomerQuotationGGBS.jsp?quotation_id=${po.quotation_id}"><i class="mdi mdi-eye mr-2 text-muted font-18 vertical-middle"></i>Print Quotation With GGBS</a>
	                                                <a class="dropdown-item ${(po.status=='cancelled')?'hidden':''}" href="AddCustomerQuotation.jsp?action=update&quotation_id=${po.quotation_id}"><i class="mdi mdi-pencil mr-2 text-muted font-18 vertical-middle"></i>Edit Customer Quotation</a>
													<a class="dropdown-item" href="#delete-model" data-animation="blur" data-plugin="custommodal" onclick="deletequotaion('${po.quotation_id}')" data-overlaySpeed="100" data-overlayColor="#36404a"><i class="mdi mdi-window-close mr-2 text-muted font-18 vertical-middle"></i>Delete Customer Quotation</a>
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
                
                <!-- MODAL FOR PLANT DELETE START  -->
				<div id="mail-model" class="modal-demo col-xs-2">
		            <button type="button" class="close" onclick="Custombox.close();">
		                <span>&times;</span><span class="sr-only">Close</span>
		            </button>
		            <h4 class="custom-modal-title" style="color: white;background-color:#f4df42;">Are you sure want to Send Mail?</h4>
		            <div class="custom-modal-text">
		                <form class="form-horizontal" action="CustomerQuotationController?action=sendMail" method="post">
		                	<input type="hidden" name="quotation_id" id="quotation_id_email"/>
		                	
		                	<table class="table">
		                		<tr>
		                			<td>CC/BCC</td>
		                			<td><span class="text-success"><i class="fa fa-plus"></i></span></td>
		                		</tr>
		                		<tr>
		                			<td>
		                				<input type="text" name="email"  class="form-control"/>
		                			</td>
		                			<td></td>
		                		</tr>
		                	</table>
		                    <div class="form-group account-btn text-center m-t-2">
		                        <div class="col-12">
		                            <button class="btn w-lg btn-rounded btn-custom waves-effect waves-light" type="submit"><span class="change_status text-uppercase">Send Mail</span></button>
		                            <button class="btn w-lg btn-rounded btn-custom btn-danger waves-effect waves-light"  onclick="Custombox.close();" type="button">CANCEL</button>
		                        </div>
		                    </div>
		                </form>
		            </div>
		        </div>
                <!--  PLANT DELETE MODAL END  -->
                
                <!-- MODAL FOR PLANT DELETE START  -->
				<div id="delete-model" class="modal-demo col-xs-2">
		            <button type="button" class="close" onclick="Custombox.close();">
		                <span>&times;</span><span class="sr-only">Close</span>
		            </button>
		            <h4 class="custom-modal-title" style="color: white;background-color: #9b3329;">Are you sure want to delete?</h4>
		            <div class="custom-modal-text">
		                <form class="form-horizontal" action="CustomerQuotationController?action=deletequotaion" method="post">
		                	<input type="hidden" name="quotation_id" id="quotation_id_delete"/>
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
                
                
                 <!-- Customer Quoatation status change model -->
				<div id="change-satus" class="modal-demo col-xs-2">
		            <button type="button" class="close" onclick="Custombox.close();">
		                <span>&times;</span><span class="sr-only">Close</span>
		            </button>
		            <h4 class="custom-modal-title" style="color: white;background-color: #9b3329;">Change Quotation Status</h4>
		            <div class="custom-modal-text">
		                <form class="form-horizontal" id="quote" action="CustomerQuotationController?action=changeStatus" method="post">
		                	<input type="hidden" name="quotation_id" id="quotation_id_status"/>
		                	<input type="hidden" name="status" id="quotation_status"/>
		                    <div class="form-group account-btn text-center m-t-2">
		                        <div class="col-12">
		                            <button class="btn w-lg btn-rounded btn-custom waves-effect waves-light" type="button" onclick="submitStatus('approved')"><span class="change_status text-uppercase">APPROVE</span></button>
		                            <button class="btn w-lg btn-rounded btn-custom btn-danger waves-effect waves-light" type="button" onclick="submitStatus('cancelled')">CANCEL</button>
		                        </div>
		                    </div>
		                </form>
		            </div>
		        </div>
                <!-- End of customer quotation status change model -->
				
				
				
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
			function deletequotaion(quotation_id){
				$('#quotation_id_delete').val(quotation_id);
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
		    		var customer_name=$('#customer_name').val();
		    		var quotation_id=$('#quotation_id').val();
		    		window.location='CustomerQuotationList.jsp?customer_name='+customer_name+'&quotation_id='+quotation_id;
		    	});
		    });
	    </script>
			
			
			
			
			
		<script type="text/javascript">
		    $(document).ready(function(){
		    	$('#search').on('click',function(){
		    		var quotation_id=$('#quotation_id').val();
		    		var from_date=$('.from_date').val();
		    		var to_date=$('.to_date').val();
		    		var customer_name=$('#customer_name').val();
		    		var mp_name=$('#mp_name').val();
		    		window.location='CustomerQuotationList.jsp?&quotation_id='+quotation_id+'&from_date='+from_date+"&to_date="+to_date+"&customer_name="+customer_name+"&mp_name="+mp_name;
		    	});
		    });
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
    	
    	
    	function deleteInvoice(id,invoice_id){
    		$('.invoice_id_delete').text(invoice_id);
    		$('#invoice_id_delete').val(invoice_id);
    		$('#id_delete').val(id);
    	}
    	
    	function sendMail(quotation_id){
    		$('#quotation_id_email').val(quotation_id);
    	}
    	
    	
    	
    	function changeStatus(quotation_id){
    		$('#quotation_id_status').val(quotation_id);
    	}
    	
    	
    	function submitStatus(status){
    		$('#quotation_status').val(status);
    		$('#quote').submit();
    	}
    </script>
    </body>
