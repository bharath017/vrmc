<!DOCTYPE html>
<%@ include file="Session.jsp" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<html>
    
<!-- Mirrored from coderthemes.com/highdmin/horizontal/form-validation.html by HTTrack Website Copier/3.x [XR&CO'2014], Sun, 18 Mar 2018 15:57:25 GMT -->
<head>
        <meta charset="utf-8" />
        <title>GST Setting</title>
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
                                    <li class="breadcrumb-item"><a href="#">Other</a></li>
                                    <li class="breadcrumb-item"><a href="#">General Settings</a></li>
                                    <li class="breadcrumb-item"><a href="#">GST Settings</a></li>
                                </ol>
                            </div>
                          
                            <h4 class="page-title">GST Setting</h4>
                            <p class="text-danger"></p>
                       
                            	
                        </div>
                    </div>
                </div>
                
                <!-- Get GST details here -->
                	<sql:query var="gst" dataSource="jdbc/rmc">
                		select * from gst_setting
                	</sql:query>
                	<c:forEach items="${gst.rows}" var="gst">
                		<c:set value="${gst}" var="rs"/>
                	</c:forEach>
                <!-- End of gst details here -->
              	<div class="row">
              		<h4 class="text-success">${result}</h4>
              		<%session.removeAttribute("result"); %>
                    <div class="col-sm-12">
                    	<form class="" action="SettingController?action=changeGSTSetting" method="post">
	                        <div class="card-box row col-sm-12">
	                        	<div class="col-sm-12 text-center">
	                        		<h2 style="color: #1f6b75;">GST Setting </h2>
	                        	</div> 	
	                        	<div class="col-sm-3">
	                        		
	                        	</div>
	                           	<div class="col-sm-6">
	                               	<div class="form-group">
	                                    <label>CGST <span class="text-danger">*</span></label>
	                                    <input type="number" class="form-control" required
	                                          pattern="[^'&quot;:]*$" value="${rs.cgst}"  placeholder="Enter CGST" id="cgst" name="cgst"/>
	                                </div>
	                                <div class="form-group">
	                                    <label>SGST <span class="text-danger">*</span></label>
	                                    <input type="number" class="form-control" required
	                                          pattern="[^'&quot;:]*$" value="${rs.sgst}"  placeholder="Enter SGST" id="sgst" name="sgst"/>
	                                </div>
	                                <div class="form-group">
	                                    <label>IGST <span class="text-danger">*</span></label>
	                                    <input type="number" class="form-control" required
	                                          pattern="[^'&quot;:]*$" value="${rs.igst}"  placeholder="Enter IGST" id="igst" name="igst"/>
	                                </div>
	                                <div class="form-group">
	                                    <div>
	                                        <button type="submit" class="btn btn-custom waves-effect waves-light">
	                                            Save
	                                        </button>
	                                        <a href="GradeList.jsp" class="btn btn-light waves-effect m-l-5">
	                                            Cancel
	                                        </a>
	                                    </div>
	                                </div>
	                             </div>
                        	</div>
                        </form>
                    </div>
                </div>
                
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