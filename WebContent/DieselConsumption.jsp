<!DOCTYPE html>
<%@ include file="Session.jsp" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<html>
    
<!-- Mirrored from coderthemes.com/highdmin/horizontal/form-validation.html by HTTrack Website Copier/3.x [XR&CO'2014], Sun, 18 Mar 2018 15:57:25 GMT -->
<head>
        <meta charset="utf-8" />
        <title>Add  Consumption - ${initParam.company_name}</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
        <meta content="A fully featured admin theme which can be used to build CRM, CMS, etc." name="description" />
        <meta content="Coderthemes" name="author" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />

        <!-- App favicon -->
        <link rel="shortcut icon" href="assets/images/favicon.ico">

        <!-- App css -->
        <link href="assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/icons.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/style.css" rel="stylesheet" type="text/css" />
        <link rel="stylesheet" href="assets/css/select2.min.css" />

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
                                    <li class="breadcrumb-item"><a href="#">Vehicle</a></li>
                                    <li class="breadcrumb-item"><a href="#">Diesel Consumption</a></li>
                                </ol>
                            </div>
                            <c:choose>
                            	<c:when test="${param.action=='update'}">
                            		<h4 class="page-title">Update Driver</h4>
                            	</c:when>
                            	<c:otherwise>
                            		<h4 class="page-title">Add Diesel Consumption</h4>
                            	</c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
                <!-- end page title end breadcrumb -->
                 <div class="row">
                    <div class="col-sm-4">
                        <a href="DriverList.jsp" class="btn btn-custom waves-effect waves-light mb-4"  data-overlayColor="#36404a"><i class="mdi mdi-plus"></i>Consumption List</a>
                    </div><!-- end col -->
                </div>
                <!-- end row -->
                
                <c:choose>
                	<c:when test="${param.action=='update'}">
                		<sql:query var="driver" dataSource="jdbc/rmc">
                			select * from driver where driver_id=?
                			<sql:param value="${param.driver_id}"/>
                		</sql:query> 
                		<c:set var="res"/>
                		<c:forEach items="${driver.rows}" var="driver">
                			<c:set value="${driver}" var="res"/>
                		</c:forEach>
                		<div class="row">
		                    <div class="col-sm-12">
		                    	<form class="" action="DriverController?button=update" method="post">
			                        <div class="card-box row col-sm-12">
			                        	<div class="col-sm-12 text-center">
			                        		<h2 style="color: #1f6b75;">Add Consumption Information</h2>
			                        	</div>
			                        	<div class="col-sm-3">
			                        		
			                        	</div>
			                           	<div class="col-sm-6">
			                          <div class="form-group">
	                                    <label>Vehicle No <span class="text-danger">*</span></label>
	                                    <sql:query var="vehicle" dataSource="jdbc/rmc">
	                                    	select * from vehicle
	                                    </sql:query>
										<select id="vehicle_no"  name="vehicle_no" required="required"  class="select2"  data-placeholder="Choose Vehicle">
											<option value="">&nbsp;</option>
											<c:forEach var="vehicle" items="${vehicle.rows}">
											<option value="${vehicle.vehicle_no}"  ${(vehicle.vehicle_no==vehicle_no)?'selected':''}>${vehicle.vehicle_no}</option>
											</c:forEach>
										</select>
	                                </div>
			                       <div class="form-group">
	                                    <label>Vehicle No <span class="text-danger">*</span></label>
										<select id="month"  name="month" onchange="changeConsumptionDetail();" required="required"  class="select2"  data-placeholder="Choose Vehicle">
											<option value="">&nbsp;</option>
											<option value="1" ${(month==1)?'selected':''}>JAN</option>
											<option value="2" ${(month==2)?'selected':''}>FEB</option>
											<option value="3" ${(month==3)?'selected':''}>MAR</option>
											<option value="4" ${(month==4)?'selected':''}>APR</option>
											<option value="5" ${(month==5)?'selected':''}>MAY</option>
											<option value="6" ${(month==6)?'selected':''}>JUNE</option>
											<option value="7" ${(month==7)?'selected':''}>JULY</option>
											<option value="8" ${(month==8)?'selected':''}>AUG</option>
											<option value="9" ${(month==9)?'selected':''}>SEP</option>
											<option value="10" ${(month==10)?'selected':''}>OCT</option>
											<option value="11" ${(month==11)?'selected':''}>NOV</option>
											<option value="12" ${(month==12)?'selected':''}>DEC</option>
										</select>
	                                </div>
			                                
			                         <div class="form-group">
	                                    <label>YEAR<span class="text-danger">*</span></label>
	                                    <%int count=2018;%>
										<select id="year"  name="year"  required="required"  class="select2"  data-placeholder="Choose Vehicle">
											<option value="">&nbsp;</option>
												<option value="<%=count%>" ${(cn==year)?'selected':''}><%=count%></option>
										</select>
	                                </div>
			                               
			                                <div class="form-group">
			                                    <div>
			                                        <button type="submit" class="btn btn-custom waves-effect waves-light">
			                                            Save
			                                        </button>
			                                        <a href="DriverList.jsp" class="btn btn-light waves-effect m-l-5">
			                                            Cancel
			                                        </a>
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
		                    	<form class="" action="DriverController?button=insert" method="post">
			                        <div class="card-box row col-sm-12">
			                        	<div class="col-sm-12 text-center">
			                        		<h2 style="color: #1f6b75;">Add Consumption Information</h2>
			                        	</div>
			                        	<div class="col-sm-3">
			                        		
			                        	</div>
			                           	<div class="col-sm-6">
			                               	 <div class="form-group">
	                                    <label>Vehicle No <span class="text-danger">*</span></label>
	                                    <sql:query var="vehicle" dataSource="jdbc/rmc">
	                                    	select * from vehicle
	                                    </sql:query>
										<select id="vehicle_no"  name="vehicle_no" required="required"  class="select2"  data-placeholder="Choose Vehicle">
											<option value="">&nbsp;</option>
											<c:forEach var="vehicle" items="${vehicle.rows}">
											<option value="${vehicle.vehicle_no}">${vehicle.vehicle_no}</option>
											</c:forEach>
										</select>
	                                </div>
			                                
			                         <div class="form-group">
	                                    <label>Month <span class="text-danger">*</span></label>
										<select id="month"  name="month" onchange="changeConsumptionDetail();" required="required"  class="select2"  data-placeholder="Choose Vehicle">
											<option value="">&nbsp;</option>
											<option value="1">JAN</option>
											<option value="2" >FEB</option>
											<option value="3">MAR</option>
											<option value="4">APR</option>
											<option value="5">MAY</option>
											<option value="6">JUNE</option>
											<option value="7">JULY</option>
											<option value="8">AUG</option>
											<option value="9">SEP</option>
											<option value="10">OCT</option>
											<option value="11">NOV</option>
											<option value="12">DEC</option>
										</select>
	                                </div>
			                                
			                       <div class="form-group">
	                                    <label>YEAR<span class="text-danger">*</span></label>
	                                    <c:set var="count" value="2018"></c:set>
	                                    
	                                 <%--    <%int count=2018;%> --%>
										<select id="year"  name="year"  required="required"  class="select2"  data-placeholder="Choose Year">
											<option value="">&nbsp;</option>
												<option value="${count}">${count}</option>
										</select>
	                                </div>
			                                <div class="form-group">
			                                    <div>
			                                       <button class="btn btn-primary" data-toggle="modal" data-target="#update-consumption">UPDATE MONTHLY DETAILS</button>
													<button class="btn btn-success" data-toggle="modal" data-target="#insert_consumption">NEW CONSUMPTION</button>
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


<c:if test="${not empty vehicle_no}">
 <div id="update-consumption" class="modal">
				<div class="modal-dialog">
					<div class="modal-content">
						<form class="form-horizontal" action="DieselConsumptionController?button=insert_consumption" name="insert_consumption" id="validation-form" method="post">
							<div id="modal-wizard-container">
								<div class="modal-header" style="background-color: #136A87;height:10%;">
									<h3 style="color:white;">UPDATE OPENING AND CLOSING KM FOR VEHICLE ${vehicle_no}</h3>
								</div>
								<div class="modal-body step-content">
									<div class="form-group">
										<label class="control-label col-xs-12 col-sm-3 no-padding-right" for="password2">OPENING KM :</label>
										<div class="col-xs-12 col-sm-9">
											<div class="clearfix">
												<input type="hidden" id="u_cons_id" name="cons_id">
												<input type="hidden" value="${vehicle_no}" id="u_vehicle_no" name="vehicle_no">
												<input type="hidden" value="${year}" id="u_year" name="year">
												<input type="hidden" id="u_month" value="${month}" name="month">
												<input type="number" name="opening_km"  required="required" step="0.01" pattern="[^'&quot;:]*$"  id="u_opening_km" class="col-xs-12 col-sm-8" />
											</div>
										</div>
									</div>
									<div class="form-group">
										<label class="control-label col-xs-12 col-sm-3 no-padding-right" for="password2">CLOSING KM :</label>
										<div class="col-xs-12 col-sm-9">
											<div class="clearfix">
												<input type="number" name="closing_km"  step="0.01" pattern="[^'&quot;:]*$"  id="u_closing_km" class="col-xs-12 col-sm-8" />
											</div>
										</div>
									</div>
									<div class="form-group">
										<label class="control-label col-xs-12 col-sm-3 no-padding-right" for="password2"> RETURNED QUANTITY :</label>
										<div class="col-xs-12 col-sm-9">
											<div class="clearfix">
												<input type="number" name="returned_quantity"  step="0.01" pattern="[^'&quot;:]*$"  id="u_returned_quantity" class="col-xs-12 col-sm-8" />
											</div>
										</div>
									</div>
								</div>
							</div>

							<div class="modal-footer wizard-actions">
								<button type="reset" class="btn btn-danger btn-sm">
									CLEAR 
									<i class="ace-icon icon-on-right"></i>
								</button>

								<button class="btn btn-success btn-sm" data-last="Finish">
									SAVE CONSUMPTION
									<i class="ace-icon icon-on-right"></i>
								</button>

								<button class="btn btn-danger btn-sm pull-left" data-dismiss="modal">
									<i class="ace-icon fa fa-times"></i>
									Cancel
								</button>
							</div>
						</form>
					</div>
				</div>
			</div><!-- PAGE CONTENT ENDS -->
	</c:if>

<c:if test="${not empty vehicle_no}">
			<!-- MODEL BOX FOR INSERTION OF DATE WISE CONSUMPION DETAIL-->
			<div id="insert_consumption" class="modal">
				<div class="modal-dialog">
					<div class="modal-content">
						<form class="form-horizontal" action="DieselConsumptionController?button=insert_date_wise" name="insert_consumption" id="validation-form" method="post">
							<div id="modal-wizard-container">
								<div class="modal-header" style="background-color: #e08ce2;height:10%;">
									<h3 style="color:white;">INSERT DATE WISE CONSUMPTION FOR VEHICLE NO :  ${vehicle_no}</h3>
								</div>
								<div class="modal-body step-content">
									<div class="form-group">
										<label class="control-label col-xs-12 col-sm-3 no-padding-right" for="password2"> CONSUMPTION QUANTITY <span class="red">*</span></label>
										<div class="col-xs-12 col-sm-9">
											<div class="clearfix">
												<input type="hidden" id="u_cons_id" name="cons_id">
												<input type="hidden" value="${vehicle_no}" id="u_vehicle_no" name="vehicle_no">
												<input type="number" name="quantity"  required="required" step="0.01" pattern="[^'&quot;:]*$"  id="quantity" class="col-xs-12 col-sm-8" />
											</div>
										</div>
									</div>
									
									<div class="form-group">
										<label class="control-label col-xs-12 col-sm-3 no-padding-right" for="email">SCHEDULE DATE<span class="red">*</span></label>
										<div class="col-xs-12 col-sm-6">
											<div class="input-group">
												<input name="date" class="form-control date-picker"  required="required"  id="id-date-picker-1" type="text" data-date-format="yyyy-mm-dd" />
												<span class="input-group-addon">
													<i class="fa fa-calendar bigger-110"></i>
												</span>
											</div>
										</div>
									 </div>
									
									<div class="form-group">
										<label class="control-label col-xs-12 col-sm-3 no-padding-right" for="password">START TIME <span class="red">*</span></label>
										<div class="col-xs-12 col-sm-6">
											<div class="input-group bootstrap-timepicker">
												<input name="time" id="timepicker1" required="required" type="text" class="form-control" />
												<span class="input-group-addon">
													<i class="fa fa-clock-o bigger-110"></i>
												</span>
											</div>
										</div>
									</div> 
								</div>
							</div>

							<div class="modal-footer wizard-actions">
								<button type="reset" class="btn btn-danger btn-sm">
									CLEAR 
									<i class="ace-icon icon-on-right"></i>
								</button>

								<button class="btn btn-success btn-sm" data-last="Finish">
									SAVE CONSUMPTION
									<i class="ace-icon icon-on-right"></i>
								</button>

								<button class="btn btn-danger btn-sm pull-left" data-dismiss="modal">
									<i class="ace-icon fa fa-times"></i>
									Cancel
								</button>
							</div>
						</form>
					</div>
				</div>
			</div><!-- PAGE CONTENT ENDS -->
			<!-- END OF MODEL BOX FOR DATE WISE CONSUMPTION DETAIL'S -->
			</c:if>





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
		
        <script type="text/javascript">
            $(document).ready(function() {
                $('form').parsley();
                
                $('.select2').css('width','100%').select2({allowClear:true})
				.on('change', function(){
				}); 
            });
        </script>

    </body>
</html>