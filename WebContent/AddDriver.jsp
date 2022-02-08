<!DOCTYPE html>
<%@ include file="Session.jsp" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<html>
    
<!-- Mirrored from coderthemes.com/highdmin/horizontal/form-validation.html by HTTrack Website Copier/3.x [XR&CO'2014], Sun, 18 Mar 2018 15:57:25 GMT -->
<head>
        <meta charset="utf-8" />
        <title>Add  Driver - ${initParam.company_name}</title>
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
                                    <li class="breadcrumb-item"><a href="#">Driver</a></li>
                                </ol>
                            </div>
                            <c:choose>
                            	<c:when test="${param.action=='update'}">
                            		<h4 class="page-title">Update Driver</h4>
                            	</c:when>
                            	<c:otherwise>
                            		<h4 class="page-title">Add Driver</h4>
                            	</c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
                <!-- end page title end breadcrumb -->
                 <div class="row">
                    <div class="col-sm-4">
                        <a href="DriverList.jsp" class="btn btn-custom waves-effect waves-light mb-4"  data-overlayColor="#36404a"><i class="mdi mdi-plus"></i>Driver List</a>
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
			                        		<h2 style="color: #1f6b75;">Add Driver Information</h2>
			                        	</div>
			                        	<div class="col-sm-3">
			                        		
			                        	</div>
			                           	<div class="col-sm-6">
			                               	<div class="form-group">
			                                    <label>Driver Name <span class="text-danger">*</span> </label>
			                                    <input type="hidden" value="${res.driver_id}" name="driver_id" id="driver_id"> 
			                                    <input type="text" class="form-control" required
			                                          pattern="[^'&quot;:]*$" value="${res.driver_name}" placeholder="Enter Driver Name.." id="driver_name" name="driver_name"/>
			                                </div>
			                                
			                                <div class="form-group">
			                                    <label>Driver Phone : </label>
			                                    <input type="text" class="form-control" 
			                                         pattern="[^'&quot;:]*$" value="${res.driver_phone}"  placeholder="Enter Driver Phone."  maxlength="10" id="driver_phone" name="driver_phone"/>
			                                </div>
			                                
			                                <div class="form-group">
			                                    <label>Licence No : </label>
			                                    <input type="text" class="form-control" 
			                                         pattern="[^'&quot;:]*$"  placeholder="Enter Licence No" value="${res.licence_no}"  id="licence_no" name="licence_no"/>
			                                </div>
			                                
			                                <div class="form-group">
			                                    <label>Licence Validity : </label>
			                                    <input type="date" class="form-control" 
			                                         pattern="[^'&quot;:]*$"   id="licence_valid_till" value="${res.licence_valid_till}" name="licence_valid_till"/>
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
			                        		<h2 style="color: #1f6b75;">Add Driver Information</h2>
			                        	</div>
			                        	<div class="col-sm-3">
			                        		
			                        	</div>
			                           	<div class="col-sm-6">
			                               	<div class="form-group">
			                                    <label>Driver Name <span class="text-danger">*</span> </label>
			                                    <input type="text" class="form-control" required
			                                          pattern="[^'&quot;:]*$" placeholder="Enter Driver Name.." id="driver_name" name="driver_name"/>
			                                </div>
			                                
			                                <div class="form-group">
			                                    <label>Driver Phone : </label>
			                                    <input type="text" class="form-control" 
			                                         pattern="[^'&quot;:]*$"  placeholder="Enter Driver Phone."  maxlength="10" id="driver_phone" name="driver_phone"/>
			                                </div>
			                                
			                                <div class="form-group">
			                                    <label>Licence No : </label>
			                                    <input type="text" class="form-control" 
			                                         pattern="[^'&quot;:]*$"  placeholder="Enter Licence No"  id="licence_no" name="licence_no"/>
			                                </div>
			                                
			                                <div class="form-group">
			                                    <label>Licence Validity : </label>
			                                    <input type="date" class="form-control" 
			                                         pattern="[^'&quot;:]*$"   id="licence_valid_till" name="licence_valid_till"/>
			                                </div>
			                                
			                               
			
			                                <div class="form-group">
			                                    <div>
			                                        <button type="submit" class="btn btn-custom waves-effect waves-light">
			                                            Save
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