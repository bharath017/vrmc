<!DOCTYPE html>
<%@ include file="Session.jsp" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<html>
<head>
        <meta charset="utf-8" />
        <title>Add Cube Test</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
        <meta content="A fully featured admin theme which can be used to build CRM, CMS, etc." name="description" />
        <meta content="Coderthemes" name="author" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />

        <!-- App favicon -->
        <link rel="shortcut icon" href="assets/images/favicon.ico">
		<link rel="stylesheet" href="picker/cs/bootstrap-datepicker3.min.css" />
		<link rel="stylesheet" href="picker/cs/bootstrap-timepicker.min.css" />
        <!-- App css -->
        <link href="assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/icons.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/style.css" rel="stylesheet" type="text/css" />
        <link rel="stylesheet" href="assets/css/select2.min.css" />
        <link rel="stylesheet" href="assets/css/render.css">
        <script src="assets/js/modernizr.min.js"></script>

    </head>

    <body>

        <!-- Navigation Bar-->
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
                                    <li class="breadcrumb-item"><a href="#">Cube Test</a></li>
                                    <li class="breadcrumb-item"><a href="#">Add Cube Test</a></li>
                                </ol>
                            </div>
                           
                             <c:choose>
                             	<c:when test="${param.action=='update'}">
                             		<h4 class="page-title">Update Cube Test</h4>
                             	</c:when>
                             	<c:otherwise>
                             		<h4 class="page-title">Add Cube Test</h4>
                             	</c:otherwise>
                             </c:choose>
                            	
                        </div>
                    </div>
                </div>
                <!-- end page title end breadcrumb -->
                 <div class="row">
                    <div class="col-sm-4">
                        <a href="CubeTestList.jsp" class="btn btn-custom waves-effect waves-light mb-4"  data-overlayColor="#36404a"><i class="mdi mdi-plus"></i>CubeTest List</a>
                    </div><!-- end col -->
                </div>
                <!-- end row -->
          
             	<c:choose>
             		<c:when test="${param.action=='update'}">
             		
             			<sql:query var="cube" dataSource="jdbc/rmc">
             				select * from cube_test where tst_id=?
             				<sql:param value="${param.tst_id}"/>
             			</sql:query>
             			
             			<c:forEach var="cube" items="${cube.rows}">
             				<c:set value="${cube}" var="cb"/>
             			</c:forEach>
             			<div class="row">
		                  <div class="col-sm-12" id="clicked">
		                   	<form class="" action="CubeTestController?action=UpdateCubeTest" method="post">
		                        <div class="card-box row col-sm-12">
		                           	<div class="col-sm-6">
		                           		<div class="form-group">
		                                    <label>Plant <span class="text-danger">*</span></label>
		                                    <sql:query var="plant" dataSource="jdbc/rmc">
		                                    	select * from plant where plant_id like if(?=0,'%%',?)
		                                    	<sql:param value="${bean.plant_id}"/>
		                                    	<sql:param value="${bean.plant_id}"/>
		                                    </sql:query>
		                                    <input type="hidden" name="tst_id" value="${cb.tst_id}" id="tst_id"/>
											<select id="plant_id"  name="plant_id"  required="required"  class="select2"  data-placeholder="Choose Plant">
												<c:forEach var="plant" items="${plant.rows}">
												<option value="${plant.plant_id}" ${(cb.plant_id==plant.plant_id)?'selected':''}>${plant.plant_name}</option>
												</c:forEach>
											</select>
		                                </div>
		                                
		                                
		                                <sql:query var="site" dataSource="jdbc/rmc">
		                                	select * from site_detail where customer_id=?
		                                	<sql:param value="${cb.customer_id}"/>
		                                </sql:query>
		                                
		                                <div class="form-group">
		                                    <label>Site Name<span class="text-danger">*</span></label>
											<select id="site_id"  name="site_id" required="required"   class="select2"  data-placeholder="Choose Site">
												<c:forEach items="${site.rows}" var="site">
													<option value="${site.site_id}" ${(site.site_id==cb.site_id)?'selected':''}>${site.site_address}</option>
												</c:forEach>
											</select>
		                                </div>
		                                
		                                <div class="form-group">
		                                    <label>Testing Days<span class="text-danger">*</span></label>
											<input type="number" class="form-control" value="${cb.testing_days}" name="testing_days" id="testing_days"/>
		                                </div>
		                                <div class="form-group">
		                                    <label>Cube Dimension<span class="text-danger">*</span></label>
											<select id="dimension"  name="dimension" required="required"   class="select2"  data-placeholder="Choose Site">
												<option value="100" ${(cb.dimension==100)?'selecte':''}>100</option>
												<option value="150" ${(cb.dimension==150)?'selecte':''}>150</option>
											</select>
		                                </div>
		                            </div>
		                            <div class="col-sm-6">
		                                 <div class="form-group">
		                                    <label>Customer <span class="text-danger">*</span></label>
		                                    <sql:query var="customer" dataSource="jdbc/rmc">
		                                    	select * from customer where customer_status='active' order by customer_name asc
		                                    </sql:query>
											<select id="customer_id"  name="customer_id"    class="select2"  data-placeholder="Choose Customer" required="required">
												<option value="">&nbsp;</option>
												<c:forEach var="customer" items="${customer.rows}">
												<option value="${customer.customer_id}" ${(customer.customer_id==cb.customer_id)?'selected':''}>${customer.customer_name}</option>
												</c:forEach>
											</select>
		                                </div>
		                                <div class="form-group">
		                                    <label>Grade<span class="text-danger">*</span></label>
											<select id="product_name"  name="product_name" required="required"  class="select2"  data-placeholder="Choose Site">
												<option value="${cb.product_name}">${cb.product_name}</option>
											</select>
		                                </div>
		                                <div class="form-group">
		                                    <label>Supply Date <span class="text-danger">*</span> </label>
		                                    <div>
		                                        <div class="input-group">
		                                            <input type="text" name="supply_date" class="form-control date-picker scheduling_date" value="${cb.supply_date}" placeholder="yyyy-mm-dd" id="id-date-picker-1" data-date-format="yyyy-mm-dd">
		                                            <div class="input-group-append">
		                                                <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
		                                            </div>
		                                        </div>
		                                    </div>
		                                </div>
		                                
		                                <!-- <div class="form-group">
		                                    <label>Supply Date<span class="text-danger">*</span></label>
											<select id="supply_date"  name="supply_date" required="required"  class="select2"  data-placeholder="Choose Supply Date">
												
											</select>
		                                </div> -->
		                                
		                             </div>
		                             
		                             <table class="table table-bordered" id="cube-table">
		                             	<thead class="text-center">
		                             		<tr style="background-color:#0cb5cc;color: white;">
			                             		<th>S/L No.</th>
			                             		<th></th>
												<th colspan="2">Cube 1</th>
												<th colspan="2">Cube 2</th>
												<th colspan="2">Cube 3</th>
												<th class="text-center"><span class="text-white" id="add-cube"><i class="fa fa-plus"></i></span></th>
											</tr>
											<tr style="background-color:#0cb5cc;color: white;">
			                             		<th></th>
			                             		<th>Cube ID</th>
												<th>Mass(KG)</th>
												<th>Max Load(KN)</th>
												<th>Mass(KG)</th>
												<th>Max Load(KN)</th>
												<th>Mass(KG)</th>
												<th>Max Load(KN)</th>
											</tr>
		                             	</thead>
										<tbody>
											<sql:query var="item" dataSource="jdbc/rmc">
												select * from cube_test_item where tst_id=?
												<sql:param value="${cb.tst_id}"/>
											</sql:query>
											<c:set value="0" var="count"/>
											<c:forEach items="${item.rows}" var="item">
											<tr>
												<td class="cube-no">${count}</td>
												<td>
													<input type="text" required="required"   value="${item.cube_id}" name="cube_id" class="form-control cube_id">
												</td>
												<td>
													<input type="hidden" name="tst_item_id" value="${item.tst_item_id}">
													<input type="number" required="required"  step="0.001" value="${item.mass1}" name="mass1" class="form-control calc">
												</td>
												<td>
													<input type="number" required="required"  step="0.001" value="${item.maxld1}" name="maxld1" class="form-control calc">
												</td>
												<td>
													<input type="number" required="required"  step="0.001" value="${item.mass2}" name="mass2" class="form-control calc">
												</td>
												<td>
													<input type="number" required="required"  step="0.001" name="maxld2" value="${item.maxld2}" class="form-control calc">
												</td>
												<td>
													<input type="number" required="required"  step="0.001" name="mass3" value="${item.mass3}" class="form-control calc">
												</td>
												<td>
													<input type="number" required="required"  step="0.001" name="maxld3" value="${item.maxld3}" class="form-control calc">
												</td>
											</tr>
											<c:set value="${count+1}" var="count"/>
											</c:forEach>
										</tbody>
										
		                             </table>
		                             <div class="col-sm-12 text-center">
		                               	<div class="form-group">
		                                    <div>
		                                        <button type="submit"  class="btn btn-custom waves-effect waves-light">
		                                            Submit
		                                        </button>
		                                        <button type="reset" class="btn btn-light waves-effect m-l-5">
		                                            Cancel
		                                        </button>
		                                    </div>
		                                </div>
		                              </div>
		                       	  </div>
		                       </form>
		                   </div>
		               </div>
             		</c:when>
             		<c:otherwise>
             			<div class="row">
		                  <div class="col-sm-12" id="clicked">
		                   	<form class="" action="CubeTestController?action=InsertCubeTest" method="post">
		                        <div class="card-box row col-sm-12">
		                           	<div class="col-sm-6">
		                           		<div class="form-group">
		                                    <label>Plant <span class="text-danger">*</span></label>
		                                    <sql:query var="plant" dataSource="jdbc/rmc">
		                                    	select * from plant where plant_id like if(?=0,'%%',?)
		                                    	<sql:param value="${bean.plant_id}"/>
		                                    	<sql:param value="${bean.plant_id}"/>
		                                    </sql:query>
		                                    <input type="hidden" name="scheduling_id" value="0" id="scheduling_id"/>
											<select id="plant_id"  name="plant_id"  required="required"  class="select2"  data-placeholder="Choose Plant">
												<c:forEach var="plant" items="${plant.rows}">
												<option value="${plant.plant_id}">${plant.plant_name}</option>
												</c:forEach>
											</select>
		                                </div>
		                                
		                                <div class="form-group">
		                                    <label>Site Name<span class="text-danger">*</span></label>
											<select id="site_id"  name="site_id" required="required"   class="select2"  data-placeholder="Choose Site">
												
											</select>
		                                </div>
		                                
		                                <div class="form-group">
		                                    <label>Testing Days<span class="text-danger">*</span></label>
											<input type="number" class="form-control" name="testing_days" id="testing_days"/>
		                                </div>
		                                <div class="form-group">
		                                    <label>Cube Dimension<span class="text-danger">*</span></label>
											<select id="dimension"  name="dimension" required="required"   class="select2"  data-placeholder="Choose Site">
												<option value="100">100</option>
												<option value="150">150</option>
											</select>
		                                </div>
		                            </div>
		                            <div class="col-sm-6">
		                                 <div class="form-group">
		                                    <label>Customer <span class="text-danger">*</span></label>
		                                    <sql:query var="customer" dataSource="jdbc/rmc">
		                                    	select * from customer where customer_status='active' order by customer_name asc
		                                    </sql:query>
											<select id="customer_id"  name="customer_id"    class="select2"  data-placeholder="Choose Customer" required="required">
												<option value="">&nbsp;</option>
												<c:forEach var="customer" items="${customer.rows}">
												<option value="${customer.customer_id}">${customer.customer_name}</option>
												</c:forEach>
											</select>
		                                </div>
		                                <div class="form-group">
		                                    <label>Grade<span class="text-danger">*</span></label>
											<select id="product_name"  name="product_name" required="required"  class="select2"  data-placeholder="Choose Site">
												
											</select>
		                                </div>
		                                <div class="form-group">
		                                    <label>Supply Date <span class="text-danger">*</span> </label>
		                                    <div>
		                                        <div class="input-group">
		                                            <input type="text" name="supply_date" class="form-control date-picker scheduling_date" placeholder="yyyy-mm-dd" id="id-date-picker-1" data-date-format="yyyy-mm-dd">
		                                            <div class="input-group-append">
		                                                <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
		                                            </div>
		                                        </div>
		                                    </div>
		                                </div>
		                                
		                                <!-- <div class="form-group">
		                                    <label>Supply Date<span class="text-danger">*</span></label>
											<select id="supply_date"  name="supply_date" required="required"  class="select2"  data-placeholder="Choose Supply Date">
												
											</select>
		                                </div> -->
		                                
		                             </div>
		                             
		                             <table class="table table-bordered" id="cube-table">
		                             	<thead class="text-center">
		                             		<tr style="background-color:#0cb5cc;color: white;">
			                             		<th>S/L No.</th>
			                             		<th></th>
												<th colspan="2">Cube 1</th>
												<th colspan="2">Cube 2</th>
												<th colspan="2">Cube 3</th>
												<th class="text-center"><span class="text-white" id="add-cube"><i class="fa fa-plus"></i></span></th>
											</tr>
											<tr style="background-color:#0cb5cc;color: white;">
			                             		<th></th>
			                             		<th>Cube ID</th>
												<th>Mass(KG)</th>
												<th>Max Load(KN)</th>
												<th>Mass(KG)</th>
												<th>Max Load(KN)</th>
												<th>Mass(KG)</th>
												<th>Max Load(KN)</th>
											</tr>
		                             	</thead>
										<tbody>
											<tr>
												<td class="cube-no">1</td>
												<td>
													<input type="text" required="required"    name="cube_id" class="form-control cube_id">
												</td>
												<td>
													<input type="number" required="required"  step="0.001" name="mass1" class="form-control calc">
												</td>
												<td>
													<input type="number" required="required"  step="0.001" name="maxld1" class="form-control calc">
												</td>
												<td>
													<input type="number" required="required"  step="0.001" name="mass2" class="form-control calc">
												</td>
												<td>
													<input type="number" required="required"  step="0.001" name="maxld2" class="form-control calc">
												</td>
												<td>
													<input type="number" required="required"  step="0.001" name="mass3" class="form-control calc">
												</td>
												<td>
													<input type="number" required="required"  step="0.001" name="maxld3" class="form-control calc">
												</td>
											</tr>
										</tbody>
										
		                             </table>
		                             <div class="col-sm-12 text-center">
		                               	<div class="form-group">
		                                    <div>
		                                        <button type="submit"  class="btn btn-custom waves-effect waves-light">
		                                            Submit
		                                        </button>
		                                        <button type="reset" class="btn btn-light waves-effect m-l-5">
		                                            Cancel
		                                        </button>
		                                    </div>
		                                </div>
		                              </div>
		                       	  </div>
		                       </form>
		                   </div>
		               </div>
             		</c:otherwise>
             	</c:choose>
                	
                <!-- end row -->

            </div> <!-- end container -->
        </div>
        <!-- Footer -->
       <%@ include file="footer.jsp" %>
        <!-- End Footer -->


        <!-- jQuery  -->
        <script src="assets/js/jquery.min.js"></script>
        <script src="assets/js/popper.min.js"></script>
        <script src="assets/js/bootstrap.min.js"></script>
        <script src="assets/js/waves.js"></script>
        <script src="assets/js/jquery.slimscroll.js"></script>

        <!-- Parsley js -->
        <script type="text/javascript" src="plugins/parsleyjs/parsley.min.js"></script>

        <!-- App js -->
        <script src="assets/js/jquery.core.js"></script>
        <script src="assets/js/jquery.app.js"></script>
        <script src="assets/js/select2.min.js"></script>
		<script src="picker/js/bootstrap-datepicker.min.js"></script>
		<script src="assets/js/bootstrap-timepicker.min.js"></script>
		<script src="picker/js/moment.min.js"></script>
		<script type="text/javascript" src="js/AddPurchaseOrder.js"></script>
		<script type="text/javascript" src="js/AddCubeTest.js"></script>
		<script src="assets/js/ace.min.js"></script>
		
		
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
				
				
				$('#timepicker2').timepicker({
					minuteStep: 1,
					showSeconds: true,
					showMeridian: false,
					disableFocus: true,
					icons: {
						up: 'fa fa-chevron-up',
						down: 'fa fa-chevron-down'
					}
				}).on('focus', function() {
					$('#timepicker2').timepicker('showWidget');
				}).next().on(ace.click_event, function(){
					$(this).prev().focus();
				});
			});
		</script>
		
		<!-- <script type="text/javascript">
			function calculateCubeTest(e){
				var dimension=$('#dimension').val();
				$('.dim').text(dimension);
				dimension=parseInt(dimension);
				var mass=$(e).closest("tr").find('input.mass').val();
				var load=$(e).closest("tr").find('input.load').val();
				mass=(mass==null || mass==undefined || mass=='')?0.0:parseFloat(mass);
				load=(load==null || load==undefined || load=='')?0.0:parseFloat(load);
				
				if(dimension==150){
					$(e).closest("tr").find('.dens').html((mass/0.003375).toFixed(0));
					$(e).closest("tr").find('.ste').html((load/22.5).toFixed(2));
				}else{
					$(e).closest("tr").find('.dens').html((mass/0.001).toFixed(0));
					$(e).closest("tr").find('.ste').html((load/10).toFixed(2));
				}
				
				var sum=0;
				$('.ste').each(function(i, obj) {
				    var val=$(obj).html();
				    val=(val==null || val.trim()=='')?0.0:parseFloat(val);
				    sum=sum+val;
				});
				var avg=(sum/3).toFixed(2);
				$('#avg').text(avg);
			}
		</script> -->
		
		<script type="text/javascript">
			$(document).ready(function(){
				$('#site_id').on('change',function(){
					var site_id=$('#site_id').val();
					var plant_id=$('#plant_id').val();
					$.ajax({
						type:'post',
						url:'CustomerController?action=GetSiteName&site_id='+site_id,
						headers:{
							Accept:"application/json;charset=utf-8",
							"Content-Type":"application/json;charset=utf-8"
						},
						success:function(result){
							$('#show_site_name').text(result.site_name);
							$('#show_site_address').text(result.site_address);
							$.ajax({
								type:'post',
								url:'PurchaseOrderController?action=GetGradeList&site_id='+site_id+'&plant_id='+plant_id,
								headers:{
									Accept:"application/json;charset=utf-8",
									"Content-Type":"application/json;charset=utf-8"
								},
								success:function(res){
									$('#select2-product_name-container').html('Choose Grade');
									$('#product_name').html('');
					        		$('#product_name').html('<option value="">Choose Grade</option>');
					        		$.each(res, function(index, value) {
					        			   $('#product_name').append("<option value='"+ value.product_name+ "'>" + value.product_name + "</option>");
					        		});
								}
							});
						}
					})
				});
			});
		</script>
		<script type="text/javascript">
		$(window).on('load', function() {
			//calculateCubeTest(this);
		});
		</script>
		<script type="text/javascript">
			$(document).ready(function(){
				$('#dimension').on("change",function(){
					var dimension=$('#dimension').val();
					if(dimension==100){
						$('.dim').text(100);
					}else{
						$('.dim').text(150);
					}
				});
			});
		</script>
		
		<!-- <script type="text/javascript">
			$(document).ready(function(){
				$('#product_name').on('change',function(){
					var product_name=$('#product_name').val();
					var customer_id=$('#customer_id').val();
					var site_id=$('#site_id').val();
					$.ajax({
						type:'POST',
						url:'CubeTestController?action=GetSupplyDetails&product_name='+product_name+'&customer_id='+customer_id+'&site_id='+site_id,
						headers:{
							Accept:"application/json;charset=utf-8",
							"Content-type":"application/json;charset=utf-8"
						},
						success:function(res){
							$('#supply_date').html("");
							alert(res[0]);
							for(var v=0;v<res.length;v++){
								$('#supply_date').append('<option value="'+res+'">'+res+'</option>');
							}
							
							var dateChanger=function(dateString){
								var parts=dateString.split("-");
								return new Date(parts[0],parts[1],parts[2]);
							}
						}
					});
				});
			});
			
			
		</script> -->
    </body>
</html>