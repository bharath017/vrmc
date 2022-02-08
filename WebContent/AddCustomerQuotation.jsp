<!DOCTYPE html>
<%@ include file="Session.jsp" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<html>
<head>
        <meta charset="utf-8" />
        <title>Add Customer Quotation</title>
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
                                    <li class="breadcrumb-item"><a href="#">Customer &amp; Customer Quotation</a></li>
                                    <li class="breadcrumb-item"><a href="#">Customer Quotation</a></li>
                                    <li class="breadcrumb-item"><a href="#">Add Customer Quotation</a></li>
                                </ol>
                            </div>
                            
                            <c:choose>
                            	<c:when test="${param.action=='update'}">
                            		<h4 class="page-title">Update Customer Quotation</h4>
                            	</c:when>
                            	<c:otherwise>
                            		<h4 class="page-title">Add Customer Quotation</h4>
                            	</c:otherwise>
                            </c:choose>
                        
                        </div>
                    </div>
                </div>
                <!-- end page title end breadcrumb -->
                 <div class="row">
                    <div class="col-sm-4">
                        <a href="CustomerQuotationList.jsp" class="btn btn-custom waves-effect waves-light mb-4"  data-overlayColor="#36404a"><i class="mdi mdi-plus"></i>Customer Quotation List</a>
                    </div><!-- end col -->
                </div>
                <!-- end row -->
                
                
                <c:choose>
                	<c:when test="${param.action=='update'}">
                		<sql:query var="cq" dataSource="jdbc/rmc">
                			select * from customer_quotation where quotation_id=?
                			<sql:param value="${param.quotation_id}"/>
                		</sql:query>
                		<c:forEach items="${cq.rows}" var="cq">
                			<c:set value="${cq}" var="rs"/>
                		</c:forEach>
                		<div class="row">
		                    <div class="col-sm-12">
		                    	<form class="" action="CustomerQuotationController?action=UpdateCustomerQuotation" method="post">
			                        <div class="card-box row col-sm-12">
			                           	<div class="col-sm-6">			                           				         	 
			                                <div class="form-group">
			                                    <label>Customer Name : <span class="text-danger">*</span> </label>
			                                    <div>
			                                       <input type="hidden" name="quotation_id" value="${rs.quotation_id}">
			                                       <input type="text" class="form-control" required="required"
			                                           placeholder="Enter Customer Name" value="${rs.customer_name}"   name="customer_name"/>
			                                    </div>
			                                </div>	
			                                
			                                <div class="form-group">
			                                    <label>Customer email : <span class="text-danger">*</span> </label>
			                                    <div>
			                                       <input type="text" class="form-control" required="required"
			                                           placeholder="Enter Customer Email" value="${rs.customer_email}"   name="customer_email"/>
			                                    </div>
			                                </div>	
			                                
			                                <div class="form-group">
                                                <label>Quotation Date <span class="text-danger"></span> </label>
                                                <div>
                                                    <div class="input-group">
                                                        <input type="text" name="quotation_date" class="form-control date-picker" value="${rs.quotation_date}" placeholder="yyyy-mm-dd" id="id-date-picker-1" data-date-format="yyyy-mm-dd">
                                                        <div class="input-group-append">
                                                            <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>			                                
			                                
			                                <div class="form-group">
			                                    <label>Site Address<span class="text-danger">*</span> </label>
			                                    <div>
			                                       <input type="text" class="form-control" 
			                                         required="required"   id="site_address" value="${rs.site_address}"  name="site_address"/>
			                                    </div>
			                                </div>	
			                       		      
			                       		      
			                       		      <div class="form-group">
			                                    <label>Marketing person <span class="text-danger">*</span></label>
			                                    <sql:query var="marketing" dataSource="jdbc/rmc">
			                                    	select * from marketing_person where mp_status='active' order by mp_name asc 
			                                    </sql:query>
												<select id="marketing"  name="mp_id" required="required"   class="select2"  data-placeholder="Choose Marketing Person">
													<option value="">&nbsp;</option>
													<c:forEach var="marketing" items="${marketing.rows}">
													<option value="${marketing.mp_id}"  ${(marketing.mp_id==rs.mp_id)?'selected':''}>${marketing.mp_name}</option>
													</c:forEach>
												</select>
			                                </div>	
			                       		                                			                                                                       		                                
			                            </div>			                            			                            
			                            
			                            <div class="col-sm-6">			                          			                            		
			                            	<div class="form-group">
			                                    <label>Customer Phone : <span class="text-danger">*</span> </label>
			                                    <div>
			                                       <input type="text" class="form-control" required="required"
			                                           placeholder="Enter Customer Phone" value="${rs.customer_phone}"   name="customer_phone"/>
			                                    </div>
			                                </div>
			                                
			                                <div class="form-group">
			                                    <label>Customer GSTIN : <span class="text-danger">*</span> </label>
			                                    <div>
			                                       <input type="text" class="form-control" required="required"
			                                           placeholder="Enter Customer GSTN" value="${rs.customer_gstin}"   name="customer_gstin"/>
			                                    </div>
			                                </div>			                           
			                                
			                                <div class="form-group">
			                                    <label>Pump Charge : </label>
			                                    <div>
			                                       <input type="text" class="form-control" 
			                                           placeholder="Enter Pump Charge"  value="${rs.pump_charge}"  name="pump_charge"/>
			                                    </div>
			                                </div>
			                                
			                                <div class="form-group">
			                                    <label>Pump Quantity : </label>
			                                    <div>
			                                       <input type="text" class="form-control" 
			                                           placeholder="Enter Pump Quantity"  value="${rs.pump_quantity}"  name="pump_quantity"/>
			                                    </div>
			                                </div>		
			                                
			                                <div class="form-group">
			                                    <label>Payment Terms : </label>
			                                    <div>
			                                       <input type="text" class="form-control" 
			                                           placeholder="Important Note"  value="${rs.comment}"  name="comment"/>
			                                    </div>
			                                </div>	                                		                                
			                             </div>
			                             
			                             <div class="col-sm-12" id="clicked">
		                                	<table class="table table-bordered" id="Table1">
		                                		<thead>
		                                			<tr>
			                                			<th class="text-center">Grade Name</th>
			                                			<th class="text_center">Quantity</th>
			                                			<th class="text-center">Cost/M<sup>3</sup> (OPC)</th>
			                                			<th class="text-center">Cost/M<sup>3</sup> (OPC + GGBS)</th>
			                                			<th class="text-center">
			                                				<span class="text-success BtnPlus">
			                                					<i class="fa fa-plus"></i>
			                                				</span>
			                                			</th>
			                                		</tr>
		                                		</thead>
		                                		<!-- get all customer quotation item here -->
		                                		<sql:query var="cqi" dataSource="jdbc/rmc">
		                                			select * from customer_quotation_item where quotation_id=?
		                                			<sql:param value="${rs.quotation_id}"/>
		                                		</sql:query>
		                                		
		                                		<tbody>
		                                			<c:forEach items="${cqi.rows}" var="cqi">
			                                			<tr>
			                                				<td>
																<sql:query var="grade" dataSource="jdbc/rmc">
							                                    	select * from product
							                                    </sql:query>
							                                    <input type="hidden" name="grade_id" value="${cqi.grade_id}">
																<select id="product_id" required="required"  name="grade_name"   class="select2"  data-placeholder="Choose Grade">
																	<option value="">&nbsp;</option>
																	<c:forEach var="grade" items="${grade.rows}">
																	<option value="${grade.product_name}" ${(cqi.grade_name==grade.product_name)?'selected':''}>${grade.product_name}</option>
																	</c:forEach>
																</select>		                                				
			                                				</td>
			                                				<td>
	                                      					 <input type="text" class="form-control"  pattern="[^'&quot;:]*$"   required="required" value="${cqi.quantity}" id="quantity" name="quantity"/>
	                                							</td>
			                                				<td>
			                                					<input type="text" class="form-control" pattern="[^'&quot;:]*$"  required="required" value="${cqi.grade_price}" placeholder="Enter Grade Price"   name="grade_price"/>
			                                				</td>
			                                				<td>
			                                					<input type="text" class="form-control" pattern="[^'&quot;:]*$"  required="required" value="${cqi.ggbs_price}" placeholder="Enter GGBS Price"   name="ggbs_price"/>
			                                				</td>
			                                			</tr>
		                                			</c:forEach>
		                                		</tbody>
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
		                    	<form class="" action="CustomerQuotationController?action=insert" method="post">
			                        <div class="card-box row col-sm-12">
			                           	<div class="col-sm-6">			                           				         	 
			                                <div class="form-group">
			                                    <label>Customer Name : <span class="text-danger">*</span> </label>
			                                    <div>
			                                       <input type="text" class="form-control" required="required"
			                                           placeholder="Enter Customer Name"   name="customer_name"/>
			                                    </div>
			                                </div>	
			                                
			                                <div class="form-group">
			                                    <label>Customer email : <span class="text-danger">*</span> </label>
			                                    <div>
			                                       <input type="email" class="form-control" required="required"
			                                           placeholder="Enter Customer Email"    name="customer_email"/>
			                                    </div>
			                                </div>
			                                
			                                <div class="form-group">
                                                <label>Quotation Date <span class="text-danger"></span> </label>
                                                <div>
                                                    <div class="input-group">
                                                        <input type="text" name="quotation_date" class="form-control date-picker" placeholder="yyyy-mm-dd" id="id-date-picker-1" data-date-format="yyyy-mm-dd">
                                                        <div class="input-group-append">
                                                            <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>			                                
			                                
			                                <div class="form-group">
			                                    <label>Site Address<span class="text-danger">*</span> </label>
			                                    <div>
			                                       <input type="text" class="form-control" 
			                                         required="required"   id="site_address"  name="site_address"/>
			                                    </div>
			                                </div>	
			                                
			                                         
					                        <div class="form-group">
			                                    <label>Marketing person <span class="text-danger">*</span></label>
			                                    <sql:query var="marketing" dataSource="jdbc/rmc">
			                                    	select * from marketing_person where mp_status='active' order by mp_name asc 
			                                    </sql:query>
												<select id="marketing"  name="mp_id" required="required"   class="select2"  data-placeholder="Choose Marketing Person">
													<option value="">&nbsp;</option>
													<c:forEach var="marketing" items="${marketing.rows}">
													<option value="${marketing.mp_id}">${marketing.mp_name}</option>
													</c:forEach>
												</select>
			                                </div>	
			                                
			                                		                                			                                                                       		                                
			                            </div>			                            			                            
			                            
			                            <div class="col-sm-6">		
			                            	                          			                            		
			                            	<div class="form-group">
			                                    <label>Customer Phone : <span class="text-danger">*</span> </label>
			                                    <div>
			                                       <input type="text" class="form-control" required="required"
			                                           placeholder="Enter Customer Phone"   name="customer_phone"/>
			                                    </div>
			                                </div>			                           
			                                
			                                <div class="form-group">
			                                    <label>Customer GSTIN : <span class="text-danger">*</span> </label>
			                                    <div>
			                                       <input type="text" class="form-control"
			                                           placeholder="Enter Customer GSTN"  name="customer_gstin"/>
			                                    </div>
			                                </div>			                           
			                                
			                                <div class="form-group">
			                                    <label>Pump Charge : </label>
			                                    <div>
			                                       <input type="number" class="form-control" 
			                                           placeholder="Enter Pump Charge"   name="pump_charge"/>
			                                    </div>
			                                </div>
			                                
			                                <div class="form-group">
			                                    <label>Pump Quantity : </label>
			                                    <div>
			                                       <input type="number" class="form-control" 
			                                           placeholder="Enter Pump Quantity"   name="pump_quantity"/>
			                                    </div>
			                                </div>	
			                                
			                                <div class="form-group">
			                                    <label>Payment Terms: </label>
			                                    <div>
														<textarea class="form-control" name="comment" required="required"></textarea>
			                                    </div>
			                                </div>
			                                
			                                		                                		                                
			                             </div>
			                             
			                             <div class="col-sm-12" id="clicked">
		                                	<table class="table table-bordered" id="Table1">
		                                		<thead>
		                                			<tr>
			                                			<th class="text-center">Grade Name</th>
			                                			<th class="text-center">Quantity</th>
			                                			<th class="text-center">Cost/M<sup>3</sup> (OPC)</th>
			                                			<th class="text-center">Cost/M<sup>3</sup> (OPC + GGBS)</th>
			                                			<th class="text-center" style="width: 3%;">
			                                				<span class="text-success BtnPlus">
			                                					<i class="fa fa-plus"></i>
			                                				</span>
			                                			</th>
			                                		</tr>
		                                		</thead>
		                                		<tbody>
		                                			<tr>
		                                				<td>
															<sql:query var="grade" dataSource="jdbc/rmc">
						                                    	select * from product
						                                    </sql:query>
															<select id="product_id" required="required"  name="grade_name"   class="select2"  data-placeholder="Choose Grade">
																<option value="">&nbsp;</option>
																<c:forEach var="grade" items="${grade.rows}">
																<option value="${grade.product_name}">${grade.product_name}</option>
																</c:forEach>
															</select>		                                				
		                                				</td>
		                                				<td>
	                                      					 <input type="text" class="form-control"  pattern="[^'&quot;:]*$"   required="required"  id="quantity" name="quantity" placeholder="Enter quantity"/>
	                                					</td>
		                                				<td>
		                                					<input type="text" class="form-control" pattern="[^'&quot;:]*$"  required="required" placeholder="Enter Grade Price"   name="grade_price"/>
		                                				</td>
		                                				<td>
		                                					<input type="text" class="form-control" pattern="[^'&quot;:]*$"  required="required" placeholder="Enter Grade Price"   name="ggbs_price"/>
		                                				</td>
		                                				<td></td>
		                                				
		                                			</tr>
		                                		</tbody>
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
		                
                	</c:otherwise>
                </c:choose>
                <!-- end row -->

            </div> <!-- end container -->
        </div>
        
<!--         end wrapper -->
		<sql:query var="pro" dataSource="jdbc/rmc">
			select * from product
		</sql:query>
		<c:set var="name">
			<select   class="select2 col-xs-12" name="grade_name">'+
				<c:forEach items="${pro.rows}" begin="0" var="pro">
					'<option value="${pro.product_name}">${pro.product_name}</option>'+
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
									'<input type="text" class="form-control"  pattern="[^\'&quot;:]*$"   required="required"  id="quantity" name="quantity" placeholder="Enter quantity"/>'+
								'</td>'+
									'<td>'+
										'<input type="text" class="form-control"  pattern="[^\'&quot;:]*$"  required="required" placeholder="Enter Grade Price"   name="grade_price"/>'+
									'</td>'+
									'<td>'+
										'<input type="text" class="form-control"  pattern="[^\'&quot;:]*$"  required="required" placeholder="Enter Grade Price"   name="ggbs_price"/>'+
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