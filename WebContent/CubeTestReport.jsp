<%@ include file="Session.jsp" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<!DOCTYPE html>
<html>
<head>
        <meta charset="utf-8" />
        <title>Cube Test Report</title>
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
                                    <li class="breadcrumb-item"><a href="#">QC Department</a></li>
                                    <li class="breadcrumb-item active">Cube Test</li>
                                    <li class="breadcrumb-item active">Cube Test Report</li>
                                </ol>
                            </div>
                            <h4 class="page-title">Cube Test Report</h4>
                        </div>
                    </div>
                </div>
                <!-- end page title end breadcrumb -->
               
                <!-- end row -->
				<div class="row">
				<div class="col-sm-3"></div>
					<div class="col-sm-6">
                        <div class="form-group form-focus">
                            <label class="control-label">Testing Days</label>
                                <input class="form-control" placeholder="Enter Testing Days" id="testing_days" type="text" name="testing_days">
                        </div>
                    
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
                    
                        <div class="form-group form-focus select-focus">
                            <label class="control-label">Site : </label>
                            <select class="form-control select2 floating"   id="site_id">
                                <option value="">All Site</option>
                            </select>
                        </div>
                    
                        <div class="form-group form-focus select-focus">
                            <label class="control-label">Grade</label>
                            <sql:query var="product" dataSource="jdbc/rmc">
                            	select * from product
                            </sql:query>
                            <select class="select2 form-control floating" id="product_name">
                                <option value="">All Product</option>
                                <c:forEach items="${product.rows}" var="product">
                                	<option value="${product.product_name}">${product.product_name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        
                         <div class="text-center m-t-20">
                               <button type="submit" id="search" class="btn btn-primary btn-lg m-r-10 save-button">Generate Report</button>
                               <a class="btn btn-info btn-lg">Clear Report</a>
                          </div>
                        
                </div>
                </div>
                <br>
                <c:if test="${param.action=='generateReport'}">
                <div class="row">
                    <div class="col-sm-12">
               			<button class="btn btn-warning btn-sm" onclick="generate_excel();">Excel</button>
               			<button class="btn btn-danger btn-sm" onclick="print();">Print</button>
               		</div>
               		<div class="col-sm-12 printme" id="printme">
                            <h4 style="color: green;">${res}</h4>
                            <c:remove var="res"/>
                            <table  class="table table-bordered" id="example-2" cellspacing="0" width="100%">
                                <thead>
	                                <tr>
										<th class="center">
											Test Id
										</th>
										<th class="text-center">Customer</th>
										<th class="text-center">Site Name</th>
										<th class="text-center">Grade</th>
										<th class="text-center">Supply Date</th>
										<th class="text-center">Testing Days</th>
										<th class="text-center">Dimension</th>
										<th class="text-center">Plant</th>
										<th>
											<table class="table">
												<tr>
													<td>Cube Id</td>
													<td>Cube Weight</td>
													<td>Density(Kg/CUM)</td>
													<td>Max Load(KN)</td>
													<td>Comp. Strength(N/MM2)</td>
													<td>Avg Strength(N/MM2)</td>
												</tr>
											</table>
										</th>
									</tr>
                                </thead>
                                <c:set value="${(empty param.product_name)?'':param.product_name}" var="product_name"/>
                                <c:set value="${(empty param.customer_id)?'':param.customer_id}" var="customer_id"/>
                                <c:set value="${(empty param.site_id)?'':param.site_id}" var="site_id"/>
                                <c:set value="${(empty param.testing_days)?'':param.testing_days}" var="testing_days"/>
								<sql:query var="cube" dataSource="jdbc/rmc">
									select cu.*,c.customer_name,s.site_name,pl.plant_name
									from cube_test cu LEFT JOIN(customer c,site_detail s,plant pl)
									ON cu.customer_id=c.customer_id
									and cu.site_id=s.site_id
									and cu.plant_id=pl.plant_id
									where cu.customer_id like if(''=?,'%%',?)
									and cu.site_id like if(''=?,'%%',?)
									and cu.product_name like if(''=?,'%%',?)
									and cu.testing_days like if(''=?,'%%',?)
									and cu.plant_id like if(?=0,'%%',?)
									order by tst_id desc
									<sql:param value="${customer_id}"/>
									<sql:param value="${customer_id}"/>
									<sql:param value="${site_id}"/>
									<sql:param value="${site_id}"/>
									<sql:param value="${product_name}"/>
									<sql:param value="${product_name}"/>
									<sql:param value="${testing_days}"/>
									<sql:param value="${testing_days}"/>
									<sql:param value="${bean.plant_id}"/>
									<sql:param value="${bean.plant_id}"/>
								</sql:query>
                                <tbody>
                                <c:forEach var="cube" items="${cube.rows}">
									<tr class="${(cube.cube_status=='cancelled')?'text-danger':''}">
										<td class="text-center">${cube.tst_id}</td>
										<td class="text-center">${cube.customer_name}</td>
										<td class="text-center">${cube.site_name}</td>
										<td class="text-center">${cube.product_name}</td>
										<td class="text-center">${cube.supply_date}</td>
										<td class="text-center">${cube.testing_days}</td>
										<td class="text-center">${cube.dimension}</td>
										<td class="text-center">${cube.plant_name}</td>
										<td>
										 <sql:query var="item" dataSource="jdbc/rmc">
											select c.*,cu.dimension, round(((maxld1/22.5)+(maxld2/22.5)+(maxld3/22.5))/3,2) as avg,
											round(case when (cu.dimension = 150) THEN (c.mass1/0.003375) ELSE (c.mass1/0.001)  END,0) as m_one,
											round(case when (cu.dimension = 150) THEN (c.mass2/0.003375) ELSE (c.mass2/0.001)  END,0) as m_two,
											round(case when (cu.dimension = 150) THEN (c.mass3/0.003375) ELSE (c.mass3/0.001)  END,0) as m_three,
											truncate(case when (cu.dimension = 150) THEN (c.maxld1/22.5) ELSE (c.maxld1/10)  END,2) as a1,
											truncate(case when (cu.dimension = 150) THEN (c.maxld2/22.5) ELSE (c.maxld2/10)  END,2) as a2,
											truncate(case when (cu.dimension = 150) THEN (c.maxld3/22.5) ELSE (c.maxld3/10)  END,2) as a3
											from cube_test_item c,cube_test cu where c.tst_id=cu.tst_id and c. tst_id=?
											<sql:param value="${cube.tst_id}"/>
										</sql:query>
										<table class="table">
										<c:forEach var="items" items="${item.rows}">
											<tr>
												<td rowspan="3" class="text-center vertical-middle"><br><br>${items.cube_id}</td>
												<td>${items.mass1}</td>
												<td>${items.m_one}</td>
												<td>${items.maxld1}</td>
												<td>${items.a1}</td>
												<td rowspan="3" class="text-center"><br><br>${items.avg}</td>
											
											</tr>
											<tr>
											<td>${items.mass2}</td>
											<td>${items.m_two}</td>
											<td>${items.maxld2}</td>
											<td>${items.a2}</td>
											</tr>
											<tr>
											<td>${items.mass3}</td>
											<td>${items.m_three}</td>
											<td>${items.maxld3}</td>
											<td>${items.a3}</td>
											</tr>
										
										</c:forEach>
										</table>
										
										</td>
									</tr>
									</c:forEach>
                                </tbody>
                            </table>
                    </div>
                </div>
                </c:if>
                <!-- end row -->
                
                <!-- MODAL FOR PLANT DELETE START  -->
				<div id="dele-model" class="modal-demo col-xs-2">
		            <button type="button" class="close" onclick="Custombox.close();">
		                <span>&times;</span><span class="sr-only">Close</span>
		            </button>
		            <h4 class="custom-modal-title" style="color: white;background-color: #9b3329;">Are you sure want to Cancel Test Id : <span class="tst_id"></span>?</h4>
		            <div class="custom-modal-text">
		                <form class="form-horizontal" action="CubeTestController?action=CancelTest" method="post">
		                	<input type="hidden" name="tst_id" id="tst_id" class="tst_id"/>
		                    <div class="form-group account-btn text-center m-t-2">
		                        <div class="col-12">
		                            <button class="btn w-lg btn-rounded btn-custom waves-effect waves-light" type="submit"><span class="change_status text-uppercase">Cancel Test</span></button>
		                            <button class="btn w-lg btn-rounded btn-custom btn-danger waves-effect waves-light"  onclick="Custombox.close();" type="button">Exit</button>
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
			function deleteCubeTest(tst_id){
				$('.tst_id').val(tst_id);
				$('.tst_id').text(tst_id);
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
	    		var testing_days=$('#testing_days').val();
	    		var product_name=$('#product_name').val();
	    		window.location='CubeTestReport.jsp?action=generateReport&customer_id='+customer_id+'&site_id='+site_id+"&testing_days="+testing_days+"&product_name="+product_name;
	    	});
	    });
    </script>
    
        <script type="text/javascript">
	    function generate_excel() {
	      var table= document.getElementById("example-2");
	      var html = table.outerHTML;
	      window.open('data:application/vnd.ms-excel;base64,' + base64_encode(html));
	    }
	    function base64_encode (data) {
	      // http://kevin.vanzonneveld.net
	      // +   original by: Tyler Akins (http://rumkin.com)
	      // +   improved by: Bayron Guevara
	      // +   improved by: Thunder.m
	      // +   improved by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
	      // +   bugfixed by: Pellentesque Malesuada
	      // +   improved by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
	      // +   improved by: Rafal Kukawski (http://kukawski.pl)
	      // *     example 1: base64_encode('Kevin van Zonneveld');
	      // *     returns 1: 'S2V2aW4gdmFuIFpvbm5ldmVsZA=='
	      // mozilla has this native
	      // - but breaks in 2.0.0.12!
	      //if (typeof this.window['btoa'] == 'function') {
	      //    return btoa(data);
	      //}
	      var b64 = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
	      var o1, o2, o3, h1, h2, h3, h4, bits, i = 0,
	        ac = 0,
	        enc = "",
	        tmp_arr = [];
	
	      if (!data) {
	        return data;
	      }
	
	      do { // pack three octets into four hexets
	        o1 = data.charCodeAt(i++);
	        o2 = data.charCodeAt(i++);
	        o3 = data.charCodeAt(i++);
	
	        bits = o1 << 16 | o2 << 8 | o3;
	
	        h1 = bits >> 18 & 0x3f;
	        h2 = bits >> 12 & 0x3f;
	        h3 = bits >> 6 & 0x3f;
	        h4 = bits & 0x3f;
	
	        // use hexets to index into b64, and append result to encoded string
	        tmp_arr[ac++] = b64.charAt(h1) + b64.charAt(h2) + b64.charAt(h3) + b64.charAt(h4);
	      } while (i < data.length);
	
	      enc = tmp_arr.join('');
	
	      var r = data.length % 3;
	
	      return (r ? enc.slice(0, r - 3) : enc) + '==='.slice(r || 3);
	
	    }
    </script>
    <script type="text/javascript">
    function print() {
        var frame = document.getElementsByClassName('printme').item(0);
        var data = frame.innerHTML;
        var win = window.open('', '', 'height=500,width=900');
        win.document.write('<style>@page{size:landscape;}@media print{*{font-size:12px;}}</style><html><head><title></title>');
        win.document.write('</head><body >');
        win.document.write(data);
        win.document.write('</body></html>');
        win.print();
        win.close();
        return true;
    }
    
    function GetURLParameter(sParam)
    {
        var sPageURL = window.location.search.substring(1);
        var sURLVariables = sPageURL.split('&');
        for (var i = 0; i < sURLVariables.length; i++) 
        {
            var sParameterName = sURLVariables[i].split('=');
            if (sParameterName[0] == sParam) 
            {
                return sParameterName[1];
            }
        }
    }
    </script>
    
    </body>
</html>