<!DOCTYPE html>
<%@ include file="Session.jsp" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<html>
<head>
        <meta charset="utf-8" />
        <title>Add Mix Design</title>
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
                                    <li class="breadcrumb-item"><a href="#">Mix Design</a></li>
                                    <li class="breadcrumb-item"><a href="#">Add Mix Design</a></li>
                                </ol>
                            </div>
                            
                           <h4 class="page-title">Add Mix Design</h4>
                            	
                        </div>
                    </div>
                </div>
                <!-- end page title end breadcrumb -->
                 <div class="row">
                    <div class="col-sm-4">
                        <a href="MixDesignList.jsp" class="btn btn-custom waves-effect waves-light mb-4"  data-overlayColor="#36404a"><i class="mdi mdi-plus"></i>Mix Design List</a>
                    </div><!-- end col -->
                </div>
                <!-- end row -->
                
                
                <c:choose>
                	<c:when test="${param.action=='update'}">
                		<!-- Get details for update -->
                		<sql:query var="mix" dataSource="jdbc/rmc">
                			select * from mix_design where design_id=?
                			<sql:param value="${param.design_id}"/>
                		</sql:query>
                		
                		<c:forEach var="mix" items="${mix.rows}">
                			<c:set value="${mix}" var="rs"/>
                		</c:forEach>
                		<div class="row">
		                    <div class="col-sm-12">
		                    	<form class="" action="MixDesignController?action=UpdateMixDesign" method="post">
			                        <div class="card-box row col-sm-12">
			                        	<div class="col-sm-3"></div>
			                           	<div class="col-sm-6">
			                                <div class="form-group">
			                                    <label>Receipe Code<span class="text-danger">*</span> </label>
			                                    <div>
			                                       <input type="hidden" name="design_id" value="${rs.design_id}">
			                                       <input type="text" class="form-control" 
			                                         pattern="[^'&quot;:]*$"  required="required"  value="${rs.recipe_code}"  id="receipe_code"  name="receipe_code"/>
			                                    </div>
			                                </div>
			                                <div class="form-group">
			                                    <label>Receipe Name<span class="text-danger">*</span> </label>
			                                    <div>
			                                       <input type="text" class="form-control" 
			                                         pattern="[^'&quot;:]*$"  required="required" value="${rs.recipe_name}"   id="receipe_name"  name="receipe_name"/>
			                                    </div>
			                                </div>
			                            </div>
			                            <div class="col-sm-12 row">
			                            	<div class="col-sm-2"></div>
			                            	<div class="col-sm-8">
			                            		<table class="table table-bordered table-condensed">
			                            			<thead>
			                            				<tr style="background-color: #3eced6;color: white;">
			                            					<th>S/L No</th>
			                            					<th>Mix Types</th>
			                            					<th>Product</th>
			                            					<th>Quantity</th>
			                            				</tr>
			                            			</thead>
			                            			<tbody>
			                            				<tr>
			                            					<td>1</td>
			                            					<td>Aggr1</td>
			                            					<td>
			                            						<input type="text" class="form-control" 
			                                         pattern="[^'&quot;:]*$"   value="${rs.aggregate1_name}"  id="aggregate1_name"  name="aggregate1_name"/>
			                            					</td>
			                            					<td>
			                            						<input type="number" class="form-control" 
			                                         pattern="[^'&quot;:]*$"  value="${rs.aggregate1_value}"   id="aggregate1_value"  name="aggregate1_value"/>
			                            					</td>
			                            				</tr>
			                            				<tr>
			                            					<td>2</td>
			                            					<td>Aggr2</td>
			                            					<td>
			                            						<input type="text" class="form-control" 
			                                         pattern="[^'&quot;:]*$"  value="${rs.aggregate2_name}"    id="aggregate2_name"  name="aggregate2_name"/>
			                            					</td>
			                            					<td>
			                            						<input type="text" class="form-control" 
			                                         pattern="[^'&quot;:]*$" value="${rs.aggregate2_value}"    id="aggregate2_value"  name="aggregate2_value"/>
			                            					</td>
			                            				</tr>
			                            				<tr>
			                            					<td>3</td>
			                            					<td>Aggr3</td>
			                            					<td>
			                            						<input type="text" class="form-control" 
			                                         pattern="[^'&quot;:]*$"  value="${rs.aggregate3_name}"   id="aggregate3_name"  name="aggregate3_name"/>
			                            					</td>
			                            					<td>
			                            						<input type="number" class="form-control" 
			                                         pattern="[^'&quot;:]*$"  value="${rs.aggregate3_value}"    id="aggregate3_value"  name="aggregate3_value"/>
			                            					</td>
			                            				</tr>
			                            				<tr>
			                            					<td>4</td>
			                            					<td>Aggr4</td>
			                            					<td>
			                            						<input type="text" class="form-control" 
			                                         pattern="[^'&quot;:]*$"  value="${rs.aggregate4_name}"   id="aggregate4_name"  name="aggregate4_name"/>
			                            					</td>
			                            					<td>
			                            						<input type="number" class="form-control" 
			                                         pattern="[^'&quot;:]*$"  value="${rs.aggregate4_value}"   id="aggregate4_value"  name="aggregate4_value"/>
			                            					</td>
			                            				</tr>
			                            				<tr>
			                            					<td>5</td>
			                            					<td>Cem1</td>
			                            					<td>
			                            						<input type="text" class="form-control" 
			                                         pattern="[^'&quot;:]*$"  value="${rs.aggregate5_name}"   id="aggregate5_name"  name="aggregate5_name"/>
			                            					</td>
			                            					<td>
			                            						<input type="number" class="form-control" 
			                                         pattern="[^'&quot;:]*$"  value="${rs.aggregate5_value}"    id="aggregate5_value"  name="aggregate5_value"/>
			                            					</td>
			                            				</tr>
			                            				<tr>
			                            					<td>6</td>
			                            					<td>Cem2</td>
			                            					<td>
			                            						<input type="text" class="form-control" 
			                                         pattern="[^'&quot;:]*$"   value="${rs.aggregate6_name}"   id="aggregate6_name"  name="aggregate6_name"/>
			                            					</td>
			                            					<td>
			                            						<input type="number" class="form-control" 
			                                         pattern="[^'&quot;:]*$"  value="${rs.aggregate6_value}"   id="aggregate6_value"  name="aggregate6_value"/>
			                            					</td>
			                            				</tr>
			                            				<tr>
			                            					<td>7</td>
			                            					<td>Cem3</td>
			                            					<td>
			                            						<input type="text" class="form-control" 
			                                         pattern="[^'&quot;:]*$"   value="${rs.aggregate7_name}"   id="aggregate7_name"  name="aggregate7_name"/>
			                            					</td>
			                            					<td>
			                            						<input type="number" class="form-control" 
			                                         pattern="[^'&quot;:]*$"   value="${rs.aggregate7_value}"  id="aggregate7_value"  name="aggregate7_value"/>
			                            					</td>
			                            				</tr>
			                            				<tr>
			                            					<td>8</td>
			                            					<td>Water</td>
			                            					<td>
			                            						<input type="text" class="form-control" 
			                                         pattern="[^'&quot;:]*$"  value="${rs.aggregate8_name}"   id="aggregate8_name"  name="aggregate8_name"/>
			                            					</td>
			                            					<td>
			                            						<input type="number" class="form-control" 
			                                         pattern="[^'&quot;:]*$"  value="${rs.aggregate8_value}"   id="aggregate8_value"  name="aggregate8_value"/>
			                            					</td>
			                            				</tr>
			                            				<tr>
			                            					<td>9</td>
			                            					<td>Admix1</td>
			                            					<td>
			                            						<input type="text" class="form-control" 
			                                         pattern="[^'&quot;:]*$"  value="${rs.aggregate9_name}"   id="aggregate9_name"  name="aggregate9_name"/>
			                            					</td>
			                            					<td>
			                            						<input type="text" class="form-control" 
			                                         pattern="[^'&quot;:]*$"   value="${rs.aggregate9_value}"  id="aggregate9_value"  step="0.01" name="aggregate9_value"/>
			                            					</td>
			                            				</tr>
			                            				<tr>
			                            					<td>10</td>
			                            					<td>Admix10</td>
			                            					<td>
			                            						<input type="text" class="form-control" 
			                                         pattern="[^'&quot;:]*$"   value="${rs.aggregate10_name}"   id="aggregate10_name"  name="aggregate10_name"/>
			                            					</td>
			                            					<td>
			                            						<input type="number" class="form-control" 
			                                         pattern="[^'&quot;:]*$"   step="0.01" value="${rs.aggregate10_value}"   id="aggregate10_value"  name="aggregate10_value"/>
			                            					</td>
			                            				</tr>
			                            				<tr>
			                            					<td>11</td>
			                            					<td>Aggr5</td>
			                            					<td>
			                            						<input type="text" class="form-control" 
			                                         pattern="[^'&quot;:]*$"   value="${rs.aggregate11_name}"    id="aggregate11_name"  name="aggregate11_name"/>
			                            					</td>
			                            					<td>
			                            						<input type="number" class="form-control" 
			                                         pattern="[^'&quot;:]*$"  value="${rs.aggregate11_value}"   id="aggregate11_value"  name="aggregate11_value"/>
			                            					</td>
			                            				</tr>
			                            			</tbody>
			                            		</table>
			                            	</div>
			                            </div>
		                               
		                                <div class="col-sm-12 text-center">
		                                	<div class="form-group">
			                                    <div>
			                                    	<input type="hidden" name="gst_percent" value="" id="gst_percent">
			                                        <button type="submit" id="save-option" class="btn btn-custom waves-effect waves-light">
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
		                    	<form class="" action="MixDesignController?action=InsertMixDesign" method="post">
			                        <div class="card-box row col-sm-12">
			                        	<div class="col-sm-3"></div>
			                           	<div class="col-sm-6">
			                                <div class="form-group">
			                                    <label>Receipe Code<span class="text-danger">*</span> </label>
			                                    <div>
			                                       <input type="text" class="form-control" 
			                                         pattern="[^'&quot;:]*$"  required="required"   id="receipe_code"  name="receipe_code"/>
			                                    </div>
			                                </div>
			                                <div class="form-group">
			                                    <label>Receipe Name<span class="text-danger">*</span> </label>
			                                    <div>
			                                       <input type="text" class="form-control" 
			                                         pattern="[^'&quot;:]*$"  required="required"   id="receipe_name"  name="receipe_name"/>
			                                    </div>
			                                </div>
			                            </div>
			                            <div class="col-sm-12 row">
			                            	<div class="col-sm-2"></div>
			                            	<div class="col-sm-8">
			                            		<table class="table table-bordered table-condensed">
			                            			<thead>
			                            				<tr style="background-color: #3eced6;color: white;">
			                            					<th>S/L No</th>
			                            					<th>Mix Types</th>
			                            					<th>Product</th>
			                            					<th>Quantity</th>
			                            				</tr>
			                            			</thead>
			                            			<tbody>
			                            				<tr>
			                            					<td>1</td>
			                            					<td>Aggr1</td>
			                            					<td>
			                            						<input type="text" class="form-control" 
			                                         pattern="[^'&quot;:]*$"    id="aggregate1_name"  name="aggregate1_name"/>
			                            					</td>
			                            					<td>
			                            						<input type="number" class="form-control" 
			                                         pattern="[^'&quot;:]*$"     id="aggregate1_value"  name="aggregate1_value"/>
			                            					</td>
			                            				</tr>
			                            				<tr>
			                            					<td>2</td>
			                            					<td>Aggr2</td>
			                            					<td>
			                            						<input type="text" class="form-control" 
			                                         pattern="[^'&quot;:]*$"     id="aggregate2_name"  name="aggregate2_name"/>
			                            					</td>
			                            					<td>
			                            						<input type="text" class="form-control" 
			                                         pattern="[^'&quot;:]*$"     id="aggregate2_value"  name="aggregate2_value"/>
			                            					</td>
			                            				</tr>
			                            				<tr>
			                            					<td>3</td>
			                            					<td>Aggr3</td>
			                            					<td>
			                            						<input type="text" class="form-control" 
			                                         pattern="[^'&quot;:]*$"     id="aggregate3_name"  name="aggregate3_name"/>
			                            					</td>
			                            					<td>
			                            						<input type="number" class="form-control" 
			                                         pattern="[^'&quot;:]*$"     id="aggregate3_value"  name="aggregate3_value"/>
			                            					</td>
			                            				</tr>
			                            				<tr>
			                            					<td>4</td>
			                            					<td>Aggr4</td>
			                            					<td>
			                            						<input type="text" class="form-control" 
			                                         pattern="[^'&quot;:]*$"     id="aggregate4_name"  name="aggregate4_name"/>
			                            					</td>
			                            					<td>
			                            						<input type="number" class="form-control" 
			                                         pattern="[^'&quot;:]*$"     id="aggregate4_value"  name="aggregate4_value"/>
			                            					</td>
			                            				</tr>
			                            				<tr>
			                            					<td>5</td>
			                            					<td>Cem1</td>
			                            					<td>
			                            						<input type="text" class="form-control" 
			                                         pattern="[^'&quot;:]*$"     id="aggregate5_name"  name="aggregate5_name"/>
			                            					</td>
			                            					<td>
			                            						<input type="number" class="form-control" 
			                                         pattern="[^'&quot;:]*$"     id="aggregate5_value"  name="aggregate5_value"/>
			                            					</td>
			                            				</tr>
			                            				<tr>
			                            					<td>6</td>
			                            					<td>Cem2</td>
			                            					<td>
			                            						<input type="text" class="form-control" 
			                                         pattern="[^'&quot;:]*$"     id="aggregate6_name"  name="aggregate6_name"/>
			                            					</td>
			                            					<td>
			                            						<input type="number" class="form-control" 
			                                         pattern="[^'&quot;:]*$"     id="aggregate6_value"  name="aggregate6_value"/>
			                            					</td>
			                            				</tr>
			                            				<tr>
			                            					<td>7</td>
			                            					<td>Cem3</td>
			                            					<td>
			                            						<input type="text" class="form-control" 
			                                         pattern="[^'&quot;:]*$"     id="aggregate7_name"  name="aggregate7_name"/>
			                            					</td>
			                            					<td>
			                            						<input type="number" class="form-control" 
			                                         pattern="[^'&quot;:]*$"     id="aggregate7_value"  name="aggregate7_value"/>
			                            					</td>
			                            				</tr>
			                            				<tr>
			                            					<td>8</td>
			                            					<td>Water</td>
			                            					<td>
			                            						<input type="text" class="form-control" 
			                                         pattern="[^'&quot;:]*$"     id="aggregate8_name"  name="aggregate8_name"/>
			                            					</td>
			                            					<td>
			                            						<input type="number" class="form-control" 
			                                         pattern="[^'&quot;:]*$"     id="aggregate8_value"  name="aggregate8_value"/>
			                            					</td>
			                            				</tr>
			                            				<tr>
			                            					<td>9</td>
			                            					<td>Admix1</td>
			                            					<td>
			                            						<input type="text" class="form-control" 
			                                         pattern="[^'&quot;:]*$"     id="aggregate9_name"  name="aggregate9_name"/>
			                            					</td>
			                            					<td>
			                            						<input type="text" class="form-control" 
			                                         pattern="[^'&quot;:]*$"     id="aggregate9_value"  step="0.01" name="aggregate9_value"/>
			                            					</td>
			                            				</tr>
			                            				<tr>
			                            					<td>10</td>
			                            					<td>Admix10</td>
			                            					<td>
			                            						<input type="text" class="form-control" 
			                                         pattern="[^'&quot;:]*$"     id="aggregate10_name"  name="aggregate10_name"/>
			                            					</td>
			                            					<td>
			                            						<input type="number" class="form-control" 
			                                         pattern="[^'&quot;:]*$"   step="0.01"   id="aggregate10_value"  name="aggregate10_value"/>
			                            					</td>
			                            				</tr>
			                            				<tr>
			                            					<td>11</td>
			                            					<td>Aggr5</td>
			                            					<td>
			                            						<input type="text" class="form-control" 
			                                         pattern="[^'&quot;:]*$"      id="aggregate11_name"  name="aggregate11_name"/>
			                            					</td>
			                            					<td>
			                            						<input type="number" class="form-control" 
			                                         pattern="[^'&quot;:]*$"     id="aggregate11_value"  name="aggregate11_value"/>
			                            					</td>
			                            				</tr>
			                            			</tbody>
			                            		</table>
			                            	</div>
			                            </div>
		                               
		                                <div class="col-sm-12 text-center">
		                                	<div class="form-group">
			                                    <div>
			                                    	<input type="hidden" name="gst_percent" value="" id="gst_percent">
			                                        <button type="submit" id="save-option" class="btn btn-custom waves-effect waves-light">
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
		<script src="picker/js/moment.min.js"></script>
		<script src="picker/js/bootstrap-datetimepicker.min.js"></script>
		<script type="text/javascript" src="js/AddPurchaseOrder.js"></script>
		
		<script type="text/javascript">
			$(document).ready(function(){
				$('#site_id').on('change',function(){
					var site_id=$('#site_id').val();
					$.ajax({
						type:'post',
						url:'CustomerController?action=siteDetailsUsingId&site_id='+site_id,
						headers:{
							Accept:"text/html;charset=utf-8",
							"Content-Type":"text/html;charset=utf-8"
						},
						success:function(res){
							$('#site_address').val(res);
						}
					});
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
			function getGstDetails(){
				var gst_type=$('#gst_type').val();
				$.ajax({
					type:'POST',
					url:'SettingController?action=getGstDetails&gst_type='+gst_type,
					headers:{
						Accept:"text/html;charset=utf-8",
						"Content-Type":"text/html;charset=utf-8"
					},
					success:function(res){
						if(res==''){
							alert("Please set gst % in GST Setting");
							$('#save-option').prop("disabled",true);
						}else{
							$('#gst_percent').val(res);
						}
					}
				})
			}
		</script>
		<script type="text/javascript">
			$(document).ready(function(){
				getGstDetails();
			});
			
			$(document).ready(function(){
				$('#gst_type').on("change",function(){
					getGstDetails();
				});
			});
		</script>
    </body>
</html>