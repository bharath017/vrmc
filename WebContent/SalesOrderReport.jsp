<%@ include file="Session.jsp" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<!DOCTYPE html>
<html>
<head>
        <meta charset="utf-8" />
        <title>Sales Order List</title>
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
                                    <li class="breadcrumb-item"><a href="#">Customer &amp; PO</a></li>
                                    <li class="breadcrumb-item active">Sales Order</li>
                                    <li class="breadcrumb-item active">Sales Order List</li>
                                </ol>
                            </div>
                            <h4 class="page-title">Sales Order List</h4>
                        </div>
                    </div>
                </div>
                <!-- end page title end breadcrumb -->

                <div class="row">
                    <div class="col-sm-4">
                        <a href="AddPurchaseOrder.jsp" class="btn btn-custom waves-effect waves-light mb-4"  data-overlayColor="#36404a"><i class="mdi mdi-plus"></i> Add Sales Order</a>
                    </div><!-- end col -->
                </div>
                <!-- end row -->
				<div class="row filter-row">
                    <div class="col-sm-3 col-xs-6">
                        <div class="form-group form-focus">
                            <label class="control-label">PO Number</label>
                                <input class="form-control" placeholder="Enter PO Number" id="po_number" type="text" name="po_number">
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
											Customer
										</th>
										<th class="text-center">Site Name</th>
										<th class="text-center">PO Date</th>
										<th class="text-center">Marketer</th>
										<th class="text-center">PO Number</th>
										<th class="text-center">Credit Period</th>
										<th class="text-center">Plant</th>
										<th>Grade</th>
										<th>Quantity</th>
										<th>Rate</th>
									</tr>
                                </thead>
                                
                                <c:set value="${(empty param.po_number)?'':param.po_number}" var="po_number"/>
                                <c:set value="${(empty param.customer_id)?'':param.customer_id}" var="customer_id"/>
                                <c:set value="${(empty param.site_id)?'':param.site_id}" var="site_id"/>
								<sql:query var="po" dataSource="jdbc/rmc">
									select p.*,c.customer_name,s.site_name,m.mp_name,(select plant_name from plant where plant_id=p.plant_id) as plant_name, poi.*,pr.product_name from purchase_order p LEFT JOIN (customer c,site_detail s,marketing_person m,purchase_order_item poi,product pr) ON p.customer_id=c.customer_id and p.site_id=s.site_id and p.marketing_person_id=m.mp_id and poi.product_id=pr.product_id and poi.order_id=p.order_id where p.customer_id like if(''=?,'%%',?) and p.site_id like if(''=?,'%%',?) and p.po_number like if(''=?,'%%',concat('%',?,'%')) and p.plant_id like if(?=0,'%%',?) order by p.order_id desc limit 200
									<sql:param value="${customer_id}"/>
									<sql:param value="${customer_id}"/>
									<sql:param value="${site_id}"/>									
									<sql:param value="${site_id}"/>
									<sql:param value="${po_number}"/>
									<sql:param value="${po_number}"/>
									<sql:param value="${bean.plant_id}"/>
									<sql:param value="${bean.plant_id}"/>
								</sql:query>
                                <tbody>
                                <c:forEach var="po" items="${po.rows}">
									<tr class="${(po.status=='cancelled')?'text-danger':''}">
										<td class="text-center">${po.customer_name}</td>
										<td class="text-center">${po.site_name}</td>
										<td class="text-center">
											${po.po_date}
										</td>
										<td class="text-center">
											${po.mp_name}
										</td>
										<td class="text-center">
											${po.po_number}
										</td>
										<td class="text-center">
											CD : ${po.credit_days}<br>
											CL : ${po.credit_limit}
										</td>
										
										<td class="text-center">
											${(empty po.plant_name)?'All Plant':po.plant_name}
										</td>
										<td>${po.product_name}</td>
										<td>${po.quantity}</td>
										<td>${po.rate}</td>
									</tr>
									</c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
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
				 $('.select2').css('width','100%').select2({allowClear:true})
					.on('change', function(){
					}); 
				 
				  $('#example').DataTable({
						"order": [],
				        "info":true,
				        "scrollX":true,
				        "iDisplayLength":10,
				        "lengthMenu":[10,20,25,50,75,100],
				        "ordering":false,
				        "searching":false,
				        "dom": 'Blfrtip',
				        "buttons": [
				            'copyHtml5',
				            'excelHtml5',
				            'csvHtml5',
				            'pdfHtml5'
				        ],
				        lengthChange: true
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
	    		var customer_id=$('#customer_id').val();
	    		var site_id=$('#site_id').val();
	    		var po_number=$('#po_number').val();
	    		window.location='PurchaseOrderList.jsp?customer_id='+customer_id+'&site_id='+site_id+"&po_number="+po_number;
	    	});
	    });
    </script>
 
    </body>
</html>