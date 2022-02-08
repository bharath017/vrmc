<!DOCTYPE html>
<%@ include file="Session.jsp" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<html>
    
<!-- Mirrored from coderthemes.com/highdmin/horizontal/form-validation.html by HTTrack Website Copier/3.x [XR&CO'2014], Sun, 18 Mar 2018 15:57:25 GMT -->
<head>
        <meta charset="utf-8" />
        <title>Moisture Setting</title>
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
                                    <li class="breadcrumb-item"><a href="#">Qc</a></li>
                                    <li class="breadcrumb-item"><a href="#">Moisture Setting</a></li>
                                    <li class="breadcrumb-item"><a href="#">Moisture Correction</a></li>
                                </ol>
                            </div>
                          
                            <h4 class="page-title">Moisture Correction</h4>
                            <p class="text-danger"></p>
                       
                            	
                        </div>
                    </div>
                </div>
                
                <div class="row filter-row">
                <div class="col-sm-2 col-xs-6 form-group">
                    <label>Plant <span class="text-danger">*</span></label>
                     <sql:query var="plant" dataSource="jdbc/rmc">
                     	select * from plant where plant_id like if(?=0,'%%',?)
                     	<sql:param value="${bean.plant_id}"/>
                     	<sql:param value="${bean.plant_id}"/>
                     </sql:query>
						<select id="plant_id"  name="plant_id" required="required"   class="select2"  data-placeholder="Choose Plant">
					<option value="" selected>Choose Plant</option>
					<c:forEach var="plant" items="${plant.rows}">
					<option value="${plant.plant_id}">${plant.plant_name}</option>
					</c:forEach>
				</select>
				</div>
	           </div>
              	<div class="row">
              		<h4 class="text-success">${result}</h4>
              		<%session.removeAttribute("result"); %>
                    <div class="col-sm-12">
                    	<form class="" action="SettingController?action=insertMoistureSetting" method="post">
	                        <div class="card-box row col-sm-12">
	                        	<div class="col-sm-12 text-center">
	                        		<h2 style="color: #1f6b75;">Moisture &amp; Water Absorption Setting </h2>
	                        	</div> 	
	                        	<div class="col-sm-3">
	                        	</div>
	                           	<div class="col-sm-6">
	                               	<div class="form-group">
	                                    <label>AGGREGATE1 MOISTURE<span class="text-danger">*</span></label>
	                                    <input type="number" class="form-control" required
	                                          pattern="[^'&quot;:]*$" step="0.01" value="${moi.aggr1_moi}"  placeholder="AGGREGATE1 MOISTURE" id="aggr1_moi" name="aggr1_moi"/>
	                                </div>
	                                <div class="form-group">
	                                    <label>AGGREGATE2 MOISTURE <span class="text-danger">*</span></label>
	                                    <input type="number" class="form-control" required
	                                          pattern="[^'&quot;:]*$" step="0.01" value="${moi.aggr2_moi}"  placeholder="AGGREGATE2 MOISTURE" id="aggr2_moi" name="aggr2_moi"/>
	                                </div>
	                                <div class="form-group">
	                                    <label>AGGREGATE3 MOISTURE <span class="text-danger">*</span></label>
	                                    <input type="hidden" name="plant_id" id="update_plant_id"/>
	                                    <input type="number" class="form-control" required
	                                          pattern="[^'&quot;:]*$" step="0.01" value="${moi.aggr3_moi}"  placeholder="AGGREGATE3 MOISTURE" id="aggr3_moi" name="aggr3_moi"/>
	                                </div>
	                                
	                                <div class="form-group">
	                                    <label>AGGREGATE4 MOISTURE <span class="text-danger">*</span></label>
	                                    <input type="number" class="form-control" required
	                                          pattern="[^'&quot;:]*$" step="0.01" value="${moi.aggr4_moi}"  placeholder="AGGREGATE4 MOISTURE" id="aggr4_moi" name="aggr4_moi"/>
	                                </div>
	                                
	                                <div class="form-group">
	                                    <label>AGGREGATE1 ABS<span class="text-danger">*</span></label>
	                                    <input type="number" class="form-control" required
	                                          pattern="[^'&quot;:]*$" step="0.01" value="${moi.aggr1_abs}"  placeholder="AGGREGATE1 WATER ABSORPTION" id="aggr1_abs" name="aggr1_abs"/>
	                                </div>
	                                <div class="form-group">
	                                    <label>AGGREGATE2 ABS <span class="text-danger">*</span></label>
	                                    <input type="number" class="form-control" required
	                                          pattern="[^'&quot;:]*$" step="0.01" value="${moi.aggr2_abs}"  placeholder="AGGREGATE2 WATER ABSORPTION" id="aggr2_abs" name="aggr2_abs"/>
	                                </div>
	                                <div class="form-group">
	                                    <label>AGGREGATE3 ABS <span class="text-danger">*</span></label>
	                                    <input type="number" class="form-control" required
	                                          pattern="[^'&quot;:]*$" step="0.01" value="${moi.aggr3_abs}"  placeholder="AGGREGATE3 WATER ABSORPTION" id="aggr3_abs" name="aggr3_abs"/>
	                                </div>
	                                
	                                <div class="form-group">
	                                    <label>AGGREGATE4 ABS <span class="text-danger">*</span></label>
	                                    <input type="number" class="form-control" required
	                                          pattern="[^'&quot;:]*$" step="0.01" value="${moi.aggr4_abs}"  placeholder="AGGREGATE4 WATER ABSORPTION" id="aggr4_abs" name="aggr4_abs"/>
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
         <script src="picker/js/moment.min.js"></script>
        <script src="js/Moisture.js"></script>
    </body>
</html>