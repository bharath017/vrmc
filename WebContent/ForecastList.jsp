<%@ include file="Session.jsp" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
        <meta charset="utf-8" />
        <title>Forecast List</title>
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
                                    <li class="breadcrumb-item"><a href="#">Sales</a></li>
                                    <li class="breadcrumb-item active">Forecast</li>
                                    <li class="breadcrumb-item active">Forcast List</li>
                                </ol>
                            </div>
                            <h4 class="page-title">Forecast List</h4>
                        </div>
                    </div>
                </div>
                <!-- end page title end breadcrumb -->

                <div class="row">
                    <div class="col-sm-4">
                        <a href="AddForecast.jsp" class="btn btn-custom waves-effect waves-light mb-4"  data-overlayColor="#36404a"><i class="mdi mdi-plus"></i> Add Forecast</a>
                    </div><!-- end col -->
                     <c:choose>
                <c:when test="${param.action=='update'}">
                    <div class="col-sm-8 text-right">
                        <a href="ForecastList.jsp" class="btn btn-custom waves-effect waves-light mb-4"  data-overlayColor="#36404a"> Forecast List</a>
                    </div>
                    </c:when>
                    <c:otherwise>
					<div class="col-sm-8 text-right">
                        <a href="ForecastList.jsp?action=update" class="btn btn-custom waves-effect waves-light mb-4"  data-overlayColor="#36404a">Monthly Forecast List</a>
                    </div>

				</c:otherwise>
                  </c:choose>
                </div>
                <!-- end row -->
			<%-- 	<div class="row filter-row">
                    <div class="col-sm-3 col-xs-6 form-group">
                        <label>Forecast Date <span class="text-danger">*</span> </label>
                        <div>
                            <div class="input-group">
                                <input type="text" name="scheduling_date" class="form-control date-picker scheduling_date" placeholder="yyyy-mm-dd" id="id-date-picker-1" data-date-format="yyyy-mm-dd">
                                <div class="input-group-append">
                                    <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-3 col-xs-6">
                        <div class="form-group form-focus select-focus">
                            <label class="control-label">Choose Customer</label>
                            <sql:query var="customer" dataSource="jdbc/rmc">
                            	select * from customer where customer_status='active'
                            </sql:query>
                            <select class="select2 form-control floating" id="customer_id">
                                <option value="">All Customer</option>
                                <c:forEach items="${customer.rows}" var="customer">
                                	<option value="${customer.customer_id}">${customer.customer_name}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    
                    <div class="col-sm-3 col-xs-6">
                        <div class="form-group form-focus select-focus">
                            <label class="control-label">Site</label>
                            <select class="form-control select2 floating"   id="site_id">
                                <option value="">All Site</option>
                            </select>
                        </div>
                    </div>
                    
                    <div class="col-sm-3 col-xs-6">
                        <div class="form-group form-focus">
                            <label class="control-label">&nbsp;</label>
                            <a href="#" id="search" class="btn btn-success btn-block"> Search </a>
                        </div>
                    </div>
                </div> --%>
                <c:choose>
                <c:when test="${param.action=='update'}">
                <c:catch var="e">
                <div class="row">
                    <div class="col-12">
                        <div class="card-box table-responsive">
                            <h4 style="color: green;">${res}</h4>
                            <c:remove var="res"/>
                            <table id="example" class="table table-striped table-bordered table-condensed" cellspacing="0" width="100%">
                                <thead>
	                                <tr>
	                                	<th class="text-center">Plant</th>
										<th class="text-center">Customer</th>
										<th class="text-center">Site Name</th>
										<th class="text-center">BDM</th>
										<th class="text-center">Project Quantity</th>
										<th class="text-center">Monthly Forecast Quantity</th>
										<th class="text-center">Expected Avg C1</th>
										<th class="text-center"> Week1(1-10) Forecast Qty</th>
										<th class="text-center"> Week2(11-17) Forecast Qty</th>
										<th class="text-center"> Week3(18-25) Forecast Qty</th>
										<th class="text-center"> Week4(26-<span id="lastDay"></span>) Forecast Qty</th>
										<th class="text-center">OPTION</th>
									</tr>
                                </thead>
                                
                                <c:set value="${(empty param.date)?'':param.date}" var="scheduling_date"/>
                                <c:set value="${(empty param.customer_id)?'':param.customer_id}" var="customer_id"/>
                                <c:set value="${(empty param.site_id)?'':param.site_id}" var="site_id"/>
								<sql:query var="sch" dataSource="jdbc/rmc">
								select c.customer_name,s.site_name,p.project_quantity,fi.*,
								(select plant_name from plant where plant_id=p.plant_id) as plant_name,m.mp_name from forecast_item fi 
								LEFT JOIN (customer c,site_detail s,marketing_person m,forecast p) ON p.forecast_id=fi.forecast_id and
								 p.customer_id=c.customer_id and p.site_id=s.site_id and p.mp_id=m.mp_id 
								 group by c.customer_name,s.site_name,p.forecast_id
								  order by p.forecast_id  desc limit 50
								</sql:query>
                                <tbody>
                                <c:forEach var="sch" items="${sch.rows}">
									<tr>
										<td class="text-center">${sch.plant_name}</td>
										<td class="text-center">${sch.customer_name}</td>
										<td class="text-center">${sch.site_name}</td>
										<td class="text-center">${sch.mp_name}</td>
										<td class="text-center">${sch.project_quantity}</td>
									    <td>${(empty sch.monthly_forecast)?'0':sch.monthly_forecast}</td>
									    <td>${(empty sch.average_c1)?'0':sch.average_c1}</td>
									    <td>${(empty sch.week1_forecast)?'0':sch.week1_forecast}</td>
									    <td>${(empty sch.week2_forecast)?'0':sch.week2_forecast}</td>
									    <td>${(empty sch.week3_forecast)?'0':sch.week3_forecast}</td>
									    <td>${(empty sch.week4_forecast)?'0':sch.week4_forecast}</td>
										<td class="text-center">
											 <div class="btn-group dropdown">
	                                            <a href="javascript: void(0);" class="table-action-btn dropdown-toggle arrow-none btn btn-light btn-sm" data-toggle="dropdown" aria-expanded="false"><i class="mdi mdi-dots-horizontal"></i></a>
	                                            <div class="dropdown-menu dropdown-menu-right">
	                                            	<a class="dropdown-item" href="AddForecast.jsp?action=update&forecast_id=${sch.forecast_id}" ><i class="fa fa-pencil mr-2 text-muted font-18 vertical-middle"></i>  Update Forecast</a>
	                                           	    <a class="dropdown-item" href="#view-model" data-animation="blur" data-plugin="custommodal" onclick="deleteScheduling('${sch.forecast_item_id}');lockMonth('${sch.year}','${sch.month}')" data-overlaySpeed="100" data-overlayColor="#36404a"><i class="mdi mdi-eye mr-2 text-muted font-18 vertical-middle"></i>Update Weekly Forecast</a>
	                                                <a class="dropdown-item" href="#delete-model" data-animation="blur" data-plugin="custommodal" onclick="deleteScheduling('${sch.forecast_id}')" data-overlaySpeed="100" data-overlayColor="#36404a"><i class="mdi mdi-window-close mr-2 text-muted font-18 vertical-middle"></i>Delete Forecast</a>
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
                </c:catch>
                <!-- end row -->
			</c:when>
			
			<c:otherwise>
			
			
			<div class="row">
                    <div class="col-12">
                        <div class="card-box table-responsive">
                            <h4 style="color: green;">${res}</h4>
                            <c:remove var="res"/>
                            <table id="example" class="table table-striped table-bordered table-condensed" cellspacing="0" width="100%">
                                <thead>
	                                <tr>
	                                	<th class="text-center">Plant</th>
										<th class="text-center">Customer</th>
										<th class="text-center">Site Name</th>
										<th class="text-center">BDM</th>
										<th class="text-center">Project Quantity</th>
										<th class="text-center">OPTION</th>
									</tr>
                                </thead>
                                
                                <c:set value="${(empty param.date)?'':param.date}" var="scheduling_date"/>
                                <c:set value="${(empty param.customer_id)?'':param.customer_id}" var="customer_id"/>
                                <c:set value="${(empty param.site_id)?'':param.site_id}" var="site_id"/>
								<sql:query var="sch" dataSource="jdbc/rmc">
								select w.customer_name,w.site_name,w.project_quantity,w.forecast_id,w.plant_name,w.plant_id,w.site_id,w.customer_id,w.mp_name from (select c.customer_name,s.site_name,p.project_quantity,p.forecast_id,(select plant_name from 
								plant where plant_id=p.plant_id) as plant_name,p.plant_id,p.site_id,c.customer_id,m.mp_name from forecast p
								LEFT JOIN (customer c,site_detail s,marketing_person m) ON
								 p.customer_id=c.customer_id and p.site_id=s.site_id and p.mp_id=m.mp_id )as w
								 group by w.customer_name,w.site_name,w.project_quantity,w.forecast_id,w.plant_name,w.plant_id,w.site_id,w.customer_id,w.mp_name
								  order by w.forecast_id  desc limit 50;
								</sql:query>
                                <tbody>
                                <c:forEach var="sch" items="${sch.rows}">
									<tr>
										<td class="text-center">${sch.plant_name}</td>
										<td class="text-center">${sch.customer_name}</td>
										<td class="text-center">${sch.site_name}</td>
										<td class="text-center">${sch.mp_name}</td>
										<td class="text-center">${sch.project_quantity}</td>
										
										<td class="text-center">
											 <div class="btn-group dropdown">
	                                            <a href="javascript: void(0);" class="table-action-btn dropdown-toggle arrow-none btn btn-light btn-sm" data-toggle="dropdown" aria-expanded="false"><i class="mdi mdi-dots-horizontal"></i></a>
	                                            <div class="dropdown-menu dropdown-menu-right">
	                                            	<a class="dropdown-item" href="AddForecast.jsp?action=update&forecast_id=${sch.forecast_id}" ><i class="fa fa-pencil mr-2 text-muted font-18 vertical-middle"></i>  Update Forecast</a>
	                                           	    <a class="dropdown-item" href="#view-model" data-animation="blur" data-plugin="custommodal" onclick="deleteScheduling('${sch.forecast_id}')" data-overlaySpeed="100" data-overlayColor="#36404a"><i class="mdi mdi-eye mr-2 text-muted font-18 vertical-middle"></i>Update Monthly Forecast</a>
	                                                <a class="dropdown-item" href="#delete-model" data-animation="blur" data-plugin="custommodal" onclick="deleteScheduling('${sch.forecast_id}')" data-overlaySpeed="100" data-overlayColor="#36404a"><i class="mdi mdi-window-close mr-2 text-muted font-18 vertical-middle"></i>Delete Forecast</a>
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
			
			
			
			
			</c:otherwise>
		</c:choose>

				<!-- MODAL FOR PLANT DELETE START  -->
				<div id="delete-model" class="modal-demo col-xs-2">
		            <button type="button" class="close" onclick="Custombox.close();">
		                <span>&times;</span><span class="sr-only">Close</span>
		            </button>
		            <h4 class="custom-modal-title" style="color: white;background-color: #b70b22;">Are you sure want to delete this Forecast ?</h4>
		            <div class="custom-modal-text">
		                <form class="form-horizontal" action="ForecastController?action=deleteForecast" method="post">
		                	<input type="hidden" name="forecast_id" id="forecast_id1"/>
		                    <div class="form-group account-btn text-center m-t-2">
		                        <div class="col-12">
		                            <button class="btn w-lg btn-rounded btn-custom waves-effect waves-light" type="submit"><span class="change_status text-uppercase">Delete Forecast</span></button>
		                            <button class="btn w-lg btn-rounded btn-custom btn-danger waves-effect waves-light"  onclick="Custombox.close();" type="button">Exit</button>
		                        </div>
		                    </div>
		                </form>
		            </div>
		        </div>
                <!--  PLANT DELETE MODAL END  -->
                
                <!-- View All Invoice according to scheduling  -->
				<div id="view-model" class="modal-demo col-xs-2">
		            <button type="button" class="close" onclick="Custombox.close();">
		                <span>&times;</span><span class="sr-only">Close</span>
		            </button>
		            <h4 class="custom-modal-title" style="color: white;background-color: #88c615;">TOTAL GENERATED INVOICE</h4>
		            <div class="custom-modal-text">
		                 <form class="form-horizontal" action="ForecastController?action=UpdateWeeklyForecast" method="post">
		                	<input type="hidden" name="forecast_id" id="forecast_id"/>
		                 	<input type="hidden" id="first_date"/>
		                 	<input type="hidden" id="last_date"/>
		                	<div class="col-sm-12 form-group">
		                		<lable><b>Forecast Type</b></lable>
		                		<div class="input-group">
		                			 <select class="form-control" required name="forecast_type" id="type" data-placeholder="Select Forecast Type">
		                			 <c:choose>
		                			 <c:when test="${param.action=='update'}">
		                			 <option value="week1_forecast">Week1 Forecast</option>
		                			 <option value="week2_forecast">Week2 Forecast</option>
		                			 <option value="week3_forecast">Week3 Forecast</option>
		                			 <option value="week4_forecast">Week4 Forecast</option>
		                			 </c:when>
		                			 <c:otherwise>
		                			  <option value="monthly_forecast">Monthly Forecast</option>
		                			 </c:otherwise>
		                			 </c:choose>
		                			 
		                			
		                			 </select>
		                		</div>
		                	</div> 
		                	<div class="form-group hidden">
                                    <label>Date <span class="text-danger">*</span> </label>
                                    <div>
                                        <div class="input-group">
                                            <input type="text" name="forecast_date" class="form-control date-picker scheduling_date hidden"  placeholder="yyyy-mm-dd" id="id-date-picker-1" data-date-format="yyyy-mm-dd">
                                            <div class="input-group-append">
                                                <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
		                	<div class="col-sm-12 form-group hidden">
		                		<lable><b>Expected Avg C1</b></lable>
		                		<div class="input-group">
		                			 <input type="number" step="0.1" class="form-control hidden"  id="average_c1" name="average_c1" />
		                		</div>
		                	</div>
		                	<div class="col-sm-12 form-group">
		                		<lable><b>Forecast Quantity</b></lable>
		                		<div class="input-group">
		                			 <input type="number" step="0.1" class="form-control"  name="forecast_quantity" />
		                		</div>
		                	</div>
		                    <div class="form-group account-btn text-center m-t-2">
		                        <div class="col-12">
		                            <button class="btn w-lg btn-rounded btn-custom waves-effect waves-light" type="submit">Submit Forecast</button>
		                            <button class="btn w-lg btn-rounded btn-custom btn-danger waves-effect waves-light"  onclick="Custombox.close();" type="button">Exit</button>
		                        </div>
		                    </div>
		                </form>
		            </div>
		        </div>
				<!-- End View all invoice according to scheduling -->
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
        function lockMonth(year,month){
        	var last_day = new Date(year, month,0);
        	var first_day = new Date(year, month-1,1);
        	$('#first_date').val(first_day);
        	$('#last_date').val(last_day);
        	$('.date-picker').datepicker('remove'); 
   			 $('.scheduling_date').val('');
    		   $('.date-picker').datepicker({
				autoclose: true,
				todayHighlight: true,
				startDate: first_day,
			   	endDate: last_day
		 	}); 
        	}
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
			function deleteScheduling(forecast_id){
				$('#forecast_id').val(forecast_id);
				$('#forecast_id1').val(forecast_id);
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
				
					var type=$('#type').val();
					if(type=='monthly_forecast'){
						$('.hidden').show();
						$('.date-picker').datepicker('remove');
						  $('.date-picker').datepicker({
				   				autoclose: true,
				   				todayHighlight: true,
				   		 	});
					}else{
						var first_day = $('#first_date').val();
		        		var last_day = $('#last_date').val();
						$('.hidden').hide();
						 $('.date-picker').datepicker('remove'); 
		        		 $('.scheduling_date').val('');
		         	   $('.date-picker').datepicker({
		   				autoclose: true,
		   				todayHighlight: true,
		   				startDate: first_day,
		   			   	endDate: last_day
		   		 	});
					}
			
			});
		</script>
		<script type="text/javascript">
	    $(document).ready(function(){
	    	$('#search').on('click',function(){
	    		var customer_id=$('#customer_id').val();
	    		var site_id=$('#site_id').val();
	    		var scheduling_date=$('.scheduling_date').val();
	    		window.location='SchedulingList.jsp?customer_id='+customer_id+'&site_id='+site_id+"&scheduling_date="+scheduling_date;
	    	});
	    });
    </script>
    <script type="text/javascript">
    	function getInvoiceDetails(customer_id,site_id,date){
    		$.ajax({
    			type:'POST',
    			url:'SchedulingController?action=ViewDetails&customer_id='+customer_id+'&site_id='+site_id+'&date='+date,
    			headers:{
    				Accept:"application/json;charset=utf-8",
    				"Content-Type":"application/json;charset=utf-8"
    			},
    			success:function(res){
    				$('#view tbody').html("");
    				$.each(res,function(d,i){
    					var row='<tr>'
    					row+='<td>'+i.invoice_id+'</td>'
    					row+='<td>'+i.product_name+'</td>'
    					row+='<td>'+i.vehicle_no+'</td>'
    					row+='<td>'+i.quantity+'</td>'
    					row+='</tr>'
    					$('#view tbody').append(row);
    				});
    			}
    		});
    	}
    </script>
    <script type="text/javascript">
    	function getInvoiceDetails(customer_id,site_id,date){
    		$.ajax({
    			type:'POST',
    			url:'SchedulingController?action=ViewDetails&customer_id='+customer_id+'&site_id='+site_id+'&date='+date,
    			headers:{
    				Accept:"application/json;charset=utf-8",
    				"Content-Type":"application/json;charset=utf-8"
    			},
    			success:function(res){
    				$('#view tbody').html("");
    				$.each(res,function(d,i){
    					var row='<tr>'
    					row+='<td>'+i.invoice_id+'</td>'
    					row+='<td>'+i.product_name+'</td>'
    					row+='<td>'+i.vehicle_no+'</td>'
    					row+='<td>'+i.quantity+'</td>'
    					row+='</tr>'
    					$('#view tbody').append(row);
    				});
    			}
    		});
    	}
    </script>
<script>
$(document).ready(function(){
	var date=new Date();
	var last_day = new Date(date.getFullYear(), date.getMonth()+1,0);
	$('#lastDay').text(last_day.getDate());
	
})</script>
    </body>
</html>