<%@ include file="Session.jsp" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>  
<!DOCTYPE html>
<html>
<head>
        <meta charset="utf-8" />
        <title>Consolidate Invoice List</title>
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

                <!-- end row -->
				<div class="row filter-row">
					<div class="col-sm-3 col-xs-6">
                        <div class="form-group form-focus">
                            <label class="control-label">Invoice No</label>
                                <input class="form-control" placeholder="Enter Invoice No" id="consolidate_invoice_id" type="text" name="invoice_id">
                        </div>
                    </div>
                    <div class="col-sm-3 col-xs-6">
                        <div class="form-group form-focus select-focus">
                            <label class="control-label">Customer : </label>
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
											Consolidate Invoice No
										</th>
										<th class="text-center">Customer</th>
										<th class="text-center">Date</th>
										<th class="text-center">Net Quantity</th>
										<th class="text-center">Net Amount</th>
										<th class="text-center">OPTION</th>
									</tr>
                                </thead>
                                <c:set value="${(empty param.consolidate_invoice_id)?'':param.consolidate_invoice_id}" var="consolidate_invoice_id"/>
                                <c:set value="${(empty param.customer_id)?'':param.customer_id}" var="customer_id"/>
								<sql:query var="invoice" dataSource="jdbc/rmc">
									select c.*,DATE_FORMAT(c.timestamp,'%d/%m/%Y') as realdate,cu.customer_name,
									(select sum(i.quantity) from invoice i,consolidate_invoice_item ci where i.id=ci.id and ci.consolidate_invoice_id=c.consolidate_invoice_id) as net_quantity,
									(select sum(i.net_amount) from invoice i,consolidate_invoice_item ci where i.id=ci.id and ci.consolidate_invoice_id=c.consolidate_invoice_id) as net_amount
									from consolidate_invoice c,customer cu
								    where c.customer_id=cu.customer_id
								    and consolidate_invoice_id like if(''=?,'%%',?)
								    and c.customer_id like if(''=?,'%%',?)
								    and c.type='invoice'
									order by consolidate_invoice_id desc
									limit 200;
									<sql:param value="${consolidate_invoice_id}"/>
									<sql:param value="${consolidate_invoice_id}"/>
									<sql:param value="${customer_id}"/>
									<sql:param value="${customer_id}"/>
								</sql:query>
                                <tbody>
                                <c:forEach var="invoice" items="${invoice.rows}">
									<tr class="${(invoice.invoice_status=='cancelled')?'text-danger':''}">
										<td class="text-center">${invoice.consolidate_invoice_id}</td>
										<td class="text-center">${invoice.customer_name} <br>${invoice.site_address}</td>
										<td class="text-center">${invoice.realdate}</td>
										<td class="text-center">${invoice.net_quantity}</td>
										<td class="text-center"><fmt:formatNumber value="${invoice.net_amount}" maxFractionDigits="2" groupingUsed="false"/></td>
										<td class="text-center">
											 <div class="btn-group dropdown">
	                                            <a href="javascript: void(0);" class="table-action-btn dropdown-toggle arrow-none btn btn-light btn-sm" data-toggle="dropdown" aria-expanded="false"><i class="mdi mdi-dots-horizontal"></i></a>
	                                            <div class="dropdown-menu dropdown-menu-right">
	                                                <span class="text-center text-success">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Invoice No : ${invoice.consolidate_invoice_id}</span>
	                                            	<a class="dropdown-item ${(invoice.invoice_status=='cancelled')?'hidden':''}" href="PrintConsolidateInvoice.jsp?consolidate_invoice_id=${invoice.consolidate_invoice_id}"><i class="fa fa-print mr-2 text-muted font-18 vertical-middle"></i>Print Invoice</a>
	                                                <a class="dropdown-item ${(invoice.invoice_status=='cancelled')?'hidden':''}" href="#cancel-modal" data-animation="blur" data-plugin="custommodal" onclick="cancelInvoice('${invoice.consolidate_invoice_id}')" data-overlaySpeed="100" data-overlayColor="#36404a"><i class="mdi mdi-window-close mr-2 text-muted font-18 vertical-middle"></i>Delete Consolidate Invoice</a>
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
                
               
				  
				<!-- Cancel consolidate Invoice -->
				<div id="cancel-modal" class="modal-demo col-xs-2">
		            <button type="button" class="close" onclick="Custombox.close();">
		                <span>&times;</span><span class="sr-only">Close</span>
		            </button>
		            <h4 class="custom-modal-title" style="color: white;background-color: #912815;">Are you sure want to Delete Consolidate invoice no <span class="consolidate_invoice_id"></span> ?</h4>
		            <div class="custom-modal-text">
		                <form class="form-horizontal" action="InvoiceController?action=cancelConsolidateInvoice" method="post">
		                	<input type="hidden" name="consolidate_invoice_id" class="consolidate_invoice_id">
		                    <div class="form-group account-btn text-center m-t-2">
		                        <div class="col-12">
		                            <button class="btn w-lg btn-rounded btn-custom waves-effect waves-light" type="submit"><span class="change_status text-uppercase">CANCEL INVOICE</span></button>
		                            <button class="btn w-lg btn-rounded btn-custom btn-danger waves-effect waves-light"  onclick="Custombox.close();" type="button">EXIT</button>
		                        </div>
		                    </div>
		                </form>
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
			function cancelInvoice(consolidate_invoice_id){
				$('.consolidate_invoice_id').val(consolidate_invoice_id);
				$('.consolidate_invoice_id').text(consolidate_invoice_id);
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
	    		var customer_id=$('#customer_id').val();
	    		var site_id=$('#site_id').val();
	    		var consolidate_invoice_id=$('#consolidate_invoice_id').val();
	    		window.location='ConsolidateInvoiceList.jsp?customer_id='+customer_id+'&site_id='+site_id+"&consolidate_invoice_id="+consolidate_invoice_id;
	    	});
	    });
    </script>
   
    </body>
</html>