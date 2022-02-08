<!DOCTYPE html>
<%@ include file="Session.jsp" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<html>
<head>
        <meta charset="utf-8" />
        <title>Customer Address</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
        <meta content="A fully featured admin theme which can be used to build CRM, CMS, etc." name="description" />
        <meta content="Coderthemes" name="author" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />

        <!-- App favicon -->
        <link rel="shortcut icon" href="../assets/images/favicon.ico">

        <!-- App css -->
        <link href="../assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="../assets/css/icons.css" rel="stylesheet" type="text/css" />
        <link href="../assets/css2/style.css" rel="stylesheet" type="text/css" />
		<!-- Custom box css -->
		<!-- DataTables -->
        <link href="../plugins/datatables/dataTables.bootstrap4.min.css" rel="stylesheet" type="text/css" />
        <link href="../plugins/datatables/buttons.bootstrap4.min.css" rel="stylesheet" type="text/css" />
		
        <link href="../plugins/custombox/css/custombox.min.css" rel="stylesheet">
        <link rel="stylesheet" href="../assets/css/select2.min.css" />
        <link rel="stylesheet" href="../assets/css/render.css">
        <script src="../assets/js/modernizr.min.js"></script>
        <style type="text/css">
        	.customer-table tr td:first-child,.table th {
					background-color: #13b2b5;
					color: white;
				}
        </style>

    </head>

    <body>

        <!-- Navigation Bar-->
        	<%@ include file="../header.jsp" %>
        <!-- End Navigation Bar-->

        <div class="wrapper">
            <div class="container-fluid">
                <!-- end page title end breadcrumb -->
                <div class="row">
                	<div class="col-sm-12">
                		<div class="page-title-box">
                            <div class="btn-group pull-right">
                                <ol class="breadcrumb hide-phone p-0 m-0">
                                    <li class="breadcrumb-item"><a href="#">Home</a></li>
                                    <li class="breadcrumb-item"><a href="#">Customer List</a></li>
                                    <li class="breadcrumb-item active">Customer Panel</li>
                                    <li class="breadcrumb-item active">Invoice List</li>
                                </ol>
                            </div>
                            <h4 class="page-title">Invoice List</h4>
                        </div>
                	</div>
                </div>
                <div class="row">
                	<div class="col-sm-12">
                		<div class="col-sm-3 pull-right">
                          	<div class="form-group">
                                   <label>Choose Customer<span class="text-danger">*</span></label>
                                   <sql:query var="customer" dataSource="jdbc/rmc">
                                   		select * from test_customer order by customer_name asc
                                   </sql:query>
								<select id="customer_id"    class="select2"  data-placeholder="Choose Customer">
									<option value="">&nbsp;</option>
									<c:forEach var="customer" items="${customer.rows}">
									<option value="${customer.customer_id}" ${(customer.customer_id==customer_id)?'selected':''}>${customer.customer_name}</option>
									</c:forEach>
								</select>
                            </div>
                        </div>
                        
                        <div class="col-sm-3 pull-left">
                        	<br>
                          	<a href="AddCustomer.jsp" class="btn btn-custom waves-effect waves-light mb-4"  data-overlayColor="#36404a"><i class="mdi mdi-plus"></i>Add Customer</a>
                          	<a href="AddCustomer.jsp" class="btn btn-custom waves-effect waves-light mb-4"  data-overlayColor="#36404a"><i class="mdi mdi-plus"></i>Customer List</a>
                        </div>
                	</div>
                </div>
                
             	<div class="row">
             		<div class="col-md-12">
                        <div class="card-box">
                            <sql:query var="name" dataSource="jdbc/rmc">
                        		select customer_name from test_customer where customer_id=?
                        		<sql:param value="${customer_id}"/>
                        	</sql:query>
                        	
                            <h4 class="header-title m-t-0 m-b-30">
                            	<c:forEach items="${name.rows}" var="name">
                            		${name.customer_name}
                            	</c:forEach>
                            </h4>

                            <ul class="nav nav-pills navtab-bg nav-justified pull-in ">
                                <li class="nav-item">
                                    <a href="ViewCustomer.jsp" aria-expanded="false" class="nav-link">
                                        <i class="fi-head mr-2"></i>Profile
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a href="ViewInvoice.jsp" aria-expanded="true" class="nav-link">
                                        <i class="fa fa-money mr-2"></i>Invoice
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a href="ViewPurchaseOrder.jsp" aria-expanded="false" class="nav-link active">
                                        <i class="fa fa-shopping-cart mr-2"></i>Purchase Order
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a href="ViewPayment.jsp"  aria-expanded="false" class="nav-link">
                                        <i class="fa fa-paypal mr-2"></i>Payment
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a href="ViewMixDesign.jsp"  aria-expanded="false" class="nav-link">
                                        <i class="fi-cog mr-2"></i>Mix Design
                                    </a>
                                </li>
                            </ul>
                            <div class="tab-content">
                                <div class="tab-pane show active" id="home1">
                                	<div class="row filter-row">
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
					                            <label class="control-label">Site : </label>
					                            <sql:query var="site" dataSource="jdbc/rmc">
					                            	select * from test_site_detail where customer_id=?
					                            	<sql:param value="${customer_id}"/>
					                            </sql:query>
					                            <select class="form-control select2 floating"   id="site_id">
					                                <option value="">All Site</option>
					                                <c:forEach var="site" items="${site.rows}">
					                                	<option value="${site.site_id}">${site.site_name}</option>
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
                                	<c:set value="${(empty param.from_date)?'':param.from_date}" var="from_date"/>
                                	<c:set value="${(empty param.to_date)?'':param.to_date}" var="to_date"/>
                                	<c:set value="${(empty param.site_id)?'':param.site_id}" var="site_id"/>
                                	<sql:query var="po" dataSource="jdbc/rmc">
		                           		select p.*,s.site_address from test_purchase_order p,test_site_detail s
		                           	    where p.site_id=s.site_id
		                           	    and  p.customer_id=?
		                           	    and p.po_date between if(''=?,'2014-01-01',?) and if(''=?,'2088-01-01',?)
		                           	    and p.site_id like if(''=?,'%%',?)
		                           		<sql:param value="${customer_id}"/>
		                           		<sql:param value="${from_date}"/>
		                           		<sql:param value="${from_date}"/>
		                           		<sql:param value="${to_date}"/>
		                           		<sql:param value="${to_date}"/>
		                           		<sql:param value="${site_id}"/>
		                           		<sql:param value="${site_id}"/>	
		                           	</sql:query>
		                         	
		                         	
                                    <div class="col-sm-12">
                                    	<div class="row">
                                    		<c:forEach items="${po.rows}" var="po">
                                    			<sql:query var="poi" dataSource="jdbc/rmc">
                                    				select poi.*,p.product_name from test_purchase_order_item poi,product p where poi.product_id=p.product_id and poi.order_id=?
                                    				<sql:param value="${po.order_id}"/>
                                    			</sql:query>
                                    			<div class="col-sm-4">
                                    				<table class="table table-bordered text-center">
	                                    				<thead>
	                                    					<tr>
	                                    						<td colspan="4" style="background-color:#d0f2f4;">
	                                    						Site : ${po.site_address}<br>PO No : ${po.po_number}<br>Date : ${po.po_date}</td>
	                                    					</tr>
	                                    					<tr style="background-color: #dcf7b7;">
		                                    					<td>Grade</td>
		                                    					<td>Quantity</td>
		                                    					<td>Rate</td>
		                                    					<td>View</td>
		                                    				</tr>
	                                    				</thead>
	                                    				<tbody>
	                                    					<c:forEach items="${poi.rows}" var="poi">
	                                    						<tr>
		                                    						<td>${poi.product_name}</td>
		                                    						<td>${poi.quantity}</td>
		                                    						<td>${poi.rate}</td>
		                                    						<td></td>
		                                    					</tr>
	                                    					</c:forEach>
	                                    				</tbody>
	                                    			</table>
                                    			</div>
                                    		</c:forEach>
                                    	</div>
			                        </div>
                                </div>
                            </div>
                        </div>
                    </div> <!-- end col -->
              	 </div>
                <!-- end row -->
            </div> <!-- end container -->
        </div>
        <!-- end wrapper -->


        <!-- Footer -->
       <%@ include file="../footer.jsp" %>
        <!-- End Footer -->


        <!-- jQuery  -->
        <script src="../assets/js/jquery.min.js"></script>
        <script src="../assets/js/popper.min.js"></script>
        <script src="../assets/js/bootstrap.min.js"></script>
        <script src="../assets/js/waves.js"></script>
        <script src="../assets/js/jquery.slimscroll.js"></script>

        <!-- Parsley js -->
        <script type="text/javascript" src="../plugins/parsleyjs/parsley.min.js"></script>

        <!-- App js -->
        <script src="../assets/js/jquery.core.js"></script>
        <script src="../assets/js/jquery.app.js"></script>
        <script src="../assets/js/select2.min.js"></script>
        <script src="../plugins/custombox/js/custombox.min.js"></script>
        <script src="../plugins/custombox/js/legacy.min.js"></script>
        <script src="../picker/js/moment.min.js"></script>
		<script src="../picker/js/bootstrap-datepicker.min.js"></script>
		<script src="../assets/js/bootstrap-timepicker.min.js"></script>
		
		<!-- Required datatable js -->
        <script src="../plugins/datatables/jquery.dataTables.min.js"></script>
        <script src="../plugins/datatables/dataTables.bootstrap4.min.js"></script>
       
        <script type="text/javascript">
            $(document).ready(function() {
                $('form').parsley();
                
                $('.select2').css('width','100%').select2({allowClear:true})
				.on('change', function(){
				}); 
            });
        </script>
        <script type="text/javascript">
            $(document).ready(function() {

                // Default Datatable
                $('#datatable').DataTable();

                
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
                
            } );

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
        	$(document).ready(function(){
        		$('#customer_id').on("change",function(){
        			var customer_id=$('#customer_id').val();
        			$.ajax({
                		type:'POST',
                		url:'../CustomerControllerTest?action=changeCustomer&customer_id='+customer_id,
                		headers:{
                			Accept:"text/html;charset=utf-8",
                			"Content-Type":"text/html;charset=utf-8"
                		},
                		success:function(result){
                			location.reload();
                		}
                	}); 
        		});
        	});
        </script>
        <script type="text/javascript">
        	function updateCustomerAddress(site_id){
        		$.ajax({
        			type:'POST',
        			url:'../CustomerControllerTest?action=getSiteDetailsForUpdate&site_id='+site_id,
        			headers:{
        				Accept:"application/json;charset=utf-8",
        				"Content-Type":"application/json;charset=utf-8"
        			},
        			success:function(res){
        				$('#edit_site_id').val(res.site_id);
        				$('#edit_site_name').val(res.site_name);
        				$('#edit_site_address').val(res.site_address);
        				$('#edit_tally_ledger').val(res.tally_ladger);
        			}
        		})
        	}
        </script>
        <script type="text/javascript">
        	function changeAddressStatus(site_id,site_name,site_status){
        		$('.show_status').text(site_status);
        		$('.site_name').text(site_name);
        		$('#status_site_id').val(site_id);
        		$('#site_status').val(site_status);
        	}
        </script>
        
         <script type="text/javascript">
		    $(document).ready(function(){
		    	$('#search').on('click',function(){
		    		var site_id=$('#site_id').val();
		    		var from_date=$('.from_date').val();
		    		var to_date=$('.to_date').val();
		    		window.location="ViewPurchaseOrder.jsp?site_id="+site_id+"&from_date="+from_date+"&to_date="+to_date;
		    	});
		    });
    	</script>

    </body>
</html>