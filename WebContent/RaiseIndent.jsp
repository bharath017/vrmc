<!DOCTYPE html>
<%@ include file="Session.jsp" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<html>
<head>
        <meta charset="utf-8" />
        <title>Add Indent</title>
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
                                    <li class="breadcrumb-item"><a href="#">Inventory</a></li>
                                    <li class="breadcrumb-item"><a href="#">Indent</a></li>
                                    <li class="breadcrumb-item"><a href="#">Add Indent</a></li>
                                </ol>
                            </div>
                            
                            <c:choose>
                            	<c:when test="${param.action=='update'}">
                            		<h4 class="page-title">Update Indent</h4>
                            	</c:when>
                            	<c:otherwise>
                            		<h4 class="page-title">Add Indent</h4>
                            	</c:otherwise>
                            </c:choose>
                        
                        </div>
                    </div>
                </div>
                <!-- end page title end breadcrumb -->
                 <div class="row">
                    <div class="col-sm-4">
                        <a href="IndentList.jsp" class="btn btn-custom waves-effect waves-light mb-4"  data-overlayColor="#36404a"><i class="mdi mdi-plus"></i>Supplier Purchase Order List</a>
                    </div><!-- end col -->
                </div>
                <!-- end row -->
                
                
                <c:choose>
                	<c:when test="${param.action=='update'}">
                		<sql:query var="spo" dataSource="jdbc/rmc">
                			select * from indent where indent_id=?
                			<sql:param value="${param.indent_id}"/>
                		</sql:query>
                		<c:forEach items="${spo.rows}" var="spo">
                			<c:set value="${spo}" var="rs"/>
                		</c:forEach>
                		<div class="row">
		                    <div class="col-sm-12">
		                    	<form class="" action="IndentController?action=updateIndent" method="post">
			                        <div class="card-box row col-sm-12">
			                       <div class="col-sm-6">	
			                           			                           				         	 
			                                <div class="form-group">
                                                <label>Indent Date <span class="text-danger">*</span> </label>
                                                <div>
                                                    <div class="input-group">
                                                     <input type="hidden" name="indent_id"  value="${rs.indent_id}">
                                                        <input type="text" name="indent_date" required="required" value="${rs.indent_date}" class="form-control date-picker" placeholder="yyyy-mm-dd" id="id-date-picker-1" data-date-format="yyyy-mm-dd">
                                                        <div class="input-group-append">
                                                            <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                             
                                            <div class="form-group">
			                                    <label>Plant <span class="text-danger">*</span></label>
			                                    <sql:query var="plant" dataSource="jdbc/rmc">
			                                    	select * from plant
			                                    </sql:query>
												<select id="plant_id"  name="plant_id"  required="required"  class="select2"  data-placeholder="Choose Plant">
													<c:forEach var="plant" items="${plant.rows}">
													<option value="${plant.plant_id}" ${(rs.plant_id==plant.plant_id)?'selected':''}>${plant.plant_name}</option>
													</c:forEach>
												</select>
			                                </div>
			                               
			                                
			                                  <div class="form-group">
			                                    <label>Type :<span class="text-danger"></span> </label>
			                                    <div>
			                                         <select id="type" class="select2"  name="type">
			                                         	<option value="consumable" ${(rs.type=='consumable')?'selected':''}>Consumable</option>
			                                         	<option value="non_consumable" ${(rs.type=='non_consumable')?'selected':''}>Non-Consumable</option>
			                                         </select>
			                                    </div>
			                                </div>		                                			                                                                       		                                
			                          </div>
			                            <div class="col-sm-6">  
			                                 <div class="form-group">
                                                <label>Required Date <span class="text-danger">*</span> </label>
                                                <div>
                                                    <div class="input-group">
                                                        <input type="text" name="required_date" required="required" value="${rs.required_date}" class="form-control date-picker" placeholder="yyyy-mm-dd" id="id-date-picker-1" data-date-format="yyyy-mm-dd">
                                                        <div class="input-group-append">
                                                            <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
			                                <div class="form-group">
			                                    <label>Budget Head<span class="text-danger"></span> </label>
			                                    <div>
			                                       <input type="text" class="form-control" 
			                                         pattern="[^'&quot;:]*$"  value="${rs.budget_head}"  id="budget_head" name="budget_head"/>
			                                    </div>
			                                </div>
			                              </div>
			                             
			                             <sql:query var="unit" dataSource="jdbc/rmc">
												select * from unit
										</sql:query>
										<c:set var="name">
											<select class="col-xs-12 select2" required="required" name="unit">'+
												<c:forEach items="${unit.rows}" begin="0" var="unit">
														'<option value="${unit.unit_name}">${unit.unit_name}</option>'+
													</c:forEach>
											'</select>
										</c:set>
			                             
			                             <div class="col-sm-12" id="clicked">
		                                	<table class="table table-bordered" id="Table1">
		                                		<thead>
		                                			<tr>
			                                			<th class="text-center">Product Name</th>
			                                			<th class="text-center">Description</th>
			                                			<th class="text-center">Quantity</th>
			                                			<th class="text-center">Unit</th>
			                                			<th class="text-center">Unit Price</th>
			                                			<th class="text-center">
			                                				<span class="text-success BtnPlus">
			                                					<i class="fa fa-plus"></i>
			                                				</span>
			                                			</th>
			                                		</tr>
		                                		</thead>
		                                		<!-- get all customer quotation item here -->
		                                		<sql:query var="spoi" dataSource="jdbc/rmc">
		                                			select * from indent_item where indent_id=?
		                                			<sql:param value="${rs.indent_id}"/>
		                                		</sql:query>
		                                		
		                                		<tbody>
		                                			<c:forEach items="${spoi.rows}" var="spoi">
			                                			<tr>
			                                				<td style="width:15%">
			                                					<input type="hidden" name="indent_item_id" value="${spoi.indent_item_id}"/>
			                                					<input type="text" class="form-control" value="${spoi.product_number}"  placeholder="Enter Product Name"   name="product_number"/>
			                                				</td>
			                                				
				                                			<td style="width:25%">
			                                					<input type="text" class="form-control" value="${spoi.description1}"  placeholder="Enter Description1"   name="description1"/>
			                                				</td>
			                                				<td style="width:20%">
			                                					<input type="text" class="form-control" value="${spoi.quantity}" placeholder="Enter Quantity"  onkeyup="calculateNetAmmount(this);" name="quantity"/>
			                                				</td>
			                                				
			                                				<td style="width:20%">
		                                					<sql:query var="unit" dataSource="jdbc/rmc">
																	select * from unit
															</sql:query>
															<select class="col-xs-12 select2" required="required" name="unit">
																<c:forEach items="${unit.rows}" begin="0" var="unit">
																		<option value="${unit.unit_name}" ${(unit.unit_name==spoi.unit)?'selected':''}>${unit.unit_name}</option>
																	</c:forEach>
															</select>
			                                				</td>
			                                				
			                                				<td style="width:10%">
			                                					<input type="text" class="form-control" value="${spoi.unit_price}" onkeyup="calculateNetAmmount(this);" placeholder="Enter Unit Price"   name="unit_price"/>
			                                				</td>
			                                				
			                                				<td style="width:10%">
			                                					<input type="text" class="form-control net_amount" 
				                                         		pattern="[^'&quot;:]*$" readonly="readonly" value="${spoi.unit_price*spoi.quantity}" required="required" placeholder="Net price"   name="net_amount"/>
			                                				</td>
			                                				<td>
			                                				</td>
			                                			</tr>
		                                			</c:forEach>
		                                		</tbody>
		                                			<tfoot>
		                                			<tr>
		                                				<td colspan="4"></td>
		                                				<td>Total Net Amount : </td>
		                                				<td id="total_grand"></td>
		                                			</tr>
		                                		</tfoot>
		                                	</table>
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
		                    	<form class="" action="IndentController?action=raiseIndent" method="post">
			                        <div class="card-box row col-sm-12">
			                           	<div class="col-sm-6">	
			                           			                           				         	 
			                                <div class="form-group">
                                                <label>Indent Date <span class="text-danger">*</span> </label>
                                                <div>
                                                    <div class="input-group">
                                                        <input type="text" name="indent_date" required="required" class="form-control date-picker" placeholder="yyyy-mm-dd" id="id-date-picker-1" data-date-format="yyyy-mm-dd">
                                                        <div class="input-group-append">
                                                            <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                             
                                            <div class="form-group">
			                                    <label>Plant <span class="text-danger">*</span></label>
			                                    <sql:query var="plant" dataSource="jdbc/rmc">
			                                    	select * from plant
			                                    </sql:query>
												<select id="plant_id"  name="plant_id"  required="required"  class="select2"  data-placeholder="Choose Plant">
													<c:forEach var="plant" items="${plant.rows}">
													<option value="${plant.plant_id}">${plant.plant_name}</option>
													</c:forEach>
												</select>
			                                </div>
			                               
			                                
			                                  <div class="form-group">
			                                    <label>Type :<span class="text-danger"></span> </label>
			                                    <div>
			                                         <select id="type" class="select2" name="type">
			                                         	<option value="consumable">Consumable</option>
			                                         	<option value="non_consumable">Non-Consumable</option>
			                                         </select>
			                                    </div>
			                                </div>		                                			                                                                       		                                
			                          </div>
			                            <div class="col-sm-6">  
			                                 <div class="form-group">
                                                <label>Required Date <span class="text-danger">*</span> </label>
                                                <div>
                                                    <div class="input-group">
                                                        <input type="text" name="required_date" required="required" class="form-control date-picker" placeholder="yyyy-mm-dd" id="id-date-picker-1" data-date-format="yyyy-mm-dd">
                                                        <div class="input-group-append">
                                                            <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
			                                <div class="form-group">
			                                    <label>Budget Head<span class="text-danger"></span> </label>
			                                    <div>
			                                       <input type="text" class="form-control" 
			                                         pattern="[^'&quot;:]*$"    id="budget_head" name="budget_head"/>
			                                    </div>
			                                </div>
			                              </div>
			                                
			                                
			                             
			                             
			                           
			                             
			                             
			                             <sql:query var="unit" dataSource="jdbc/rmc">
												select * from unit
										</sql:query>
										<c:set var="name">
											<select class="col-xs-12 select2" required="required" name="unit">'+
												<c:forEach items="${unit.rows}" begin="0" var="unit">
														'<option value="${unit.unit_name}">${unit.unit_name}</option>'+
													</c:forEach>
											'</select>
										</c:set>
			                             <div class="col-sm-12" id="clicked">
		                                	<table class="table table-bordered" id="Table1">
		                                		<thead>
		                                			<tr>
			                                			<th class="text-center">Product Name</th>
			                                			<th class="text-center">Description</th>
			                                			<th class="text-center">Quantity</th>
			                                			<th class="text-center">Unit</th>
			                                			<th class="text-center">Unit Price</th>
			                                			<th class="text-center">Net Amount</th>
			                                			<th class="text-center" style="width: 2%;">
			                                				<span class="text-success BtnPlus">
			                                					<i class="fa fa-plus"></i>
			                                				</span>
			                                			</th>
			                                		</tr>
		                                		</thead>
		                                		<tbody>
		                                			<tr>
		                                				<td style="width:15%">
		                                					<input type="text" class="form-control" required="required" placeholder="Enter Product Name"   name="product_number"/>
		                                				</td>
		                                				
		                                				<td style="width:25%">
		                                					<input type="text" class="form-control" 
			                                         pattern="[^'&quot;:]*$"  required="required" placeholder="Enter Description1"   name="description1"/>
		                                				</td>
		                                				
		                                				<td style="width:12%">
		                                					<input type="number" step="0.01" class="form-control quantity" 
			                                         pattern="[^'&quot;:]*$"  required="required" onkeyup="calculateNetAmmount(this);" placeholder="Enter Quantity"   name="quantity"/>
		                                				</td>
		                                				
		                                				<td style="width:12%">
		                                					${name}
		                                				</td>
		                                				
		                                				<td style="width:12%">
		                                					<input type="text" step="0.01" class="form-control unit_price" 
			                                         pattern="[^'&quot;:]*$"  required="required" placeholder="Enter Unit Price" onkeyup="calculateNetAmmount(this);"  name="unit_price"/>
		                                				</td>
		                                				<td style="width:20%">
		                                					<input type="text" class="form-control net_amount" 
			                                         pattern="[^'&quot;:]*$" readonly="readonly" required="required" placeholder="Net price"   name="net_amount"/>
		                                				</td>
		                                			</tr>
		                                		</tbody>
		                                		<tfoot>
		                                		<!-- 	<tr>
		                                				<td colspan="4"></td>
		                                				<td>Total Gross Amount : </td>
		                                				<td id="total_val"></td>
		                                			</tr>
		                                			<tr>
		                                				<td colspan="4"></td>
		                                				<td>Total Tax Amount : </td>
		                                				<td id="total_gst"></td>
		                                			</tr> -->
		                                			<tr>
		                                				<td colspan="4"></td>
		                                				<td>Total Net Amount : </td>
		                                				<td id="total_grand"></td>
		                                			</tr>
		                                		</tfoot>
		                                	</table>
		                                </div>
		                                <div class="form-group col-sm-12">
			                                    <label>JUSTIFICATION FOR PROCURMENT OF THE ABOVE ITEMS :<span class="text-danger"></span> </label>
			                                    <div>
			                                     <textarea  class="form-control" 
			                                              id="justification" name="justification"></textarea>
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
        
