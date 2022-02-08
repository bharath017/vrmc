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
        <link rel="shortcut icon" href="assets/images/favicon.ico">

        <!-- App css -->
        <link href="assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/icons.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/style.css" rel="stylesheet" type="text/css" />
		<!-- Custom box css -->
		<!-- DataTables -->
        <link href="plugins/datatables/dataTables.bootstrap4.min.css" rel="stylesheet" type="text/css" />
        <link href="plugins/datatables/buttons.bootstrap4.min.css" rel="stylesheet" type="text/css" />
		
        <link href="plugins/custombox/css/custombox.min.css" rel="stylesheet">
        <link rel="stylesheet" href="assets/css/select2.min.css" />
        <link rel="stylesheet" href="assets/css/render.css">
        <script src="assets/js/modernizr.min.js"></script>
        <style type="text/css">
        	.customer-table tr td:first-child,.table th {
					background-color: #13b2b5;
					color: white;
				}
        </style>

    </head>

    <body>

        <!-- Navigation Bar-->
        	<%@ include file="header.jsp" %>
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
                                   		select * from customer order by customer_name asc
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
                        		select customer_name from customer where customer_id=?
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
                                    <a href="ViewTransactionHistory.jsp"  aria-expanded="false" class="nav-link">
                                        <i class="fa fa-paypal mr-2"></i>Transaction History
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
					                            	select * from site_detail where customer_id=?
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
					                    
					                    <div class="col-sm-2 col-xs-6">
					                        <div class="form-group form-focus">
					                            <label class="control-label">&nbsp;</label>
					                            <a href="#delete-model" data-animation="blur" id="search" data-plugin="custommodal" data-overlaySpeed="100" data-overlayColor="#36404a" class="btn btn-primary btn-block"> New PO </a>
					                        </div>
					                    </div>
					                </div>
                                	<c:set value="${(empty param.from_date)?'':param.from_date}" var="from_date"/>
                                	<c:set value="${(empty param.to_date)?'':param.to_date}" var="to_date"/>
                                	<c:set value="${(empty param.site_id)?'':param.site_id}" var="site_id"/>
                                	<sql:query var="po" dataSource="jdbc/rmc">
		                           		select p.*,s.site_address from purchase_order p,site_detail s
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
                                    				select poi.*,p.product_name from purchase_order_item poi,product p where poi.product_id=p.product_id and poi.order_id=?
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
        
        
        <!-- Address Deactivate Model Details  -->
		<div id="delete-model" class="modal-demo col-xs-2">
            <button type="button" class="close" onclick="Custombox.close();">
                <span>&times;</span><span class="sr-only">Close</span>
            </button>
            <h4 class="custom-modal-title" style="color: white;background-color: #39918d;">ADD NEW PO</h4>
            <div class="custom-modal-text">
                <form class="form-horizontal" id="clicked" action="CustomerViewController?action=InsertPO" method="post">
                	<div class="form-group text-left">
                      <label>Plant <span class="text-danger">*</span></label>
                      <sql:query var="plant" dataSource="jdbc/rmc">
                      	select * from plant where plant_id like if(?=0,'%%',?)
                      	<sql:param value="${bean.plant_id}"/>
                      	<sql:param value="${bean.plant_id}"/>
                      </sql:query>
						<select id="plant_id"  name="plant_id"  required="required"  class="form-control"  data-placeholder="Choose Plant">
							<c:if test="${bean.plant_id==0}">
							<option value="0" ${(res.plant_id==0)?'selected':''}>All Plant</option>
							</c:if>
							<c:forEach var="plant" items="${plant.rows}">
							<option value="${plant.plant_id}" ${(plant.plant_id==res.plant_id)?'selected':''}>${plant.plant_name}</option>
							</c:forEach>
						</select>
					</div>
					<input type="hidden" name="customer_id" value="${customer_id}"/>
                	<div class="form-group text-left">
                		<label for="site_id" class="text-left">Site Name <span class="text-danger">*</span> </label>
                		<sql:query var="site" dataSource="jdbc/rmc">
                			select site_id,site_name from site_detail where customer_id=?
                			<sql:param value="${customer_id}"/>
                		</sql:query>
                		<select class="form-control" name="site_id" id="site_id">
                			<c:forEach items="${site.rows}" var="site">
                				<option value="${site.site_id}">${site.site_name}</option>
                			</c:forEach>
                		</select>
                	</div>
                	
                	 <div class="form-group text-left col-xs-6">
                        <label>Order Date <span class="text-danger">*</span> </label>
                        <div>
                            <div class="input-group">
                                <input type="text" name="po_date" required="required" class="form-control date-picker" value="${res.po_date}" placeholder="yyyy-mm-dd" id="id-date-picker-1" data-date-format="yyyy-mm-dd">
                                <div class="input-group-append">
                                    <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
                                </div>
                            </div>
                            <span class="parsley-required"></span>
                        </div>
                    </div>
                    
                    <div class="form-group text-left">
                        <label>PO No : </label>
                        <div>
                           <input type="text" class="form-control" 
                             pattern="[^'&quot;:]*$"  placeholder="Enter PO No."  value="${res.po_number}"  name="po_number"/>
                        </div>
                    </div>
	                                
                   <div class="form-group text-left">
                        <label>GST Category <span class="text-danger">*</span></label>
                        <sql:query var="gst" dataSource="jdbc/rmc">
                        	select * from gst_percent
                        </sql:query>
						<select id="gst_id"  name="gst_id" required="required"   class="form-control"  data-placeholder="Select GST Category">
							<c:forEach items="${gst.rows}" var="gst">
								<option value="${gst.gst_id}" ${(gst.gst_id==res.gst_id)?'selected':''}>${gst.gst_category} @${gst.gst_percent}</option>
							</c:forEach>
						</select>
                 </div>
		         <div class="form-group text-left">
	                 <label>Order Type<span class="text-danger">*</span></label>
					<select id="order_type"  name="order_type"   class="form-control"  data-placeholder="Choose Plant">
						<option value="close" ${(res.order_type=='close')?'selected':''}>CLOSE ORDER</option>
						<option value="open" ${(res.order_type=='open')?'selected':''}>OPEN ORDER</option>
					</select>
	            </div>                     
                                 
                                 
                                
              <div class="form-group text-left">
                  <label>Marketing Person <span class="text-danger">*</span></label>
                  <sql:query var="market" dataSource="jdbc/rmc">
                  	select * from marketing_person where mp_status='active'  order by mp_name asc
                  </sql:query>
					<select id="mp_id"  name="mp_id"    class="form-control"  data-placeholder="Choose Marketing Person" required="required">
						<c:forEach var="market" items="${market.rows}">
						<option value="${market.mp_id}" ${(market.mp_id==res.marketing_person_id)?'selected':''}>${market.mp_name}</option>
						</c:forEach>
					</select>
              </div>
              
              <table class="table table-bordered" id="Table1">
            		<thead>
            			<tr>
	             			<th class="text-center">Grade <span class="text-danger">*</span></th>
	             			<th class="text-center">Quantity <span class="text-danger">*</span></th>
	             			<th class="text-center">Rate <span class="text-danger">*</span></th>
	             			<th class="text-center">
	             				<span class="text-success BtnPlus">
	             					<i class="fa fa-plus"></i>
	             				</span>
	             			</th>
	             		</tr>
            		</thead>
                             		
               		<!-- get purchase order details -->
               		<sql:query var="poi" dataSource="jdbc/rmc">
               			select * from purchase_order_item  where order_id=?
               			<sql:param value="${res.order_id}"/>
               		</sql:query>
                   		<tbody>
                   			<tr>
                   				<td style="width:30%">
									<sql:query var="grade" dataSource="jdbc/rmc">
			                           	select * from product
			                         </sql:query>
									<select id="product_id" required="required"  name="product_id"   class="form-control"  data-placeholder="Choose Grade">
										<c:forEach var="grade" items="${grade.rows}">
										<option value="${grade.product_id}">${grade.product_name}</option>
										</c:forEach>
									</select>		                                				
                   				</td>
                   				<td style="width:30%">
                   					<input type="text" class="form-control" 
                             				pattern="[^'&quot;:]*$"  required="required" placeholder="Enter Quantity"   name="quantity"/>
                   				</td>
                   				<td style="width:35%">
                   					<input type="text" class="form-control" 
                            			 pattern="[^'&quot;:]*$"  required="required" placeholder="Enter Rate"   name="rate"/>
                   				</td>
                   				<td></td>
                   			</tr>
                   		</tbody>
                   </table>
                	
                    <div class="form-group account-btn text-center m-t-2">
                        <div class="col-12">
                            <button class="btn w-lg btn-rounded btn-custom waves-effect waves-light" type="submit">Save</button>
                            <button class="btn w-lg btn-rounded btn-custom btn-danger waves-effect waves-light"  onclick="Custombox.close();" type="button">CANCEL</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>


		<sql:query var="pro" dataSource="jdbc/rmc">
			select * from product
		</sql:query>
		<c:set var="name">
			<select   class="form-control" name="product_id">'+
				<c:forEach items="${pro.rows}" begin="0" var="pro">
					'<option value="${pro.product_id}">${pro.product_name}</option>'+
				</c:forEach>
			'</select>
		</c:set>
        <!-- Footer -->
       <%@ include file="footer.jsp" %>
        <!-- End Footer -->


        <!-- jQuery  -->
        <script src="assets/js/jquery.min.js"></script>
        <script src="assets/js/popper.min.js"></script>
        <script src="assets/js/bootstrap.min.js"></script>
        <script src="assets/js/waves.js"></script>
        <script src="assets/js/jquery.slimscroll.js"></script>


        <!-- App js -->
        <script src="assets/js/jquery.core.js"></script>
        <script src="assets/js/jquery.app.js"></script>
        <script src="assets/js/select2.min.js"></script>
        <script src="plugins/custombox/js/custombox.min.js"></script>
        <script src="plugins/custombox/js/legacy.min.js"></script>
        <script src="picker/js/moment.min.js"></script>
		<script src="picker/js/bootstrap-datepicker.min.js"></script>
		<script src="assets/js/bootstrap-timepicker.min.js"></script>
		
		<!-- Required datatable js -->
        <script src="plugins/datatables/jquery.dataTables.min.js"></script>
        <script src="plugins/datatables/dataTables.bootstrap4.min.js"></script>
       
        <script type="text/javascript">
            $(document).ready(function() {
               // $('form').parsley();
                
                $('.select2').css('width','100%').select2({allowClear:true})
				.on('change', function(){
				}); 
            });
        </script>
        
        <script type="text/javascript">
			$(document).ready(function () {
			    function addRow(){
			        var html = '<tr>'+
									'<td>'+
										'${name}'+
									'</td>'+
									'<td>'+
										'<input type="text" class="form-control" pattern="[^\'&quot;:]*$"  required="required" placeholder="Enter Quantity"   name="quantity"/>'+
									'</td>'+
									'<td>'+
										'<input type="text" class="form-control"  pattern="[^\'&quot;:]*$"  required="required" placeholder="Enter Rate"   name="rate"/>'+
									'</td>'+
									'<td>'+
										'<span class="text-danger removebtn"><i class="fa fa-trash"></i></span>'+
									'</td>'+
								'</tr>'
			        $(html).appendTo($("#Table1"))
			        $('.select2').css('width','100%').select2({allowClear:true})
					.on('change', function(){
					}); 
			    };
			    $("#clicked").on("click", ".BtnPlus", addRow);
			});
			 $('#Table1').on('click', '.removebtn', function(){
				    $(this).closest ('tr').remove ();
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
                		url:'CustomerController?action=changeCustomer&customer_id='+customer_id,
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
        			url:'CustomerController?action=getSiteDetailsForUpdate&site_id='+site_id,
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