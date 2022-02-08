<!DOCTYPE html>
<%@ include file="Session.jsp" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<html>
<head>
        <meta charset="utf-8" />
        <title>Add Marketing Person</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
        <meta content="A fully featured admin theme which can be used to build CRM, CMS, etc." name="description" />
        <meta content="Coderthemes" name="author" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />

        <!-- App favicon -->
        <link rel="shortcut icon" href="assets/images/favicon.ico">

        <!-- App css -->
		<link rel="stylesheet" href="picker/cs/bootstrap-datepicker3.min.css" />
		<link rel="stylesheet" href="picker/cs/bootstrap-timepicker.min.css" />
        <!-- App css -->
        <link href="assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/icons.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/style.css" rel="stylesheet" type="text/css" />
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
                                    <li class="breadcrumb-item"><a href="#">Marketing Person</a></li>
                                    <li class="breadcrumb-item"><a href="#">Add Marketing Person</a></li>
                                </ol>
                            </div>
                           <c:choose>
                           		<c:when test="${param.action=='update'}">
                           			 <h4 class="page-title">Update Marketing Person</h4>
                           		</c:when>
                           		<c:otherwise>
                           			 <h4 class="page-title">Add Marketing Person</h4>
                           		</c:otherwise>
                           </c:choose>
                        </div>
                    </div>
                </div>
                <!-- end page title end breadcrumb -->
                 <div class="row">
                    <div class="col-sm-4">
                        <a href="MarketingPersonList.jsp" class="btn btn-custom waves-effect waves-light mb-4"  data-overlayColor="#36404a"><i class="mdi mdi-plus"></i>Marketing Person List</a>
                    </div><!-- end col -->
                </div>
                <!-- end row -->
                
                
                <c:choose>
                	<c:when test="${param.action=='update'}">
                		<sql:query var="market" dataSource="jdbc/rmc">
                			select * from marketing_person where mp_id=?
                			<sql:param value="${param.mp_id}"/>
                		</sql:query> 
                		<c:forEach items="${market.rows}" var="market">
                			<c:set value="${market}" var="rs"/>
                		</c:forEach>
                		<div class="row">
		                    <div class="col-sm-12">
		                    	<form class="" action="MarketingPersonController?action=UpdateMaketingPerson" method="post">
			                        <div class="card-box row col-sm-12">
			                           	<div class="col-sm-6">
			                               	<div class="form-group">
			                                    <label>Marketing Person Name<span class="text-danger">*</span></label>
			                                    <input type="hidden" name="mp_id" id="mp_id" value="${rs.mp_id}">
			                                    <input type="text" class="form-control" required
			                                          pattern="[^'&quot;:]*$" value="${rs.mp_name}" placeholder="Enter Marketing Person Name"  name="mp_name"/>
			                                </div>
			                                
			                                <div class="form-group">
			                                    <label>Marketing Person Phone<span class="text-danger">*</span> </label>
			                                    <input type="text" class="form-control" required
			                                         pattern="[^'&quot;:]*$" value="${rs.mp_phone}"  placeholder="Enter Marketing Person Phone Number"  maxlength="10"   name="mp_phone"/>
			                                </div>
			                                
			                                <div class="form-group">
			                                    <label>Marketing Person Email : </label>
			                                    <div>
			                                        <input type="email" class="form-control" 
			                                             pattern="[^'&quot;:]*$"  parsley-type="email" value="${rs.mp_email}" placeholder="Ex : example@example.com" name="mp_email"/>
			                                    </div>
			                                </div>
			                                
			                                <div class="form-group">
			                                    <label>Marketing Person Address<span class="text-danger">*</span> </label>
			                                    <textarea  class="form-control" required
			                                         pattern="[^'&quot;:]*$"    name="mp_address">${rs.mp_address}</textarea>
			                                </div>
			                                
			                                
			                            </div>
			                            <div class="col-sm-6">
			                               	
			                               	
			                               	 <div class="form-group">
			                                    <label>Plant <span class="text-danger">*</span></label>
			                                    <sql:query var="plant" dataSource="jdbc/rmc">
			                                    	select * from plant
			                                    </sql:query>
												<select id="plant_id"  name="plant_id" required="required"   class="select2"  data-placeholder="Choose Plant">
													<c:forEach var="plant" items="${plant.rows}">
													<option value="${plant.plant_id}" ${(rs.plant_id==plant.plant_id)?'selected':'' }>${plant.plant_name}</option>
													</c:forEach>
												</select>
			                                </div>
			                            
			                               	<div class="form-group">
			                               	<label>Designation</label>
			                               	<select class="select2" name="mp_type" id="mp_type" data-placeholder="Choose Designation">
			                               		<option value=""></option>
			                               		<!-- changing these option values will affect the login for marketing person -->
			                               		<option ${(rs.mp_type=='marketing_head')?'selected':''} value="marketing_head">BDM</option>
			                               		<option ${(rs.mp_type=='sales_person')?'selected':''} Value="sales_person">Sales Person</option>
			                               		<!--  -->
			                               	</select>
			                               	</div>
			                                
			                          <div class="form-group  ${(rs.mp_type=='sales_person')?'':'sales'}">
	                                    <label>Marketing Head <span class="text-danger">*</span></label>
	                                    <sql:query var="vehicle" dataSource="jdbc/rmc">
	                                    	select * from marketing_person where mp_type='marketing_head'
	                                    </sql:query>
										<select id="mp_head"  name="mp_head"   class="select2 ${(rs.mp_type=='sales_person')?'':'sales'}"  data-placeholder="Choose Marketing Head">
											<option value="">&nbsp;</option>
											<c:forEach var="vehicle" items="${vehicle.rows}">
											<option value="${vehicle.mp_id}" ${(rs.mp_head==vehicle.mp_id)?'selected':''}>${vehicle.mp_name}</option>
											</c:forEach>
										</select>
	                                </div>
			                                
			                                  <div class="form-group">
			                                    <label>Login Id <span class="text-danger">*</span>  </label>
			                                    <div>
			                                       <input type="text" class="form-control" 
			                                         pattern="[^'&quot;:]*$"  placeholder="Enter Marketing Person Login Id"  value="${rs.mp_login_id}"  name="mp_login_id"/>
			                                    </div>
			                                </div>
			                                
			                                <div class="form-group">
			                                    <label>Marketing User Password : </label>
			                                    <div>
			                                       <input type="text" class="form-control" 
			                                         pattern="[^'&quot;:]*$"  placeholder="Enter Marketing User Password"  value="${rs.mp_password}"   name="mp_password"/>
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
		                    	<form class="" action="MarketingPersonController?action=InsertMarketingPerson" method="post">
			                        <div class="card-box row col-sm-12">
			                           	<div class="col-sm-6">
			                               	<div class="form-group">
			                                    <label>Marketing Person Name<span class="text-danger">*</span></label>
			                                    <input type="text" class="form-control" required
			                                          pattern="[^'&quot;:]*$" placeholder="Enter Marketing Person Name"  name="mp_name"/>
			                                </div>
			                                
			                                <div class="form-group">
			                                    <label>Marketing Person Phone<span class="text-danger">*</span> </label>
			                                    <input type="text" class="form-control" required
			                                         pattern="[^'&quot;:]*$"  placeholder="Enter Marketing Person Phone Number"  maxlength="10"   name="mp_phone"/>
			                                </div>
			                                
			                                <div class="form-group">
			                                    <label>Marketing Person Email : </label>
			                                    <div>
			                                        <input type="email" class="form-control" 
			                                             pattern="[^'&quot;:]*$"  parsley-type="email" placeholder="Ex : example@example.com" name="mp_email"/>
			                                    </div>
			                                </div>
			                                
			                                <div class="form-group">
			                                    <label>Marketing Person Address<span class="text-danger">*</span> </label>
			                                    <textarea  class="form-control" required
			                                         pattern="[^'&quot;:]*$"  placeholder="Enter Marketing Person Address"     name="mp_address"/></textarea>
			                                </div>
			                            </div>
			                            <div class="col-sm-6">
					                         <div class="form-group">
			                                    <label>Plant <span class="text-danger">*</span></label>
			                                    <sql:query var="plant" dataSource="jdbc/rmc">
			                                    	select * from plant
			                                    </sql:query>
												<select id="plant_id"  name="plant_id" required="required"   class="select2"  data-placeholder="Choose Plant">
													<c:forEach var="plant" items="${plant.rows}">
													<option value="${plant.plant_id}">${plant.plant_name}</option>
													</c:forEach>
												</select>
			                                </div>
			                            
			                               	<div class="form-group">
			                               	<label>Designation</label>
			                               	<select class="select2" name="mp_type" id="mp_type" data-placeholder="Choose Designation">
			                               		<option value=""></option>
			                               		<!-- changing these option values will affect the login for marketing person -->
			                               		<option value="marketing_head">BDM</option>
			                               		<option Value="sales_person">Sales Person</option>
			                               		<!--  -->
			                               	</select>
			                               	</div>
			                                
			                          <div class="form-group sales">
	                                    <label>Marketing Head <span class="text-danger">*</span></label>
	                                    <sql:query var="vehicle" dataSource="jdbc/rmc">
	                                    	select * from marketing_person where mp_type='marketing_head'
	                                    </sql:query>
										<select id="mp_head"  name="mp_head"   class="select2 sales"  data-placeholder="Choose Marketing Head">
											<option value="">&nbsp;</option>
											<c:forEach var="vehicle" items="${vehicle.rows}">
											<option value="${vehicle.mp_id}">${vehicle.mp_name}</option>
											</c:forEach>
										</select>
	                                </div>
			                                
			                                  <div class="form-group">
			                                    <label>Login Id <span class="text-danger">*</span>  </label>
			                                    <div>
			                                       <input type="text" class="form-control" 
			                                         pattern="[^'&quot;:]*$"  placeholder="Enter Marketing Person Login Id"   name="mp_login_id"/>
			                                    </div>
			                                </div>
			                                
			                                <div class="form-group">
			                                    <label>Marketing User Password : </label>
			                                    <div>
			                                       <input type="text" class="form-control" 
			                                         pattern="[^'&quot;:]*$"  placeholder="Enter Marketing User Password"   name="mp_password"/>
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
        <script src="picker/js/moment.min.js"></script>
		
        <script type="text/javascript">
            $(document).ready(function() {
                $('form').parsley();
                
                $('.select2').css('width','100%').select2({allowClear:true})
				.on('change', function(){
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
		<script>
		$(document).ready(function() {
			$('#mp_type').on("change",function(){
				var mp_type=$('#mp_type').val();
				if(mp_type=='sales_person'){
					$('.sales').show();
					$('.sales').prop('disabled',false);
					$('.sales').prop('required',true);
				}else{
					$('.sales').hide();
					$('.sales').prop('disabled',true);
				}
			})
			$('.sales').hide();
			$('.sales').prop('disabled',true);
			var mp_type=$('#mp_type').val();
			if(mp_type=='sales_person'){
				$('.sales').show();
				$('.sales').prop('disabled',false);
				$('.sales').prop('required',true);
			}
			
		});
		</script>

    </body>
</html>