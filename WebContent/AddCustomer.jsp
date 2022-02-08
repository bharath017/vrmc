<!DOCTYPE html>
<%@ include file="Session.jsp" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<html>
<head>
        <meta charset="utf-8" />
        <title>New Customer</title>
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
                                    <li class="breadcrumb-item"><a href="#">Other</a></li>
                                    <li class="breadcrumb-item"><a href="#">Add Plant</a></li>
                                </ol>
                            </div>
                            <h4 class="page-title">Add Customer</h4>
                        </div>
                    </div>
                </div>
                <!-- end page title end breadcrumb -->
                 <div class="row">
                    <div class="col-sm-4">
                        <a href="CustomerList.jsp" class="btn btn-custom waves-effect waves-light mb-4"  data-overlayColor="#36404a"><i class="mdi mdi-plus"></i>Customer List</a>
                    </div><!-- end col -->
                </div>
                <!-- end row -->
                
                
                <c:choose>
                	<c:when test="${param.action=='update'}">
                		<sql:query var="customer" dataSource="jdbc/rmc">
                			select * from customer where customer_id=?
                			<sql:param value="${param.customer_id}"/>
                		</sql:query> 
                		<c:forEach items="${customer.rows}" var="customer">
                			<c:set value="${customer}" var="rs"/>
                		</c:forEach>
                		<div class="row">
		                    <div class="col-sm-12">
		                    	<form class="" action="CustomerController?action=UpdateCustomer" method="post">
			                        <div class="card-box row col-sm-12">
			                           	<div class="col-sm-6">
			                               	<div class="form-group">
			                                    <label>Customer Name <span class="text-danger">*</span></label>
			                                    <input type="hidden" name="customer_id" value="${rs.customer_id}" id="customer_id">
			                                    <input type="text" class="form-control" required
			                                          pattern="[^'&quot;:]*$" placeholder="Enter Customer Name" value="${rs.customer_name}"  name="customer_name"/>
			                                </div>
			                                
			                                <div class="form-group">
			                                    <label>Customer Phone <span class="text-danger">*</span> </label>
			                                    <input type="text" class="form-control" required
			                                         pattern="[^'&quot;:]*$" maxlength="10" placeholder="Enter Customer Phone"  value="${rs.customer_phone}"  name="customer_phone"/>
			                                </div>
			                                
			                                <div class="form-group">
			                                    <label>Customer Email : </label>
			                                    <div>
			                                        <input type="email" class="form-control" 
			                                             pattern="[^'&quot;:]*$"  parsley-type="email" value="${rs.customer_email}" placeholder="Ex : example@example.com" name="customer_email"/>
			                                    </div>
			                                </div>
			                                
			                                <div class="form-group">
			                                    <label>Business Group <span class="text-danger">*</span></label>
			                                    <div>
			                                    	<sql:query var="group" dataSource="jdbc/rmc">
			                                    		select business_id,group_name
			                                    		from business_group
			                                    	</sql:query>
													<select class="form-control" id="business_id" name="business_id">
														<c:forEach items="${group.rows}" var="group">
															<option value="${group.business_id}"
																	 ${(group.business_id==rs.business_id)?'selected':''}>${group.group_name}</option>
														</c:forEach>
													</select>
			                                    </div>
			                                </div>
			                                
			                                 <div class="form-group">
			                                	 <label>Opening Balance <span class="text-danger">*</span> </label>
			                                    <div>
			                                       <input type="text" class="form-control" 
			                                         pattern="[^'&quot;:]*$"  placeholder="Enter Opening Balance" required="required"
			                                         name="opening_balance" id="opening_balance" value="${rs.opening_balance}"/>
			                                    </div>
			                                </div>
			                                
			                                <div class="form-group">
			                                    <label>Plant <span class="text-danger">*</span></label>
			                                    <sql:query var="plant" dataSource="jdbc/rmc">
			                                    	select * from plant where plant_id like if(?=0,'%%',?)
			                                    	<sql:param value="${bean.plant_id}"/>
			                                    	<sql:param value="${bean.plant_id}"/>
			                                    </sql:query>
			                                    <input type="hidden" name="id" value="${rs.id}"/>
												<select id="plant_id"  name="plant_id" required="required"   class="select2"  data-placeholder="Choose Plant">
													<c:forEach var="plant" items="${plant.rows}">
													<option value="${plant.plant_id}" ${(plant.plant_id==rs.plant_id)?'selected':''}>${plant.plant_name}</option>
													</c:forEach>
												</select>
			                                </div>
			                                
			                            </div>
			                            <div class="col-sm-6">
			                               	<div class="form-group">
			                                    <label>Customer GSTIN : </label>
			                                    <div>
			                                       <input type="text" class="form-control" 
			                                         pattern="[^'&quot;:]*$"  placeholder="Enter GSTIN."  value="${rs.customer_gstin}"  name="customer_gstin"/>
			                                    </div>
			                                </div>
			                                
			                                <div class="form-group">
			                                    <label>PAN No : </label>
			                                    <div>
			                                       <input type="text" class="form-control" 
			                                         pattern="[^'&quot;:]*$"  placeholder="Enter Customer PAN No." value="${rs.customer_panno}"   name="customer_panno"/>
			                                    </div>
			                                </div>
			                                
			                                <div class="form-group">
			                                    <label>Customer Address <span class="text-danger">*</span> </label>
			                                    <div>
			                                       <input type="text" class="form-control" 
			                                         pattern="[^'&quot;:]*$"  placeholder="Enter Billing Address" required="required" value="${rs.customer_address}"  name="customer_address"/>
			                                    </div>
			                                </div>
			                                
			                                  <div class="form-group">
			                                    <label>Marketing Person <span class="text-danger">*</span></label>
			                                    <sql:query var="market" dataSource="jdbc/rmc">
			                                    	select * from marketing_person where mp_status='active'  order by mp_name asc
			                                    </sql:query>
												<select id="mp_id"  name="mp_id"    class="select2"  data-placeholder="Choose Marketing Person" required="required">
													<c:forEach var="market" items="${market.rows}">
														<option value="${market.mp_id}" ${(market.mp_id==rs.mp_id)?'selected':''}>${market.mp_name}</option>
													</c:forEach>
												</select>
			                                </div>
			                                
			                                <div class="form-group">
		                                        <label>Last Dispatch Date <span class="text-danger"></span> </label>
		                                        <div>
		                                            <div class="input-group">
		                                                <input type="text" name="last_dispatch_date" value="${rs.last_dispatch_date}" class="form-control date-picker" required="required" placeholder="yyyy-mm-dd" data-date-format="yyyy-mm-dd">
		                                                <div class="input-group-append">
		                                                    <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
		                                                </div>
		                                            </div>
		                                        </div>
		                                   </div>
		                                   
			                             </div>
		                                 <div class="col-sm-12 text-center">
		                                	<div class="form-group">
			                                    <div>
			                                        <button type="submit" class="btn btn-custom waves-effect waves-light">
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
		                    	<form class="" action="CustomerController?action=AddCustomer" method="post">
			                        <div class="card-box row col-sm-12">
			                           	<div class="col-sm-6">
			                           		<div class="row">
			                           			<div class="col-sm-10">
			                           				<div class="form-group">
														<label>Customer GSTIN <span class="text-danger">*</span></label>
														<div>
															<div class="input-group">
																<input type="text" class="form-control" 
					                                         		pattern="[^'&quot;:]*$"  placeholder="Enter GSTIN." 
					                                         		  name="customer_gstin" id="customer_gstin"/>
																<div class="input-group-append" style="cursor: pointer;"  id="validate_gstin_btn">
																	<span class="input-group-text btn btn-info">Validate GSTIN</span>
																</div>
															</div>
															<span class="error" style="color: red;display: none;" id="gstin-length-error">Please enter proper GSTIN</span>
															<span class="error" style="color: red;display: none;" id="invalid-gstin-error">GSTIN Not Found</span>
														</div>
													</div>
			                           			</div>
			                           			<div class="col-sm-2">
			                           				<div class="form-group">
			                           					<label>&nbsp;</label>
			                           					<div class="input-group">
			                           						<img alt="Loader" src="loader/loader.svg" 
			                           						 style="display: none;" id="loader_image"	class="image-reponsive" width="40" height="40">
			                           					</div>
			                           				</div>
			                           			</div>
			                           	</div>
			                           			
			                               	<div class="form-group">
			                                    <label>Customer Name <span class="text-danger">*</span></label>
			                                    <input type="text" class="form-control" required
			                                          pattern="[^'&quot;:]*$" placeholder="Enter Customer Name"  name="customer_name" id="customer_name"/>
			                                </div>
			                                
			                                <div class="form-group">
			                                    <label>Customer Phone <span class="text-danger">*</span> </label>
			                                    <input type="text" class="form-control" required
			                                         pattern="[^'&quot;:]*$"  placeholder="Enter Customer Phone"
			                                         maxlength="10"   name="customer_phone" id="customer_phone"/>
			                                </div>
			                                
			                                <div class="form-group">
			                                    <label>Customer Email : </label>
			                                    <div>
			                                        <input type="email" class="form-control" 
			                                             pattern="[^'&quot;:]*$"  parsley-type="email" placeholder="Ex : example@example.com"
			                                              name="customer_email" id="customer_email"/>
			                                    </div>
			                                </div>
			                                
			                                <div class="form-group">
			                                	 <label>Opening Balance <span class="text-danger">*</span> </label>
			                                    <div>
			                                       <input type="text" class="form-control" 
			                                         pattern="[^'&quot;:]*$"  placeholder="Enter Opening Balance" required="required"
			                                         name="opening_balance" id="opening_balance"/>
			                                    </div>
			                                </div>
			                                
			                                <div class="form-group">
			                                	<label for="plant_id">Plant Id <span class="text-danger">*</span></label>
			                                	<sql:query var="plant" dataSource="jdbc/rmc">
			                                		select plant_id,plant_name
			                                		from plant where plant_id like if(?=0,'%%',?)
			                                		<sql:param value="${bean.plant_id}"/>
			                                		<sql:param value="${bean.plant_id}"/>
			                                	</sql:query>
			                                	<select name="plant_id" id="plant_id" class="form-control">
			                                		<c:forEach items="${plant.rows}" var="plant">
			                                			<option value="${plant.plant_id}">${plant.plant_name}</option>
			                                		</c:forEach>
			                                	</select>
			                                </div>
			                                
			                            </div>
			                            <div class="col-sm-6">
			                                <div class="form-group">
			                                    <label>PAN No : </label>
			                                    <div>
			                                       <input type="text" class="form-control" 
			                                         pattern="[^'&quot;:]*$"  placeholder="Enter Customer PAN No." 
			                                         name="customer_panno" id="customer_panno"/>
			                                    </div>
			                                </div>
			                                
			                                <div class="form-group">
			                                    <label>Customer Address <span class="text-danger">*</span> </label>
			                                    <div>
			                                       <input type="text" class="form-control" 
			                                         pattern="[^'&quot;:]*$"  placeholder="Enter Billing Address" required="required"
			                                         name="customer_address" id="customer_address"/>
			                                    </div>
			                                </div>
			                                
			                                  <div class="form-group">
			                                    <label>Marketing Person <span class="text-danger">*</span></label>
			                                    <sql:query var="market" dataSource="jdbc/rmc">
			                                    	select * from marketing_person where mp_status='active'  order by mp_name asc
			                                    </sql:query>
												<select id="mp_id"  name="mp_id"    class="select2"  data-placeholder="Choose Marketing Person"
													 required="required">
													<option value=""></option>
													<c:forEach var="market" items="${market.rows}">
													<option value="${market.mp_id}">${market.mp_name}</option>
													</c:forEach>
												</select>
			                                </div>
			                                <div class="form-group">
			                                    <label>Business Group <span class="text-danger">*</span></label>
			                                    <div>
			                                    	<sql:query var="group" dataSource="jdbc/rmc">
			                                    		select business_id,group_name
			                                    		from business_group
			                                    		where business_id like if(0=?,'%%',?)
			                                    		<sql:param value="${bean.business_id}"/>
			                                    		<sql:param value="${bean.business_id}"/>
			                                    	</sql:query>
													<select class="form-control" id="business_id" name="business_id">
														<c:forEach items="${group.rows}" var="group">
															<option value="${group.business_id}">${group.group_name}</option>
														</c:forEach>
													</select>
			                                    </div>
			                                </div>
			                                
			                                 <div class="form-group">
		                                        <label>Last Dispatch Date <span class="text-danger"></span> </label>
		                                        <div>
		                                            <div class="input-group">
		                                                <input type="text" name="last_dispatch_date" class="form-control date-picker invoice_date" required="required" placeholder="yyyy-mm-dd" id="id-date-picker-1" data-date-format="yyyy-mm-dd">
		                                                <div class="input-group-append">
		                                                    <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
		                                                </div>
		                                            </div>
		                                        </div>
		                                   </div>
			                                
			                             </div>
			                             <div class="col-sm-12" id="clicked">
		                                	<table class="table table-bordered" id="Table1">
		                                		<thead>
		                                			<tr>
			                                			<th class="text-center">Site Name</th>
			                                			<th class="text-center">Site Address</th>
			                                			<th class="text-center">
			                                				<span class="text-success BtnPlus">
			                                					<i class="fa fa-plus"></i>
			                                				</span>
			                                			</th>
			                                		</tr>
		                                		</thead>
		                                		<tbody>
		                                			<tr>
		                                				<td style="width:30%">
		                                				
		                                					<input type="text" class="form-control" required="required"
			                                         pattern="[^'&quot;:]*$"  placeholder="Enter Site Name"   name="site_name"/>
		                                				</td>
		                                				<td style="width:65%">
		                                					<input type="text" class="form-control" 
			                                         pattern="[^'&quot;:]*$"  required="required" placeholder="Enter Site Address"   name="site_address"/>
		                                				</td>
		                                				<td></td>
		                                			</tr>
		                                		</tbody>
		                                	</table>
		                                </div>
		                                <div class="col-sm-12 text-center">
		                                	<div class="form-group">
			                                    <div>
			                                        <button type="submit" class="btn btn-custom waves-effect waves-light">
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
        <!-- end wrapper -->


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
		<script src="assets/js/bootstrap-timepicker.min.js"></script>
		<script src="picker/js/bootstrap-datetimepicker.min.js"></script>
		
		<script type="text/javascript" src="js/validation-datetime.js"></script>
		<script type="text/javascript" src="validation/jquery.validate.min.js"></script>
		
        <script type="text/javascript">
            $(document).ready(function() {
                $('form').parsley();
                
                $('.select2').css('width','100%').select2({allowClear:true})
				.on('change', function(){
					/* $(this).closest('form').validate().element($(this)); */
				}); 
            });
        </script>
        <script type="text/javascript">
		 $(document).ready(function () {
		    function addRow(){
		        var html = '<tr>'+
								'<td>'+
									'<input type="text" class="form-control" required="required" pattern="[^\'&quot;:]*$"  placeholder="Enter Site Name"   name="site_name"/>'+
								'</td>'+
								'<td>'+
									'<input type="text" class="form-control" required="required"  pattern="[^\'&quot;:]*$"  placeholder="Enter Site Address"   name="site_address"/>'+
								'</td>'+
								'<td>'+
									'<span class="text-danger removebtn"><i class="fa fa-trash"></i></span>'+
								'</td>'+
							'</tr>'
		        $(html).appendTo($("#Table1"))
		    };
		    $("#clicked").on("click", ".BtnPlus", addRow);
		});
		 $('#Table1').on('click', '.removebtn', function(){
			    $(this).closest ('tr').remove ();
		});
		</script>
		
		<script type="text/javascript">
			$('#validate_gstin_btn').on('click',function(){
				$('#loader_image').show();
				var customer_gstin = $('#customer_gstin').val();
				if(customer_gstin.length!=15){
					$('#loader_image').hide();
					$('#gstin-length-error').show();
					$('#invalid-gstin-error').hide();
					return false;
				}else {
					$('#gstin-length-error').hide();
					$('#invalid-gstin-error').hide();
				}
				$.ajax({
					type:'post',
					url:'EWayBillController?action=getGSTINDetails&gstin='+customer_gstin,
					headers:{
						Accept:"application/json;charset=utf-8",
						"Content-Type":"application/json;charset=utf-8"
					},
					success:function(res){
						$('#loader_image').hide();
						var errorCode = res.errorCode;
						if(errorCode!=0){
							$('#invalid-gstin-error').show();
						}else{
							$('#customer_name').val(res.tradeName);
							$('#customer_address').val(res.address1+","+res.address2);
							$('#customer_panno').val(res.panNo);
						}
					},
					error:function(res){
						$('#loader_image').hide();
					}
				});
			});
		</script>
		

    </body>
</html>