<!--         end wrapper -->

        <!-- Footer -->
       <%@ include file="footer.jsp" %>
        <!-- End Footer -->


        <!-- jQuery  -->
        <script src="assets/js/jquery.min.js"></script>
        <script src="assets/js/popper.min.js"></script>
        <script src="assets/js/bootstrap.min.js"></script>
        <script src="assets/js/waves.js"></script>
        <script src="assets/js/jquery.slimscroll.js"></script>
		<script type="text/javascript" src="js/AddPurchaseOrder.js"></script>
        <!-- Parsley js -->
        <script type="text/javascript" src="plugins/parsleyjs/parsley.min.js"></script>

        <!-- App js -->
        <script src="assets/js/jquery.core.js"></script>
        <script src="assets/js/jquery.app.js"></script>
        <script src="assets/js/select2.min.js"></script>
		<script src="picker/js/bootstrap-datepicker.min.js"></script>
		<script src="picker/js/moment.min.js"></script>
		<script src="picker/js/bootstrap-datetimepicker.min.js"></script>
		
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
										'<input type="text" class="form-control"  pattern="[^\'&quot;:]*$"  required="required" placeholder="Enter Product Number"   name="product_number"/>'+
									'</td>'+
									
									'<td>'+
										'<input type="text" class="form-control"  pattern="[^\'&quot;:]*$"  required="required" placeholder="Enter Description"   name="description1"/>'+
									'</td>'+
									
									'<td>'+
										'<input type="number" step="0.01" class="form-control quantity" pattern="[^\'&quot;:]*$" onkeyup="calculateNetAmmount(this);" required="required" placeholder="Enter Quantity"   name="quantity"/>'+
									'</td>'+
									
									'<td>'+
										'${name}'+
									'</td>'+
									
									'<td>'+
										'<input type="number" step="0.01" class="form-control unit_price"  pattern="[^\'&quot;:]*$" onkeyup="calculateNetAmmount(this);"  required="required" placeholder="Enter Unit Price"   name="unit_price"/>'+
									'</td>'+
									
									'<td>'+
										'<input type="text" class="form-control net_amount"  readonly pattern="[^\'&quot;:]*$"  required="required" placeholder="Net Price"   name="net_amount"/>'+
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
				
				$("#id-date-picker-2").datepicker("setDate", new Date());
				$('#id-date-picker-2').datepicker({
				        "setDate": new Date(),
				        "autoclose": true
			    });
			});
			
			$(document).ready(function(){
				$('#gst_type').on("change",function(){
					getGstDetails();
				});
			});
		</script>
		<script type="text/javascript">
			function calculateNetAmmount(e){
				var quantity= $(e).closest("tr").find('input.quantity').val();
				var unit_price= $(e).closest("tr").find('input.unit_price').val();
				var total_price=parseFloat(quantity)*parseFloat(unit_price);
				total_price=isNaN(total_price)?'0.0':total_price;
			    $(e).closest("tr").find('input.net_amount').val(total_price);
			    var total = document.getElementsByClassName("net_amount");
			    var total_price=0.0;
			    for(var i=0;i<total.length;i++){
			    	if(!isNaN(total[i].value) && total[i].value.trim()!=''){
			    		total_price=parseFloat(total_price)+parseFloat(total[i].value);	
			    	}
			    }
			    
			   
				var grand_total=total_price;			    
				$('#total_val').html(total_price);
			/* 	$('#total_gst').html(gst_value.toFixed(2)); */
				$('#total_grand').html(grand_total.toFixed(2));
				
			}
		</script>
    </body>
</html>