<!DOCTYPE html>
<%@ include file="Session.jsp" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<html>
    
<!-- Mirrored from coderthemes.com/highdmin/horizontal/form-validation.html by HTTrack Website Copier/3.x [XR&CO'2014], Sun, 18 Mar 2018 15:57:25 GMT -->
<head>
        <meta charset="utf-8" />
        <title>Employee Attendance</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
        <meta content="A fully featured admin theme which can be used to build CRM, CMS, etc." name="description" />
        <meta content="Coderthemes" name="author" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <script type="text/javascript" src="angular/angular.min.js"></script>
        <!-- App favicon -->
        <link rel="shortcut icon" href="assets/images/favicon.ico">
		<link rel="stylesheet" href="picker/cs/bootstrap-datepicker3.min.css" />
		<link rel="stylesheet" href="picker/cs/bootstrap-timepicker.min.css" />
		
		
        <!-- DataTables -->
        <link href="plugins/datatables/dataTables.bootstrap4.min.css" rel="stylesheet" type="text/css" />
        <link href="plugins/datatables/buttons.bootstrap4.min.css" rel="stylesheet" type="text/css" />
        <!-- Responsive datatable examples -->
        <link href="plugins/datatables/responsive.bootstrap4.min.css" rel="stylesheet" type="text/css" />

        <!-- Multi Item Selection examples -->
        <link href="plugins/datatables/select.bootstrap4.min.css" rel="stylesheet" type="text/css" />
        <!-- App css -->
        <link href="plugins/custombox/css/custombox.min.css" rel="stylesheet">
        <link href="assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/icons.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/style.css" rel="stylesheet" type="text/css" />
        <link rel="stylesheet" href="assets/css/select2.min.css" />
		<link rel="stylesheet" href="assets/css/render.css">
        <script src="assets/js/modernizr.min.js"></script>
        <link href="assets/jquery-toast/jquery.toast.min.css" rel="stylesheet" type="text/css" />
        <style type="text/css">
        	.error{
        		color: red;
        	}
        	#map {
		        height: 400px;  /* The height is 400 pixels */
		        width: 100%;  /* The width is the width of the web page */
		       }
        </style>
       

    </head>
    <body data-ng-controller="myController">

        <!-- Navigation Bar-->
        	<%@ include file="header.jsp" %>
        <!-- End Navigation Bar-->


	<div class="wrapper">
		<div class="container-fluid">
			<div class="row">
				<div class="col-sm-12">
					<div class="page-title-box">
						<div class="btn-group pull-right">
							<ol class="breadcrumb hide-phone p-0 m-0">
								<li class="breadcrumb-item"><a href="#">Home</a></li>
								<li class="breadcrumb-item"><a href="#">HRM</a></li>
								<li class="breadcrumb-item"><a href="#">Add Attendance</a></li>
										                                       
							</ol>
						</div>
					</div>
				</div>
			</div>
			<div class="row filter-row card-box">
					<div class="col-sm-2 col-xs-6">
                        <div class="form-group form-focus select-focus">
                            <label class="control-label">Business Group  <span class="text-danger">*</span></label>
                            <sql:query var="business" dataSource="jdbc/rmc">
                            	select business_id,group_name
                            	from business_group
                            	where business_id like if(?=0,'%%',?)
                            	<sql:param value="${bean.business_id}"/>
                            	<sql:param value="${bean.business_id}"/>
                            </sql:query>
                            <select class="select2 form-control floating" id="business_id"
                            	    name="business_id">
                                <c:forEach items="${business.rows}" var="business">
                                	<option value="${business.business_id}">${business.group_name}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <div class="col-sm-2 col-xs-6 form-group">
                        <label>Attendance Date <span class="text-danger">*</span> </label>
                        <div>
                            <div class="input-group">
                                <input type="text" name="attendance_date"
                                			class="form-control date-picker attendance_date" 
                                			placeholder="dd/mm/yyyy" id="attendance_date"
                                		    style="background-color: white;"
                                		    data-date-format="dd/mm/yyyy" readonly="readonly"/>
                                <div class="input-group-append">
                                    <span class="input-group-text"><i class="mdi mdi-calendar"></i></span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-1 col-xs-6">
                        <div class="form-group form-focus">
                            <label class="control-label">&nbsp;</label>
                            <a href="#" id="search" class="btn btn-success btn-block"> Search </a>
                        </div>
                    </div>
                </div>
			<div class="row card-box">
				<div class="col-sm-12 text-center">
					<button class="btn btn-custom" id="update_attendance">Update Attendance</button>
					<form action="" id="attendance_form">
						<input type="hidden" name="count" id="count"/>
						<input type="hidden" name="attendance_date" id="attendance_date_result"/>
						<input type="hidden" name="user_id" value="${bean.user_id}" id="user_id"/>
						<table class="table table-bordered table-custom" id="att-table">
							<thead>
								<tr style="background-color: #02c0ce;color:white;">
									<th>S/L No</th>
									<th>Employee ID</th>
									<th>Employee Name</th>
									<th>Mob No</th>
									<th>Attendance Status</th>
									<th>Start Time</th>
									<th>End Time</th>
									<th>Description</th>
								</tr>
							</thead>	
							<tbody>
								
							</tbody>				
						</table>
					</form>
				</div>
			</div>
			
		</div>
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
        <!-- App js -->
        <script src="assets/js/jquery.core.js"></script>
        <script src="assets/js/select2.min.js"></script>
		<script src="picker/js/bootstrap-datepicker.min.js"></script>
		<script src="picker/js/moment.min.js"></script>
		<script src="assets/js/bootstrap-timepicker.min.js"></script>
		<script src="picker/js/bootstrap-datetimepicker.min.js"></script>
		<!-- Required datatable js -->
		<script src="plugins/custombox/js/custombox.min.js"></script>
        <script type="text/javascript" src="validation/jquery.validate.js"></script>
        <script type="text/javascript" src="js/hrm/Attendance.js"></script>
        <script src="assets/jquery-toast/jquery.toast.min.js"></script>
</body>
</html>