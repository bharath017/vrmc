<%@ include file="Session.jsp" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<!DOCTYPE html>
<html>
<head>
        <meta charset="utf-8" />
        <title>Receipe List</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
        <meta content="A fully featured admin theme which can be used to build CRM, CMS, etc." name="description" />
        <meta content="Coderthemes" name="author" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />

        <!-- App favicon -->
        <link rel="shortcut icon" href="../assets/images/favicon.ico">

        <!-- DataTables -->
        <link href="../plugins/datatables/dataTables.bootstrap4.min.css" rel="stylesheet" type="text/css" />
        <link href="../plugins/datatables/buttons.bootstrap4.min.css" rel="stylesheet" type="text/css" />
        <!-- Responsive datatable examples -->
        <link href="../plugins/datatables/responsive.bootstrap4.min.css" rel="stylesheet" type="text/css" />

        <!-- Multi Item Selection examples -->
        <link href="../plugins/datatables/select.bootstrap4.min.css" rel="stylesheet" type="text/css" />
		
		<link rel="stylesheet" href="../picker/cs/bootstrap-datepicker3.min.css" />
		<link rel="stylesheet" href="../picker/cs/bootstrap-timepicker.min.css" />
		
        <!-- App css -->
        <link href="../assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="../assets/css/icons.css" rel="stylesheet" type="text/css" />
        <link href="../assets/css2/style.css" rel="stylesheet" type="text/css" />
		  <!-- Custom box css -->
        <link href="../plugins/custombox/css/custombox.min.css" rel="stylesheet">
        <link rel="stylesheet" href="../assets/css/select2.min.css" />
		<link rel="stylesheet" href="../assets/css/render.css">
        <script src="../assets/js/modernizr.min.js"></script>
        <style type="text/css">
        	.hidden{
        		display: none;
        	}
        </style>
        
    </head>

    <body>

        <!-- Navigation Bar-->
        <!-- PUT HEADER.JSP HERE -->
       <%@ include file="../header.jsp" %>
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
                                    <li class="breadcrumb-item active">Receipe</li>
                                    <li class="breadcrumb-item active">Receipe List</li>
                                </ol>
                            </div>
                            <h4 class="page-title">Invoice List</h4>
                        </div>
                    </div>
                </div>
                <!-- end page title end breadcrumb -->

                <div class="row">
                    <div class="col-sm-4">
                        <a href="AddReceipe.jsp" class="btn btn-custom waves-effect waves-light mb-4"  data-overlayColor="#36404a"><i class="mdi mdi-plus"></i> Add Receipe</a>
                    </div><!-- end col -->
                </div>
                <!-- end row -->
				<div class="row filter-row">
					<div class="col-sm-2 col-xs-6">
                        <div class="form-group form-focus">
                            <label class="control-label">Receipe Code</label>
                                <input class="form-control" placeholder="Enter Receipe Code" id="receipe_code" type="text" name="receipe_code">
                        </div>
                    </div>
                    <div class="col-sm-2 col-xs-6">
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
                        <div class="form-group form-focus select-focus">
                            <label class="control-label">Site : </label>
                            <select class="form-control select2 floating"   id="site_id">
                                <option value="">All Site</option>
                            </select>
                        </div>
                    </div>
                    
                    <div class="col-sm-2 col-xs-6">
                        <div class="form-group form-focus select-focus">
                            <label class="control-label">Grade</label>
                            <sql:query var="product" dataSource="jdbc/rmc">
                            	select * from product
                            </sql:query>
                            <select class="select2 form-control floating" id="product_id">
                                <option value="">All Product</option>
                                <c:forEach items="${product.rows}" var="product">
                                	<option value="${product.product_id}">${product.product_name}</option>
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
											S/L No
										</th>
										<th class="text-center">Receipe Code</th>
										<th class="text-center">Customer</th>
										<th class="text-center">Site Name</th>
										<th class="text-center">Grade</th>
										<th class="text-center">Plant</th>
										<th class="text-center">Option</th>
									</tr>
                                </thead>
                                <c:set value="${(empty param.product_id)?'':param.product_id}" var="product_id"/>
                                <c:set value="${(empty param.customer_id)?'':param.customer_id}" var="customer_id"/>
                                <c:set value="${(empty param.site_id)?'':param.site_id}" var="site_id"/>
                                <c:set value="${(empty param.receipe_code)?'':param.receipe_code}" var="receipe_code"/>
								<sql:query var="rec" dataSource="jdbc/rmc">
									select r.*,c.customer_name,p.product_name,s.site_name,pl.plant_name
									from test_receipe r LEFT JOIN(product p,test_site_detail s,test_customer c,plant pl)
									ON r.customer_id=c.customer_id
									and r.site_id=s.site_id
									and r.product_id=p.product_id
									and r.plant_id=pl.plant_id
									where r.recipe_code like if(''=?,'%%',?)
									and r.customer_id like if(''=?,'%%',?)
									and r.site_id like if(''=?,'%%',?)
									and r.product_id like if(''=?,'%%',?)
									and r.plant_id like if(0=?,'%%',?)
									order by receipe_id desc
									limit 500
									<sql:param value="${receipe_code}"/>
									<sql:param value="${receipe_code}"/>
									<sql:param value="${customer_id}"/>
									<sql:param value="${customer_id}"/>
									<sql:param value="${site_id}"/>
									<sql:param value="${site_id}"/>
									<sql:param value="${product_id}"/>
									<sql:param value="${product_id}"/>
									<sql:param value="${bean.plant_id}"/>
									<sql:param value="${bean.plant_id}"/>
								</sql:query>
                                <tbody>
                                <c:set value="0" var="sum"/>
                                <c:forEach var="rec" items="${rec.rows}">
                                	<c:set value="${sum+1}" var="sum"/>
									<tr>
										<td class="text-center">${sum}</td>
										<td class="text-center">${rec.recipe_code}</td>
										<td class="text-center">${rec.customer_name}</td>
										<td class="text-center">${rec.site_name}</td>
										<td class="text-center">${rec.product_name}</td>
										<td class="text-center">${rec.plant_name}</td>
										<td class="text-center">
											 <div class="btn-group dropdown">
	                                            <a href="javascript: void(0);" class="table-action-btn dropdown-toggle arrow-none btn btn-light btn-sm" data-toggle="dropdown" aria-expanded="false"><i class="mdi mdi-dots-horizontal"></i></a>
	                                            <div class="dropdown-menu dropdown-menu-right">
	                                           	    <a class="dropdown-item" href="#delete-model" data-animation="blur" data-plugin="custommodal" onclick="getSingleReceipeView('${rec.receipe_id}');" data-overlaySpeed="100" data-overlayColor="#36404a"><i class="fa fa-eye mr-2 text-muted font-18 vertical-middle"></i>Show Design</a>
	                                           	    <a class="dropdown-item" href="AddReceipe.jsp?action=update&receipe_id=${rec.receipe_id}"><i class="fa fa-edit mr-2 text-muted font-18 vertical-middle"></i>Edit Receipe</a>
	                                                <a class="dropdown-item" href="#dele-model" data-animation="blur" data-plugin="custommodal" onclick="deleteReceipe('${rec.receipe_id}')" data-overlaySpeed="100" data-overlayColor="#36404a"><i class="mdi mdi-window-close mr-2 text-muted font-18 vertical-middle"></i>Delete Receipe</a>
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
				<div id="delete-model" class="modal-demo col-xs-2">
		            <button type="button" class="close" onclick="Custombox.close();">
		                <span>&times;</span><span class="sr-only">Close</span>
		            </button>
		            <h4 class="custom-modal-title text-uppercase" style="color: white;background-color: #28afa0;"><b>Mix Design For Grade : <span id="grade_name"></span></b></h4>
		            <div class="custom-modal-text">
						<table class="table table-bordered table-hover table-light table-condensed">
					  		<thead>
					  			<tr style="background-color: #89993e;color: white;">
					  				<th colspan="2">Customer Name : </th>
					  				<th colspan="2" id="customer_name"></th>
					  			</tr>
					  			<tr style="background-color: #89993e;color: white;">
					  				<th colspan="2">Site Name : </th>
					  				<th colspan="2" id="site_name"></th>
					  			</tr>
					  			<tr style="background-color: #04dbd7;color: white;">
					  				<th>S/L No</th>
					  				<th>Aggregate</th>
					  				<th>Quantity</th>
					  				<th>Unit</th>
					  			</tr>
					  		</thead>
					  		<tbody>
					  			<tr>
					  				<td>1</td>
					  				<td id="aggr1_name"></td>
					  				<td id="aggr1_val"></td>
					  				<td>Kg.</td>
					  			</tr>
					  			<tr>
					  				<td>2</td>
					  				<td id="aggr2_name"></td>
					  				<td id="aggr2_val"></td>
					  				<td>Kg.</td>
					  			</tr>
					  			<tr>
					  				<td>3</td>
					  				<td id="aggr3_name"></td>
					  				<td id="aggr3_val"></td>
					  				<td>Kg.</td>
					  			</tr>
					  			<tr>
					  				<td>4</td>
					  				<td id="aggr4_name"></td>
					  				<td id="aggr4_val"></td>
					  				<td>Kg.</td>
					  			</tr>
					  			<tr>
					  				<td>5</td>
					  				<td id="aggr5_name"></td>
					  				<td id="aggr5_val"></td>
					  				<td>Kg.</td>
					  			</tr>
					  			<tr>
					  				<td>6</td>
					  				<td id="aggr6_name"></td>
					  				<td id="aggr6_val"></td>
					  				<td>Kg.</td>
					  			</tr>
					  			<tr>
					  				<td>7</td>
					  				<td id="aggr7_name"></td>
					  				<td id="aggr7_val"></td>
					  				<td>Kg.</td>
					  			</tr>
					  			<tr>
					  				<td>8</td>
					  				<td id="aggr8_name"></td>
					  				<td id="aggr8_val"></td>
					  				<td>Kg.</td>
					  			</tr>
					  			<tr>
					  				<td>9</td>
					  				<td id="aggr9_name"></td>
					  				<td id="aggr9_val"></td>
					  				<td>Kg.</td>
					  			</tr>
					  			<tr>
					  				<td>10</td>
					  				<td id="aggr10_name"></td>
					  				<td id="aggr10_val"></td>
					  				<td>Kg.</td>
					  			</tr>
					  		</tbody>
					   </table>
		            </div>
		        </div>
                <!--  PLANT DELETE MODAL END  -->
                
                
                <!-- MODAL FOR PLANT DELETE START  -->
				<div id="dele-model" class="modal-demo col-xs-2">
		            <button type="button" class="close" onclick="Custombox.close();">
		                <span>&times;</span><span class="sr-only">Close</span>
		            </button>
		            <h4 class="custom-modal-title" style="color: white;background-color: #9b3329;">Are you sure want to delete?</h4>
		            <div class="custom-modal-text">
		                <form class="form-horizontal" action="../MixDesignControllerTest?action=DeleteReceipe" method="post">
		                	<input type="hidden" name="receipe_id" id="receipe_id"/>
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

            </div> <!-- end container -->
        </div>
        <!-- end wrapper -->


        <!-- Footer -->
        <!-- PUT FOOTER.JSP HERE -->
        <%@ include file="../footer.jsp" %>
        <!-- End Footer -->


        <!-- jQuery  -->
        <script src="../assets/js/jquery.min.js"></script>
        <script src="../assets/js/popper.min.js"></script>
        <script src="../assets/js/bootstrap.min.js"></script>
        <script src="../assets/js/waves.js"></script>
        <script src="../assets/js/jquery.slimscroll.js"></script>

        <!-- Required datatable js -->
        <script src="../plugins/datatables/jquery.dataTables.min.js"></script>
        <script src="../plugins/datatables/dataTables.bootstrap4.min.js"></script>
        <!-- Buttons examples -->
        <script src="../plugins/datatables/dataTables.buttons.min.js"></script>
        <script src="../plugins/datatables/buttons.bootstrap4.min.js"></script>
        <script src="../plugins/datatables/pdfmake.min.js"></script>
        <script src="../plugins/datatables/vfs_fonts.js"></script>
        <script src="../plugins/datatables/buttons.html5.min.js"></script>
        <script src="../plugins/datatables/buttons.print.min.js"></script>
        <script src="../assets/js/select2.min.js"></script>
		<script src="picker/js/bootstrap-datepicker.min.js"></script>
		<script src="../assets/js/bootstrap-timepicker.min.js"></script>
		<script src="picker/js/moment.min.js"></script>
        <!-- Key Tables -->
        <script src="../plugins/datatables/dataTables.keyTable.min.js"></script>

        <!-- Responsive examples -->
        <script src="../plugins/datatables/dataTables.responsive.min.js"></script>
        <script src="../plugins/datatables/responsive.bootstrap4.min.js"></script>

        <!-- Selection table -->
        <script src="../plugins/datatables/dataTables.select.min.js"></script>
        <!-- App js -->
        <script src="../assets/js/jquery.core.js"></script>
        <script src="../assets/js/jquery.app.js"></script>
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
        <script src="../plugins/custombox/js/custombox.min.js"></script>
        <script src="../plugins/custombox/js/legacy.min.js"></script>
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
				$('#customer_id').on('change',function(){
					var customer_id=$('#customer_id').val();
					$.ajax({
						type:'POST',
						url:'../CustomerControllerTest?action=getCustomerSiteDetails&customer_id='+customer_id,
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
	    		var receipe_code=$('#receipe_code').val();
	    		var product_id=$('#product_id').val();
	    		window.location='ReceipeList.jsp?customer_id='+customer_id+'&site_id='+site_id+"&receipe_code="+receipe_code+"&product_id="+product_id;
	    	});
	    });
    </script>
    <script type="text/javascript">
    	function getSingleReceipeView(receipe_id){
    		$.ajax({
    			type:'POST',
    			url:'../MixDesignControllerTest?action=GetSingleReceipe&receipe_id='+receipe_id,
    			headers:{
    				Accept:"application/json;charset=utf-8",
    				"Content-Type":"application/json;charset=utf-8"
    			},
    			success:function(res){
    				$('#customer_name').text(res.customer_name);
    				$('#site_name').text(res.site_name);
    				$('#grade_name').text(res.product_name);
    				$('#aggr1_name').text(res.aggregate1_name);
    				$('#aggr1_val').text(res.aggregate1_value);	
    				$('#aggr2_name').text(res.aggregate2_name);
    				$('#aggr2_val').text(res.aggregate2_value);	
    				$('#aggr3_name').text(res.aggregate3_name);
    				$('#aggr3_val').text(res.aggregate3_value);	
    				$('#aggr4_name').text(res.aggregate4_name);
    				$('#aggr4_val').text(res.aggregate4_value);	
    				$('#aggr5_name').text(res.aggregate5_name);
    				$('#aggr5_val').text(res.aggregate5_value);	
    				$('#aggr6_name').text(res.aggregate6_name);
    				$('#aggr6_val').text(res.aggregate6_value);	
    				$('#aggr7_name').text(res.aggregate7_name);
    				$('#aggr7_val').text(res.aggregate7_value);	
    				$('#aggr8_name').text(res.aggregate8_name);
    				$('#aggr8_val').text(res.aggregate8_value);	
    				$('#aggr9_name').text(res.aggregate9_name);
    				$('#aggr9_val').text(res.aggregate9_value);	
    				$('#aggr10_name').text(res.aggregate10_name);
    				$('#aggr10_val').text(res.aggregate10_value);	
    			}
    		});
    	}
    </script>
    
    <script type="text/javascript">
    	function deleteReceipe(receipe_id){
    		$('#receipe_id').val(receipe_id);
    	}
    
    </script>
    </body>
</html>