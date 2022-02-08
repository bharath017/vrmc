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
        <link rel="shortcut icon" href="../assets/images/favicon.ico">
		<link rel="stylesheet" href="../picker/cs/bootstrap-datepicker3.min.css" />
		<link rel="stylesheet" href="../picker/cs/bootstrap-timepicker.min.css" />
        <!-- App css -->
        <link href="../assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="../assets/css/icons.css" rel="stylesheet" type="text/css" />
        <link href="../assets/css2/style.css" rel="stylesheet" type="text/css" />
        <link rel="stylesheet" href="../assets/css/select2.min.css" />
        <link rel="stylesheet" href="../assets/css/render.css">
        <script src="../assets/js/modernizr.min.js"></script>

    </head>

    <body>

        <!-- Navigation Bar-->
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
             				select c.*,cu.customer_name,DATE_FORMAT(c.supply_date,'%d/%m/%Y') as realdate,s.site_name,DATE_FORMAT(supply_date+interval c.testing_days day,'%d/%m/%Y')  as  testing,
							round(((maxld1/22.5)+(maxld2/22.5)+(maxld3/22.5))/3,2) as avg,
							round(case when (c.dimension = 150) THEN (c.mass1/0.003375) ELSE (c.mass1/0.001)  END,0) as m_one,
							round(case when (c.dimension = 150) THEN (c.mass2/0.003375) ELSE (c.mass2/0.001)  END,0) as m_two,
							round(case when (c.dimension = 150) THEN (c.mass3/0.003375) ELSE (c.mass3/0.001)  END,0) as m_three,
							(case when (c.dimension = 150) THEN (c.maxld1/22.5) ELSE (c.maxld1/10)  END) as a1,
							(case when (c.dimension = 150) THEN (c.maxld2/22.5) ELSE (c.maxld2/10)  END) as a2,
							(case when (c.dimension = 150) THEN (c.maxld3/22.5) ELSE (c.maxld3/10)  END) as a3
							from test_cube_test c,test_site_detail s,test_customer cu
							where c.customer_id=cu.customer_id
							and c.site_id=s.site_id
							and c.tst_id=?
             				<sql:param value="${param.tst_id}"/>
             			</sql:query>
             		
             			<c:forEach items="${cube.rows}" var="cube">
             				<c:set value="${cube}" var="rs"/>
             			</c:forEach>
             			<div class="row">
		                  <div class="col-sm-12">
		                   	<form class="" action="../CubeTestControllerTest?action=UpdateCubeTest" method="post">
		                        <div class="card-box row col-sm-12">
		                           	<div class="col-sm-6">
		                           		<div class="form-group">
		                                    <label>Plant <span class="text-danger">*</span></label>
		                                    <sql:query var="plant" dataSource="jdbc/rmc">
		                                    	select * from plant where plant_id like if(0=?,'%%',?)
		                                    	<sql:param value="${bean.plant_id}"/>
		                                    	<sql:param value="${bean.plant_id}"/>
		                                    </sql:query>
		                                    <input type="hidden" name="tst_id" value="${rs.tst_id}" id="tst_id"/>
											<select id="plant_id"  name="plant_id"  required="required"  class="select2"  data-placeholder="Choose Plant">
												<c:forEach var="plant" items="${plant.rows}">
												<option value="${plant.plant_id}" ${(plant.plant_id==rs.plant_id)?'selected':''}>${plant.plant_name}</option>
												</c:forEach>
											</select>
		                                </div>
		                                
		                                <!-- Get customer site details  -->
		                                <sql:query var="site" dataSource="jdbc/rmc">
		                                	select * from test_site_detail where customer_id=?
		                                	<sql:param value="${rs.customer_id}"/>
		                                </sql:query>
		                                <div class="form-group">
		                                    <label>Site Name<span class="text-danger">*</span></label>
											<select id="site_id"  name="site_id" required="required"   class="select2"  data-placeholder="Choose Site">
												<c:forEach items="${site.rows}" var="site">
													<option value="${site.site_id}" ${(site.site_id==rs.site_id)?'selected':''}>${site.site_name}</option>
												</c:forEach>
											</select>
		                                </div>
		                                
		                                <div class="form-group">
		                                    <label>Testing Days<span class="text-danger">*</span></label>
											<input type="number" class="form-control" value="${rs.testing_days}" name="testing_days" id="testing_days"/>
		                                </div>
		                                <div class="form-group">
		                                    <label>Cube Dimension<span class="text-danger">*</span></label>
											<select id="dimension"  name="dimension" required="required"   class="select2"  data-placeholder="Choose Site">
												<option value="100" ${(rs.dimension==100)?'selected':''}>100</option>
												<option value="150" ${(rs.dimension==150)?'selected':''}>150</option>
											</select>
		                                </div>
		                            </div>
		                            <div class="col-sm-6">
		                                 <div class="form-group">
		                                    <label>Customer <span class="text-danger">*</span></label>
		                                    <sql:query var="customer" dataSource="jdbc/rmc">
		                                    	select * from test_customer where customer_status='active' order by customer_name asc
		                                    </sql:query>
											<select id="customer_id"  name="customer_id"    class="select2"  data-placeholder="Choose Customer" required="required">
												<option value="">&nbsp;</option>
												<c:forEach var="customer" items="${customer.rows}">
												<option value="${customer.customer_id}" ${(customer.customer_id==rs.customer_id)?'selected':''}>${customer.customer_name}</option>
												</c:forEach>
											</select>
		                                </div>
		                                <div class="form-group">
		                                    <label>Grade<span class="text-danger">*</span></label>
											<select id="product_name"  name="product_name" required="required"  class="select2"  data-placeholder="Choose Site">
												<option value="${rs.product_name}">${rs.product_name}</option>
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
		                                
		                             </div>
		                             
		                             <table class="table table-bordered">
		                             	<tr style="background-color:#f48611;color: white;">
											<th>Length</th>
											<th>Width</th>
											<th>Height</th>
											<th class="col-xs-3 text-center">Total Mass(KG)</th>
											<th class="col-xs-3 text-center">Max Load(KN)</th>
											<th class="col-xs-1 text-center">Cube Strength</th>
											<th class="col-xs-1 text-center">Cube Density</th>
										</tr>
										
										<tr>
											<td class="dim">150</td>
											<td class="dim">150</td>
											<td class="dim">150</td>
											<td>
												<input type="number" value="${rs.mass1}" required="required" onkeyup="calculateCubeTest(this);" step="0.01" name="mass1" id="mass1" class="form-control mass">
											</td>
											<td>
												<input type="number" value="${rs.maxld1}" required="required" onkeyup="calculateCubeTest(this);" step="0.01" name="maxld1" id="maxld1" class="form-control load">
											</td>
											<td class="ste">
												${rs.a1}
											</td>
											<td class="dens">${rs.m_one}</td>
										</tr>
										
										<tr>
											<td class="dim">150</td>
											<td class="dim">150</td>
											<td class="dim">150</td>
											<td>
												<input type="number" value="${rs.mass2}" required="required" onkeyup="calculateCubeTest(this);" step="0.01" name="mass2" id="mass2" class="form-control mass">
											</td>
											<td>
												<input type="number" value="${rs.maxld2}" required="required" onkeyup="calculateCubeTest(this);" step="0.01" name="maxld2" id="maxld2" class="form-control load">
											</td>
											<td class="ste">
												${rs.a2}
											</td>
											<td class="dens">${rs.m_two}</td>
										</tr>
										
										<tr>
											<td class="dim">150</td>
											<td class="dim">150</td>
											<td class="dim">150</td>
											<td>
												<input type="number" value="${rs.mass3}" required="required" onkeyup="calculateCubeTest(this);" step="0.01" name="mass3" id="mass3" class="form-control mass">
											</td>
											<td>
												<input type="number" value="${rs.maxld3}" required="required" onkeyup="calculateCubeTest(this);" step="0.01" name="maxld3" id="maxld3" class="form-control load">
											</td>
											<td class="ste">
												${rs.a3}
											</td>
											<td class="dens">${rs.m_three}</td>
										</tr>
										<tr>
											<td colspan="5" class="text-right">Avarage</td>
											<td colspan="2" id="avg"></td>
										</tr>
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
		                  <div class="col-sm-12">
		                   	<form class="" action="../CubeTestControllerTest?action=InsertCubeTest" method="post">
		                        <div class="card-box row col-sm-12">
		                           	<div class="col-sm-6">
		                           		<div class="form-group">
		                                    <label>Plant <span class="text-danger">*</span></label>
		                                    <sql:query var="plant" dataSource="jdbc/rmc">
		                                    	select * from plant where plant_id like if(0=?,'%%',?)
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
		                                    	select * from test_customer where customer_status='active' order by customer_name asc
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
		                                
		                             </div>
		                             
		                             <table class="table table-bordered">
		                             	<tr style="background-color:#f48611;color: white;">
											<th>Length</th>
											<th>Width</th>
											<th>Height</th>
											<th class="col-xs-3 text-center">Total Mass(KG)</th>
											<th class="col-xs-3 text-center">Max Load(KN)</th>
											<th class="col-xs-1 text-center">Cube Strength</th>
											<th class="col-xs-1 text-center">Cube Density</th>
										</tr>
										
										<tr>
											<td class="dim">150</td>
											<td class="dim">150</td>
											<td class="dim">150</td>
											<td>
												<input type="number" required="required" onkeyup="calculateCubeTest(this);" step="0.01" name="mass1" id="mass1" class="form-control mass">
											</td>
											<td>
												<input type="number" required="required" onkeyup="calculateCubeTest(this);" step="0.01" name="maxld1" id="maxld1" class="form-control load">
											</td>
											<td class="ste">
											</td>
											<td class="dens"></td>
										</tr>
										
										<tr>
											<td class="dim">150</td>
											<td class="dim">150</td>
											<td class="dim">150</td>
											<td>
												<input type="number" required="required" onkeyup="calculateCubeTest(this);" step="0.01" name="mass2" id="mass2" class="form-control mass">
											</td>
											<td>
												<input type="number" required="required" onkeyup="calculateCubeTest(this);" step="0.01" name="maxld2" id="maxld2" class="form-control load">
											</td>
											<td class="ste">
											</td>
											<td class="dens"></td>
										</tr>
										
										<tr>
											<td class="dim">150</td>
											<td class="dim">150</td>
											<td class="dim">150</td>
											<td>
												<input type="number" required="required" onkeyup="calculateCubeTest(this);" step="0.01" name="mass3" id="mass3" class="form-control mass">
											</td>
											<td>
												<input type="number" required="required" onkeyup="calculateCubeTest(this);" step="0.01" name="maxld3" id="maxld3" class="form-control load">
											</td>
											<td class="ste">
											</td>
											<td class="dens"></td>
										</tr>
										<tr>
											<td colspan="5" class="text-right">Avarage</td>
											<td colspan="2" id="avg"></td>
										</tr>
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
		<script src="../picker/js/bootstrap-datepicker.min.js"></script>
		<script src="../assets/js/bootstrap-timepicker.min.js"></script>
		<script src="../picker/js/moment.min.js"></script>
		<script type="text/javascript" src="../js/AddPurchaseOrder2.js"></script>
		<script src="../assets/js/ace.min.js"></script>
		
		
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
		
		<script type="text/javascript">
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
		</script>
		
		<script type="text/javascript">
			$(document).ready(function(){
				$('#site_id').on('change',function(){
					var site_id=$('#site_id').val();
					var plant_id=$('#plant_id').val();
					$.ajax({
						type:'post',
						url:'../CustomerControllerTest?action=GetSiteName&site_id='+site_id,
						headers:{
							Accept:"application/json;charset=utf-8",
							"Content-Type":"application/json;charset=utf-8"
						},
						success:function(result){
							$('#show_site_name').text(result.site_name);
							$('#show_site_address').text(result.site_address);
							$.ajax({
								type:'post',
								url:'../PurchaseOrderControllerTest?action=GetGradeList&site_id='+site_id+'&plant_id='+plant_id,
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
			calculateCubeTest(this);
		});
		</script>
    </body>
</html>